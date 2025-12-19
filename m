Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E7233134
	for <virtualization@lists.linux.dev>; Fri, 19 Dec 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157575; cv=none; b=qbqBpwMToaQcsuHtJQ3rFOaRGSh8lXo8ApGo7/vk3v9kqf/+GNVGKglqdU9ThQgFGtpq05ZEqSH9wPDQ/nWAVX9p6hwUp7Rhk0Zup0Y3pBKq4WhWPDR+8nzk9bnN5cLXN7vW58LrODLVlCDUdgYUnmM04Um/hs+PzkehFJtUYp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157575; c=relaxed/simple;
	bh=SiQJJ/8PgJHyVW2ZkAJ/6XgvBaKvdYFfEiXyAwcKD6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3+Zggrr4oi4YS+iMGnv1XeLUmozutP3P0ehD/lSDYNF+23xOsaB0eVBxp9G5x/SvWgpTXCv/JQsAjPNmqRt3UYsMJh4MAAkTh6H6IwtDHMvVGG0o66mSC8YHapz5NAItKBTsU8Jp8CBxlkB7+f9im/snmWf4vods5ba1NuntAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8AOZloW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8AOZloW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766157572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHj+wduZUcYN7C5b9KiUhsWnrpfTbeC41R9t5+9Q9Zk=;
	b=P8AOZloWb38Wm5sEUEVtaJOTvyJQvM/Ah5CT0uY/z0hTtDSvy4BgaYkK3SQ3XwFgRKzYU6
	xYKf56ibVjx77/1evsDEOoT6F5Yxfqrlc1zBwoIU5RcJwy9kmwVYv54G2tGd4IuUcW1hW1
	QEmkmv2NLEpEW4Usmcn1NApmm2ndqUw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-7Yi2GEL4Oe-uzqCOUZ8XyQ-1; Fri, 19 Dec 2025 10:19:30 -0500
X-MC-Unique: 7Yi2GEL4Oe-uzqCOUZ8XyQ-1
X-Mimecast-MFC-AGG-ID: 7Yi2GEL4Oe-uzqCOUZ8XyQ_1766157570
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-78954aac3e7so24284537b3.0
        for <virtualization@lists.linux.dev>; Fri, 19 Dec 2025 07:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766157569; x=1766762369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eHj+wduZUcYN7C5b9KiUhsWnrpfTbeC41R9t5+9Q9Zk=;
        b=tuzkp8G1L/mZjB+AoajbhS11oMcTfH3chb/Z2G0g5kMMilxHUpKlXRx5IEM+sliy5o
         HUPJNxri8Uz6RvOSXRkUP8ZaL7j7QlmhaRlMmciezN4Wjz6M2TMdPEWrOrNCqRevo0Qv
         JtIUfktNUYEQouOeD7J4AvOIJS+jQRbqvxP4pPLruwb2v/vukOqmL5tQmK3h0rZ+KdxE
         F9hQrZddbhaYvWgG3nSMYqMV2dgauTzzWXa2SN8nXFJe2ggV3vg7Wgw62/RXA2H41VsW
         D5HUqWVBcDP5euYI+CZoi2od2vEiE0P/fi6NHXfQTluwZxMaEEZHSAX5x94vYMXR1Ksb
         TciQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOeieNEabK1lXxyvW1I10SPSOkcYBJYGc/fcgi82eQrTliA9jZi4TFSBMgYfYIZa/daDNDMs8VwwoK/QlItw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxizpiAAi3E6M474XcVugwLDsGKJfuccKRKf7UwwY68PeSvgRBS
	mJi2XXAbfSOwkTlozyvh4nqq6IQKKoMWXZBN9zc7naGy/HmLrb8y1RB9P1MIhjNLTfl2c3jUSSB
	VEXU5wRcUPJIGtMj3TBwbH6dD86fLfKPhxKqqPPMyZEadCMKLVi4dFepNU5KGqSAw5gMq1KMC4L
	HgtH1l76cvyniTvLRBjuaPMUp1/QKJ0SMiIxbYthr/ELGYDNKxpCnIFQ==
X-Gm-Gg: AY/fxX5A5gXD21dsSgpx2ZPX2AwkptK3SWWtCm3jmKrTuSy0GuqiW5DYGd6N3a2yRCT
	0U9Ao5dW3f9MMu5PQKbMJAPSV/0+cYwKNF7MjhXSaHeb3ihIhIbClTTbuCwGA+NA/h+d75IVhrN
	l+7srI1UT73ZchC+wLSpUZZWTJ9oGLkvLH3ctEw4rMfYNWJGg9/ImOYgqk5PcJkGfA3Sk=
