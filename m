Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A04C8F3
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672289; cv=none; b=oSsvGkLDQnaxNGX+sJu2PMmeTr1qVLGb7u5p9CEPr2bHcy1jVWcnmyALh1HIM9UTK/9TQIOdn3LyZ8PGKgFmmnKBsDU3cF4Izbk4YeuPAAlUq7pA5zecvdUZJtDAaeeHgfkCUOaWLnOCAmzCwMb8eBUqA0eGu8+7l1lFR4kNRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672289; c=relaxed/simple;
	bh=BcZiEvbUPWAEXb1/HWwVCeV6Dbuj8tN2IOHOXPgW+6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3YYLLlneQ358NBGcUjTfMrJ/RNXmQYNIJd8+SuUUXbSyVBMUXgIBApQOxGUl6XmQSRGBu5VMPopqOdqApJzAcOTAQnOUCGYfb8eB542wRtUttfSaRNgUv3dKPeGqYwQLpwfo57Td4Rhgn+j+aZ9EK6BK89DU0TFuqGxq8O66cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMD7MnFu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMD7MnFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718672286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+okBG7PpWy4DufQEdFfLyzbevb4glnqxJQBbXfup58=;
	b=AMD7MnFuCo/UymqvEAf2dBsEPWqlOKitC5VUKBH9Qnpwtn0QvAbJUkTz535yE95SG6SqHB
	wiPdHhq+OBBltZXYaJfLBgMA095KrKIb/mfIAi0UmKaWng+TMMKRDsTOtA+/BxduX6jY26
	VubH76sq9K4+/E7m/QwZjV0w8Ygcftk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-DJScdnyHO-2Gb0Mw7YbOBw-1; Mon, 17 Jun 2024 20:58:05 -0400
X-MC-Unique: DJScdnyHO-2Gb0Mw7YbOBw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c2d6e09e62so5137568a91.2
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 17:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718672284; x=1719277084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+okBG7PpWy4DufQEdFfLyzbevb4glnqxJQBbXfup58=;
        b=wRtooIrQb1muHyOzgWTKFshkjKZfAbXEmT0oOgiESmXgJcaOo++i9UTYfdqDNKz+Ki
         Q64SPq57lRVWo/5bryeWTncJFJHNvlZFC/dHLAeu2WvPokWHiF4IeHx2VWbFsKNd14Hh
         e3g5zQW3kPIKYb3Dahz3lnGeCSjK44T9Z7aONxOzUFyw6d3TimHbNStqqjMDc9S3lSx0
         K9FFPMRj6heS3cvqGp6foNfv0cV1AbH12PZmVTT2waKAnF5k0wSv8CMFlMWcUOtvkHnv
         bm5PG3m9pJLjz+7YmqqHT1Zi47DCL5f9rCE+YMYY7+qbKNGdXZ/tP6pzEUf0Zzf8fVOC
         wg+w==
X-Forwarded-Encrypted: i=1; AJvYcCVYd3/X6BjhVXjpe5x8OZN2ww+W4Zxl0Ljs1v/IOhPkAfolhtsau7l6luoyNQSFfP0zcD9fJJuk0WxOJ5c5sc+/ikALGo1nPtisldpWNPE=
X-Gm-Message-State: AOJu0YyrT8JpEbT57YkO7PpKYtd5/5bIq5ye9VCqszWoztbiGA26dXCE
	uFn1VZb/mjPTQ4zQ2OsPnr1RwcCyBBt+FKJHwDufBcPwUCPBdxRLpz61TnazU9rnVKAUeGqqMBZ
	9hF0U8kmrHpQSXLL1j43ebfcmKDeKumLuvPDOinS721M2pX1PZBcXv0JrYYWdgmInUBXsSVtk0P
	O09jiwNjtptBY65nuZTVRUQacBztuL2a66X2PSBG0=
X-Received: by 2002:a17:90a:d710:b0:2c2:dd0b:3d78 with SMTP id 98e67ed59e1d1-2c4db242536mr2409797a91.18.1718672283887;
        Mon, 17 Jun 2024 17:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFInXJzYplRO3ASLqLbn+uSgyN6soGHyPycPHBS3eUTSuLbgFdWsMgokUAZDHLUU+Qcszixp8pt/1/YhZVZ20=
