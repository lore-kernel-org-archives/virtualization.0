Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5E10A14
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NB4hD8xz"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE7C740B23
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 08:11:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE7C740B23
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NB4hD8xz
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ZmzvQf_J9FM
	for <virtualization@lists.linux-foundation.org>;
	Thu, 16 Nov 2023 08:11:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 696B34054E
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 08:11:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 696B34054E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700122293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLaNZilIDD63SEEygMdoCG1llBxOb1PA9Y3SZfWqDgY=;
	b=NB4hD8xzzTA8wAkO2BglkbTmhIvQQikqzEvwYLh7wylY8WpiS7IPo9HyDxfJN7QznTX08x
	QCj6NNphkntl02wp63Bf83eJPP6nbcq7bup/bRJwXBCH1JV0h/JeiA7GYfta/8W3rIhlj9
	EB6u9XbeOBhhOlpo9462kT0/gWzPcJk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-aar2R0fiN-qoE78to-EUdA-1; Thu, 16 Nov 2023 03:11:31 -0500
X-MC-Unique: aar2R0fiN-qoE78to-EUdA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50a753d9f0aso472199e87.2
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 00:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700122290; x=1700727090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLaNZilIDD63SEEygMdoCG1llBxOb1PA9Y3SZfWqDgY=;
        b=qUUHwCLri+4VDgZK/Jn5M28q61AXN7B7DpgTVVnzw4ecLFD2xXViuLleUGa+nbShxF
         XLNwU7a0mavDEXP8O7cFJW/xkDVcJobVoW+051vU7PfQE/wJh/1u2o0WO5c4b5xQCJPD
         HYZ0dGjC2nHrBX+nckxJThTcnim2EEhRhprxwrVWfAJr0gGO0aYrn137k9Nyb7YlgGzs
         F0RjFvFGkoXFpKjNcSGqmILP2J+lJUMkeU1CgaZVO7mHMPNrmyjsKYxDsYGjpt03l19n
         X/Yzg1tKlKdhLmdPtSMa7c4eK9eJbmKmNlkK6QEqa3zSNYJlhnJyiYaYjWBgHiZmuMJm
         zQfQ==
X-Gm-Message-State: AOJu0YxdrN5RIohw29VYLaSuSeBS138JtkA4YYcrjos4kjplE6AcF6Tr
	Vn61QQU/rjyiAW29wmw66fQSjA/916qoBwYchU9EA8h/8/fbPam+IvAzZA89M51VZ8ve1pvFbTA
	PprgIEiOd1pSRjTyjmpeG39XkydyTVobn+S0Fl0WdOCXwjCwg/yzWLc56fQ==
X-Received: by 2002:a05:6512:b14:b0:509:8e3d:7cb0 with SMTP id w20-20020a0565120b1400b005098e3d7cb0mr14843265lfu.41.1700122289715;
        Thu, 16 Nov 2023 00:11:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMRdnF3HRiUkpMAM+ioukVfdqgIGlPEV8hGc02mOPiDDn2Gl9wY56oW12ynHFZa8+kJMMDSVG9Hqp2PJrdRkE=
X-Received: by 2002:a05:6512:b14:b0:509:8e3d:7cb0 with SMTP id
 w20-20020a0565120b1400b005098e3d7cb0mr14843247lfu.41.1700122289452; Thu, 16
 Nov 2023 00:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com> <20231114113104.33994-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231114113104.33994-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Nov 2023 16:11:17 +0800
