Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794205333;
	b=CQfRO3XiFgxmq7nzO1IQZ8QaYZhq2M/fU4XqPSdl817ZmgF49vaLpjomKzQRsdZQ+UZD
	 MOOZtxtzSlHtRIFcSCN9kNPnyeMxHbcBLg8vsKqtoLSy00G7XbuF7yU4uJC5txhPFcdjO
	 AiShIfOdOvSTAFZC0oQGJD9ngW6oBKqW33ky6klQ4x58ESLzhDcs3i9HaC8zVT58PfyG9
	 liwjKa10wGToXM2gxS/2VKHzHN23e9wheSMdhZSaRNQ12rJGYS1wsDdsCQp0+yFBvQhvP
	 Ztr5A8enpLfzFgVG596lzXCQJU5DiOrb1ynYXUdRnJ8FITz5NgrIqwYp6U12sKjXyfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794205333;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 X-DetectorID-Processed:Content-Type;
	bh=6fPKu5+Dg8yYs9HmOYu86nwSuwxAhRQ/mm/STEiCUwo=;
	b=XbT8ArBZPUCZqH6/kK9aZ3z+5w6PorYS4Hoo5AL9jaGWoLoNC7ECDggQdjyoKfVASQhz
	 XhgexHebheNPUtWDJMuRiJ7cIJblbYkS7P5AWjaEfbSCx7wdofeoHtK1peavfzBaBegMm
	 12B8cr3pJdQl5LclEu4wzbglid5L2TeiwYvx8KdoQc5Pda6eEribLgRJtdN0tbq3MVm22
	 4fVHU2JeXHT8aR2/U/5pOZWugbQFoZ1sG/rwa1njmK5uOLXG/sDcSWi5ny+BWZnVoXS+X
	 4F5Z52jW3/a/JlJR7xBXsTzMxq2g3Sx4QkeUQPJ+2tuGY47Estu8dT2RMkJ5uYjGySw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ckta9NwE;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46905606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 06:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46905606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ckta9NwE
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-ccca948203aso158668a12.3
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 22:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794205332; x=1794810132;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6fPKu5+Dg8yYs9HmOYu86nwSuwxAhRQ/mm/STEiCUwo=;
        b=XGlQVY8ULoRxOc6v3J5q1yPZicQLcBqnEwtwP0p1TT2hLE8n+vBbJ32xGLb7KkzgG2
         YJnrrJ6ubM0HmpEaqoND9j/Zq42ZCcufAD08Lji9U66OlE5ufO8xKYHwAs+giRtIQgU0
         w2RjPFN3INcsPjULAEVfJxohc2lbO2EGqe3ROld9vOVWtauFIsMtxfDo0yX+WpmPY/wT
         5dz1Q0z77HN0NLC6r6EzyY3mR4B0b3Pd8v6/z6+20moztC2xY+UC9qU5HqVnq8jwtNSJ
         enr60W45BJh87acRobOlgj78+4ajHR02y4blAfZLonTdhVIJZKQb1x6oEU85+WU/if82
         lmmw==
X-Gm-Message-State: APuU4Z+ovNRGDce48e3CzkAyKcILeJ+iqlWhkJ4N09KcSUI5mT0SKQNN
	9Dq9lq4I2wD7DiiSkvgb5mqheG4+gWmjCeQvOgdCh8XsSCx0K6YOPbW2Gt52YImjOqO0B2o6LML
	9IqiSlgi9kfOENw/LLIpD+EGrwsMA9MYe0Fqclr8tDeGcdND8d9Z9WmjDPql9l2NnVgC3Em3Vt9
	uT6HYQYOuI6CWqxQ4X21b9Y7JScW6LMuYu9z3c/2EYsQomEOrcj8zyzmjz1y4DbebbdJaHIU8hP
	KeJiO0/ryXidnNsFgY=
