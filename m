Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93451F16B
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761016925; cv=none; b=RouWbSTJRlmGp0UiMsAxwW9YZ7Guf/oXQ7Vn0hnPwP1787pMO574aUWZHmW7TycQ7hz43hcw6J6gXJQx1NuypXY65lnSaaJcgkun088XzfN+9XMFYy4A84tjNAfz2f+tBJ8HsXG64uzH0QBJkFCvlatsyf8zq3edkO1fg/cj78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761016925; c=relaxed/simple;
	bh=erkW1KTSIwxuHi3Wqh2oODhT0lopT0ZDvAd3XDlbF6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCPysDYEQdE67OESuH/vseLqIWbAVyegxdkJuW2GSo4SuF1D+owFlCuI/tetLOd4AHC9yFPtXD5ch7ntTMDE6wR7ALv5GXGoGNIVE2lWDTSA3+WycY50WbpIIBsyDTNY/YKqZXwiPVQTJNc5xlHKoaOJysaKUdcKJds5NEgxEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6Joc/KX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6Joc/KX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761016921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRUfPsgwsj/KjPpuBmVFYilvOa8QEPRJKgZd71wjw9w=;
	b=U6Joc/KXxNKABFD4z5q1Mof//I2fD0n/sfbcJHgNRFIJEqrbdzEpxzVntXtNjgMg+5vOH6
	lbOwRZ7PuEHquCJraHbP1gYvU0QSuByzMoAKrvCbizfJovwMBZXwntIBFk2M1ymbbulaTB
	6ugukym4wr7OYY1poA+4HI9TOp2kUpE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-GDSoag5fOqSE4vcVIud8DQ-1; Mon, 20 Oct 2025 23:22:00 -0400
X-MC-Unique: GDSoag5fOqSE4vcVIud8DQ-1
X-Mimecast-MFC-AGG-ID: GDSoag5fOqSE4vcVIud8DQ_1761016919
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so4165381a91.2
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 20:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761016919; x=1761621719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRUfPsgwsj/KjPpuBmVFYilvOa8QEPRJKgZd71wjw9w=;
        b=XhOSuUNJHuj6sOFnF8/I4xtQoFWFapdRUAW8lAEI2mzHq34BGOeGQiwPoKn0nx37+2
         Z5MyjWsf9IMRnovVbceZnA86vsctZyo9DnupM0pm8ZBY8x/6QaPqT89sJKyBrU7jH1QI
         JSbeJ30BsuFQKwYkNZ1T2KACydhSVnipvrfgn/Pg4QhOrNLoOdU5nJYpN+0G2hKOqoYO
         tteROHtMglEjP8PteTKQvz3c+iHNsRCOyyjYHa8QkPS2Jldxby3PEgooQZar0jzWmdaH
         Bo9wP6tbYa0GVMQeZWwpMX4r8LjhviESnuojQaBbP8dwLVAvnuQOX6OX+0MmrPwSMWzR
         EBNg==
X-Forwarded-Encrypted: i=1; AJvYcCUvAw/+tcVuGA6ufwB4YqsqaMNOFdFHDL9uzkwR+XOSaFOutrPLcGc5q8tFmBiy5ygDoPeA+mDq8UMeZ/JZCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqUNDYXj1ohOxAI1g3REdZs/dFGf1AvXcWVO8dVX4WoLQJkyEg
	GIEZfQXl5tABjcIR+LOSyK/dJhokUrtu0T0w2bSeD3plkckbfT8/9ddWKekiWuQ41TkQx7jzoIt
	qk9gqiLbnCVYZNyZuPX0uMzFxYZZptYJ9TkhWj719seimqVzTs4EVYXe5fyncPGTyBhFnL9TynS
	OLrMx0sGJVz+D5NeTn9SncyYUoA9qg8AGX0kow+vExV+4=
X-Gm-Gg: ASbGncvhjxlzuz78OQMl9s0hqEW6CKMWcbCpOX3LEz21IbEAK9TcTg1LWeTSDWnDqPd
	uWqitYXyBD8rSoKjOYX+YYPSG40Ljxs62B9C3aW0psD9PhL0E+FmrzAOnXL4JL4SSstUgwXy7hn
	OGviEXSES/L7bofDw/EloQfbL/4pM1VusL1tyhGEGmCXbBjO1zKfb/oxOi
X-Received: by 2002:a17:90b:6cd:b0:32e:87f6:f5a6 with SMTP id 98e67ed59e1d1-33bceb1eb5emr18602236a91.0.1761016919030;
        Mon, 20 Oct 2025 20:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx2mm6nQN8rs2Oq78KNadBFLODQfiO2r+yVlsezvxnfC5JYzMJbQcQdfM8NA36rE2gxC/6/q+A4iHZFXgKzTk=
