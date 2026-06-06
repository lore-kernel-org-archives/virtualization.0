Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCED4071FE
	for <virtualization@lists.linux.dev>; Sat,  6 Jun 2026 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780735221; cv=none; b=XMO39AUQvOEn1KUpF6PKVC808lqohphXVk8YNpmjdnvyKcJCOSZQdh0ZehDMuxKNZ2pzUed2cimneSQmKdyBerHp/BIbj3a7gyOYhjqAbaaKP2PRkLqqSt2HzdR5foLyK2XuEYJi6uiNsy+KKT3L+PxL84xB1d6DPcPsa37nUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780735221; c=relaxed/simple;
	bh=rkhKQS89b50kiu4B39caolckRfcM07Ahq3gjWequ89o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ha4u50tDN0+nbDUqvGze4tn1M/0AVcJ4gXueFMzesIfBmsDNLR3vLvNhiqxmNd+5jjQQnblVvdxGBcf+3UQb0jOy7qz6KecSJ7i5EktlbGYzjPfXr5ahpePzTiOXjG9B7Oh+fET3ozRPQIIyQPGh+cnwEpG8W+FWOHF939Uuxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7WVlZyZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7WVlZyZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780735217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6a8D6PKyj3T42BmGkn1gN/k2Pm8r+kvs7tG5TWxDMy0=;
	b=K7WVlZyZYA0Oz3OMm7AyRTcA4bsuOBHwH1Km0uPZ7EogmFtvwR6h7UfyD8OihWh6HpT0cc
	hW4qPeKE96+jMw5fSvbewtjzc8XqwzSFb+x6S7fYPYe85aX68vY8xy0HStrmNSOA9efO1Z
	L5cDyve9/q0MKY8v6IcuJm/G5K7PSmc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-f87jrVUPOZ-7YN2CJ28Zkg-1; Sat, 06 Jun 2026 04:40:16 -0400
X-MC-Unique: f87jrVUPOZ-7YN2CJ28Zkg-1
X-Mimecast-MFC-AGG-ID: f87jrVUPOZ-7YN2CJ28Zkg_1780735215
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b93debc8so21590355e9.1
        for <virtualization@lists.linux.dev>; Sat, 06 Jun 2026 01:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780735215; x=1781340015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a8D6PKyj3T42BmGkn1gN/k2Pm8r+kvs7tG5TWxDMy0=;
        b=TtC9Sq3oScAigLOjSB5fyKtaue/Nu2zAsGWUwk3U2kziwa+DSPEWs1iHNR728eGCx8
         nFVvPS67HXFM+mPhUWMBy1CHQ7ev3zdUI6d99/Xwb8N4WOjijf1t23QuJm5ocPwVjm8c
         vQNFDSJOFlf60vQv1GIkoJYbtC3rmO8hFyR0uk6KqEAcoa/ryaWGIPNiSjWj0PadLcMs
         bjJmvwNHHijrA3k0KSGQ+vr+El+mjjML0573OERP5sAXfp50MrWuwwA4VD/Z958E6ZGJ
         D8gbtQFb6+XxgBCfC+M+/qUlkpRUQ7zdimKaiZp/6IfiqUJbmcjnQaa1bhZAmDB47TuQ
         QgdA==
X-Forwarded-Encrypted: i=1; AFNElJ+Y9sFF213MXvfLPonWT18pd/VV6v5K+zSr5UT9UrwUPHmtKd6+ZPaaSGY2I9YdMe+Gf6hj43D0UmAGpFA6yA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIJG9IhifkEu/GdXSq7RSyhnTap8Ds6Nn4ILE45CNvWbccn3Qd
	DtNEcqpuPSeHeFxNmxcXp3qpTAtkHHJfDPqGKTvyE6jUEZm5qa+v+0GjPJiI170ix6it1fHYVH9
	tRXHKrQJCvEwjyv5ZkuBkWSimTaMQrc7veUbYa8T+hOAtEKk72QaI9Kj0bslLfQFaQh8K
