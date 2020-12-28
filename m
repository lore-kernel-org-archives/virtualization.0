Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A46FC433E0
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 17:29:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC90229C4
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 17:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC90229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 33D3386FDC;
	Mon, 28 Dec 2020 17:29:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FrmqHf3Cv9tN; Mon, 28 Dec 2020 17:29:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6259C86FC7;
	Mon, 28 Dec 2020 17:29:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 367D2C0893;
	Mon, 28 Dec 2020 17:29:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB3BDC0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BF39281C8D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sunORXx4VsL9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:29:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DDDD481AE8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609176538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gGvJqem7a81M/b2pl+4LUjnrCUZWKh0z89Pf1v3aCwI=;
 b=R8FIHGR8u5zkNO5yoQ5zm5ki2P/ZgBThLFjh1WiNprP+zZSRzWJpRN7AwXfx5wgJmfog4k
 cC8LoluZsOEFFe4+Rq2Wad96choFpa7yUCuPs49kGEY7nU86xDbEU/so9fGNOPJftU+0Ab
 D2MU0empYZfT5V3ocTYYgTCq549Nlhg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-Ap83pk3UObGLFy3GCBlGlA-1; Mon, 28 Dec 2020 12:28:57 -0500
X-MC-Unique: Ap83pk3UObGLFy3GCBlGlA-1
Received: by mail-wr1-f72.google.com with SMTP id i4so6596114wrm.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 09:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gGvJqem7a81M/b2pl+4LUjnrCUZWKh0z89Pf1v3aCwI=;
 b=jfYTi310PGLG8NVRWaByV3lOzq23lyHrvf3Pp/Fokj4EPU0lleLEJckg/anlZ+mocz
 H+sit6dMcdeS1exQz2bJmMlELvvqopEGCMGCDCyAw2JSJXwCjbEMUhA+EkTZ6SFF+P3U
 UDXyKlG+idZqv8ZljzxsZdOLH9dtWweAj/O4eP6bmm8INEmIbQCQf8cL4vjPQloTbRQA
 cEdqhCMiAg5fSAgEnyysIm5eiGybhk5iwCp5Ogam5oNUj0h87eioMOuBi13uNfPs2QWe
 KDlgUh3G6uI25PEM59EZ0sojSIyEBbCbASZBcWS7RkK8njwdiTedquEpggkH3JaHKLm6
 ZkvQ==
X-Gm-Message-State: AOAM533wOlDy8UdjE9BwN/YPYaGiCTjdEpXjtTMaHxvSlukLHpnkG3qs
 mvseo/mJvOT/GKF7Nmht/lRuL6DeDrYT18xb2McmZQagxrwW5x1fmLdH51I991FKwo0+It3Zfit
 0RkqXPC9/j6MavlbskoUUhByYLEXYU3zBaGDMyhSGOQ==
X-Received: by 2002:adf:9cca:: with SMTP id h10mr51884086wre.77.1609176535869; 
 Mon, 28 Dec 2020 09:28:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3CvROt5ur1I1l3P77PDjZ8wuWthA9/Pni/ZrE+rb1H8lj93XGC/+D+KNt3FmC+uKlTcUXyQ==
X-Received: by 2002:adf:9cca:: with SMTP id h10mr51884075wre.77.1609176535702; 
 Mon, 28 Dec 2020 09:28:55 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id a13sm53668700wrt.96.2020.12.28.09.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 09:28:55 -0800 (PST)
Date: Mon, 28 Dec 2020 12:28:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH rfc 2/3] virtio-net: support receive timestamp
Message-ID: <20201228122253-mutt-send-email-mst@kernel.org>
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
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

On Mon, Dec 28, 2020 at 11:22:32AM -0500, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Add optional PTP hardware timestamp offload for virtio-net.
> 
> Accurate RTT measurement requires timestamps close to the wire.
> Introduce virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
> virtio-net header is expanded with room for a timestamp. A host may
> pass receive timestamps for all or some packets. A timestamp is valid
> if non-zero.
> 
> The timestamp straddles (virtual) hardware domains. Like PTP, use
> international atomic time (CLOCK_TAI) as global clock base. It is
> guest responsibility to sync with host, e.g., through kvm-clock.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/virtio_net.c        | 20 +++++++++++++++++++-
>  include/uapi/linux/virtio_net.h | 12 ++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b917b7333928..57744bb6a141 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -204,6 +204,9 @@ struct virtnet_info {
>  	/* Guest will pass tx path info to the host */
>  	bool has_tx_hash;
>  
> +	/* Host will pass CLOCK_TAI receive time to the guest */
> +	bool has_rx_tstamp;
> +
>  	/* Has control virtqueue */
>  	bool has_cvq;
>  
> @@ -292,6 +295,13 @@ static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
>  	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
>  }
>  
> +static inline struct virtio_net_hdr_v12 *skb_vnet_hdr_12(struct sk_buff *skb)
> +{
> +	BUILD_BUG_ON(sizeof(struct virtio_net_hdr_v12) > sizeof(skb->cb));
> +
> +	return (void *)skb->cb;
> +}
> +
>  /*
>   * private is used to chain pages for big packets, put the whole
>   * most recent used list in the beginning for reuse
> @@ -1082,6 +1092,9 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  		goto frame_err;
>  	}
>  
> +	if (vi->has_rx_tstamp)
> +		skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(skb_vnet_hdr_12(skb)->tstamp);
> +
>  	skb_record_rx_queue(skb, vq2rxq(rq->vq));
>  	skb->protocol = eth_type_trans(skb, dev);
>  	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> @@ -3071,6 +3084,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RX_TSTAMP)) {
> +		vi->has_rx_tstamp = true;
> +		vi->hdr_len = sizeof(struct virtio_net_hdr_v12);
> +	}
> +
>  	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
>  	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>  		vi->any_header_sg = true;
> @@ -3261,7 +3279,7 @@ static struct virtio_device_id id_table[] = {
>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>  	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> -	VIRTIO_NET_F_TX_HASH
> +	VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP
>  
>  static unsigned int features[] = {
>  	VIRTNET_FEATURES,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index f6881b5b77ee..0ffe2eeebd4a 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_RX_TSTAMP	  55	/* Host sends TAI receive time */
>  #define VIRTIO_NET_F_TX_HASH	  56	/* Guest sends hash report */
>  #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
> @@ -182,6 +183,17 @@ struct virtio_net_hdr_v1_hash {
>  	};
>  };
>  
> +struct virtio_net_hdr_v12 {
> +	struct virtio_net_hdr_v1 hdr;
> +	struct {
> +		__le32 value;
> +		__le16 report;
> +		__le16 flow_state;
> +	} hash;
> +	__virtio32 reserved;
> +	__virtio64 tstamp;
> +};
> +
>  #ifndef VIRTIO_NET_NO_LEGACY
>  /* This header comes first in the scatter-gather list.
>   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must


So it looks like VIRTIO_NET_F_RX_TSTAMP should depend on both
VIRTIO_NET_F_RX_TSTAMP and VIRTIO_NET_F_HASH_REPORT then?

I am not sure what does v12 mean here.

virtio_net_hdr_v1 is just with VIRTIO_F_VERSION_1,
virtio_net_hdr_v1_hash is with VIRTIO_F_VERSION_1 and
VIRTIO_NET_F_HASH_REPORT.

So this one is virtio_net_hdr_hash_tstamp I guess?


> -- 
> 2.29.2.729.g45daf8777d-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
