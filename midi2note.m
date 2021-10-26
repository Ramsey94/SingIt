%%midinumertonote
function note = midi2note(midi)
    A4 = 440;
    freq=(2^((midi-69)/12))*(A4);
    notenames = { 'C' , 'C#', 'D' , 'D#' , 'E' , 'F' , 'F#', 'G' , 'G#' , 'A' , 'A#' , 'B' };
    centdif = floor( 1200 * log(freq/A4)/log(2) );
    notedif = floor(centdif/100);
    if(mod(centdif,100)>50)
       notedif = notedif + 1;
    end
    error = centdif-notedif*100;
    notenumber = notedif + 9 + 12*4; %count of half tones starting from C0.
    octavenumber = floor((notenumber)/12);
    place = mod(notenumber,12) + 1;
    note = strcat(notenames(place) , num2str(octavenumber));
end