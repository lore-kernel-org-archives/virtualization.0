Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32F2C433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 13:22:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC246113D
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 13:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FC246113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50F3A40521;
	Tue, 19 Oct 2021 13:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ejKmmtraUPvV; Tue, 19 Oct 2021 13:22:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BAF73402BC;
	Tue, 19 Oct 2021 13:22:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A206C0011;
	Tue, 19 Oct 2021 13:22:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B01B1C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FBED60BCF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cAfStCoY-Vlx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:21:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C004160BA7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634649718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vC1M/mvjWoSIvFBq522o29WiFAg/J8OK9TerHC6wOuo=;
 b=H7rwzOaZZ3e1HmaJBgKx+rSYHp9MNo4Wu7Uybau/MqHxuAMZ8DDFCBN2Q6Yu6k1t/8AGSU
 8VtFbHOfZZX5pi2n4npEiHvW8Tq7tqD+veSZE+gzcngoofUQvfIWjWJm6gpA0IZr2a3d/J
 oaC+vDYxmopn/cW7ylaj0CXbUUZG+Sk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-oTcIDqtkOK640-kXSZHKzA-1; Tue, 19 Oct 2021 09:21:56 -0400
X-MC-Unique: oTcIDqtkOK640-kXSZHKzA-1
Received: by mail-wm1-f70.google.com with SMTP id
 k9-20020a7bc409000000b0030d978403e9so2534802wmi.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 06:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vC1M/mvjWoSIvFBq522o29WiFAg/J8OK9TerHC6wOuo=;
 b=FJ2tDEDFsrwVHfZ/gBSnYncsVNsdoy8dyAglphOpRmOndy6Jhgzq2dIwelxhrb/pja
 WaHTQ0NdXRUfpd+W3WjhSCdDxXH6Fzx2EjKeMnJ+IGNNC5zzuf3E28Lju8NbO32smZo0
 zOdZ0CUHM8yhnporJvJ8rFXLEhgDH18VN+z9A6uT0X44euagGzup3jWLpMPbxKIDso4H
 xIoko1fKnBduOEEkSB/NOrvi7SFrRHKDbIlSO4Jyv0vCKe6e/vRL+g1Omm49T0ZCg9VF
 VobWYDh901QJnL8Qhi8tXWChTDLnOLI+LhxNGegaczAtJf8hhCJMEcYJUZqgXL6yKcYw
 Bkgg==
X-Gm-Message-State: AOAM531WCInx5jvzLXEVq21dl1bkGqILq8+mlsVZxaStH6GS2wJfu8U2
 1RwuI5L7hVfKeHUrWZzfj+zphhiKt21zZgmEPNp05a/6pYcaeeFhIIFE9NmYiSof3+2tnOp1Ywn
 XGw2zaalWio329zXTTnrS/zBrPv9o2oxxviAaegvQDA==
X-Received: by 2002:a05:600c:208:: with SMTP id
 8mr5760140wmi.173.1634649715615; 
 Tue, 19 Oct 2021 06:21:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/kpLbtHW0cNKNCcLk0a1hXQol7+Qpu7kNRzf6u/F3Xr9XMChpYKTU916VYquSzEcWB4wgiw==
X-Received: by 2002:a05:600c:208:: with SMTP id
 8mr5760112wmi.173.1634649715376; 
 Tue, 19 Oct 2021 06:21:55 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id t14sm15176470wrr.75.2021.10.19.06.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 06:21:54 -0700 (PDT)
Date: Tue, 19 Oct 2021 09:21:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 2/2] virtio_ring: check desc == NULL when using
 indirect with packed
Message-ID: <20211019091947-mutt-send-email-mst@kernel.org>
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

this comment belongs in virtqueue_add_packed right after
return.

> +		return -EAGAIN;
>  

-ENOMEM surely?

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
