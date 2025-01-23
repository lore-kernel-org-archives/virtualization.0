Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310F1BC4E
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737599228; cv=none; b=nYlq1Dqg5pBZ7JXsx8HGYT2JDSP47WwWiy5PA9kXC82hGccU85cg+ZIWZ8MooRugXb+5gy988EYQaGuIz1qfA/kTE7FTz74oMK/vy6r5jBvyAL9hWarAKo+TxN7CJxcQuSfIM2Z1qWuzEiduFLIn1l8leLfZAociNyLBt7AnANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737599228; c=relaxed/simple;
	bh=w0sCJHR30d9H4iHMdYEVBs+Jk7gsg4eA3IAPwRozNYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgF3rAj4ZVd/LHvRVRjnwgM46WH0xpqt8sJ2ZHE8QUhD/r87owtqh9RjDSK1UAZkhRHkG5PGRGWJ9g6nvmW1Q0REEz4RiEj4odlO3s2O2V+eOcm/xhcpwffUqUNkXxzONX67S1acXTpvKzev7R7voaM2CDqgk+zzYSn5PsLthHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8++YPHY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8++YPHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737599224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xvvDVwx6xeKtI//AmMCAzmotUJcSdgHvXAzS18AXEM=;
	b=h8++YPHYC5+egdvjBWomJGOOum4oJW5snOLA7dAX45SBHaFFdPlNaxZoU02HGPVAsLBQbX
	BJxgsoajpveZmH21nL/bn7L3dXx3j/U+iUyoNXAEgERsW/MlD+D6i8iu+AHpLjnkdmgukE
	1c+8ipg7WEZlrNyP5l8E/5+5X8d2K2o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-pjAO7_60MCep1w2YKUNZfw-1; Wed, 22 Jan 2025 21:27:03 -0500
X-MC-Unique: pjAO7_60MCep1w2YKUNZfw-1
X-Mimecast-MFC-AGG-ID: pjAO7_60MCep1w2YKUNZfw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso1454515a91.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 18:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737599222; x=1738204022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xvvDVwx6xeKtI//AmMCAzmotUJcSdgHvXAzS18AXEM=;
        b=aTTQf6h2wx2K4m0wc6N8DwozSzo3nTUxCtpQ2nITkIsHodpNJSsFbx1Z8ejFpzFRCg
         AnsGnQuZB4tEAXX2k0FXFO+e2WnGAzebUQyP6UHPNj7XOlVBKF3m1OtXYiirccyI7SkO
         FNhhz1s1egb3ENrl8oYpWrhDQWTqJPQfQK1LuOhJG87LkmhKxFG7U8y1NRDT10yl5VoN
         ZrWPLlUHsALeWavvj/M/k23iEfd3/XbdeEvylbhCkSyom+UcheoNDTJ/WMDrvyQeC59C
         zrG7I01L9qw1XNyY0cXuH4TSdRdPbQpOh2sjfee55+1kBR0ciqFBT5jrwUOOC4o4Fjjo
         SHmg==
X-Forwarded-Encrypted: i=1; AJvYcCUKxYcLiXux4uoe+s4vr1BraxsKXxjZxUt6+O4AfRDDrb0LqqJ9LnOUDe9CUz3AWf1Kx4UWtNJjCzU4mamGRw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7wOtm8GGHSSEM/Mj86y9Z9shIYuDD9mfN+ST518I8mmlf9l+s
	9V6E1NTx0AGPaGGMO9hlxhS0APKCzI5deupIjeJ1BostpqeTuNDg3IPF6mrlG81Xz4V1ppD+uB2
	twwwgbrDX6WnUqKPzdAlKlRQJuUwRTcN5YXGWieTBQgZvlw4RgisiGeBnlm54DedAkDGKo3SUon
	uYlIqAI9tP/Y4QhzO31C272UUACapWa/cTxSHP4Sw=
X-Gm-Gg: ASbGncsULtN039b0a9ucJr8wS6brQf1eToki2XczuWyA0wGNfdZiFlXxdKLcxTYZF1i
	myiqQUts2pfqqF6r5gHBSqS/N69kPp/zBLwTmuEvSqkXHGz1MUw==
X-Received: by 2002:a05:6a00:a95:b0:72d:8fa2:9998 with SMTP id d2e1a72fcca58-72dafa44feamr36883287b3a.14.1737599222520;
        Wed, 22 Jan 2025 18:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpu8YJ9iEpTYU6b3mWHjuSjoNlZ0U5kMEFvFgM0xZYCTiqbvv3D9V3+eCAtnr9nAO7E+B/LroW7hOWk9VJDHk=
X-Received: by 2002:a05:6a00:a95:b0:72d:8fa2:9998 with SMTP id
 d2e1a72fcca58-72dafa44feamr36883250b3a.14.1737599222050; Wed, 22 Jan 2025
 18:27:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122163154.1225353-1-eperezma@redhat.com> <20250122163154.1225353-6-eperezma@redhat.com>
 <CACGkMEu377y+Q+vV3b6Azc620B=TZQeYEfY6w7bKTNAWkEqy9Q@mail.gmail.com>
