Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EC6C433DB
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 21:36:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808CD21534
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 21:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808CD21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 20DB085F92;
	Mon, 28 Dec 2020 21:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uvo7UhBo_nP9; Mon, 28 Dec 2020 21:36:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58E39842DE;
	Mon, 28 Dec 2020 21:36:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45303C0893;
	Mon, 28 Dec 2020 21:36:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65778C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4A06D86DCF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:36:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P2ygsguor5Wk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:36:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2CD5C86DCC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609191402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cNicy8A1iYfuWy2Y4PrSJ6PP9ocoInA0QnPx1AGCPo0=;
 b=IGBor0EnLwI2Iif2Gf/Clb0T8fN0Wq0qrGy62n5sUlHTXOBwRprzP8BhAESv4iegCDHkjH
 8InCUo++cr1eNyanvzUANyO22/bfdW1e70bThoCnjgfsybY+kcvUugSWdu1AlnLL8+dvvr
 QZKWxUdS4mDD2kyyf+OcgWRZ0fJI314=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-oXYys156MJ6G8gS_mxRQwg-1; Mon, 28 Dec 2020 16:36:40 -0500
X-MC-Unique: oXYys156MJ6G8gS_mxRQwg-1
Received: by mail-wr1-f69.google.com with SMTP id y5so6769184wrs.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 13:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cNicy8A1iYfuWy2Y4PrSJ6PP9ocoInA0QnPx1AGCPo0=;
 b=F13HZzchmMQMVMu5HnkYyNUlymWN4+GJPnNZwzI1VrCN5ek+vnP243RrahkQf9kYnX
 JCfCrOT9BRWL/rOQEFH2LMZoNQ4BCsiiNIXdibo6GVolkn0wWPpQgLOpSVaY8Cypnkpl
 PR/zdeazvGyw+7xAG4JfHmVWr7DR/z7VW6U3WLt8PfLn53K0O8xQWEF7KLwcOm4cLTqa
 yucJidcdSHIdUQ1DXAmMccdc6G+CNkyPgb2WQ8pQ2w+8Qpnrscoy7Ge62O4UoEMpoRi0
 i0haobxk1qyC2mnzrffPYmAynsM5MdXOZ87KbXgfc44ad40+uFQi566EH4he7gjBDAn2
 xX4g==
X-Gm-Message-State: AOAM532rPx9z2ErEbsLnci9j4d231wBm2Dale5rarTHbpOxr1llSIoAR
 +KgvmZHrbFIxCcmMb5hjiFd0GpynIMdTrjslG/astoUnE60y9I5ehP3bjTQ0YCz72Z8SAkjIi5z
 XgTd0cJBiOxlMuxQ1qvKDk33q3MYC+7MrKIWNGr7caw==
X-Received: by 2002:a5d:400c:: with SMTP id n12mr53078772wrp.218.1609191399099; 
 Mon, 28 Dec 2020 13:36:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2wEb3D1BWN/UONyqc2w0gJAIvl4kLQiL+4H3nvCzIRKbLME7rvRsdRCxiQ9+pTl1aaS1mKQ==
X-Received: by 2002:a5d:400c:: with SMTP id n12mr53078760wrp.218.1609191398959; 
 Mon, 28 Dec 2020 13:36:38 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id v20sm60258556wra.19.2020.12.28.13.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 13:36:38 -0800 (PST)
Date: Mon, 28 Dec 2020 16:36:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH rfc 1/3] virtio-net: support transmit hash report
Message-ID: <20201228163359-mutt-send-email-mst@kernel.org>
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-2-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201228162233.2032571-2-willemdebruijn.kernel@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org
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

