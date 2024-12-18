#Persistent
VolumeBeforeMute := -1

Home::
    SoundGet, currentVolume, Master, Volume
    if (currentVolume = 0)
    {
        if (VolumeBeforeMute != -1)
        {
            SoundSet, %VolumeBeforeMute%, Master, Volume
        }
        else
        {
            SoundSet, 50, Master, Volume
        }
    }
    else
    {
        VolumeBeforeMute := currentVolume
        SoundSet, 0, Master, Volume
    }
    return