X-Received: by 2002:a17:90b:6cd:b0:32e:87f6:f5a6 with SMTP id
 98e67ed59e1d1-33bceb1eb5emr18602192a91.0.1761016918336; Mon, 20 Oct 2025
 20:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-20-jasowang@redhat.com>
 <20251020043646-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020043646-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:21:47 +0800
X-Gm-Features: AS18NWBclU7PvZyOiAL5cceEAU8SmTE27hMILk4bM5_GMShPOzgzz6heHBWom0I
Message-ID: <CACGkMEs71BL0rwWnXPbNu4T=tusPM_Lmj_ah6VSnZ6DFPfVRug@mail.gmail.com>
Subject: Re: [PATCH V8 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _ZG219DCokK2RfEMXe5Bcut9V64PTlk5ThgnBpSfcdU_1761016919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 03:10:03PM +0800, Jason Wang wrote:
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue. Performance could be gained for the device where the
> > memory access could be expensive (e.g vhost-net or a real PCI device):
> >
> > Benchmark with KVM guest:
> >
> > Vhost-net on the host: (pktgen + XDP_DROP):
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.20Mpps     | 6.20Mpps    | +19%
> >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> >
> > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> >
> > For split virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> >
> > For packed virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> >
> > Benchmark also shows no performance impact for in_order=3Doff for queue
> > size with 256 and 1024.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 440 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 416 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 96d7f165ec88..411bfa31707d 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -70,6 +70,8 @@
> >  enum vq_layout {
> >       SPLIT =3D 0,
> >       PACKED,
> > +     SPLIT_IN_ORDER,
> > +     PACKED_IN_ORDER,
> >       VQ_TYPE_MAX,
> >  };
> >
> > @@ -80,6 +82,7 @@ struct vring_desc_state_split {
> >        * allocated together. So we won't stress more to the memory allo=
cator.
> >        */
> >       struct vring_desc *indir_desc;
> > +     u32 total_len;                  /* Buffer Length */
> >  };
> >
> >  struct vring_desc_state_packed {
> > @@ -91,6 +94,7 @@ struct vring_desc_state_packed {
> >       struct vring_packed_desc *indir_desc;
> >       u16 num;                        /* Descriptor list length. */
> >       u16 last;                       /* The last desc state in a list.=
 */
> > +     u32 total_len;                  /* Buffer Length */
> >  };
> >
> >  struct vring_desc_extra {
> > @@ -168,7 +172,7 @@ struct vring_virtqueue_packed {
> >  struct vring_virtqueue;
> >
> >  struct virtqueue_ops {
> > -     int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[]=
,
> > +     int (*add)(struct vring_virtqueue *vq, struct scatterlist *sgs[],
> >                  unsigned int total_sg, unsigned int out_sgs,
> >                  unsigned int in_sgs, void *data,
> >                  void *ctx, bool premapped, gfp_t gfp);
> > @@ -205,8 +209,23 @@ struct vring_virtqueue {
> >
> >       enum vq_layout layout;
> >
> > -     /* Head of free buffer list. */
> > +     /*
> > +      * Without IN_ORDER it's the head of free buffer list. With
> > +      * IN_ORDER and SPLIT, it's the next available buffer
> > +      * index. With IN_ORDER and PACKED, it's unused.
> > +      */
> >       unsigned int free_head;
> > +
> > +     /*
> > +      * With IN_ORDER, devices write a single used ring entry with
> > +      * the id corresponding to the head entry of the descriptor chain
> > +      * describing the last buffer in the batch
>
> In the spec, yes, but I don't get it, so what does this field do?
> This should say something like:
> "once we see an in-order batch, this stores this last
>  entry, and until we return the last buffer.
>  After this, id is set to vq.num to mark it invalid.
>  Unused without IN_ORDER.
> "

Right, let me tweak it as you suggested here.

>
>
>
>
> > +      */
> > +     struct used_entry {
> > +             u32 id;
> > +             u32 len;
> > +     } batch_last;
> > +
> >       /* Number we've added since last sync. */
> >       unsigned int num_added;
> >
> > @@ -259,7 +278,12 @@ static void vring_free(struct virtqueue *_vq);
> >
> >  static inline bool virtqueue_is_packed(const struct vring_virtqueue *v=
q)
> >  {
> > -     return vq->layout =3D=3D PACKED;
> > +     return vq->layout =3D=3D PACKED || vq->layout =3D=3D PACKED_IN_OR=
DER;
> > +}
> > +
> > +static inline bool virtqueue_is_in_order(const struct vring_virtqueue =
*vq)
> > +{
> > +     return vq->layout =3D=3D SPLIT_IN_ORDER || vq->layout =3D=3D PACK=
ED_IN_ORDER;
> >  }
> >
> >  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> > @@ -576,6 +600,8 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> >       unsigned int i, n, avail, descs_used, err_idx, c =3D 0;
> > +     /* Total length for in-order */
> > +     unsigned int total_len =3D 0;
> >       int head;
> >       bool indirect;
> >
> > @@ -645,6 +671,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >                       i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> >                                                    ++c =3D=3D total_sg =
? 0 : VRING_DESC_F_NEXT,
> >                                                    premapped);
> > +                     total_len +=3D len;
> >               }
> >       }
> >       for (; n < (out_sgs + in_sgs); n++) {
> > @@ -662,6 +689,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >                               i, addr, len,
> >                               (++c =3D=3D total_sg ? 0 : VRING_DESC_F_N=
EXT) |
> >                               VRING_DESC_F_WRITE, premapped);
> > +                     total_len +=3D len;
> >               }
> >       }
> >
> > @@ -684,7 +712,12 @@ static inline int virtqueue_add_split(struct vring=
_virtqueue *vq,
> >       vq->vq.num_free -=3D descs_used;
> >
> >       /* Update free pointer */
> > -     if (indirect)
> > +     if (virtqueue_is_in_order(vq)) {
> > +             vq->free_head +=3D descs_used;
> > +             if (vq->free_head >=3D vq->split.vring.num)
> > +                     vq->free_head -=3D vq->split.vring.num;
> > +             vq->split.desc_state[head].total_len =3D total_len;;
>
> what's with ;; ?

Let me drop the extra ';' here.

>
>
> > +     } else if (indirect)
> >               vq->free_head =3D vq->split.desc_extra[head].next;
> >       else
> >               vq->free_head =3D i;
> > @@ -858,6 +891,14 @@ static bool more_used_split(const struct vring_vir=
tqueue *vq)
> >       return virtqueue_poll_split(vq, vq->last_used_idx);
> >  }
> >
> > +static bool more_used_split_in_order(const struct vring_virtqueue *vq)
> > +{
> > +     if (vq->batch_last.id !=3D vq->split.vring.num)
>
> So why not use ~0x0 to mark the id invalid?
> Will save a vring num read making the code a bit
> more compact, no? worth trying.

Yes, let me try it in the next version.

>
>
> > +             return true;
> > +
> > +     return virtqueue_poll_split(vq, vq->last_used_idx);
> > +}
> > +
> >  static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
> >                                        unsigned int *len,
> >                                        void **ctx)
>
> So now we have both more_used_split and more_used_split_in_order
> and it's confusing that more_used_split is not a superset
> of more_used_split_in_order.
>
> I think fundamentally out of order code will have to be
> renamed with _ooo suffix.
>
>
> Not a blocker for now.

