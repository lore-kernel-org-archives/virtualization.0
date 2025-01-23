Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CED52914
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 01:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597379; cv=none; b=U2SjFurnoFWi7TuuWGscXAwjI+heU+UR08Y/X85y7uyLnSv9i2Je2NmjWPnR7y+USFVHcwoKymBepjBt5Mguq/G2RKbT/sDs72f/DUruFMaeIVVXhQXUcxm4AgfgEthdry6AlJrIB5+PIMIVIbJMwiE2fDq1vEwpg/z18E7uFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597379; c=relaxed/simple;
	bh=XiEOoD4yzD2F81TdjyrRKaWKiuUNatsVv3GejtGvLy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mxn5vwVU32gx6koOkH02o8ZjFb4/1UxxVXAZNut8xRgeqszaf7+lApBqL5LlH8t15rAr8jG/mCAjaagzDmiH9T6UABLNokM4yH6XJMV6NlpJqYET3h05Ce8WlYy/b1ZtiogeVSpGmf5KjVrzuai9j6zyYU+vT0xhwnxalrRxvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHmM9Ity; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHmM9Ity"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737597376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYTUDeFLUf5sRvOpJXpQej/n7vd/1xg+Uhd8MOoxlnc=;
	b=NHmM9ItyLSjJH4NIX653fjqrAzxFUfcBfWX0HJ7BCut6gzAUCXOvYAr8tAC/xfdYZX0pWi
	x2Wh9rax9rLFYWIARzUDWLVRaHGYElmd7k6yMuRdPE6gFo/Po2soP+qWAWkY82c5z4BNCw
	zl92xiCUQ+xtQj6qulMtep0uo/724jk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-HsITRqEjMgW4vQ0-qDeCSw-1; Wed, 22 Jan 2025 20:56:14 -0500
X-MC-Unique: HsITRqEjMgW4vQ0-qDeCSw-1
X-Mimecast-MFC-AGG-ID: HsITRqEjMgW4vQ0-qDeCSw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee46799961so1354510a91.2
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 17:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737597373; x=1738202173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYTUDeFLUf5sRvOpJXpQej/n7vd/1xg+Uhd8MOoxlnc=;
        b=p0WpRsQSQhe8X8/YCRy0k5AlIkZ/8M5xoM9gILO+XNT0vvCEdKNE9GXr/7Np1AxutT
         uXnNstjqBVZliPFHFhi/e+9f53s/kn6IX9+TZf0NzEbJ3nO2WY+1O0kML1L+Dhy6JR40
         CRGd6R3qB9Uwr+LkgF1Bky3fbIdoFk9ZcbUIwTWQCgc2eagBelhTMNS2DNXSda72H8nm
         ixcss5xsoC/ICMECDoroJNTO8+mBGk/OAoJ97iBrepehvTG1ldrkXZFoBg+fqs8/4uo/
         BQjzxeeCALtBZCpWe9CKiRpbsoocFgxcrWhToRwPD9P2HhZGhhAZe8cofpQiBM9fVvZF
         Exww==
X-Forwarded-Encrypted: i=1; AJvYcCWoVxCNcE7hvCysqsA6GZBKYvgHkQiULaxRlkOeeSndT3hz8OhaAYvCqEeUN2CzsoLhEzAfnVZj2jyCZtJeXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy54M/07fgzkuv/ByZy7Pse9e2Xw39Jkyi9j87JmRK2Am6C2wCs
	waeBqvDv9wL9yL7uDdAl+m+J/C4SG9Aq0HUNiMHB1dANJ+8JBvYwrHNbF8Mx/hEPWm8Evp2YM91
	7NzztWk02FckkCUId1nBEE+vLzZl4fulvVC5hJ+bwpl5S8LTzzAzQMGI2kO63aR/fYE+mzXxOvj
	6aHN3j/n4fplYKcNIUlJWgovpm5Ii8Rs3pmwnLhS8=
X-Gm-Gg: ASbGncuZrAcsY685pteN48r5pgwP6REWWL1wnG/qIjavpFVBlnD1k2yhmcdl/EGOj8a
	OxZkPTRRgXSgF4PPsSRw+3mstB04NTPO5sgKBC20wjcMmrOHwqA==
X-Received: by 2002:a05:6a00:17a7:b0:725:eb85:f7ef with SMTP id d2e1a72fcca58-72dafa10944mr34637945b3a.14.1737597373293;
        Wed, 22 Jan 2025 17:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFXtkfahLYX5yBy5EGvs4lhrrThFtq5+9mQOHcUMOEW0C358kRvr06x3nIDobdrPVGvo8KNoEOzhB2fAUvcro=
X-Received: by 2002:a05:6a00:17a7:b0:725:eb85:f7ef with SMTP id
 d2e1a72fcca58-72dafa10944mr34637889b3a.14.1737597372787; Wed, 22 Jan 2025
 17:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122163154.1225353-1-eperezma@redhat.com> <20250122163154.1225353-6-eperezma@redhat.com>
