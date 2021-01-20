Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DD0C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 07:57:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37FB23158
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 07:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37FB23158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 102668691E;
	Wed, 20 Jan 2021 07:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gyD1NxkyHi1I; Wed, 20 Jan 2021 07:57:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D17B2868B6;
	Wed, 20 Jan 2021 07:57:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A05C4C088B;
	Wed, 20 Jan 2021 07:57:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6A9DC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B54F586D52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hgf9v2mRk6CQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:57:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 232738693C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611129462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6UrxbpNYHnK4DEP6WSgA1c696nQ5LZj2MHb845FTR0o=;
 b=JfaiPu/Ton8/Of7IxLmCwZ1eB5RJt5u+/eW7JyxyVxouHCDfLt/KUxbVLI1lLaY69C9jNa
 rU1Q43WsLRQ+oavZ004yx50VUrtCIdOga3zxZSwbyF27P/ijYaimQeNbYe8ZhAvV+YRJBG
 v1wEptLCLXXmM7Y09vynoewdnbsLfBU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-pJmoLd1eOYqKdj3i0ttdsQ-1; Wed, 20 Jan 2021 02:57:40 -0500
X-MC-Unique: pJmoLd1eOYqKdj3i0ttdsQ-1
Received: by mail-wm1-f72.google.com with SMTP id 184so314508wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 23:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6UrxbpNYHnK4DEP6WSgA1c696nQ5LZj2MHb845FTR0o=;
 b=ZQMFK1Pbkc6Yy+5JY88XZ33+gu59GTXwmocr/Cox/iGSdPKfyjJn7Pkaqg2uHXG71U
 xJ3m0o63VnXkTpCV29qkNpPGGPpaNFpyzZJjIPF7HG8NpfLWJn0YZvuzWsNXkZjk0oaE
 q+CCt+UUL+5hOX6pO+hQywSqPSWMeAbJ7yX9XBnVszjXV0obs63DUaTQAUnvsYgndQhE
 jgGnfFCkuzvZVjKLanyL6Rb7jkiiv4liZfZhZI9oduorKP5gQyDZ+lIOftN+0PKd6xQ/
 idzO5VnQIRwCxrYyodMQFoGeKWBxWw+zTLw38UASmW3nZPh456vnAnxTi/744RcBFHTp
 AA8Q==
X-Gm-Message-State: AOAM5335YsQBX3U9QqNVlZrAT4PHZHt664srqgI9/zPdpIQNl4+ynXAY
 YllJyfxi6/sR1ETIA5fsJkQxO1+/YHJWwpRMYmNjy8Knl09fw2eHer9HAb0x1B7JFJeku/UYPb7
 wo7j7sLpnKB4Oxj3VDdSN07lENy6Bu960yQhdh0JLTQ==
X-Received: by 2002:a1c:a784:: with SMTP id q126mr3058496wme.52.1611129459058; 
 Tue, 19 Jan 2021 23:57:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIpBmdXLlNr8vbRKHAMR3mn1UgNMPNu1agQMsKN5OdQKV4XJ/XAHPr6RwZNDY4dCN1R7xGyw==
X-Received: by 2002:a1c:a784:: with SMTP id q126mr3058476wme.52.1611129458879; 
 Tue, 19 Jan 2021 23:57:38 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id k9sm2510093wma.17.2021.01.19.23.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 23:57:38 -0800 (PST)
Date: Wed, 20 Jan 2021 02:57:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 2/3] virtio-net: support IFF_TX_SKB_NO_LINEAR
Message-ID: <20210120025729-mutt-send-email-mst@kernel.org>
References: <cover.1611128806.git.xuanzhuo@linux.alibaba.com>
 <d54438cec1fc86a1cb0166098493b1aa6a15885a.1611128806.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <d54438cec1fc86a1cb0166098493b1aa6a15885a.1611128806.git.xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexander Lobakin <alobakin@pm.me>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, bjorn.topel@intel.com,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Wed, Jan 20, 2021 at 03:49:10PM +0800, Xuan Zhuo wrote:
> Virtio net supports the case where the skb linear space is empty, so add
> priv_flags.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ba8e637..f2ff6c3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2972,7 +2972,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		return -ENOMEM;
>  
>  	/* Set up network device as normal. */
> -	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
> +	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
> +			   IFF_TX_SKB_NO_LINEAR;
>  	dev->netdev_ops = &virtnet_netdev;
>  	dev->features = NETIF_F_HIGHDMA;
>  
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
