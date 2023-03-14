Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4DCC6FD1F
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 09:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05BDB605A3;
	Tue, 14 Mar 2023 09:11:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05BDB605A3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R2BA2x6u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6u_ceoKWMgWg; Tue, 14 Mar 2023 09:11:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F3706103D;
	Tue, 14 Mar 2023 09:11:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F3706103D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65088C0035;
	Tue, 14 Mar 2023 09:11:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42ED5C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B23981220
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:11:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B23981220
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R2BA2x6u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LEwgM0d6uBCH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72D2C81008
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72D2C81008
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678785103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T7LMCjgV3148z08653yeBgRUZqj0U6BVbsGsCqJdIQw=;
 b=R2BA2x6ujlaA2v/AfGgSWEc9Qdv86iwZ4bRci9uxyDvVlvmraSd1QnJgxExnyeH6lQwdty
 +wTgPEB8YrSZwKxpiZUyyDj8hJykadybj6MRghcY/0K+bT3NMtKhn5xgUqpMwdZVx/sawA
 gIXw8DP8aE86WZwkIzaWVy2GMgA4T5Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-pGmMPmfsP2OA85m8XyVtbg-1; Tue, 14 Mar 2023 05:11:42 -0400
X-MC-Unique: pGmMPmfsP2OA85m8XyVtbg-1
Received: by mail-ed1-f72.google.com with SMTP id
 ev6-20020a056402540600b004bc2358ac04so21180134edb.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 02:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678785099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7LMCjgV3148z08653yeBgRUZqj0U6BVbsGsCqJdIQw=;
 b=O/tCNFa5uWSD3Q5AupPVlMC+dm4e30V9rmKHn+oEwZl+I2UyEegtEm80LFxldHmV+7
 6LltCtMfq6/BVxebT35UHQogD5zb/JqZSAuDXWmzv+4vm9gnr1s9YfxtMLayEgfbmhrB
 T1pKSSfbyFzFU76DSrqAGOYg0WdQLNfuCchMyU4eIsjWZxTifw6UF4/21RrPHUYRU2aC
 6830fhf8Anjoj9HgG5q3IxUz2J78pQxi5WJRMv91odqOJfej0gCnRZRowb6GvI+YBXij
 BKt8AzEWO7bPWBIUEMpRnHHB+X5rSrt2QNjrm7G6DoH9aJZiYtBkxFoWi26DXLJWy52x
 7Uiw==
X-Gm-Message-State: AO0yUKVzH4hltN+DntObMgZLHOl5rzuNLzqo5iGK9MdbBd2HcCzEVqjh
 kdaiD4Ubnnd41N74PJ22uYjSJTFPZ7Iebjp0Pq6mwIovePoqnIhPNcg3DeoF+qyj/ffXAUverIj
 04AVaCAV7SVCaj3Q+GLAnQobQKlNfJUSeyrUnYCBimg==
X-Received: by 2002:a17:907:746:b0:92b:ae6c:23e7 with SMTP id
 xc6-20020a170907074600b0092bae6c23e7mr1868567ejb.56.1678785099435; 
 Tue, 14 Mar 2023 02:11:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set+bdi1ysk/4yWOK0bSSOg12ZBcLDKbIuHqp5BWiooRh0XX2E3g6+Wpi5yzgkrXZjiEs1t2Sbg==
X-Received: by 2002:a17:907:746:b0:92b:ae6c:23e7 with SMTP id
 xc6-20020a170907074600b0092bae6c23e7mr1868546ejb.56.1678785099140; 
 Tue, 14 Mar 2023 02:11:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:4129:3ef9:ea05:f0ca:6b81])
 by smtp.gmail.com with ESMTPSA id
 hd31-20020a170907969f00b0092d58e24e11sm356116ejc.137.2023.03.14.02.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Mar 2023 02:11:38 -0700 (PDT)
Date: Tue, 14 Mar 2023 05:11:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 2/2] virtio_net: free xdp shinfo frags when
 build_skb_from_xdp_buff() fails
Message-ID: <20230314051049-mutt-send-email-mst@kernel.org>
References: <20230314083901.40521-1-xuanzhuo@linux.alibaba.com>
 <20230314083901.40521-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230314083901.40521-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Heng Qi <hengqi@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Mar 14, 2023 at 04:39:01PM +0800, Xuan Zhuo wrote:
> build_skb_from_xdp_buff() may return NULL, on this
> scene we need to free the frags of xdp shinfo.

s/on this scene/in this case/

> 
> Fixes: fab89bafa95b ("virtio-net: support multi-buffer xdp")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8ecf7a341d54..d36183be0481 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1273,9 +1273,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  
>  		switch (act) {
>  		case XDP_PASS:
> +			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> +			if (!head_skb)
> +				goto err_xdp_frags;
> +
>  			if (unlikely(xdp_page != page))
>  				put_page(page);
> -			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>  			rcu_read_unlock();
>  			return head_skb;
>  		case XDP_TX:
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
