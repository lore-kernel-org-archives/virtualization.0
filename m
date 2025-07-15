Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E01A1DF98D
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603372; cv=none; b=bEmKeJZ20RCZVCKRuF+AxpRR6EVXqm/ZoVlriWqr3is0bhfmLB3GDp42LkCWuy9s/i9soCycTdSUDVlcXU2CveEZxifSx79HuBMqgG3Onka4MXmfLNJyQwUtQLXSIY3vi0PzJChO4sJsVb0IwOL00Y2e63ApC2TX72OIEc1DFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603372; c=relaxed/simple;
	bh=KF1P8H9pio5hdPq64Wd+l6dMdiVE/cxrI0h/tw+6hc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/V6IP+jaw7lgsKmZOqhCRXGBPtdOp5ccd9HTbcSJlqtPsYIYjlwrPxeRMnhzdzvwTioHygeCvLtS3XjcNsWeSD2Q0k/W+5fn6Eg95YIBGDPfM3XSrxRPFf9OPwm/eEGVPFxc/krIYnrSGg+Y0bXDI6POc6lwqimxhTVeuQ8PtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dFmD/JAS; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dFmD/JAS"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70f94fe1e40so1791607b3.1
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752603370; x=1753208170; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=980SBgdyOTTJkeZe3fmC67fmalDmS6qvEGzK0fgCj7I=;
        b=dFmD/JASz+nycUQ3qxdzsDQmj3nKmbrXmq96bEfDOyDnDSS48z0SfqwwUCZB72Yh8H
         ZrCqDHmGHARZneMDxrYuldG+44sKkRXXWzxa5JHpYO2eZ5XluPVe1vKzhVJf909vGQEb
         63O0DjFQCgdlJuFW/oEC7MzlPTSJn9NJeXmHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752603370; x=1753208170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=980SBgdyOTTJkeZe3fmC67fmalDmS6qvEGzK0fgCj7I=;
        b=WNXzb4ok4NQ18T9aKtv7qY8no7x7sDEdJXf5/VHPn6uO/WTmqolBNR+KxR37L8Puwk
         TLceIucvXIyXL4cygbWqarMHyzy+R4cpTs2FwbTPPddC7Km48KKUqxCeVp3h01mL8hhs
         gX8laaLb1MWVKcfL6E2HRD3gTELJ89xOFeRquXeR7g78GgqUF+wYJ5hQGhMO3qVb/Khk
         mFJR2D546CrX2wq7hkCnBKfxhsNnLg/bR0g8QnpVnT/6DBTBmQrMJAxsxX0o8z2B1zLh
         DCM6cpRz1FkjhsmfoLM3svy6CWDP5q46n7HnTbFtcYSasOkTW5Q5Jjq46g5mBSnLNYmW
         S71A==
X-Forwarded-Encrypted: i=1; AJvYcCXaPvYX6VdcsolOmadBwlBNlrruhtdvvbFrqXtTpBMCftZnLn7XcetgMFFjJJqK5MM2aRASFpaAqRLF/Xf0bg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9PpM97Ls4WiofbYQjv4MPGYYt+W9bsScYim7t+9bBy51ap3mz
	EmN9Q+s9KDyEEQosrtVuxFQwfKw8/Nohhh6vENhaTWRwnVYkSKgmosIrrvS9PYu0N6E9vl6zotg
	9fjJfOc/338GJnXZ6jWAm0ZTXAaaQuzXwF054awsd
X-Gm-Gg: ASbGncthoffh+gT2n4rvKc5F6C8REllx8wsg14nAWTh6a9WIKvwnZz47kI40CX48z4l
	tKI4qjpwBsO0RLcbx8/uII2JfTnMsNa0SiRTJR28K4zcZQmIa/PuRe+8F0Skrq2L/lYzWUq0cqv
	Rh4jK4DE68zNwrEA8Rt9WBtomU1Npoz+GdoPJt3lQsAQRiYkMUW5X3+MUbz56lInjFaeA0QpISZ
	Zf3jxSkDZLBx8Gj3n8=
X-Google-Smtp-Source: AGHT+IH18HIzDfiAUMtuCYdRmgoCqftHm0U2aeiTXjCkRgmxVFuZ5mWpVYYUMHrwJ2Oq+BhQ8JmA0/msgew5ZSA4pKc=
X-Received: by 2002:a05:690c:b91:b0:70e:7f7f:cfda with SMTP id
 00721157ae682-718350314d1mr3060677b3.10.1752603370280; Tue, 15 Jul 2025
 11:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250715155934.150656-1-tzimmermann@suse.de>
