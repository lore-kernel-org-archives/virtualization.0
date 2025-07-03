Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BEB227BB5
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512454; cv=none; b=OaylU4Vwx9fz72AcuYtIUzJ1SUXJ+IP8naXF8CeiadGZyhoAZVO39W7x2UajAQDhRbLA7GYYgtlZSMVB2R1dj1bcJJoHdBWWshuJxlHLCUqEWwOAYDoVJMu/UIdLnQWs6vHIMc2EJEUQclUtUAb3tS4fbn/SCmFxn4CB7UUoNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512454; c=relaxed/simple;
	bh=pMOSR+Ba6+A9Eh401EjLUYOiCvMDSPaRSBZH2LjAYGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dar/aJOoXYu7cP1KR3a4kHq+JVNnpowjkQ2ZaVen3EWjUP1SuNuTZkx6SXSwc9GmMaXi2YFoyMset/1jHggSLQzFmVb3XPncuHmXIItV1zRS+/l6WFIOooXD1jQ6QIWYq3Rq3ltZ6lZJ8P8sC2VHOoVZzr39Xmfp6APqjueXRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGSNxtzI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGSNxtzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751512451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRIW5pbrJtZ6KIhhLr9tLMcbjMGeAtZxWrxYegWLOvk=;
	b=fGSNxtzIVFXQ52MCQk4aTIPsnkFpp0TTEg4kDpaGnXcGqmP1rkkLkgOZ8+pYyQ/9swaYbv
	oTGzmG11Pv8WZ41Vu3xdtvcbDK/m8SFIg6FYjgmZRYEZnUxoDbxBQMNJvg3/FDokpLV33I
	4BOAdTjkIGFQKwYIr6evzXIxgGEzKxs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-l9fbS-CZORyXqb-wExgBuw-1; Wed, 02 Jul 2025 23:14:08 -0400
X-MC-Unique: l9fbS-CZORyXqb-wExgBuw-1
X-Mimecast-MFC-AGG-ID: l9fbS-CZORyXqb-wExgBuw_1751512447
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so6494109a91.1
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 20:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512447; x=1752117247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRIW5pbrJtZ6KIhhLr9tLMcbjMGeAtZxWrxYegWLOvk=;
        b=AyHBYOL8WuHY6LDdizB5sQnhIqgJSzvvx4zh5L7/QEEV9A0VZs4KMJ5rizcgMEZjTi
         bYyI1qK/4Bp//PMP3xJ7g9LXQxwXRDLNOeZeJsiWYT5mN7PQSqIh3kAGDsbzX7o6WIct
         hfJkwDyqh1QshISJ3sRfINT9L7SXIV/VQ+fZaYvXXF+xwQBJZHWgEUs9bO6yGzfLwe2K
         ksgx7S7f3yP9s3tOUBzmFBh2gSJkLtBzPBpYvfAdmYIo81SItherIE9wpDvIm9niN+g7
         x+ZJjOWVn9sT1XA0eDLfhMmENkl5KPuLN1CdiZ+hApRRBwc2a7kyNig97i8aibtMC2Z5
         ZsOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4htEGb1S4Zpc9yDY4z05HJvpSYW5Hu6UoH4zX6Z4wqnqBGo9udlr3QJX2lELMXL4W6rgAov+aKgnojyEeug==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUYNm8aBrSyLaJDq9m5HPNLfWW7GWcWWsoeI+7HuOWW2wwtSa7
	3wZz5858o1HTM7SCKzRXNqdczuHXCIXUr2So68zFvjfcgF5b7BwuMclXCmedZlhUPXwr9Vgz8Ft
	YWtNsfwfi/I3Q/05aA1rFlftuWDcrArFTtvM5UqgZsJNUR7Tb3O22YfXOv3jTx2nMR719g+HySl
	0ckGHlBBsiV9HGG4uvlfp3T67nabBZCe/6NKfNFE53wVc=
X-Gm-Gg: ASbGncuTOMbJFQVB0Z+Jcg53OLBVsaO34sOFFvLr2aOCZdVskqqrJiEKtLIVu6Rwr3w
	2WLRE33RO+htP6a+jMC2fbExh101sSZIqpSinMzgDHfFl6/3tlQigI3AG5QQenBxjONYxZ5HKB2
	KaDgbs
X-Received: by 2002:a17:90b:4b11:b0:311:fde5:c4c2 with SMTP id 98e67ed59e1d1-31a9d57d983mr2241299a91.1.1751512446730;
        Wed, 02 Jul 2025 20:14:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNPprkHjmFCaG5ZezUgnHfsLYn1qY2/eNgQxJTgFAdsg1SexMlL8reb1Iy78Be/MZbDT3KSwi9g4t5kGsHosI=