X-Gm-Gg: AYBFou18gsjU9uR8nwOy4tOtBzOdwevmusOTExNw/ob2CIXtYtsilWdXWYptT4aqgSA
	ChWAGVOMRLQAJ1HHerFEX1W8WRXQqulw1siXFqqsJ8MgYbCwW0Rt+yfpsb/FzYjobRYOwqkdC8X
	AM3fltbsG2GzX7mkuxHW6BvTo1Naq1N3jDwka1Y4GWH/x8QUoIQGs/rvJ9FujXbFh6z0txD6ljJ
	vY86BJ6rVw0yNHd6iPKXqeu/kK8CeMkvw3zRbMaIQUG6H+5Lj4b5FdyQArST+TZM9YugM50nJTM
	KOVBlVFWRwGNd49SX24bdpnZxcghN3+lW6rbztdzPgcXCkJfpuDFlpQFABs/39kFA2nbqLNMelT
	BQq1Kkbo1kNnUA5o6kxb4xUvFA6uVkgDI+yksGwJ1M91OAoLOYtKNRrpEbymBLZJo713tUvj5bH
	ohsEGjwzZwERcOQbnz7GQZqhiwqTGpXdVE
X-Received: by 2002:a17:90a:df0d:b0:3ac:a203:e092 with SMTP id 98e67ed59e1d1-3b12d0e72e1mr2076096a91.1.1794205332290;
        Sun, 08 Nov 2026 22:22:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b12e6b2cbcsm2356087a91.5.2026.11.08.22.22.11
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 22:22:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3ab3061668eso1506271fa.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 22:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794205330; x=1794810130; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fPKu5+Dg8yYs9HmOYu86nwSuwxAhRQ/mm/STEiCUwo=;
        b=ckta9NwEVhLHO/9MziWg9sv4nn8y/vG32K2u/7V+4SkTcyt7dyxMBFiqzcvmxzcyp0
         KdYHaRSeHa+30BhotVhUKsLHrUlsw4Rm1q6Uiii9U68b3CKFD3UkhvcKO0vmmwbQx9Ii
         2z5BLhC6qO2+Up6CV3X3Ftp5vfFBDjzAQbm50=
X-Received: by 2002:a05:651c:c00a:20b0:3ad:fd26:fd2c with SMTP id 38308e7fff4ca-3adfd26ff36mr2881491fa.8.1794205330190;
        Sun, 08 Nov 2026 22:22:10 -0800 (PST)
X-Received: by 2002:a05:651c:c00a:20b0:3ad:fd26:fd2c with SMTP id
 38308e7fff4ca-3adfd26ff36mr2881431fa.8.1794205329698; Sun, 08 Nov 2026
 22:22:09 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <cover.1793685318.git.zack.rusin@broadcom.com> <70ce0c2c18008fb25399125fc81eb368d8e824ad.1793685318.git.zack.rusin@broadcom.com>
 <sashiko-outbox-194717@kernel.org>
In-Reply-To: <sashiko-outbox-194717@kernel.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 9 Nov 2026 01:21:56 -0500
X-Gm-Features: AclHuK-p-2n4Wp5I9eP4XP_3-4cVVjzrF7s_0FwAgYIN_B1MUV90OPuaEZWmVL4
Message-ID: <CABQX2QMDMEk0n0W=yrupYK0O=gs62Ukih263pw_meX6wv-mNOA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86/vmware: Route low-bandwidth hypercalls through
 a static call
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000061b055065fd1fb54"

