Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C43CC9E9
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701850; cv=none; b=IutfjE9i0tLwM8ssMatpgxrrH3dGS3VsHgq7/ficL/OpeXD1pRuEWFoZV/ZNwz804D/0IgA2Ez2ay9dNDio9Fo5mqHQ5aEWjmCHdecoSGs1RSIaDHodzMwQORJ9kwnqk6QC2LuhOJvuUaBwXdBol2orDlSjH/gpx6a2RWYKkQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701850; c=relaxed/simple;
	bh=Ztaqij1A0PYuSLhNN9wxT1BIT7KNIenfx74QZrG9SVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0tAYr/Vle8x/JMOwIUkP58W6xw47AT7w6jH45QMX4nIa6+in3In3i9572nkNTrseWdrMFtTV0gvQ7vZX7jYwBiV3KBgAjuWNrZS4kk65ASey2kPwe2t/gWtdRuniP3crhBqI+SyXKbV+XVNeu6UBw6fQkP62Oxk+jLXWOeX5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IcjVBH3y; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IcjVBH3y"
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-782e0fc1e55so116514137.3
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 20:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789701845; x=1790306645;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P4TISpGTEpPRFeH6dNvjSEs86mDbAdNLizDP0rAJkDw=;
        b=zMWYvK9qpENsEc0iILX9uqd0AlD6wHQkUfOI7DKvRBrjWACX/WcuZXzM4LIaYOhHjZ
         N8CKaKVDvVyEAiI1/RVS3ayC8WGg1AGNDwCOnaAgnz4GhV20q/juo7h78r9Xq1poM+yK
         j2JJeo+GtLmj59Px09P+PBJSqZnLOgbKy0FvYomf5oz1OXJYnmwrMqfOqDo30YkUwBAn
         yPK66cFutjOWGB9hbJukE6qUcoaKYTt/M7CyXjD6MoD+5BYaRmulWOGFU6ppdKZTQXqE
         CF5TBbHmbR5XAtHHyUg4dV89PsUhJZnRq5tUhuvyLoQbHlNjwbK1XdCG1z7vong0mfZ/
         TI7A==
X-Forwarded-Encrypted: i=1; AKwUvBxI6HZB8bHWYbQwe7tRIimFFEtK8FayuoYgy9g5klCUPb/DFkJIWhu0qXn9eyF+zYdrQ5WK2/AUhjL66VDTSQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kVJvjnYoFdKtd9TEuQpH6omU+jmNSG9wFksoS9f/0KBswygo78
	tbYDvvp0gzyamyq70LRQhx/0vFZ1IjwY/teMZkFk+cBgRPikTMaHiPiXS2K0X7gQ8QZq31Pw3LW
	Dgr928lPFHlM5ZarG7Uc30QaR8A8SgBGMwA985zwYygMOoCaNfZE01L5rStRLWWf87IeyAeP18N
	kyaHCWfw3O+nDvW4F/tZXfvlWlIsakV4BrqgZnkN+tOBlKTDuFk1IF/BHQdVD49pQdcIu5YY6i3
	dxKW3pbYRGL7xatW+A=
X-Gm-Gg: AYBFou3CPPzwKgd5qDS2DCtDX1vPgB1oRwzg6tz6ajJBg5jayfYnAx6prOB9PmdZHPP
	/vxAUud3Da0Lagx52lyx5+QmtYqyKzQKiUFr6xl2MKc1T4gmbHNl20SgsceoF04BJVwtJ4Svkwo
	Wxe7nzLnWg1Hu3/Hzq1vxf3eUD7ohz3tSTTUcGjAh5JVQMZBsXZrFUKroxUeB/VzGMkxlOcBm0Y
	JmxGtYzPFZ+P0Tlvb7fKyuibpgRxYGAOB6gyTuix+78dwi0/LPD+EoBo7hsVAeg0f1G+lnDfUde
	PN0uVgHGjHnpDoXVTQC4CRAvOlebexxFy8mLYj25Wc7422Tmf/cuMdHqWB8eeE+cUnbuhjM2x/A
	d2so4vf1YU35ZSRgNkGuqJO+HwiC1zWI5eS03ivyZ+3dOWFRGGOLhjonY+ec3oDx7HGwikcTSfR
	AU6eWYP8EcDzqfQEEhUZ9oAqor9B1Uafyu
X-Received: by 2002:a05:6122:3114:b0:5c9:a60d:3276 with SMTP id 71dfb90a1353d-5c9b599c9cemr543422e0c.10.1789701845250;
        Thu, 17 Sep 2026 20:24:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c9b81d36d0sm221448e0c.1.2026.09.17.20.24.04
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 20:24:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5b76707e6d9so131534e87.0
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789701843; x=1790306643; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4TISpGTEpPRFeH6dNvjSEs86mDbAdNLizDP0rAJkDw=;
        b=IcjVBH3yuASce2Wvrmd1u6WhlaQqjes8msvzQSEKSWfF4TpVWYGDC6BMvRXPCo4w+j
         BSoeOTunV56Fdp9rsw8ivSKmrZ5sgGJ2/WaD72C8q57WHWulNt9n8Ezj/Qu3xKgOOSk2
         i3U4HJdoYV4K0yRM+51/vr3U4VtbW26Kj8K58=
