Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0202E1C6B
	for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766992526; cv=none; b=AikS2f/yA/WSb1xWhNKFEApj5XvBEyqO5YdBKHBaa/Ucy4ozccPSWz7W8Da8EOayYWQ9bLYtVYJbhH0pEiP2eIdrLaqS71SnhMhX0xY/d8S3+kuObVcua2fjRMGZvLRINoifaNKS8KNajj8AO/KcKaN8R5jMj4aTspIWBxXy+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766992526; c=relaxed/simple;
	bh=zs6U0BbtFrF8az5bUFkrk0w4wKt4CXd1zKvtSE+QNXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgaw3dIIUzZ5PZSnRloDuY9Aw9BTLzzZInYWcbu1ozCE9bT0t0npnFB5e2NfkkJzn75Ac7+YvXNHWG/gQyK19efgMfOjjCNtaSepsGhS43YN/NcUX2A9CSIO8sBIU/CS0aUXez9FLysxxmIbITgKCfeHhaI2TJIjE3qKLqIPZMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJBBzoaU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJBBzoaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766992521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSfEwxdQLdmC7PzKVRTAggdJV02TNJl4LPhlVlFIEto=;
	b=LJBBzoaUM62z/0prJsOUm8zATGlikDtsIGeJmQ81IUAf2eI4IlPU6J78rcTDGhXCKSJQVi
	LzdA+rcWoLexJ90J+bD9vjwZBhIl3bgz1jlvZt12jl+383TBqjFv+Zjr1IV4tXTPnanE92
	QAaLEgTfs0qaX78KNNA0Mty6i1vcHt4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-YT1A9-0aP5eGB4BQSIsL7g-1; Mon, 29 Dec 2025 02:15:19 -0500
X-MC-Unique: YT1A9-0aP5eGB4BQSIsL7g-1
X-Mimecast-MFC-AGG-ID: YT1A9-0aP5eGB4BQSIsL7g_1766992518
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c66cb671fso12555989a91.3
        for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 23:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766992518; x=1767597318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSfEwxdQLdmC7PzKVRTAggdJV02TNJl4LPhlVlFIEto=;
        b=w7PLdsxisL3O7pRHOAVUz9bsr5M1P9Pyu/6toUFycnzEmbFr7V2IFrWk+P+LbB8113
         CAxXQfBHQkBZiQSTl7G/9IrW6i/arKFzx/KBMxbEi/xZCp8dvx8DV/QOkEh0RKHXkXVY
         4haT3TincHoTU0d9YVdPgTNJeLiCUnM/VVmu/A4sAwcbm3Ep1Fae581QmYnN7Dk94BIQ
         jUx1+E9a4bTaKAo6ONzeNI7oeWHq39sO5R62TsoKObKp/ayu2CZauGxr7NJ/TGhqw3Xk
         gkepuJO/t1VF5/ev5TGxr9di9RnC7Y43U+SADuL5P6uW9QXnEoZll45opHa9m1IjnMTp
         PorA==
X-Forwarded-Encrypted: i=1; AJvYcCWCKuCIkFFEOE4ETsZ3bx0Nqi1jjObgBy5C84eQ0kua9S6ZSO+QCLFvm6gjBRGo7HyDBYd4FXPcBemGCmhF+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMkz9JDxWWPSDFgAHiyD3otdXPEs0I8qxykwER6Mw/w2Mb5Sqs
	Heuuq9eKFH8vsArr/Pa+syPGCVPDzwi69d1/6o0QlnB/+qT7JAH/DwGdQ/n3M0AWK1qkK5XUtaU
	Z7gxC67l5tkHJ+dyVGAs9tjRfw9KdVf707+nubLE/ffjuW4lHxXBRvnr/6merJaLVOpJx4s6Hxz
	0pW0WWKD3mXVPr4vtNa3oqqLoYBG79AlnvfuGPGdWP5d4=
X-Gm-Gg: AY/fxX6dmcMDnMDjCVmIFGE6V7nkdcd9GQ02NcTLowaGruThrFQq/cML4868+vcdO4U
	3pupMpniCs06eGKJ+kpMsBFKmljqM3oPJ5/6OWuMEobi0QuACwyCRSzGlNaKrj2U3O9Ry1wgtkS
	jwDTUAjBjJy8oBred4tYRJWtp5de4CQ2pCKqRybyRo/f7zsN0j+jslwbTxV9CrdfEgnhI=
X-Received: by 2002:a05:6a20:244e:b0:34f:241f:aa1e with SMTP id adf61e73a8af0-376a7fe2e5cmr28317409637.31.1766992517824;
        Sun, 28 Dec 2025 23:15:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8k3iAe2MOpXkOnBazK0aY5USW3kWpzxzrXsa6upmySc1aZ9pz2lIGu9vMvG7aFTaKDyl0GQzI53ZjcMF6cTA=
