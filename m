Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FEE1F5FA
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362625; cv=none; b=soK0O/A8IO7iYWrAyPVwwsTKDK0xRKkknzcFUnEOAXJH9EVSStuQTF/jbf4/BOePU/72uOolwraFP0Ey+kP/8HESlz3VKbWlMDKewjfxl40r+hBOAdxnfhgOyKEa9/6TsUfrlQhe5by/6IRskfHb+nEPkDn/V44xdz55H3gGoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362625; c=relaxed/simple;
	bh=w7R9ytRD85MeIXtcZKee/rVGun8dMiy7oOSdiI6M/3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgeYA39jY8gBb/OJWoy1GH0k52TsMabAgM7hp5y7+Yo5kx/9p8kUBowJf0v+d2sajomk3qJi+Jwo2LdvEAxSHIFJsCPg+tYwEuvKoaIxodN2C0Ms+SGp5g6OfuTP/1SOey+wOiofwydZH6jfu1h/M+bZ1/7Vd4oD91pxhfyQglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2glEUDy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2glEUDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vj/eatzi8/SbTZm4sotqYn1LymWrRr/7l24MdkO3x34=;
	b=H2glEUDyodTwFeLPTrpzOP6jXCMusWM5qoBH3xZwIcY83eVhw9XOsCAiDWsKp/nLAgQtSG
	ahVyWe3I+x2CVtHkjWg1rwyu4Y5fhXLLjfcatrz8Nf0hdzvvbYZnqVBGcS6V/nBL5kwfNy
	ngiaYSeFSvSyRCa2jeCllpSRZ5inba4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-VYlS4bDyMdS9VACJpE7-IA-1; Sun, 23 Feb 2025 21:03:41 -0500
X-MC-Unique: VYlS4bDyMdS9VACJpE7-IA-1
X-Mimecast-MFC-AGG-ID: VYlS4bDyMdS9VACJpE7-IA_1740362620
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc1eadf5a8so8375089a91.3
        for <virtualization@lists.linux.dev>; Sun, 23 Feb 2025 18:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362620; x=1740967420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj/eatzi8/SbTZm4sotqYn1LymWrRr/7l24MdkO3x34=;
        b=uULhNjWhxtO1hD8FhQdMzqQOYU7DCj8G0BHf+alwYoPkV/jnFTqXi2oK7Ac3QWH0Sg
         kXoCAdUl+W5jytIY7hs67aoPJJx/j2Whb/VSrFV8tmNS32fsO6Q1dsKo4NHYui2Ez2Jr
         zZLu5IPNMAlc9UTJsb9Xt0PByRxxaf0Dsa8QIyxcdCXC9egVfOFMw6Rl24stDBLwdXSL
         Yr6uIOCn7oIhkWqqMUK13+tXsxCbKLFEA/CfJZib7G5TMZqvsPIFQ/d1BZflMJ7B6gb/
         s3QSszZN7rVPPHGiqp0lLUY45bKuXta6gXpUVYO66cj99QHsFs7nOL4QuTm1Du/FfAOP
         C3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUJYb6geaMUaCyDsIYNJQKd3xwstxYmP6fAGtv+bBN/hxV8MdKl7rWMF6xLzavNMmGTBgQsL2Mb1sTHJvE/vA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKshY9gltp6lBgkNt1LC85TKNQgMDTx+WVxx+bLoLxRvog7qSd
	W00irv0YL8sb82TxOTq3g7gEPqdKTv11I4oiAcPnYFNPMb+KqWijZBBVIe3Fr+i2PTjrIbOo1oh
	3xhyi4Yrj7EKag7IL2K0xvhssbKXzO5Zm7QVe1VXXyrsVSeEksFiQnZx7Bu248sXWlYkvjk0Wlz
	YyRO5aX4o5ON1taTGMFsHrEganyG/S2MsiOM7xIoY=
X-Gm-Gg: ASbGnctok7pkufTIWLj0nWVlCyu6E2chBx/LaHVRudDu3tg/9MuPA7e9/4jl7CvGgeT
	QzszjuDSQ2p+WkPm5Jxy/SYWH4lOu7ecEVW0N/FN9LmdtWBYOMWCAlrXyNSvi0vqqi+xg/RkFmQ
	==
X-Received: by 2002:a17:90b:2f10:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-2fce75d8389mr23425064a91.0.1740362620360;
        Sun, 23 Feb 2025 18:03:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqHYDfPs1srCspzCYJowyZpz5am+Rf4d4c61UQnVndBWfcy166ap+BjMNrsJ3c3QtjlAG1XZ63cmpi3gjXfVA=
