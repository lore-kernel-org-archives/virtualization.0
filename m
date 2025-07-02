Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CADB22AE65
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453821; cv=none; b=GmX9xtG7Oq6IKeAbDgIP0SLRIBIHbU7HeNJ0MXawq3K1pp23CiU4AaV2Nqc4frVAwWjZib27G9N8Ud1jWoxShBlzcwR3mpYSlkT2FUGTWIckudTId2thuVpeF8oQN940XFskSSrOZDX0+tKdLqYRyWcnOz/4vYoWsFlT4QfDh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453821; c=relaxed/simple;
	bh=ZVzwxr887wToG7MgwzRowZQD9nIxHj8I9RllumE22dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C58WnuZmiJ8dXj+nOy+OCiB3y0TMKFpB5ayxFb7WHPQ5xVESQjRYWHJlriIF9xyf/WSY6PD1vg0TG/dE++3m7wb5o/Xi7cTnt2Pt/PRsTc/QuRV2R4xdLZWB9UiOxS/pEda+UJ7bjKyZZ2sPdZ6pDNKdQ1jvZdvRPv+zPIzrrmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VfBvWKzE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfBvWKzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751453819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yfqigI6iFuRnjvOscPGmKN9whaPUb4tE1+3hMy2w+w=;
	b=VfBvWKzEQEsrPmWqdTvpcuGfoF2HwYw/VvDaUxwuQXYPw/Gs4D7jEFK0Gr5q81+CjbrayR
	kpQiZZhKRgnUvcTS/u5J59So17rdLuALDSZps69nyI2tI/wP+CCuykhiTIZCyhtuJHQEWa
	5AN7BvV/1ndCAeMUmGK5Q+4g9tLLCsU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-r7lcR30VOQyUPa6FKXT7-g-1; Wed, 02 Jul 2025 06:56:58 -0400
X-MC-Unique: r7lcR30VOQyUPa6FKXT7-g-1
X-Mimecast-MFC-AGG-ID: r7lcR30VOQyUPa6FKXT7-g_1751453817
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6090274dd37so4248768a12.0
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 03:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751453817; x=1752058617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yfqigI6iFuRnjvOscPGmKN9whaPUb4tE1+3hMy2w+w=;
        b=oxIsmtB7kYfdlsUuuTZFeuSi24kN8udR85kUdjFkHWKIys4DbWDNse45J99Si+3/sU
         L9/Gxc2WXGUTD10cw1mkp/IpRxnD/2T36WUCi9vj2wquQYB9bKz19iJiuePuqvM++rsn
         2OI0jjbzsBf67xnYFRq8ccOENAxQbtoYUfDksFUb9JkscDWvAGhkT8fzP4yqyMKV+5TJ
         uVhGI6raLJ/eftA8J5pLFe7ZfLAX1o0LYW97mnhOBT9Gs0Cxw1wv1Hsi6JHXa+027rDu
         16Yc8CM+0ZhwQ1sFq8O7MJpD0Os72adNSi4mbsRORT7eQxe13wfI9cOgHVPX8gYEurTu
         mamg==
X-Forwarded-Encrypted: i=1; AJvYcCWPd8P4XwXc7V5ORq+CrBWNC6j510guAoVA+LwIIhQrRhyEskMPXyHKg8XHtqHJNo3ySmO/eQUIAL5nJugPtw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0HZIajtMhOoACEmSTQtXQRICE4BESiAq1iMmuu+ZmQSLUX4xv
	5z4fvKGDscn72d0aEbRGGiyadlUxvZhoDOOjIrJwmCNOC6FDfhnzHNRFux6PLqm/8YI8Tic0vi0
	4H94UA8rxM8vqCmr0zcyg5M5M0PJabo77bpwG2xumN+HaWZJOPx+wQwVh4uRaGqk4GIEQ
X-Gm-Gg: ASbGncu3EG82jYxBhsO0bPjzb/wyimT5UpQXXkmblDD5SvHufTs35QTMvVXjy5S+g6D
	lc2KuLXh1XB8KbK+ga11itU2mpLygQXmQ8FI7dzT+9Yyr4Ds6YobulVnlXmvm+xeaoz3ieelZ45
	A8PE7LM7uAqBXGUtvYTylfBi8ItZoo8PreABV8cqstx52h9tdNIFzqR5XnYkDJeHefkCKUi9+Po
	k0ujpOHa4TlQWSgK1YDwhk1KArV8/2Xz7oM98zTtGLhR3Oe82VVlRzrz3ly6x8YrFr485FP1593
	CCot+j6zk2KF
