Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64ADC433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 13:24:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD6D6137E
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 13:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BD6D6137E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A3AB406EE;
	Tue, 19 Oct 2021 13:24:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EIwbL35MBTLo; Tue, 19 Oct 2021 13:24:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09288406FD;
	Tue, 19 Oct 2021 13:24:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3AFEC0011;
	Tue, 19 Oct 2021 13:24:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE346C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD93D80F2F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:24:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s87TnCpj_hli
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:24:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C62D80EED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634649860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Se1LaNRir0M6jYSdH66G/5LCcMixDP4mBs4RhWWiU6I=;
 b=PlGjymMCMYPo4Ks7bsc00KBRTgQXHSzoaeuJqnOe8941uveaXmUbUqPjrx9E1gPObCALC5
 p9CfATwOXwBVTcWLXljPcB4rgzhTH5jFJoefG4wsR9vZNbskkFmovivIsAHbHVUfzz973c
 sv165fFEKr0nHe9GmOKTUwxX6jmtL0g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-UMPuZeZHNliw37QNBhnyhQ-1; Tue, 19 Oct 2021 09:24:19 -0400
X-MC-Unique: UMPuZeZHNliw37QNBhnyhQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 z23-20020aa7cf97000000b003db7be405e1so17651784edx.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 06:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Se1LaNRir0M6jYSdH66G/5LCcMixDP4mBs4RhWWiU6I=;
 b=Xu6w2pGUcf7ZdZ7R2PHGyYr0WNu24s7dheTVyl3Smc5/EB+i7PL6P7gP4W4drYyhSC
 KiAVa8ttuUyKHKyGR2y2yhJeRZujjHx1X3ZJ5/qWSEAy/TIrhyB0Wz2OfIbTtGwuUoua
 ngd6pjwczmrjPEdbdfFuyhPjQY6yVb6IQ/7sXJxWZo6uohA2RrlMGq0OMS9ExuKZTCka
 JRKnbdltEnIU/Ihw1IbrAGTWFlQsNVfuepo9gK3lG9JpQHxiGa2Gde23inMRXa530rNP
 Bwoa+51xoJ2HcA6pj0mzMFnSiOc3MpK5WiSJFsIsju6WbLH9p53mN52ECAOIn+bOGThe
 ilaQ==
X-Gm-Message-State: AOAM530n92MGx5ChYM746Wfl9C9JW6FNzGjvjp0T/bBLXfvhKkxszc+9
 LHSQ0bZVewX2L/m2p+DefDMXm+Yq+qtuiBPxIbIRKaQPTMYITWF0m6TdrGs5ohVRoJ2OGwSepef
 FuX1TgGwLhMh413GLQng/YJmUV9OTOPtJpOJjwf5HJw==
X-Received: by 2002:a17:906:2bc7:: with SMTP id
 n7mr37104042ejg.238.1634649858031; 
 Tue, 19 Oct 2021 06:24:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3yoN+aYuUee3D134kbaVewgshMVYg7QnsR0WXvmQ38oJ3YWQoE2ni8AJNewgszZwuiYN2rg==
X-Received: by 2002:a17:906:2bc7:: with SMTP id
 n7mr37104024ejg.238.1634649857871; 
 Tue, 19 Oct 2021 06:24:17 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id s3sm10386394ejm.49.2021.10.19.06.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 06:24:17 -0700 (PDT)
Date: Tue, 19 Oct 2021 09:24:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 2/2] virtio_ring: check desc == NULL when using
 indirect with packed
Message-ID: <20211019092355-mutt-send-email-mst@kernel.org>
References: <20211019115235.106507-1-xuanzhuo@linux.alibaba.com>
 <20211019115235.106507-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211019115235.106507-3-xuanzhuo@linux.alibaba.com>
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

On Tue, Oct 19, 2021 at 07:52:35PM +0800, Xuan Zhuo wrote:
> When using indirect with packed, we don't check for allocation failures.
> This patch checks that and fall back on direct.
> 
> Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Was a crash observed with this? It seems quite likely ...


> ---
>  drivers/virtio/virtio_ring.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 91a46c4da87d..44a03b6e4dc4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1065,6 +1065,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> +	if (!desc)
> +		/* fall back on direct */
> +		return -EAGAIN;
>  
>  	if (unlikely(vq->vq.num_free < 1)) {
>  		pr_debug("Can't add buf len 1 - avail = 0\n");
> @@ -1176,6 +1179,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	unsigned int i, n, c, descs_used, err_idx;
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
> +	int err;
>  
>  	START_USE(vq);
>  
> @@ -1191,9 +1195,12 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
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
