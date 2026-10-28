Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188990;
	b=qF+WxBP479nDq47dHYpnF5NTpY3eGauSNFklQ/m0vqjCc2AXr9g/Z/4xmzBwBWqyahgT
	 EH2fR9q24NIqUFEn4FPL/vG8rl4E+d8s2hy8TM/PFm9t5rMeLKd0LrJ9Ac4iqChR+25ZC
	 mZu3xMHfpk8Mesuufwk7vQKSRmP8yD5BaW3nBOLuum1e1Np8gUqxcEaP2A6HjLLL4Y6Zn
	 +UA3pBcAUO9iQVSdXgw9bWLmokIlfzhbYZl+j7/Eo5UNPc0yZorjoCR0oISavLysze3LP
	 fj9xXl48tukm5u61StbcGja8X8DR8/sWipRaXfXV/M3j9PPl+nX7B5uSaUBYVpAEJaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188990;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=KlCe0+8s3XTQz062L9ihPU7MN8aurKl8xAB8W7Pm540=;
	b=RH2QBQynY7ugwwUtVnfuDdATmmyY7ltE91VcB2ctiQEnfORGnMFu2yQW3CJYyTm0vRvU
	 ReNSo8kL38VGm05pHJCvsqtbDt0YxBUJU93HOcTw78xIekfYzb1fVfIyM54DkR8qwEyKL
	 feyZLdF5ibgiJGh0RsQ9Key28DfyuQTx1N0YjAThNxeu01HG8HuV+NyQ4D35MfGqoa8iu
	 PeO9O/DzGGz4P0tOppqJVP/YT8MHh4q7weyynjM+1n+S4I+ZzRqFICTXcA1LmJ0qZqGvM
	 4UuNGVuUUewjhfBr85NrXbb77t5rICFo9xpITIOqefYAYRxAc+0p+J08EMRotlByEKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=e97RYiaq;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDEA606A31D
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 12:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDEA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=e97RYiaq
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so419726a12.0
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 05:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188990; x=1793793790;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KlCe0+8s3XTQz062L9ihPU7MN8aurKl8xAB8W7Pm540=;
        b=CKBS8V3syWHGksrC6pPcnZcbKuHOdW9kNb2ZzYQuNnjCUUBQ9pBSUHjp69eFRlUskc
         i8o8erbJmVGWDEpfJvtnXjM/R/f1i9UaUhz6/Z+6p5OQ7tNbVIlLzkDu6XFOArXf1Tm9
         RBto1hajGtx3HgKu/bPVH1DsoFRKjzOx4n47VfMRHvoMupIJyXAW3xVd2kkp/s7eRhRN
         kboilRvkgTf+OgQNcMNK7Awu3CIMgYzCYr9WyUQQlyBTPhpiJgi9eXDzfL/mjwfavDpm
         Qm3qIrCmbIlf6RdIZ64uGnsezbzppjIi3+LAcSade6eshicjyFkJKcNCuuNNtvN2eJYE
         c/pg==
X-Forwarded-Encrypted: i=1; AKwUvBxBVt4OGTsh3wQb3cBP6IAVY6faBOlrH0hiNfR8HfceMwM/DGl8g7IEuTYpk1vH34EG9dkGYVUYh0cygDwG0A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ4EIQpoA540F7GXZgGy17Ww45RHCDe7eMTD7Y/k8lUQ29IioPz
	2fDJSq1yP7neMteRM1Wxw/2um3dSNyrUj2TLf9C7hYbn0hI1MJ9i0679Oc7lA9pQkdTwccwKKMF
	W0ios3qdxFmE3BKSqmX5moz+vwVdk1TODZ+lZCgOikb/KOz0LSxb8GVY205phYYc3fMYK2b8BmW
	p3TnVmFwxS7iLsMOen4uGTsumOwAdEV/JERnTskOoQGQgtMZ4FoOJsIWpsC3hrNxPjelWFgE7O2
	6pZ9OIgntFJvIQzZzI=
X-Gm-Gg: AYBFou3ckBe8nw2N7hR0QLlUrLId6Xc3Ph4wk8qaJfTDhj2ooX0fh6H7TLe5AJfLraf
	PwC8czG1rZLacgMFxG2hTWg616DWlpDj13nv7cuWhIOleAni+dOOEwYA0SyTzhzNdroN5B2z3gv
	OkYyuu35oNk7TvpF+LdZJ5hZyvVFTm/PA+eOojll2wsctiln7ynhZrpdYqKnniGh7aD0fT4IAP4
	Frle+SjvSkgkTW6XtKvSIZlDSSanKoXEvSuaPqVHOHjWHtL64tNm2CSPovqcOcNYfD2ysw+7F7R
	dAiBI27Kep25n59bZcLt+l6E5Q3z4Si1sQTMoWbJGJPs+gv3ZaClY9XCv9gTGT98E6vm/XlspFS
	C5gy/K/zSmB1jEM+6ptZ/ZOrN7CCYsz+KQhBCRy5p0dV1t+O08fwgD0V9cWp3qToSZTxiTgSlNd
	/gwJbbVxAPWNgGwkqysz2Ge57iL/nV6xbQ