X-Received: by 2002:a05:6402:34ce:b0:60c:3a73:a630 with SMTP id 4fb4d7f45d1cf-60e52cc480bmr2005360a12.9.1751453816565;
        Wed, 02 Jul 2025 03:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc4ZAJ5DDtXvenjBt+iRpz7JDzxPAN5HAkZUjXWksn5iJF7n9ojiMe/GbaACeYKf63X24xWA==
X-Received: by 2002:a05:6402:34ce:b0:60c:3a73:a630 with SMTP id 4fb4d7f45d1cf-60e52cc480bmr2005336a12.9.1751453815986;
        Wed, 02 Jul 2025 03:56:55 -0700 (PDT)
Received: from redhat.com ([31.187.78.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828bb60fsm9063535a12.3.2025.07.02.03.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:56:55 -0700 (PDT)
Date: Wed, 2 Jul 2025 06:56:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 19/19] virtio_ring: add in order support
Message-ID: <20250702064413-mutt-send-email-mst@kernel.org>
References: <20250616082518.10411-1-jasowang@redhat.com>
 <20250616082518.10411-20-jasowang@redhat.com>
 <20250701024602-mutt-send-email-mst@kernel.org>
 <CACGkMEuzTYPcDMamptLMQpSZu3gWxYx1Sr2nJef+pyuo2m35XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuzTYPcDMamptLMQpSZu3gWxYx1Sr2nJef+pyuo2m35XQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qtrHSn1KVmhNFJMc9e2DFTvYlDffXWnhPSw5uycsvAw_1751453817
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 02, 2025 at 05:29:18PM +0800, Jason Wang wrote:
> On Tue, Jul 1, 2025 at 2:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 16, 2025 at 04:25:17PM +0800, Jason Wang wrote:
> > > This patch implements in order support for both split virtqueue and
> > > packed virtqueue.
> >
> > I'd like to see more motivation for this work, documented.
> > It's not really performance, not as it stands, see below:
> >
> > >
> > > Benchmark with KVM guest + testpmd on the host shows:
> > >
> > > For split virtqueue: no obvious differences were noticed
> > >
> > > For packed virtqueue:
> > >
> > > 1) RX gets 3.1% PPS improvements from 6.3 Mpps to 6.5 Mpps
> > > 2) TX gets 4.6% PPS improvements from 8.6 Mpps to 9.0 Mpps
> > >
> >
> > That's a very modest improvement for a lot of code.
> > I also note you put in some batching just for in-order.
> > Which could also explain the gains maybe?
> > What if you just put in a simple implementation with no
> > batching tricks? do you still see a gain?
> 
> It is used to implement the batch used updating.
> 
> """
> Some devices always use descriptors in the same order in which they
> have been made available. These devices can offer the
> VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows
> devices to notify the use of a batch of buffers to the driver by only
> writing out a single used ring entry with the id corresponding to the
> head entry of the descriptor chain describing the last buffer in the
> batch.
> """
> 
> DPDK implements this behavior, so it's a must for the virtio driver.
> 
> > Does any hardware implement this? Maybe that can demonstrate
> > bigger gains.
> 
> Maybe but I don't have one in my hand.
> 
> For performance, I think it should be sufficient as a starter. I can
> say in the next version something like "more optimizations could be
> done on top"

What are some optimizations you have in mind?



> Note that the patch that introduces packed virtqueue, there's not even
> any numbers:
> 
> commit 1ce9e6055fa0a9043405c5604cf19169ec5379ff
> Author: Tiwei Bie <tiwei.bie@intel.com>
> Date:   Wed Nov 21 18:03:27 2018 +0800
> 
>     virtio_ring: introduce packed ring support
> 
>     Introduce the packed ring support. Packed ring can only be
>     created by vring_create_virtqueue() and each chunk of packed
>     ring will be allocated individually. Packed ring can not be
>     created on preallocated memory by vring_new_virtqueue() or
>     the likes currently.
> 
>     Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>