X-Received: by 2002:a17:90b:4b11:b0:311:fde5:c4c2 with SMTP id
 98e67ed59e1d1-31a9d57d983mr2241252a91.1.1751512446185; Wed, 02 Jul 2025
 20:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616082518.10411-1-jasowang@redhat.com> <20250616082518.10411-20-jasowang@redhat.com>
 <20250701024602-mutt-send-email-mst@kernel.org> <CACGkMEuzTYPcDMamptLMQpSZu3gWxYx1Sr2nJef+pyuo2m35XQ@mail.gmail.com>
 <20250702064413-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250702064413-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 3 Jul 2025 11:13:54 +0800
X-Gm-Features: Ac12FXwdZitM7cr8QECMFGaDxCYqGvGIjQXb0mGKXn4BjTMZqkxnxiDHrz98zA0
Message-ID: <CACGkMEs0-FiRbUVTbtVyqPh=A8ufdW-Mh1XnR9hf8XQ7_Qf9sg@mail.gmail.com>
Subject: Re: [PATCH V3 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jonah Palmer <jonah.palmer@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6l-Al5ZIjtjvOIOpfsL-6E1Cq0HZpjMjwNeLmd1v3C4_1751512447
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Jul 02, 2025 at 05:29:18PM +0800, Jason Wang wrote:
> > On Tue, Jul 1, 2025 at 2:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Mon, Jun 16, 2025 at 04:25:17PM +0800, Jason Wang wrote:
> > > > This patch implements in order support for both split virtqueue and
> > > > packed virtqueue.
> > >
> > > I'd like to see more motivation for this work, documented.
> > > It's not really performance, not as it stands, see below:
> > >
> > > >
> > > > Benchmark with KVM guest + testpmd on the host shows:
> > > >
> > > > For split virtqueue: no obvious differences were noticed
> > > >
> > > > For packed virtqueue:
> > > >
> > > > 1) RX gets 3.1% PPS improvements from 6.3 Mpps to 6.5 Mpps
> > > > 2) TX gets 4.6% PPS improvements from 8.6 Mpps to 9.0 Mpps
> > > >
> > >
> > > That's a very modest improvement for a lot of code.
> > > I also note you put in some batching just for in-order.
> > > Which could also explain the gains maybe?
> > > What if you just put in a simple implementation with no
> > > batching tricks? do you still see a gain?
> >
> > It is used to implement the batch used updating.
> >
> > """
> > Some devices always use descriptors in the same order in which they
> > have been made available. These devices can offer the
> > VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows
> > devices to notify the use of a batch of buffers to the driver by only
> > writing out a single used ring entry with the id corresponding to the
> > head entry of the descriptor chain describing the last buffer in the
> > batch.
> > """
> >
> > DPDK implements this behavior, so it's a must for the virtio driver.
> >
> > > Does any hardware implement this? Maybe that can demonstrate
> > > bigger gains.
> >
> > Maybe but I don't have one in my hand.
> >
> > For performance, I think it should be sufficient as a starter. I can
> > say in the next version something like "more optimizations could be
> > done on top"
>
> What are some optimizations you have in mind?

One thing in my mind, spec currently said:

"""
 If negotiated, this knowledge allows devices to notify the use of a
batch of buffers to the driver by only writing out a single used
descriptor with the Buffer ID corresponding to the last descriptor in
the batch.
"""

If the device writes the last descriptor ID instead of the buffer ID
and skip the number of descriptors in the used ring. For split
virtqueue, the avail ring is not needed anymore. Device knows the
availability of buffers via avail_idx. In this way, we completely
eliminate the access of the available ring. This reduces the memory
access which is expensive for both:

1) kernel vhost-net where small user space memory access is expensive
2) hardware PCI transactions

Does this make sense?

>
>
>
> > Note that the patch that introduces packed virtqueue, there's not even
> > any numbers:
> >
> > commit 1ce9e6055fa0a9043405c5604cf19169ec5379ff
> > Author: Tiwei Bie <tiwei.bie@intel.com>
> > Date:   Wed Nov 21 18:03:27 2018 +0800
> >
> >     virtio_ring: introduce packed ring support
> >
> >     Introduce the packed ring support. Packed ring can only be
> >     created by vring_create_virtqueue() and each chunk of packed
> >     ring will be allocated individually. Packed ring can not be
> >     created on preallocated memory by vring_new_virtqueue() or
> >     the likes currently.
> >
> >     Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
>
>
> I think the assumption there was that intel has hardware that
> requires packed. That's why Dave merged this.

I think it should according to Qemu patch:

commit c03213fdc9d7b680cc575cd1e725750702a10b09
Author: Jonah Palmer <jonah.palmer@oracle.com>
Date:   Wed Jul 10 08:55:18 2024 -0400

    vhost,vhost-user: Add VIRTIO_F_IN_ORDER to vhost feature bits

    Add support for the VIRTIO_F_IN_ORDER feature across a variety of vhost
    devices.

    The inclusion of VIRTIO_F_IN_ORDER in the feature bits arrays for these
    devices ensures that the backend is capable of offering and providing
    support for this feature, and that it can be disabled if the backend
    does not support it.

    Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
    Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
    Message-Id: <20240710125522.4168043-6-jonah.palmer@oracle.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Adding Jonah for more thought here.

