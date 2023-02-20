Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F52C636D6
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 05:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7879041527;
	Mon, 20 Feb 2023 05:38:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7879041527
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W6PmtCzY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CnANrm1RdyQN; Mon, 20 Feb 2023 05:38:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4183241523;
	Mon, 20 Feb 2023 05:38:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4183241523
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BABBC0032;
	Mon, 20 Feb 2023 05:38:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77987C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5228941527
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5228941527
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fMRo1gXg9maV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC5D341523
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC5D341523
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676871482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4jFSxCP4Q5c4cGG+8C1cbB1xkt/xgLJ5U7tZ4GGm3M=;
 b=W6PmtCzY5+o3kFYCrUz/9tg6xXUT2EJw3udI4j/3/dwNiBxHzXcNwa8p+ybkRpQMM44XrH
 9iEs/dSEZxGLIa57QcY4hOyFALd+ymtBpGHymTiOe5NSMdAvFsfmthtH0DMLQ+aARPjnew
 1toc4Q+/e2FT4oxRvOH2YKpLYCT5YOo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-uIDLKlbbPbOaPnNo9UdNaQ-1; Mon, 20 Feb 2023 00:37:58 -0500
X-MC-Unique: uIDLKlbbPbOaPnNo9UdNaQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-171deb7f31aso546278fac.16
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Feb 2023 21:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l4jFSxCP4Q5c4cGG+8C1cbB1xkt/xgLJ5U7tZ4GGm3M=;
 b=jGEtKWmykWb9OULMMP3f+CEAbYYg5XPShhXVRKrSey35dVAiX035Jbq0zT23bQl60o
 q6NtDZvY2bsPKQuaBEQUeRKd0VgU3ALdH1KexoCFcn8DQmMY6qSI526IMiR/uxiBUziY
 qLCQpiYMCG8d7TJ3OuoaP8P/uj7B8DjRn1uFv6TG1pttI4BuyYPouuA9rxUvBfy+fuu9
 o7oyh+zPHBgvr+ne5vhWIFwD0YqZtPwq1jwUquELgJbLPgY0PSINGyFrWy9Q1L6X1CeT
 3mbs2wqc1cZzZvQ12i0NMa2QmxwGJMVQwF927ZjymAEeUXPxcm305+XG5e7KRvnjCdKf
 gDZA==
X-Gm-Message-State: AO0yUKVdVuD/KQF/jUvszjWBkQIF0loT/gK9p/+ugo74WGRQZjsEfq54
 StlHXBp4Q76DoLqlyV4qz8KCu8K6nOSDmauBTOnb/xB8+ZutkBSFVYazJLMe0O8dsVkbgn7zeG3
 Pr/9c/vr5bjjI65Ie1o35Qqw6fYpUIWwEnVOwa+PBPnrsYC/IR/co2UyPtQ==
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr920418oib.217.1676871477740; 
 Sun, 19 Feb 2023 21:37:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+W9Wk0YwEdaRzQYV8wnZxb2Gh1FofLGIoyUY09y2M4y5cMKKLLG9hRVSDvF0FYbZ55jXzD4r+HdQRuarwb7KM=
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr920417oib.217.1676871477431; Sun, 19
 Feb 2023 21:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230214072704.126660-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 13:37:46 +0800
Message-ID: <CACGkMEvo0EiSFYLDX4oCF2QkNJ0DKd2gB85mamFLj0Z4dsXxig@mail.gmail.com>
Subject: Re: [PATCH vhost 03/10] virtio_ring: packed: refactor
 virtqueue_add_packed() for premapped
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
> DMA-related logic is separated from virtqueue_add_packed to prepare for
> the subsequent support for premapped.

