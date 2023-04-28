Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF73C77B73
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 01:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D12C41DC2;
	Fri, 28 Apr 2023 01:08:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D12C41DC2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iRTW9oQ6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3R3YTWlRMU2J; Fri, 28 Apr 2023 01:08:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8FE4C405A4;
	Fri, 28 Apr 2023 01:08:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8FE4C405A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56153C0036;
	Fri, 28 Apr 2023 01:08:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 580ADC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BDDF61114
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:08:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2BDDF61114
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iRTW9oQ6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 93xtG2nbZL8F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:08:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F2A660A84
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F2A660A84
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 01:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682644122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIlO9U65Fa78/bYD7F0pTgvbn+G5S4dqydIF9IQsHyM=;
 b=iRTW9oQ6mjvxqclW3tyUDT+FdWHPlWNxtR2m+DxRZzlUZjqP5CVImtz+pyb24vZeJ6AMDf
 xIymKbRVcdQA4GqhNMcY7v8NhsvbLMAm7qfSt4LLqn9kJwi9AQokrstI4pyIGaswukbqpo
 WUtQiQ6yD6Qy0LEhTkgFgXotK7bUKfY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-a8cGrluzNTy9JoiT4FFHjQ-1; Thu, 27 Apr 2023 21:08:31 -0400
X-MC-Unique: a8cGrluzNTy9JoiT4FFHjQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-2ffee43dac5so3394986f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 18:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682644110; x=1685236110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIlO9U65Fa78/bYD7F0pTgvbn+G5S4dqydIF9IQsHyM=;
 b=jj61c8BUkxTA91i8FnKporFKPwLKxkJGhbeXdBhI1D3dlVrS6CGnAcTk6OT/DOd/BY
 d9zIB4lV5soPI4nLy+SEsYRCw/gXyNuKbzV/sPXJUn8jS9P3MWdFl24i8qwzk+tRbQGR
 1HUTfBEifYEh/YvXNL0ADj0XEx1ebB+utEy+MHZNWtDIQNq5Covncnt/+c2OZgbdWPLx
 VIzgdYjHcmLvU5ZAwGpaoMN4Bz5a/Ntnn4Gf0gWrc+8hJ/JQRcrRx/+n7sZmXaw6jzQY
 vJFRzX9TIoB4/sbfj5+s8P0BbmKXM+gegUYpY2A6EGTBZKxaxGG3gvaqgW5cw2+b0zj8
 Ev6Q==
X-Gm-Message-State: AC+VfDzwH0CnJrG8akMpP5DFMDk1hGbW/cRjMs70nGkejCujm9kQpdKj
 1Xn/ykvV0bcCjv9KCeMmXGpQPgJdIwHbwcQBPSq0QDBb0I9t1hzUbkiG2wJI5pGzCebRTvYGhJr
 y6asHsAtD1pi71T2BZahg8NtH0wHOnVAu8JhdZwMKGQ==
X-Received: by 2002:a05:6000:12c8:b0:303:a2e4:e652 with SMTP id
 l8-20020a05600012c800b00303a2e4e652mr2432529wrx.14.1682644110297; 
 Thu, 27 Apr 2023 18:08:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43yyZywMx1CB2ADiJh65tjfwD1uFSRC7hVGQKqY+xMXE6kvoExBkKUH0cVOJuari+LUhVLcQ==
X-Received: by 2002:a05:6000:12c8:b0:303:a2e4:e652 with SMTP id
 l8-20020a05600012c800b00303a2e4e652mr2432520wrx.14.1682644110024; 
 Thu, 27 Apr 2023 18:08:30 -0700 (PDT)
Received: from redhat.com ([2.52.19.183]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1c7718000000b003f3195be0a0sm3088178wmi.31.2023.04.27.18.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Apr 2023 18:08:29 -0700 (PDT)
Date: Thu, 27 Apr 2023 21:08:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 12/15] virtio_net: small: avoid double
 counting in xdp scenarios
Message-ID: <20230427210802-mutt-send-email-mst@kernel.org>
References: <20230427030534.115066-1-xuanzhuo@linux.alibaba.com>
 <20230427030534.115066-13-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230427030534.115066-13-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Apr 27, 2023 at 11:05:31AM +0800, Xuan Zhuo wrote:
> Avoid the problem that some variables(headroom and so on) will repeat
> the calculation when process xdp.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>


this is "code duplication" not "double counting".


> ---
>  drivers/net/virtio_net.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b8ec642899c9..f832ab8a3e6e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1027,11 +1027,10 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	struct sk_buff *skb;
>  	struct bpf_prog *xdp_prog;
>  	unsigned int xdp_headroom = (unsigned long)ctx;
> -	unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
> -	unsigned int headroom = vi->hdr_len + header_offset;
> -	unsigned int buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> -			      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  	struct page *page = virt_to_head_page(buf);
> +	unsigned int header_offset;
> +	unsigned int headroom;
> +	unsigned int buflen;
>  
>  	len -= vi->hdr_len;
>  	stats->bytes += len;
> @@ -1059,6 +1058,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	rcu_read_unlock();
>  
>  skip_xdp:
> +	header_offset = VIRTNET_RX_PAD + xdp_headroom;
> +	headroom = vi->hdr_len + header_offset;
> +	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> +		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
>  	skb = build_skb(buf, buflen);
>  	if (!skb)
>  		goto err;
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
