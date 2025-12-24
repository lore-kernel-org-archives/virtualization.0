Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F2B632
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766534789; cv=none; b=EBijtTCvsjtrIhs4qK/jDlrrNdI5bHwsIAJLVB/VcF/A+AePXd9T3sZ9c3Ojvh7KlR7xJeO4dhiBbZzuAZWf5lHUqbW9IUnGjJMPij8dEepAVmRWZuNk/5cLMZmK1FvglAMqjgaiXtbS49UgnOr2JvGL9ve3Co7hkr0gHpv1UII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766534789; c=relaxed/simple;
	bh=19MgKAXok3rC8s4937aGBC4KgDeDvrawMVAxUXF0g34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+qC33wVoEYabBeurKOzfbMMAVLGmLyyhuIeB3/96uAOZP3UVTYjOhGrOWYXX/tmXtAtCqACYwGUJW40Ts6A134KDnc8Emcovd4YyJzfnBAtW8HsFj+Z6V0+9hMRuTmp7/UPzO9kRfeN1HOsp7i4FktQOnWkjIBDpuYZdR8/FMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FT7Uw+MV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FT7Uw+MV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766534785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9BtyRrLnGm64Rktr+s4Wa3ITFSilxKz7fSofzJ760o=;
	b=FT7Uw+MVmkH1XtwdPh3lU/CBaiUnKstLn5XB9AuMWSBLkM7KB0obt66J6kawBm3aTprzt/
	vfoWxnToPAsw9wZsmkscRSKF97pnF2Br9mahL6VwP6x4CMHpb401mogzOMiDZSGumTkscx
	1jWWyGMZiYxxOPfg1IOiukJwybr2xKU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-_aazgeC8ORGLEZmnCsCtQg-1; Tue, 23 Dec 2025 19:06:24 -0500
X-MC-Unique: _aazgeC8ORGLEZmnCsCtQg-1
X-Mimecast-MFC-AGG-ID: _aazgeC8ORGLEZmnCsCtQg_1766534783
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34e5a9f0d6aso5520716a91.0
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766534783; x=1767139583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m9BtyRrLnGm64Rktr+s4Wa3ITFSilxKz7fSofzJ760o=;
        b=MEdi9CdIoMBUo8AMz7zZDgKAzq//5od58F1nKmxunEJ5GnGU8xwJ1cBJLAoHaW3AZe
         16qNxNoD8cqOLgENC13nfYf8Z21k8wNE9h8lmelFCZ5b6jbHd95y5O1qOprykPsNELFU
         PyM8guscnX2qMxkIr34WU8N+jDKfNlk6AUtGaILElhHbVy9Inpt9+fyUjz3mlzQpycDT
         WO6yPW+biE1HFT1F8uM21wAVU3O5nnDZ7bXtJ8sqaj0nnlXDXf9aP3njj40Fsd+MvIV4
         0TxCZzZ1x4TsyX1kDAnlZ3zA3nUZPTCpgYF3OXjv0D7hsLMwn7vo5un9PdL6ASyVfzH/
         dDow==
X-Forwarded-Encrypted: i=1; AJvYcCWv7N+Wc5n/+JyQwR7T/W7SWyg2Gm8R4U+nqYq2z7RAXxu3QMq5I0PI2fs1wpJi7F0WvUBsk4EKs2vyAuUXZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdbJChuLQ9A/Qd3fnPq3sE97eIcGzK/Jtz+TH9YAS5sdtTVaI6
	D3gWxX/vS4APc/7h8b3EfgYohe8J/1a4kbiq0mAc+TO1FBDs6DscjarRuoDrIg+J/R5BZW0qfdV
	uoe+lioTUBYRPVj0Qeu7VkzYICcSZgwiB+JLlOmTtFxAIQQ8dgk9h6cEP4inhK/Yr1DE7oLoOXX
	waz9fRAOJl2mB4ggJ1/QrFNJZ/gZj+rPTX2hZzVt2qPmI=
