Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3905C433B4
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 14:35:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA8261C96
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 14:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA8261C96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C334608D0;
	Mon, 17 May 2021 14:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18dKZYDETp-p; Mon, 17 May 2021 14:35:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51D7360A36;
	Mon, 17 May 2021 14:35:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 240A2C000D;
	Mon, 17 May 2021 14:35:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21160C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 14:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7CA4402EF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 14:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=lunn.ch
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3yAQa2hWKozA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 14:35:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16C63402C1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=+etklaO9vkFUBnNppWvW4wT/pFgZKsFAvZPj7+HIov0=; b=zpD4UKF6csA6gWp48EJrtM/Jcv
 pr7Ed12Me36Es1mhkIPUQI9CBD7Sqd6mSIVYVSGi4JtlVUhHPk+SPqr9NxuKQqsIUg4vi4+ynw3Ix
 AEGn9kD+0a4htguaZTizw+/0CSrCsLhA+setHgH0Fm4heqTWKbybbmOQVAzf+DhTgPj8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1lieL2-004ZSU-Np; Mon, 17 May 2021 16:35:20 +0200
Date: Mon, 17 May 2021 16:35:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Use BUG_ON instead of if condition followed
 by BUG
Message-ID: <YKJ/KPtw5Xcjsea+@lunn.ch>
References: <56270996-33a6-d71b-d935-452dad121df7@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56270996-33a6-d71b-d935-452dad121df7@linux.alibaba.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 davem@davemloft.net
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

On Mon, May 17, 2021 at 09:31:19PM +0800, Xianting Tian wrote:
> BUG_ON() uses unlikely in if(), which can be optimized at compile time.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c921ebf3ae82..212d52204884 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1646,10 +1646,9 @@ static int xmit_skb(struct send_queue *sq, struct
> sk_buff *skb)
>  	else
>  		hdr = skb_vnet_hdr(skb);
> 
> -	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,

How fatal is it not being able to get the header from the skb? There
has been push back on the use of BUG() or its variants, since it kills
the machine dead. Would it be possible to turn this into a WARN_ON and
return -EPROTO or something?

       Andrew
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
