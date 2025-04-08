Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12018207E14
	for <virtualization@lists.linux.dev>; Tue,  8 Apr 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112225; cv=none; b=WjBvoHRGJW7Q0VOwP3K+tiXX+Tpf8NP4I2E1De0jy4zEs9RzXGHWYtv7vJP18HwjKxyn5mfHO0vfJsoTkFXOZUfYqSGihHx0iFA1Ubjplo+aVXCthuXXTI9T5wUEL1AUklLDazYIMcyum85zFkOB097YyJ5XHPbsFitCA5tEinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112225; c=relaxed/simple;
	bh=9s3L86w3tciUYe4psZappCfNDi/qGVH4vUq7so5fIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=urInrLz8PxgTAL0ERN6c0IoS7FDFkdZZ3yVOVr9GAzi1W77I4yxAkzwB5jy9X1eWZTw18LVURV6VZbBjg+APl5WbOg1wjlHwwq43CGpwPvF8nnDqGxC9sOeJEcz57VxckUdKF2/PJGX0rXeiDduWe15AZoQ8d7ZOZ/VOpyATNkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAXyYqcs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAXyYqcs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744112221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cn8oAI1Xv630WkLxowzeUqJr8VFrC4TI+Nd+Uqm5SUI=;
	b=TAXyYqcsJ/KwaVNiLVCPGBN4kbOTAze/p0np6bID6KG00rn2yLox59yzoLknB1mx4a0H5d
	2ULFL0RtbtD1F/kqDwhExY1Ahfo511bWJ1jpKM/W0s4BMDDnRzxiSol7OovstgIDb4AzlU
	CRA47hem4CCQwE5Vr1LuGUwC5QuGagc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-x6ypfbaTPG6XJKQ8IgaKRg-1; Tue, 08 Apr 2025 07:37:00 -0400
X-MC-Unique: x6ypfbaTPG6XJKQ8IgaKRg-1
X-Mimecast-MFC-AGG-ID: x6ypfbaTPG6XJKQ8IgaKRg_1744112219
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so30393285e9.2
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 04:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112219; x=1744717019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cn8oAI1Xv630WkLxowzeUqJr8VFrC4TI+Nd+Uqm5SUI=;
        b=xOCzHyWcjMo4h/XOOGxY080Xwf94Xim21dFKnPI7pj6DxS2Pmm9JTbU2LlOeNGIVJU
         FLEQxyj03EAjEq7Wa6gD8Tt7oofs88g/u/CTx9Y1KtZ0Nk6Bdu1qGL/O+tepZ2Wedqjv
         4NI7z77yPgwo3m5F9ShhmZLiTgkcap1ZxCavGbRDo3z62zAuuhWO2+RG8E/uj/TSsUc2
         ncmnDXvEfVYVcRod5KNjuINfESg3TkTItW+hGqVfGMO30XT2tgaNB1PGlVOfcOAtW7n7
         SyFCSmpcGgGywmQm9SqV8SMU7Rf5YLisLbRqeNEqQDNoQG+i8EodkSZyboNzhDx+0pre
         g4UA==
X-Forwarded-Encrypted: i=1; AJvYcCVgQ8VXsCDd3qHLmZmtQ49U5TyZaxv/YTLaobPtcZZLX8xKXxw8fEcA/0RoVz+3z2058AxrSUXqxS0jH/y5HA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjQwD/Gntw+Ret3+sYqcDsnA8HaoOlLiIevgSrcQE08I4xKokS
	/pfg0CzJT3aVCT0QNmT2oSfU+8I3z50Exfwo4AccJuhIwlqazWDZM3SKAZqdkYDcx/f5WY1I32G
	Tvv3sKZSFlCEPkYEOs2LwHI2xmXtdt06dzh4gvCxB8W+uOFvwEVmyuUEgDDJNsBiY
X-Gm-Gg: ASbGncvIemyBCiw/NegQbCXDVrfgNEKO1LJQ10FaQ484dNPtNm4sd6rDnj2M0+5o/bt
	f2NUBzQ47E/WLklJ3/hi91tJGis2Pb7qVgkH2qfShTMGJEfElQ40dk9e+eYil0PDyOG3MnE25oD
	zFVkFjxpc3hkpBhh4iKUNgDc/hbd+yNlBibR8WlU33uYPUaHI9B+gduYpDs7VRBVT8NN2q3QrTP
	uc1/xZQgzzP4CT022oWmEFbk9jicJp5FezPf5xXSYvZHdf3RtTaRQPR8OCarFX8ZbawjSChnXPS
	+CD3+tGqMA==
X-Received: by 2002:a05:600c:5494:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43ecfa04a99mr114813555e9.28.1744112219037;
        Tue, 08 Apr 2025 04:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkdd9XDHZH69wpZWmKlgMrLox4ZlFp0C8zW/kcglEMyDCZY1oLA2xMCYRrwZ1w1FPWZTxnjA==
X-Received: by 2002:a05:600c:5494:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43ecfa04a99mr114813315e9.28.1744112218570;
        Tue, 08 Apr 2025 04:36:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7225sm14608667f8f.26.2025.04.08.04.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:36:57 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:36:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] virtio_ring: introduce virtqueue ops