X-Received: by 2002:a53:df48:0:b0:645:5a5c:9e6e with SMTP id 956f58d0204a3-6466a8f35c3mr2094581d50.58.1766157569179;
        Fri, 19 Dec 2025 07:19:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZeGY0h8Au4FpXJAo406l/YW0DQIZZJememygFJaPHTCN8LkGEH1AiUd4OhSIqpCUVYif/66SGvqOn8lmaDK8=
X-Received: by 2002:a53:df48:0:b0:645:5a5c:9e6e with SMTP id
 956f58d0204a3-6466a8f35c3mr2094538d50.58.1766157568314; Fri, 19 Dec 2025
 07:19:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251125070838.70736-1-jasowang@redhat.com> <20251125070838.70736-20-jasowang@redhat.com>
In-Reply-To: <20251125070838.70736-20-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Dec 2025 16:18:51 +0100
X-Gm-Features: AQt7F2qo1RvzVhVRCUvn28GPV2uaYXS7jV499ZgDtjl2cXpcnr2UrsMHHSFUifA
Message-ID: <CAJaqyWdmcaSAtGtXQAQ4sTD4S60+zHFpeyaS0YhRXxZOjV-+Pw@mail.gmail.com>
Subject: Re: [PATCH V9 19/19] virtio_ring: add in order support
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AHncK1bYA0EJmMnT8bYsr-9WVmDe5GMIhE39-3il4CM_1766157570
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 8:10=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This patch implements in order support for both split virtqueue and
> packed virtqueue. Performance could be gained for the device where the
> memory access could be expensive (e.g vhost-net or a real PCI device):
>
> Benchmark with KVM guest:
>
> Vhost-net on the host: (pktgen + XDP_DROP):
>
>          in_order=3Doff | in_order=3Don | +%
>     TX:  4.51Mpps     | 5.30Mpps    | +17%
>     RX:  3.47Mpps     | 3.61Mpps    | + 4%
>
> Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
>
> For split virtqueue:
>
>          in_order=3Doff | in_order=3Don | +%
>     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
>     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
>
> For packed virtqueue:
>
>          in_order=3Doff | in_order=3Don | +%
>     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
>     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
>
> Benchmark also shows no performance impact for in_order=3Doff for queue
> size with 256 and 1024.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 458 +++++++++++++++++++++++++++++++++--
>  1 file changed, 435 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 61884e031b94..9847b23f82ea 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -70,6 +70,8 @@
>  enum vq_layout {
>         SPLIT =3D 0,
>         PACKED,
> +       SPLIT_IN_ORDER,
> +       PACKED_IN_ORDER,
>         VQ_TYPE_MAX,
>  };
>
> @@ -80,6 +82,7 @@ struct vring_desc_state_split {
>          * allocated together. So we won't stress more to the memory allo=
cator.
>          */
>         struct vring_desc *indir_desc;
> +       u32 total_len;                  /* Buffer Length */
>  };
>
>  struct vring_desc_state_packed {
> @@ -91,6 +94,7 @@ struct vring_desc_state_packed {
>         struct vring_packed_desc *indir_desc;
>         u16 num;                        /* Descriptor list length. */
>         u16 last;                       /* The last desc state in a list.=
 */
> +       u32 total_len;                  /* Buffer Length */
>  };
>
>  struct vring_desc_extra {
> @@ -205,8 +209,24 @@ struct vring_virtqueue {
>
>         enum vq_layout layout;
>
> -       /* Head of free buffer list. */
> +       /*
> +        * Without IN_ORDER it's the head of free buffer list. With
> +        * IN_ORDER and SPLIT, it's the next available buffer
> +        * index. With IN_ORDER and PACKED, it's unused.
> +        */
>         unsigned int free_head;
> +
> +       /*
> +        * With IN_ORDER, once we see an in-order batch, this stores
> +        * this last entry, and until we return the last buffer.
> +        * After this, id is set to vq.num to mark it invalid.

s/vq.num/UINT_MAX/.

> +        * Unused without IN_ORDER.
> +        */
> +       struct used_entry {
> +               u32 id;
> +               u32 len;
> +       } batch_last;
> +
>         /* Number we've added since last sync. */
>         unsigned int num_added;
>
> @@ -218,6 +238,11 @@ struct vring_virtqueue {
>          */
>         u16 last_used_idx;
>
> +       /* With IN_ORDER and SPLIT, last descriptor id we used to
> +        * detach buffer.
> +        */
> +       u16 last_used;
> +
>         /* Hint for event idx: already triggered no need to disable. */
>         bool event_triggered;
>
> @@ -259,7 +284,12 @@ static void vring_free(struct virtqueue *_vq);
>
>  static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq)
>  {
> -       return vq->layout =3D=3D PACKED;
> +       return vq->layout =3D=3D PACKED || vq->layout =3D=3D PACKED_IN_OR=
DER;
> +}
> +
> +static inline bool virtqueue_is_in_order(const struct vring_virtqueue *v=
q)
> +{
> +       return vq->layout =3D=3D SPLIT_IN_ORDER || vq->layout =3D=3D PACK=
ED_IN_ORDER;
>  }
>
>  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> @@ -469,6 +499,8 @@ static void virtqueue_init(struct vring_virtqueue *vq=
, u32 num)
>         else
>                 vq->last_used_idx =3D 0;
>
> +       vq->last_used =3D 0;
> +
>         vq->event_triggered =3D false;
>         vq->num_added =3D 0;
>
> @@ -576,6 +608,8 @@ static inline int virtqueue_add_split(struct vring_vi=
rtqueue *vq,
>         struct scatterlist *sg;
>         struct vring_desc *desc;
>         unsigned int i, n, avail, descs_used, err_idx, sg_count =3D 0;
> +       /* Total length for in-order */
> +       unsigned int total_len =3D 0;
>         int head;
>         bool indirect;
>
> @@ -648,6 +682,7 @@ static inline int virtqueue_add_split(struct vring_vi=
rtqueue *vq,
>                          */
>                         i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr,
>                                                      len, flags ,premappe=
d);
> +                       total_len +=3D len;
>                 }
>         }
>         for (; n < (out_sgs + in_sgs); n++) {
> @@ -667,6 +702,7 @@ static inline int virtqueue_add_split(struct vring_vi=
rtqueue *vq,
>                          */
>                         i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr,
>                                                      len, flags, premappe=
d);
> +                       total_len +=3D len;
>                 }
>         }
>
> @@ -689,7 +725,12 @@ static inline int virtqueue_add_split(struct vring_v=
irtqueue *vq,
>         vq->vq.num_free -=3D descs_used;
>
>         /* Update free pointer */
> -       if (indirect)
> +       if (virtqueue_is_in_order(vq)) {
> +               vq->free_head +=3D descs_used;
> +               if (vq->free_head >=3D vq->split.vring.num)
> +                       vq->free_head -=3D vq->split.vring.num;
> +               vq->split.desc_state[head].total_len =3D total_len;
> +       } else if (indirect)
>                 vq->free_head =3D vq->split.desc_extra[head].next;
>         else
>                 vq->free_head =3D i;
> @@ -862,6 +903,14 @@ static bool more_used_split(const struct vring_virtq=
ueue *vq)
>         return virtqueue_poll_split(vq, vq->last_used_idx);
>  }
>
> +static bool more_used_split_in_order(const struct vring_virtqueue *vq)
> +{
> +       if (vq->batch_last.id !=3D UINT_MAX)
> +               return true;
> +
> +       return virtqueue_poll_split(vq, vq->last_used_idx);
> +}
> +
>  static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>                                          unsigned int *len,
>                                          void **ctx)
> @@ -919,6 +968,80 @@ static void *virtqueue_get_buf_ctx_split(struct vrin=
g_virtqueue *vq,
>         return ret;
>  }
>
> +static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue=
 *vq,
