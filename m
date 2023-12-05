Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276215481
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvWTov69"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAA1C821AB
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 07:12:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAA1C821AB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XvWTov69
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4b5NqsNQUpJc
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 07:12:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAABC82197
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 07:12:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAABC82197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701760344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kD8A32kwjL2na27A7W2hBlqIe3XWpfK13eV+bO8NmGQ=;
	b=XvWTov691XgwqMNUpDi3l7o8ao5OG9SLhSVzvl/kF/NVBPOktqvv0eagNucSxMOQh9tjVj
	U/EjKJVBwTQ+yvZ7LONGgEhwje6t4nPxXmfFMG5g7O95ICt/8eZXmccisejWTFSIvHt9js
	SYrLXIMLhP1tUKvGCe/Hw1kjKf7agXI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-hJ4TrKX_NPe6_9_rXq8BKg-1; Tue, 05 Dec 2023 02:12:22 -0500
X-MC-Unique: hJ4TrKX_NPe6_9_rXq8BKg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50bfbf019d3so1127472e87.1
        for <virtualization@lists.linux-foundation.org>; Mon, 04 Dec 2023 23:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701760341; x=1702365141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD8A32kwjL2na27A7W2hBlqIe3XWpfK13eV+bO8NmGQ=;
        b=BY6XDfZnSeqOBcKc1NfmpgoMtdx1MuPh73v40nXp1/m8TpSISzKHdOufxnOzIcP154
         sjidAXtAFlOz3ochVJS+9fwN4aE1PSlfFaVAu6Hqp5IyQ/Zijfd268Z3Gq0LJTjBQi6p
         HDajtd7+y4ExX5yovDLSGaOvEK6xNXWhTTBO1iX18Xef6DOcX8uwhysPn8dBqzYZ7PzT
         S+FfNhvMFMbyRhoWVZuPtoAABfy3I93zo0KCN6gRSi67a2FJLll2VIt4vziiIHuQKrOa
         9d769gIpmE1R1WZFhujYfMeKfYb+89YOUvvLCwy1eHKCS33j0YOkKWnQ5U74GQXtauFq
         KDIg==
X-Gm-Message-State: AOJu0YwLXnhObQ+B931JUS9XVFW12hfc29QbL4bRUGWho2yxgSDYeuTl
	9qfb3+ysDneHmjVQW9iiwmI3A339YS5jP1PbNSh0Yqnn15iph8SRNYrslIXRpavUCvZWc6kjf1f
	HV7jR8Zso5Z+x6B+hqoXd8McUk4IKlQJ4qGTBNW0Y1qKCD8l+hOQY+OCnnA==
X-Received: by 2002:ac2:4c10:0:b0:50b:e5cd:aa8e with SMTP id t16-20020ac24c10000000b0050be5cdaa8emr1885268lfq.113.1701760341428;
        Mon, 04 Dec 2023 23:12:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVrZALIkTc5x4OaOwrv61PwjuUlO0CGXiR6D7yi8dWn4zhT3Ry7zkcY6c6Lc54/Bj2kXOfPeJd0UTisAiUpLk=
X-Received: by 2002:ac2:4c10:0:b0:50b:e5cd:aa8e with SMTP id
 t16-20020ac24c10000000b0050be5cdaa8emr1885263lfq.113.1701760341165; Mon, 04
 Dec 2023 23:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231204072331.73776-1-xuanzhuo@linux.alibaba.com> <20231204072331.73776-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231204072331.73776-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Dec 2023 15:12:09 +0800
Message-ID: <CACGkMEvT--4jgba4WHFzSqNgKhExPJVSrmhuUzrbeMf=9XeUGw@mail.gmail.com>
Subject: Re: [PATCH 4/4] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
>
> command: pktgen_sample01_simple.sh -i eth0 -s 16/1400 -d 10.0.0.123 -m 00=
:16:3e:12:e1:3e -n 0 -p 100
> matchine:  ecs.ebmg6e.26xlarge of Aliyun
> cpu: Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> iommu mode: intel_iommu=3Don iommu.strict=3D1 iommu=3Dnopt
>
>                       |        iommu off           |        iommu on
> ----------------------|--------------------------------------------------=
---
>                       | 16         |  1400         | 16         | 1400
> ----------------------|--------------------------------------------------=
---
> Before:               |1716796.00  |  1581829.00   | 390756.00  | 374493.=
00
> After(premapped off): |1733794.00  |  1576259.00   | 390189.00  | 378128.=
00
> After(premapped on):  |1707107.00  |  1562917.00   | 385667.00  | 373584.=
00
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 116 ++++++++++++++++++++++++++++----
>  drivers/net/virtio/virtio_net.h |   2 +
>  2 files changed, 105 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index d81ee75142e0..fa77a85d1d37 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -167,13 +167,32 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> +static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_dm=
a_head *dma)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < dma->next; ++i)
> +               virtqueue_dma_unmap_single_attrs(sq->vq,
> +                                                dma->items[i].addr,
> +                                                dma->items[i].length,
> +                                                DMA_TO_DEVICE, 0);
> +       dma->next =3D 0;

I'd suggest to check vring_use_dma_api() then we can avoid the unnecessary =
loop.

