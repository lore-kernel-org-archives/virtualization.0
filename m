Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A5BC433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 08:18:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13C064F30
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 08:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13C064F30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74A2B84167;
	Thu, 18 Mar 2021 08:18:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FO6wiQrfMddh; Thu, 18 Mar 2021 08:18:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21B9784164;
	Thu, 18 Mar 2021 08:18:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE32EC000B;
	Thu, 18 Mar 2021 08:18:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A30DC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 08:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5445C4309A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 08:18:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xaFj5caZ6xrY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 08:18:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD4CD41566
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 08:18:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D6C264EF6;
 Thu, 18 Mar 2021 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616055497;
 bh=3E9H2zpeiDX6zhLzzRcdnJAvRLq5r0LmDVSbVqSH5PY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=toPoZYi70tiuUwSJYqo92mplFfSeGWj2ik1yhufFzen5C/HeF0MbGYzDQYB46llDj
 4LCHbAPmBGvIeD6di0GoC+M5803q0r4t7a7AE4k06k3wJYsPf12qD0V3/NrP0ohEZm
 eJB7ZjL4cshxkdRAVtC3mAxMcouDKNP+n9nw1TSU3iTHu6Jx0ODcDbE74ihKmGvwyU
 ahbCDNPeQopboh+9SPM75PGBUTCqAPHat9pW3Q1ZooeY/I/nPHkOs4v5EPkWdOIm8V
 H9L4QuAASoDvtS7+nghvIORXU5tfBT0k/6VE5/7x3T0i/n8IsFmbQkAh/kkDeqLgxU
 qzRWQ90DG0mKA==
Date: Thu, 18 Mar 2021 10:18:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: replace if (cond) BUG() with BUG_ON()
Message-ID: <YFMMxSHGNxjw29iA@unreal>
References: <1615960635-29735-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1615960635-29735-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Cc: songliubraving@fb.com, kafai@fb.com, hawk@kernel.org, daniel@iogearbox.net,
 mst@redhat.com, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, andrii@kernel.org, yhs@fb.com, kpsingh@kernel.org,
 kuba@kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
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

On Wed, Mar 17, 2021 at 01:57:15PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
>
> ./drivers/net/virtio_net.c:1551:2-5: WARNING: Use BUG_ON instead of if
> condition followed by BUG.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 82e520d..093530b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1545,10 +1545,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  	else
>  		hdr = skb_vnet_hdr(skb);
>
> -	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
> -				    virtio_is_little_endian(vi->vdev), false,
> -				    0))
> -		BUG();
> +	BUG_ON(virtio_net_hdr_from_skb(skb, &hdr->hdr,  virtio_is_little_endian(vi->vdev),
> +				       false, 0));

This BUG() in virtio isn't supposed to be in the first place.
You should return -EINVAL instead of crashing system.

Thanks

>
>  	if (vi->mergeable_rx_bufs)
>  		hdr->num_buffers = 0;
> --
> 1.8.3.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