> +                                                 unsigned int *len,
> +                                                 void **ctx)
> +{
> +       void *ret;
> +       unsigned int num =3D vq->split.vring.num;
> +       unsigned int num_free =3D vq->vq.num_free;
> +       u16 last_used, last_used_idx;
> +
> +       START_USE(vq);
> +
> +       if (unlikely(vq->broken)) {
> +               END_USE(vq);
> +               return NULL;
> +       }
> +
> +       last_used =3D vq->last_used & (num - 1);
> +       last_used_idx =3D vq->last_used_idx & (num - 1);
> +
> +       if (vq->batch_last.id =3D=3D UINT_MAX) {
> +               if (!more_used_split_in_order(vq)) {
> +                       pr_debug("No more buffers in queue\n");
> +                       END_USE(vq);
> +                       return NULL;
> +               }
> +
> +               /*
> +                * Only get used array entries after they have been
> +                * exposed by host.
> +                */
> +               virtio_rmb(vq->weak_barriers);
> +
> +               vq->batch_last.id =3D virtio32_to_cpu(vq->vq.vdev,
> +                                   vq->split.vring.used->ring[last_used_=
idx].id);
> +               vq->batch_last.len =3D virtio32_to_cpu(vq->vq.vdev,
> +                                    vq->split.vring.used->ring[last_used=
_idx].len);
> +       }
> +
> +       if (vq->batch_last.id =3D=3D last_used) {
> +               vq->batch_last.id =3D UINT_MAX;
> +               *len =3D vq->batch_last.len;
> +       } else {
> +               *len =3D vq->split.desc_state[last_used].total_len;
> +       }
> +
> +       if (unlikely(last_used >=3D num)) {
> +               BAD_RING(vq, "id %u out of range\n", last_used);
> +               return NULL;
> +       }
> +       if (unlikely(!vq->split.desc_state[last_used].data)) {
> +               BAD_RING(vq, "id %u is not a head!\n", last_used);
> +               return NULL;
> +       }
> +
> +       /* detach_buf_split clears data, so grab it now. */
> +       ret =3D vq->split.desc_state[last_used].data;
> +       detach_buf_split_in_order(vq, last_used, ctx);
> +
> +       vq->last_used_idx++;
> +       vq->last_used +=3D (vq->vq.num_free - num_free);
> +       /* If we expect an interrupt for the next entry, tell host
> +        * by writing event index and flush out the write before
> +        * the read in the next get_buf call. */
> +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +               virtio_store_mb(vq->weak_barriers,
> +                               &vring_used_event(&vq->split.vring),
> +                               cpu_to_virtio16(vq->vq.vdev, vq->last_use=
d_idx));
> +
> +       LAST_ADD_TIME_INVALID(vq);
> +
> +       END_USE(vq);
> +       return ret;
> +}
> +
>  static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
>  {
>         if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))=
 {
> @@ -1012,7 +1135,10 @@ static void *virtqueue_detach_unused_buf_split(str=
uct vring_virtqueue *vq)
>                         continue;
>                 /* detach_buf_split clears data, so grab it now. */
>                 buf =3D vq->split.desc_state[i].data;
> -               detach_buf_split(vq, i, NULL);
> +               if (virtqueue_is_in_order(vq))
> +                       detach_buf_split_in_order(vq, i, NULL);
> +               else
> +                       detach_buf_split(vq, i, NULL);
>                 vq->split.avail_idx_shadow--;
>                 vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq.vde=
v,
>                                 vq->split.avail_idx_shadow);
> @@ -1075,6 +1201,7 @@ static void virtqueue_vring_attach_split(struct vri=
ng_virtqueue *vq,
>
>         /* Put everything in free lists. */
>         vq->free_head =3D 0;
> +       vq->batch_last.id =3D UINT_MAX;
>  }
>
>  static int vring_alloc_state_extra_split(struct vring_virtqueue_split *v=
ring_split)
> @@ -1186,7 +1313,6 @@ static struct virtqueue *__vring_new_virtqueue_spli=
t(unsigned int index,
>         if (!vq)
>                 return NULL;
>
> -       vq->layout =3D SPLIT;
>         vq->vq.callback =3D callback;
>         vq->vq.vdev =3D vdev;
>         vq->vq.name =3D name;
> @@ -1206,6 +1332,8 @@ static struct virtqueue *__vring_new_virtqueue_spli=
t(unsigned int index,
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !context;
>         vq->event =3D virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> +       vq->layout =3D virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> +                    SPLIT_IN_ORDER : SPLIT;
>
>         if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>                 vq->weak_barriers =3D false;
> @@ -1363,13 +1491,14 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                                          unsigned int in_sgs,
>                                          void *data,
>                                          bool premapped,
> -                                        gfp_t gfp)
> +                                        gfp_t gfp,
> +                                        u16 id)
>  {
>         struct vring_desc_extra *extra;
>         struct vring_packed_desc *desc;
>         struct scatterlist *sg;
> -       unsigned int i, n, err_idx, len;
> -       u16 head, id;
> +       unsigned int i, n, err_idx, len, total_len =3D 0;
> +       u16 head;
>         dma_addr_t addr;
>
>         head =3D vq->packed.next_avail_idx;
> @@ -1387,8 +1516,6 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         }
>
>         i =3D 0;
> -       id =3D vq->free_head;
> -       BUG_ON(id =3D=3D vq->packed.vring.num);
>
>         for (n =3D 0; n < out_sgs + in_sgs; n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> @@ -1408,6 +1535,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                                 extra[i].flags =3D n < out_sgs ?  0 : VRI=
NG_DESC_F_WRITE;
>                         }
>
> +                       total_len +=3D len;
>                         i++;
>                 }
>         }
> @@ -1454,13 +1582,15 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                                 1 << VRING_PACKED_DESC_F_USED;
>         }
>         vq->packed.next_avail_idx =3D n;
> -       vq->free_head =3D vq->packed.desc_extra[id].next;
> +       if (!virtqueue_is_in_order(vq))
> +               vq->free_head =3D vq->packed.desc_extra[id].next;
>
>         /* Store token and indirect buffer state. */
>         vq->packed.desc_state[id].num =3D 1;
>         vq->packed.desc_state[id].data =3D data;
>         vq->packed.desc_state[id].indir_desc =3D desc;
>         vq->packed.desc_state[id].last =3D id;
> +       vq->packed.desc_state[id].total_len =3D total_len;
>
>         vq->num_added +=3D 1;
>
> @@ -1513,8 +1643,11 @@ static inline int virtqueue_add_packed(struct vrin=
g_virtqueue *vq,
>         BUG_ON(total_sg =3D=3D 0);
>
>         if (virtqueue_use_indirect(vq, total_sg)) {
> +               id =3D vq->free_head;
> +               BUG_ON(id =3D=3D vq->packed.vring.num);
>                 err =3D virtqueue_add_indirect_packed(vq, sgs, total_sg, =
out_sgs,
> -                                                   in_sgs, data, premapp=
ed, gfp);
> +                                                   in_sgs, data, premapp=
ed,
> +                                                   gfp, id);
>                 if (err !=3D -ENOMEM) {
>                         END_USE(vq);
>                         return err;
> @@ -1635,6 +1768,156 @@ static inline int virtqueue_add_packed(struct vri=
ng_virtqueue *vq,
>         return -EIO;
>  }
>
> +static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *=
vq,
> +                                               struct scatterlist *sgs[]=
,
> +                                               unsigned int total_sg,
> +                                               unsigned int out_sgs,
> +                                               unsigned int in_sgs,
> +                                               void *data,
> +                                               void *ctx,
> +                                               bool premapped,
> +                                               gfp_t gfp)
> +{
> +       struct vring_packed_desc *desc;
> +       struct scatterlist *sg;
> +       unsigned int i, n, sg_count, err_idx, total_len =3D 0;
> +       __le16 head_flags, flags;
> +       u16 head, avail_used_flags;
> +       int err;
> +
> +       START_USE(vq);
> +
> +       BUG_ON(data =3D=3D NULL);
> +       BUG_ON(ctx && vq->indirect);
> +
> +       if (unlikely(vq->broken)) {
> +               END_USE(vq);
> +               return -EIO;
> +       }
> +
> +       LAST_ADD_TIME_UPDATE(vq);
> +
> +       BUG_ON(total_sg =3D=3D 0);
> +
> +       if (virtqueue_use_indirect(vq, total_sg)) {
> +               err =3D virtqueue_add_indirect_packed(vq, sgs, total_sg, =
out_sgs,
> +                                                   in_sgs, data, premapp=
ed, gfp,
> +                                                   vq->packed.next_avail=
_idx);
> +               if (err !=3D -ENOMEM) {
> +                       END_USE(vq);
> +                       return err;
> +               }
> +
> +               /* fall back on direct */
> +       }
> +
> +       head =3D vq->packed.next_avail_idx;
> +       avail_used_flags =3D vq->packed.avail_used_flags;
> +
> +       WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
> +
> +       desc =3D vq->packed.vring.desc;
> +       i =3D head;
> +
> +       if (unlikely(vq->vq.num_free < total_sg)) {
> +               pr_debug("Can't add buf len %i - avail =3D %i\n",
> +                        total_sg, vq->vq.num_free);
> +               END_USE(vq);
> +               return -ENOSPC;
> +       }
> +
> +       sg_count =3D 0;
> +       for (n =3D 0; n < out_sgs + in_sgs; n++) {
> +               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> +                       dma_addr_t addr;
> +                       u32 len;
> +
> +                       flags =3D 0;
> +                       if (++sg_count !=3D total_sg)
> +                               flags |=3D cpu_to_le16(VRING_DESC_F_NEXT)=
;
> +                       if (n >=3D out_sgs)
> +                               flags |=3D cpu_to_le16(VRING_DESC_F_WRITE=
);
> +
> +                       if (vring_map_one_sg(vq, sg, n < out_sgs ?
> +                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE,
> +                                            &addr, &len, premapped))
> +                               goto unmap_release;
> +
> +                       flags |=3D cpu_to_le16(vq->packed.avail_used_flag=
s);
> +
> +                       if (i =3D=3D head)
> +                               head_flags =3D flags;
> +                       else
> +                               desc[i].flags =3D flags;
> +
> +                       desc[i].addr =3D cpu_to_le64(addr);
> +                       desc[i].len =3D cpu_to_le32(len);
> +                       desc[i].id =3D cpu_to_le16(head);
> +
> +                       if (unlikely(vq->use_map_api)) {
> +                               vq->packed.desc_extra[i].addr =3D premapp=
ed ?
> +                                     DMA_MAPPING_ERROR: addr;
> +                               vq->packed.desc_extra[i].len =3D len;
> +                               vq->packed.desc_extra[i].flags =3D
> +                                       le16_to_cpu(flags);
> +                       }
> +
> +                       if ((unlikely(++i >=3D vq->packed.vring.num))) {
> +                               i =3D 0;
> +                               vq->packed.avail_used_flags ^=3D
> +                                       1 << VRING_PACKED_DESC_F_AVAIL |
> +                                       1 << VRING_PACKED_DESC_F_USED;
> +                               vq->packed.avail_wrap_counter ^=3D 1;
> +                       }
> +
> +                       total_len +=3D len;
> +               }
> +       }
> +
> +       /* We're using some buffers from the free list. */
> +       vq->vq.num_free -=3D total_sg;
> +
> +       /* Update free pointer */
> +       vq->packed.next_avail_idx =3D i;
> +
> +       /* Store token. */
> +       vq->packed.desc_state[head].num =3D total_sg;
> +       vq->packed.desc_state[head].data =3D data;
> +       vq->packed.desc_state[head].indir_desc =3D ctx;
> +       vq->packed.desc_state[head].total_len =3D total_len;
> +
> +       /*
> +        * A driver MUST NOT make the first descriptor in the list
> +        * available before all subsequent descriptors comprising
> +        * the list are made available.
> +        */
> +       virtio_wmb(vq->weak_barriers);
> +       vq->packed.vring.desc[head].flags =3D head_flags;
> +       vq->num_added +=3D total_sg;
> +
> +       pr_debug("Added buffer head %i to %p\n", head, vq);
> +       END_USE(vq);
> +
> +       return 0;
> +
> +unmap_release:
> +       err_idx =3D i;
> +       i =3D head;
> +       vq->packed.avail_used_flags =3D avail_used_flags;
> +
> +       for (n =3D 0; n < total_sg; n++) {
> +               if (i =3D=3D err_idx)
> +                       break;
> +               vring_unmap_extra_packed(vq, &vq->packed.desc_extra[i]);
> +               i++;
> +               if (i >=3D vq->packed.vring.num)
> +                       i =3D 0;
> +       }
> +
> +       END_USE(vq);
> +       return -EIO;
> +}
> +
>  static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  {
>         u16 new, old, off_wrap, flags, wrap_counter, event_idx;
> @@ -1796,10 +2079,82 @@ static void update_last_used_idx_packed(struct vr=
ing_virtqueue *vq,
>                                 cpu_to_le16(vq->last_used_idx));
>  }
>
> +static bool more_used_packed_in_order(const struct vring_virtqueue *vq)
> +{
> +       if (vq->batch_last.id !=3D UINT_MAX)
> +               return true;
> +
> +       return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
> +}
> +
> +static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueu=
e *vq,
> +                                                  unsigned int *len,
> +                                                  void **ctx)
> +{
> +       unsigned int num =3D vq->packed.vring.num;
> +       u16 last_used, last_used_idx;
> +       bool used_wrap_counter;
> +       void *ret;
> +
> +       START_USE(vq);
> +
> +       if (unlikely(vq->broken)) {
> +               END_USE(vq);
> +               return NULL;
> +       }
> +
> +       last_used_idx =3D vq->last_used_idx;
> +       used_wrap_counter =3D packed_used_wrap_counter(last_used_idx);
> +       last_used =3D packed_last_used(last_used_idx);
> +
> +       if (vq->batch_last.id =3D=3D UINT_MAX) {
> +               if (!more_used_packed_in_order(vq)) {
> +                       pr_debug("No more buffers in queue\n");
> +                       END_USE(vq);
> +                       return NULL;
> +               }
> +               /* Only get used elements after they have been exposed by=
 host. */
> +               virtio_rmb(vq->weak_barriers);
> +               vq->batch_last.id =3D
> +                       le16_to_cpu(vq->packed.vring.desc[last_used].id);
> +               vq->batch_last.len =3D
> +                       le32_to_cpu(vq->packed.vring.desc[last_used].len)=
;
> +       }
> +
> +       if (vq->batch_last.id =3D=3D last_used) {
> +               vq->batch_last.id =3D UINT_MAX;
> +               *len =3D vq->batch_last.len;
> +       } else {
> +               *len =3D vq->packed.desc_state[last_used].total_len;
> +       }
> +
> +       if (unlikely(last_used >=3D num)) {
> +               BAD_RING(vq, "id %u out of range\n", last_used);
> +               return NULL;
> +       }
> +       if (unlikely(!vq->packed.desc_state[last_used].data)) {
> +               BAD_RING(vq, "id %u is not a head!\n", last_used);
> +               return NULL;
> +       }
> +
> +       /* detach_buf_packed clears data, so grab it now. */
> +       ret =3D vq->packed.desc_state[last_used].data;
> +       detach_buf_packed_in_order(vq, last_used, ctx);
> +
> +       update_last_used_idx_packed(vq, last_used, last_used,
> +                                   used_wrap_counter);
> +
> +       LAST_ADD_TIME_INVALID(vq);
> +
> +       END_USE(vq);
> +       return ret;
> +}
> +
>  static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>                                           unsigned int *len,
>                                           void **ctx)
>  {
> +       unsigned int num =3D vq->packed.vring.num;
>         u16 last_used, id, last_used_idx;
>         bool used_wrap_counter;
>         void *ret;
> @@ -1826,7 +2181,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vr=
ing_virtqueue *vq,
>         id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);
>         *len =3D le32_to_cpu(vq->packed.vring.desc[last_used].len);
>
> -       if (unlikely(id >=3D vq->packed.vring.num)) {
> +       if (unlikely(id >=3D num)) {
>                 BAD_RING(vq, "id %u out of range\n", id);
>                 return NULL;
>         }
> @@ -1967,7 +2322,10 @@ static void *virtqueue_detach_unused_buf_packed(st=
ruct vring_virtqueue *vq)
>                         continue;
>                 /* detach_buf clears data, so grab it now. */
>                 buf =3D vq->packed.desc_state[i].data;
> -               detach_buf_packed(vq, i, NULL);
> +               if (virtqueue_is_in_order(vq))
> +                       detach_buf_packed_in_order(vq, i, NULL);
> +               else
> +                       detach_buf_packed(vq, i, NULL);
>                 END_USE(vq);
>                 return buf;
>         }
> @@ -1993,6 +2351,8 @@ static struct vring_desc_extra *vring_alloc_desc_ex=
tra(unsigned int num)
>         for (i =3D 0; i < num - 1; i++)
>                 desc_extra[i].next =3D i + 1;
>
> +       desc_extra[num - 1].next =3D 0;
> +
>         return desc_extra;
>  }
>
> @@ -2124,10 +2484,17 @@ static void virtqueue_vring_attach_packed(struct =
vring_virtqueue *vq,
>  {
>         vq->packed =3D *vring_packed;
>
> -       /* Put everything in free lists. */
> -       vq->free_head =3D 0;
> +       if (virtqueue_is_in_order(vq)) {
> +               vq->batch_last.id =3D UINT_MAX;
> +       } else {
> +               /*
> +                * Put everything in free lists. Note that
> +                * next_avail_idx is sufficient with IN_ORDER so
> +                * free_head is unused.
> +                */
> +               vq->free_head =3D 0;
> +       }
>  }
> -
>  static void virtqueue_reset_packed(struct vring_virtqueue *vq)
>  {
>         memset(vq->packed.vring.device, 0, vq->packed.event_size_in_bytes=
);
> @@ -2172,13 +2539,14 @@ static struct virtqueue *__vring_new_virtqueue_pa=
cked(unsigned int index,
>  #else
>         vq->broken =3D false;
>  #endif
> -       vq->layout =3D PACKED;
>         vq->map =3D map;
>         vq->use_map_api =3D vring_use_map_api(vdev);
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !context;
>         vq->event =3D virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> +       vq->layout =3D virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> +                    PACKED_IN_ORDER : PACKED;
>
>         if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>                 vq->weak_barriers =3D false;
> @@ -2288,9 +2656,39 @@ static const struct virtqueue_ops packed_ops =3D {
>         .reset =3D virtqueue_reset_packed,
>  };
>
> +static const struct virtqueue_ops split_in_order_ops =3D {
> +       .add =3D virtqueue_add_split,
> +       .get =3D virtqueue_get_buf_ctx_split_in_order,
> +       .kick_prepare =3D virtqueue_kick_prepare_split,
> +       .disable_cb =3D virtqueue_disable_cb_split,
> +       .enable_cb_delayed =3D virtqueue_enable_cb_delayed_split,
> +       .enable_cb_prepare =3D virtqueue_enable_cb_prepare_split,
> +       .poll =3D virtqueue_poll_split,
> +       .detach_unused_buf =3D virtqueue_detach_unused_buf_split,
> +       .more_used =3D more_used_split_in_order,
> +       .resize =3D virtqueue_resize_split,
> +       .reset =3D virtqueue_reset_split,
> +};
> +
> +static const struct virtqueue_ops packed_in_order_ops =3D {
> +       .add =3D virtqueue_add_packed_in_order,
> +       .get =3D virtqueue_get_buf_ctx_packed_in_order,
> +       .kick_prepare =3D virtqueue_kick_prepare_packed,
> +       .disable_cb =3D virtqueue_disable_cb_packed,
> +       .enable_cb_delayed =3D virtqueue_enable_cb_delayed_packed,
> +       .enable_cb_prepare =3D virtqueue_enable_cb_prepare_packed,
> +       .poll =3D virtqueue_poll_packed,
> +       .detach_unused_buf =3D virtqueue_detach_unused_buf_packed,
> +       .more_used =3D more_used_packed_in_order,
> +       .resize =3D virtqueue_resize_packed,
> +       .reset =3D virtqueue_reset_packed,
> +};
> +
>  static const struct virtqueue_ops *const all_ops[VQ_TYPE_MAX] =3D {
>         [SPLIT] =3D &split_ops,
> -       [PACKED] =3D &packed_ops
> +       [PACKED] =3D &packed_ops,
> +       [SPLIT_IN_ORDER] =3D &split_in_order_ops,
> +       [PACKED_IN_ORDER] =3D &packed_in_order_ops,
>  };
>
>  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
> @@ -2346,6 +2744,12 @@ static int virtqueue_enable_after_reset(struct vir=
tqueue *_vq)
>         case PACKED:                                                    \
>                 ret =3D all_ops[PACKED]->op(vq, ##__VA_ARGS__);          =
 \
>                 break;                                                  \
> +       case SPLIT_IN_ORDER:                                            \
> +               ret =3D all_ops[SPLIT_IN_ORDER]->op(vq, ##__VA_ARGS__);  =
 \
> +               break;                                                  \
> +       case PACKED_IN_ORDER:                                           \
> +               ret =3D all_ops[PACKED_IN_ORDER]->op(vq, ##__VA_ARGS__); =
 \
> +               break;                                                  \
>         default:                                                        \
>                 BUG();                                                  \
>                 break;                                                  \
> @@ -2362,10 +2766,16 @@ static int virtqueue_enable_after_reset(struct vi=
rtqueue *_vq)
>         case PACKED:                                    \
>                 all_ops[PACKED]->op(vq, ##__VA_ARGS__); \
>                 break;                                  \
> -       default:                                        \
> -               BUG();                                  \
> -               break;                                  \
> -       }                                               \
> +       case SPLIT_IN_ORDER:                                            \
> +               all_ops[SPLIT_IN_ORDER]->op(vq, ##__VA_ARGS__); \
> +               break;                                                  \
> +       case PACKED_IN_ORDER:                                           \
> +               all_ops[PACKED_IN_ORDER]->op(vq, ##__VA_ARGS__);        \
> +               break;                                                  \
> +       default:                                                        \
> +               BUG();                                                  \
> +               break;                                                  \
> +       }                                                               \
>  })
>
>  static inline int virtqueue_add(struct virtqueue *_vq,
> @@ -3081,6 +3491,8 @@ void vring_transport_features(struct virtio_device =
*vdev)
>                         break;
>                 case VIRTIO_F_NOTIFICATION_DATA:
>                         break;
> +               case VIRTIO_F_IN_ORDER:
> +                       break;
>                 default:
>                         /* We don't understand this bit. */
>                         __virtio_clear_bit(vdev, i);
> --
> 2.31.1
>

