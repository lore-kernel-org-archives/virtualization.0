Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634C2E7F0A
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571619; cv=none; b=lS3QqJPSsFLcp1PN3BaV2ni3e60FnOGIItOXOMsIXtqzyG4TEuUXUoaTznYh0QFvE9qj7qAh14x2cxIi5FrCbkM3SRyLJUNvDmjc7KNOlaAdPkiBKc4Y16xo77hMo97Rpi5qAjbDEfMFk5rKt8vmLL7uIvU36NJlMJKYp3sKjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571619; c=relaxed/simple;
	bh=oYrwPO86ZCxudCbsRZuqfzHLWeJAOAoyrphKxk8LHjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Es1Bv24j1gwOUkZkrEtDh2GSALmzPXWNlM2gM+yHc4WkKZj/B/6az3sCMaybe4qxQcCj6vlL3AftpaVx3yN1tU+N7D0WpIDP/PoABE43YhId9dCVbocFhl8tnyWsh+kBYNqfGOOotqJHYxBZvt/gmo7j7QB0MOrI+et5n6+DyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3kpaFEQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3kpaFEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766571616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6O2EtwV8zLDpt91a2UuKYvEZqcHN8Sgzg6sMdCfF3b8=;
	b=X3kpaFEQ9r8/LPJItKyaU7unz+v6wFYxphUFVvDn8u9ZdJZPQd/86Bz9g1D4hCD7Uo/81K
	EXBrwU79+/8FUSy/USanI8+g2OZeLE4AIj2S97pL5UjkVGyCz/3zK9ROVrNFIU3JUi5gWi
	NTRW9Lpju4IFIva00GXgp9lTJx5ANYs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-ReRCGX14OZeq9iZ3DBOK8g-1; Wed, 24 Dec 2025 05:20:14 -0500
X-MC-Unique: ReRCGX14OZeq9iZ3DBOK8g-1
X-Mimecast-MFC-AGG-ID: ReRCGX14OZeq9iZ3DBOK8g_1766571613
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d40e8a588so448775e9.3
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 02:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571613; x=1767176413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6O2EtwV8zLDpt91a2UuKYvEZqcHN8Sgzg6sMdCfF3b8=;
        b=L4ku52M/bV1or3lFiopttcrfypIf4qvHO+fVU1Q48vDmzpGOBhagDfzEfg3R7MPCPl
         Wr/NLVbHkWzAs6Kdh0GVQAq3y8TVZ01Zijolb1TsYN1y2pCq/NSOCDBs41mXRZpzEB4J
         p7HbU2D9G/OaLHJdzxKKnbMgKM1YlUYMFdFXgmqNHkqoMbpdKiy+PzHykjM6n3U4ids0
         JFWsvoROUa4RM2CXINX/Pum6nKX0kXEkG9YIBs1TxkWBfmKBkHrgj2B6xQwdAo90XUvv
         jYYAaFJUq5Ax7IH3a6CuReOuD6UPiZacSwir83ZSPhnW6e9fAmhz7gPRx1RmT1tn9YhI
         Zg9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqHh6wOuaVP6WeLHC30WfoMYfHd0GRMvnol4UO763hPwV1YZSSfyYz/oPBNub1yh7MOAvQJDGf1RJTXBrnIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDMny0FNs5Z8nrkgxaLKr9VSQW/1GGDN3M1t9dNFcmKn2quLTI
	rDqfXWJi9Gdd03adB066kKonShm1bnbXz0BxnjGOc8MWDTwEGX8gRgabfAB5Io1QLfcvadIL1dn
	4qrgYk7gqrxv8b2eaa/1ofgGQKhWbVIgPpf7igC8lwHWfwEy2TSYYrQLoG6KEpHwDham6
