Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60235C433F5
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 03:20:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E222F60F94
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 03:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E222F60F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3D3081064;
	Mon, 27 Sep 2021 03:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7oHVkR13Rdvq; Mon, 27 Sep 2021 03:20:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55107814B4;
	Mon, 27 Sep 2021 03:20:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05F20C000F;
	Mon, 27 Sep 2021 03:20:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0F42C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 03:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9123881064
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 03:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UTjeFwYdjNqV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 03:20:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B71080F19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632712830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/WU1sfZdSOfPsYGZg+eBXNbvJbTP/rfhSzujvqHizs=;
 b=RKj1CIPwQmDhSaj3mOcdjOmB4Xr7FGUKGb1Y2V/dFyflo9ycUDSlSdJprtE3SYFKBWOQc3
 6r2RJ7rqL0VyNPrFdzApWwu3oxIiVoH/YrIFATgZvqK0zC5vfq3E5EuNWf9C41UdC6v3AW
 KlRCA15AsJmsxJJ4sucl2ZjV0NQ7e7Q=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-9VotT6AoMuOCmIMvswQsqQ-1; Sun, 26 Sep 2021 23:20:29 -0400
X-MC-Unique: 9VotT6AoMuOCmIMvswQsqQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 c24-20020ac25318000000b003f257832dfdso14414548lfh.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 20:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+/WU1sfZdSOfPsYGZg+eBXNbvJbTP/rfhSzujvqHizs=;
 b=3mw/IIuz1kxMEXPVuCNsazHnjYVchsQjmmi3rXP5r6i4116AUcUzXH9pSovTkB7IpN
 tJRgZRX/PyRE/uE2h6oKmal8iGHV7z/eUyBpSkRtQ9PrRDhfY4DZIOejQ+wCPxzdLTyT
 OXgguN3mJv8p0tSc+9vDHJfOS8Ah4MFSyKJajMFqFeUDiKEdyN/cYCw2ZlHCcLZjrhrA
 /PDcbxYahKrFw6cK9vaD5OlbuDPhIfTwI1hKAZc93kemLgxNgFRWgiNtG+yYVcvljgzX
 u247itH0wjvlDRA24X2KAUhoi2uek3YLNiZl5tlbtX4isiOa9uMJNXrQJoYWKVYtETJ0
 FvDg==
X-Gm-Message-State: AOAM53298IjFOTcKPFHoiwIm3B9Iy8uUyUqtuq76PnpvMnGPqesRIAR1
 gqEVTKp+kab1VpRbubSYaVK9sgwXev6feEfW7uGGwFpkYswMFRLOaG6QxBZ9ytMNv4xOA8wurFW
 oeEhRtwFfhK3vhizp4oEuBvXEHOZZy7UrfV4lgAsCNkxyfcFDNaabggjHxQ==
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr26241029ljp.307.1632712827888; 
 Sun, 26 Sep 2021 20:20:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxStY28PBh3NlvXmvA3Vkb4aCvs6qkkL6+aZfZlzsrISLTdQ2C5OqazcLyzDz3lOdCbQ3/Vu98r/OyXUAk8osE=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr26241017ljp.307.1632712827684; 
 Sun, 26 Sep 2021 20:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210927030618.81278-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210927030618.81278-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Sep 2021 11:20:16 +0800
Message-ID: <CACGkMEtaXD=0zPoiLxrXbqBQPZF4ZLWvm_dNkSnf6s3H+-VRgA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: check desc == NULL when packed and indirect
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Sep 27, 2021 at 11:06 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> In the case of packed, use indirect desc, since desc is allocated by
> kmalloc_array(), we should check whether its return value is NULL.
>
> Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dd95dfd85e98..7dd381eae725 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1050,21 +1050,20 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
>  }
>
>  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> -                                      struct scatterlist *sgs[],
> -                                      unsigned int total_sg,
> -                                      unsigned int out_sgs,
> -                                      unsigned int in_sgs,
> -                                      void *data,
> -                                      gfp_t gfp)
> +                                        struct scatterlist *sgs[],
> +                                        struct vring_packed_desc *desc,
> +                                        unsigned int total_sg,
> +                                        unsigned int out_sgs,
> +                                        unsigned int in_sgs,
> +                                        void *data,
> +                                        gfp_t gfp)

It looks to me the style changes are mixed with bug fix here.

>  {
> -       struct vring_packed_desc *desc;
>         struct scatterlist *sg;
>         unsigned int i, n, err_idx;
>         u16 head, id;
>         dma_addr_t addr;
>
>         head = vq->packed.next_avail_idx;
> -       desc = alloc_indirect_packed(total_sg, gfp);
>
>         if (unlikely(vq->vq.num_free < 1)) {
>                 pr_debug("Can't add buf len 1 - avail = 0\n");
> @@ -1191,9 +1190,15 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>
>         BUG_ON(total_sg == 0);
>
> -       if (virtqueue_use_indirect(_vq, total_sg))
> -               return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> -                               out_sgs, in_sgs, data, gfp);
> +       if (virtqueue_use_indirect(_vq, total_sg)) {
> +               desc = alloc_indirect_packed(total_sg, gfp);
> +               if (desc) {
> +                       return virtqueue_add_indirect_packed(vq, sgs, desc,
> +                                                            total_sg,
> +                                                            out_sgs, in_sgs,
> +                                                            data, gfp);
> +               }
> +       }

Any reason that we can't fix virtqueue_add_indirect_packed()? It can
help to reduce the changeset and ease the backport.

Thanks

>
>         head = vq->packed.next_avail_idx;
>         avail_used_flags = vq->packed.avail_used_flags;
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
