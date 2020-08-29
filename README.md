# Sound-Equalizer-Processing
Note:
This is a graphical interface which is capable of playing music and being able to apply different filters during run-time. 
The user is able to interact with the interface by applying the 3 rudimental filters, being the low-pass, high-pass and band-pass filter. 
To which my aim was to demonstrate how the filter is affecting the music,
aiding to both senses of hearing and sight. This artefact, works by utilizing a Fast Fourier
Transform (FFT) algorithm to analyze the frequencies within a piece of music. These frequencies
are then plotted in the form of a spectrogram, to which the user can witness the bass, the mid
level and the treble of music, fluctuating according to different sounds. The user can is then able
to selected the filter accordingly and witness how the music and frequency bands are
manipulated.

Tutorial
--------------------------------------------------------------------------
Select the song via the initializeVariables() method, in order for this application to work you
must install the Processing Sound library. The user is able to interact with the song via a filter of
choice (or a mix), by selecting the slider component accordingly.