X-Received: by 2002:a17:90a:d710:b0:2c2:dd0b:3d78 with SMTP id
 98e67ed59e1d1-2c4db242536mr2409782a91.18.1718672283464; Mon, 17 Jun 2024
 17:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-9-xuanzhuo@linux.alibaba.com> <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
 <1718609026.3881757-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1718609026.3881757-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 08:57:52 +0800
Message-ID: <CACGkMEvLv8g7BHC2Dhy_BsrcUxshaY=49DhFJDz7uqw-AH0GXg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 17 Jun 2024 13:00:13 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > If the xsk is enabling, the xsk tx will share the send queue.
> > > But the xsk requires that the send queue use the premapped mode.
> > > So the send queue must support premapped mode when it is bound to
> > > af-xdp.
> > >
> > > * virtnet_sq_set_premapped(sq, true) is used to enable premapped mode=
.
> > >
> > >     In this mode, the driver will record the dma info when skb or xdp
> > >     frame is sent.
> > >
> > >     Currently, the SQ premapped mode is operational only with af-xdp.=
 In
> > >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will sha=
re
> > >     the same SQ. Af-xdp independently manages its DMA. The kernel sta=
ck
> > >     and xdp tx/redirect utilize this DMA metadata to manage the DMA
> > >     info.
> > >
> > >     If the indirect descriptor feature be supported, the volume of DM=
A
> > >     details we need to maintain becomes quite substantial. Here, we h=
ave
> > >     a cap on the amount of DMA info we manage.
> > >
> > >     If the kernel stack and xdp tx/redirect attempt to use more
> > >     descriptors, virtnet_add_outbuf() will return an -ENOMEM error. B=
ut
> > >     the af-xdp can work continually.
> >
> > Rethink of this whole logic, it looks like all the complication came
> > as we decided to go with a pre queue pre mapping flag. I wonder if
> > things could be simplified if we do that per buffer?
>
> YES. That will be simply.
>
> Then this patch will be not needed. The virtio core must record the prema=
pped
> imfo to the virtio ring state or extra.
>
>          http://lore.kernel.org/all/20230517022249.20790-6-xuanzhuo@linux=
.alibaba.com

Yes, something like this. I think it's worthwhile to re-consider that
approach. If my memory is correct, we haven't spotted the complicated
issues we need to deal with like this patch.

>
> >
> > Then we don't need complex logic like dmainfo and cap.
>
> So the premapped mode and the internal dma mode can coexist.
> Then we do not need to make the sq to support the premapped mode.

Probably.

>
>
> >
> > >
> > > * virtnet_sq_set_premapped(sq, false) is used to disable premapped mo=
de.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 228 +++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 224 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index e84a4624549b..88ab9ea1646f 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -25,6 +25,7 @@
> > >  #include <net/net_failover.h>
> > >  #include <net/netdev_rx_queue.h>
> > >  #include <net/netdev_queues.h>
> > > +#include <uapi/linux/virtio_ring.h>
> >
> > Why do we need this?
>
> for using VIRTIO_RING_F_INDIRECT_DESC

Ok. It's probably a hint that something like layer violation happens.
A specific driver should not know details about the ring layout ...

