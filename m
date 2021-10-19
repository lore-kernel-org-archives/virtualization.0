Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0941C433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:09:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FE66137F
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1FE66137F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 671FE4047B;
	Tue, 19 Oct 2021 11:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8puaaYVYr0j0; Tue, 19 Oct 2021 11:09:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E42F1402F1;
	Tue, 19 Oct 2021 11:09:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C947EC0011;
	Tue, 19 Oct 2021 11:09:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F4015C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D22004025D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:09:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jh8xFCguVHGp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9B0840251
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634641761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YoRn8BTp1LshRffCicLg35iJygWZL/sOneMHNZgcvcM=;
 b=U2+caH0vlhsJDxvRSWZFXxSrQWix3B5KdFXdI+PfaktVMuoLcJltrFKjvq+Y/H96ey1rj+
 5/ziMDrb/cVw9Y4VpbcIYGGcxhbsrQ++5ivJZm6TI43K/TD2ifVXCIqqeKrXhlM4eX+RpL
 stB3X/Bosiqqx04ngD113c4SK1k1Cfg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-WJFc3PutNB6u_fYOS2Ac5A-1; Tue, 19 Oct 2021 07:09:19 -0400
X-MC-Unique: WJFc3PutNB6u_fYOS2Ac5A-1
Received: by mail-wm1-f72.google.com with SMTP id
 f20-20020a05600c155400b0030db7b29174so1026545wmg.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 04:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YoRn8BTp1LshRffCicLg35iJygWZL/sOneMHNZgcvcM=;
 b=UXFtzIF9/m9ClIZ7hCO6T3qwqvbQxHOZUZ5LdFd1OYqYpVzKlMKCqXdrdQQgBaTA8O
 RS9oIMTBTPrIsR9/8BJqxlTbps+486Genr37teAsHSb2WkdQ2Hz7IQ5T4QhnintnC5w8
 Qe+Wp/t9Js6IxBTwm6Ky3Vr0WrnWk5K6pbrBbmup6MhUKKHLvs4MI/owWhtDpDufflw2
 7SxmrTWb8/qHrH+fhRKaLMDX5j57ZW0DOSlEn7t064DGVn3iZWAZgCJ54MTgKoG2sguI
 pvSDJ1RvualRV8zYfXLQrUdJ+cRpZ1/PnviCCt+AB740vka/aNp+G1RmaOTNtCkhJK59
 yk5g==
X-Gm-Message-State: AOAM531M60qSf/BGgXPOpO5C5dCX3YyHvY2MTewlU8VLbIFrObIjF3Gm
 Si6txCoaYeIRjgT2mdhny2TijT4j92+4uawbekAx1z9jV1lujq7teGI7uyHSHxAIeFoeRum5fgf
 H/6mFOreoaxDN1lt1iTEceiu1L3bKtVytJ1e19GFe1g==
X-Received: by 2002:a05:600c:19d3:: with SMTP id
 u19mr5178195wmq.164.1634641758713; 
 Tue, 19 Oct 2021 04:09:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGBkw3MElOOg2rO3fVeEhT4fG1a28pSqAgDhYIV5lfhRy+6RiVKHThfSd5HhHjy/5tms6OFA==
X-Received: by 2002:a05:600c:19d3:: with SMTP id
 u19mr5178176wmq.164.1634641758567; 
 Tue, 19 Oct 2021 04:09:18 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id s14sm14677159wro.76.2021.10.19.04.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 04:09:18 -0700 (PDT)
Date: Tue, 19 Oct 2021 07:09:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 1/2] virtio_ring: fix style of
 virtqueue_add_indirect_packed
Message-ID: <20211019070814-mutt-send-email-mst@kernel.org>
References: <20211019105657.9108-1-xuanzhuo@linux.alibaba.com>
 <20211019105657.9108-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211019105657.9108-2-xuanzhuo@linux.alibaba.com>
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

On Tue, Oct 19, 2021 at 06:56:56PM +0800, Xuan Zhuo wrote:
> Fix the style problem of virtqueue_add_indirect_packed().
> Align arguments to the open ( to make it look prettier.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

fix the style problem -> make virtqueue_add_indirect_packed prettier.

same for subject

there's no style problem, certainly not the problem.

> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dd95dfd85e98..91a46c4da87d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1050,12 +1050,12 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
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
> +					 unsigned int total_sg,
> +					 unsigned int out_sgs,
> +					 unsigned int in_sgs,
> +					 void *data,
> +					 gfp_t gfp)
>  {
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