Message-ID: <20250408073317-mutt-send-email-mst@kernel.org>
References: <20250324054333.1954-1-jasowang@redhat.com>
 <20250324060127.2358-1-jasowang@redhat.com>
 <20250407041729-mutt-send-email-mst@kernel.org>
 <CACGkMEv-=V0a7jpR9e-i=Oe+PE9pN_cH3yDBmyOYhwPcJXOHPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv-=V0a7jpR9e-i=Oe+PE9pN_cH3yDBmyOYhwPcJXOHPQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CAHUJCEm8TdZU-WA8IgJJb3BmPKGfPkvKNUKNxf7iPQ_1744112219
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 08, 2025 at 03:02:35PM +0800, Jason Wang wrote:
> On Mon, Apr 7, 2025 at 4:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Mar 24, 2025 at 02:01:21PM +0800, Jason Wang wrote:
> > > This patch introduces virtqueue ops which is a set of the callbacks
> > > that will be called for different queue layout or features. This would
> > > help to avoid branches for split/packed and will ease the future
> > > implementation like in order.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> >
> >
> >
> > > ---
> > >  drivers/virtio/virtio_ring.c | 96 +++++++++++++++++++++++++-----------
> > >  1 file changed, 67 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index a2884eae14d9..ce1dc90ee89d 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -159,9 +159,30 @@ struct vring_virtqueue_packed {
> > >       size_t event_size_in_bytes;
> > >  };
> > >
> > > +struct vring_virtqueue;
> > > +
> > > +struct virtqueue_ops {
> > > +     int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[],
> > > +                unsigned int total_sg, unsigned int out_sgs,
> > > +                unsigned int in_sgs, void *data,
> > > +                void *ctx, bool premapped, gfp_t gfp);
> > > +     void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void **ctx);
> > > +     bool (*kick_prepare)(struct vring_virtqueue *vq);
> > > +     void (*disable_cb)(struct vring_virtqueue *vq);
> > > +     bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> > > +     unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> > > +     bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx);
> > > +     void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> > > +     bool (*more_used)(const struct vring_virtqueue *vq);
> > > +     int (*resize)(struct vring_virtqueue *vq, u32 num);
> > > +     void (*reset)(struct vring_virtqueue *vq);
> > > +};
> >
> > I like it that it's organized but
> > I worry about the overhead of indirect calls here.
> 
> We can switch to use INDIRECT_CALL_X() here

If you think it's cleaner.. but INDIRECT_CALL is all chained
while a switch can do a binary search.


