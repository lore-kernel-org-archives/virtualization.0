Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525AAC433FE
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 09:36:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D10D60FC2
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 09:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D10D60FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C40D081815;
	Mon, 27 Sep 2021 09:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id imWVfi4T8nEx; Mon, 27 Sep 2021 09:36:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 72E1581501;
	Mon, 27 Sep 2021 09:36:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41DA1C0011;
	Mon, 27 Sep 2021 09:36:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9F61C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C98D0607BB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uHVptNJWLsBj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:36:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AC7660796
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632735399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VwkEEsx/SFo4vZQiJMyrqZ3z0jMskB1/efBB0bt6CTQ=;
 b=SlKqJUZ++HlcEfjgqU2XmM1xg6qYaEk0FK/izwh2JtoFh4COTFky9uLDtOGvha+gQFZWu/
 aIm+nTyvT1u3EAZdz6J6RWus4lMJIp0zbgnp2SCtpBFFoJMiqOxvhcztkH2eygkxomYyRS
 Jkqi2kTM7Tq6JpQbVAcBmVXF5dAmnYE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-b8cfVHXTMKSapQWS6S4fUA-1; Mon, 27 Sep 2021 05:36:38 -0400
X-MC-Unique: b8cfVHXTMKSapQWS6S4fUA-1
Received: by mail-wr1-f71.google.com with SMTP id
 u7-20020adfed47000000b0016061b6caa8so3079916wro.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 02:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VwkEEsx/SFo4vZQiJMyrqZ3z0jMskB1/efBB0bt6CTQ=;
 b=rjO0/87ZB+AvY6ny713wEK8MbWtDT37gViMucdZq6Ma34jk+4qrt9th4uLWkNHo9/R
 dGqEm8mlcm/9QN/pHk+9a/UIh4QSqsbNTPa/rCurXkC4uXDhHyualZEnfNPBY4a0yc3A
 xdO+G1g759H16gkJAbhzaPkzl4g6HoRGPpePRLmj+2dhXXWHfiZultd2t/MhNRFxitky
 ERFcabrOYynyxw4KbyFIcG7xl4pO8H9Gl9+eh0WUoWaZN8sJnojpaGoDzfk9jXNnicfm
 29NBelaXIL333VC2BoELuMnd1nocyFhqttS/7THSmRAG3aG++cTP1BeuaFkYCD3KcyRr
 zRfg==
X-Gm-Message-State: AOAM531/yTQuVpFkzah0QrKEajEbxSTfcIMo9Y99alLXaQVBKgRxpfis
 jK51N7BSYmV/Tvl0admoZYvJjlmaC/udeOb5qNI6tGA/NuDOwIOCYZWuqRJgQpVIZ+tpig8gmlJ
 9uf+KofB6rFmGHHL4a2aKnrzE1TAH2kDR1sj2+9Xt9A==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr14852298wmj.120.1632735396491; 
 Mon, 27 Sep 2021 02:36:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUjNj6KYNQACo9ai9IgeUezllhTcbixb9Qv1AxHht+R+8Mp3IWM1C4FYLVNPVbrfGjtOTfXA==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr14852289wmj.120.1632735396332; 
 Mon, 27 Sep 2021 02:36:36 -0700 (PDT)
Received: from redhat.com ([2.55.16.138])
 by smtp.gmail.com with ESMTPSA id r2sm2011396wmq.28.2021.09.27.02.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 02:36:35 -0700 (PDT)
Date: Mon, 27 Sep 2021 05:36:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: check desc == NULL when packed and indirect
Message-ID: <20210927053429-mutt-send-email-mst@kernel.org>
References: <20210927030618.81278-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20210927030618.81278-1-xuanzhuo@linux.alibaba.com>
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

On Mon, Sep 27, 2021 at 11:06:18AM +0800, Xuan Zhuo wrote:
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
> -				       struct scatterlist *sgs[],
> -				       unsigned int total_sg,
> -				       unsigned int out_sgs,
> -				       unsigned int in_sgs,
> -				       void *data,
> -				       gfp_t gfp)
> +					 struct scatterlist *sgs[],
> +					 struct vring_packed_desc *desc,
> +					 unsigned int total_sg,
> +					 unsigned int out_sgs,
> +					 unsigned int in_sgs,
> +					 void *data,
> +					 gfp_t gfp)
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
> @@ -1191,9 +1190,15 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  
>  	BUG_ON(total_sg == 0);
>  
> -	if (virtqueue_use_indirect(_vq, total_sg))
> -		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> -				out_sgs, in_sgs, data, gfp);
> +	if (virtqueue_use_indirect(_vq, total_sg)) {
> +		desc = alloc_indirect_packed(total_sg, gfp);
> +		if (desc) {
> +			return virtqueue_add_indirect_packed(vq, sgs, desc,
> +							     total_sg,
> +							     out_sgs, in_sgs,
> +							     data, gfp);
> +		}

Eschew {} for a single statement if conditions pls.


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
