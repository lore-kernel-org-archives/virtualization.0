Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C350A21D5B3
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758692300; cv=none; b=UfsUQ2alTLnNq2jdL21HYkdi9drSZzGKH1cKP8VAEQwB/8kX3wcmLO58NFvEAH+ISdP9ShD5me4bTfNz4FQ9MEiOfduPel7VKAbircuctWf0oYK63ueOS6PEP0fJbIYVPS0OWEhwYlaxdTAB+H7cudHSiG8mlZZv24OZP+UQn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758692300; c=relaxed/simple;
	bh=KA1QNP+iOdJwD6IPg8p5whMwnMPyXfj2p6cvxvXts94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsLYib/p6QMjutxqrXHk23VK0393dd4V+wQPf6WzgEDoqSTsRuX7gC/YMPiBdkVcE5s9zgIqrXig+kIC6mwrNaM51ZNaLMn5YpEVpnc7Nf6ohXVT0ZmdxsUh0OzjZs9dZVORb4fT740cmeCjjX3IKxzAzGa7r1Yqb04vywN+gMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RM6yehZt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RM6yehZt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758692297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hihurR2zRUErIYZo12Xrc8bmmh31dywfS2yZgz5urck=;
	b=RM6yehZty8gVS8HT4iyXNd5KONX5C8Hnl+kXVESQoiE59UcXIgvkenL/l7+wxkE7DHMGgb
	NY1sHQUVZUiYQoSoK4KOW8AK7H5+rJjg5tqAek0Kbtc92Q0WM1HAkHC8rQu85FrTLfFZ7e
	WsNwYb8UBdaNxhbh5tG9LI3SIuA1bNk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-JhoK7OqnNHG3onTifQ64kA-1; Wed, 24 Sep 2025 01:38:16 -0400
X-MC-Unique: JhoK7OqnNHG3onTifQ64kA-1
X-Mimecast-MFC-AGG-ID: JhoK7OqnNHG3onTifQ64kA_1758692295
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-277f0ea6fc6so57116165ad.2
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 22:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758692295; x=1759297095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hihurR2zRUErIYZo12Xrc8bmmh31dywfS2yZgz5urck=;
        b=tRxRpQqxf33hnb7UuPpP0/D5kykolspLULOBhSkZOsQt7YBb2mHGYysFKcIqvg2jgT
         VVTQVtIz/5hzWsIvKBwQaEP6x4cS305siYzTSC5SPasrFKCFm2i0nFkCFHOniBgVTkFa
         IFdsJMyZInEDC+1rkk9byhxuCcvR6HQKG80VMbyCrDudPKzNbiF46Wrld/DiwipDfmFM
         Zt7/J3ixMCVcoajEqO4kVjidQnUarIahcGA70cayCQwXULlutnTBx4wzfmapc/BhbdKC
         Vat4sBNPjwpWgh0uG7L9o7IBEu+UGCkQFWXXpo/4v3Q4Uho8Oh7TQZE4bwZnARlV66kY
         o3hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwo5rY29YNjsm4QTBiY5uSj9eLhoKWwdNndPk1Sw5CROXukOJYXy9NK2kUwk2fmANUpDf3Nya3b9OZLPxKqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2vDHMwpH3HWkWsD95uKn8SQUOi5xxe7iI6mSg4eWfrfE4yAGj
	eR4HMf6pxLxe2ceRADDC+4zDrwTh0O3bgQENCuYn6/ktpGyWiFCDu6GHdf4Id4xbs7f2ACFDoPy
	H4ikevaBXjXSgHc/XFUm7X9AcCk5Wt8t64xG1PN8lEQURG2gRhvejl3UDioho+0nsyh8rzJfd3T
	RuqAXTsc6fyn7sTwhY+19zy7WPgRJCasoiuqqfzExgUfA=
X-Gm-Gg: ASbGnculUWVvEQUdezGxQxxnq3jvzStW7/F+cGcAt592BKp0CHvG0/RBXVvW/45zAo6
	ZJX5vSirxog09ZV4CcGoDtGXiVYrNd6Ki7fH2rFVimLj6IPBX/6kVmELItF0LN7DHiKioyodMqe
	wRTCNp4c8oJf8mkFOFgw==
