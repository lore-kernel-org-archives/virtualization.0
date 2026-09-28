Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E03845D3
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620833; cv=none; b=Bvn23cszrXmHhiSPGv4nOqs0TOobDCr0O719+zR5FDNVNmlQ1w4VNR3aNtZJlcrWsmRV9HFeKiT0Grk9mGARRz59URrFkAe/g9dGgtYhcS1WZ1KCKfdZg1u/tYLrtrMdje2B2ghDHydLTws9i1TEr5Vh4alOqluP/fPsWL4OeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620833; c=relaxed/simple;
	bh=bO5656cF55zEyV9Zq+ramYg9ZytNBPwdRk5ClzLKF3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EA4gXx9fTWhll6UUXkrkNiFAqAnTPX90+V1k+NlgLBtKWysEdsiEjW3Fn8COYpbF6UfnRmwGl04fylCBGw/Q0USe6foQr20FY5NSfRc8nxTex4yJEbJSw7WoVMZbF868RZ8HJYQwGFq/2ylYKn3/RPGl4U23CzBgcNs0Jrp8EGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K3hDhpll; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K3hDhpll"
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-30b6dad2382so125508eec.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 11:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620830; x=1791225630;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=frq6EGenjUoA9z6+DtHPE1EFxaV+hr+FS0p46mkWSLk=;
        b=CdJzNWBUFEEUTfGrRgoXFy7OoyuBeY3EaWom1bwCC3XInqBm4W70GoTcx7mfZIxaGB
         GYrRE6m5MCoNvb/UknrRK1pXH9GWBHvV1ZHGfAm28rOzO5vhrcEdRNvljnZuM4bBx4bM
         X/snr5paGwX/NsxeAIXRrJtb3v72oj4H38JZvx40XvO8KIMsftCkE31uJ+ShqXnB0+Q+
         XAhdJZwF+KHb/BdXoA6LuPHdCDHP/sRR4B6SykUicPKhwaqpszEAIxwnVSTqVcoOAz+q
         0lHfYbS85h8t9uWrOgjNreubFGoZ1XFHJOQeFm3w3WvpPN0WtEB51BlbEkzVVqPkgGcm
         Jq9A==
X-Forwarded-Encrypted: i=1; AKwUvBzIIPwyGdI0VHzmql7nCs04cy56TN9mhFn60dXEOvOL/+BUpK1MMoQSBdxHCpk2LNnpRkWLxgJ127B3Ewd5tQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nIm6OEvzrrrX/LCzkQjKin+ltJ8vN2qhBNBf+29DZGzetAPiRD
	GfDI6bUpgPgQH88AzHt+DJp6mq+kg6qXoB7eMcqK0IR4J9+6r3WgSfsr4JsAyAD9a6FXLaAdEUw
	X8oz/SvVaYkQ+2QWWajineHUgeY6u3uBSDiS9FgM0rQebM25/Q5myfm26mTLyTVIaI2xJUhakhn
	cALpIXpZ3BZnGyxtVSjwT5XD16juDKoIGVqnGT79SZkTmrgJfU2zngHxwcWs3nwHXoMMDqWwle1
	dZDLY+EtagvNkO6fd4=
X-Gm-Gg: AYBFou2jIZmpSTHYoVQl5NcO9PG7D6k0g29WnrTTVIBQQDqIbc2+K3qS4/b/TK3H2Hy
	5EpceyADgXAwjsfHy6DV8aynDY8jNXaAIQMWL7njUL7khT1XPSb1tv2JQ5ovt3mpOlLIP4l2MMf
	0kvDgflHEgBmomjZwvVoIV6nJz5YrJrHK2w5SFHQOTfwq8K8v7NNA04ELbJC5UMNDY6t2vDTOoF
	ucEF1nX85dAAOmLqnIxIU9GVdRkKCjPf608JXasNTFOMdZoX2ZtiqIn30AqmzXYWc18AZ5QfiiN
	TvV5bx6k0xK914LtWPhz4hoRneaUipTIn90dJgdBNYiVsQ+oIvpSJ7Zt8KiGi22M4R/8l6b4ayg
	aEeo4k4O00n3SBkG7g72GzMBq//pNArsHbKgBEfcZtc1hTDaIHIMwxU6kP6QceGhzGTc3xQExXS
	Kbc8tqYb39t5ULj1GOjA+XxgJZJmihSFvn
X-Received: by 2002:a05:701b:2051:20b0:13f:be10:5168 with SMTP id a92af1059eb24-146ce493f5emr10823665c88.20.1790620829120;
        Mon, 28 Sep 2026 11:40:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-145a720b6fasm279558c88.0.2026.09.28.11.40.28
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 11:40:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3a5b062d0dbso1705231fa.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790620826; x=1791225626; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=frq6EGenjUoA9z6+DtHPE1EFxaV+hr+FS0p46mkWSLk=;
        b=K3hDhplllWy7Xt9yvbnbUY8nTuqXd/4DoicFj0NIy998TIDLbSPUSjKR0qwIoGId3M
         sYjuUjrOjMu4M9HDZxBLhar3nKG4ZAPB8RsdwbFcwV35wSdCsAXt22j+XADvMIG1iSLp
         RRQ+omiQ5OajPbpXIliNEjZRyiUsZvDCzKQjw=
X-Forwarded-Encrypted: i=1; AKwUvByECvkEPDnNhU88LPGV2QQmOlkyQMpktswVsbV2njdumuJjmhKClR2IMtQl2DGiTE9zgpSyIReV7GOdX+fong==@lists.linux.dev
X-Received: by 2002:a05:651c:18c6:b0:3a6:5fab:f4c8 with SMTP id 38308e7fff4ca-3a76479b9fcmr534821fa.21.1790620826615;
        Mon, 28 Sep 2026 11:40:26 -0700 (PDT)
