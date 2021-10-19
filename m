Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD238C433F5
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:08:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD436137C
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CD436137C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A8FB405D0;
	Tue, 19 Oct 2021 11:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ErqLzg6-DBVW; Tue, 19 Oct 2021 11:08:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 96F9B4075F;
	Tue, 19 Oct 2021 11:08:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FC91C0011;
	Tue, 19 Oct 2021 11:08:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E68C8C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE3AF80BA2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:08:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yfB7ZCJEhVrg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:08:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8CE5880B7B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634641685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fJo6bSXeAlJXxopDe/cCY5BNbQ8MobgCD7/vrxmNPk=;
 b=X7cCCJE/Ibzp8/iZ0j7Tw23kyWgigCacM1HHsUw9xqooOA5zoVlRhWTOP2WCXXdH4pyCz3
 NdfLjXFZ/QArY/yNIxplYakr19PB+NHG2p/D3QIfCliJXyKCsYHcczQ2ikFGHU5oHKtzTd
 3eSBIgNZKVDWvoRI9LPQpDXh3XyKGtk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-8JVHOXrqOA-BZtNG2gQrJg-1; Tue, 19 Oct 2021 07:08:04 -0400
X-MC-Unique: 8JVHOXrqOA-BZtNG2gQrJg-1
Received: by mail-wm1-f70.google.com with SMTP id
 f20-20020a05600c155400b0030db7b29174so1025676wmg.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 04:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/fJo6bSXeAlJXxopDe/cCY5BNbQ8MobgCD7/vrxmNPk=;
 b=LqmnA7eW0uBmas71yQIgpKXCUsoNeqdMBxKIPh3L7yTzrzlxW2wATtrSlY30aFmSlT
 SxAJHayXNibEI5N/pUAKHMUbpKN4Vly1MuORdWDWF+J47Ly7yYIeaiO+F+yPA/gljoq5
 JQRCS97o4j6F/UxbpcSDVd4dV7nuXA21QMyHOjXon+FZfTd0OBQf2t5Fuw68WpCNv2qf
 fFUgXqElrBXujuDji0XaoNKZMLCrgvQjLO0SeFb4zuVSnXxPfHfwufYT6kGC8xGIKH4+
 ltjGxggpe/MF/5hNXcbOtK2zUfTBzgnrkNBmx8ZEespBzayMoa9+bratoGbtX/bXJe4R
 6jRQ==
X-Gm-Message-State: AOAM533Z14Yi4Jz+3ikCXy95DJ92/Y5dWeGnh52C8lQ5xtyyEmNahGkg
 iiYKXk6LdOhDWnDIPbc55FDOlgsu2AldTLIOn8Lu4ckJ3Ex6ILoHa+5a5aKln/eCd5Pgjs3/oYX
 rPVPyLLp48fLITKEbWRdLCa5C0Um8BXqM0ct5jpJAkg==
X-Received: by 2002:a05:600c:354d:: with SMTP id
 i13mr5255448wmq.189.1634641682887; 
 Tue, 19 Oct 2021 04:08:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMGLAQI7H0REZ89vhqMejgiXk3VQqH4VvrQNziRQ80nkoIOcuZqc8JbN6L9++F4E//8DaJzQ==
X-Received: by 2002:a05:600c:354d:: with SMTP id
 i13mr5255435wmq.189.1634641682718; 
 Tue, 19 Oct 2021 04:08:02 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id j16sm1977383wms.16.2021.10.19.04.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 04:08:02 -0700 (PDT)
Date: Tue, 19 Oct 2021 07:07:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 2/2] virtio_ring: check desc == NULL when packed and
 indirect
Message-ID: <20211019070002-mutt-send-email-mst@kernel.org>
References: <20211019105657.9108-1-xuanzhuo@linux.alibaba.com>
 <20211019105657.9108-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211019105657.9108-3-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
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

On Tue, Oct 19, 2021 at 06:56:57PM +0800, Xuan Zhuo wrote:
> In the case of packed, use indirect desc, since desc is allocated by
> kmalloc_array(), we should check whether its return value is NULL.
> 
> This patch alloc desc inside virtqueue_add_packe(), if desc == NULL,

Can we manage without typos in commit log please?

> fall back to not using indirect.


It should say why is the patch created, and how it's fixed,
as opposed to repating what patch does.

E.g.

when using indirect with packed, we don't check for
allocation failures. Check and fall back on direct.



> Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 91a46c4da87d..62323c27bfe4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1051,20 +1051,19 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
>  
>  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  					 struct scatterlist *sgs[],
> +					 struct vring_packed_desc *desc,
>  					 unsigned int total_sg,
>  					 unsigned int out_sgs,
>  					 unsigned int in_sgs,
>  					 void *data,
>  					 gfp_t gfp)

So this gets desc and will free it. I don't much like this.


>  {
> -	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
>  	unsigned int i, n, err_idx;
>  	u16 head, id;
>  	dma_addr_t addr;
>  
>  	head = vq->packed.next_avail_idx;
> -	desc = alloc_indirect_packed(total_sg, gfp);
>  
>  	if (unlikely(vq->vq.num_free < 1)) {
>  		pr_debug("Can't add buf len 1 - avail = 0\n");
> @@ -1191,9 +1190,14 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  
>  	BUG_ON(total_sg == 0);
>  
> -	if (virtqueue_use_indirect(_vq, total_sg))
> -		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> -				out_sgs, in_sgs, data, gfp);
> +	if (virtqueue_use_indirect(_vq, total_sg)) {
> +		desc = alloc_indirect_packed(total_sg, gfp);
> +		if (desc)
> +			return virtqueue_add_indirect_packed(vq, sgs, desc,
> +							     total_sg,
> +							     out_sgs, in_sgs,
> +							     data, gfp);
> +	}
>  
>  	head = vq->packed.next_avail_idx;
>  	avail_used_flags = vq->packed.avail_used_flags;
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
