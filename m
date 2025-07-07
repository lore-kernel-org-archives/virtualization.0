Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A63214
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751858949; cv=none; b=tLshEYAC0OSkmXQfav7AvpPV37/1jGj+P6E6l8fX5SNgEEi/CP9qlpIONRT+wL38ZNOgqR39E7TJtq4U3pFx/0D4EdrZ/XZu4Z4OTzBZEr6F0br7TBEuHoa8oBm9te4eKTEmUU7sdJa0Cx74vdugRLuGc87hWqf4vaLZVjGulS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751858949; c=relaxed/simple;
	bh=t8lBA9sJk2oaDmMoVITCw9kuVZaUBAs7oQ7HLKOeWNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJCbOrq11MvRg/W3Y7ZbK4h6hbPRukGYsSQIrj+f5RqUwCfd7c7C3MX7kbt0qNfdpTXnlgMp6ZpkMqDmBLSUZFwCr/vo4MkiyAkrekCyFi6AYY9bI0HZcYJXd76ek7YyCmOQbmAXONvaQcJBRq+bTUNntK5pQGa6pHtMK2fCQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRVZBtc7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRVZBtc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751858945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzNSA6kkMVhvb3f9QSl7spHefBEQGUYGMFldNo6sZTU=;
	b=ZRVZBtc7K5oP6nCYXb0gmhNAW+TRNDc1KSmi3s0sC/iIWGOau9InLtT3GUHpELosX23Eks
	XzXdVyiVupbyJe5Bo3PfbQHfrpPZJajXIZiSLXcvx/oJ9U3K5MLFzL76DxXkbSU6vXml9W
	Tkbjh6CjC4FC8yUDyQJzY0WKRQ0P9vQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-tbCzBdyPPYCNHNGOQv2TzQ-1; Sun, 06 Jul 2025 23:29:04 -0400
X-MC-Unique: tbCzBdyPPYCNHNGOQv2TzQ-1
X-Mimecast-MFC-AGG-ID: tbCzBdyPPYCNHNGOQv2TzQ_1751858943
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso2627125a91.2
        for <virtualization@lists.linux.dev>; Sun, 06 Jul 2025 20:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751858943; x=1752463743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzNSA6kkMVhvb3f9QSl7spHefBEQGUYGMFldNo6sZTU=;
        b=hpsuhcK6nAMLQ7K52Ke2iACkSf4VhxIFicVWi3S5uqXOCYrlCl+w7lafGD4JjRrIxh
         P2nKGcLNUQrU7IjGAgWz5Cdc+NGNPgl9f2bC8JD9Id0Sdh/Wa/plrz2gyiHW5AXH7j2b
         eWMm5qUfn1ak9d3P5QXdsyM8ztY0PYF7NtnK64eYppoZME7PM+gaCudRxJdtGn4gqtL8
         C2yX2lPay0oFrAUoLbOty2Lfp/SJij+4gRmYnsqqJv/JZ4LKY8m1AUOLDkRyjYmyFVTr
         UTuFUcpJPqeN6zhS0fnfW2XxICc6eQ/GN375v+nXSIhQsVa0p+hNZdf2D3GJykCylwqS
         kWrA==
X-Forwarded-Encrypted: i=1; AJvYcCVlj5ZJVGncmpwpft2jMbHeY2ds/Ige8bDld+f3cxIb62GjpwHgdHGhwehCUralgni5qVbQPEpbmJ2IncpLqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyedmeKSYVEDxsYDQXu6fzFsDMOBmPC9/YGp1Ou11ieSI0ZApi5
	rhEH/sZ5NAFxG9+ucHISY7TIisIGJujRT6+ltEOTKq24vSS5qjz4buArLXtMjbSr72gWqwxPW5n
	ZewquhEZJyVZP83/bGAgPrlRGP+sO6t0DNwUosHXzH4OR9rX7dzBkVVbR/QuCAJ79E0IV8wkWql
	gEwQOn8ZZUnnMOAwpec4HRcQ8ORu6Sdp3raaAUQSpl2Pk=
X-Gm-Gg: ASbGncuusOk8HT80sP60Bw2kThN0p5ujFmeFCtWlxieoUwHNnVffjwmVf6WaYkP/joh
	tbEtZHgFDfX1VWc9kEiLMwuK/n3Lqra2CqmYrXhT4CDVxE2TKUAp1WdZTnKMlxtpxoDIM8x5LKy
	mm2dn6
X-Received: by 2002:a17:90b:3fc8:b0:315:9cae:bd8 with SMTP id 98e67ed59e1d1-31aba8d3d96mr8207906a91.23.1751858943035;
        Sun, 06 Jul 2025 20:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Qb25y+4enyWKDn3kQBS+LRjVY3jtnAM+5jtEXKrcrWZYxfPZbpbOBaHxKm2v5Ur5jcZ29cA0BpcIJMAqJ8U=