X-Received: by 2002:a05:651c:18c6:b0:3a6:5fab:f4c8 with SMTP id
 38308e7fff4ca-3a76479b9fcmr534701fa.21.1790620826067; Mon, 28 Sep 2026
 11:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1790014793.git.zack.rusin@broadcom.com> <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
 <20260928180829.3A3461F000FF@smtp.kernel.org>
In-Reply-To: <20260928180829.3A3461F000FF@smtp.kernel.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 28 Sep 2026 14:40:12 -0400
X-Gm-Features: AclHuK9rgQQeHz19PVz8BmJKDUJ1fDkrmkQ8Mwi1v0UIsBqIb-VqjZZNOA_FQDw
Message-ID: <CABQX2QNHSjP+FFppUR1ohthwvCjWNA2ozOuZtnwwdNu7WGaV0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] crash: Notify pre-kdump callbacks before switching kernels
To: sashiko-reviews@lists.linux.dev
Cc: Petr Mladek <pmladek@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Kees Cook <kees@kernel.org>, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Ian Forbes <ian.forbes@broadcom.com>, Borislav Petkov <bp@alien8.de>, 
	Joel Granados <joel.granados@kernel.org>, 
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Bo Gan <bo.gan@broadcom.com>, virtualization@lists.linux.dev, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Eugenio Perez <eperezma@redhat.com>, kexec@lists.infradead.org, 
	bcm-kernel-feedback-list@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000512ce3065c8f6614"

--000000000000512ce3065c8f6614
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] panic: Pre-kdump callbacks always receive NULL message in defa=
ult config

fwiw, this report seems invalid to me.

> commit 8884313d127ae4b9734baebea7b4ba8dd25b38a5
> Author: Zack Rusin <zack.rusin@broadcom.com>
>
> crash: Notify pre-kdump callbacks before switching kernels
>
> Fatal x86 oopses can call crash_kexec() without reaching panic(). Run the
> pre-kdump chain from __crash_kexec() as well, after finding a loaded imag=
e
> under the kexec lock and capturing the original registers.
>
> Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
>
> >     the shared guard skips callbacks already invoked by panic().
>
> [Severity: Medium]
> Is this statement accurate?
>
> During a standard panic-triggered kdump with crash_kexec_post_notifiers=
=3D0
> (the default configuration), vpanic() calls __crash_kexec(NULL) before it
> formats the panic message and calls its own explicit
> panic_notify_pre_kdump(buf).
>
> Because __crash_kexec(NULL) runs first, won't the new
> panic_notify_pre_kdump(NULL) call consume the once-per-boot atomic guard,
> rather than being skipped by it?

Yes, and that's intended. By default the crash-core call runs first
and the late call in vpanic() is skipped. With
crash_kexec_post_notifiers=3D1 the order is reversed. vpanic() runs the
list with buf, and the crash-core call is skipped. The changelog
sentence only describes the second case.

> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 2b36aa9fade06..5d9fe9e00f39f 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> [ ... ]
> > @@ -139,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
> >                       struct pt_regs fixed_regs;
> >
> >                       crash_setup_regs(&fixed_regs, regs);
> > +                     panic_notify_pre_kdump(NULL);
>
> [Severity: Medium]
> Will this cause pre-kdump notifiers to receive a NULL message pointer ins=
tead
> of the expected panic message?
>
> If a system panic occurs and kexec is configured with the default setting=
 of
> crash_kexec_post_notifiers=3D0, vpanic() triggers __crash_kexec(NULL) bef=
ore
> reaching its own explicit panic_notify_pre_kdump(buf):
>
> kernel/panic.c:vpanic() {
>     ...
>     if (!_crash_kexec_post_notifiers)
>         __crash_kexec(NULL);
>     ...
>     panic_notify_pre_kdump(buf);
> }
>
> When this happens, __crash_kexec() will invoke panic_notify_pre_kdump() w=
ith
> a NULL message pointer. This permanently consumes the once-per-boot guard=
,
> and any callback relying on the documented msg parameter will experience
> data loss or potential NULL dereferences, violating the API contract that
> promises the panic message during a panic.

afaict Sashiko gets tripped up here by the doc from the previous
email. Nothing in this series dereferences the msg. The only callback
is the VMware logger in patch 4, which ignores the argument. It reads
the printk buffer, where vpanic() has already written the panic line.

If there's an interest in fixing this false-positive in code for
Sashiko (or if there are other issues that would make me respin v3)
I'd just change the doc added in the first change in this series like
this:
- * @msg: Panic message, or NULL for direct crash-kexec entry
+ * @msg: Optional panic message; callbacks must tolerate NULL
which, I think, would fix Sashiko here.

z

--000000000000512ce3065c8f6614
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPhI
gaXowkjjU9UqGixDN9KfNAZpSsFV1cvMkPQZAQKnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkyODE4NDAyNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADF9zyt1TzcjIO9q6kaPLHyVwDQW/qHPu3RX/QW1
lRgOL+zkqpfhgAJfMYHo946HHdNdu70dPWn+YOiPbJxoJL2vo32Za69viZJsreL3xtf25S4yjyWF
8yj/xby7OVYFLGP9n7r8hwziIOHWJG/Vuw9s4e1yZuDawOitJlVZQYhcFQfI5fhl2dnYtnW2TOao
sCigQsvUFud6irkf1+UTpJeUm814yCPeK2w8UBrrlkxhXrMqcvg1B0iCzAzmNHx5W3c584MJ4rgG
imy1LHh8zOZl81BtxkuLOmt87EvSTszUfs24QLzB9oyTBffOsSbYDt68G4lFV4NFG1yDKTklSsA=
--000000000000512ce3065c8f6614--
