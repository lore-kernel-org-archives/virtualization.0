Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C91C433EF
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:44:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9593860551
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9593860551
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CA496067E;
	Mon,  1 Nov 2021 08:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ej3Wn459R301; Mon,  1 Nov 2021 08:44:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 70C2A605AD;
	Mon,  1 Nov 2021 08:44:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57FF0C0019;
	Mon,  1 Nov 2021 08:44:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05423C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB1F780CB3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id si3HEPuaY4ad
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60ED580CC7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635756248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Ad4v/ujl0t03/UsIys5jLvOTiR3MOz3oTeEO3GUsRw=;
 b=UdxHmithQu3Z860J0B8MI1vr1m86BAPBmp43ufKVyqUVGkICbWxGZlwLsin8SKjYD9/Sku
 XFf0QJpRk81zhLDw/2XM6AmkpFX8RfZdSMgMd2u9Magq2o3/pTSboijJZGZmsxpD6Vynw0
 pN2JdQDPQtGgP5CBl9FEvJ1U5qUWDNs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-tNQgTR5sNIudob5yiD78ww-1; Mon, 01 Nov 2021 04:44:07 -0400
X-MC-Unique: tNQgTR5sNIudob5yiD78ww-1
Received: by mail-ed1-f69.google.com with SMTP id
 w26-20020a056402071a00b003e28a389d04so2615340edx.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 01:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2Ad4v/ujl0t03/UsIys5jLvOTiR3MOz3oTeEO3GUsRw=;
 b=4olqNcPLaIbf1XOHZkjuKJWiyh711yZuT+6xfiiZL8HUab3fTPp6yG0RM5dUQVCuC+
 eQ1yRkcsgxEnYgtGBOSn6mz5kqW2sZTp7UuSi0cEnAD99FsNysUzB0jJDtgcTGL0hqzo
 2Vnqe1c+1M4emxYRhGs2ShAfdN3o62BuCXT7m7Gysm4mzY1ghETCHZ7RCAFGIiaq3gzD
 RI3wWscmM2guJKaASa/iOk07GH8fJWZqKs7ytdauukhqPJHgHvTA1oNlrxMnKSqdDNhr
 VnIuvTY2u1gA3bYoM/QwtM+cAfOVK58LZ1kEp6zkm4BhTNOzWsO41orEwYJ0nwe8ptgy
 wyBQ==
X-Gm-Message-State: AOAM533K9n0PtPfg1Pvs4/BnAdJZt9X4bZ2puedoC60NRDXh79ocHqWF
 Uut9kx5mnnNed55VaiN6Aw/yQS9zcRPhxkcC3C69q1AsGyoUZIr4shPGCnB/2Qw4TdKbcVagTJ7
 RSrx+8ec5rP/HJpNUGNsoR3qPmFgPmPiSLy2yrswfEQ==
X-Received: by 2002:a17:906:6a08:: with SMTP id
 qw8mr16861437ejc.200.1635756246077; 
 Mon, 01 Nov 2021 01:44:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd49MFk73UCNOr557C1b0YMN2BJsE8P1scufrL9YzNQZV1E2Ocll2Ydrc/TjafnpwIacvjTA==
X-Received: by 2002:a17:906:6a08:: with SMTP id
 qw8mr16861416ejc.200.1635756245941; 
 Mon, 01 Nov 2021 01:44:05 -0700 (PDT)
Received: from redhat.com ([176.12.204.186])
 by smtp.gmail.com with ESMTPSA id ho17sm1128483ejc.111.2021.11.01.01.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 01:44:05 -0700 (PDT)
Date: Mon, 1 Nov 2021 04:44:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [RFC PATCH 2/4] drivers/net/virtio_net: Changed mergeable buffer
 length calculation.
Message-ID: <20211101044051-mutt-send-email-mst@kernel.org>
References: <20211031045959.143001-1-andrew@daynix.com>
 <20211031045959.143001-3-andrew@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20211031045959.143001-3-andrew@daynix.com>
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

On Sun, Oct 31, 2021 at 06:59:57AM +0200, Andrew Melnychenko wrote:
> Now minimal virtual header length is may include the entire v1 header
> if the hash report were populated.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>

subject isn't really descriptive. changed it how?

And I couldn't really decypher what this log entry means either.

> ---
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b72b21ac8ebd..abca2e93355d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -393,7 +393,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	hdr_p = p;
>  
>  	hdr_len = vi->hdr_len;
> -	if (vi->mergeable_rx_bufs)
> +	if (vi->has_rss_hash_report)
> +		hdr_padded_len = sizeof(struct virtio_net_hdr_v1_hash);
> +	else if (vi->mergeable_rx_bufs)
>  		hdr_padded_len = sizeof(*hdr);
>  	else
>  		hdr_padded_len = sizeof(struct padded_vnet_hdr);
> @@ -1252,7 +1254,7 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>  					  struct ewma_pkt_len *avg_pkt_len,
>  					  unsigned int room)
>  {
> -	const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
> +	const size_t hdr_len = ((struct virtnet_info *)(rq->vq->vdev->priv))->hdr_len;
>  	unsigned int len;
>  
>  	if (room)

Is this pointer chasing the best we can do?

> @@ -2817,7 +2819,7 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
>   */
>  static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqueue *vq)
>  {
> -	const unsigned int hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
> +	const unsigned int hdr_len = vi->hdr_len;
>  	unsigned int rq_size = virtqueue_get_vring_size(vq);
>  	unsigned int packet_len = vi->big_packets ? IP_MAX_MTU : vi->dev->max_mtu;
>  	unsigned int buf_len = hdr_len + ETH_HLEN + VLAN_HLEN + packet_len;
> -- 
> 2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