X-Received: by 2002:a17:90b:3fc8:b0:315:9cae:bd8 with SMTP id
 98e67ed59e1d1-31aba8d3d96mr8207869a91.23.1751858942418; Sun, 06 Jul 2025
 20:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616082518.10411-1-jasowang@redhat.com> <20250616082518.10411-20-jasowang@redhat.com>
 <20250701024602-mutt-send-email-mst@kernel.org> <CACGkMEuzTYPcDMamptLMQpSZu3gWxYx1Sr2nJef+pyuo2m35XQ@mail.gmail.com>
 <20250702064413-mutt-send-email-mst@kernel.org> <CACGkMEs0-FiRbUVTbtVyqPh=A8ufdW-Mh1XnR9hf8XQ7_Qf9sg@mail.gmail.com>
 <9c254fa8-7bb9-4484-8546-5f0a469619f9@oracle.com>
In-Reply-To: <9c254fa8-7bb9-4484-8546-5f0a469619f9@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Jul 2025 11:28:50 +0800
X-Gm-Features: Ac12FXzUnPOxqITJVGQ51EpXnL0jUPiDIDq-L2O6vC6-PTG-BHyVZ3Vkcn31pCk
Message-ID: <CACGkMEvH_S1_Uuzy6D28G9SZLFUPUK_b5puYUB+jgAWZ==FJ_Q@mail.gmail.com>
Subject: Re: [PATCH V3 19/19] virtio_ring: add in order support
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ShArkcg2r7PJFJ-n_u0BFuDopkBvC61_FE2POgB3mFo_1751858943
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 9:50=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
>
>
> On 7/2/25 11:13 PM, Jason Wang wrote:
> > On Wed, Jul 2, 2025 at 6:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >>
> >> On Wed, Jul 02, 2025 at 05:29:18PM +0800, Jason Wang wrote:
> >>> On Tue, Jul 1, 2025 at 2:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> >>>>
> >>>> On Mon, Jun 16, 2025 at 04:25:17PM +0800, Jason Wang wrote:
> >>>>> This patch implements in order support for both split virtqueue and
> >>>>> packed virtqueue.
> >>>>
> >>>> I'd like to see more motivation for this work, documented.
> >>>> It's not really performance, not as it stands, see below:
> >>>>
> >>>>>
> >>>>> Benchmark with KVM guest + testpmd on the host shows:
> >>>>>
> >>>>> For split virtqueue: no obvious differences were noticed
> >>>>>
> >>>>> For packed virtqueue:
> >>>>>
> >>>>> 1) RX gets 3.1% PPS improvements from 6.3 Mpps to 6.5 Mpps
> >>>>> 2) TX gets 4.6% PPS improvements from 8.6 Mpps to 9.0 Mpps
> >>>>>
> >>>>
> >>>> That's a very modest improvement for a lot of code.
> >>>> I also note you put in some batching just for in-order.
> >>>> Which could also explain the gains maybe?
> >>>> What if you just put in a simple implementation with no
> >>>> batching tricks? do you still see a gain?
> >>>
> >>> It is used to implement the batch used updating.
> >>>
> >>> """
> >>> Some devices always use descriptors in the same order in which they
> >>> have been made available. These devices can offer the
> >>> VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows
> >>> devices to notify the use of a batch of buffers to the driver by only
> >>> writing out a single used ring entry with the id corresponding to the
> >>> head entry of the descriptor chain describing the last buffer in the
> >>> batch.
> >>> """
> >>>
> >>> DPDK implements this behavior, so it's a must for the virtio driver.
> >>>
> >>>> Does any hardware implement this? Maybe that can demonstrate
> >>>> bigger gains.
> >>>
> >>> Maybe but I don't have one in my hand.
> >>>
> >>> For performance, I think it should be sufficient as a starter. I can
> >>> say in the next version something like "more optimizations could be
> >>> done on top"
> >>
> >> What are some optimizations you have in mind?
> >
> > One thing in my mind, spec currently said:
> >
> > """
> >   If negotiated, this knowledge allows devices to notify the use of a
> > batch of buffers to the driver by only writing out a single used
> > descriptor with the Buffer ID corresponding to the last descriptor in
> > the batch.
> > """
> >
> > If the device writes the last descriptor ID instead of the buffer ID
> > and skip the number of descriptors in the used ring. For split
> > virtqueue, the avail ring is not needed anymore. Device knows the
> > availability of buffers via avail_idx. In this way, we completely
> > eliminate the access of the available ring. This reduces the memory
> > access which is expensive for both:
> >
> > 1) kernel vhost-net where small user space memory access is expensive
> > 2) hardware PCI transactions
> >
> > Does this make sense?
> >
> >>
> >>
> >>
> >>> Note that the patch that introduces packed virtqueue, there's not eve=
n
> >>> any numbers:
> >>>
> >>> commit 1ce9e6055fa0a9043405c5604cf19169ec5379ff
> >>> Author: Tiwei Bie <tiwei.bie@intel.com>
> >>> Date:   Wed Nov 21 18:03:27 2018 +0800
> >>>
> >>>      virtio_ring: introduce packed ring support
> >>>
> >>>      Introduce the packed ring support. Packed ring can only be
> >>>      created by vring_create_virtqueue() and each chunk of packed
> >>>      ring will be allocated individually. Packed ring can not be
> >>>      created on preallocated memory by vring_new_virtqueue() or
> >>>      the likes currently.
> >>>
> >>>      Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> >>>      Signed-off-by: David S. Miller <davem@davemloft.net>
> >>
> >>
> >> I think the assumption there was that intel has hardware that
> >> requires packed. That's why Dave merged this.
> >
> > I think it should according to Qemu patch:
> >
> > commit c03213fdc9d7b680cc575cd1e725750702a10b09
> > Author: Jonah Palmer <jonah.palmer@oracle.com>
> > Date:   Wed Jul 10 08:55:18 2024 -0400
> >
> >      vhost,vhost-user: Add VIRTIO_F_IN_ORDER to vhost feature bits
> >
> >      Add support for the VIRTIO_F_IN_ORDER feature across a variety of =
vhost
> >      devices.
> >
> >      The inclusion of VIRTIO_F_IN_ORDER in the feature bits arrays for =
these
> >      devices ensures that the backend is capable of offering and provid=
ing
> >      support for this feature, and that it can be disabled if the backe=
nd
> >      does not support it.
> >
> >      Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >      Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >      Message-Id: <20240710125522.4168043-6-jonah.palmer@oracle.com>
> >      Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Adding Jonah for more thought here.
> >
>
> Hi. By "it should", are you referring to Intel having hardware requiring
> this feature? Sorry, just having a bit of trouble following.