> +}
> +
>  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
>                             u64 *bytes, u64 *packets)
>  {
> +       struct virtio_dma_head *dma;
>         unsigned int len;
>         void *ptr;
>
> -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> +       dma =3D (typeof(dma))sq->sg;

This seems tricky, people may forget to check the sizeof when they
want to extend the dma in the future.

Can we use union here?

> +       dma->num =3D ARRAY_SIZE(sq->sg);
> +       dma->next =3D 0;
> +
> +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len, dma, NULL=
)) !=3D NULL) {
> +               virtnet_sq_unmap_buf(sq, dma);

Can we allow passing NULL then core can just don't bother with
collecting DMA information?

> +
>                 if (!is_xdp_frame(ptr)) {
>                         struct sk_buff *skb =3D ptr;
>
> @@ -567,20 +586,79 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq=
, u32 size, gfp_t gfp)
>         return buf;
>  }
>
> -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> +static void virtnet_set_premapped(struct virtnet_info *vi)
>  {
> +       struct virtio_dma_head dma;
> +       struct virtnet_sq *sq;
>         int i;
>
> -       /* disable for big mode */
> -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> -               return;
> +       sq =3D &vi->sq[0];
> +
> +       BUG_ON(sizeof(sq->sg) < sizeof(dma) + sizeof(dma.items[0]) * ARRA=
Y_SIZE(sq->sg));
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> -                       continue;
> +               if (!virtqueue_set_dma_premapped(vi->sq[i].vq))
> +                       vi->sq[i].do_dma =3D true;
> +
> +               /* disable for big mode */
> +               if (vi->mergeable_rx_bufs || !vi->big_packets) {
> +                       if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> +                               vi->rq[i].do_dma =3D true;
> +               }
> +       }
> +}
> +
> +static void virtnet_sq_unmap_sg(struct virtnet_sq *sq, u32 num)
> +{
> +       struct scatterlist *sg;
> +       u32 i;
> +
> +       for (i =3D 0; i < num; ++i) {
> +               sg =3D &sq->sg[i];
> +
> +               virtqueue_dma_unmap_single_attrs(sq->vq,
> +                                                sg->dma_address,
> +                                                sg->length,
> +                                                DMA_TO_DEVICE, 0);
> +       }
> +}
> +
> +static int virtnet_sq_map_sg(struct virtnet_sq *sq, u32 num)
> +{
> +       struct scatterlist *sg;
> +       u32 i;
> +
> +       for (i =3D 0; i < num; ++i) {
> +               sg =3D &sq->sg[i];
> +               sg->dma_address =3D virtqueue_dma_map_single_attrs(sq->vq=
, sg_virt(sg),
> +                                                                sg->leng=
th,
> +                                                                DMA_TO_D=
EVICE, 0);
> +               if (virtqueue_dma_mapping_error(sq->vq, sg->dma_address))
> +                       goto err;
> +       }
> +
> +       return 0;
> +
> +err:
> +       virtnet_sq_unmap_sg(sq, i);
> +       return -ENOMEM;
> +}
> +
> +static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *data=
)
> +{
> +       int ret;
>
> -               vi->rq[i].do_dma =3D true;
> +       if (sq->do_dma) {
> +               ret =3D virtnet_sq_map_sg(sq, num);
> +               if (ret)
> +                       return -ENOMEM;
>         }
> +
> +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMI=
C);
> +       if (ret && sq->do_dma)
> +               virtnet_sq_unmap_sg(sq, num);
> +
> +       return ret;
>  }
>
>  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> @@ -686,8 +764,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info=
 *vi,
>                             skb_frag_size(frag), skb_frag_off(frag));
>         }
>
> -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
>         if (unlikely(err))
>                 return -ENOSPC; /* Caller handle free/refcnt */
>
> @@ -2126,7 +2203,7 @@ static int xmit_skb(struct virtnet_sq *sq, struct s=
k_buff *skb)
>                         return num_sg;
>                 num_sg++;
>         }
> -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOM=
IC);
> +       return virtnet_add_outbuf(sq, num_sg, skb);
>  }
>
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *de=
v)
> @@ -3852,10 +3929,23 @@ static void virtnet_rq_free_unused_buf(struct vir=
tqueue *vq, void *buf)
>
>  static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
>  {
> +       struct virtnet_info *vi =3D vq->vdev->priv;
> +       struct virtio_dma_head *dma;
> +       struct virtnet_sq *sq;
> +       int i =3D vq2txq(vq);
>         void *buf;
>
> -       while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL)
> +       sq =3D &vi->sq[i];
> +
> +       dma =3D (typeof(dma))sq->sg;
> +       dma->num =3D ARRAY_SIZE(sq->sg);
> +       dma->next =3D 0;
> +
> +       while ((buf =3D virtqueue_detach_unused_buf_premapped(vq, dma)) !=
=3D NULL) {
> +               virtnet_sq_unmap_buf(sq, dma);
> +
>                 virtnet_sq_free_unused_buf(vq, buf);
> +       }
>  }
>
>  static void virtnet_rq_free_unused_bufs(struct virtqueue *vq)
> @@ -4052,7 +4142,7 @@ static int init_vqs(struct virtnet_info *vi)
>         if (ret)
>                 goto err_free;
>
> -       virtnet_rq_set_premapped(vi);
> +       virtnet_set_premapped(vi);
>
>         cpus_read_lock();
>         virtnet_set_affinity(vi);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index ebf9f344648a..870855a829a0 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -67,6 +67,8 @@ struct virtnet_sq {
>
>         /* Record whether sq is in reset state. */
>         bool reset;
> +
> +       bool do_dma;

Could we have a core helper for this? It can benefit for other driver
like virtio-fs.

Thanks


>  };
>
>  /* Internal representation of a receive virtqueue */
> --
> 2.32.0.3.g01195cf9f
>

