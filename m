Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60E27F170
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761364; cv=none; b=otHClDEsj+BxqkWCe5bY5Z3eYpycq+RVT2ORsVM26q7KkOSruIO+u1nzED9ZctjreRBulQFJLAPQ5oIyfLFtWFuDRH8NGO8rjpCU/b61rMzQOWQvQ4Jt6tSHVl/U9t/eoR4hxWQEt82oc97tfDMcdHBNnDTeFS6vUThTzLHmoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761364; c=relaxed/simple;
	bh=6CViWuPX00eU2i8EAuavfyf3Zqe6PhQ83HuHdPBTl2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kseKSvfWwEeYJD8SAlAnybpHSzxM2fkxyFFhrOJkyMjJXkFUAT90JyJ7HCug6CnB7W3YfuydzlmNC4DbUgx0dMMFM2cjsJeWczUKnBHPZkyuxWHsF8X14mbyC4CG1oSUp2UvZrzF/sLK1xzUqtwi/lU24b2OCGS2JrSYGm7N4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpwRZ/VL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpwRZ/VL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750761361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3LLsiuFWfA6idjZrblBAge6t85zqJ/pmKfL0AuNa2U=;
	b=BpwRZ/VL9y2ge4CfELYO/Ge7hFRAl4GGjG/FtrIVVXMOdtEV8eRRN5uWWaFUA08TNcBgme
	qBcNGz2yrLeMrQZ9h2SUv9mZXYB3p40+3yT7aiVizQSA565vz2KMiBNZP/bhWPwqiBLoPJ
	Cb6yj91i921e8HF05q7cg/fd4F482zA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-mLHZ_zWPP8KToYljYzFo7A-1; Tue, 24 Jun 2025 06:35:57 -0400
X-MC-Unique: mLHZ_zWPP8KToYljYzFo7A-1
X-Mimecast-MFC-AGG-ID: mLHZ_zWPP8KToYljYzFo7A_1750761357
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-addfe17eb89so34701466b.3
        for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 03:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750761357; x=1751366157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3LLsiuFWfA6idjZrblBAge6t85zqJ/pmKfL0AuNa2U=;
        b=HFzbLNpWoiSz9XhLxQr+s2pQ+eshBhnDfx3XlHrAQHU5BzupxVWE/GgIds50nTVl9h
         6h0JJaCAUkosGfgs0vlAvEqn92TqDwjdsTOKNls4nnsO9iwOtPQxW0KC8/x8DKVM8qRI
         Lma3E/28RTty2o/zy1QqWkioelp4aL5TBeXVwnEDtXP+6cKSFlcROsIcK08madm2Q8Ix
         5QlJb9XzzqOM4vX/3RSVJnsBAvz14ALuLLZRBp4V6HbIVSI356ml5NCy9EeJQs11Pa2G
         7l3DXTKi5rAurCNViRXJdOPuVE+95O2qkt9/EUoIXDhHZsjSNFpLPaVa+obYygiaT+IW
         RbQg==
X-Forwarded-Encrypted: i=1; AJvYcCV0fMiSf7KQsgEae99go+oww87S1/i261pW+2M3pqA6sGYi8TLjfyzZPNMWciYZqkGqtpeDSflf4MzqTlf/qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQjaopUiwSWtbQGyYSoXb9ITyn6qMX37d5Bl/iXYAqcmiN/yvZ
	0UuzZWyR8+U0lrIoHdDlm411a0DKGESBPFgtG3tWxSIsSdOt9dPLEPrDrX/RsPf8RYDynLXEtGY
	BmqXUhynfav/zwuhZLp0KQajDWBvYLAttWQPAr/aqzzBPAizu27bpzCNCGLUUE3Pj4xLkIeI4so
	sSN0KJAQJ7H2nbqiJlU9xjnjCw000Wmu+6m42mosz8T6I=