--00000000000061b055065fd1fb54
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 2:34=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] x86/vmware: broken TDX hypercall guard when vmware_init_hyperc=
all() is skipped
> --
>
> commit fc9641d4edae98b08577710c597ef17cc2f5765e
> Author: Alexey Makhalov <alexey.makhalov@broadcom.com>
>
> x86/vmware: Route low-bandwidth hypercalls through a static call
>
> This commit consolidates the low-bandwidth VMware hypercall inline assemb=
ly
> into four backend functions dispatched via a static call, passing argumen=
ts
> and results through structures rather than nullable pointers.
>
> Link: https://lore.kernel.org/r/20260309235250.2611115-2-alexey.makhalov@=
broadcom.com
> Link: https://lore.kernel.org/all/CAHk-=3Dwivx7pi+h+hGmvNFAJm6StQLiQ-b8Dd=
sE5J=3DLMOWae8Ng@mail.gmail.com/
>
> [Severity: Medium]
> In arch/x86/kernel/cpu/vmware.c, vmware_init_hypercall() (around line 510=
)
> updates the vmware_hypercall static call to vmware_tdx_hypercall() when
> X86_FEATURE_TDX_GUEST is enabled, while the link-time default for
> vmware_hypercall is vmware_backdoor_hypercall().
>
> Previously, vmware_hypercall1() through vmware_hypercall7() in
> arch/x86/include/asm/vmware.h checked cpu_feature_enabled(X86_FEATURE_TDX=
_GUEST)
> directly and called vmware_tdx_hypercall(), which rejected non-VMware TDX
> guests via !hypervisor_is_type(X86_HYPER_VMWARE) (around line 633 of
> arch/x86/kernel/cpu/vmware.c) and returned ULONG_MAX.
>
> With this change, vmware_init_hypercall() is only invoked from
> vmware_platform_setup(), which only runs when VMware is the detected
> hypervisor. On a TDX guest running under KVM (where x86_hyper_type is
> X86_HYPER_KVM), vmware_platform_setup() does not run, leaving the
> vmware_hypercall static call pointing at vmware_backdoor_hypercall().
>
> When vmmouse_detect() in drivers/input/mouse/vmmouse.c (line 323) runs on=
 a
> KVM TDX guest (since vmmouse_supported_hypervisors[] includes X86_HYPER_K=
VM)
> and calls vmware_hypercall3(VMWARE_CMD_GETVERSION, ...), won't it execute
> the port I/O instruction inl (0x5658) in vmware_backdoor_hypercall() inst=
ead
> of being blocked by vmware_tdx_hypercall()? In a TDX guest, executing inl
> triggers a #VE exception and issues a TDG.VP.VMCALL<Instruction.IO> to th=
e
> VMM, which will raise a kernel #GP(0) fault via ve_raise_fault() if the V=
MM
> rejects port 0x5658 I/O.
>
> Additionally, since vmware_tdx_hypercall() is now only installed after
> x86_hyper_type has already been set to X86_HYPER_VMWARE, doesn't the
> !hypervisor_is_type(X86_HYPER_VMWARE) check inside vmware_tdx_hypercall()
> become unreachable?

Those are valid. I forgot that various pieces of the vmware driver
code are running on other hypervisors... I'll respin v4 of this series
tomorrow.

z

--00000000000061b055065fd1fb54
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEvF
InpyiW0Gg4T3X+6WwiwSj2sNqyj5w33sNsXvCGThMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTEwOTA2MjIxMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGQu47wIDZmKVe3AjZSNprYr4oKyzG1Zv/hYRmhs
5ZhUN4ogirZWIOUJSNSq4kFvXBFFfymRg2YAz5Lhsr/YOv6uVoWtdqxJKM8h0OT2a57GmgJ88yJE
pnl0CDiHbPHSl5pyU4fRHyKx4ud0GOpc6Li3l+B4d7bsUzxb3PJkEaN7gctJ/6TNkZbn4X+YPjrc
glfQbUsjTL+TWOum97WnpiZdmXTlNktLOMCT2IOGGvF5D3EVx9CLeZjPTCx9I8Ox3QSR3G5fvmOA
rCTKG0quVDJLldjeywu5eOZ5PFpOvYqSlWdjF5qUmFt73pIihDUVoUnBdOVDfWUQwLIE7DjSn3I=
--00000000000061b055065fd1fb54--
