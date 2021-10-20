Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB01EC433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 11:09:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFF0613A0
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 11:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CFF0613A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2705C81046;
	Wed, 20 Oct 2021 11:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwQu5-Q-gYCA; Wed, 20 Oct 2021 11:09:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC0F380F80;
	Wed, 20 Oct 2021 11:09:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE706C000F;
	Wed, 20 Oct 2021 11:09:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06F43C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 11:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF54E4028A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 11:09:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AMS4JCtM2b0n
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 11:09:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88100401AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 11:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634728151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxSG0fUeJqydzpQE/P3Q1fgRsaxczG8DXtmAlOyDYFE=;
 b=WzZlFmXj1Utu2opphq4liJjq/LzCOUlSkARGIV/Czgf19xvJ04+VmJ8npOqdGpr/PFLmcp
 men9h4TpWscyzkYU4Q3VUGeITd6y8jtByHgwF20T9rwm34DMHDwtqi22kqpiKA3Jf7FCuX
 HVQq2+mjj3ZdLg0djFLs6Zg5+2rFqAw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-dzSMzSlSMtudzdmQvuuVKA-1; Wed, 20 Oct 2021 07:09:09 -0400
X-MC-Unique: dzSMzSlSMtudzdmQvuuVKA-1
Received: by mail-ed1-f71.google.com with SMTP id
 t28-20020a508d5c000000b003dad7fc5caeso3459803edt.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 04:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JxSG0fUeJqydzpQE/P3Q1fgRsaxczG8DXtmAlOyDYFE=;
 b=VUwv8RMwNw8+ju7DNSvKbhy2lL2gq70PFqIV9Q4bssQTpvoXrgeiSYMTffPXMX1VrF
 g6ld9P/37IGvYQJ6em1/VW9VwqbpzoJdXp5/hV6vnksEDrkue9b7/JmQ76GZcdyXZscw
 j+xSORIe1RMzkeNngMxdAim9XKWXz0J61OqSzLZFM6vZlzBAxZHAUfF1b3QWPtsXhGHA
 LwtHWFD42x6ncqpoi3hezwH+q70in3hBxLgDAs403WCz3kTLSNEORrP282T51BTlDeAA
 Zow/S2MW4M6679CVr5DP989Kwy6NqMDQXQ+cKoo0OGX7hgJee9FoGTYAiL+OUeZKLWqC
 UOlQ==
X-Gm-Message-State: AOAM531PuNcS8SuMEmq93gq99ia3LEAQ9i8Yeufn+9gKYr5N6zrEhl1l
 wUANbNgMmFIVprBpunBmlJfBEqCG1q4Hn4VVygLGWt6wWuRcLUhPQmwkDkoZmTT5gw/Tx/oUFrk
 ZXH2k3mWPsinOvmP7/GzX/eAho+PhqX46CLvbo5dPcA==
X-Received: by 2002:aa7:dcc4:: with SMTP id w4mr11350814edu.194.1634728148511; 
 Wed, 20 Oct 2021 04:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLX0s3ZmOy8j5Wq7PJT3DPwI2ndCHMGio5EJATdUrqpM/aB9mtQHR7d4pjcB4ErVm9QyAxvA==
X-Received: by 2002:aa7:dcc4:: with SMTP id w4mr11350782edu.194.1634728148257; 
 Wed, 20 Oct 2021 04:09:08 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id i6sm886352ejd.57.2021.10.20.04.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 04:09:07 -0700 (PDT)
Date: Wed, 20 Oct 2021 07:09:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v5 2/2] virtio_ring: check desc == NULL when using
 indirect with packed
Message-ID: <20211020070838-mutt-send-email-mst@kernel.org>
References: <20211020110551.37358-1-xuanzhuo@linux.alibaba.com>
 <20211020110551.37358-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211020110551.37358-3-xuanzhuo@linux.alibaba.com>
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

On Wed, Oct 20, 2021 at 07:05:51PM +0800, Xuan Zhuo wrote:
> When using indirect with packed, we don't check for allocation failures.
> This patch checks that and fall back on direct.
> 
> Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 91a46c4da87d..552055157b21 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1065,6 +1065,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> +	if (!desc)
> +		return -EAGAIN;
>  
>  	if (unlikely(vq->vq.num_free < 1)) {
>  		pr_debug("Can't add buf len 1 - avail = 0\n");

I still think ENOMEM is better, this way we handle dma map
failures in the same way.

> @@ -1176,6 +1178,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	unsigned int i, n, c, descs_used, err_idx;
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
> +	int err;
>  
>  	START_USE(vq);
>  
> @@ -1191,9 +1194,14 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  
>  	BUG_ON(total_sg == 0);
>  
> -	if (virtqueue_use_indirect(_vq, total_sg))
> -		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> -				out_sgs, in_sgs, data, gfp);
> +	if (virtqueue_use_indirect(_vq, total_sg)) {
> +		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> +						    in_sgs, data, gfp);
> +		if (err != -EAGAIN)
> +			return err;
> +
> +		/* fall back on direct */
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
