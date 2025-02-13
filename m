Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF09245AF6
	for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475140; cv=none; b=jF+B6EwY18byOFHg4H92dWseWwAT+D4vhGwD3eM+anNyeWgZyIWwAvjGZOwR1WeHARBXcuOWM3kBiZMJFDyOcKWlO3n5jCgw3Un+XIRN9ljOFjc2bPQTaFbPB8TZRfqTfSZ53I2Hf9iuIIwVMMA5VF69o15HYqz5X/nj8AWdxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475140; c=relaxed/simple;
	bh=vN3xU5PUlBtz0G8Jkp9LPRqLUaC4SYRlG+96xxoP57k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avW77CTWkut8csn34gyKAIaZT57PHdnD7vdO9Fyv4DkND3FC+Qz8kcePUlftqG/TadVUsskNWk0+lRDcxUo/WGDDDHXO+tgySeh8L9+QXJkpSjhXJQSyyyUNR4J7zBX8PQ7RHHlYtVINtxStGmDkeIxYCjU91uBNZYy72itpGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OuqIdIXg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OuqIdIXg"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9f90103bbso277777a91.3
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 11:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739475138; x=1740079938; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHPT8j19eeATQvpAXIQ4iMz+8wtwWzqZEPxJSsWFp70=;
        b=OuqIdIXgETHfzRvdl3Uvou96BLMv0XUKapQW9g28F8c0yt2P1pFrpgvOj4JYM6R0HN
         gcr+XWAf6wodF7Apf9laq02LJFhDuSVwkxvLWtFG9NdX5zyuktKJ3l8jENzJF/1/hp/p
         8IcPswsaecpQLnpxS7J9v+3WE8YpAVUJDuoWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739475138; x=1740079938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHPT8j19eeATQvpAXIQ4iMz+8wtwWzqZEPxJSsWFp70=;
        b=AGN5bV94ASIVWK1xiaAN+j6MGMe5B/SfJUgSXUQ/cgGS2j/YO74UqvrtYovLqMAimB
         VvmeyUCAENX57lY56yjfBcpOQpEFo5pTEZO3DuBKNltS2B11BptePy0QWDvAV1a9f4EW
         tEH7qQDz+4tRnE2J/Dgdk5W/LiE3cBum9fMfpG810mGLAOCtY5pHdYrUu/uQ5ETriFj7
         FGoKEP+VC14f1jM809MV5FjMqLBdv5xwYay0ARIOJbW6d+VF524hxlgckFxPIl5gpiCS
         bX7Qcq3cQnfz7zVbU10xtv33TVIyIKtkCIb2nyKSCBNzWxL6LNONanhMfIrFxcUxbgge
         j/Og==
X-Forwarded-Encrypted: i=1; AJvYcCXncdqk63BzD7siIYyVG/8DxocOhjRC1Aj01+HtfDYC98lBXrSzTyaBAgmCkXKdOPmCgZokWiqlMvQcnI5FDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaR2EEMhnoydimcyA16KbVwMBzziG6qNMd1d0ww1e600xc/Hj1
	tJ07OmpFbPTt/jErc9xHtyyXvM8DJyfVvcHTczynevEh6Sw60j5WthnhdqMCYsgzwUTGuMhLQpf
	Gjw==
X-Gm-Gg: ASbGncvA2+RjYYDLPiTdo8/PW/vzMjCY2uMdN4zR/mFxpjzD/u299sh1grZVeM+c8f/
	SIMQbFxeTil/3hl9kVwrXZQwtJAT6yCbyQh4SCsw/5N07B5eU35RL3qy3if++4pFfYxVkx3e0Wl
	QDs3aUIhIpknp/FnqI7JIigQP2VHf2NgUMz3iMkpneDvIgTJ8qvU2Ugd/EQ8LvCmPAsT1kvvBhM
	5cZ01TL5kR/aE8bMx7BDNwcUs+fRmGznMwqEPTjIsxVB0KCs+p2UVq1A4Bmebw8uwbVgYOWHXiR
	6/xP4h/e9t/+GecVBp/ShWbo7FjSkEPlN7ADO0/mooWAJ13Jotxx59Q31NY=