I meant I guess you may have the hardware that supports IN_ORDER.

>
> In any case, this looks like a good first implementation that can be
> used as a foundation for future implementations to further improve its
> performance.

Right.

>
> This was the thought process I had when I implemented this feature in
> Qemu. That is, get a solid framework down that supports this feature
> (which had some small, modest performance improvements for some devices)
> and then add on future patches (perhaps device-specific and/or general
> implementations) that take advantage of the fact that data follows this
> FIFO model.
>
> As Jason mentioned, one such future implementation could remove the need
> for the use of the avail ring in the split VQ case since the device
> wouldn't need to read it to learn which descriptor comes next.

Right.

>
> Another example could be with vhost-net / vhost-vdpa. Currently each
> queue tracks 3 separate indices and keeps a per-descriptor bookkeeping
> table to handle buffers completing out of order. If the backend knows
> data is FIFO, we might be able to drop these trackers and just use a
> head and tail counter with a single contiguous iovec ring. This could
> result in a smaller cache footprint and fewer DMAs.

Exactly.

So I had a quick hack on vhost-net to implement this optimization
(bypasses the reading of available ring). It gives us 15.8%
improvement with this series. DPDK gives me 10% PPS as well.

https://github.com/jasowang/net/commit/719ce1d24e3369cde9c5fcc8c6d7518ca902=
2e5f

I think it should be sufficient to move forward even without real
hardware support. Maybe vhost-net part can go first.

Thanks

