Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554B2391BC
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386655; cv=none; b=Uji1/oZLVD4UDdoU/JlAjLR85JDjjHKORGxN401alAoIy4zSZRdNHYgkGvIe7CM3GRwwEPSyspJPPx3txNTg6z5HnSAiJQ5g4Mg6csdxdBBSG/eZwwE2ELFARUHpQNBS8hYMJ+ZodapvOzLWd5Ph5jZZaURjPaH2GxLIsq9wzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386655; c=relaxed/simple;
	bh=NOarGEiLW7uDcB7mgflbJdS9uElAnfk9lmUyOixETEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjYAjvQ2z+8UzVWxoitoXURaYPd2WsBnWLs6+4VPsfM1neqegI6DJR9opMhjagEi1tYVEVwWw0C2KO0ThRBBS4WDeDf38GibMuvL+6VkdvopPsMyMCunCBCWTVedrli9vqcWodIITCRrqqAELBg0a0YjzDfNl+qRS71NDq8VWvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONF8OYgp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONF8OYgp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733386651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbYp5fuTMDGZJg47KgQS7zrO6fL9YebjB31M2vYEM5Q=;
	b=ONF8OYgpvsi2lo200jooyHGU5IYMhTGQcmcFZLXF/dr/d2HgrMhzQiTkV8W0/qgTjGWHaK
	Ntl+nK746xFyjjySiwJmEAH7SPVLSudINYin+78g7ES7lnrHQ7f6uWjYJEYtj6Roi9NzNK
	yy0D87mNR9QEkMcobqkr9h6Lh2C0aPY=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-MdEt3PBcOIuRvTcgKENwQg-1; Thu, 05 Dec 2024 03:17:30 -0500
X-MC-Unique: MdEt3PBcOIuRvTcgKENwQg-1
X-Mimecast-MFC-AGG-ID: MdEt3PBcOIuRvTcgKENwQg
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4afaabf65dbso38225137.3
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 00:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733386650; x=1733991450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbYp5fuTMDGZJg47KgQS7zrO6fL9YebjB31M2vYEM5Q=;
        b=wm0h1r5xVZV7p20MAYkcvFwFA82auWcKRy+NWZLFPoBKQW8MJdt++e3sbPvkhsyDyP
         zWLKvGNhTGq8ss/qBvG5hVsUNd8PAGwYy6hl11IQKYvJj7HHhXHrrcBh0SPFwgZqfCMX
         vD0YIfvJEV4xDkVXH8obfiQTWf4Jo0AQFR0u5iYecYENBU5WD4/2X6vLoiu/ZJy96Tx4
         xYqcYJ5CK3fUxZW+qjCEP756C9hSCt0uydo0owddNASwjIVbxuAV5m6wOeS7v+B+lIJJ
         9L1WgDPmRak4O1tPLHxrr/kLN24XcmtMHHsCUHij6TTRHOHAtcygeQfmjHPYg9tJ2N9+
         Uhxg==
X-Forwarded-Encrypted: i=1; AJvYcCUWFsGt4Ky5NbCE+e6GOC/I2bSruFskNy80y+gQKC+jiyyy1v+8ezlJA35PfnNc2UqrjPz+ppjbvUL3iC6kdw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzrdzs2GjcnPUkCSksHKDN5mj+zJanQ18RrQUc394bqapzECu6Q
	itlx+VHrTsw8ip4jcxKHFq11E2T3mLBnGphTMTneejuZDR3hpGf53pmPz39ijnhXltGo2euSAW8
	uBWvg85B5OtNkoJHpNyP9bCFkP/no6VvL3nHI1CsixqhBYEoh3QExtRUVOTUSeV0QPF87IpNjBe
	0zAtqvq5UL7Xst7kcrJCUThsE4C73HkavbwW6oYXw=
X-Gm-Gg: ASbGncuxuQz7A5oF8GX4Srq7x6lcOAEJZoquXLnTThGksj8vz7jHxlExp5WzbbQ5F+g
	uCByqtxMA2QNEgcbdvSS2Sk/kYFE+A9n7