X-Forwarded-Encrypted: i=1; AKwUvBzKrNW9NKVEvp0v5Mqje1072n/fQHryJa5f0VwN0DjjFHT8HYi46M1zdJtQPx7L9OOTqlTk/tdVlKxFtxkAVw==@lists.linux.dev
X-Received: by 2002:a05:6512:3ba3:b0:5b8:bc5e:d118 with SMTP id 2adb3069b0e04-5b8c1986aeamr235861e87.66.1789701843383;
        Thu, 17 Sep 2026 20:24:03 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba3:b0:5b8:bc5e:d118 with SMTP id
 2adb3069b0e04-5b8c1986aeamr235845e87.66.1789701842954; Thu, 17 Sep 2026
 20:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1788414671.git.zack.rusin@broadcom.com> <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
In-Reply-To: <aquttpMVKX8e6zGB@pathway.suse.cz>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 17 Sep 2026 23:23:49 -0400
X-Gm-Features: AcwNN1UbbvzheDkuAbTIJB-wv3-UyGyD0BDcZCvagFWxgsOb2LvxtBfe6D-Qesg
Message-ID: <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by default
To: Petr Mladek <pmladek@suse.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org, 
	Joel Granados <joel.granados@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, John Ogness <john.ogness@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>, 
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a5c882065bb96e86"

--000000000000a5c882065bb96e86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 5:07=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> Adding Guilherme G. Piccoli into Cc.
>
> On Tue 2026-09-08 14:07:16, Zack Rusin wrote:
> > The core panic path enters a loaded crash kernel before running kmsg
> > dumpers, so the VMware logger cannot preserve the panic in the host log=
.
> > Set crash_kexec_post_notifiers during VMware platform setup. setup_arch=
()
> > runs before ordinary core parameters are parsed, so an explicit
> > crash_kexec_post_notifiers=3D0 still overrides this default. The 0644
> > parameter also remains writable at runtime.
> >
> > VMware exposes no capability bit for this behavior, so the default chan=
ges
> > for every VMware guest. Running the logger first adds work to the panic
> > path and can reduce kdump reliability.
>
> AFAIK, the quality of the notifiers is varying. Running all notifiers
> might reduce the kdump reliability even more.
>
> I do not like much the hack with crash_kexec_post_notifiers. It is
> an all or nothing option.
>
> Also it was introduced as a quick hack so that users could decide
> what is more important for them. But it is not longer a "user"
> decision when some platforms enforce the ordering because they
> depend on the notifier.
>
> panic() is problematic and it is about compromises. And we need
> to balance what is important, what is safe, and what is optional.
> This is why I suggested to introduce more notifiers some time ago,
> see https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp@alley/
>
> Guillermo implemented this, see
> https://lore.kernel.org/all/20220427224924.592546-1-gpiccoli@igalia.com/
> But it has stalled because it touched too many subsystems and it was
> hard to get an agreement.
>
> Maybe, we should start with something simple, and introduce
> one more panic notifier as a start. It might be called either:
>
>   + "panic_hypervisor_list" because "crash_kexec_post_notifiers =3D true"
>     seems to be primary set on hypervisors.
>
> But I would rather make it more generic and call it
>
>   + panic_pre_crash_kexec or panic_pre_kdump because there might be
>     more notifiers which are either 100% safe and useful or are worth
>     the risk before calling crash dump.
>
> We could put there x86/vmware notifiers as a start. And we could later
> move there other important notifiers.
>
> How does that sound, please?

afaict that sounds good. Keeping it to one new list and one client
should make it manageable to review (which is my biggest worry :) ).

As so the implementation: I'll drop VMware's
crash_kexec_post_notifiers default and start with one generic
panic_pre_kdump_list, with only the VMware log sender on it. The
structured crash-report hypercall (REPORTGUESTCRASH) can terminate the
VM, so it stays late and remains suppressed when a crash kernel is
loaded. Log transfer is still controlled by
kernel.vmware_record_panic_msg, with encrypted guests defaulting to
off.

I think that without that default though, x86 oops_end() can enter
crash_kexec(regs) before reaching panic(), for example with
panic_on_oops=3D1. To cover that path too, I'd call the chain from
__crash_kexec() after the image check and register capture, under the
existing kexec lock. A second call in vpanic(), immediately before
kmsg_dump_desc(), would cover the fallback path. And I think a
set-once guard would prevent duplicate or recursive dispatch.

That leaves CPU-stop and ordinary notifier ordering unchanged. The
logger would read the kmsg buffer directly, without invoking the other
dumpers, and would need to tolerate NMI context and other CPUs still
running. I'll keep the crash-core call in a separate patch for kdump
review, leaving other clients for follow-ups.

Does that sound good to you?

z

--000000000000a5c882065bb96e86
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIP6m
uYCiia3ORHyqPmaSAdKPjfLBQQ4P4lHomezD1Dh3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkxODAzMjQwM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIJoiqN+pGBweUn+Tw/Bk02/2LuL0p2H5SVE0c/c
RackBtK7eGpsWfY80ejZOxPsrOcCSNd/PwPLAHfTDFrBV4eeRsKSIvXnYo9Rd/s/WXtvfnj7aksD
arOk+coO3+mc6qBHRSeQ6/JJJOxBkavp6QdrvJVDF9/hryFuMHaIZEOC/Jg6b8zCMv696KHqI2LH
Gsw5+z4jBn/co22kaB8CqYvlWWSzvqpHK6QJp9ZHtGfVqoROyKfvWGMv02z54jwmscT6p60Ru2IY
XN1CMthKyOmV+cLZzJv5XVGDiy0i7AoAH+aGU8BWVmKulTEcWBlUd8zX/E1WsuK+yNMAGGEGDcU=
--000000000000a5c882065bb96e86--