X-Gm-Gg: AY/fxX6YN6SN/zGJ1Dj784wbyAsmv5Mk4inNATcaWnQZHCMXnir8H400lxYjTjrfYPM
	DS6gwGS9OpHn2ws/fbZcvEb8zHAUZAQVDFy9CcsSc7+QCDi5wLSCOvCuhFiOPQrvalNdxTmN54x
	ov4wssTac7zrG24xwiPOBjBDpnnPNnLJOQ5jPT/GZaqhzQBQBgxc1ORofnk/tA59z3pQey
X-Received: by 2002:a17:90b:28cc:b0:34c:6a13:c3bc with SMTP id 98e67ed59e1d1-34e71e0a19dmr17095231a91.9.1766534783035;
        Tue, 23 Dec 2025 16:06:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEro8Jnc6wXgueOCjWuEnqz9oMKFE6Fp+xhkOaUlLyKJPlt0O/oQqWuESr6vyI81VxXuczyRuXC1aWpqtr8sZU=
X-Received: by 2002:a17:90b:28cc:b0:34c:6a13:c3bc with SMTP id
 98e67ed59e1d1-34e71e0a19dmr17095204a91.9.1766534782304; Tue, 23 Dec 2025
 16:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251125070838.70736-1-jasowang@redhat.com> <20251125070838.70736-20-jasowang@redhat.com>
 <CAJaqyWdqcT7mM25Kigk7hOF2cjbSejVdzm5rML==4TY9cyM0jA@mail.gmail.com> <CAJaqyWeeQFCYeCYDMwUdwH2WsM7SiMLSyKTR47YigSbdf=qbKQ@mail.gmail.com>