X-Google-Smtp-Source: AGHT+IEmk5kGzePACdWIsq8q71rNlVH/gyIRKNPzZsNerrdCk4radEuuhuJJMRgd2/AkzEFu/vEwRA==
X-Received: by 2002:a05:6a00:1944:b0:72a:83e4:42e2 with SMTP id d2e1a72fcca58-7324f56e6e1mr75350b3a.2.1739475137830;
        Thu, 13 Feb 2025 11:32:17 -0800 (PST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5e0cfsm1545789a12.15.2025.02.13.11.32.15
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:32:16 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c8eb195aso23997305ad.0
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 11:32:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPAkbX7HDMZ3PHNom9silD1rfRE3ZZ5EKqwgzNlmKkaTvqpzPy8nN5FX28oMFcNGQP2WJpVWo/q52ZpuX1+w==@lists.linux.dev
X-Received: by 2002:a17:902:da92:b0:21b:b3c9:38ff with SMTP id
 d9443c01a7336-220bbc5a245mr127466175ad.37.1739475134479; Thu, 13 Feb 2025
 11:32:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
 <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com> <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
In-Reply-To: <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Thu, 13 Feb 2025 11:31:47 -0800
X-Gmail-Original-Message-ID: <CABVzXAkFPr-GiALnk2v53CzX0b5Y0yG=KoRoOFR7fy98Xeyb3w@mail.gmail.com>
X-Gm-Features: AWEUYZk5k0yVhKRl6x_CJTphuuoRNXkv7QK8mgqxAE6j9hp4qpFVaj_QTvwQhdQ
Message-ID: <CABVzXAkFPr-GiALnk2v53CzX0b5Y0yG=KoRoOFR7fy98Xeyb3w@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] virtio-pci: extend virtio_pci_cap to hold page_size
To: Sergio Lopez <slp@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 11:22=E2=80=AFAM Daniel Verkamp <dverkamp@chromium.=
org> wrote:
>
> On Thu, Feb 13, 2025 at 7:54=E2=80=AFAM Sergio Lopez <slp@redhat.com> wro=
te:
> >
> > Turn the 16 bit padding into a page_size field to allow the device to
> > pass its required page size with format PAGE_SIZE >> 12.
> >
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci_modern.c | 29 +++++++++++++++++++++++++----
> >  include/uapi/linux/virtio_pci.h    |  2 +-
> >  2 files changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio=
_pci_modern.c
> > index 79616ce5057bf3b2b88cae7e8fb7729efa9dd632..26e9cd5148c0f10209c34d1=
2e65d64490a855d75 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> [...]
> > +               if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE)) {
> > +                       pci_read_config_word(dev, pos + offsetof(struct=
 virtio_pci_cap,
> > +                                                                page_s=
ize), &res_psize);
> > +                       if (!res_psize) {
> > +                               dev_err(&dev->dev, "%s: shm cap with in=
valid page size on "
> > +                                       "a device with VIRTIO_F_SHM_PAG=
E_SIZE feature\n",
> > +                                       __func__);
>
> Maybe this should also constrain the page size to be a power of 2?
>
> [...]
> > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virti=
o_pci.h
> > index 8549d4571257142ac6c9dad5c01369923791a85a..fb0ccb7a125d8178c1f7833=
3c4d2f43540e1764b 100644
> > --- a/include/uapi/linux/virtio_pci.h
> > +++ b/include/uapi/linux/virtio_pci.h
> > @@ -127,7 +127,7 @@ struct virtio_pci_cap {
> >         __u8 cfg_type;          /* Identifies the structure. */
> >         __u8 bar;               /* Where to find it. */
> >         __u8 id;                /* Multiple capabilities of the same ty=
pe */
> > -       __u8 padding[2];        /* Pad to full dword. */
> > +       __u16 page_size;        /* Device page size (PAGE_SIZE >> 12). =
*/
>
> This comment should probably clarify that the page_size field is only
> valid when cfg_type is VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, assuming
> that's the case. Or should the device be expected to provide the
> page_size for all capabilities regardless of type?
>
> It seems like the name should also ideally make it clearer that this
> is page_size/4096 rather than the actual page size to avoid confusing
> device implementers.

Alternatively, this could be represented as a single u8 page_shift,
where page_size =3D 1 << (page_shift + 12), and then existing devices
would "just work" (assuming they filled the padding with 0). It is
probably still a good idea to guard it with a feature bit, though, so
it doesn't really make that much difference.

Thanks,
-- Daniel
