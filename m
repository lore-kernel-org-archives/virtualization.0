Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F6DC636D6
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 05:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B831181E3D;
	Mon, 20 Feb 2023 05:37:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B831181E3D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QRwg1QN2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ituiTn_jsKjB; Mon, 20 Feb 2023 05:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D21D181586;
	Mon, 20 Feb 2023 05:37:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D21D181586
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0727C0032;
	Mon, 20 Feb 2023 05:37:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 340B9C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF86E81DCA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:37:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF86E81DCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ENDax3BuD8OI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:37:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D79C81586
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D79C81586
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676871472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VDXrbFsnbPQQ7+9xmjlRcKK0zERKc+VKcnRHGHf9QBo=;
 b=QRwg1QN2SQbJGBpXoflRzMqDaVtEkroTCfbVio/99Sb3jITEphGy8tfq7379LOjCitHjIr
 8RKMz5vNHf48MNUOzJYtBwB8IXSWBJ49Iub8upHJxE1nNf+MZj5h1jKPuN8Be6U/cSysf4
 Gy4NaUoImulndrTu/MqZ6CYueDz1eLY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-kyBaXzd6OjaNmv0QaCH3bA-1; Mon, 20 Feb 2023 00:37:50 -0500
X-MC-Unique: kyBaXzd6OjaNmv0QaCH3bA-1
Received: by mail-ot1-f70.google.com with SMTP id
 t25-20020a05683022f900b00690eb93bd3bso447447otc.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Feb 2023 21:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VDXrbFsnbPQQ7+9xmjlRcKK0zERKc+VKcnRHGHf9QBo=;
 b=WpfmQYTZMKvFKFHkVBfkLweZsCDrN6uZxc8XDqihxCnXNGWCn5rZ85hfzHQSpCOfBd
 phGHiGQvVaL7T9xs0nnJ6w8TDSgIL9ZkJ71dJUpKsvsi8Syg/VYpj+2OQGLeoyEa5RQD
 QzBqOy7i0FSbJKgQubG000PhrWVObAdz6d+/6K9voMGmJpp9hGxduCXKocuot+yskkkP
 kvpDjBw0V9Dx9D88k0A8cjmxvxeFS3S7EiPczRthMzFFRGgx6GAqW5rqVBOUdSMgzMrV
 Fjib7ht8wGqJxMp7r4cBA0sFg+4Rlvu3pkoFTanbwUVFoHqshwwQm156Wc9xR7Me9jiy
 Z+2g==
X-Gm-Message-State: AO0yUKURpTazELAPH5p9TQdnk3RXjnrm6hOhLv/rsAU9rkVpaLT1Whp3
 N8HaD2PURpVj9PwdQCZOct8teZN3zI54grGwumAyXc9Xja4nEYj8hNBIfEJKnvW4byEisU5+zJ6
 OLgE+F7rfBUYGTCWi1zo68DimuqXP1wCe9k5tdXq/0UEfZC6QbnGq3sNj6Q==
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr920396oib.217.1676871469117; 
 Sun, 19 Feb 2023 21:37:49 -0800 (PST)
X-Google-Smtp-Source: AK7set9FiCKsQYl9jQfWy15Pu0uo2Z9GMkAiQMC1nUMZbex1pHr4moyT4i128w4e6npedNdf1ocAsk3YwoqTgtKk1HU=
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr920394oib.217.1676871468748; Sun, 19
 Feb 2023 21:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230214072704.126660-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 13:37:37 +0800
Message-ID: <CACGkMEtnVwTBzwmRGGXELNkds=b1K+crAmonyjn9=rM1R2-Fkw@mail.gmail.com>
Subject: Re: [PATCH vhost 01/10] virtio_ring: split: refactor
 virtqueue_add_split() for premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> DMA-related logic is separated from the virtqueue_add_split to prepare
> for subsequent support for premapped.

The patch seems to do more than what is described here.

To simplify reviewers, I'd suggest to split this patch into three:

1) virtqueue_add_split_prepare() (could we have a better name?)
2) virtqueue_map_sgs()
3) virtqueue_add_split_vring()