In-Reply-To: <20250122163154.1225353-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jan 2025 09:56:01 +0800
X-Gm-Features: AbW1kvYPp1o_rP3qSdcoKKOeCxgylgXWTM4WEUCLE6G5ZJqW7pcPzq2KrovWuoI
Message-ID: <CACGkMEu377y+Q+vV3b6Azc620B=TZQeYEfY6w7bKTNAWkEqy9Q@mail.gmail.com>
Subject: Re: [RFC 5/5] virtiofs: perform DMA operations out of the spinlock
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, 
	Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PwO_0fzT2BiV9EmLcQ8yLlqhElqlOiLK2kReI5_Q_LY_1737597373
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 12:32=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> This is useful for some setups like swiotlb or VDUSE where the DMA
> operations are expensive and/or need to be performed with a write lock.
>
> After applying this patch, fio read test goes from 1201MiB/s to 1211MiB/s=
.

The difference is too small to differentiate it from the noise.

I would suggest to test with different setups.

1) SWIOTLB 2) VDUSE

Note that SWIOTLB will do bouncing even for DMA_FROM_DEVICE, so I
think we may see better performance there.

And we need to try with different request size, I did a similar patch
for virtio-blk and I see better performance for large request like 1M
etc.

Thanks

>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c |  2 ++
>  fs/fuse/virtio_fs.c          | 25 +++++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index e49912fa77c5..eb22bfcb9100 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -580,6 +580,7 @@ int virtqueue_map_sgs(struct virtqueue *_vq,
>                                 goto unmap_release;
>
>                         sg_dma_address(sg) =3D addr;
> +                       sg_dma_len(sg) =3D sg->length;
>                         mapped_sg++;
>                 }
>         }
> @@ -592,6 +593,7 @@ int virtqueue_map_sgs(struct virtqueue *_vq,
>                                 goto unmap_release;
>
>                         sg_dma_address(sg) =3D addr;
> +                       sg_dma_len(sg) =3D sg->length;
>                         mapped_sg++;
>                 }
>         }
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 1344c5782a7c..2b558b05d0f8 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -836,8 +836,21 @@ static void virtio_fs_requests_done_work(struct work=
_struct *work)
>
>         /* End requests */
>         list_for_each_entry_safe(req, next, &reqs, list) {
> +               struct scatterlist *stack_sgs[6];
> +               struct scatterlist **sgs =3D stack_sgs;
> +               unsigned int total_sgs =3D req->out_sgs + req->in_sgs;
> +
>                 list_del_init(&req->list);
>
> +               /* TODO replace magic 6 by a macro */
> +               if (total_sgs > 6)
> +                       sgs =3D kmalloc_array(total_sgs, sizeof(sgs[0]), =
GFP_ATOMIC);
> +
> +               for (unsigned int i =3D 0; i < total_sgs; ++i)
> +                       sgs[i] =3D &req->sg[i];
> +
> +               virtqueue_unmap_sgs(vq, sgs, req->out_sgs, req->in_sgs);
> +
>                 /* blocking async request completes in a worker context *=
/
>                 if (req->args->may_block) {
>                         struct virtio_fs_req_work *w;
> @@ -850,6 +863,9 @@ static void virtio_fs_requests_done_work(struct work_=
struct *work)
>                 } else {
>                         virtio_fs_request_complete(req, fsvq);
>                 }
> +
> +               if (sgs !=3D stack_sgs)
> +                       kfree(sgs);
>         }
>
>         /* Try to push previously queued requests, as the queue might no =
longer be full */
> @@ -1426,6 +1442,11 @@ static int virtio_fs_enqueue_req(struct virtio_fs_=
vq *fsvq,
>                 sgs[i] =3D &req->sg[i];
>         WARN_ON(req->out_sgs + req->in_sgs !=3D total_sgs);
>
> +       // TODO can we change this ptr out of the lock?
> +       vq =3D fsvq->vq;
> +       // TODO handle this and following errors
> +       ret =3D virtqueue_map_sgs(vq, sgs, req->out_sgs, req->in_sgs);
> +       BUG_ON(ret < 0);
>         spin_lock(&fsvq->lock);
>
>         if (!fsvq->connected) {
> @@ -1434,8 +1455,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_v=
q *fsvq,
>                 goto out;
>         }
>
> -       vq =3D fsvq->vq;
> -       ret =3D virtqueue_add_sgs(vq, sgs, req->out_sgs, req->in_sgs, req=
, GFP_ATOMIC);
> +       ret =3D virtqueue_add_sgs_premapped(vq, sgs, req->out_sgs,
> +                                         req->in_sgs, req, GFP_ATOMIC);
>         if (ret < 0) {
>                 spin_unlock(&fsvq->lock);
>                 goto out;
> --
> 2.48.1
>

