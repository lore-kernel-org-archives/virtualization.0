Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553681;
	b=fDd+e3BUsLYfeYbZtzSpuRYy/wfcPrryD4SPB7Ig2/AF602gILg94zNTJ91eVUyF6gNV
	 rsxtQDdpIRe9Xd8yYVfY5Cw1nlSXzoPlZaHnQZKWBg2b0WoYZ2c80iVxVinD/3+LbaOep
	 7alQVGNUlLfXuzxMh1BapurD/WSsdPmhHxEA4FSeNTMSWXSrhzw6KKiCGcPpzQ4pWu80C
	 c6A9pkFrf8jcyH9SiN7mJPhDV2E3OVkR2bRKBZUpb3XVnZp0tUWagXdQWda+ip0ox/Mm7
	 biTzcJ8d1fjxxYk6JEKIVkRzupCBhM8yzVg9hzWmTJsbCtOVAIyVSqL6Wr3sNOFhZjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553681;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=TW/BbVMbFlcb5rUkwbNncNlF+KIBoi9iFK9eJaB+gV0=;
	b=HyO98DonmWY0p7pY1lZXMY6612Ksu+1nMTYBioYEMmHkJ3kvvHRUGUwcLkaqCWLyb5F/
	 aq+4s7RwwPdsihs9nJZ0l+tPDTfUKB17li5jTb0ShjbD6XneqFwKj576MscrQ3jbz9DSu
	 tw9jcX7uNyZlo7G04GGISLn+JESuf2sVajZNPaR/ldfKO+A/8lHswQ06wnouYIAblOgwe
	 yHxv7u/eQbZXYEd0hTR/EfcmUMFpdiYg2J4CL4ygjzoiHeLuJVRfsqkSknh4+xMpcq3cD
	 O+uX+L9yjuET2sEFDoHGUmRGW8h/bmk92/2ool5xWwrgZD6X8hNeTdQsCgH+DYfrEjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ey+m5s2Z;
	arc=none smtp.remote-ip=209.85.222.226
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A2606A31A
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 03:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 446A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ey+m5s2Z
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-93f3c616c84so27100385a.1
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 20:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553680; x=1793158480;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TW/BbVMbFlcb5rUkwbNncNlF+KIBoi9iFK9eJaB+gV0=;
        b=A4Ctf3xDjF2e+Ku1VxxIzrhXGFTBpyyr9slNkNSADNhmUO9jcJXqaAysNAENlPI351
         Gx/kvZB7uAwQQJXGKeaJxzJWWEDCvEPDd1Zrydh54Wp9zDEJhl/sxeMYsqULLwqJ3xxn
         MXDzOCoODCVY7oezztelywHP5Y+uVnEKKd4mmgV8FtDbLhGORRwGJiCgY92PGuBJn5Tp
         jnBMCDd7kyzKgDzUXbVO1QOwiTnj0l6feV/n12Rtk3KIadfS7O/EP/4gAQ1pMtRsY73U
         5sOAueG2CemRI7o7rOVq9NtU62IgPlp4ogu3cRVQDXQGHQrn1iCqnINMUinBdW+OIHl9
         ynZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxH6Gd557NKQthBLY1oR5g65ji/pse0ATJeub9Z4zK96AtPRhO9u7Wh6WbhgFeUiUhHBE/7cCW2lgtWUTVhg==@lists.linux.dev
X-Gm-Message-State: AFq9FYII6UUkd7AV4P/4U2ouWJ100+ibqVzwB/9sBMKC58TDQNt9elW5
	9MgWpC6NprueziwOzF9p5GpiJCdKv2XplGBFMyCPpgPpCvDPwVnmrNk/Fmyi+ZjaCT36mjQbOcJ
	v9cC6pvkPx4xOwPxR5SfIyIdIrFekvNRlXlZnvvDWwDnstRp5T3dOlO4JBjRjEkGZtnmVmdnJxp
	9Z3T1g9V4RU5byPPO8TI+OfWCx8qG+KL5a9jijXJKwvBYc2eeR0Zhpmqy4iPOe6+iSAKqhzDX0z
	NjDQcVpSDu3C27EA44=
X-Gm-Gg: AYBFou3jzhctFfnjPaF+SVrHYS7t5xHu14Am/hDnn4EBNuMx2Ge1f7T81f41hfFUuKv
	Zdc2mPqh3Fcazl91wKY/8wdzU5LQxThrpsAaYyGddzT8RcCENSnYiP9L/Xr+zRcjr11r+x8Kyyi
	Nj9SkvbVB+nhe6B2Kg4bIwczPo+4I1mSqCg6JX6b4c1HGfEGnb3u2Jj7khtOxDdaMOrITqmGlA6
	eHoF61T4XfnHmiM1pNZFZg903qedKFjfEgmpaXuKSYBW1zr8RQ49xFbOFX59f045wskBWeyTZZC
	gw+bWRmQSexd+M9DYIIOAg0D+QLwfKSTgiOW4jqumfGr3hWI4CikxjHB9T4cKOA6z+Cf/kTo6UP
	3Jx/y4XxAPw5f4Tg1kQpNrH4piJ03c7HI7E2GSL7niNSQUDTHHU3XxoOeoWtd8CnU7UPf7oWEL7
	D69zBPk0zPWlkGdlyM8Fci+72Ok7qVdbwyQs4=
