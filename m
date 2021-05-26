Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8577DC47082
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 15:15:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B855613CC
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 15:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B855613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8EB1401A2;
	Wed, 26 May 2021 15:15:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3SqaTI4j_90A; Wed, 26 May 2021 15:15:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CF8B40110;
	Wed, 26 May 2021 15:15:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9D41C000D;
	Wed, 26 May 2021 15:15:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D98D3C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 15:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D521F6072D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 15:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5GXnG9bOeDbh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 15:15:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E455060034
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 15:15:11 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id r10so1496619wrj.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zKJ+d2xdcQaoB86Ynp+qKaVBKetJQslZOwN/xQshRB8=;
 b=KES3ksYHStQ8/mkQZCs5zeLeMkaAH4nC6yhbnk9UPF7+IfT858MJijVOdsVUBP7HRc
 5pIh67hsUI8/kjjmVKZW0jVxpsfhwy7sS49DQ7t1GsCwkTfBXZzwvzjwMwLgAG3ycyot
 BsEU2khpD+3Xhgfe/XM3G/NGbNTf+Q3o3NPNNIVx5qWbd9D/SxNKeRdoZB5rQ6Mjq586
 uI9l/U6fU+yHOsAJHciWoKZnWzCQAPHUQJ17xawm7IsV1A9UgbSTLwuugRr8K4UKl+Ii
 nynya7Z67fF3cjfgnzErQrByX/+0jYaT5U5OCRhBPQdzy8zfHTacbzEJrk7CdRnPlOIq
 7KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zKJ+d2xdcQaoB86Ynp+qKaVBKetJQslZOwN/xQshRB8=;
 b=a3c2YivJJYSu0UPu8ZLmFaXvPAuBol3W71jC+g9SSgWBCTnZvO3VMJkAAISXQXyuvS
 ViJuM1hnFAdKXzpymV38LuMqPyQDjyhSCurNnInsSuDVD17w46A4P93ooJvJM2tIfiFM
 7tRP1uk3NjRvUvjd/bdglPp2cpvENOZgVJ7ZOrgvsw459WAC3ImWxj9TKGEeuekjhMlH
 r1lKlSjlP9WtRCcmabDiyL7JU/5vJmnu/t+YHs14bnt81uLX6epr9VzJ8JPRdB/L94jY
 D2bgW2wyA8NkzoCb6kf0fuzmNIYYdzOlCW9hQW4onS5dBLRPrNTkOqm3pdis/bH6GZWF
 h0pA==
X-Gm-Message-State: AOAM532h75x/ojjDbPivLzAK4P1BY/dPBcl6r5/q6s+Mq34rJRGh9wEy
 9RwQOLCG6ha3SEIU8jgD/gE=
X-Google-Smtp-Source: ABdhPJy9NnY2LhH3kKQdhNXpEedeixyGrR0OX9dVm2JF4HKUWdQTid8aqP3v4clKFGZKsGe/8G02Bw==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr33464058wrs.333.1622042110246; 
 Wed, 26 May 2021 08:15:10 -0700 (PDT)
Received: from [10.0.0.2] ([37.170.107.4])
 by smtp.gmail.com with ESMTPSA id k7sm20137292wro.8.2021.05.26.08.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 08:15:09 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] virtio_net: disable cb aggressively
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-5-mst@redhat.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <18b47c22-8c8a-7699-ffaf-ccfdcbf39d37@gmail.com>
Date: Wed, 26 May 2021 17:15:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210526082423.47837-5-mst@redhat.com>
Content-Language: en-US
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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



On 5/26/21 10:24 AM, Michael S. Tsirkin wrote:
> There are currently two cases where we poll TX vq not in response to a
> callback: start xmit and rx napi.  We currently do this with callbacks
> enabled which can cause extra interrupts from the card.  Used not to be
> a big issue as we run with interrupts disabled but that is no longer the
> case, and in some cases the rate of spurious interrupts is so high
> linux detects this and actually kills the interrupt.
> 
> Fix up by disabling the callbacks before polling the tx vq.


It is not clear why we want to poll TX completions from ndo_start_xmit() in napi mode ?

This seems not needed, adding costs to sender thread, this might
reduce the ability to use a different cpu for tx completions.

Also this will likely conflict with BQL model if we want to use BQL at some point.

> 

This probably needs a Fixes: tag 

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/virtio_net.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c29f42d1e04f..a83dc038d8af 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1433,7 +1433,10 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  		return;
>  
>  	if (__netif_tx_trylock(txq)) {
> -		free_old_xmit_skbs(sq, true);
> +		do {
> +			virtqueue_disable_cb(sq->vq);
> +			free_old_xmit_skbs(sq, true);
> +		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>  			netif_tx_wake_queue(txq);
> @@ -1605,12 +1608,17 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>  	bool kick = !netdev_xmit_more();
>  	bool use_napi = sq->napi.weight;
> +	unsigned int bytes = skb->len;
>  
>  	/* Free up any pending old buffers before queueing new ones. */
> -	free_old_xmit_skbs(sq, false);
> +	do {
> +		if (use_napi)
> +			virtqueue_disable_cb(sq->vq);
>  
> -	if (use_napi && kick)
> -		virtqueue_enable_cb_delayed(sq->vq);
> +		free_old_xmit_skbs(sq, false);
> +
> +	} while (use_napi && kick &&
> +	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  	/* timestamp packet in software */
>  	skb_tx_timestamp(skb);
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