In-Reply-To: <20250715155934.150656-1-tzimmermann@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 15 Jul 2025 14:15:59 -0400
X-Gm-Features: Ac12FXxKEg1ugAQfc0kfIJatq4gdtnJJzB--PAhTyzI-iXu_KNJDMhlPIG8plIQ
Message-ID: <CABQX2QNJ_Yd9h_L3iNhtFx2QZ8SiZQus3anNJ2d5OGOBz3ywHA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] drm: Revert general use of struct drm_gem_object.dma_buf
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, christian.koenig@amd.com, 
	torvalds@linux-foundation.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk, 
	kraxel@redhat.com, christian.gmeiner@gmail.com, dmitry.osipenko@collabora.com, 
	gurchetansingh@chromium.org, olvaffe@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, virtualization@lists.linux.dev, 
	intel-gfx@lists.freedesktop.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005665100639fbc5e7"

--0000000000005665100639fbc5e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 12:02=E2=80=AFPM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Revert the use of drm_gem_object.dma_buf back to .import_attach->dmabuf
> in the affected places. Separates references to imported and exported DMA
> bufs within a GEM object; as before.
>
> The dma_buf field in struct drm_gem_object is not stable over the object
> instance's lifetime. The field becomes NULL when user space releases the
> final GEM handle on the buffer object. This resulted in a NULL-pointer
> deref.
>
> Workarounds in commit 5307dce878d4 ("drm/gem: Acquire references on GEM
> handles for framebuffers") and commit f6bfc9afc751 ("drm/framebuffer:
> Acquire internal references on GEM handles") only solved the problem
> partially. They especially don't work for buffer objects without a DRM
> framebuffer associated.
>
> v3:
> - cc stable where necessary
> v2:
> - extended commit messages (Sima)
> - drop the GEM-handle changes to be resolved separately
>
> Thomas Zimmermann (7):
>   Revert "drm/virtio: Use dma_buf from GEM object instance"
>   Revert "drm/vmwgfx: Use dma_buf from GEM object instance"
>   Revert "drm/etnaviv: Use dma_buf from GEM object instance"
>   Revert "drm/prime: Use dma_buf from GEM object instance"
>   Revert "drm/gem-framebuffer: Use dma_buf from GEM object instance"
>   Revert "drm/gem-shmem: Use dma_buf from GEM object instance"
>   Revert "drm/gem-dma: Use dma_buf from GEM object instance"
>
>  drivers/gpu/drm/drm_gem_dma_helper.c         | 2 +-
>  drivers/gpu/drm/drm_gem_framebuffer_helper.c | 8 ++++++--
>  drivers/gpu/drm/drm_gem_shmem_helper.c       | 4 ++--
>  drivers/gpu/drm/drm_prime.c                  | 8 +++++++-
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c  | 4 ++--
>  drivers/gpu/drm/virtio/virtgpu_prime.c       | 5 +++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c          | 6 +++---
>  7 files changed, 24 insertions(+), 13 deletions(-)
>
> --

Thanks for taking care of this.

Acked-by: Zack Rusin <zack.rusin@broadcom.com>

z

--0000000000005665100639fbc5e7
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBcG
ACp2vnr6+UOvAvSF8xGC/jbk5OWkJiWFwUiMKYumMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MDcxNTE4MTYxMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABd4T/163I7Q38CBtt30fgpIbMKckSIiwax+niIb
hkRD7c5WGqU2ljZv3Rm7ypZD0NXEFWqcnxdCueeeUbOic2pmfiRFcAEl+ZJnC1qQjAYLAP4zy5sR
4hr0K+ae2g3zeeXKJZ72jgUAeuTYI69R08b6T95BAX7KakZ0gqalgoYx6jcw+NGxm0z7UaHjK98G
pltqcBeKtSo5r01N9e8XiNfmyDKxsw1bFdeWhEznsA7e6hlhrZAXpZ2d39OLZar9DSinqh21k+0c
9m3WS9amejtpA+LwEeGr8OTyys40dIpbq/DBmKONNl1+17xEJTPfElLyeKSuu7+ya0qV0V2M8IU=
--0000000000005665100639fbc5e7--
