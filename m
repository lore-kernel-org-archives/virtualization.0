Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B100C433F5
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:40:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C315A60FC4
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C315A60FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BAE1606D9;
	Mon,  1 Nov 2021 08:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zwSFsiGdSI6K; Mon,  1 Nov 2021 08:40:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E0D0605AD;
	Mon,  1 Nov 2021 08:40:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 645EFC0019;
	Mon,  1 Nov 2021 08:40:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1856BC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E1634021C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:40:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7edpDhn7GzWp
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:40:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 880C5401C8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635756030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xG02j+2l2mZLkyt+TpF2G0aulBqscjth8gUxjgVZezY=;
 b=FnXTfK1geImmRlI77HKoGj57So0jsUSHYPBjJUrVvjIDlxK+11KoFrk7nPrh+skvSEFVqD
 4iUpOqNCwfID+pHYutJy9HxCEl56C4BFcVWppdxRtmPNzpVINaSemIXRSIalGJGFHYp3Lf
 MwdCA/kV4SozB/O28rttZ/emZ6zcbAw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-thfx89ooMGy-5rr5wtwbnA-1; Mon, 01 Nov 2021 04:40:29 -0400
X-MC-Unique: thfx89ooMGy-5rr5wtwbnA-1
Received: by mail-ed1-f72.google.com with SMTP id
 h16-20020a05640250d000b003dd8167857aso14951988edb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 01:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xG02j+2l2mZLkyt+TpF2G0aulBqscjth8gUxjgVZezY=;
 b=igkAnsbRHWpt8B0sP7EA4QBBvl8xlpF9Jo2VQMWMrwa6X7EcYZWUfqcShmngIhtp5C
 +aPM8VxprVGba7HoLoQcjYEu7n1CC0O0ueUUQTc6Au3cjsKZaMq0n1QlwGQg+r5iZJHW
 ko2f4Mm6uPczD6C5hWc5uU1lTuPNrItiqmkJXV0YnLdc5aw/+4T0AawyuFS4MALdDkZF
 cTJerxX3nnmJ2VDUdRcjjRYtkZ5UsyfaU+QP1UCNxG21ia9c9QPwmANlg0BXzk/MGlby
 UqtlKJSU+uvtcOiKpy2nlEOsPW6wZiEiKMj8xj8GSeVMMtGKWOeS7ZWqFekmu8lLgN2u
 zyVA==
X-Gm-Message-State: AOAM5308a1IB6avaPWz5Ip0wqOZ0iM4q8hvt20kj2bK6pW/ttWSUZTkY
 QX/XRDpb0bAoT0CFws5tYQjMFiuTkteTqBuZKf8CggCToLOIMlffpGxhctJCaRpGcKiIm38ZbaD
 JO8SvkbEAdacSDWTmQY/PlVg+1Kwz3Er7Cxdr16gATw==
X-Received: by 2002:a17:906:9753:: with SMTP id
 o19mr16290315ejy.513.1635756028249; 
 Mon, 01 Nov 2021 01:40:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRLzYbWnPDC085EPIZWH2RRdLkJUu6nKtFVO5sJTsosKOeosrJ5fmlxUDbieMdkrBJ/VNAfw==
X-Received: by 2002:a17:906:9753:: with SMTP id
 o19mr16290290ejy.513.1635756028044; 
 Mon, 01 Nov 2021 01:40:28 -0700 (PDT)
Received: from redhat.com ([176.12.204.186])
 by smtp.gmail.com with ESMTPSA id eg33sm5763112edb.77.2021.11.01.01.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 01:40:27 -0700 (PDT)
Date: Mon, 1 Nov 2021 04:40:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [RFC PATCH 1/4] drivers/net/virtio_net: Fixed vheader to use v1.
Message-ID: <20211101043723-mutt-send-email-mst@kernel.org>
References: <20211031045959.143001-1-andrew@daynix.com>
 <20211031045959.143001-2-andrew@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20211031045959.143001-2-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, yuri.benditovich@daynix.com,
 yan@daynix.com, kuba@kernel.org, davem@davemloft.net
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

On Sun, Oct 31, 2021 at 06:59:56AM +0200, Andrew Melnychenko wrote:
> The header v1 provides additional info about RSS.
> Added changes to computing proper header length.
> In the next patches, the header may contain RSS hash info
> for the hash population.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/net/virtio_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4ad25a8b0870..b72b21ac8ebd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -240,13 +240,13 @@ struct virtnet_info {
>  };
>  
>  struct padded_vnet_hdr {
> -	struct virtio_net_hdr_mrg_rxbuf hdr;
> +	struct virtio_net_hdr_v1_hash hdr;
>  	/*
>  	 * hdr is in a separate sg buffer, and data sg buffer shares same page
>  	 * with this header sg. This padding makes next sg 16 byte aligned
>  	 * after the header.
>  	 */
> -	char padding[4];
> +	char padding[12];
>  };
>  
>  static bool is_xdp_frame(void *ptr)


This is not helpful as a separate patch, just reserving extra space.
better squash with the patches making use of the change.

> @@ -1636,7 +1636,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	int num_sg;
> -	unsigned hdr_len = vi->hdr_len;
> +	unsigned int hdr_len = vi->hdr_len;
>  	bool can_push;


if we want this, pls make it a separate patch.


>  
>  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> -- 
> 2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