On Mon, Dec 28, 2020 at 11:22:31AM -0500, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Virtio-net supports sharing the flow hash from host to guest on rx.
> Do the same on transmit, to allow the host to infer connection state
> for more robust routing and telemetry.
> 
> Linux derives ipv6 flowlabel and ECMP multipath from sk->sk_txhash,
> and updates these fields on error with sk_rethink_txhash. This feature
> allows the host to make similar decisions.
> 
> Besides the raw hash, optionally also convey connection state for
> this hash. Specifically, the hash rotates on transmit timeout. To
> avoid having to keep a stateful table in the host to detect flow
> changes, explicitly notify when a hash changed due to timeout.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/virtio_net.c        | 24 +++++++++++++++++++++---
>  include/uapi/linux/virtio_net.h | 10 +++++++++-
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 21b71148c532..b917b7333928 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -201,6 +201,9 @@ struct virtnet_info {
>  	/* Host will merge rx buffers for big packets (shake it! shake it!) */
>  	bool mergeable_rx_bufs;
>  
> +	/* Guest will pass tx path info to the host */
> +	bool has_tx_hash;
> +
>  	/* Has control virtqueue */
>  	bool has_cvq;
>  
> @@ -394,9 +397,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  
>  	hdr_len = vi->hdr_len;
>  	if (vi->mergeable_rx_bufs)
> -		hdr_padded_len = sizeof(*hdr);
> +		hdr_padded_len = max_t(unsigned int, hdr_len, sizeof(*hdr));
>  	else
> -		hdr_padded_len = sizeof(struct padded_vnet_hdr);
> +		hdr_padded_len = ALIGN(hdr_len, 16);
>  
>  	/* hdr_valid means no XDP, so we can copy the vnet header */
>  	if (hdr_valid)
> @@ -1534,6 +1537,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  	struct virtio_net_hdr_mrg_rxbuf *hdr;
>  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
> +	struct virtio_net_hdr_v1_hash *ht;
>  	int num_sg;
>  	unsigned hdr_len = vi->hdr_len;
>  	bool can_push;
> @@ -1558,6 +1562,14 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  	if (vi->mergeable_rx_bufs)
>  		hdr->num_buffers = 0;
>  
> +	ht = (void *)hdr;
> +	if (vi->has_tx_hash) {
> +		ht->hash_value = cpu_to_virtio32(vi->vdev, skb->hash);
> +		ht->hash_report = skb->l4_hash ? VIRTIO_NET_HASH_REPORT_L4 :
> +						 VIRTIO_NET_HASH_REPORT_OTHER;
> +		ht->hash_state = VIRTIO_NET_HASH_STATE_DEFAULT;
> +	}
> +
>  	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
>  	if (can_push) {
>  		__skb_push(skb, hdr_len);
> @@ -3054,6 +3066,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	else
>  		vi->hdr_len = sizeof(struct virtio_net_hdr);
>  
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_TX_HASH)) {
> +		vi->has_tx_hash = true;
> +		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
> +	}
> +
>  	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
>  	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>  		vi->any_header_sg = true;
> @@ -3243,7 +3260,8 @@ static struct virtio_device_id id_table[] = {
>  	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>  	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> -	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
> +	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> +	VIRTIO_NET_F_TX_HASH
>  
>  static unsigned int features[] = {
>  	VIRTNET_FEATURES,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 3f55a4215f11..f6881b5b77ee 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_TX_HASH	  56	/* Guest sends hash report */
>  #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
> @@ -170,8 +171,15 @@ struct virtio_net_hdr_v1_hash {
>  #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
>  #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
>  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> +#define VIRTIO_NET_HASH_REPORT_L4              10
> +#define VIRTIO_NET_HASH_REPORT_OTHER           11

Need to specify these I guess ...
Can't there be any consistency with RX hash?
Handy for VM2VM ...


>  	__le16 hash_report;
> -	__le16 padding;
> +	union {
> +		__le16 padding;
> +#define VIRTIO_NET_HASH_STATE_DEFAULT          0
> +#define VIRTIO_NET_HASH_STATE_TIMEOUT_BIT      0x1
> +		__le16 hash_state;
> +	};
>  };
>  
>  #ifndef VIRTIO_NET_NO_LEGACY
> -- 
> 2.29.2.729.g45daf8777d-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