Ok.

>
>
>
> > @@ -915,6 +956,73 @@ static void *virtqueue_get_buf_ctx_split(struct vr=
ing_virtqueue *vq,
> >       return ret;
> >  }
> >
> > +static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtque=
ue *vq,
> > +                                               unsigned int *len,
> > +                                               void **ctx)
> > +{
> > +     void *ret;
> > +     unsigned int num =3D vq->split.vring.num;
> > +     u16 last_used;
> > +
> > +     START_USE(vq);
> > +
> > +     if (unlikely(vq->broken)) {
> > +             END_USE(vq);
> > +             return NULL;
> > +     }
> > +
> > +     last_used =3D (vq->last_used_idx & (vq->split.vring.num - 1));
>
> just (num - 1) ?

Right.

>
>
> > +
> > +     if (vq->batch_last.id =3D=3D num) {
> > +             if (!more_used_split(vq)) {
>
>
> Well this works technically but it is really confusing.
> Better to call more_used_split_in_order consistently.

Fixed.

>
>
> > +                     pr_debug("No more buffers in queue\n");
> > +                     END_USE(vq);
> > +                     return NULL;
> > +             }
> > +
> > +             /* Only get used array entries after they have been
> > +              * exposed by host. */
>
> /*
>  * Always format multiline comments
>  * like this.
>  */
>
> /* Never
>  * like this */

Fixed.

>
>
>
> > +             virtio_rmb(vq->weak_barriers);
> > +             vq->batch_last.id =3D virtio32_to_cpu(vq->vq.vdev,
> > +                                 vq->split.vring.used->ring[last_used]=
.id);
> > +             vq->batch_last.len =3D virtio32_to_cpu(vq->vq.vdev,
> > +                                  vq->split.vring.used->ring[last_used=
].len);
> > +     }
> > +
> > +     if (vq->batch_last.id =3D=3D last_used) {
> > +             vq->batch_last.id =3D num;
> > +             *len =3D vq->batch_last.len;
> > +     } else
> > +             *len =3D vq->split.desc_state[last_used].total_len;
> > +
> > +     if (unlikely(last_used >=3D num)) {
> > +             BAD_RING(vq, "id %u out of range\n", last_used);
> > +             return NULL;
> > +     }
> > +     if (unlikely(!vq->split.desc_state[last_used].data)) {
> > +             BAD_RING(vq, "id %u is not a head!\n", last_used);
> > +             return NULL;
> > +     }
> > +
> > +     /* detach_buf_split clears data, so grab it now. */
> > +     ret =3D vq->split.desc_state[last_used].data;
> > +     detach_buf_split_in_order(vq, last_used, ctx);
> > +
> > +     vq->last_used_idx++;
> > +     /* If we expect an interrupt for the next entry, tell host
> > +      * by writing event index and flush out the write before
> > +      * the read in the next get_buf call. */
> > +     if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > +             virtio_store_mb(vq->weak_barriers,
> > +                             &vring_used_event(&vq->split.vring),
> > +                             cpu_to_virtio16(vq->vq.vdev, vq->last_use=
d_idx));
> > +
> > +     LAST_ADD_TIME_INVALID(vq);
> > +
> > +     END_USE(vq);
> > +     return ret;
> > +}
> > +
> >  static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
> >  {
> >       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))=
 {
> > @@ -1008,7 +1116,10 @@ static void *virtqueue_detach_unused_buf_split(s=
truct vring_virtqueue *vq)
> >                       continue;
> >               /* detach_buf_split clears data, so grab it now. */
> >               buf =3D vq->split.desc_state[i].data;
> > -             detach_buf_split(vq, i, NULL);
> > +             if (virtqueue_is_in_order(vq))
> > +                     detach_buf_split_in_order(vq, i, NULL);
> > +             else
> > +                     detach_buf_split(vq, i, NULL);
> >               vq->split.avail_idx_shadow--;
> >               vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq.vde=
v,
> >                               vq->split.avail_idx_shadow);
> > @@ -1071,6 +1182,7 @@ static void virtqueue_vring_attach_split(struct v=
ring_virtqueue *vq,
> >
> >       /* Put everything in free lists. */
> >       vq->free_head =3D 0;
> > +     vq->batch_last.id =3D vq->split.vring.num;
> >  }
> >
> >  static int vring_alloc_state_extra_split(struct vring_virtqueue_split =
*vring_split)
> > @@ -1182,7 +1294,6 @@ static struct virtqueue *__vring_new_virtqueue_sp=
lit(unsigned int index,
> >       if (!vq)
> >               return NULL;
> >
> > -     vq->layout =3D SPLIT;
> >       vq->vq.callback =3D callback;
> >       vq->vq.vdev =3D vdev;
> >       vq->vq.name =3D name;
> > @@ -1202,6 +1313,8 @@ static struct virtqueue *__vring_new_virtqueue_sp=
lit(unsigned int index,
> >       vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
> >               !context;
> >       vq->event =3D virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> > +     vq->layout =3D virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> > +                  SPLIT_IN_ORDER : SPLIT;
> >
> >       if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >               vq->weak_barriers =3D false;
>
> Same comments for packed below, I don't repeat them.
>

I've switched to calling more_used_packed_in_order() in
virtqueue_get_buf_ctx_packed_in_order().

>
>
>
> > @@ -1359,13 +1472,14 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> >                                        unsigned int in_sgs,
> >                                        void *data,
> >                                        bool premapped,
> > -                                      gfp_t gfp)
> > +                                      gfp_t gfp,
> > +                                      u16 id)
> >  {
> >       struct vring_desc_extra *extra;
> >       struct vring_packed_desc *desc;
> >       struct scatterlist *sg;
> > -     unsigned int i, n, err_idx, len;
> > -     u16 head, id;
> > +     unsigned int i, n, err_idx, len, total_len =3D 0;
> > +     u16 head;
> >       dma_addr_t addr;
> >
> >       head =3D vq->packed.next_avail_idx;
> > @@ -1383,8 +1497,6 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >       }
> >
> >       i =3D 0;
> > -     id =3D vq->free_head;
> > -     BUG_ON(id =3D=3D vq->packed.vring.num);
> >
> >       for (n =3D 0; n < out_sgs + in_sgs; n++) {
> >               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > @@ -1404,6 +1516,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >                               extra[i].flags =3D n < out_sgs ?  0 : VRI=
NG_DESC_F_WRITE;
> >                       }
> >
> > +                     total_len +=3D len;
> >                       i++;
> >               }
> >       }
> > @@ -1450,13 +1563,15 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> >                               1 << VRING_PACKED_DESC_F_USED;
> >       }
> >       vq->packed.next_avail_idx =3D n;
> > -     vq->free_head =3D vq->packed.desc_extra[id].next;
> > +     if (!virtqueue_is_in_order(vq))
> > +             vq->free_head =3D vq->packed.desc_extra[id].next;
> >
> >       /* Store token and indirect buffer state. */
> >       vq->packed.desc_state[id].num =3D 1;
> >       vq->packed.desc_state[id].data =3D data;
> >       vq->packed.desc_state[id].indir_desc =3D desc;
> >       vq->packed.desc_state[id].last =3D id;
> > +     vq->packed.desc_state[id].total_len =3D total_len;
> >
> >       vq->num_added +=3D 1;
> >
> > @@ -1509,8 +1624,11 @@ static inline int virtqueue_add_packed(struct vr=
ing_virtqueue *vq,
> >       BUG_ON(total_sg =3D=3D 0);
> >
> >       if (virtqueue_use_indirect(vq, total_sg)) {
> > +             id =3D vq->free_head;
> > +             BUG_ON(id =3D=3D vq->packed.vring.num);
> >               err =3D virtqueue_add_indirect_packed(vq, sgs, total_sg, =
out_sgs,
> > -                                                 in_sgs, data, premapp=
ed, gfp);
> > +                                                 in_sgs, data, premapp=
ed,
> > +                                                 gfp, id);
> >               if (err !=3D -ENOMEM) {
> >                       END_USE(vq);
> >                       return err;
> > @@ -1631,6 +1749,152 @@ static inline int virtqueue_add_packed(struct v=
ring_virtqueue *vq,
> >       return -EIO;
> >  }
> >
> > +static inline int virtqueue_add_packed_in_order(struct vring_virtqueue=
 *vq,
> > +                                             struct scatterlist *sgs[]=
,
> > +                                             unsigned int total_sg,
> > +                                             unsigned int out_sgs,
> > +                                             unsigned int in_sgs,
> > +                                             void *data,
> > +                                             void *ctx,
> > +                                             bool premapped,
> > +                                             gfp_t gfp)
> > +{
> > +     struct vring_packed_desc *desc;
> > +     struct scatterlist *sg;
> > +     unsigned int i, n, c, err_idx, total_len =3D 0;
> > +     __le16 head_flags, flags;
> > +     u16 head, avail_used_flags;
> > +     int err;
> > +
> > +     START_USE(vq);
> > +
> > +     BUG_ON(data =3D=3D NULL);
> > +     BUG_ON(ctx && vq->indirect);
> > +
> > +     if (unlikely(vq->broken)) {
> > +             END_USE(vq);
> > +             return -EIO;
> > +     }
> > +
> > +     LAST_ADD_TIME_UPDATE(vq);
> > +
> > +     BUG_ON(total_sg =3D=3D 0);
> > +
> > +     if (virtqueue_use_indirect(vq, total_sg)) {
> > +             err =3D virtqueue_add_indirect_packed(vq, sgs, total_sg, =
out_sgs,
> > +                                                 in_sgs, data, premapp=
ed, gfp,
> > +                                                 vq->packed.next_avail=
_idx);
> > +             if (err !=3D -ENOMEM) {
> > +                     END_USE(vq);
> > +                     return err;
> > +             }
> > +
> > +             /* fall back on direct */
> > +     }
> > +
> > +     head =3D vq->packed.next_avail_idx;
> > +     avail_used_flags =3D vq->packed.avail_used_flags;
> > +
> > +     WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
> > +
> > +     desc =3D vq->packed.vring.desc;
> > +     i =3D head;
> > +
> > +     if (unlikely(vq->vq.num_free < total_sg)) {
> > +             pr_debug("Can't add buf len %i - avail =3D %i\n",
> > +                      total_sg, vq->vq.num_free);
> > +             END_USE(vq);
> > +             return -ENOSPC;
> > +     }
> > +
> > +     c =3D 0;
> > +     for (n =3D 0; n < out_sgs + in_sgs; n++) {
> > +             for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > +                     dma_addr_t addr;
> > +                     u32 len;
> > +
> > +                     if (vring_map_one_sg(vq, sg, n < out_sgs ?
> > +                                          DMA_TO_DEVICE : DMA_FROM_DEV=
ICE,
> > +                                          &addr, &len, premapped))
> > +                             goto unmap_release;
> > +
> > +                     flags =3D cpu_to_le16(vq->packed.avail_used_flags=
 |
> > +                                 (++c =3D=3D total_sg ? 0 : VRING_DESC=
_F_NEXT) |
> > +                                 (n < out_sgs ? 0 : VRING_DESC_F_WRITE=
));
> > +                     if (i =3D=3D head)
> > +                             head_flags =3D flags;
> > +                     else
> > +                             desc[i].flags =3D flags;
> > +
> > +
> > +                     desc[i].addr =3D cpu_to_le64(addr);
> > +                     desc[i].len =3D cpu_to_le32(len);
> > +                     desc[i].id =3D cpu_to_le16(head);
> > +
> > +                     if (unlikely(vq->use_map_api)) {
> > +                             vq->packed.desc_extra[i].addr =3D premapp=
ed ?
> > +                                   DMA_MAPPING_ERROR: addr;
> > +                             vq->packed.desc_extra[i].len =3D len;
> > +                             vq->packed.desc_extra[i].flags =3D
> > +                                     le16_to_cpu(flags);
> > +                     }
> > +
> > +                     if ((unlikely(++i >=3D vq->packed.vring.num))) {
> > +                             i =3D 0;
> > +                             vq->packed.avail_used_flags ^=3D
> > +                                     1 << VRING_PACKED_DESC_F_AVAIL |
> > +                                     1 << VRING_PACKED_DESC_F_USED;
> > +                             vq->packed.avail_wrap_counter ^=3D 1;
> > +                     }
> > +
> > +                     total_len +=3D len;
> > +             }
> > +     }
> > +
> > +     /* We're using some buffers from the free list. */
> > +     vq->vq.num_free -=3D total_sg;
> > +
> > +     /* Update free pointer */
> > +     vq->packed.next_avail_idx =3D i;
> > +
> > +     /* Store token. */
> > +     vq->packed.desc_state[head].num =3D total_sg;
> > +     vq->packed.desc_state[head].data =3D data;
> > +     vq->packed.desc_state[head].indir_desc =3D ctx;
> > +     vq->packed.desc_state[head].total_len =3D total_len;
> > +
> > +     /*
> > +      * A driver MUST NOT make the first descriptor in the list
> > +      * available before all subsequent descriptors comprising
> > +      * the list are made available.
> > +      */
> > +     virtio_wmb(vq->weak_barriers);
> > +     vq->packed.vring.desc[head].flags =3D head_flags;
> > +     vq->num_added +=3D total_sg;
> > +
> > +     pr_debug("Added buffer head %i to %p\n", head, vq);
> > +     END_USE(vq);
> > +
> > +     return 0;
> > +
> > +unmap_release:
> > +     err_idx =3D i;
> > +     i =3D head;
> > +     vq->packed.avail_used_flags =3D avail_used_flags;
> > +
> > +     for (n =3D 0; n < total_sg; n++) {
> > +             if (i =3D=3D err_idx)
> > +                     break;
> > +             vring_unmap_extra_packed(vq, &vq->packed.desc_extra[i]);
> > +             i++;
> > +             if (i >=3D vq->packed.vring.num)
> > +                     i =3D 0;
> > +     }
> > +
> > +     END_USE(vq);
> > +     return -EIO;
> > +}
> > +
> >  static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
> >  {
> >       u16 new, old, off_wrap, flags, wrap_counter, event_idx;
> > @@ -1792,10 +2056,81 @@ static void update_last_used_idx_packed(struct =
vring_virtqueue *vq,
> >                               cpu_to_le16(vq->last_used_idx));
> >  }
> >
> > +static bool more_used_packed_in_order(const struct vring_virtqueue *vq=
)
> > +{
> > +     if (vq->batch_last.id !=3D vq->packed.vring.num)
> > +             return true;
> > +
> > +     return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
> > +}
> > +
> > +static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqu=
eue *vq,
> > +                                                unsigned int *len,
> > +                                                void **ctx)
> > +{
> > +     unsigned int num =3D vq->packed.vring.num;
> > +     u16 last_used, last_used_idx;
> > +     bool used_wrap_counter;
> > +     void *ret;
> > +
> > +     START_USE(vq);
> > +
> > +     if (unlikely(vq->broken)) {
> > +             END_USE(vq);
> > +             return NULL;
> > +     }
> > +
> > +     last_used_idx =3D vq->last_used_idx;
> > +     used_wrap_counter =3D packed_used_wrap_counter(last_used_idx);
> > +     last_used =3D packed_last_used(last_used_idx);
> > +
> > +     if (vq->batch_last.id =3D=3D num) {
> > +             if (!more_used_packed(vq)) {
> > +                     pr_debug("No more buffers in queue\n");
> > +                     END_USE(vq);
> > +                     return NULL;
> > +             }
> > +             /* Only get used elements after they have been exposed by=
 host. */
> > +             virtio_rmb(vq->weak_barriers);
> > +             vq->batch_last.id =3D
> > +                     le16_to_cpu(vq->packed.vring.desc[last_used].id);
> > +             vq->batch_last.len =3D
> > +                     le32_to_cpu(vq->packed.vring.desc[last_used].len)=
;
> > +     }
> > +
> > +     if (vq->batch_last.id =3D=3D last_used) {
> > +             vq->batch_last.id =3D num;
> > +             *len =3D vq->batch_last.len;
> > +     } else
> > +             *len =3D vq->packed.desc_state[last_used].total_len;
> > +
> > +     if (unlikely(last_used >=3D num)) {
> > +             BAD_RING(vq, "id %u out of range\n", last_used);
> > +             return NULL;
> > +     }
> > +     if (unlikely(!vq->packed.desc_state[last_used].data)) {
> > +             BAD_RING(vq, "id %u is not a head!\n", last_used);
> > +             return NULL;
> > +     }
> > +
> > +     /* detach_buf_packed clears data, so grab it now. */
> > +     ret =3D vq->packed.desc_state[last_used].data;
> > +     detach_buf_packed_in_order(vq, last_used, ctx);
> > +
> > +     update_last_used_idx_packed(vq, last_used, last_used,
> > +                                 used_wrap_counter);
> > +
> > +     LAST_ADD_TIME_INVALID(vq);
> > +
> > +     END_USE(vq);
> > +     return ret;
> > +}
> > +
> >  static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
> >                                         unsigned int *len,
> >                                         void **ctx)
> >  {
> > +     unsigned int num =3D vq->packed.vring.num;
> >       u16 last_used, id, last_used_idx;
> >       bool used_wrap_counter;
> >       void *ret;
> > @@ -1822,7 +2157,7 @@ static void *virtqueue_get_buf_ctx_packed(struct =
vring_virtqueue *vq,
> >       id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);
> >       *len =3D le32_to_cpu(vq->packed.vring.desc[last_used].len);
> >
> > -     if (unlikely(id >=3D vq->packed.vring.num)) {
> > +     if (unlikely(id >=3D num)) {
> >               BAD_RING(vq, "id %u out of range\n", id);
> >               return NULL;
> >       }
> > @@ -1963,7 +2298,10 @@ static void *virtqueue_detach_unused_buf_packed(=
struct vring_virtqueue *vq)
> >                       continue;
> >               /* detach_buf clears data, so grab it now. */
> >               buf =3D vq->packed.desc_state[i].data;
> > -             detach_buf_packed(vq, i, NULL);
> > +             if (virtqueue_is_in_order(vq))
> > +                     detach_buf_packed_in_order(vq, i, NULL);
> > +             else
> > +                     detach_buf_packed(vq, i, NULL);
> >               END_USE(vq);
> >               return buf;
> >       }
> > @@ -1989,6 +2327,8 @@ static struct vring_desc_extra *vring_alloc_desc_=
extra(unsigned int num)
> >       for (i =3D 0; i < num - 1; i++)
> >               desc_extra[i].next =3D i + 1;
> >
> > +     desc_extra[num - 1].next =3D 0;
> > +
> >       return desc_extra;
> >  }
> >
> > @@ -2120,10 +2460,17 @@ static void virtqueue_vring_attach_packed(struc=
t vring_virtqueue *vq,
> >  {
> >       vq->packed =3D *vring_packed;
> >
> > -     /* Put everything in free lists. */
> > -     vq->free_head =3D 0;
> > +     if (virtqueue_is_in_order(vq))
> > +             vq->batch_last.id =3D vq->packed.vring.num;
> > +     else {
>
> coding style violation:
>
>         This does not apply if only one branch of a conditional statement=
 is a single
>         statement; in the latter case use braces in both branches:
>
>         .. code-block:: c
>
>                 if (condition) {
>                         do_this();
>                         do_that();
>                 } else {
>                         otherwise();
>                 }
>
>

Right, fixed.

>
>
>
> > +             /*
> > +              * Put everything in free lists. Note that
> > +              * next_avail_idx is sufficient with IN_ORDER so
> > +              * free_head is unused.
> > +              */
> > +             vq->free_head =3D 0 ;
>
> extra space here
>
>

And this as well.

>
> > +     }
> >  }
> > -
> >  static void virtqueue_reset_packed(struct vring_virtqueue *vq)
> >  {
> >       memset(vq->packed.vring.device, 0, vq->packed.event_size_in_bytes=
);
> > @@ -2168,13 +2515,14 @@ static struct virtqueue *__vring_new_virtqueue_=
packed(unsigned int index,
> >  #else
> >       vq->broken =3D false;
> >  #endif
> > -     vq->layout =3D PACKED;
> >       vq->map =3D map;
> >       vq->use_map_api =3D vring_use_map_api(vdev);
> >
> >       vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
> >               !context;
> >       vq->event =3D virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> > +     vq->layout =3D virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> > +                  PACKED_IN_ORDER : PACKED;
> >
> >       if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >               vq->weak_barriers =3D false;
> > @@ -2284,9 +2632,39 @@ static const struct virtqueue_ops packed_ops =3D=
 {
> >       .reset =3D virtqueue_reset_packed,
> >  };
> >
> > +static const struct virtqueue_ops split_in_order_ops =3D {
> > +     .add =3D virtqueue_add_split,
> > +     .get =3D virtqueue_get_buf_ctx_split_in_order,
> > +     .kick_prepare =3D virtqueue_kick_prepare_split,
> > +     .disable_cb =3D virtqueue_disable_cb_split,
> > +     .enable_cb_delayed =3D virtqueue_enable_cb_delayed_split,
> > +     .enable_cb_prepare =3D virtqueue_enable_cb_prepare_split,
> > +     .poll =3D virtqueue_poll_split,
> > +     .detach_unused_buf =3D virtqueue_detach_unused_buf_split,
> > +     .more_used =3D more_used_split_in_order,
> > +     .resize =3D virtqueue_resize_split,
> > +     .reset =3D virtqueue_reset_split,
> > +};
> > +
> > +static const struct virtqueue_ops packed_in_order_ops =3D {
> > +     .add =3D virtqueue_add_packed_in_order,
> > +     .get =3D virtqueue_get_buf_ctx_packed_in_order,
> > +     .kick_prepare =3D virtqueue_kick_prepare_packed,
> > +     .disable_cb =3D virtqueue_disable_cb_packed,
> > +     .enable_cb_delayed =3D virtqueue_enable_cb_delayed_packed,
> > +     .enable_cb_prepare =3D virtqueue_enable_cb_prepare_packed,
> > +     .poll =3D virtqueue_poll_packed,
> > +     .detach_unused_buf =3D virtqueue_detach_unused_buf_packed,
> > +     .more_used =3D more_used_packed_in_order,
> > +     .resize =3D virtqueue_resize_packed,
> > +     .reset =3D virtqueue_reset_packed,
> > +};
> > +
> >  static const struct virtqueue_ops *const all_ops[VQ_TYPE_MAX] =3D {
> >       [SPLIT] =3D &split_ops,
> > -     [PACKED] =3D &packed_ops
> > +     [PACKED] =3D &packed_ops,
> > +     [SPLIT_IN_ORDER] =3D &split_in_order_ops,
> > +     [PACKED_IN_ORDER] =3D &packed_in_order_ops,
> >  };
> >
> >  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
> > @@ -2342,6 +2720,12 @@ static int virtqueue_enable_after_reset(struct v=
irtqueue *_vq)
> >       case PACKED:                                                    \
> >               ret =3D all_ops[PACKED]->op(vq, ##__VA_ARGS__);          =
 \
> >               break;                                                  \
> > +     case SPLIT_IN_ORDER:                                            \
> > +             ret =3D all_ops[SPLIT_IN_ORDER]->op(vq, ##__VA_ARGS__);  =
 \
> > +             break;                                                  \
> > +     case PACKED_IN_ORDER:                                           \
> > +             ret =3D all_ops[PACKED_IN_ORDER]->op(vq, ##__VA_ARGS__); =
 \
> > +             break;                                                  \
> >       default:                                                        \
> >               BUG();                                                  \
> >               break;                                                  \
> > @@ -2358,10 +2742,16 @@ static int virtqueue_enable_after_reset(struct =
virtqueue *_vq)
> >       case PACKED:                                    \
> >               all_ops[PACKED]->op(vq, ##__VA_ARGS__); \
> >               break;                                  \
> > -     default:                                        \
> > -             BUG();                                  \
> > -             break;                                  \
> > -     }                                               \
> > +     case SPLIT_IN_ORDER:                                            \
> > +             all_ops[SPLIT_IN_ORDER]->op(vq, ##__VA_ARGS__); \
> > +             break;                                                  \
> > +     case PACKED_IN_ORDER:                                           \
> > +             all_ops[PACKED_IN_ORDER]->op(vq, ##__VA_ARGS__);        \
> > +             break;                                                  \
> > +     default:                                                        \
> > +             BUG();                                                  \
> > +             break;                                                  \
> > +     }                                                               \
> >  })
> >
> >  static inline int virtqueue_add(struct virtqueue *_vq,
> > @@ -3078,6 +3468,8 @@ void vring_transport_features(struct virtio_devic=
e *vdev)
> >                       break;
> >               case VIRTIO_F_NOTIFICATION_DATA:
> >                       break;
> > +             case VIRTIO_F_IN_ORDER:
> > +                     break;
> >               default:
> >                       /* We don't understand this bit. */
> >                       __virtio_clear_bit(vdev, i);
> > --
> > 2.31.1
>

Thanks

