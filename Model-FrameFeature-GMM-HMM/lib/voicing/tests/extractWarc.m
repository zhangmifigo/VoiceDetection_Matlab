
%clear a, pfft, ses, res, ac, ens, ps, ms, ipaqSGP, ipaqAcorr, msg, msgp, macorr, mens

framesize = 512;
framestep = 256;

a = getAudioStream(warcfile);
%az = (double(a)-32768) ./ 32768;
a = a - 32768;
a = double(a);

a01 = a + (randn(size(a))*0.01)*32768;
a02 = a + (randn(size(a))*0.02)*32768;
a07 = a + (randn(size(a))*0.07)*32768;

[pfft,ses,res,ac,ens,ps,pvs,pvsi,acx,acxi,acn,ceps] = getAudioStatsStream(warcfile);
ipaqSGP = reshape(pfft, 257, size(pfft,1)/257)';
ipaqAcorr = reshape(ac, 256, size(ac,1)/256)';

ipaqCeps = reshape(ceps, 256, size(ceps,1)/256)';

msg = compute_specgram_whole(a, framesize, framestep);
msgp = abs(msg);

mses = specentropy(msgp);

meansg = compute_meanspecgram(msgp, 500);
for i=1:size(msgp,1)
    mres(i) = relspecent2(msgp,meansg,i);
end

msg02 = compute_specgram_whole(a02, framesize, framestep);
msgp02 = abs(msg02);

msg07 = compute_specgram_whole(a07, framesize, framestep);
msgp07 = abs(msg07);


macorr = acorrgram(a, framesize, framestep);
macorr01 = acorrgram(a01, framesize, framestep);
macorr02 = acorrgram(a02, framesize, framestep);
macorr07 = acorrgram(a07, framesize, framestep);

%for i=1:size(msgp,1)
%    mens(i) = (msgp(i,:)*msgp(i,:)');% / size(msgp,2);
%end

frames = mk_frames(a, framesize, framestep);
for i=1:size(frames,1)
    mens(i) = frames(i,:)*frames(i,:)';
end