> (but I'm not sure we
> should worry about it too much as ndo_ops or qdiscs doesn't use that).


And that's why we ended up with xdp, no? the stack's too heavy ...

> > How about a switch statement instead?
> >
> > struct vring_virtqueue {
> >         enum vring_virtqueue_ops ops;
> >
> > }
> >
> >
> > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
> >  {
> >       struct vring_virtqueue *vq = to_vvq(_vq);
> >
> >         switch (vq->ops) {
> >          VQ_PACKED:
> >          VQ_SPLIT:
> >          VQ_IN_ORDER:
> >         }
> >
> >
> > }
> >
> >
> > What do you think?
> 
> Actually, the matrix will be 2*2:
> 
> PACKED, SPLIT, PACKED_IN_ORDER, SPLIT_IN_ORDER

Confused. Same amount of enums as ops structures in your approach, no?


> And will be doubled if a new layout is implemented.
> 
> If we open them such a switch will spread in a lot of places in the code.
> 
> Thanks
> 
> >
> >
> >
> > > +
> > >  struct vring_virtqueue {
> > >       struct virtqueue vq;
> > >
> > > +     struct virtqueue_ops *ops;
> > > +
> > >       /* Is this a packed ring? */
> > >       bool packed_ring;
> > >
> > > @@ -1116,6 +1137,8 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
> > >       return 0;
> > >  }
> > >
> > > +struct virtqueue_ops split_ops;
> > > +
> > >  static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
> > >                                              struct vring_virtqueue_split *vring_split,
> > >                                              struct virtio_device *vdev,
> > > @@ -1134,6 +1157,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
> > >               return NULL;
> > >
> > >       vq->packed_ring = false;
> > > +     vq->ops = &split_ops;
> > >       vq->vq.callback = callback;
> > >       vq->vq.vdev = vdev;
> > >       vq->vq.name = name;
> > > @@ -2076,6 +2100,8 @@ static void virtqueue_reset_packed(struct vring_virtqueue *vq)
> > >       virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
> > >  }
> > >
> > > +struct virtqueue_ops packed_ops;
> > > +
> > >  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
> > >                                              struct vring_virtqueue_packed *vring_packed,
> > >                                              struct virtio_device *vdev,
> > > @@ -2107,6 +2133,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
> > >       vq->broken = false;
> > >  #endif
> > >       vq->packed_ring = true;
> > > +     vq->ops = &packed_ops;
> > >       vq->dma_dev = dma_dev;
> > >       vq->use_dma_api = vring_use_dma_api(vdev);
> > >
> > > @@ -2194,6 +2221,34 @@ static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
> > >       return -ENOMEM;
> > >  }
> > >
> > > +struct virtqueue_ops split_ops = {
> > > +     .add = virtqueue_add_split,
> > > +     .get = virtqueue_get_buf_ctx_split,
> > > +     .kick_prepare = virtqueue_kick_prepare_split,
> > > +     .disable_cb = virtqueue_disable_cb_split,
> > > +     .enable_cb_delayed = virtqueue_enable_cb_delayed_split,
> > > +     .enable_cb_prepare = virtqueue_enable_cb_prepare_split,
> > > +     .poll = virtqueue_poll_split,
> > > +     .detach_unused_buf = virtqueue_detach_unused_buf_split,
> > > +     .more_used = more_used_split,
> > > +     .resize = virtqueue_resize_split,
> > > +     .reset = virtqueue_reset_split,
> > > +};
> > > +
> > > +struct virtqueue_ops packed_ops = {
> > > +     .add = virtqueue_add_packed,
> > > +     .get = virtqueue_get_buf_ctx_packed,
> > > +     .kick_prepare = virtqueue_kick_prepare_packed,
> > > +     .disable_cb = virtqueue_disable_cb_packed,
> > > +     .enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
> > > +     .enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
> > > +     .poll = virtqueue_poll_packed,
> > > +     .detach_unused_buf = virtqueue_detach_unused_buf_packed,
> > > +     .more_used = more_used_packed,
> > > +     .resize = virtqueue_resize_packed,
> > > +     .reset = virtqueue_reset_packed,
> > > +};
> > > +
> > >  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
> > >                                        void (*recycle)(struct virtqueue *vq, void *buf))
> > >  {
> > > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -     return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
> > > -                                     out_sgs, in_sgs, data, ctx, premapped, gfp) :
> > > -                              virtqueue_add_split(vq, sgs, total_sg,
> > > -                                     out_sgs, in_sgs, data, ctx, premapped, gfp);
> > > +     return vq->ops->add(vq, sgs, total_sg,
> > > +                         out_sgs, in_sgs, data, ctx, premapped, gfp);
> > >  }
> > >
> > >  /**
> > > @@ -2437,8 +2490,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -     return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> > > -                              virtqueue_kick_prepare_split(vq);
> > > +     return vq->ops->kick_prepare(vq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
> > >
> > > @@ -2508,8 +2560,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -     return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
> > > -                              virtqueue_get_buf_ctx_split(vq, len, ctx);
> > > +     return vq->ops->get(vq, len, ctx);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> > >
> > > @@ -2531,10 +2582,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -     if (vq->packed_ring)
> > > -             virtqueue_disable_cb_packed(vq);
> > > -     else
> > > -             virtqueue_disable_cb_split(vq);
> > > +     return vq->ops->disable_cb(vq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> > >
> > > @@ -2557,8 +2605,7 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> > >       if (vq->event_triggered)
> > >               vq->event_triggered = false;
> > >
> > > -     return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> > > -                              virtqueue_enable_cb_prepare_split(vq);
> > > +     return vq->ops->enable_cb_prepare(vq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> > >
> > > @@ -2579,8 +2626,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
> > >               return false;
> > >
> > >       virtio_mb(vq->weak_barriers);
> > > -     return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
> > > -                              virtqueue_poll_split(vq, last_used_idx);
> > > +     return vq->ops->poll(vq, last_used_idx);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_poll);
> > >
> > > @@ -2623,8 +2669,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
> > >       if (vq->event_triggered)
> > >               vq->event_triggered = false;
> > >
> > > -     return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> > > -                              virtqueue_enable_cb_delayed_split(vq);
> > > +     return vq->ops->enable_cb_delayed(vq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> > >
> > > @@ -2640,14 +2685,13 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -     return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> > > -                              virtqueue_detach_unused_buf_split(vq);
> > > +     return vq->ops->detach_unused_buf(vq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> > >
> > >  static inline bool more_used(const struct vring_virtqueue *vq)
> > >  {
> > > -     return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
> > > +     return vq->ops->more_used(vq);
> > >  }
> > >
> > >  /**
> > > @@ -2785,10 +2829,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >       if (recycle_done)
> > >               recycle_done(_vq);
> > >
> > > -     if (vq->packed_ring)
> > > -             err = virtqueue_resize_packed(vq, num);
> > > -     else
> > > -             err = virtqueue_resize_split(vq, num);
> > > +     err = vq->ops->resize(vq, num);
> > >
> > >       return virtqueue_enable_after_reset(_vq);
> > >  }
> > > @@ -2822,10 +2863,7 @@ int virtqueue_reset(struct virtqueue *_vq,
> > >       if (recycle_done)
> > >               recycle_done(_vq);
> > >
> > > -     if (vq->packed_ring)
> > > -             virtqueue_reset_packed(vq);
> > > -     else
> > > -             virtqueue_reset_split(vq);
> > > +     vq->ops->reset(vq);
> > >
> > >       return virtqueue_enable_after_reset(_vq);
> > >  }
> > > --
> > > 2.42.0
> >