X-Received: by 2002:a05:6102:38c8:b0:4af:b546:528 with SMTP id ada2fe7eead31-4afb5460870mr4447448137.10.1733386649951;
        Thu, 05 Dec 2024 00:17:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdo6QymRNsZnTJgOtBqEiCYB5DVr2hSvWwg+hYaJRaORCrLdYXdoathgCL2+dUKRKmi+r4t26vvmd0ZKaf8uM=
X-Received: by 2002:a05:6102:38c8:b0:4af:b546:528 with SMTP id
 ada2fe7eead31-4afb5460870mr4447439137.10.1733386649543; Thu, 05 Dec 2024
 00:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com>
In-Reply-To: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 16:17:16 +0800
Message-ID: <CACGkMEtPs5O25KVxN3UJX8RD5f0EhNqrqdVqt28FZSMX_W6GTg@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH 0/1] Virtio-loopback: a virtio based HAL
 for non-virtualized environments
To: t.ampelikiotis@virtualopensystems.com
Cc: virtio-dev@lists.oasis-open.org, anna@virtualopensystems.com, 
	a.rigo@virtualopensystems.com, m.paolino@virtualopensystems.com, 
	s.raho@virtualopensystems.com, chou.kensou@jp.panasonic.com, 
	wminer@linuxfoundation.org, jsmoeller@linuxfoundation.org, 
	virtualization@lists.linux.dev, stefanha@redhat.com, 
	xuanzhuo@linux.alibaba.com, sgarzare@redhat.com, 
	eperezma <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I7nmuqsMOlyB9myGCiFjJMQL3-jzqtl3DbmT3gJMPDk_1733386650
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Eugenio and YongJi.

On Wed, Dec 4, 2024 at 11:38=E2=80=AFPM <t.ampelikiotis@virtualopensystems.=
com> wrote:
>
> From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
>
> We would like to share with you an RFC for the Virtio-loopback
> technology which we have been working on at Virtual Open Systems in
> the context of the Automotive Grade Linux community (Software defined
> Vehicles expert group)
>
> We previously presented this activity (see [1]) and now we come back
> to you with latest development and updates.
>
> We believe that the technology is more mature today and we would like
> to assess the community interest in the technology itself and in
> merging the code.
>
> Below we provide a brief description of the technology, recent
> updates and a short comparison with vDUSE that might be seen as a
> similar technology.
>
> 1. Overview:
> -------
>
> Virtio-loopback is a hardware abstraction layer (HAL) designed for
> non-virtualized environments based on virtio. The main objective is
> to enable applications communication with vhost-user devices in a
> non-virtualized environment.
>
> More in details, Virtio-loopback architecture consists of a new
> transport (Virtio-loopback), a user-space application (Adapter) and
> the vhost-user devices.
>
> The data path has been implemented using the "zero-copy" principle,

This need more clarification, for example, how could we prevent
malicious usersapce device from modifying kernel pages etc. Especially
consider not all buffer occupy full pages.

Actually, after chatting with Yong Ji, I've played with a zerocopy POC
for VDUSE, but it tries to do zerocopy only for page aligned buffer:

https://github.com/jasowang/net/tree/vduse-zerocopy

The idea is to map the page directly to the userspace if the buffer
occupies a full page and usersapce is expected to recycle the page via
MADV_DONTNEED. It's far from mature but it can demonstrate the idea
somehow.

> where vhost-user devices access virtqueues directly in the kernel
> space.

Eugenio used to work on a POC to bridge vhost-user to vDPA via a
dedicated userspace application. He might share more thoughts about
this.

> The technology does not require any changes to virtio protocol
> and vhost-user library.
>
> The architecture supports vhost-user-rng, input, blk, gpio, can,
> sound and console devices. Early support has been provided also for
> vhost-user-vsock, i2c and scsi.

One important reason why we do device whitelist or feature blacklist
for VDUSE is for security.

For example, we should not allow the userspace device to do DOS to
kernel by not responding to

1) config space write (we disable WCE for block)