In-Reply-To: <CAJaqyWeeQFCYeCYDMwUdwH2WsM7SiMLSyKTR47YigSbdf=qbKQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Dec 2025 08:06:08 +0800
X-Gm-Features: AQt7F2q2TChhmpUWeMVKGwPAMMxcQ-qk2bj7JmL-C7DgDPKMtdJuZmVDM_Vo_oI
Message-ID: <CACGkMEtb8WYUamBc-WouAS28vXUtgnszHNM7xPPNw5gABik5KQ@mail.gmail.com>
Subject: Re: [PATCH V9 19/19] virtio_ring: add in order support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ntHHIGkSnCwH8-9fYZLmZ-vuXGjU2ieYKg_dfKtBuoU_1766534783
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:04=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Dec 19, 2025 at 11:44=E2=80=AFAM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Tue, Nov 25, 2025 at 8:10=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
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
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > I have one nitpick though, but it can be added on top or just ignored.
> >
> > > ---
> > >  drivers/virtio/virtio_ring.c | 458 +++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 435 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 61884e031b94..9847b23f82ea 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -70,6 +70,8 @@
> > >  enum vq_layout {
> > >         SPLIT =3D 0,
> > >         PACKED,
> > > +       SPLIT_IN_ORDER,
> > > +       PACKED_IN_ORDER,
> > >         VQ_TYPE_MAX,
> > >  };
> > >
> > > @@ -80,6 +82,7 @@ struct vring_desc_state_split {
> > >          * allocated together. So we won't stress more to the memory =
allocator.
> > >          */
> > >         struct vring_desc *indir_desc;
> > > +       u32 total_len;                  /* Buffer Length */
> > >  };
> > >
> > >  struct vring_desc_state_packed {
> > > @@ -91,6 +94,7 @@ struct vring_desc_state_packed {
> > >         struct vring_packed_desc *indir_desc;
> > >         u16 num;                        /* Descriptor list length. */
> > >         u16 last;                       /* The last desc state in a l=
ist. */
> > > +       u32 total_len;                  /* Buffer Length */
> > >  };
> > >
> > >  struct vring_desc_extra {
> > > @@ -205,8 +209,24 @@ struct vring_virtqueue {
> > >
> > >         enum vq_layout layout;
> > >
> > > -       /* Head of free buffer list. */
> > > +       /*
> > > +        * Without IN_ORDER it's the head of free buffer list. With
> > > +        * IN_ORDER and SPLIT, it's the next available buffer
> > > +        * index. With IN_ORDER and PACKED, it's unused.
> > > +        */
> > >         unsigned int free_head;
> > > +
> > > +       /*
> > > +        * With IN_ORDER, once we see an in-order batch, this stores
> > > +        * this last entry, and until we return the last buffer.
> > > +        * After this, id is set to vq.num to mark it invalid.
> > > +        * Unused without IN_ORDER.
> > > +        */
> > > +       struct used_entry {
> > > +               u32 id;
> > > +               u32 len;
> > > +       } batch_last;
> > > +
> > >         /* Number we've added since last sync. */
> > >         unsigned int num_added;
> > >
> > > @@ -218,6 +238,11 @@ struct vring_virtqueue {
> > >          */
> > >         u16 last_used_idx;
> > >
> > > +       /* With IN_ORDER and SPLIT, last descriptor id we used to
> > > +        * detach buffer.
> > > +        */
> > > +       u16 last_used;
> > > +
> > >         /* Hint for event idx: already triggered no need to disable. =
*/
> > >         bool event_triggered;
> > >
> > > @@ -259,7 +284,12 @@ static void vring_free(struct virtqueue *_vq);
> > >
> > >  static inline bool virtqueue_is_packed(const struct vring_virtqueue =
*vq)
> > >  {
> > > -       return vq->layout =3D=3D PACKED;
> > > +       return vq->layout =3D=3D PACKED || vq->layout =3D=3D PACKED_I=
N_ORDER;
> > > +}
> > > +
> > > +static inline bool virtqueue_is_in_order(const struct vring_virtqueu=
e *vq)
> > > +{
> > > +       return vq->layout =3D=3D SPLIT_IN_ORDER || vq->layout =3D=3D =
PACKED_IN_ORDER;
> > >  }
> > >
> > >  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> > > @@ -469,6 +499,8 @@ static void virtqueue_init(struct vring_virtqueue=
 *vq, u32 num)
> > >         else
> > >                 vq->last_used_idx =3D 0;
> > >
> > > +       vq->last_used =3D 0;
> > > +
> > >         vq->event_triggered =3D false;
> > >         vq->num_added =3D 0;
> > >
> > > @@ -576,6 +608,8 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> > >         struct scatterlist *sg;
> > >         struct vring_desc *desc;
> > >         unsigned int i, n, avail, descs_used, err_idx, sg_count =3D 0=
;
> > > +       /* Total length for in-order */
> > > +       unsigned int total_len =3D 0;
> > >         int head;
> > >         bool indirect;
> > >
> > > @@ -648,6 +682,7 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> > >                          */
> > >                         i =3D virtqueue_add_desc_split(vq, desc, extr=
a, i, addr,
> > >                                                      len, flags ,prem=
apped);
> > > +                       total_len +=3D len;
> > >                 }
> > >         }
> > >         for (; n < (out_sgs + in_sgs); n++) {
> > > @@ -667,6 +702,7 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> > >                          */
> > >                         i =3D virtqueue_add_desc_split(vq, desc, extr=
a, i, addr,
> > >                                                      len, flags, prem=
apped);
> > > +                       total_len +=3D len;
> > >                 }
> > >         }
> > >
> > > @@ -689,7 +725,12 @@ static inline int virtqueue_add_split(struct vri=
ng_virtqueue *vq,
> > >         vq->vq.num_free -=3D descs_used;
> > >
> > >         /* Update free pointer */
> > > -       if (indirect)
> > > +       if (virtqueue_is_in_order(vq)) {
> > > +               vq->free_head +=3D descs_used;
> > > +               if (vq->free_head >=3D vq->split.vring.num)
> > > +                       vq->free_head -=3D vq->split.vring.num;
> > > +               vq->split.desc_state[head].total_len =3D total_len;
> > > +       } else if (indirect)
> > >                 vq->free_head =3D vq->split.desc_extra[head].next;
> > >         else
> > >                 vq->free_head =3D i;
> > > @@ -862,6 +903,14 @@ static bool more_used_split(const struct vring_v=
irtqueue *vq)
> > >         return virtqueue_poll_split(vq, vq->last_used_idx);
> > >  }
> > >
> > > +static bool more_used_split_in_order(const struct vring_virtqueue *v=
q)
> > > +{
> > > +       if (vq->batch_last.id !=3D UINT_MAX)
> > > +               return true;
> > > +
> > > +       return virtqueue_poll_split(vq, vq->last_used_idx);
> > > +}
> > > +
> > >  static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
> > >                                          unsigned int *len,
> > >                                          void **ctx)
> > > @@ -919,6 +968,80 @@ static void *virtqueue_get_buf_ctx_split(struct =
vring_virtqueue *vq,
> > >         return ret;
> > >  }
> > >
> > > +static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtq=
ueue *vq,
> > > +                                                 unsigned int *len,
> > > +                                                 void **ctx)
> > > +{
> > > +       void *ret;
> > > +       unsigned int num =3D vq->split.vring.num;
> > > +       unsigned int num_free =3D vq->vq.num_free;
> > > +       u16 last_used, last_used_idx;
> > > +
> > > +       START_USE(vq);
> > > +
> > > +       if (unlikely(vq->broken)) {
> > > +               END_USE(vq);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       last_used =3D vq->last_used & (num - 1);
> > > +       last_used_idx =3D vq->last_used_idx & (num - 1);
> > > +
> > > +       if (vq->batch_last.id =3D=3D UINT_MAX) {
> > > +               if (!more_used_split_in_order(vq)) {
> > > +                       pr_debug("No more buffers in queue\n");
> > > +                       END_USE(vq);
> > > +                       return NULL;
> > > +               }
> > > +
> > > +               /*
> > > +                * Only get used array entries after they have been
> > > +                * exposed by host.
> > > +                */
> > > +               virtio_rmb(vq->weak_barriers);
> > > +
> > > +               vq->batch_last.id =3D virtio32_to_cpu(vq->vq.vdev,
> > > +                                   vq->split.vring.used->ring[last_u=
sed_idx].id);
> > > +               vq->batch_last.len =3D virtio32_to_cpu(vq->vq.vdev,
> > > +                                    vq->split.vring.used->ring[last_=
used_idx].len);
> > > +       }
> > > +
> > > +       if (vq->batch_last.id =3D=3D last_used) {
> > > +               vq->batch_last.id =3D UINT_MAX;
> > > +               *len =3D vq->batch_last.len;
> > > +       } else {
> > > +               *len =3D vq->split.desc_state[last_used].total_len;
> > > +       }
> > > +
> > > +       if (unlikely(last_used >=3D num)) {
> > > +               BAD_RING(vq, "id %u out of range\n", last_used);
> > > +               return NULL;
> > > +       }
> > > +       if (unlikely(!vq->split.desc_state[last_used].data)) {
> > > +               BAD_RING(vq, "id %u is not a head!\n", last_used);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       /* detach_buf_split clears data, so grab it now. */
> > > +       ret =3D vq->split.desc_state[last_used].data;
> > > +       detach_buf_split_in_order(vq, last_used, ctx);
> > > +
> > > +       vq->last_used_idx++;
> > > +       vq->last_used +=3D (vq->vq.num_free - num_free);
> > > +       /* If we expect an interrupt for the next entry, tell host
> > > +        * by writing event index and flush out the write before
> > > +        * the read in the next get_buf call. */
> > > +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRU=
PT))
> > > +               virtio_store_mb(vq->weak_barriers,
> > > +                               &vring_used_event(&vq->split.vring),
> > > +                               cpu_to_virtio16(vq->vq.vdev, vq->last=
_used_idx));
> > > +
> > > +       LAST_ADD_TIME_INVALID(vq);
> > > +
> > > +       END_USE(vq);
> > > +       return ret;
> > > +}
> > > +
> > >  static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
> > >  {
> > >         if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRU=
PT)) {
> > > @@ -1012,7 +1135,10 @@ static void *virtqueue_detach_unused_buf_split=
(struct vring_virtqueue *vq)
> > >                         continue;
> > >                 /* detach_buf_split clears data, so grab it now. */
> > >                 buf =3D vq->split.desc_state[i].data;
> > > -               detach_buf_split(vq, i, NULL);
> > > +               if (virtqueue_is_in_order(vq))
> > > +                       detach_buf_split_in_order(vq, i, NULL);
> > > +               else
> > > +                       detach_buf_split(vq, i, NULL);
> > >                 vq->split.avail_idx_shadow--;
> > >                 vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq=
.vdev,
> > >                                 vq->split.avail_idx_shadow);
> > > @@ -1075,6 +1201,7 @@ static void virtqueue_vring_attach_split(struct=
 vring_virtqueue *vq,
> > >
> > >         /* Put everything in free lists. */
> > >         vq->free_head =3D 0;
> > > +       vq->batch_last.id =3D UINT_MAX;
> > >  }
> > >
> > >  static int vring_alloc_state_extra_split(struct vring_virtqueue_spli=
t *vring_split)
> > > @@ -1186,7 +1313,6 @@ static struct virtqueue *__vring_new_virtqueue_=
split(unsigned int index,
> > >         if (!vq)
> > >                 return NULL;
> > >
> > > -       vq->layout =3D SPLIT;
> > >         vq->vq.callback =3D callback;
> > >         vq->vq.vdev =3D vdev;
> > >         vq->vq.name =3D name;
> > > @@ -1206,6 +1332,8 @@ static struct virtqueue *__vring_new_virtqueue_=
split(unsigned int index,
> > >         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIR=
ECT_DESC) &&
> > >                 !context;
> > >         vq->event =3D virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_ID=
X);
> > > +       vq->layout =3D virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> > > +                    SPLIT_IN_ORDER : SPLIT;
> > >
> > >         if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> > >                 vq->weak_barriers =3D false;
> > > @@ -1363,13 +1491,14 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > >                                          unsigned int in_sgs,
> > >                                          void *data,
> > >                                          bool premapped,
> > > -                                        gfp_t gfp)
> > > +                                        gfp_t gfp,
> > > +                                        u16 id)
> > >  {
> > >         struct vring_desc_extra *extra;
> > >         struct vring_packed_desc *desc;
> > >         struct scatterlist *sg;
> > > -       unsigned int i, n, err_idx, len;
> > > -       u16 head, id;
> > > +       unsigned int i, n, err_idx, len, total_len =3D 0;
> > > +       u16 head;
> > >         dma_addr_t addr;
> > >
> > >         head =3D vq->packed.next_avail_idx;
> > > @@ -1387,8 +1516,6 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> > >         }
> > >
> > >         i =3D 0;
> > > -       id =3D vq->free_head;
> > > -       BUG_ON(id =3D=3D vq->packed.vring.num);
> > >
> > >         for (n =3D 0; n < out_sgs + in_sgs; n++) {
> > >                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > > @@ -1408,6 +1535,7 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> > >                                 extra[i].flags =3D n < out_sgs ?  0 :=
 VRING_DESC_F_WRITE;
> > >                         }
> > >
> > > +                       total_len +=3D len;
> > >                         i++;
> > >                 }
> > >         }
> > > @@ -1454,13 +1582,15 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > >                                 1 << VRING_PACKED_DESC_F_USED;
> > >         }
> > >         vq->packed.next_avail_idx =3D n;
> > > -       vq->free_head =3D vq->packed.desc_extra[id].next;
> > > +       if (!virtqueue_is_in_order(vq))
> > > +               vq->free_head =3D vq->packed.desc_extra[id].next;
> > >
> > >         /* Store token and indirect buffer state. */
> > >         vq->packed.desc_state[id].num =3D 1;
> > >         vq->packed.desc_state[id].data =3D data;
> > >         vq->packed.desc_state[id].indir_desc =3D desc;
> > >         vq->packed.desc_state[id].last =3D id;
> > > +       vq->packed.desc_state[id].total_len =3D total_len;
> > >
> > >         vq->num_added +=3D 1;
> > >
> > > @@ -1513,8 +1643,11 @@ static inline int virtqueue_add_packed(struct =
vring_virtqueue *vq,
> > >         BUG_ON(total_sg =3D=3D 0);
> > >
> > >         if (virtqueue_use_indirect(vq, total_sg)) {
> > > +               id =3D vq->free_head;
> > > +               BUG_ON(id =3D=3D vq->packed.vring.num);
> > >                 err =3D virtqueue_add_indirect_packed(vq, sgs, total_=
sg, out_sgs,
> > > -                                                   in_sgs, data, pre=
mapped, gfp);
> > > +                                                   in_sgs, data, pre=
mapped,
> > > +                                                   gfp, id);
> > >                 if (err !=3D -ENOMEM) {
> > >                         END_USE(vq);
> > >                         return err;
> > > @@ -1635,6 +1768,156 @@ static inline int virtqueue_add_packed(struct=
 vring_virtqueue *vq,
> > >         return -EIO;
> > >  }
> > >
> > > +static inline int virtqueue_add_packed_in_order(struct vring_virtque=
ue *vq,
> > > +                                               struct scatterlist *s=
gs[],
> > > +                                               unsigned int total_sg=
,
> > > +                                               unsigned int out_sgs,
> > > +                                               unsigned int in_sgs,
> > > +                                               void *data,
> > > +                                               void *ctx,
> > > +                                               bool premapped,
> > > +                                               gfp_t gfp)
> > > +{
> > > +       struct vring_packed_desc *desc;
> > > +       struct scatterlist *sg;
> > > +       unsigned int i, n, sg_count, err_idx, total_len =3D 0;
> > > +       __le16 head_flags, flags;
> > > +       u16 head, avail_used_flags;
> > > +       int err;
> > > +
> > > +       START_USE(vq);
> > > +
> > > +       BUG_ON(data =3D=3D NULL);
> > > +       BUG_ON(ctx && vq->indirect);
> > > +
> > > +       if (unlikely(vq->broken)) {
> > > +               END_USE(vq);
> > > +               return -EIO;
> > > +       }
> > > +
> > > +       LAST_ADD_TIME_UPDATE(vq);
> > > +
> > > +       BUG_ON(total_sg =3D=3D 0);
> > > +
> > > +       if (virtqueue_use_indirect(vq, total_sg)) {
> > > +               err =3D virtqueue_add_indirect_packed(vq, sgs, total_=
sg, out_sgs,
> > > +                                                   in_sgs, data, pre=
mapped, gfp,
> > > +                                                   vq->packed.next_a=
vail_idx);
> > > +               if (err !=3D -ENOMEM) {
> > > +                       END_USE(vq);
> > > +                       return err;
> > > +               }
> > > +
> > > +               /* fall back on direct */
> > > +       }
> > > +
> > > +       head =3D vq->packed.next_avail_idx;
> > > +       avail_used_flags =3D vq->packed.avail_used_flags;
> > > +
> > > +       WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect=
);
> > > +
> > > +       desc =3D vq->packed.vring.desc;
> > > +       i =3D head;
> > > +
> > > +       if (unlikely(vq->vq.num_free < total_sg)) {
> > > +               pr_debug("Can't add buf len %i - avail =3D %i\n",
> > > +                        total_sg, vq->vq.num_free);
> > > +               END_USE(vq);
> > > +               return -ENOSPC;
> > > +       }
> > > +
> > > +       sg_count =3D 0;
> > > +       for (n =3D 0; n < out_sgs + in_sgs; n++) {
> > > +               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > > +                       dma_addr_t addr;
> > > +                       u32 len;
> > > +
> > > +                       flags =3D 0;
> > > +                       if (++sg_count !=3D total_sg)
> > > +                               flags |=3D cpu_to_le16(VRING_DESC_F_N=
EXT);
> > > +                       if (n >=3D out_sgs)
> > > +                               flags |=3D cpu_to_le16(VRING_DESC_F_W=
RITE);
> > > +
> > > +                       if (vring_map_one_sg(vq, sg, n < out_sgs ?
> > > +                                            DMA_TO_DEVICE : DMA_FROM=
_DEVICE,
> > > +                                            &addr, &len, premapped))
> > > +                               goto unmap_release;
> > > +
> > > +                       flags |=3D cpu_to_le16(vq->packed.avail_used_=
flags);
> > > +
> > > +                       if (i =3D=3D head)
> > > +                               head_flags =3D flags;
> > > +                       else
> > > +                               desc[i].flags =3D flags;
> > > +
> > > +                       desc[i].addr =3D cpu_to_le64(addr);
> > > +                       desc[i].len =3D cpu_to_le32(len);
> > > +                       desc[i].id =3D cpu_to_le16(head);
> > > +
> > > +                       if (unlikely(vq->use_map_api)) {
> > > +                               vq->packed.desc_extra[i].addr =3D pre=
mapped ?
> > > +                                     DMA_MAPPING_ERROR: addr;
> > > +                               vq->packed.desc_extra[i].len =3D len;
> > > +                               vq->packed.desc_extra[i].flags =3D
> > > +                                       le16_to_cpu(flags);
> > > +                       }
> > > +
> > > +                       if ((unlikely(++i >=3D vq->packed.vring.num))=
) {
> > > +                               i =3D 0;
> > > +                               vq->packed.avail_used_flags ^=3D
> > > +                                       1 << VRING_PACKED_DESC_F_AVAI=
L |
> > > +                                       1 << VRING_PACKED_DESC_F_USED=
;
> > > +                               vq->packed.avail_wrap_counter ^=3D 1;
> > > +                       }
> > > +
> > > +                       total_len +=3D len;
>
> I hit send too fast :). The used descriptor "length" field is the
> amount of bytes written by the device. So total_len should only be
> updated in the in descs, not in the out ones. Same with split. Maybe
> rename to total_in_len is also useful, I'm calling that way in SVQ.

Yes, I will fix this.

>
> > > +               }
> > > +       }
> > > +
> > > +       /* We're using some buffers from the free list. */
> > > +       vq->vq.num_free -=3D total_sg;
> > > +
> > > +       /* Update free pointer */
> > > +       vq->packed.next_avail_idx =3D i;
> > > +
> > > +       /* Store token. */
> > > +       vq->packed.desc_state[head].num =3D total_sg;
> > > +       vq->packed.desc_state[head].data =3D data;
> > > +       vq->packed.desc_state[head].indir_desc =3D ctx;
> > > +       vq->packed.desc_state[head].total_len =3D total_len;
> > > +
> > > +       /*
> > > +        * A driver MUST NOT make the first descriptor in the list
> > > +        * available before all subsequent descriptors comprising
> > > +        * the list are made available.
> > > +        */
> > > +       virtio_wmb(vq->weak_barriers);
> > > +       vq->packed.vring.desc[head].flags =3D head_flags;
> > > +       vq->num_added +=3D total_sg;
> > > +
> > > +       pr_debug("Added buffer head %i to %p\n", head, vq);
> > > +       END_USE(vq);
> > > +
> > > +       return 0;
> > > +
> > > +unmap_release:
> > > +       err_idx =3D i;
> > > +       i =3D head;
> > > +       vq->packed.avail_used_flags =3D avail_used_flags;
> > > +
> > > +       for (n =3D 0; n < total_sg; n++) {
> > > +               if (i =3D=3D err_idx)
> > > +                       break;
> > > +               vring_unmap_extra_packed(vq, &vq->packed.desc_extra[i=
]);
> > > +               i++;
> > > +               if (i >=3D vq->packed.vring.num)
> > > +                       i =3D 0;
> > > +       }
> > > +
> > > +       END_USE(vq);
> > > +       return -EIO;
> > > +}
> >
> > This function duplicates a lot of logic from virtqueue_add_packed in
> > my opinion. To make descriptors available is the same process in
> > order, except for saving total_len. I like this new version more, as
> > it gets rid of descs_used, that is always =3D total_sg. Maybe it is
> > better to just perform these steps conditionally, the same way as
> > virtqueue_add_split?
> >

I prefer to leave this as is to reduce the change since it's in the
merge window now.

Thanks

