Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDFA53445B
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997670; cv=none; b=Fp3/8l2AzZEXduBLtPd99mJOrhYosjfRtKQN4YLhMdbG6It9bpMXFjC87pDouI/b8HL2xFaNB762Oer7Ptfj9a4YVpCBKsFYxclnZV8x1Nul2rF1b9FYZuW/TFnu99Mgd1Xm6XRepIqmKUdDHoU1p4bgOEffk0Z7c9UjA7adXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997670; c=relaxed/simple;
	bh=70tYLLgFJ9ntyifhGhJ4y6MyRTjMs+bi9ftkpHcsyEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDFz6e4yf7HA57dvyOOCA7LSXueH4AuWrOBtpGvbb6RBtMYcg6LhdKY0jX7bm6vY/x7rGEM8MQ4z6fqErH6aZJzYW+4lMp9qRxi7ycvGM8bPDydXzeKsMOrPHttqy1+py+Ozfck16aHkUT7qTJGUJVKL+kbb+VfyV9FV49mxTWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G6a+wyNZ; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G6a+wyNZ"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso549052a91.2
        for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 10:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997668; x=1792602468;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JHzW6bDEaGoGs5DhIF2XGQykKSGS2iggchCHk5Yn44c=;
        b=1INFpBKj74GI9N3rorhZCiP0s90tJBr0XV4n2l5ns/YYwd53ggYp9JXqkHSzY/6wi8
         dtDigIwEp6lYmp+OnAklQfNVM8DlIHuwEUkHo18L7LSf+SYOjvRF66t0F5d5voUULDC2
         WSf5It3BjIyBUWP/3eLQE8om9HRBNXOsjp/OtZEHWz4o6wwaJzjJhuC1Jq5eT5DZLX+W
         dfrJyyrHo7JnJVw40YQXRUIl1G2dTyxS4Rr+aUgvwr1hcGeBIsitWvBgfTIrDeOxvi5u
         Wyxjid35FtAWzVujie6+8rGcHMNp67gjMFYfQkKb7wcEF9nyMBwaz8cizVyOwj3vru2k
         TCFw==
X-Forwarded-Encrypted: i=1; AKwUvBwBPBFes78pnZoipFPVAfdPdNLtg3Ta+Onv9+BKhV1lHQVw6byxkcMVrlkA2/n0i/bZPQ62OEV/PQ+ZRLwmng==@lists.linux.dev
X-Gm-Message-State: AFq9FYJvbEc2R7LIrgdXtFv2xZnrW3SPeylsdItJcmUhj5CK7mLUGW3b
	5TexGaUhWVyH/os+Q953T/pyxVtN0Chwg48PkMk4C+h4sr43fzQrpvqF9BqMhNgrPjaF4l15hOE
	bOC2uJ6GpClpoY/JqZlV5368P88WBh7Bd88/JLIHMYYGE2bcBWj+GGf0288wKDKX0LyK/jZHrkU
	GYGalRJysGIOAXiIc4iuqpNqzoar3wSFAn3or8qER0FNuEf3q0vT1of8kj7PEQxHP8Qz33YsWlk
	wT8P7CjeUlWid9iZGyneQ==
X-Gm-Gg: AYBFou0CHYjqt2PNue+ETYh+o5PXjX4fxsgkZknx1HAmWku97mLlCMlfsBwzAxhTfkj
	W4PsUW7rhQqjmk92trZWw3MASQnrkgct8cazdeYuOsyrBBCcqqxz50x+L5ZtK5zPY4kBH+rwPLD
	G54zDKlHI8ge2S1sNTe/yd/6/G4gSfJ69kRPrRl/PNKl9F8yJbguqOVPrvRHkDardPh/YH51doF
	rdgwe93a2oD4Af01onHa+r7UiTAiZjpXe/02Aw/+pCBRqu7aRLQUejywJcrPqXaMITYc6NLz6rd
	pgDWKOrzEeH5o/1UFmy7+8EMTHMfcEmkmixuM6/vKtVqjOiEepWROvoy+hrnAY4AVg1VI/WI8Lg
	5j753eFvGfRULVj800mPRM/laDMvCzfW1xc9fIOPcRc/x0H3ku0bohuEuysmAiNF4qYmB0rHHZN
	P8qZAs7OESH9FoNZN55ijNFJ1aOrNZoX83iKk=