X-Received: by 2002:a17:90a:e70e:b0:3ac:38dc:6b9e with SMTP id 98e67ed59e1d1-3ae5810099fmr1539593a91.25.1793188989132;
        Wed, 28 Oct 2026 05:03:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae5a655d30sm1455866a91.7.2026.10.28.05.03.08
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 05:03:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3ab357a21adso4150591fa.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793188987; x=1793793787; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlCe0+8s3XTQz062L9ihPU7MN8aurKl8xAB8W7Pm540=;
        b=e97RYiaq33+8oPC0eeQ7q3GEJrnNiuqzXnxdkMhK577q/gJSHwaywO9WEI+Azl8QCX
         T5yiSJ1F9ewVybEw89Xn/5F5ZawZ4h7Pp34Ur++7Ljywnez1KN40YelU5q2W4OANSkWM
         4nr+dMfXr/pditPP+u5lc9cRHNZd0x7kooC9U=
X-Forwarded-Encrypted: i=1; AKwUvByZjLmFzKdvaOHj2a/H1N4W82Xn0leASGRDlYS4ySeY7AQt2qatf4T2VMsQmOJwun3yw4+aeEcwoSLrZx3oAQ==@lists.linux.dev
X-Received: by 2002:a05:651c:2101:b0:3ab:47e4:9a9c with SMTP id 38308e7fff4ca-3ac9ce3407dmr4767711fa.3.1793188986809;
        Wed, 28 Oct 2026 05:03:06 -0700 (PDT)
X-Received: by 2002:a05:651c:2101:b0:3ab:47e4:9a9c with SMTP id
 38308e7fff4ca-3ac9ce3407dmr4767351fa.3.1793188986322; Wed, 28 Oct 2026
 05:03:06 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin@broadcom.com>
 <CABQX2QMNetg9iYRRsQmeM3+1tnC94ccWM=450wMZL_sUbqAJtA@mail.gmail.com> <20261028060042.GCauGPirK7ePNeTGF0@fat_crate.local>
In-Reply-To: <20261028060042.GCauGPirK7ePNeTGF0@fat_crate.local>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 28 Oct 2026 08:02:52 -0400
X-Gm-Features: AclHuK8GKefxAuouxabHPgUXz1TuCwIBoofaMi9ek3JpE85x7Tutg-n7QSry9co
Message-ID: <CABQX2QP=cpMfFTdmxdQr6uVnJSF5uVQj7F6bdGwpdb1BT_UtJQ@mail.gmail.com>
Subject: Re: [PATCH v1] x86/vmware: Fix i386 high-bandwidth hypercall arguments
To: Borislav Petkov <bp@alien8.de>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000097d99a065ee55896"

--00000000000097d99a065ee55896
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 2:01=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Oct 20, 2026 at 11:34:23PM -0400, Zack Rusin wrote:
> > Gentle ping on this one. It's a stable fix for the i386 high-bandwidth
> > hypercalls (vmwgfx uses them), Maaz reviewed it, and it still applies
> > cleanly to v7.3. The hypercall cleanup series I'm about to post moves
> > this assembly out of line and is based on it, so it would help to know
> > whether it's queued or needs changes.
>
> Sashiko complains about some pre-existing issues:
>
> https://sashiko.dev/#/patchset/4ab10678a8f50053934b62b56af81f881c1d3798.1=
788414669.git.zack.rusin%40broadcom.com
>
> Please address them: if valid, you should see about fixing them, if not,
> explain why they don't need to be fixed.

I haven't seen this. I need to update my kernel setup to fetch those
muted Sashiko reports. Anyway, both are valid but they're preexisting
issues in vmwgfx. I was planning to rip out most of that code in
vmwgfx but I can provide fixes for these two. We could land them via
your tree if you need them as a prerequisite for landing the above,
I'll just make sure nothing touches that code via the drm tree while
the changes are staged in yours. Or I can send out the vmwgfx fixes to
dri-devel and land them in parallel via the regular drm tree. Let me
know what you prefer.

z

--00000000000097d99a065ee55896
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBFt
ESD21beC83Gb0OReQ1IePOf2bAibVghchBQwPU3TMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAyODEyMDMwN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEXZB4tRhPKV5CXI1idgRkejQHr+LjxREK/qzBGC
+/8PDd7XJy5osqg0Gy2iSMXvsW99ulrzC0kjnY4NA8hWlPYPk/bZRq+npGKi1bVS5L4PiUL2g8bT
NV0uRX47ff1LkuXM4W1EfQvn1E0MZRdP/9zk1DDhDIIp25hAVaAvDECeghDLmqPVFEg00QDFSSYi
HssbPGn8vcZpo2pQxr4b2W3g1yHY5cg9uq8k2m0LeA+2Sv5J8+5QYrm8pjNV+dKCcwQf6kNU+ozF
8WqXvRVfj27y3QpvOUrYg0yDjm56Zn/2OgXJ4YFnIuN9M55DIVxroduOAGdELkD1dTp8U9I35BY=
--00000000000097d99a065ee55896--