Message-ID: <CACGkMEs9+NCNd53EYu4_=gg+0giuZV1WoaCUUyn-YLwCrm-Ztg@mail.gmail.com>
Subject: Re: [RFC 4/4] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 7:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 114 ++++++++++++++++++++++++++++----
>  drivers/net/virtio/virtio_net.h |   2 +
>  2 files changed, 102 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 57cbd449637a..0766fed28afe 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -167,13 +167,46 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> +static void virtnet_sq_unmap(struct virtnet_sq *sq)
> +{
> +       struct scatterlist *sg;
> +
> +       for (sg =3D sq->sg; ; sg =3D sg_next(sg)) {
> +               virtqueue_dma_unmap_single_attrs(sq->vq,
> +                                                sg->dma_address,
> +                                                sg->length,
> +                                                DMA_TO_DEVICE, 0);
> +
> +               if (sg_is_last(sg)) {
> +                       /* clear the end mark setted by virtio core. */
> +                       sg_unmark_end(sg);
> +                       break;
> +               }
> +       }
> +
> +       /* mark the last one of sq->sg[] as the end for reuse by
> +        * virtqueue_get_buf_ctx_dma().
> +        */
> +       sg_mark_end(&sq->sg[ARRAY_SIZE(sq->sg) - 1]);

This API seems to be odd: the flag is set to be core but clear by driver.

Can we simply follow the add API that returns the #sgs?

> +}
> +
>  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
>                             u64 *bytes, u64 *packets)
>  {
> +       struct scatterlist *sg =3D NULL;
>         unsigned int len;
>         void *ptr;
>
> -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> +       /* clear the sg table */
> +       if (sq->do_dma) {
> +               sg_init_table(sq->sg, ARRAY_SIZE(sq->sg));
> +               sg =3D sq->sg;
> +       }
> +
> +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len, sg, NULL)=
) !=3D NULL) {
> +               if (sq->do_dma)
> +                       virtnet_sq_unmap(sq);
> +
>                 if (!is_xdp_frame(ptr)) {
>                         struct sk_buff *skb =3D ptr;
>
> @@ -567,22 +600,61 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq=
, u32 size, gfp_t gfp)
>         return buf;
>  }
>
> -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> +static void virtnet_set_premapped(struct virtnet_info *vi)
>  {
>         int i;
>
> -       /* disable for big mode */
> -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> -               return;
> -
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> -                       continue;
> +               if (!virtqueue_set_dma_premapped(vi->sq[i].vq))
> +                       vi->sq[i].do_dma =3D true;
>
> -               vi->rq[i].do_dma =3D true;
> +               /* disable for big mode */
> +               if (vi->mergeable_rx_bufs || !vi->big_packets) {
> +                       if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> +                               vi->rq[i].do_dma =3D true;
> +               }
>         }
>  }
>
> +static int virtnet_sq_map_sg(struct virtnet_sq *sq)
> +{
> +       struct scatterlist *sg;
> +
> +       for (sg =3D sq->sg; sg; sg =3D sg_next(sg)) {
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
> +       if (sg !=3D sq->sg) {
> +               sg_mark_end(sg - 1);
> +               virtnet_sq_unmap(sq);
> +       }
> +       return -ENOMEM;
> +}
> +
> +static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *data=
)
> +{
> +       int ret;
> +
> +       if (sq->do_dma) {
> +               ret =3D virtnet_sq_map_sg(sq);
> +               if (ret)
> +                       return -ENOMEM;
> +       }
> +
> +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMI=
C);
> +       if (ret && sq->do_dma)
> +               virtnet_sq_unmap(sq);
> +
> +       return ret;
> +}
> +
>  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
>  {
>         u64 bytes, packets =3D 0;
> @@ -686,8 +758,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info=
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
> @@ -2126,7 +2197,7 @@ static int xmit_skb(struct virtnet_sq *sq, struct s=
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
> @@ -3852,10 +3923,25 @@ static void virtnet_rq_free_unused_buf(struct vir=
tqueue *vq, void *buf)
>
>  static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
>  {
> +       struct virtnet_info *vi =3D vq->vdev->priv;
> +       struct scatterlist *sg =3D NULL;
> +       struct virtnet_sq *sq;
> +       int i =3D vq2txq(vq);
>         void *buf;
>
> -       while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL)
> +       sq =3D &vi->sq[i];
> +
> +       if (sq->do_dma) {
> +               sg_init_table(sq->sg, ARRAY_SIZE(sq->sg));

Btw, if we only care about dma_addr and length, using sg seems to be
expensive here.

Thanks


> +               sg =3D sq->sg;
> +       }
> +
> +       while ((buf =3D virtqueue_detach_unused_buf_premapped(vq, sg)) !=
=3D NULL) {
> +               if (sq->do_dma)
> +                       virtnet_sq_unmap(sq);
> +
>                 virtnet_sq_free_unused_buf(vq, buf);
> +       }
>  }
>
>  static void virtnet_rq_free_unused_bufs(struct virtqueue *vq)
> @@ -4052,7 +4138,7 @@ static int init_vqs(struct virtnet_info *vi)
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
>  };
>
>  /* Internal representation of a receive virtqueue */
> --
> 2.32.0.3.g01195cf9f
>

