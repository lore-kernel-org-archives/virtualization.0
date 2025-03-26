Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A11DF24E
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990970; cv=none; b=ZhIXHxoH85qbfkvY6DHcF+EJGGDUrJQCyisQ5HIGSgLFLhwcTxaNgZyJAI/N8ZolrtbLF2nCHF6ePMS2fG2+U7X0Xl/7CCOvGO2aPuByyRyhxDhLZ+eNogv+TdpIO80wgj76cFuQQ3gMYdot4BzB5Kbc0Giej32Rz0bDRYR3lig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990970; c=relaxed/simple;
	bh=/XWouKMbD2oQnq+am6VXLfECTMKaj5hCa9hjtsLparA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIB5hz6D/Pa+Di/hj/sgQUxxlpIiwgIv0FatUylyG7k119fvjwSl/qNXR99FXdpULqZvy/v2GVN9kDIgXtiR5yCMeao/JaEJXBSIJhew8agihwA3r50JOcaXJLhuY24wzKh+EnHJfrx4GEKaGXZkBB5NEdM07bkYy7GAdS6xSz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIifVmoS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIifVmoS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742990967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCTBGWYiVmEwl6WMzGfDrfo/qCoag28PGkVkZQCdvC0=;
	b=IIifVmoSpmXfV7/B5jmuou1I2yBDDs0JniPs1INBYJ0zm+wlnOY3IfS/OKqMclGCZSGyY5
	uug+s8t12gtNvcNjOKR8MgkrQ+wFQgs2J74lojDJZ0xU1Wiv229OBRpaUWKoFHHZLivC5B
	XCaMn8528MNXnMkQWAOJecnmcmaJBXU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-F0es5aTQOSecqS3YOu0gAg-1; Wed, 26 Mar 2025 08:09:26 -0400
X-MC-Unique: F0es5aTQOSecqS3YOu0gAg-1
X-Mimecast-MFC-AGG-ID: F0es5aTQOSecqS3YOu0gAg_1742990966
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff62f96b10so1510092a91.0
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742990965; x=1743595765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCTBGWYiVmEwl6WMzGfDrfo/qCoag28PGkVkZQCdvC0=;
        b=d6KonOKgUKNwfNpwquwIFQQ0hjMAw8rrTpqiZVr/otebQaOF1HEJ0xzsjg91Yy13Pu
         9RKHcUGdrqGpymWRfK5/2NZujIohgjJ+C4XHTaBwBoGhr8LCUZNShESS4WX7RCH/buvp
         BMkTbJm7GHzqIKxR0hXJ7AfoxCMmcUoe2wWGgygJ5MT0fkDXHYfvs5eJWEJIZ6km8Amo
         zM2ZLpxIyo9XU7YlugH/z2t4mTobvUVK+Ran3cybgi3U1lWoe56VUACy67k+I2S1mj7w
         kI82FpzcGTJra0sOi6uH0R8fKB+d6GHF/1WgMD3Kj8VrlMTy8M5lEUFCRz3zIrka9ex0
         XftQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYg6a2MtOP07p5GSQZVqTODUg+nJvJuCz0ZF1ZST+3GiZ/mkADhTb6KrRLTt5cVumfd7PWw+K2IdnouJx1jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwerkMn3iqkA2+hJ9uf/BLvrVtyoA6cNjUxro9oi+b0Csgd2Xeh
	QwhdD1liJzVv+2mR+fDp/3gdZYQUZAhWN4YLZTLcXcDL6RveNh7vlkgrxeAIJCXnvxvrhvBmDS+
	GaADGEJ/e9oJ1KbQb2d/Yp7zmMF2zOJRArGMJAGdIu7ooxzAXqEOjBXvJzJrpebgR0arlODZWiB
	3H7mSSUXl+yZuSFgJW3V7UpBCSV+9esdIuGslNUHk=
X-Gm-Gg: ASbGncuHaNIrE9HG2Zr47o1AJq+Yj67rSqdt7zc4rd+PHCS5MUVHugWKYvwgnVpN7Vg
	QRjcnm+wJoqSUyO4ujxndmnyuQv1yV6hhburg3fpOBMlNXSg+ULW/qo3zTIUEGssN+FwVDZs=
X-Received: by 2002:a17:90b:54c4:b0:2fa:562c:c1cf with SMTP id 98e67ed59e1d1-303788c2685mr5612926a91.1.1742990965385;
        Wed, 26 Mar 2025 05:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF08/xQUBw1qW6H7aLUt4LlzOG2QAjL0z5ddqYDq1gJyhsrwBfoOpE9/miJp0mJcZwfCL0bkXJyElu25CxqUpA=
X-Received: by 2002:a17:90b:54c4:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-303788c2685mr5612880a91.1.1742990964861; Wed, 26 Mar 2025
 05:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-2-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:08:48 +0100
X-Gm-Features: AQ5f1Jrv63LkXsP4PD_7nrO0YIAGYmDZjtrgpSHFpXGUIqckHLvcEGNJAhPgi6A
Message-ID: <CAJaqyWeX0V2esyyWct3OnnDtCzGdJJamSjphSVz6KEFomYr0DQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: baQK7XxEDeCtdhqABJmbzVnOsdS60HWEmyIXntjU53c_1742990966
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:43=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> To be consistent with virtqueue_reset().
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fdd2d2b07b5a..1bdfd5d617a7 100644
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
> 2.42.0
>