(Or only factor DMA parts out, I haven't gone through the reset of the patches)

Thanks


>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 219 ++++++++++++++++++++++++-----------
>  1 file changed, 152 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 41144b5246a8..560ee30d942c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -520,29 +520,83 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
>         return next;
>  }
>
> -static inline int virtqueue_add_split(struct virtqueue *_vq,
> -                                     struct scatterlist *sgs[],
> -                                     unsigned int total_sg,
> -                                     unsigned int out_sgs,
> -                                     unsigned int in_sgs,
> -                                     void *data,
> -                                     void *ctx,
> -                                     gfp_t gfp)
> +static int virtqueue_map_sgs(struct vring_virtqueue *vq,
> +                            struct scatterlist *sgs[],
> +                            unsigned int total_sg,
> +                            unsigned int out_sgs,
> +                            unsigned int in_sgs)
>  {
> -       struct vring_virtqueue *vq = to_vvq(_vq);
>         struct scatterlist *sg;
> -       struct vring_desc *desc;
> -       unsigned int i, n, avail, descs_used, prev, err_idx;
> -       int head;
> -       bool indirect;
> +       unsigned int n;
>
> -       START_USE(vq);
> +       for (n = 0; n < out_sgs; n++) {
> +               for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> +                       dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
> +
> +                       if (vring_mapping_error(vq, addr))
> +                               return -ENOMEM;
> +
> +                       sg->dma_address = addr;
> +               }
> +       }
> +       for (; n < (out_sgs + in_sgs); n++) {
> +               for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> +                       dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
> +
> +                       if (vring_mapping_error(vq, addr))
> +                               return -ENOMEM;
> +
> +                       sg->dma_address = addr;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void virtqueue_unmap_sgs(struct vring_virtqueue *vq,
> +                               struct scatterlist *sgs[],
> +                               unsigned int total_sg,
> +                               unsigned int out_sgs,
> +                               unsigned int in_sgs)
> +{
> +       struct scatterlist *sg;
> +       unsigned int n;
> +
> +       for (n = 0; n < out_sgs; n++) {
> +               for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> +                       if (!sg->dma_address)
> +                               return;
> +
> +                       dma_unmap_single(vring_dma_dev(vq), sg->dma_address,
> +                                        sg->length, DMA_TO_DEVICE);
> +               }
> +       }
> +       for (; n < (out_sgs + in_sgs); n++) {
> +               for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> +                       if (!sg->dma_address)
> +                               return;
> +
> +                       dma_unmap_single(vring_dma_dev(vq), sg->dma_address,
> +                                        sg->length, DMA_FROM_DEVICE);
> +               }
> +       }
> +}
> +
> +static inline int virtqueue_add_split_prepare(struct vring_virtqueue *vq,
> +                                             unsigned int total_sg,
> +                                             unsigned int out_sgs,
> +                                             void *data,
> +                                             void *ctx,
> +                                             gfp_t gfp,
> +                                             struct vring_desc **pdesc)
> +{
> +       struct vring_desc *desc;
> +       unsigned int descs_used;
>
>         BUG_ON(data == NULL);
>         BUG_ON(ctx && vq->indirect);
>
>         if (unlikely(vq->broken)) {
> -               END_USE(vq);
>                 return -EIO;
>         }
>
> @@ -550,27 +604,17 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>
>         BUG_ON(total_sg == 0);
>
> -       head = vq->free_head;
> -
>         if (virtqueue_use_indirect(vq, total_sg))
> -               desc = alloc_indirect_split(_vq, total_sg, gfp);
> +               desc = alloc_indirect_split(&vq->vq, total_sg, gfp);
>         else {
>                 desc = NULL;
>                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
>         }
>
> -       if (desc) {
> -               /* Use a single buffer which doesn't continue */
> -               indirect = true;
> -               /* Set up rest to use this indirect table. */
> -               i = 0;
> +       if (desc)
>                 descs_used = 1;
> -       } else {
> -               indirect = false;
> -               desc = vq->split.vring.desc;
> -               i = head;
> +       else
>                 descs_used = total_sg;
> -       }
>
>         if (unlikely(vq->vq.num_free < descs_used)) {
>                 pr_debug("Can't add buf len %i - avail = %i\n",
> @@ -580,38 +624,64 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>                  * host should service the ring ASAP. */
>                 if (out_sgs)
>                         vq->notify(&vq->vq);
> -               if (indirect)
> -                       kfree(desc);
> -               END_USE(vq);
> +               kfree(desc);
>                 return -ENOSPC;
>         }
>
> +       *pdesc = desc;
> +
> +       return 0;
> +}
> +
> +static inline int virtqueue_add_split_vring(struct vring_virtqueue *vq,
> +                                           struct scatterlist *sgs[],
> +                                           unsigned int total_sg,
> +                                           unsigned int out_sgs,
> +                                           unsigned int in_sgs,
> +                                           struct vring_desc *desc)
> +{
> +       unsigned int n, i, avail, descs_used, prev;
> +       struct virtqueue *_vq = &vq->vq;
> +       struct scatterlist *sg;
> +       bool indirect;
> +       int head;
> +
> +       head = vq->free_head;
> +
> +       if (desc) {
> +               /* Use a single buffer which doesn't continue */
> +               indirect = true;
> +               /* Set up rest to use this indirect table. */
> +               i = 0;
> +               descs_used = 1;
> +       } else {
> +               indirect = false;
> +               desc = vq->split.vring.desc;
> +               i = head;
> +               descs_used = total_sg;
> +       }
> +
>         for (n = 0; n < out_sgs; n++) {
>                 for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> -                       dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> -                               goto unmap_release;
> -
>                         prev = i;
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
> -                       i = virtqueue_add_desc_split(_vq, desc, i, addr, sg->length,
> +                       i = virtqueue_add_desc_split(_vq, desc, i,
> +                                                    sg->dma_address,
> +                                                    sg->length,
>                                                      VRING_DESC_F_NEXT,
>                                                      indirect);
>                 }
>         }
>         for (; n < (out_sgs + in_sgs); n++) {
>                 for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> -                       dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> -                               goto unmap_release;
> -
>                         prev = i;
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
> -                       i = virtqueue_add_desc_split(_vq, desc, i, addr,
> +                       i = virtqueue_add_desc_split(_vq, desc, i,
> +                                                    sg->dma_address,
>                                                      sg->length,
>                                                      VRING_DESC_F_NEXT |
>                                                      VRING_DESC_F_WRITE,
> @@ -630,7 +700,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>                         vq, desc, total_sg * sizeof(struct vring_desc),
>                         DMA_TO_DEVICE);
>                 if (vring_mapping_error(vq, addr))
> -                       goto unmap_release;
> +                       return -ENOMEM;
>
>                 virtqueue_add_desc_split(_vq, vq->split.vring.desc,
>                                          head, addr,
> @@ -648,13 +718,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>         else
>                 vq->free_head = i;
>
> -       /* Store token and indirect buffer state. */
> -       vq->split.desc_state[head].data = data;
> -       if (indirect)
> -               vq->split.desc_state[head].indir_desc = desc;
> -       else
> -               vq->split.desc_state[head].indir_desc = ctx;
> -
>         /* Put entry in available array (but don't update avail->idx until they
>          * do sync). */
>         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> @@ -677,30 +740,52 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>                 virtqueue_kick(_vq);
>
>         return 0;
> +}
>
> -unmap_release:
> -       err_idx = i;
> +static inline int virtqueue_add_split(struct virtqueue *_vq,
> +                                     struct scatterlist *sgs[],
> +                                     unsigned int total_sg,
> +                                     unsigned int out_sgs,
> +                                     unsigned int in_sgs,
> +                                     void *data,
> +                                     void *ctx,
> +                                     gfp_t gfp)
> +{
> +       struct vring_virtqueue *vq = to_vvq(_vq);
> +       struct vring_desc *desc;
> +       int head;
> +       int err;
>
> -       if (indirect)
> -               i = 0;
> -       else
> -               i = head;
> +       START_USE(vq);
>
> -       for (n = 0; n < total_sg; n++) {
> -               if (i == err_idx)
> -                       break;
> -               if (indirect) {
> -                       vring_unmap_one_split_indirect(vq, &desc[i]);
> -                       i = virtio16_to_cpu(_vq->vdev, desc[i].next);
> -               } else
> -                       i = vring_unmap_one_split(vq, i);
> -       }
> +       /* check vq state and try to alloc desc for indirect. */
> +       err = virtqueue_add_split_prepare(vq, total_sg, out_sgs, data, ctx, gfp, &desc);
> +       if (err)
> +               goto end;
>
> -       if (indirect)
> -               kfree(desc);
> +       err = virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
> +       if (err)
> +               goto err;
>
> +       head = vq->free_head;
> +       err = virtqueue_add_split_vring(vq, sgs, total_sg, out_sgs, in_sgs, desc);
> +       if (err)
> +               goto err;
> +
> +       /* Store token and indirect buffer state. */
> +       vq->split.desc_state[head].data = data;
> +       vq->split.desc_state[head].indir_desc = desc ? desc : ctx;
> +
> +       goto end;
> +
> +err:
> +       virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
> +
> +       kfree(desc);
> +
> +end:
>         END_USE(vq);
> -       return -ENOMEM;
> +       return err;
>  }
>
>  static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> --
> 2.32.0.3.g01195cf9f
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
