Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F21C84A3
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992268; cv=none; b=XPgNXaq7J1sc1/qHOdXtMocHv9TmsOg2bEsM62JfXzc+h/HRFc/pH1bzytRM/ga/6whBpEK7OSAsBOS/2vjCjuVKRNWHX4ETEDemtQrF9QHyikXbUVyjQRwr0007Z8GPul5Phz8vzca5uuA2n/i9uwN4wbHtebQFUrN/C1XRVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992268; c=relaxed/simple;
	bh=wdIRuME0zncj+f5DDnbpfsgAtBRUsGNlNduoYO4D52A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH9AEYhk0avF7c+D/7Mnt7ocM7s7S9UvVrTLJP67YpWlBEC5NKU0xPOt2f627ex5h9eApNDGE4D1uqZhPLoJPXhf688aB9l0c2ofbHn/XS4hRxeQIsPhyAiAV8nNkJeydS8djUtsRp8NlFBjOkvKHU/akWIuV/GX6HGINpKpQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYPqQm5y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYPqQm5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6cKGbPa/biSuO145jPh4hCTdr0hLEmlrBu7Lv96WI4=;
	b=JYPqQm5yJFcyx2NsMQtTH05bsMidcIVDHUaCSetmN5Gqu/kGGnjhtBVC8MlXZljpQuXsJN
	lLHyhtRaGUSCE8kOLAE9T0obKo/gRZkl29/I6TSzVgXn48h+4HjEgfQ9j2wDz4YUl8NhA4
	duTt2Aic/7F4Sbi2PlAY2PTzRrerD7k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-JEwgvHUmMja3dCHMYmSsMQ-1; Wed, 26 Mar 2025 08:31:04 -0400
X-MC-Unique: JEwgvHUmMja3dCHMYmSsMQ-1
X-Mimecast-MFC-AGG-ID: JEwgvHUmMja3dCHMYmSsMQ_1742992264
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so12659456a91.2
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992264; x=1743597064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6cKGbPa/biSuO145jPh4hCTdr0hLEmlrBu7Lv96WI4=;
        b=Lio6Z9W/ZirsdGAIycARoPpzQ3ROL29ZRXBlyjRZ434V7gbytTMs+h9nz/xkvDsgRH
         SSGKbZ+q/3oiakwPbrQSEPWx7owGu8IgqDzDesd2KbH4ow8X4GYmJjj0VMBDzcK6QCha
         uVuTjhdIsp2Kah4Cq6oAyAkt1MP9GNsD+20Zmr+i5tqt90roEJjMc58kWmrJXeeiv6VH
         VHG6XGJH6HrUZXslPFpohSnZRxlOFlCJMoO5VJc+iest10pj00m2xBb56ZAUV831b5Q4
         2jVxk94/gVa4v6hoU+8v3ZPlUPE3lIGfbQgJEe2oQdnblwD9zDRTmWFbK2wTPtL/11qr
         OjUg==
X-Forwarded-Encrypted: i=1; AJvYcCXNfg7IMNDXmPy1JsGJu895E85zawtaWyKrKx9JkHDwQKwhMcyV6achEGwFKeo1XNG5DqH0c+JOn+2iTc1XzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YztjnnKZ1Ir9dwS9JLq4qlmheOY/I+nMJZ9SLSvP7wReLNOALRj
	LkN5DwdMDyO0LTcOWRlc5VNh8ELht4iXNbv3jevUV9hdatXba8e8xde5AR2+ejtXbZY1w4rSdRz
	YJBHQ4OR1f/2x8BtjosC38ksenNsHDUut4PYOknUpk44TB0vu7jbVTrZVLeGV5PjW+tm+fti4hq
	CaAs21DMBzRXy/A7vxRYj3JX1/O1BT0yti7K6e8yQ=
X-Gm-Gg: ASbGncug8BHjiUJL7aeM05i4IJxZpNAsV9XCBAYt2MHPlxSlst24pzWVmp3hGF1VglC
	JmzogTVpri8wgjc+jaNlnJUsrboPPlrS0KrvtnzLb0nuJKTbwSPeBDKlbyTk+ddDpo9SeT48=
X-Received: by 2002:a17:90b:35c4:b0:2ee:b6c5:1def with SMTP id 98e67ed59e1d1-3030fe75747mr29582014a91.8.1742992263682;
        Wed, 26 Mar 2025 05:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3CZe85e3cPBUO+wooyUMtF8xON86OsS/QFoXGWXEmTS/eeT7lhZDqKxtKdQFEkvTv0OsgxqaCGbus0LAxjDc=
X-Received: by 2002:a17:90b:35c4:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-3030fe75747mr29581970a91.8.1742992263103; Wed, 26 Mar 2025
 05:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-9-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-9-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:30:26 +0100
X-Gm-Features: AQ5f1JrnjKIStDl8FKrj2WhOboQ6WN9lC9kQj540Si_DlDA1zSNpcLXHxuohnSk
Message-ID: <CAJaqyWfe5HRvCq7-JzprVD=DGef-HM2H0opFx6JWMngYfZUvdg@mail.gmail.com>
Subject: Re: [PATCH 08/19] virtio_ring: switch to use vring_virtqueue for
 enable_cb_prepare variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q_jbH1yL8SNXhw49r6zW0y-xMWZ3srAw9IfUIMj4tp0_1742992264
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Those variants are used internally so let's switch to use
> vring_virtqueue as parameter to be consistent with other internal
> virtqueue helpers.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 3fab40648c75..a414e66915d9 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -893,9 +893,8 @@ static void virtqueue_disable_cb_split(struct virtque=
ue *_vq)
>         }
>  }
>
> -static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *=
_vq)
> +static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtq=
ueue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 last_used_idx;
>
>         START_USE(vq);
> @@ -909,10 +908,10 @@ static unsigned int virtqueue_enable_cb_prepare_spl=
it(struct virtqueue *_vq)
>                 vq->split.avail_flags_shadow &=3D ~VRING_AVAIL_F_NO_INTER=
RUPT;
>                 if (!vq->event)
>                         vq->split.vring.avail->flags =3D
> -                               cpu_to_virtio16(_vq->vdev,
> +                               cpu_to_virtio16(vq->vq.vdev,
>                                                 vq->split.avail_flags_sha=
dow);
>         }
> -       vring_used_event(&vq->split.vring) =3D cpu_to_virtio16(_vq->vdev,
> +       vring_used_event(&vq->split.vring) =3D cpu_to_virtio16(vq->vq.vde=
v,
>                         last_used_idx =3D vq->last_used_idx);
>         END_USE(vq);
>         return last_used_idx;
> @@ -1807,10 +1806,8 @@ static void virtqueue_disable_cb_packed(struct vir=
tqueue *_vq)
>         }
>  }
>
> -static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue =
*_vq)
> +static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virt=
queue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
>         START_USE(vq);
>
>         /*
> @@ -2568,8 +2565,8 @@ unsigned int virtqueue_enable_cb_prepare(struct vir=
tqueue *_vq)
>         if (vq->event_triggered)
>                 vq->event_triggered =3D false;
>
> -       return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) =
:
> -                                virtqueue_enable_cb_prepare_split(_vq);
> +       return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> +                                virtqueue_enable_cb_prepare_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>
> --
> 2.42.0
>

