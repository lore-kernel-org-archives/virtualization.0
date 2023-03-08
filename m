Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F40DC678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 06:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 920B540400;
	Wed,  8 Mar 2023 06:53:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 920B540400
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eHzOY54b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R0GqV6c2UDW7; Wed,  8 Mar 2023 06:53:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A20EF4054E;
	Wed,  8 Mar 2023 06:53:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A20EF4054E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68653C0071;
	Wed,  8 Mar 2023 06:53:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6178FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F99040400
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:53:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F99040400
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Udqg6uz2Jehl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:53:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B339D4054E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B339D4054E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678258404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y86pDM0nF4SS/2l52+50ptoIaTxu1jy+95EBPWqW538=;
 b=eHzOY54bLnuOwEolP0N/+odD8pWurO1r7Da6c2a76IfncLDUt1SzqFqq40eKR/2QuxqVCD
 0YmQfc2fm++LnVMDIr5hvYL+smiLL8pYwYcde27942gMgGMKOiCCE+BU28hNKHgDtdPLX0
 yXwXAt+NUXLpQDbsl+BwE+VgsvYoS4w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-kdBJ3oyhPnKs8lxRDtylXQ-1; Wed, 08 Mar 2023 01:53:21 -0500
X-MC-Unique: kdBJ3oyhPnKs8lxRDtylXQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 q13-20020a5085cd000000b004af50de0bcfso22739481edh.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 22:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678258400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y86pDM0nF4SS/2l52+50ptoIaTxu1jy+95EBPWqW538=;
 b=tsAjtZVXraiU3EZS3aoWT7PqPB5FeODz3jDJDiJ/ORF9GCNX+il6WEj8w/nJvcG7I8
 sLo8SIqUBDPOdEzp/oQcHv8uHS/xYvyeSygUeDFCEPBNNqdt1v9AVlsWUyIoAHhb/yOW
 8AKT25/gKe/cDW+6X0Mas4eAItOs+SKmheU5+kmkkltQOixL0EgvpgSUFWpsqIiJFMn5
 OvFMe1pSC6v4+N6YPFU/Y5pLiShUpUth8kA0bzX7vVmMc6jOit+zUGER7ZIhn2TCNnN5
 RdR8oTX8934tvsCZos6Qa/Q7AGJZmuwoTSagi5Pn2jI+IRJPdfCqOxMuyeMvD1aU8++2
 NrLw==
X-Gm-Message-State: AO0yUKX/BfkpU4qWPhTnfqdHMZoIIHyRBZh3tkN8Pbu6EuxUURFUQKSm
 BM1hmVmiA9bL4VoGb5SCqbLqn50v7/SLYijingIXmp/tUgKIEhc0T1h5PVZAvE62iR+GRrTiYdD
 FnfvDUcrAoHcERzi/IKM6s4Su/cowf7+RATKtsgbyJA==
X-Received: by 2002:a17:907:72c7:b0:889:d156:616d with SMTP id
 du7-20020a17090772c700b00889d156616dmr21552350ejc.27.1678258400255; 
 Tue, 07 Mar 2023 22:53:20 -0800 (PST)
X-Google-Smtp-Source: AK7set9xF4xRWiMSSCuL+dL3ONYy7crKcxfjeDDKfUoTwq1xZ/S/2EmD4jkVLapobwjXJ06W9xks2w==
X-Received: by 2002:a17:907:72c7:b0:889:d156:616d with SMTP id
 du7-20020a17090772c700b00889d156616dmr21552324ejc.27.1678258399943; 
 Tue, 07 Mar 2023 22:53:19 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 bn17-20020a170906c0d100b008f7f6943d1dsm7044130ejb.42.2023.03.07.22.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Mar 2023 22:53:19 -0800 (PST)
Date: Wed, 8 Mar 2023 01:53:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net, stable v1 1/3] virtio_net: reorder some funcs
Message-ID: <20230308015204-mutt-send-email-mst@kernel.org>
References: <20230308024935.91686-1-xuanzhuo@linux.alibaba.com>
 <20230308024935.91686-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230308024935.91686-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Yichun Zhang <yichun@openresty.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Wed, Mar 08, 2023 at 10:49:33AM +0800, Xuan Zhuo wrote:
> The purpose of this is to facilitate the subsequent addition of new
> functions without introducing a separate declaration.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

this one isn't for stable naturally, stable can use forward declarations
instead.

> ---
>  drivers/net/virtio_net.c | 92 ++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fb5e68ed3ec2..8b31a04052f2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -545,6 +545,52 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	return skb;
>  }
>  
> +static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
> +{
> +	unsigned int len;
> +	unsigned int packets = 0;
> +	unsigned int bytes = 0;
> +	void *ptr;
> +
> +	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> +		if (likely(!is_xdp_frame(ptr))) {
> +			struct sk_buff *skb = ptr;
> +
> +			pr_debug("Sent skb %p\n", skb);
> +
> +			bytes += skb->len;
> +			napi_consume_skb(skb, in_napi);
> +		} else {
> +			struct xdp_frame *frame = ptr_to_xdp(ptr);
> +
> +			bytes += xdp_get_frame_len(frame);
> +			xdp_return_frame(frame);
> +		}
> +		packets++;
> +	}
> +
> +	/* Avoid overhead when no packets have been processed
> +	 * happens when called speculatively from start_xmit.
> +	 */
> +	if (!packets)
> +		return;
> +
> +	u64_stats_update_begin(&sq->stats.syncp);
> +	sq->stats.bytes += bytes;
> +	sq->stats.packets += packets;
> +	u64_stats_update_end(&sq->stats.syncp);
> +}
> +
> +static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> +{
> +	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> +		return false;
> +	else if (q < vi->curr_queue_pairs)
> +		return true;
> +	else
> +		return false;
> +}
> +
>  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>  				   struct send_queue *sq,
>  				   struct xdp_frame *xdpf)
> @@ -1714,52 +1760,6 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  	return stats.packets;
>  }
>  
> -static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
> -{
> -	unsigned int len;
> -	unsigned int packets = 0;
> -	unsigned int bytes = 0;
> -	void *ptr;
> -
> -	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> -		if (likely(!is_xdp_frame(ptr))) {
> -			struct sk_buff *skb = ptr;
> -
> -			pr_debug("Sent skb %p\n", skb);
> -
> -			bytes += skb->len;
> -			napi_consume_skb(skb, in_napi);
> -		} else {
> -			struct xdp_frame *frame = ptr_to_xdp(ptr);
> -
> -			bytes += xdp_get_frame_len(frame);
> -			xdp_return_frame(frame);
> -		}
> -		packets++;
> -	}
> -
> -	/* Avoid overhead when no packets have been processed
> -	 * happens when called speculatively from start_xmit.
> -	 */
> -	if (!packets)
> -		return;
> -
> -	u64_stats_update_begin(&sq->stats.syncp);
> -	sq->stats.bytes += bytes;
> -	sq->stats.packets += packets;
> -	u64_stats_update_end(&sq->stats.syncp);
> -}
> -
> -static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> -{
> -	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> -		return false;
> -	else if (q < vi->curr_queue_pairs)
> -		return true;
> -	else
> -		return false;
> -}
> -
>  static void virtnet_poll_cleantx(struct receive_queue *rq)
>  {
>  	struct virtnet_info *vi = rq->vq->vdev->priv;
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