X-Received: by 2002:a17:902:e750:b0:269:a8a8:4029 with SMTP id d9443c01a7336-27cc09e438emr75594145ad.5.1758692295227;
        Tue, 23 Sep 2025 22:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFCg7N1f1H+hfQw3+Nmgb0hnz37Xm6yjReegwEqRowfiGm2+m9FsFlUnSHACRlvxKhPYHIIXOKMkfzdw8K4Nw=
X-Received: by 2002:a17:902:e750:b0:269:a8a8:4029 with SMTP id
 d9443c01a7336-27cc09e438emr75593515ad.5.1758692294187; Tue, 23 Sep 2025
 22:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-20-jasowang@redhat.com>
 <20250921142053-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921142053-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 13:38:03 +0800
X-Gm-Features: AS18NWDZvhFUT8No6yLNin7JlDDvcYs50zxBZISnex8R65uIYgGXFHWNLu-oi5w
Message-ID: <CACGkMEtFRyzafYqrfuT6gYeosAADL94T5-abEwQ3ThTMn7HQkw@mail.gmail.com>
Subject: Re: [PATCH V6 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XpY9EOy8f3DibsT8FoYDmC-dpB9UP4wwaBoAx11_R2U_1758692295
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:24=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:54PM +0800, Jason Wang wrote:
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue. Perfomance could be gained for the device where the
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
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 421 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 401 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index b700aa3e56c3..c00b5e57f2fc 100644
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
> > @@ -206,6 +210,17 @@ struct vring_virtqueue {
> >
> >       /* Head of free buffer list. */
> >       unsigned int free_head;
> > +
> > +     /*
> > +      * With IN_ORDER, devices write a single used ring entry with
> > +      * the id corresponding to the head entry of the descriptor chain
> > +      * describing the last buffer in the batch
> > +      */
> > +     struct used_entry {
> > +             u32 id;
> > +             u32 len;
> > +     } batch_last;
> > +
> >       /* Number we've added since last sync. */
> >       unsigned int num_added;
> >
> > @@ -258,7 +273,12 @@ static void vring_free(struct virtqueue *_vq);
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
> > @@ -575,6 +595,8 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> >       unsigned int i, n, avail, descs_used, err_idx, c =3D 0;
> > +     /* Total length for in-order */
> > +     unsigned int total_len =3D 0;
> >       int head;
> >       bool indirect;
> >
> > @@ -646,6 +668,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >                                                    ++c =3D=3D total_sg =
?
> >                                                    0 : VRING_DESC_F_NEX=
T,
> >                                                    premapped);
> > +                     total_len +=3D len;
> >               }
> >       }
> >       for (; n < (out_sgs + in_sgs); n++) {
> > @@ -663,6 +686,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >                               i, addr, len,
> >                               (++c =3D=3D total_sg ? 0 : VRING_DESC_F_N=
EXT) |
> >                               VRING_DESC_F_WRITE, premapped);
> > +                     total_len +=3D len;
> >               }
> >       }
> >
> > @@ -685,7 +709,12 @@ static inline int virtqueue_add_split(struct vring=
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
> > +     } else if (indirect)
> >               vq->free_head =3D vq->split.desc_extra[head].next;
> >       else
> >               vq->free_head =3D i;
> > @@ -858,6 +887,14 @@ static bool more_used_split(const struct vring_vir=
tqueue *vq)
> >       return virtqueue_poll_split(vq, vq->last_used_idx);
> >  }
> >
> > +static bool more_used_split_in_order(const struct vring_virtqueue *vq)
> > +{
> > +     if (vq->batch_last.id !=3D vq->packed.vring.num)
> > +             return true;
>
> Hmm why ->packed?

Right, it's a bug. Let me fix that.

>
> This is actually a problem in this approach, kinda easy to get confused
> which variant to call where.

Probably, but we have been doing this since the introduction of packed
virtqueue.

>
> Worth thinking how to fix this.
>

Yes, but I think this series improves this by introducing the
virtqueue ops. Optimization could be done on top.

For example, having separate files for packed and split with private struct=
ure.

Thanks