or

2) any control virtqueue commands (we disable control vq for net).

This needs to be explained here as well.

>
> 2. Updates:
> -------
>
> Since the last time virtio-loopback was introduced [1], we implemented
> the following updates:
> - Multi-device support:
>   - The driver can handle multiple instances of virtio-devices and
>     connects them with multiple different instances of the vhost-user
>     devices though one or many instances of the adapter application.
>
> - Update the memory mapping mechanism (zero copy mechanism between
>   virtio and vhost-user devices):
>   - The technology implements a page-fault mechanism which enables
>     the vhost-user devices to access the vrings buffer located in the
>     kernel.
>
> - Update the notification mechanism:
>   - Notification can be delivered from the virtio-driver directly to
>     the vhost-user-device (by-passing the adapter application)
>
> - Add support for more devices:
>   - The technology added support for vhost-user GPIO, CAN and
>     Sound device.
>   - The architecture has become more device-agnostic and the process
>     of supporting new devices has become a trivial task for most
>     devices.
>
> 3. Virtio-loopback vs vDUSE (+ benchmarks):
> -------
>
> Virtio-loopback and vDUSE technologies serve the same purpose by
> trying to define a virtio-based HAL between application and
> user-spaces drivers.
>
> The main differences between the two technologies are:
> - Memory mapping mechanism:
>   - Virtio-loopback implements a zero-copy data sharing mechanism
>   - vDUSE implements a bouncing buffer mechanism for sharing the data
>     with the user-space.
> - Dependencies to other technologies:
>   - Virtio-loopback is a simple virtio-transport driver while vDUSE
>     is relying on vDPA as an upper layer
> - Devices supported:
>   - Virtio-loopback: virtio-blk, virtio-rng, virtio-input, virtio-can,
>     virtio-gpio, virtio-sound
>   - vDUSE: virtio-blk and virtio-net
>
> Performance wise the two technologies seems to behave very similarly
> when we measured the throughout for the virtio-block case using the
> fio tool [4].

Interesting, any reason for this? As there's a costy bounce buffer
operation done for VDUSE.

Thanks

>
> 4. More information:
> -------
>
> More information and instruction about how to test the design can be
> found in repo [5].
>
> 5. References:
> ------
>
> [1] -> https://lore.kernel.org/virtio-dev/CANN35wLsm_RTTKmxFz5jcBujoxfjPw=
su37FAw9+W58hjt_nVPQ@mail.gmail.com/
> [2] -> https://gerrit.automotivelinux.org/gerrit/admin/repos/src/virtio/v=
irtio-loopback-driver
> [3] -> https://gerrit.automotivelinux.org/gerrit/admin/repos/src/virtio/v=
irtio-loopback-adapter
> [4] -> http://www.virtualopensystems.com/en/research/scientific-contribut=
ions/virtio-loopback-perf-eval-icai2024/
> [5] -> https://gerrit.automotivelinux.org/gerrit/gitweb?p=3Dsrc/virtio/vi=
rtio-loopback-adapter.git;a=3Dblob;f=3DDocumentation/testing_virtio_loopbac=
k_design.md
>
> Thank you for taking the time to review this RFC,
> I would appreciate your feedback and suggestions for improvements.
>
> Timos Ampelikiotis (1):
>   VirtIO: Add platform bus driver for loopback virtio device
>
>  MAINTAINERS                                |  10 +
>  drivers/virtio/Kconfig                     |  20 +
>  drivers/virtio/Makefile                    |   2 +
>  drivers/virtio/virtio_loopback.c           | 780 +++++++++++++++++
>  drivers/virtio/virtio_loopback_transport.c | 924 +++++++++++++++++++++
>  include/uapi/linux/virtio_loopback.h       | 259 ++++++
>  6 files changed, 1995 insertions(+)
>  create mode 100644 drivers/virtio/virtio_loopback.c
>  create mode 100644 drivers/virtio/virtio_loopback_transport.c
>  create mode 100644 include/uapi/linux/virtio_loopback.h
>
> --
> 2.34.1
>

