Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55707388E7E
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773288238; cv=none; b=bgRH47lYwRwNkacKA4cOvkzzbx5YtyTr19CridW1MfAFxIUcLkWjctz5QCOw0C2qYSw+3SkA+XLW48OTpGBfMigJVDZX4l2JZORPuqtgjjJ8vpBreVpFItPXS3o38cVhyOqq0D0LuECEZWpSvu6dlO6x3e+wQFGCiVZtLoo9RI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773288238; c=relaxed/simple;
	bh=EOPBbMSMSB4IA9hBMVC3rb3aG77DnEnnDVUw3K7kPRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9Pz0JtJo1ZKHztLgR/T5+uTveiJZLidBJMnvU+2KRZ7Igjz5i2yYQkou3sNC13r6v/xiB7MsSRq/Nc+VSIOWHONuvE9ekZwQ0cY1gzQ6B7MtLkrGVYPrdV9gnF+bXFkT/ixrbciCNyvNli7qv8m+FtoiL5vOrfvOVygFkRDsyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfUbDfl2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfUbDfl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773288236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ek1UpcOvEfrzUPIbMS5plfWlnvHSRbFxGJXHHOh9jQ=;
	b=NfUbDfl2zONr7bRJKTZc7NSa6J4r/Uj0ZoFaCsu5Y2ht1iPHdzXmjHmt+X4gMNZ4Qq7snA
	KZ3aFanED0fErTP0I8u23FqsDJV17r11TCKlj4L3KL8THIEdIN5h0r5UN/+LiLMtogkDX/
	1+/YhWwwnZn7Mi/tIJ1vtdF60k6bNMw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-nBNrpxkQPbaKV-SrjPZPGw-1; Thu, 12 Mar 2026 00:03:53 -0400
X-MC-Unique: nBNrpxkQPbaKV-SrjPZPGw-1
X-Mimecast-MFC-AGG-ID: nBNrpxkQPbaKV-SrjPZPGw_1773288232
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35984ef203bso499196a91.3
        for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 21:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773288232; x=1773893032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ek1UpcOvEfrzUPIbMS5plfWlnvHSRbFxGJXHHOh9jQ=;
        b=xQKSlmXMRT/fzr2xuVMl6BQfJppoW7B8ehHVIcesaBWaffic/Jgv59SIVEIuN5oTC2
         y7ux+8wzGqLlDi0kzI2Gy0HXHaNFglyTb5kgxuGed9f7E4o/M8YXa2+ZTV97Dm9dNRAB
         uk+hk0TIhhprvZ1o+DqPJ2WLkgcRK51fjKtJ/2gzfgCbCmqY3db3tAbYoCDWCxMf3S1g
         HofPWZe0wA3gPz7JmQcan6jb+XmYQa6KdAO4e/LujMJtbsmBZES8x0gI9P+NGs/OSEFm
         XCWKm9DvOKXF1TEzBphwvV7wVlCD5Tp/J6P8vNk13fSQVBS8aqoqqR6VQ187DALDHIKz
         9ipg==
X-Forwarded-Encrypted: i=1; AJvYcCVKR2vBVrUl4afaMKgRapIepjVm0jZlvMQjjqMsZDPBlZqZgPYQ+EDo3hzaMY2dReRg5uBlyDCWJeCDc3zraQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9s8P6soC1IIcJxg7VkAU+Ft7PxTEcmCbPE8QR+XKmtBxdZf3T
	tNkrSrsBN8kpgJSMux1btKxN7mjFairRTqmXbK9KfkDIYz/Z/Fw5jVB9Eg3KHn3kFcqpLy2K0i2
	oA32E2EmNUAzM66jjye9MAjTKoI/zmXntOFR+yoCLoGtMVqGfAEZGkNgO1QVuiqG+nsMSqgjVAg
	p+dxgB3t5YndU1GWwMjTZ68ZGamv9MIzkdpwZS+mtdZXE=
