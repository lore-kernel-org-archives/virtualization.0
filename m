Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD2537E9
	for <virtualization@lists.linux.dev>; Sun,  9 Nov 2025 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724576; cv=none; b=bg5Y8mmYxe5sk9JoX4w3Srf1GWI+0Et6CE4Zy0zEkaDWlWsCBLElCd+cndknNexLUO1um3WnurZ9Dk4dFRfaNOW5DuZ8SJQe83PvdLz+FPtU3AQWaqfOYCpT7KIhKSZgAZ937p/EQb0vuRPzVPa80jKOpawpGvXPTLSb/zE5PMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724576; c=relaxed/simple;
	bh=LmKB2duQIVCAvE+Z+ImdR2aiNTNb7iGVbnE+RW0CfL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FJv+hm1wF/LZPntLmpl9s+Z4e/ohP/DNkq87iaFLsPCuMNzwkhlQE+NmdeBushLNPLODHb115ZHIFnshwG8eZTyj7/mHRoWrqLlxgCW7m6zeMiLa+bXUNLLDhPed6DZhfIdRHZmxLE7ujIs49R20BbM2zTLunoffpaogX9jJ3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4hQftot; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4hQftot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762724573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6IXQ9UBlHWYywhU0Xh3V4xPK5ResoKCt5ne0jLzblXQ=;
	b=g4hQftotPKKLpfNS+bVLP8uJvu3+G05OcJB7vsBELJQaWbxsqbbP37EpLHToPhjDKItfGa
	8KXz+XML+QLpYRKxx8TuGnITNuZ9y/LgHwBpguznC5QH1quySNorw55L45ZUp/5zuTCRvZ
	sb+LYo+pXrwF4YfGOFvoG0YRTGdIXiU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-jw5r2Y9uNjijgsZEAWnD8w-1; Sun, 09 Nov 2025 16:42:52 -0500
X-MC-Unique: jw5r2Y9uNjijgsZEAWnD8w-1
X-Mimecast-MFC-AGG-ID: jw5r2Y9uNjijgsZEAWnD8w_1762724571
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775fcf67d8so20186775e9.0
        for <virtualization@lists.linux.dev>; Sun, 09 Nov 2025 13:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724571; x=1763329371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IXQ9UBlHWYywhU0Xh3V4xPK5ResoKCt5ne0jLzblXQ=;
        b=K3+jMfiqvw+miW5I8HUFfAeir+EflBp3g8w8FpEWFniFXghzdbfFOjHSgBuqaX63e8
         porgwAqWFMWMlBmdOUX9+aqBFfdoEk0RxoWCV+LW6D9eJbovxbfpSig94nwul03LK5U6
         7They9q5omlt9SGiFaEBjCesBTa5YHiD1zSWOSbeS+dJUvIpdN1/94qj3rvC0wdGrV3Y
         pM0MQN8e6/RAgmlVnO2WCt/j32y6wWRBZHVxq7qPDNpSZlGNSOvOFoyAO3sFx5Ay0qk9
         kpjYWaLENy2OV2K6csYm1s9M+vBELxl3cugf5PZegFP8RJko/jeoZADhcWPaRymoI9Q3
         hMog==
X-Forwarded-Encrypted: i=1; AJvYcCUed1xlJHwjsZ+sfWlbDKrW/NkMTY7Zread/m/6fiozidkVgbdBHbv7NqDebQyabD6vIZle6yyB5QnA37J3iA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz71x5QC2u2ap+RPYXog5WP5oOscDowVqBdBkgcQSLQobDIkB0J
	Y98zZWuckfLxa7cBolG7xKfsugmXCy+qs6LAHMoEFr1e9mBuFg6Q78SQTiNAwcIiVdGv973ZjDn
	ZudGg7v9uI2ZoLCQ8XMA3jc7zQ7aO5R8QMlVrZNux4lFLciYt3dyJkp8oKGu9TvQ4Fjya
X-Gm-Gg: ASbGncsEdUR3outESOWHzeJ+OtP6fjzUJCd6kHz0Dfc1excwgRpTV9LyvYFQfVB9Jon
	Xubx8p05jbv7nwSmq8POPZBOsdqp0FncMFuu/NPvxAwA6IGJGGlMfqvcdvJXFP0Fg0njJlJZYBg
	3927rXQp/DZH0EKtlnKcadTGum/ySN+3MfDs2wJMnc8/W+UQDtyZOHE23PtVH0hDR/iksBnWz2g
	7wlNGtoCURLCtJLKpLixQBa5I8vpPjJlz0ipgApXDzQMS5Gq2UjUU8KVe1/RBoaGKMk1mrApfzn
	y4pn20xCq9+mJj7ZTG9SvY+DgEJ42k4GfU9icWnkHNyKLeaWKqlGxv8ijAVxPBzdJMI=
X-Received: by 2002:a05:600c:c4a1:b0:471:1717:40f with SMTP id 5b1f17b1804b1-4777326eb4dmr52274035e9.22.1762724571433;
        Sun, 09 Nov 2025 13:42:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoJBOUKmXnSs/COEMtg4usMh/sEWfzcIqGkN8whiHWFiHxtB0SnSQIC6SRXRLiuUoPaGqZVg==
X-Received: by 2002:a05:600c:c4a1:b0:471:1717:40f with SMTP id 5b1f17b1804b1-4777326eb4dmr52273875e9.22.1762724571022;
        Sun, 09 Nov 2025 13:42:51 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774d3557csm97500045e9.8.2025.11.09.13.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:42:50 -0800 (PST)
Date: Sun, 9 Nov 2025 16:42:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251109164133-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SUnqShV4iTcxA3aMv3itSvOhL0pl3yylaj0sxyVZZSQ_1762724571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2025 at 11:09:12AM +0800, Xuan Zhuo wrote:
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
> 
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
> 
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.
> 
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

ca you supply some examples when this is wrong please?

> ---
>  include/linux/virtio_net.h | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 710ae0d2d336..6ef0b737d548 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -217,25 +217,35 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> +		u16 hdr_len = 0;
>  
>  		/* In certain code paths (such as the af_packet.c receive path),
>  		 * this function may be called without a transport header.
>  		 * In this case, we do not need to set the hdr_len.
>  		 */



you actually do initialize it, just to 0.
the comment is confusing.

>  		if (skb_transport_header_was_set(skb))
> -			hdr->hdr_len = __cpu_to_virtio16(little_endian,
> -							 skb_headlen(skb));
> +			hdr_len = skb_transport_offset(skb);

better:
	else
		hdr_len = 0;



>  
>  		hdr->gso_size = __cpu_to_virtio16(little_endian,
>  						  sinfo->gso_size);
> -		if (sinfo->gso_type & SKB_GSO_TCPV4)
> +		if (sinfo->gso_type & SKB_GSO_TCPV4) {
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> -		else if (sinfo->gso_type & SKB_GSO_TCPV6)
> +			if (hdr_len)
> +				hdr_len += tcp_hdrlen(skb);
> +		} else if (sinfo->gso_type & SKB_GSO_TCPV6) {
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> -		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> +			if (hdr_len)
> +				hdr_len += tcp_hdrlen(skb);
> +		} else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
> -		else
> +			if (hdr_len)
> +				hdr_len += sizeof(struct udphdr);
> +		} else {
>  			return -EINVAL;
> +		}
> +
> +		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> +
>  		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>  			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
>  	} else
> -- 
> 2.32.0.3.g01195cf9f