>
> > >
> > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 423 +++++++++++++++++++++++++++++++=
++--
> > > >  1 file changed, 402 insertions(+), 21 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 27a9459a0555..21d456392ba0 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -70,11 +70,14 @@
> > > >  enum vq_layout {
> > > >       SPLIT =3D 0,
> > > >       PACKED,
> > > > +     SPLIT_IN_ORDER,
> > > > +     PACKED_IN_ORDER,
> > > >       VQ_TYPE_MAX,
> > > >  };
> > > >
> > > >  struct vring_desc_state_split {
> > > >       void *data;                     /* Data for callback. */
> > > > +     u32 total_len;                  /* Buffer Length */
> > > >
> > > >       /* Indirect desc table and extra table, if any. These two wil=
l be
> > > >        * allocated together. So we won't stress more to the memory =
allocator.
> > > > @@ -84,6 +87,7 @@ struct vring_desc_state_split {
> > > >
> > > >  struct vring_desc_state_packed {
> > > >       void *data;                     /* Data for callback. */
> > > > +     u32 total_len;                  /* Buffer Length */
> > > >
> > > >       /* Indirect desc table and extra table, if any. These two wil=
l be
> > > >        * allocated together. So we won't stress more to the memory =
allocator.
> > >
> > > We are bloating up the cache footprint for everyone,
> > > so there's a chance of regressions.
> > > Pls include benchmark for in order off, to make sure we
> > > are not regressing.
> >
> > Ok.
> >
> > > How big was the ring?
> >
> > 256.
>
> that is very modest, you want to fill at least one cache way,
> preferably more.

I can test larger queue sizes.

>
> > > Worth trying with a biggish one, where there is more cache
> > > pressure.
> >
> > Ok.
> >
> > >
> > >
> > > Why not have a separate state for in-order?
> >
> > It can work.
> >
> > >
> > >
> > >
> > > > @@ -206,6 +210,12 @@ struct vring_virtqueue {
> > > >
> > > >       /* Head of free buffer list. */
> > > >       unsigned int free_head;
> > > > +
> > > > +     /* Head of the batched used buffers, vq->num means no batchin=
g */
> > > > +     unsigned int batch_head;
> > > > +
> > > > +     unsigned int batch_len;
> > > > +
> > >
> > > Are these two only used for in-order? Please document that.
> >
> > Yes, I will do that.
> >
> > > I also want some documentation about the batching trickery
> > > used please.
> > > What is batched, when, how is batching flushed, why are we
> > > only batching in-order ...
> >
> > I'm not sure I get things like this, what you want seems to be the
> > behaviour of the device which has been stated by the spec or I may
> > miss something here.
>
> "a single used ring entry with the id corresponding to the
>  head entry of the descriptor chain describing the last buffer in the
>  batch"
> ?

Exactly.

>
> so together they form this used ring entry describing the last buffer?
> "head" is the id and "len" the length?

Yes.

>
> maybe
>
>         /*
>          * With IN_ORDER, devices write a single used ring entry with
>          * the id corresponding to the head entry of the descriptor chain
>          * describing the last buffer in the batch
>          */
>         struct used_entry {
>                 u32 id;
>                 u32 len;
>         } batch_last;
>
> ?

This should be fine.

>
>
>
>
> > >
> > >
> > >
> > >
> > > >       /* Number we've added since last sync. */
> > > >       unsigned int num_added;
> > > >
> > > > @@ -256,10 +266,14 @@ static void vring_free(struct virtqueue *_vq)=
;
> > > >
> > > >  #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue=
, vq)
> > > >
> > > > -
> > > >  static inline bool virtqueue_is_packed(const struct vring_virtqueu=
e *vq)
> > > >  {
> > > > -     return vq->layout =3D=3D PACKED;
> > > > +     return vq->layout =3D=3D PACKED || vq->layout =3D=3D PACKED_I=
N_ORDER;
> > > > +}
> > > > +
> > > > +static inline bool virtqueue_is_in_order(const struct vring_virtqu=
eue *vq)
> > > > +{
> > > > +     return vq->layout =3D=3D SPLIT_IN_ORDER || vq->layout =3D=3D =
PACKED_IN_ORDER;
> > > >  }
> > > >
> > > >  static bool virtqueue_use_indirect(const struct vring_virtqueue *v=
q,
> > > > @@ -570,7 +584,7 @@ static inline int virtqueue_add_split(struct vr=
ing_virtqueue *vq,
> > > >       struct vring_desc_extra *extra;
> > > >       struct scatterlist *sg;
> > > >       struct vring_desc *desc;
> > > > -     unsigned int i, n, c, avail, descs_used, err_idx;
> > > > +     unsigned int i, n, c, avail, descs_used, err_idx, total_len =
=3D 0;
> > >
> > >
> > > I would add a comment here:
> > >
> > > /* Total length for in-order */
> > > unsigned int total_len =3D 0;
> >
> > Ok.
> >
> > Thanks
>