I think the assumption there was that intel has hardware that
requires packed. That's why Dave merged this.

> >
> >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 423 +++++++++++++++++++++++++++++++++--
> > >  1 file changed, 402 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 27a9459a0555..21d456392ba0 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -70,11 +70,14 @@
> > >  enum vq_layout {
> > >       SPLIT = 0,
> > >       PACKED,
> > > +     SPLIT_IN_ORDER,
> > > +     PACKED_IN_ORDER,
> > >       VQ_TYPE_MAX,
> > >  };
> > >
> > >  struct vring_desc_state_split {
> > >       void *data;                     /* Data for callback. */
> > > +     u32 total_len;                  /* Buffer Length */
> > >
> > >       /* Indirect desc table and extra table, if any. These two will be
> > >        * allocated together. So we won't stress more to the memory allocator.
> > > @@ -84,6 +87,7 @@ struct vring_desc_state_split {
> > >
> > >  struct vring_desc_state_packed {
> > >       void *data;                     /* Data for callback. */
> > > +     u32 total_len;                  /* Buffer Length */
> > >
> > >       /* Indirect desc table and extra table, if any. These two will be
> > >        * allocated together. So we won't stress more to the memory allocator.
> >
> > We are bloating up the cache footprint for everyone,
> > so there's a chance of regressions.
> > Pls include benchmark for in order off, to make sure we
> > are not regressing.
> 
> Ok.
> 
> > How big was the ring?
> 
> 256.

that is very modest, you want to fill at least one cache way,
preferably more.

> > Worth trying with a biggish one, where there is more cache
> > pressure.
> 
> Ok.
> 
> >
> >
> > Why not have a separate state for in-order?
> 
> It can work.
> 
> >
> >
> >
> > > @@ -206,6 +210,12 @@ struct vring_virtqueue {
> > >
> > >       /* Head of free buffer list. */
> > >       unsigned int free_head;
> > > +
> > > +     /* Head of the batched used buffers, vq->num means no batching */
> > > +     unsigned int batch_head;
> > > +
> > > +     unsigned int batch_len;
> > > +
> >
> > Are these two only used for in-order? Please document that.
> 
> Yes, I will do that.
> 
> > I also want some documentation about the batching trickery
> > used please.
> > What is batched, when, how is batching flushed, why are we
> > only batching in-order ...
> 
> I'm not sure I get things like this, what you want seems to be the
> behaviour of the device which has been stated by the spec or I may
> miss something here.

"a single used ring entry with the id corresponding to the
 head entry of the descriptor chain describing the last buffer in the
 batch"
?

so together they form this used ring entry describing the last buffer?
"head" is the id and "len" the length?

maybe

	/*
	 * With IN_ORDER, devices write a single used ring entry with
	 * the id corresponding to the head entry of the descriptor chain
	 * describing the last buffer in the batch
	 */
	struct used_entry {
		u32 id;
		u32 len;
	} batch_last;

?




> >
> >
> >
> >
> > >       /* Number we've added since last sync. */
> > >       unsigned int num_added;
> > >
> > > @@ -256,10 +266,14 @@ static void vring_free(struct virtqueue *_vq);
> > >
> > >  #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq)
> > >
> > > -
> > >  static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq)
> > >  {
> > > -     return vq->layout == PACKED;
> > > +     return vq->layout == PACKED || vq->layout == PACKED_IN_ORDER;
> > > +}
> > > +
> > > +static inline bool virtqueue_is_in_order(const struct vring_virtqueue *vq)
> > > +{
> > > +     return vq->layout == SPLIT_IN_ORDER || vq->layout == PACKED_IN_ORDER;
> > >  }
> > >
> > >  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> > > @@ -570,7 +584,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
> > >       struct vring_desc_extra *extra;
> > >       struct scatterlist *sg;
> > >       struct vring_desc *desc;
> > > -     unsigned int i, n, c, avail, descs_used, err_idx;
> > > +     unsigned int i, n, c, avail, descs_used, err_idx, total_len = 0;
> >
> >
> > I would add a comment here:
> >
> > /* Total length for in-order */
> > unsigned int total_len = 0;
> 
> Ok.
> 
> Thanks