X-Received: by 2002:a05:620a:198d:b0:93f:184d:ac13 with SMTP id af79cd13be357-93f57f4684fmr224685185a.51.1792553680107;
        Tue, 20 Oct 2026 20:34:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93f56e0591csm26678485a.16.2026.10.20.20.34.39
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:34:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3ab32495d61so1280621fa.3
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792553678; x=1793158478; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TW/BbVMbFlcb5rUkwbNncNlF+KIBoi9iFK9eJaB+gV0=;
        b=Ey+m5s2ZCcz0zFWq22Ol1xGmxrP9aF6O8Hdf7itRV9z05lVjKNZyatLhe35jegz7fB
         PVv9ARuAz4vizQhEsLYEWAhRrIInKrJ/MmNXA9EFP+XYekRWdz8r3N68qsmai3zI5i2G
         3XWYrC93cdBDKxArkoF1eM0Y8ZSj7sCUbXy0A=
X-Forwarded-Encrypted: i=1; AKwUvBxS8Qpd5up/zeKY4XXbNaHmMX2+U+8nGvq50rsoLEV293lPQqqOkNucS6Xbz+d5bUqfMwVYz/6UA2w4s+i0mg==@lists.linux.dev
X-Received: by 2002:a05:651c:a0c8:10b0:3ab:3b73:4560 with SMTP id 38308e7fff4ca-3ac4416514amr1399531fa.11.1792553678359;
        Tue, 20 Oct 2026 20:34:38 -0700 (PDT)
X-Received: by 2002:a05:651c:a0c8:10b0:3ab:3b73:4560 with SMTP id
 38308e7fff4ca-3ac4416514amr1399461fa.11.1792553677861; Tue, 20 Oct 2026
 20:34:37 -0700 (PDT)
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
In-Reply-To: <4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 20 Oct 2026 23:34:23 -0400
X-Gm-Features: AclHuK8ENfLisiIT_GEK1qalO15UCXsiYROrnCL-RUbBf_6CSo_GUxqkuPipUvI
Message-ID: <CABQX2QMNetg9iYRRsQmeM3+1tnC94ccWM=450wMZL_sUbqAJtA@mail.gmail.com>
Subject: Re: [PATCH v1] x86/vmware: Fix i386 high-bandwidth hypercall arguments
To: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000041b6cd065e516d01"

--00000000000041b6cd065e516d01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:07=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.com=
> wrote:
>
> The high-bandwidth hypercall helpers push %ebp before loading the in6
> operand into it. On i386 without frame pointers, both GCC and Clang can
> address the memory-constrained operand relative to %esp. The push then
> moves the stack and the helpers load the wrong value.
>
> Typical i386 configurations use the frame-pointer unwinder and happen to
> address the operand through %ebp. However, UNWINDER_GUESS is available
> with EXPERT and permits the affected frame-pointer-disabled configuration=
.
> vmwgfx is also available on i386 and calls both helpers.
>
> Stage in6 through %eax before changing either stack register, then save
> %ebp and copy the staged value into it. Load the VMware magic immediately
> before the string I/O instruction. Mark %eax early-clobber so it cannot
> also provide in6 or an address register for it. Use the same sequence on
> x86-64, where the full-width register preserves in6.
>
> Fixes: 34bf25e820ae ("x86/vmware: Introduce VMware hypercall API")
> Cc: stable@vger.kernel.org # 6.11+
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Hi, Boris.

Gentle ping on this one. It's a stable fix for the i386 high-bandwidth
hypercalls (vmwgfx uses them), Maaz reviewed it, and it still applies
cleanly to v7.3. The hypercall cleanup series I'm about to post moves
this assembly out of line and is based on it, so it would help to know
whether it's queued or needs changes.

z

--00000000000041b6cd065e516d01
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILp+
YS8IS4ny6z8YupvsGjeu4GQJnu7XOoFoKwZuI4WxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAyMTAzMzQzOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAQIOyY9umz0jGduAk7yJ7nOmFjrQb8Op/UZN/9r
hgzl7KxRjd7M4hScN0XEoKJn4oJMfHdkGYc+07w9Io+UVVBkds18D4q7jOm/Ngym/BcKKjSgGv1z
K1oIjZu1fcxIT2vJu17I5BYZcIXOMKL4bGs0EHAeAqdZPcciPq3vBD+2IpydG42u0n6sPD6mj8uH
UMt6JbMLKivRZp/zEepKBPCripnp1ZGJwfsXG+8ya3/BgpzI7a1D6OEhtjklL0vAURHbNxwNCzGn
Xro66AxXm5VK6KDDI+cegVCsd1foc2UYXb2Q5szyZtlnVaDG8vYy5oOVFzvMrYd4nASpHDkCwyE=
--00000000000041b6cd065e516d01--