X-Gm-Gg: ASbGncs6h+ZNMGHgRfXrCZzvcofMeTxgA7vpI30Q+MMxxQ/YbYepqTOWIIHSky+1Tw1
	oeLUtJma8FC2YOQxQNdtY36yuVBbQ1bsCWyVnQq5gYY85NZ2A7sqfMXfT/je/tU2EyUD6PUyUnF
	yVUCGH
X-Received: by 2002:a17:906:6a05:b0:ace:cc7f:8abe with SMTP id a640c23a62f3a-ae057b39bdfmr1751261466b.31.1750761356630;
        Tue, 24 Jun 2025 03:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG945gyIWXiR+ffSgL3olytMGzXmaQ3MYtuPPSyPyclXoNDFXHfuOBd36+G6jQmYhGmRc0OV6LyDDHJ4f9ky0E=
X-Received: by 2002:a17:906:6a05:b0:ace:cc7f:8abe with SMTP id
 a640c23a62f3a-ae057b39bdfmr1751259566b.31.1750761356252; Tue, 24 Jun 2025
 03:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616082518.10411-1-jasowang@redhat.com> <20250616082518.10411-2-jasowang@redhat.com>
In-Reply-To: <20250616082518.10411-2-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 24 Jun 2025 18:35:18 +0800
X-Gm-Features: Ac12FXyfv18Bnl6zW9gEC4TfyPem9I0gsnQH2c14IyIgNpT2vz0N9HVKpPOYF10
Message-ID: <CAPpAL=wHn_Ak+5qNwqv6rEv=ROQPzra2nJuLD0HxOpZfjsEjVA@mail.gmail.com>
Subject: Re: [PATCH V3 01/19] virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d1GlwiX9YQZ5om9tOyOawAW4z7BdmM0h7VEXpZoJYMQ_1750761357
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I used the "virtio-net-pci,...,in_order=3Don" to test this series of
patches v3 with regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jun 16, 2025 at 4:27=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> To be consistent with virtqueue_reset().
>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b784aab66867..afdd51fc3c9c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1005,7 +1005,7 @@ static void virtqueue_vring_init_split(struct vring=
_virtqueue_split *vring_split
>         }
>  }
>
> -static void virtqueue_reinit_split(struct vring_virtqueue *vq)
> +static void virtqueue_reset_split(struct vring_virtqueue *vq)
>  {
>         int num;
>
> @@ -1248,7 +1248,7 @@ static int virtqueue_resize_split(struct virtqueue =
*_vq, u32 num)
>  err_state_extra:
>         vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
>  err:
> -       virtqueue_reinit_split(vq);
> +       virtqueue_reset_split(vq);
>         return -ENOMEM;
>  }
>
> @@ -2092,7 +2092,7 @@ static void virtqueue_vring_attach_packed(struct vr=
ing_virtqueue *vq,
>         vq->free_head =3D 0;
>  }
>
> -static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
> +static void virtqueue_reset_packed(struct vring_virtqueue *vq)
>  {
>         memset(vq->packed.vring.device, 0, vq->packed.event_size_in_bytes=
);
>         memset(vq->packed.vring.driver, 0, vq->packed.event_size_in_bytes=
);
> @@ -2219,7 +2219,7 @@ static int virtqueue_resize_packed(struct virtqueue=
 *_vq, u32 num)
>  err_state_extra:
>         vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
>  err_ring:
> -       virtqueue_reinit_packed(vq);
> +       virtqueue_reset_packed(vq);
>         return -ENOMEM;
>  }
>
> @@ -2852,9 +2852,9 @@ int virtqueue_reset(struct virtqueue *_vq,
>                 recycle_done(_vq);
>
>         if (vq->packed_ring)
> -               virtqueue_reinit_packed(vq);
> +               virtqueue_reset_packed(vq);
>         else
> -               virtqueue_reinit_split(vq);
> +               virtqueue_reset_split(vq);
>
>         return virtqueue_enable_after_reset(_vq);
>  }
> --
> 2.34.1
>
>