>
>
> >
> > >
> > >  static int napi_weight =3D NAPI_POLL_WEIGHT;
> > >  module_param(napi_weight, int, 0444);
> > > @@ -276,6 +277,26 @@ struct virtnet_rq_dma {
> > >         u16 need_sync;
> > >  };
> > >
> > > +struct virtnet_sq_dma {
> > > +       union {
> > > +               struct llist_node node;
> > > +               struct llist_head head;
> >
> > If we want to cap the #dmas, could we simply use an array instead of
> > the list here?
> >
> > > +               void *data;
> > > +       };
> > > +       dma_addr_t addr;
> > > +       u32 len;
> > > +       u8 num;
> > > +};
> > > +
> > > +struct virtnet_sq_dma_info {
> > > +       /* record for kfree */
> > > +       void *p;
> > > +
> > > +       u32 free_num;
> > > +
> > > +       struct llist_head free;
> > > +};
> > > +
> > >  /* Internal representation of a send virtqueue */
> > >  struct send_queue {
> > >         /* Virtqueue associated with this send _queue */
> > > @@ -295,6 +316,11 @@ struct send_queue {
> > >
> > >         /* Record whether sq is in reset state. */
> > >         bool reset;
> > > +
> > > +       /* SQ is premapped mode or not. */
> > > +       bool premapped;
> > > +
> > > +       struct virtnet_sq_dma_info dmainfo;
> > >  };
> > >
> > >  /* Internal representation of a receive virtqueue */
> > > @@ -492,9 +518,11 @@ static void virtnet_sq_free_unused_buf(struct vi=
rtqueue *vq, void *buf);
> > >  enum virtnet_xmit_type {
> > >         VIRTNET_XMIT_TYPE_SKB,
> > >         VIRTNET_XMIT_TYPE_XDP,
> > > +       VIRTNET_XMIT_TYPE_DMA,
> >
> > I think the name is confusing, how about TYPE_PREMAPPED?
> >
> > >  };
> > >
> > > -#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT=
_TYPE_XDP)
> > > +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT=
_TYPE_XDP \
> > > +                               | VIRTNET_XMIT_TYPE_DMA)
> > >
> > >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> > >  {
> > > @@ -510,12 +538,180 @@ static void *virtnet_xmit_ptr_mix(void *ptr, e=
num virtnet_xmit_type type)
> > >         return (void *)((unsigned long)ptr | type);
> > >  }
> > >
> > > +static void virtnet_sq_unmap(struct send_queue *sq, void **data)
> > > +{
> > > +       struct virtnet_sq_dma *head, *tail, *p;
> > > +       int i;
> > > +
> > > +       head =3D *data;
> > > +
> > > +       p =3D head;
> > > +
> > > +       for (i =3D 0; i < head->num; ++i) {
> > > +               virtqueue_dma_unmap_page_attrs(sq->vq, p->addr, p->le=
n,
> > > +                                              DMA_TO_DEVICE, 0);
> > > +               tail =3D p;
> > > +               p =3D llist_entry(llist_next(&p->node), struct virtne=
t_sq_dma, node);
> > > +       }
> > > +
> > > +       *data =3D tail->data;
> > > +
> > > +       __llist_add_batch(&head->node, &tail->node,  &sq->dmainfo.fre=
e);
> > > +
> > > +       sq->dmainfo.free_num +=3D head->num;
> > > +}
> > > +
> > > +static void *virtnet_dma_chain_update(struct send_queue *sq,
> > > +                                     struct virtnet_sq_dma *head,
> > > +                                     struct virtnet_sq_dma *tail,
> > > +                                     u8 num, void *data)
> > > +{
> > > +       sq->dmainfo.free_num -=3D num;
> > > +       head->num =3D num;
> > > +
> > > +       tail->data =3D data;
> > > +
> > > +       return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
> > > +}
> > > +
> > > +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *s=
q, int num, void *data)
> > > +{
> > > +       struct virtnet_sq_dma *head =3D NULL, *p =3D NULL;
> > > +       struct scatterlist *sg;
> > > +       dma_addr_t addr;
> > > +       int i, err;
> > > +
> > > +       if (num > sq->dmainfo.free_num)
> > > +               return NULL;
> > > +
> > > +       for (i =3D 0; i < num; ++i) {
> > > +               sg =3D &sq->sg[i];
> > > +
> > > +               addr =3D virtqueue_dma_map_page_attrs(sq->vq, sg_page=
(sg),
> > > +                                                   sg->offset,
> > > +                                                   sg->length, DMA_T=
O_DEVICE,
> > > +                                                   0);
> > > +               err =3D virtqueue_dma_mapping_error(sq->vq, addr);
> > > +               if (err)
> > > +                       goto err;
> > > +
> > > +               sg->dma_address =3D addr;
> > > +
> > > +               p =3D llist_entry(llist_del_first(&sq->dmainfo.free),
> > > +                               struct virtnet_sq_dma, node);
> > > +
> > > +               p->addr =3D sg->dma_address;
> > > +               p->len =3D sg->length;
> >
> > I may miss something, but I don't see how we cap the total number of dm=
ainfos.
>
> static void *virtnet_dma_chain_update(struct send_queue *sq,
>                                      struct virtnet_sq_dma *head,
>                                      struct virtnet_sq_dma *tail,
>                                      u8 num, void *data)
> {
>        sq->dmainfo.free_num -=3D num;
> ->       head->num =3D num;
>
>        tail->data =3D data;
>
>        return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
> }

Ok, speak too fast I guess it should be more like:

 if (num > sq->dmainfo.free_num)
               return NULL;

Thanks

>
>
>
> Thanks.
>
> >
> > Thanks
> >
>