>
> Jonah
>
> >>
> >>>>
> >>>>
> >>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>>> ---
> >>>>>   drivers/virtio/virtio_ring.c | 423 ++++++++++++++++++++++++++++++=
+++--
> >>>>>   1 file changed, 402 insertions(+), 21 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> >>>>> index 27a9459a0555..21d456392ba0 100644
> >>>>> --- a/drivers/virtio/virtio_ring.c
> >>>>> +++ b/drivers/virtio/virtio_ring.c
> >>>>> @@ -70,11 +70,14 @@
> >>>>>   enum vq_layout {
> >>>>>        SPLIT =3D 0,
> >>>>>        PACKED,
> >>>>> +     SPLIT_IN_ORDER,
> >>>>> +     PACKED_IN_ORDER,
> >>>>>        VQ_TYPE_MAX,
> >>>>>   };
> >>>>>
> >>>>>   struct vring_desc_state_split {
> >>>>>        void *data;                     /* Data for callback. */
> >>>>> +     u32 total_len;                  /* Buffer Length */
> >>>>>
> >>>>>        /* Indirect desc table and extra table, if any. These two wi=
ll be
> >>>>>         * allocated together. So we won't stress more to the memory=
 allocator.
> >>>>> @@ -84,6 +87,7 @@ struct vring_desc_state_split {
> >>>>>
> >>>>>   struct vring_desc_state_packed {
> >>>>>        void *data;                     /* Data for callback. */
> >>>>> +     u32 total_len;                  /* Buffer Length */
> >>>>>
> >>>>>        /* Indirect desc table and extra table, if any. These two wi=
ll be
> >>>>>         * allocated together. So we won't stress more to the memory=
 allocator.
> >>>>
> >>>> We are bloating up the cache footprint for everyone,
> >>>> so there's a chance of regressions.
> >>>> Pls include benchmark for in order off, to make sure we
> >>>> are not regressing.
> >>>
> >>> Ok.
> >>>
> >>>> How big was the ring?
> >>>
> >>> 256.
> >>
> >> that is very modest, you want to fill at least one cache way,
> >> preferably more.
> >
> > I can test larger queue sizes.
> >
> >>
> >>>> Worth trying with a biggish one, where there is more cache
> >>>> pressure.
> >>>
> >>> Ok.
> >>>
> >>>>
> >>>>
> >>>> Why not have a separate state for in-order?
> >>>
> >>> It can work.
> >>>
> >>>>
> >>>>
> >>>>
> >>>>> @@ -206,6 +210,12 @@ struct vring_virtqueue {
> >>>>>
> >>>>>        /* Head of free buffer list. */
> >>>>>        unsigned int free_head;
> >>>>> +
> >>>>> +     /* Head of the batched used buffers, vq->num means no batchin=
g */
> >>>>> +     unsigned int batch_head;
> >>>>> +
> >>>>> +     unsigned int batch_len;
> >>>>> +
> >>>>
> >>>> Are these two only used for in-order? Please document that.
> >>>
> >>> Yes, I will do that.
> >>>
> >>>> I also want some documentation about the batching trickery
> >>>> used please.
> >>>> What is batched, when, how is batching flushed, why are we
> >>>> only batching in-order ...
> >>>
> >>> I'm not sure I get things like this, what you want seems to be the
> >>> behaviour of the device which has been stated by the spec or I may
> >>> miss something here.
> >>
> >> "a single used ring entry with the id corresponding to the
> >>   head entry of the descriptor chain describing the last buffer in the
> >>   batch"
> >> ?
> >
> > Exactly.
> >
> >>
> >> so together they form this used ring entry describing the last buffer?
> >> "head" is the id and "len" the length?
> >
> > Yes.
> >
> >>
> >> maybe
> >>
> >>          /*
> >>           * With IN_ORDER, devices write a single used ring entry with
> >>           * the id corresponding to the head entry of the descriptor c=
hain
> >>           * describing the last buffer in the batch
> >>           */
> >>          struct used_entry {
> >>                  u32 id;
> >>                  u32 len;
> >>          } batch_last;
> >>
> >> ?
> >
> > This should be fine.
> >
> >>
> >>
> >>
> >>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>>        /* Number we've added since last sync. */
> >>>>>        unsigned int num_added;
> >>>>>
> >>>>> @@ -256,10 +266,14 @@ static void vring_free(struct virtqueue *_vq)=
;
> >>>>>
> >>>>>   #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueu=
e, vq)
> >>>>>
> >>>>> -
> >>>>>   static inline bool virtqueue_is_packed(const struct vring_virtque=
ue *vq)
> >>>>>   {
> >>>>> -     return vq->layout =3D=3D PACKED;
> >>>>> +     return vq->layout =3D=3D PACKED || vq->layout =3D=3D PACKED_I=
N_ORDER;
> >>>>> +}
> >>>>> +
> >>>>> +static inline bool virtqueue_is_in_order(const struct vring_virtqu=
eue *vq)
> >>>>> +{
> >>>>> +     return vq->layout =3D=3D SPLIT_IN_ORDER || vq->layout =3D=3D =
PACKED_IN_ORDER;
> >>>>>   }
> >>>>>
> >>>>>   static bool virtqueue_use_indirect(const struct vring_virtqueue *=
vq,
> >>>>> @@ -570,7 +584,7 @@ static inline int virtqueue_add_split(struct vr=
ing_virtqueue *vq,
> >>>>>        struct vring_desc_extra *extra;
> >>>>>        struct scatterlist *sg;
> >>>>>        struct vring_desc *desc;
> >>>>> -     unsigned int i, n, c, avail, descs_used, err_idx;
> >>>>> +     unsigned int i, n, c, avail, descs_used, err_idx, total_len =
=3D 0;
> >>>>
> >>>>
> >>>> I would add a comment here:
> >>>>
> >>>> /* Total length for in-order */
> >>>> unsigned int total_len =3D 0;
> >>>
> >>> Ok.
> >>>
> >>> Thanks
> >>
> >
>

