# This file is a part of LegendDSP.jl, licensed under the MIT License (MIT).

"""
    dsp_decay_times(wvfs::AbstractSamples, start::Real, stop::Real)

Get statistics on the logarhithmic of the tail of the `wvfs` in the interval (`start`,`stop`).
# Returns
- `τ`: decay time in µs
"""
function dsp_decay_times(wvfs::ArrayOfRDWaveforms, bl_mean::Tuple, pz_fit::Tuple)
    # get config parameters
    bl_mean_min, bl_mean_max    = bl_mean
    pz_fit_min, pz_fit_max      = pz_fit

    # get baseline mean, std and slope
    bl_stats = signalstats.(wvfs, bl_mean_min, bl_mean_max)

    # substract baseline from waveforms
    wvfs_bl = shift_waveform.(wvfs, -bl_stats.mean)

    # extract decay times
    decay_times = tailstats.(wvfs_bl, pz_fit_min, pz_fit_max)
    
    # return converted to µs vals
    return uconvert.(u"µs", decay_times.τ)
end

function dsp_decay_times(wvfs::ArrayOfRDWaveforms, config::DSPConfig)
    dsp_decay_times(wvfs, config.bl_mean, config.pz_fit)
end
export dsp_decay_times