X-Gm-Gg: AY/fxX6xyL2i83bsV48XPiF0AEZ5noGrbfpyeXuHj4D11/cImVcUyNny2/cDPJNcYvq
	NdpY3KrY51AQfLUwNdoOukwftPY/Mwv3wDhUbLG9rMTGM71P2PUOQnUWucMxNhET0SOU3IOq46y
	WXxg0BGPaCYk7LYoxRIr0jSNrK4asZv78xjy+GOOkUPpU2Yu1i3bAk+OOkaK5vyYnAK7qdgEnAM
	tT7XfiHs28vAh5D3HGDvep/Id9EXqL95ZxOG754AKsUXMsfrJVAZ3MpiHTRgD2bRD3S3mW4VenL
	m4aZrhuF5VYQrsUr1u8njEJaZZZ72urknGYDL7SiA32VizKjNhDKCb44rT4ANr7ZQIUHbzf7zl+
	G
X-Received: by 2002:a05:600c:350c:b0:477:7658:572a with SMTP id 5b1f17b1804b1-47d19584900mr150239485e9.20.1766571613426;
        Wed, 24 Dec 2025 02:20:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmKYK5ou+1W1Pze+hjbzHTs9SfZ3rn+HzocgNknKunmQm1zT8c7gWFoIrC37NzpjjUkVO+xA==
X-Received: by 2002:a05:600c:350c:b0:477:7658:572a with SMTP id 5b1f17b1804b1-47d19584900mr150239105e9.20.1766571612873;
        Wed, 24 Dec 2025 02:20:12 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a40a14sm146641555e9.2.2025.12.24.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:20:12 -0800 (PST)
Date: Wed, 24 Dec 2025 05:20:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net 2/3] virtio-net: ensure rx NAPI is enabled before
 enabling refill work
Message-ID: <20251224051936-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-3-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251223152533.24364-3-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PVe4MsPOA8kUpW3EIDeLspMh0Q2tMqlQ-6MRuJInptE_1766571613
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2025 at 10:25:32PM +0700, Bui Quang Minh wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock.

a deadlock?

> Because the delayed refill work will call napi_disable(), we
> must ensure that refill work is only enabled and scheduled after we have
> enabled the rx queue's NAPI.


a bugfix so needs a Fixes tag.

> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 63126e490bda..8016d2b378cf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3208,16 +3208,31 @@ static int virtnet_open(struct net_device *dev)
>  	int i, err;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		bool schedule_refill = false;
> +
> +		/* - We must call try_fill_recv before enabling napi of the same
> +		 * receive queue so that it doesn't race with the call in
> +		 * virtnet_receive.
> +		 * - We must enable and schedule delayed refill work only when
> +		 * we have enabled all the receive queue's napi. Otherwise, in
> +		 * refill_work, we have a deadlock when calling napi_disable on
> +		 * an already disabled napi.
> +		 */
>  		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
>  			/* Make sure we have some buffers: if oom use wq. */
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->rq[i].refill, 0);
> +				schedule_refill = true;
>  		}
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
>  			goto err_enable_qp;
> +
> +		if (i < vi->curr_queue_pairs) {
> +			enable_delayed_refill(&vi->rq[i]);
> +			if (schedule_refill)
> +				schedule_delayed_work(&vi->rq[i].refill, 0);
> +		}
>  	}
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> @@ -3456,11 +3471,16 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  	bool running = netif_running(vi->dev);
>  	bool schedule_refill = false;
>  
> +	/* See the comment in virtnet_open for the ordering rule
> +	 * of try_fill_recv, receive queue napi_enable and delayed
> +	 * refill enable/schedule.
> +	 */
>  	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_refill = true;
>  	if (running)
>  		virtnet_napi_enable(rq);
>  
> +	enable_delayed_refill(rq);
>  	if (schedule_refill)
>  		schedule_delayed_work(&rq->refill, 0);
>  }
> @@ -3470,18 +3490,15 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
>  	int i;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
> +		if (i < vi->curr_queue_pairs)
>  			__virtnet_rx_resume(vi, &vi->rq[i], true);
> -		} else {
> +		else
>  			__virtnet_rx_resume(vi, &vi->rq[i], false);
> -		}
>  	}
>  }
>  
>  static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  {
> -	enable_delayed_refill(rq);
>  	__virtnet_rx_resume(vi, rq, true);
>  }
>  
> -- 
> 2.43.0