X-Gm-Gg: ATEYQzwjr9n13qHk3CZ4cxt0dvr028r61p89Oia0SUVhWi24LcaYZLsLbLTCjfYbSNj
	Ju3HV+9/3ASSa7e19qHdf1KtxLGDpc038eTdKZ/JKcHCquuf73MRat/KQ5aNTCMWtDnqSJoGzRT
	CQQVe+QkP0Y14SGzTTGl2Xn8SaD8hQih2GXh+lWRABtmeQ6DN01CN9UTEQCKb1UEf/wc0KwYUZd
	C2TWPhM
X-Received: by 2002:a17:902:ce02:b0:2ae:b91c:1ac with SMTP id d9443c01a7336-2aeb91c0436mr22580325ad.52.1773288231927;
        Wed, 11 Mar 2026 21:03:51 -0700 (PDT)
X-Received: by 2002:a17:902:ce02:b0:2ae:b91c:1ac with SMTP id
 d9443c01a7336-2aeb91c0436mr22580155ad.52.1773288231478; Wed, 11 Mar 2026
 21:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310191019.1099757-1-eperezma@redhat.com>
In-Reply-To: <20260310191019.1099757-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Mar 2026 12:03:40 +0800
X-Gm-Features: AaiRm53Uph-HpjQCZOXcEP-eXSKwrUyscslGOBS-0lNrzWgVCctHiW-ku6wiQfY
Message-ID: <CACGkMEtAQ1HM_4P0aM2AARy7LVtjFmtzbPGOkYn4jD5KMJ+cBQ@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: Add suspend
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jPlm8uVXH7Wnc7EZytgrFee5cIvmfVx3s-WHgHrcWkg_1773288232
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:10=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Implement suspend operation for vduse devices, so vhost-vdpa will offer
> that backend feature and userspace can effectively suspend the device.
>
> This is a must before get virtqueue indexes (base) for live migration,
> since the device could modify them after userland gets them.

As discussed in the pervious version, let's explain why and the plan
to support resume.

>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> This patch depends on
> https://lore.kernel.org/lkml/20260310190759.1097506-1-eperezma@redhat.com
>
> v2:
> * Take the rwsem only before the actual kick, not in vduse_vdpa_kick_vq.
>   This assures that we're not in a critical section.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 86 +++++++++++++++++++++++++++++-
>  include/uapi/linux/vduse.h         |  4 ++
>  2 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 4f642b95a7cb..f56b1e3eb82d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -54,7 +54,8 @@
>  #define IRQ_UNBOUND -1
>
>  /* Supported VDUSE features */
> -static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY);
> +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY) |
> +                                      BIT_U64(VDUSE_F_SUSPEND);
>
>  /*
>   * VDUSE instance have not asked the vduse API version, so assume 0.
> @@ -85,6 +86,7 @@ struct vduse_virtqueue {
>         int irq_effective_cpu;
>         struct cpumask irq_affinity;
>         struct kobject kobj;
> +       struct vduse_dev *dev;
>  };
>
>  struct vduse_dev;
> @@ -134,6 +136,7 @@ struct vduse_dev {
>         int minor;
>         bool broken;
>         bool connected;
> +       bool suspended;
>         u64 api_version;
>         u64 device_features;
>         u64 driver_features;
> @@ -480,6 +483,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>
>         down_write(&dev->rwsem);
>
> +       dev->suspended =3D false;
>         dev->status =3D 0;
>         dev->driver_features =3D 0;
>         dev->generation++;
> @@ -538,6 +542,10 @@ static void vduse_vq_kick(struct vduse_virtqueue *vq=
)
>         if (!vq->ready)
>                 goto unlock;
>
> +       guard(rwsem_read)(&vq->dev->rwsem);
> +       if (vq->dev->suspended)
> +               return;

Any reason for this? E.g We don't do this for other transports.

Everything else looks good.

Thanks