X-Gm-Gg: Acq92OEbUF15VYP+q8Vrjlf6L7ZExJQ2O+fTQsNw3NenKNOScuM7fQUQdXRdtFhYX/2
	d2xJHV2sm6sgUxgOwluFPHuCz8ROe4CoxZRiSrzmUtzbzMpdf3jRrZz8nn78rPaMNE4Kxz6z+6z
	ivL3eF62f8paOTMU7/VuV0YLLlC213cHUd+uxaeh7Bk80HxWvZVfW8ns0JypPDcyrMqnAzGvBlH
	9tZjG1n93wvazXavVJoi8xwNUHvUQ9wENwjD5OwvT95FSOpF9+RvSfphIf1wAFRvMR9czAuWF4N
	VyVlK3plxV8u1HO1KB1cC7Ct8KasQ4H5avNRc7qXAa0lgpcSCsfa3cAC9LEjv2hWt07UuJt6QoK
	xMujar+ITgrs9vFCAXqSmN8k=
X-Received: by 2002:a05:600c:628c:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490c25a87f5mr107060625e9.9.1780735214988;
        Sat, 06 Jun 2026 01:40:14 -0700 (PDT)
X-Received: by 2002:a05:600c:628c:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490c25a87f5mr107060075e9.9.1780735214457;
        Sat, 06 Jun 2026 01:40:14 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm222765095e9.13.2026.06.06.01.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 01:40:13 -0700 (PDT)
Date: Sat, 6 Jun 2026 04:40:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO NET DRIVER" <netdev@vger.kernel.org>,
	"open list:VIRTIO NET DRIVER" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_net: normalize non-positive napi_weight values
Message-ID: <20260606043757-mutt-send-email-mst@kernel.org>
References: <20260605194045.2625610-1-sam.moelius@trailofbits.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260605194045.2625610-1-sam.moelius@trailofbits.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pMHEEcgGXQjYl_gwwg2-FyIeXgM9mlsTOe5kjdd9B3U_1780735215
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2026 at 07:40:44PM +0000, Samuel Moelius wrote:
> The virtio_net.napi_weight module parameter is signed and is copied
> directly into the RX NAPI weight after netif_napi_add_config().
> 
> A value of -1 lets virtnet_poll() run with a negative budget.  The RX
> loop processes no packets, the unsigned received-vs-budget comparison
> completes NAPI, and the NAPI core reports:
> 
> NAPI poll function virtnet_poll returned 0, exceeding its budget of -1
> 
> The device then repeatedly drops receive progress under stock QEMU
> virtio-net traffic.
> 
> Normalize non-positive values to the default NAPI weight before
> assigning the RX and TX NAPI weights.  TX NAPI can still be disabled
> through the separate napi_tx parameter, which intentionally sets the TX
> weight to zero.
> 
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>


Why should we bother working around admin errors in the kernel?
Leave it for the userspace tooling which can at least provide
useful diagnostics.

> ---
>  drivers/net/virtio_net.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..667026607cfa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6481,6 +6481,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  static int virtnet_alloc_queues(struct virtnet_info *vi)
>  {
>  	int i;
> +	int weight = napi_weight > 0 ? napi_weight : NAPI_POLL_WEIGHT;
>  
>  	if (vi->has_cvq) {
>  		vi->ctrl = kzalloc_obj(*vi->ctrl);
> @@ -6500,10 +6501,10 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>  		vi->rq[i].pages = NULL;
>  		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
>  				      i);
> -		vi->rq[i].napi.weight = napi_weight;
> +		vi->rq[i].napi.weight = weight;
>  		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
>  					 virtnet_poll_tx,
> -					 napi_tx ? napi_weight : 0);
> +					 napi_tx ? weight : 0);
>  
>  		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
>  		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
> -- 
> 2.43.0