In-Reply-To: <CACGkMEu377y+Q+vV3b6Azc620B=TZQeYEfY6w7bKTNAWkEqy9Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jan 2025 10:26:50 +0800
X-Gm-Features: AbW1kvbYLGTSiuABd4he8P4rwYoEBm8czT-1Mkq3bRJS7zf47Ngk0N2PCGvvO7U
Message-ID: <CACGkMEupbs7eU2RT0jgigmpumubNJcBS_8zpi3gVZkuxBd7W6w@mail.gmail.com>
Subject: Re: [RFC 5/5] virtiofs: perform DMA operations out of the spinlock
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, 
	Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V1LPJo0ntf-9LF_82sRya1VD-SFDhXMIYyUtU78BfwI_1737599222
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 9:56=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jan 23, 2025 at 12:32=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> >
> > This is useful for some setups like swiotlb or VDUSE where the DMA
> > operations are expensive and/or need to be performed with a write lock.
> >
> > After applying this patch, fio read test goes from 1201MiB/s to 1211MiB=
/s.
>
> The difference is too small to differentiate it from the noise.
>
> I would suggest to test with different setups.
>
> 1) SWIOTLB 2) VDUSE
>
> Note that SWIOTLB will do bouncing even for DMA_FROM_DEVICE,

I meant dma map in this case actually.

Thanks

> so I
> think we may see better performance there.
>
> And we need to try with different request size, I did a similar patch
> for virtio-blk and I see better performance for large request like 1M
> etc.
>
> Thanks
>
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c |  2 ++
> >  fs/fuse/virtio_fs.c          | 25 +++++++++++++++++++++++--
> >  2 files changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index e49912fa77c5..eb22bfcb9100 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -580,6 +580,7 @@ int virtqueue_map_sgs(struct virtqueue *_vq,
> >                                 goto unmap_release;
> >
> >                         sg_dma_address(sg) =3D addr;
> > +                       sg_dma_len(sg) =3D sg->length;
> >                         mapped_sg++;
> >                 }
> >         }
> > @@ -592,6 +593,7 @@ int virtqueue_map_sgs(struct virtqueue *_vq,
> >                                 goto unmap_release;
> >
> >                         sg_dma_address(sg) =3D addr;
> > +                       sg_dma_len(sg) =3D sg->length;
> >                         mapped_sg++;
> >                 }
> >         }
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 1344c5782a7c..2b558b05d0f8 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -836,8 +836,21 @@ static void virtio_fs_requests_done_work(struct wo=
rk_struct *work)
> >
> >         /* End requests */
> >         list_for_each_entry_safe(req, next, &reqs, list) {
> > +               struct scatterlist *stack_sgs[6];
> > +               struct scatterlist **sgs =3D stack_sgs;
> > +               unsigned int total_sgs =3D req->out_sgs + req->in_sgs;
> > +
> >                 list_del_init(&req->list);
> >
> > +               /* TODO replace magic 6 by a macro */
> > +               if (total_sgs > 6)
> > +                       sgs =3D kmalloc_array(total_sgs, sizeof(sgs[0])=
, GFP_ATOMIC);
> > +
> > +               for (unsigned int i =3D 0; i < total_sgs; ++i)
> > +                       sgs[i] =3D &req->sg[i];
> > +
> > +               virtqueue_unmap_sgs(vq, sgs, req->out_sgs, req->in_sgs)=
;
> > +
> >                 /* blocking async request completes in a worker context=
 */
> >                 if (req->args->may_block) {
> >                         struct virtio_fs_req_work *w;
> > @@ -850,6 +863,9 @@ static void virtio_fs_requests_done_work(struct wor=
k_struct *work)
> >                 } else {
> >                         virtio_fs_request_complete(req, fsvq);
> >                 }
> > +
> > +               if (sgs !=3D stack_sgs)
> > +                       kfree(sgs);
> >         }
> >
> >         /* Try to push previously queued requests, as the queue might n=
o longer be full */
> > @@ -1426,6 +1442,11 @@ static int virtio_fs_enqueue_req(struct virtio_f=
s_vq *fsvq,
> >                 sgs[i] =3D &req->sg[i];
> >         WARN_ON(req->out_sgs + req->in_sgs !=3D total_sgs);
> >
> > +       // TODO can we change this ptr out of the lock?
> > +       vq =3D fsvq->vq;
> > +       // TODO handle this and following errors
> > +       ret =3D virtqueue_map_sgs(vq, sgs, req->out_sgs, req->in_sgs);
> > +       BUG_ON(ret < 0);
> >         spin_lock(&fsvq->lock);
> >
> >         if (!fsvq->connected) {
> > @@ -1434,8 +1455,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs=
_vq *fsvq,
> >                 goto out;
> >         }
> >
> > -       vq =3D fsvq->vq;
> > -       ret =3D virtqueue_add_sgs(vq, sgs, req->out_sgs, req->in_sgs, r=
eq, GFP_ATOMIC);
> > +       ret =3D virtqueue_add_sgs_premapped(vq, sgs, req->out_sgs,
> > +                                         req->in_sgs, req, GFP_ATOMIC)=
;
> >         if (ret < 0) {
> >                 spin_unlock(&fsvq->lock);
> >                 goto out;
> > --
> > 2.48.1
> >