As stated in patch 1, I think it's better to split.

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 150 ++++++++++++++++++-----------------
>  1 file changed, 78 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 42b1ff87518e..47b6f9152f9f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1329,7 +1329,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>                                          unsigned int total_sg,
>                                          unsigned int out_sgs,
>                                          unsigned int in_sgs,
> -                                        void *data,
>                                          struct vring_packed_desc *desc)
>  {
>         struct scatterlist *sg;
> @@ -1345,14 +1344,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>
>         for (n = 0; n < out_sgs + in_sgs; n++) {
>                 for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> -                       addr = vring_map_one_sg(vq, sg, n < out_sgs ?
> -                                       DMA_TO_DEVICE : DMA_FROM_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> -                               goto unmap_release;
> -
>                         desc[i].flags = cpu_to_le16(n < out_sgs ?
>                                                 0 : VRING_DESC_F_WRITE);
> -                       desc[i].addr = cpu_to_le64(addr);
> +                       desc[i].addr = cpu_to_le64(sg->dma_address);
>                         desc[i].len = cpu_to_le32(sg->length);
>                         i++;
>                 }
> @@ -1363,7 +1357,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>                         total_sg * sizeof(struct vring_packed_desc),
>                         DMA_TO_DEVICE);
>         if (vring_mapping_error(vq, addr))
> -               goto unmap_release;
> +               return -ENOMEM;
>
>         vq->packed.vring.desc[head].addr = cpu_to_le64(addr);
>         vq->packed.vring.desc[head].len = cpu_to_le32(total_sg *
> @@ -1404,53 +1398,30 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>
>         /* Store token and indirect buffer state. */
>         vq->packed.desc_state[id].num = 1;
> -       vq->packed.desc_state[id].data = data;
>         vq->packed.desc_state[id].indir_desc = desc;
>         vq->packed.desc_state[id].last = id;
>
>         vq->num_added += 1;
>
>         pr_debug("Added buffer head %i to %p\n", head, vq);
> -       END_USE(vq);
>
>         return 0;
> -
> -unmap_release:
> -       err_idx = i;
> -
> -       for (i = 0; i < err_idx; i++)
> -               vring_unmap_desc_packed(vq, &desc[i]);
> -
> -       kfree(desc);
> -
> -       END_USE(vq);
> -       return -ENOMEM;
>  }
>
> -static inline int virtqueue_add_packed(struct virtqueue *_vq,
> -                                      struct scatterlist *sgs[],
> -                                      unsigned int total_sg,
> -                                      unsigned int out_sgs,
> -                                      unsigned int in_sgs,
> -                                      void *data,
> -                                      void *ctx,
> -                                      gfp_t gfp)
> +static inline int virtqueue_add_packed_prepare(struct vring_virtqueue *vq,
> +                                              unsigned int total_sg,
> +                                              void *data,
> +                                              void *ctx,
> +                                              struct vring_packed_desc **pdesc,
> +                                              gfp_t gfp)
>  {
> -       struct vring_virtqueue *vq = to_vvq(_vq);
>         struct vring_packed_desc *desc;
> -       struct scatterlist *sg;
> -       unsigned int i, n, c, descs_used, err_idx;
> -       __le16 head_flags, flags;
> -       u16 head, id, prev, curr, avail_used_flags;
> -       int err;
> -
> -       START_USE(vq);
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
> @@ -1458,39 +1429,55 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>
>         BUG_ON(total_sg == 0);
>
> +       desc = NULL;
> +
>         if (virtqueue_use_indirect(vq, total_sg)) {
>                 desc = alloc_indirect_packed(total_sg, gfp);
>                 if (desc) {
>                         if (unlikely(vq->vq.num_free < 1)) {
>                                 pr_debug("Can't add buf len 1 - avail = 0\n");
>                                 kfree(desc);
> -                               END_USE(vq);
>                                 return -ENOSPC;
>                         }
>
> -                       return virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> -                                                            in_sgs, data, desc);
> +                       return 0;
>                 }
>
>                 /* fall back on direct */
>         }
>
> -       head = vq->packed.next_avail_idx;
> -       avail_used_flags = vq->packed.avail_used_flags;
> -
>         WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
>
> -       desc = vq->packed.vring.desc;
> -       i = head;
>         descs_used = total_sg;
>
>         if (unlikely(vq->vq.num_free < descs_used)) {
>                 pr_debug("Can't add buf len %i - avail = %i\n",
>                          descs_used, vq->vq.num_free);
> -               END_USE(vq);
>                 return -ENOSPC;
>         }
>
> +       *pdesc = desc;
> +
> +       return 0;
> +}
> +
> +static void virtqueue_add_packed_vring(struct vring_virtqueue *vq,
> +                                      struct scatterlist *sgs[],
> +                                      unsigned int total_sg,
> +                                      unsigned int out_sgs,
> +                                      unsigned int in_sgs)
> +{
> +       struct vring_packed_desc *desc;
> +       struct scatterlist *sg;
> +       unsigned int i, n, c, descs_used;
> +       __le16 head_flags, flags;
> +       u16 head, id, prev, curr;
> +
> +       desc = vq->packed.vring.desc;
> +       head = vq->packed.next_avail_idx;
> +       i = head;
> +       descs_used = total_sg;
> +
>         id = vq->free_head;
>         BUG_ON(id == vq->packed.vring.num);
>
> @@ -1498,11 +1485,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>         c = 0;
>         for (n = 0; n < out_sgs + in_sgs; n++) {
>                 for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> -                       dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
> -                                       DMA_TO_DEVICE : DMA_FROM_DEVICE);
> -                       if (vring_mapping_error(vq, addr))
> -                               goto unmap_release;
> -
>                         flags = cpu_to_le16(vq->packed.avail_used_flags |
>                                     (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>                                     (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> @@ -1511,12 +1493,12 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>                         else
>                                 desc[i].flags = flags;
>
> -                       desc[i].addr = cpu_to_le64(addr);
> +                       desc[i].addr = cpu_to_le64(sg->dma_address);
>                         desc[i].len = cpu_to_le32(sg->length);
>                         desc[i].id = cpu_to_le16(id);
>
>                         if (unlikely(vq->use_dma_api)) {
> -                               vq->packed.desc_extra[curr].addr = addr;
> +                               vq->packed.desc_extra[curr].addr = sg->dma_address;
>                                 vq->packed.desc_extra[curr].len = sg->length;
>                                 vq->packed.desc_extra[curr].flags =
>                                         le16_to_cpu(flags);
> @@ -1545,8 +1527,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>
>         /* Store token. */
>         vq->packed.desc_state[id].num = descs_used;
> -       vq->packed.desc_state[id].data = data;
> -       vq->packed.desc_state[id].indir_desc = ctx;
>         vq->packed.desc_state[id].last = prev;
>
>         /*
> @@ -1559,29 +1539,55 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>         vq->num_added += descs_used;
>
>         pr_debug("Added buffer head %i to %p\n", head, vq);
> -       END_USE(vq);
> +}
>
> -       return 0;
> +static inline int virtqueue_add_packed(struct virtqueue *_vq,
> +                                      struct scatterlist *sgs[],
> +                                      unsigned int total_sg,
> +                                      unsigned int out_sgs,
> +                                      unsigned int in_sgs,
> +                                      void *data,
> +                                      void *ctx,
> +                                      gfp_t gfp)
> +{
> +       struct vring_virtqueue *vq = to_vvq(_vq);
> +       struct vring_packed_desc *desc;
> +       u16 id;
> +       int err;
>
> -unmap_release:
> -       err_idx = i;
> -       i = head;
> -       curr = vq->free_head;
> +       START_USE(vq);
>
> -       vq->packed.avail_used_flags = avail_used_flags;
> +       /* check vq state and try to alloc desc for indirect. */
> +       err = virtqueue_add_packed_prepare(vq, total_sg, data, ctx, &desc, gfp);
> +       if (err)
> +               goto end;
>
> -       for (n = 0; n < total_sg; n++) {
> -               if (i == err_idx)
> -                       break;
> -               vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
> -               curr = vq->packed.desc_extra[curr].next;
> -               i++;
> -               if (i >= vq->packed.vring.num)
> -                       i = 0;
> +       err = virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
> +       if (err)
> +               goto err;
> +
> +       id = vq->free_head;
> +
> +       if (desc) {
> +               err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs, in_sgs, desc);
> +               if (err)
> +                       goto err;
> +       } else {
> +               virtqueue_add_packed_vring(vq, sgs, total_sg, out_sgs, in_sgs);
> +               vq->packed.desc_state[id].indir_desc = ctx;

I think it's better to be consistent here, e.g split hides those into
virtqueue_add_split_vring().

Thanks


>         }
>
> +       vq->packed.desc_state[id].data = data;
> +
> +       goto end;
> +
> +err:
> +       virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
> +       kfree(desc);
> +
> +end:
>         END_USE(vq);
> -       return -EIO;
> +       return err;
>  }
>
>  static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> --
> 2.32.0.3.g01195cf9f
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