X-Received: by 2002:a17:90b:224c:b0:3ab:2ad1:f10a with SMTP id 98e67ed59e1d1-3ab3a0ef48emr13419448a91.0.1791997668256;
        Wed, 14 Oct 2026 10:07:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac9446352csm122654a91.4.2026.10.14.10.07.46
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2026 10:07:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3a767a22ca6so20514551fa.1
        for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791997665; x=1792602465; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHzW6bDEaGoGs5DhIF2XGQykKSGS2iggchCHk5Yn44c=;
        b=G6a+wyNZJDLdBpSCAM3aBh5ZKTX9mBG0fj4p+YgLw1Rh/7kLFqcZIN9T/KI4MjvT09
         6UyTfcXcFsHqUHIwwCWQ7j4MTmlTAn9VOEA9l530cWqPBA7BSKOguO1hVdFcSHH1XhDz
         4D9SX62PP43vb7SoiSiwbODmSvzlp2531j/U0=
X-Forwarded-Encrypted: i=1; AKwUvBxaG2xTJb2bgaDQcTqUTkbzb69OOzGtQYNk1yGT8qt1FTLN4ka4bvrZ8pq/XcEPTrp6Srfm+tvfk6ULNZqZ8g==@lists.linux.dev
X-Received: by 2002:a05:651c:b27:b0:3a6:6aad:be45 with SMTP id 38308e7fff4ca-3a9c54b789fmr36820551fa.10.1791997665342;
        Wed, 14 Oct 2026 10:07:45 -0700 (PDT)
X-Received: by 2002:a05:651c:b27:b0:3a6:6aad:be45 with SMTP id
 38308e7fff4ca-3a9c54b789fmr36820461fa.10.1791997664890; Wed, 14 Oct 2026
 10:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1790014793.git.zack.rusin@broadcom.com> <364337F4-8127-4693-BB85-E0657B634B43@mainlining.org>
In-Reply-To: <364337F4-8127-4693-BB85-E0657B634B43@mainlining.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 14 Oct 2026 10:07:30 -0700
X-Gm-Features: AclHuK-pXeefcjtxG6LN0Usydz067LI9rz9CqzP8-9S0l3gWG-8eO_FkGWWqZ_g
Message-ID: <CABQX2QMX7yQgKwY7EnazH6ejAExx_hb2o8Vcw21E+kucYz=h-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] panic, x86/vmware: Preserve crash logs before kdump
To: Bradley Morgan <brads@mainlining.org>
Cc: ajay.kaher@broadcom.com, akpm@linux-foundation.org, 
	alexey.makhalov@broadcom.com, baoquan.he@linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, bo.gan@broadcom.com, bp@alien8.de, 
	brennan.lamoreaux@broadcom.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	gpiccoli@igalia.com, hpa@zytor.com, ian.forbes@broadcom.com, 
	joel.granados@kernel.org, john.ogness@linutronix.de, kees@kernel.org, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maaz.mombasawala@broadcom.com, 
	mhklinux@outlook.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pmladek@suse.com, pratyush@kernel.org, rdunlap@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, ruirui.yang@linux.dev, 
	senozhatsky@chromium.org, skhan@linuxfoundation.org, 
	stephen.s.brennan@oracle.com, tglx@kernel.org, virtualization@lists.linux.dev, 
	x86@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004d3b70065dcff880"

