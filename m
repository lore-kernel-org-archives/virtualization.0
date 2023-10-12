Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27B0CDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 09:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F004410BA;
	Thu, 12 Oct 2023 09:11:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F004410BA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eOKB/WnD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z_3AELINi-iy; Thu, 12 Oct 2023 09:11:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3146F410A4;
	Thu, 12 Oct 2023 09:11:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3146F410A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BB10C0071;
	Thu, 12 Oct 2023 09:11:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B183CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EF0882252
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:11:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EF0882252
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eOKB/WnD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id veAJRPx7fN_q
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:11:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4D7682162
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:11:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4D7682162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697101866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t2ul78a+hZKKQoapj3GAU9FVBpVNy3dwXsHSe4SyE4s=;
 b=eOKB/WnDObyE3Os5ZyxHXEy6DprcZ9XF+Ibx842TjauMEwDmshhipLDTvTgeTICfp9HW0F
 5q0Y5pl4X9GXQScpldxLoto78cHsZiabJbTzZ2d9LL2gl03Eqv9UcGm3dkovLamYnC3HUA
 unIf2i6M2dsAvV/SPiMZycM349CRWpw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-fSpWTTEzOumTuQqaUEiZ3w-1; Thu, 12 Oct 2023 05:11:00 -0400
X-MC-Unique: fSpWTTEzOumTuQqaUEiZ3w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40570ccc497so6099155e9.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 02:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697101859; x=1697706659;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2ul78a+hZKKQoapj3GAU9FVBpVNy3dwXsHSe4SyE4s=;
 b=vjX0/i9ILaZW+f5c02BCBt7hgvIpDK9zdImaaU2z03X654CV+OMjpsOiQ3Pwrws8fX
 NP7P20yAaO202XjMhPaoQtaffmfJo9SmpFtrMzY4ehQXaC4GmoqcFCwTtdgx2m/HBsUC
 T0a2kGRTLr+IbidfS8tVO9u5fHKHhuZB7c5YGhstlvsUgLuXtysyZeP8Am+S5CzxtMpX
 W2potKAtmhir45kaMw/9jZ5MDe/kJxQDJ670DWUSWF1q+zG/SsOlYZvTJ90dfhfCgqxS
 suiClgCZFkMu5vvkNx6zU9jGeLpEpKN/Tlw8NVuJ8ywoFbojQg+7w2oJHXg20inbzEvB
 v1yQ==
X-Gm-Message-State: AOJu0YwqB78risrvv/zIdnICOYEcb6vunUXeUmBZr6gPHMFYwfEd6nAc
 uZIv6P0ugJ4hi3TGK9ZKyauSlylwR/H+E5MukEFMeFWjlsFUU7DKUezG1HRv2+FZFMqNTuDJAq1
 seuf7wF5JHyzoC/OwVuIuCEty5gU1CtD42SfrbhfAzA==
X-Received: by 2002:a05:600c:21d5:b0:402:ee71:29 with SMTP id
 x21-20020a05600c21d500b00402ee710029mr21887104wmj.10.1697101859464; 
 Thu, 12 Oct 2023 02:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuGS+ZPrNCjZO/nefYmxLR7WYca/gn0IK+gNcR2C/7QxR8YxUcJKE4ATwpT+VU575s2Y1WmA==
X-Received: by 2002:a05:600c:21d5:b0:402:ee71:29 with SMTP id
 x21-20020a05600c21d500b00402ee710029mr21887081wmj.10.1697101859026; 
 Thu, 12 Oct 2023 02:10:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a05600c214500b003fbe791a0e8sm19097092wml.0.2023.10.12.02.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 02:10:58 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:10:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 21/22] virtio_net: update tx timeout record
Message-ID: <20231012050936-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
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

On Wed, Oct 11, 2023 at 05:27:27PM +0800, Xuan Zhuo wrote:
> If send queue sent some packets, we update the tx timeout
> record to prevent the tx timeout.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/xsk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index 7abd46bb0e3d..e605f860edb6 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -274,6 +274,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
>  
>  	virtnet_xsk_check_queue(sq);
>  
> +	if (stats.packets) {
> +		struct netdev_queue *txq;
> +		struct virtnet_info *vi;
> +
> +		vi = sq->vq->vdev->priv;
> +
> +		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
> +		txq_trans_cond_update(txq);
> +	}
> +
>  	u64_stats_update_begin(&sq->stats.syncp);
>  	sq->stats.packets += stats.packets;
>  	sq->stats.bytes += stats.bytes;

I don't get what this is doing. Is there some kind of race here you
are trying to address? And what introduced the race?

> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
