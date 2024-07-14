Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87AC1B7F7
	for <virtualization@lists.linux.dev>; Sun, 14 Jul 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720942734; cv=none; b=LcgRaBGbR4e1+otT+2M4wEcXNhtWpovJ/w55+oIFv0IPygVh09Xk9dcN4+bKwlC20sq7zJcN27ukskNgPtE0gU6meuP2KHJr+dHuybLrXPG1/eXx06hf4hfTtskuyxDJNr4ueFD/UT4erZpzl3wEflwNudLiGGlLXO2yk3hVmy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720942734; c=relaxed/simple;
	bh=mURsluDMLpxNoaumQ2nTLxmmSeyyeYKTv6HWHwvKTh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sEjjBG1KmvS5cejwWVgDrus/SM98z2u0YOmzecwj/bw76Bo8JyRjXakJJABnJEiElBhhQFLaFU6Ew1kvJpe4dsemRa9V7LkfRyPsHkKGlBPkT/0uxWC1d07dxMU6dgYQTDMpNHcVcKgB0Lr/VBVngiRTei4sk3nsNdsAk5svbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIcdge7p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIcdge7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720942731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/SebrfEikJq8ECk0NytyAByK+ewDtjBFqNCZE/Bunw=;
	b=fIcdge7pLpBjldOerENh1DLED447FjCQ1ExxNLoN7yLs2DE9IUNa8jacrNf7H5zgMo7Y+Q
	HzoqfhLqsaJGpf+LkZ2E8W72ZPBaWhfaebzJJMdGneqHhRXTtVpsnZcLdUNDkW0YQ+6VfG
	PdsGhSiNIzzt4cmzlyN0YtiUh7/lZc8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-xF7_ZG97NVKsxurTc4KE7Q-1; Sun, 14 Jul 2024 03:38:50 -0400
X-MC-Unique: xF7_ZG97NVKsxurTc4KE7Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367f1dc92e3so2069866f8f.0
        for <virtualization@lists.linux.dev>; Sun, 14 Jul 2024 00:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720942729; x=1721547529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/SebrfEikJq8ECk0NytyAByK+ewDtjBFqNCZE/Bunw=;
        b=FXdQ0fmrkTULee1ue0nEiTVsBK+DSp6BOTRYplMhoLtDDzLksJYgiKhUjPqx+Coxt7
         E/l1DyjbSwtvcR1A2hLN/kEPVspy4y3nLleTyGhbwM09P0Zm7vwpt7DfM/i4JDhCuUuZ
         sr1sRuLUbvJWBbequXXnNduB3am1xZyBzEZL9bgXOThVO8VrMAAE44IHZsTbqQ6s1sPo
         f206PMMLYBWOAII2Fj6oRc2JWcr9iY7I1uQjOiFCgITrIWL4kauTjcekW0DXcA4foCJ2
         tZwTJoPb6uPkixJ8k5hA01FMV5liK1p1hH/U3dfYOHmyU6omYn2/hgmPniCr8aJ5Aapw
         2mgA==
X-Forwarded-Encrypted: i=1; AJvYcCXVFWzAGo+uiP5Mm5JP35qv9Ac9H4EE5uI+3VgpxU4Ba1d0fslymKsVIYfDqxkpokIFgNptJd2c4hKXpZlaLjIf1vuJYpXndg6WvK0XOGM=
X-Gm-Message-State: AOJu0YxGgoDBZcMNicRHKLPVhoXuq5ovIKy3XOCl7wQZJvmZxwZ4C3ck
	VVnu0aspSnuYrKcXSVpgdHDC8YGq8udLyPbM7tUIgIy+tusZUlgYl8EMiuvUxGp5IR3AqWoYQMC
	LJd6S77rQPDeTYTJkNab9E7JywTJ6CfMzDREdCE6Bh14LQB4BOjHeQMKZ2zvtDZJn
X-Received: by 2002:a5d:6885:0:b0:367:9ab5:2c89 with SMTP id ffacd0b85a97d-367cea91ce0mr8942042f8f.30.1720942729120;
        Sun, 14 Jul 2024 00:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSMMoiqQ+jKFg/wkDA5WQf1lEooI7FM/27fu/XXp8qm7yGliPIqQE2zbCOoEObLvDZvhAtXQ==
X-Received: by 2002:a5d:6885:0:b0:367:9ab5:2c89 with SMTP id ffacd0b85a97d-367cea91ce0mr8942022f8f.30.1720942728341;
        Sun, 14 Jul 2024 00:38:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:240:5146:27c:20a3:47d4:904])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db03f02sm3177735f8f.96.2024.07.14.00.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 00:38:47 -0700 (PDT)
Date: Sun, 14 Jul 2024 03:38:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rbc@meta.com, horms@kernel.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <20240714033803-mutt-send-email-mst@kernel.org>
References: <20240712115325.54175-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240712115325.54175-1-leitao@debian.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2024 at 04:53:25AM -0700, Breno Leitao wrote:
> After the commit bdacf3e34945 ("net: Use nested-BH locking for
> napi_alloc_cache.") was merged, the following warning began to appear:
> 
> 	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0
> 
> 	  __warn+0x12f/0x340
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  report_bug+0x165/0x370
> 	  handle_bug+0x3d/0x80
> 	  exc_invalid_op+0x1a/0x50
> 	  asm_exc_invalid_op+0x1a/0x20
> 	  __free_old_xmit+0x1c8/0x510
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  __free_old_xmit+0x1c8/0x510
> 	  __free_old_xmit+0x1c8/0x510
> 	  __pfx___free_old_xmit+0x10/0x10
> 
> The issue arises because virtio is assuming it's running in NAPI context
> even when it's not, such as in the netpoll case.
> 
> To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> is available. Same for virtnet_poll_cleantx(), which always assumed that
> it was in a NAPI context.
> 
> Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

though I'm not sure I understand the connection with bdacf3e34945.

> ---
>  drivers/net/virtio_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0b4747e81464..fb1331827308 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2341,7 +2341,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  	return packets;
>  }
>  
> -static void virtnet_poll_cleantx(struct receive_queue *rq)
> +static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
>  {
>  	struct virtnet_info *vi = rq->vq->vdev->priv;
>  	unsigned int index = vq2rxq(rq->vq);
> @@ -2359,7 +2359,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  
>  		do {
>  			virtqueue_disable_cb(sq->vq);
> -			free_old_xmit(sq, txq, true);
> +			free_old_xmit(sq, txq, !!budget);
>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> @@ -2404,7 +2404,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	unsigned int xdp_xmit = 0;
>  	bool napi_complete;
>  
> -	virtnet_poll_cleantx(rq);
> +	virtnet_poll_cleantx(rq, budget);
>  
>  	received = virtnet_receive(rq, budget, &xdp_xmit);
>  	rq->packets_in_napi += received;
> @@ -2526,7 +2526,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	txq = netdev_get_tx_queue(vi->dev, index);
>  	__netif_tx_lock(txq, raw_smp_processor_id());
>  	virtqueue_disable_cb(sq->vq);
> -	free_old_xmit(sq, txq, true);
> +	free_old_xmit(sq, txq, !!budget);
>  
>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
>  		if (netif_tx_queue_stopped(txq)) {
> -- 
> 2.43.0