--0000000000004d3b70065dcff880
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:40=E2=80=AFPM Bradley Morgan <brads@mainlining.or=
g> wrote:
>
> On 28 September 2026 18:55:34 BST, Zack Rusin <zack.rusin@broadcom.com>
> wrote:
> >A VMware guest may have no persistent storage or working userspace after
> >a crash. Preserve its newest kernel log tail in the host's vmware.log
> >before entering kdump, without enabling every panic notifier by default.
> >
> >Following Petr's suggestion, add one generic panic_pre_kdump_list with
> >VMware as its first client. A set-once helper covers panic() and direct
> >crash-kexec entry. Fatal oopses can reach kdump without calling panic(),
> >so patch 2 adds that call after capturing the original registers under
> >the existing kexec lock. The late panic call follows sys_info() and
> >precedes the kmsg dumpers.
> >
> >Patch 3 adds Guilherme's suggested escape hatch for debugging kdump
> >failures involving early callbacks. With panic_pre_kdump_postpone set,
> >the list runs before kdump only when crash_kexec_post_notifiers is also
> >set. This can omit hypervisor crash handling as well as diagnostics.
> >The late panic call remains eligible. This policy is a separate patch;
> >I can omit patch 3 if it is not wanted.
> >
> >The logger preallocates an 8 KiB buffer and bounds its register-based
> >RPC transfer and retries. Michael suggested increasing the buffer
> >because 4 KiB can omit useful stack-trace context. Ordinary guests
> >enable logging by default; encrypted guests must opt in. Use
> >bool/proc_dobool for the sysctl as Joel requested. The potentially
> >terminating REPORTGUESTCRASH event remains a separate late dumper,
> >suppressed whenever a crash image is loaded. The v1 assignment to
> >crash_kexec_post_notifiers is dropped.
> >
> >Tested on VMware Workstation and ESXi with ordinary guests, and on
> >ESXi with SEV-SNP and TDX guests.
> >
> >v1:
> >https://lore.kernel.org/r/cover.1788414671.git.zack.rusin@broadcom.com
> >
> >Zack Rusin (6):
> >  panic: Add a notifier chain for pre-kdump callbacks
> >  crash: Notify pre-kdump callbacks before switching kernels
> >  panic: Allow postponing pre-kdump notifiers
> >  x86/vmware: Add a bounded pre-kdump log sender
> >  x86/vmware: Add the vmware_record_panic_msg sysctl
> >  x86/vmware: Report guest crashes after kmsg dumpers
> >
> > .../admin-guide/kernel-parameters.txt         |  14 +
> > Documentation/admin-guide/sysctl/kernel.rst   |  20 ++
> > arch/x86/include/asm/vmware.h                 |   2 +
> > arch/x86/kernel/cpu/vmware.c                  | 250 ++++++++++++++++++
> > include/linux/panic_notifier.h                |   4 +
> > kernel/crash_core.c                           |   3 +
> > kernel/panic.c                                |  28 ++
> > 7 files changed, 321 insertions(+)
> >
>
> All the panic changes and crash_core changes looks good to me!
>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>
> Tested basic panic calls with Power10, in courtesy of osuosl:
>
> Tested-by: Bradley Morgan <brads@mainlining.org> # Power10

Thank you for testing!

Petr, do you have any thoughts? I think this version addresses all of
your concerns/suggestions from v1.

z

--0000000000004d3b70065dcff880
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEFo
IJ5vd/MUhAk2bv3a6kGZnwx1m1lxJbC2yytLvdDuMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAxNDE3MDc0NVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABK9edzXmHJsrnESInLkCDpMxAeQWV5jzCabkD63
GDvvFykL23/V0cxhOSPMDMCRC9nn0dsnVDcbFl9Zhc4DtkDZuXCbQENDMfMUSI/GePHHJG8YnjrD
2JWCESHf00TcVrhQbaO1r4Nq7xZtgMbLEeEz5zIB7hjmqikeVV6EyHhSloq+nAx07GaiUnIlZwoA
+Um86trs2MIo17ep5P50407bAKu5B9UkDlVvUWYNFpmBYZ02S+tKGkXM93HQ0hBzHbrwpTcko8Tn
6gqJzfNUh5LDuNdSF+L/WRZqxKEVQcHaRRsf16bPWPxCB7I+x++uf69cRAP2I0rYxLtm5Et7KXc=
--0000000000004d3b70065dcff880--