X-Received: by 2002:a05:6a20:244e:b0:34f:241f:aa1e with SMTP id
 adf61e73a8af0-376a7fe2e5cmr28317387637.31.1766992517282; Sun, 28 Dec 2025
 23:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251225042608.32350-1-jasowang@redhat.com> <20251225042608.32350-20-jasowang@redhat.com>
 <20251226145001-mutt-send-email-mst@kernel.org> <20251227050526-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251227050526-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Dec 2025 15:15:06 +0800
X-Gm-Features: AQt7F2qT720tRffeB_cRV93LLdPOfVSOLhtSgKVzj2DNDQNFyz1qbb6m5x1JiT0
Message-ID: <CACGkMEuc2pNao96nTrVQD0VOdpYHk_gbS+K8X5n_J_iiJUVqkg@mail.gmail.com>
Subject: Re: [PATCH V11 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: elC_N_NHwiULvHHEETRjn6gocraUT1TjjeJnUwcG5wk_1766992518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 6:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Dec 26, 2025 at 02:57:03PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 25, 2025 at 12:26:08PM +0800, Jason Wang wrote:
> > > This patch implements in order support for both split virtqueue and
> > > packed virtqueue. Performance could be gained for the device where th=
e
> > > memory access could be expensive (e.g vhost-net or a real PCI device)=
:
> > >
> > > Benchmark with KVM guest:
> > >
> > > Vhost-net on the host: (pktgen + XDP_DROP):
> > >
> > >          in_order=3Doff | in_order=3Don | +%
> > >     TX:  4.51Mpps     | 5.30Mpps    | +17%
> > >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> > >
> > > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> > >
> > > For split virtqueue:
> > >
> > >          in_order=3Doff | in_order=3Don | +%
> > >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> > >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> > >
> > > For packed virtqueue:
> > >
> > >          in_order=3Doff | in_order=3Don | +%
> > >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> > >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> > >
> > > Benchmark also shows no performance impact for in_order=3Doff for que=
ue
> > > size with 256 and 1024.
> > >
> > > Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 455 +++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 432 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 61884e031b94..d1bcd1d8c66b 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -70,6 +70,8 @@
> > >  enum vq_layout {
> > >     SPLIT =3D 0,
> > >     PACKED,
> > > +   SPLIT_IN_ORDER,
> > > +   PACKED_IN_ORDER,
> > >     VQ_TYPE_MAX,
> > >  };
> > >
> > > @@ -80,6 +82,7 @@ struct vring_desc_state_split {
> > >      * allocated together. So we won't stress more to the memory allo=
cator.
> > >      */
> > >     struct vring_desc *indir_desc;
> > > +   u32 total_in_len;
> > >  };
> > >
> > >  struct vring_desc_state_packed {
> > > @@ -91,6 +94,7 @@ struct vring_desc_state_packed {
> > >     struct vring_packed_desc *indir_desc;
> > >     u16 num;                        /* Descriptor list length. */
> > >     u16 last;                       /* The last desc state in a list.=
 */
> > > +   u32 total_in_len;
> > >  };
> > >
> >
> > So let's be clear. Is this the device-written length or the driver supp=
lied
> > length?
> >
> >
> > >  struct vring_desc_extra {
> > > @@ -205,8 +209,24 @@ struct vring_virtqueue {
> > >
> > >     enum vq_layout layout;
> > >
> > > -   /* Head of free buffer list. */
> > > +   /*
> > > +    * Without IN_ORDER it's the head of free buffer list. With
> > > +    * IN_ORDER and SPLIT, it's the next available buffer
> > > +    * index. With IN_ORDER and PACKED, it's unused.
> > > +    */
> > >     unsigned int free_head;
> > > +
> > > +   /*
> > > +    * With IN_ORDER, once we see an in-order batch, this stores
> > > +    * this last entry, and until we return the last buffer.
> > > +    * After this, id is set to UINT_MAX to mark it invalid.
> > > +    * Unused without IN_ORDER.
> > > +    */
> > > +   struct used_entry {
> > > +           u32 id;
> > > +           u32 len;
> > > +   } batch_last;
> > > +
> > >     /* Number we've added since last sync. */
> > >     unsigned int num_added;
> > >
> > > @@ -218,6 +238,11 @@ struct vring_virtqueue {
> > >      */
> > >     u16 last_used_idx;
> > >
> > > +   /* With IN_ORDER and SPLIT, last descriptor id we used to
> > > +    * detach buffer.
> > > +    */
> > > +   u16 last_used;
> > > +
> > >     /* Hint for event idx: already triggered no need to disable. */
> > >     bool event_triggered;
> > >
> > > @@ -259,7 +284,12 @@ static void vring_free(struct virtqueue *_vq);
> > >
> > >  static inline bool virtqueue_is_packed(const struct vring_virtqueue =
*vq)
> > >  {
> > > -   return vq->layout =3D=3D PACKED;
> > > +   return vq->layout =3D=3D PACKED || vq->layout =3D=3D PACKED_IN_OR=
DER;
> > > +}
> > > +
> > > +static inline bool virtqueue_is_in_order(const struct vring_virtqueu=
e *vq)
> > > +{
> > > +   return vq->layout =3D=3D SPLIT_IN_ORDER || vq->layout =3D=3D PACK=
ED_IN_ORDER;
> > >  }
> > >
> > >  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> > > @@ -469,6 +499,8 @@ static void virtqueue_init(struct vring_virtqueue=
 *vq, u32 num)
> > >     else
> > >             vq->last_used_idx =3D 0;
> > >
> > > +   vq->last_used =3D 0;
> > > +
> > >     vq->event_triggered =3D false;
> > >     vq->num_added =3D 0;
> > >
> > > @@ -576,6 +608,8 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> > >     struct scatterlist *sg;
> > >     struct vring_desc *desc;
> > >     unsigned int i, n, avail, descs_used, err_idx, sg_count =3D 0;
> > > +   /* Total length for in-order */
> > > +   unsigned int total_in_len =3D 0;
> > >     int head;
> > >     bool indirect;
> > >
> > > @@ -667,6 +701,7 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> > >                      */
> > >                     i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr,
> > >                                                  len, flags, premappe=
d);
> > > +                   total_in_len +=3D len;
> > >             }
> > >     }
> > >
> > > @@ -689,7 +724,12 @@ static inline int virtqueue_add_split(struct vri=
ng_virtqueue *vq,
> > >     vq->vq.num_free -=3D descs_used;
> > >
> > >     /* Update free pointer */
> > > -   if (indirect)
> > > +   if (virtqueue_is_in_order(vq)) {
> > > +           vq->free_head +=3D descs_used;
> > > +           if (vq->free_head >=3D vq->split.vring.num)
> > > +                   vq->free_head -=3D vq->split.vring.num;
> > > +           vq->split.desc_state[head].total_in_len =3D total_in_len;
> >
> >
> > Looks like total_in_len is the driver supplied length?
> >
> > > +   } else if (indirect)
> > >             vq->free_head =3D vq->split.desc_extra[head].next;
> > >     else
> > >             vq->free_head =3D i;
> > > @@ -862,6 +902,14 @@ static bool more_used_split(const struct vring_v=
irtqueue *vq)
> > >     return virtqueue_poll_split(vq, vq->last_used_idx);
> > >  }
> > >
> > > +static bool more_used_split_in_order(const struct vring_virtqueue *v=
q)
> > > +{
> > > +   if (vq->batch_last.id !=3D UINT_MAX)
> > > +           return true;
> > > +
> > > +   return virtqueue_poll_split(vq, vq->last_used_idx);
> > > +}
> > > +
> > >  static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
> > >                                      unsigned int *len,
> > >                                      void **ctx)
> > > @@ -919,6 +967,76 @@ static void *virtqueue_get_buf_ctx_split(struct =
vring_virtqueue *vq,
> > >     return ret;
> > >  }
> > >
> > > +static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtq=
ueue *vq,
> > > +                                             unsigned int *len,
> > > +                                             void **ctx)
> > > +{
> > > +   void *ret;
> > > +   unsigned int num =3D vq->split.vring.num;
> > > +   unsigned int num_free =3D vq->vq.num_free;
> > > +   u16 last_used, last_used_idx;
> > > +
> > > +   START_USE(vq);
> > > +
> > > +   if (unlikely(vq->broken)) {
> > > +           END_USE(vq);
> > > +           return NULL;
> > > +   }
> > > +
> > > +   last_used =3D vq->last_used & (num - 1);
> > > +   last_used_idx =3D vq->last_used_idx & (num - 1);
> > > +
> > > +   if (vq->batch_last.id =3D=3D UINT_MAX) {
> > > +           if (!more_used_split_in_order(vq)) {
> > > +                   pr_debug("No more buffers in queue\n");
> > > +                   END_USE(vq);
> > > +                   return NULL;
> > > +           }
> > > +
> > > +           /*
> > > +            * Only get used array entries after they have been
> > > +            * exposed by host.
> > > +            */
> > > +           virtio_rmb(vq->weak_barriers);
> > > +
> > > +           vq->batch_last.id =3D virtio32_to_cpu(vq->vq.vdev,
> > > +                               vq->split.vring.used->ring[last_used_=
idx].id);
> > > +           vq->batch_last.len =3D virtio32_to_cpu(vq->vq.vdev,
> > > +                                vq->split.vring.used->ring[last_used=
_idx].len);
> > > +   }
> > > +
> > > +   if (vq->batch_last.id =3D=3D last_used) {
> > > +           vq->batch_last.id =3D UINT_MAX;
> > > +           *len =3D vq->batch_last.len;
> > > +   } else {
> > > +           *len =3D vq->split.desc_state[last_used].total_in_len;
> > > +   }
> >
> >
> > but now we return this as buffer length? I think the expected value
> > here is the used length, not the driver supplied one?
> >
> >
> >
> > Same questions apply to packed.
> >
>
> Ah, I got it. These are the skipped buffers:
>
>         The skipped buffers (for which no used descriptor was written)
>         are assumed to have been used (read or written) by the
>         device completely.
>
> maybe a comment won't hurt here. Can be a patch on top.
>

I've fixed this in the new version.

Thanks