X-Received: by 2002:a17:90b:2f10:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-2fce75d8389mr23425019a91.0.1740362619936; Sun, 23 Feb 2025
 18:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-5-eperezma@redhat.com>
In-Reply-To: <20250221170626.261687-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 10:03:27 +0800
X-Gm-Features: AWEUYZmFvdghBWbj7dfL1lk5t5jzlCOVdRYAsevanX_ZGMVfIVhiNzRnHAcWiJI
Message-ID: <CACGkMEuGSGcmMtAwGwBWfHai=yUGGcD__kjCh-z3NbK8q6oGSw@mail.gmail.com>
Subject: Re: [RFC v2 4/5] virtiofs: perform DMA operations out of the spinlock
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sxHDx9UdJC22S3irCJOozC17_ILSAXZlROE0dx1czxs_1740362620
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 1:07=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This is useful for some setups like swiotlb or VDUSE where the DMA
> operations are expensive and/or need to be performed with a write lock.
>
> After applying this patch, fio read test goes from 1124MiB/s to 1191MiB/s=
.

What FIO parameter have you used? It might be worth trying different
sizes. It seems to be more obvious when using larger requests when I'm
testing similar optimization for virtio-blk.

And we also need to test without VDUSE, to make sure no regression in
classical setups.

Thanks

>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 1344c5782a7c..e19c78f2480e 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -836,8 +836,19 @@ static void virtio_fs_requests_done_work(struct work=
_struct *work)
>
>         /* End requests */
>         list_for_each_entry_safe(req, next, &reqs, list) {
> +               unsigned int total_sgs =3D req->out_sgs + req->in_sgs;
> +
>                 list_del_init(&req->list);
>
> +               for (unsigned int i =3D 0; i < total_sgs; ++i) {
> +                       enum dma_data_direction dir =3D (i < req->out_sgs=
) ?
> +                               DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +                       dma_unmap_page(vq->vdev->dev.parent,
> +                                      sg_dma_address(&req->sg[i]),
> +                                      sg_dma_len(&req->sg[i]), dir);
> +
> +               }
> +
>                 /* blocking async request completes in a worker context *=
/
>                 if (req->args->may_block) {
>                         struct virtio_fs_req_work *w;
> @@ -1426,6 +1437,24 @@ static int virtio_fs_enqueue_req(struct virtio_fs_=
vq *fsvq,
>                 sgs[i] =3D &req->sg[i];
>         WARN_ON(req->out_sgs + req->in_sgs !=3D total_sgs);
>
> +       // TODO can we change this ptr out of the lock?
> +       vq =3D fsvq->vq;
> +       // TODO handle this and following errors
> +       for (i =3D 0; i < total_sgs; i++) {
> +               struct page *page =3D sg_page(&req->sg[i]);
> +               enum dma_data_direction dir =3D (i < req->out_sgs) ?
> +                       DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +               dma_addr_t dma_addr =3D dma_map_page(vq->vdev->dev.parent=
, page,
> +                                                  req->sg[i].offset, req=
->sg[i].length, dir);
> +
> +               if (dma_mapping_error(vq->vdev->dev.parent, dma_addr)) {
> +                       ret =3D -ENOMEM;
> +                       goto out;
> +               }
> +               sg_dma_address(&req->sg[i]) =3D dma_addr;
> +               sg_dma_len(&req->sg[i]) =3D req->sg[i].length;
> +       }
> +
>         spin_lock(&fsvq->lock);
>
>         if (!fsvq->connected) {
> @@ -1434,8 +1463,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_v=
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
> @@ -1460,6 +1489,13 @@ static int virtio_fs_enqueue_req(struct virtio_fs_=
vq *fsvq,
>                 virtqueue_notify(vq);
>
>  out:
> +       for (unsigned int j =3D 0; ret && j < total_sgs; ++j) {
> +               enum dma_data_direction dir =3D (j < req->out_sgs) ?
> +                       DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +               dma_unmap_page(vq->vdev->dev.parent,
> +                              sg_dma_address(&req->sg[j]),
> +                              sg_dma_len(&req->sg[j]), dir);
> +       }
>         if (ret < 0 && req->argbuf) {
>                 kfree(req->argbuf);
>                 req->argbuf =3D NULL;
> --
> 2.48.1
>

