Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92F305684
	for <virtualization@lists.linux.dev>; Sun, 21 Jun 2026 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782081096; cv=none; b=hxVTVi4Po7Bd2H8xpGPiK6bpN/Evsi6KLZ9t2YD6MDX/qhkk0FgPqq3jY1NANE2fqLl6xsOfOHabVTg7EXSypwrxUBs6AB8mHF7BYa99yA/xP1UNHQasHAgDHwNBdL0LETpJolxFQnrvdnzzNVpMMdjLttiA3X7Wy7VAJ24shZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782081096; c=relaxed/simple;
	bh=gak6u5xVNKNtPy9SyiZwr828na6uRPsG4KNYGmdyl5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YOsrekuT6hQhHd+UWZYAz1emVq0zQNOp7J1y6ScU+bP5hbt2UzMTwOEwtINcAQCLxVmnVslD3xxeqDSvILruO/Hah8r0b8yxfQBDmrmGLj4na1E4jV2Q74lMBpIxS9BNUzDIP2sFyuuYqR4YeGkXp3kdDUdLA1+ZRS7ZxepFh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZmcz6vn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZmcz6vn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782081093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3hT6b+62UwE6IrhyySHAzdMAZ/HMl2D61nk6Amr5cc=;
	b=dZmcz6vn7AFKTIraII/bf2sh5mwR0+ZYf5mJETzQJQDfQcd2tb9PpFTfG89RCXdMdIJ+dw
	ipHaARthpSmm5S7aKQs+FyZQ4uQC7Lz58J5yiMMVYudDQC7ZYWYf7s/TOScsAJk5nY2v89
	OlgNmvrTDKvRZUEmS2YpmKUkGIwXBE0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-4mLukFCCPYuyHB9sulcAuQ-1; Sun, 21 Jun 2026 18:31:32 -0400
X-MC-Unique: 4mLukFCCPYuyHB9sulcAuQ-1
X-Mimecast-MFC-AGG-ID: 4mLukFCCPYuyHB9sulcAuQ_1782081091
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-469218e618dso131364f8f.2
        for <virtualization@lists.linux.dev>; Sun, 21 Jun 2026 15:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782081091; x=1782685891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3hT6b+62UwE6IrhyySHAzdMAZ/HMl2D61nk6Amr5cc=;
        b=kwTOa3Pz5DyJjOA4cV8b7t36SBjJV30jSJlkEylhJHs1OyAa0HL3YE2diULJMFC/2Q
         GC07Lyb/UZSYPRiQigkhYGRqpZvuSfF5iGKdQqYHcYRxjdUeXT1eVbE8FuSE5CgI5owD
         mR7n4cf+t2lNe+7okhN10A+U8bU+/cix/6KD5pJ/kM/7d+Ilqm8nixMEqdpBD+fVmNqn
         6d5i7ZtV8+ANfDDPhPFfVXae2St8T9eP008ALGp4yJiUZfPj2M9Na+Qky8zVLv76X6VX
         hNhIOnN3Zrvlszr5pm/iv4AYXTxcUaluDr3ULR6aBNZZlfEzEx92dZbktZglkXxtHuZg
         TP5w==
X-Forwarded-Encrypted: i=1; AFNElJ9FktBLKml7jaWJgfOda9gZlRj6kZbu7ibedVKOyzh/86Mt908kBgM95gxAvfalGahAnM2M0Ge7M0gjMJKP+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyycAQasySTfKYDc3feW2BaNMRYjGn/Z4EubuQ8HkS5BKcYMCsw
	oK9NKgTaKqdZhAUa3+iZIRD0zaiDE2Jg+4aWNC0E0Fvtl+W1AuFxNebzneGkiZ3g/00Re1u3YM+
	I2Apw/xweqoJJwcWq6B/KsKkUsfY+oQwVl0/PC8UsHY4vjcziLKW83JNag8uGoRQq1zI6sJStQG
	gm
X-Gm-Gg: AfdE7ckOyQQOcYp4BUZ8x/J3CNyu4BZ9vUsYnLeWW72Vhms+v3ZYKO+I+2s/GaaHMwr
	3AAZ+IN69ielFYO9Upo7D9dI4Gjk0OJZUDVDpArpejzadZYJ6ebkdaFG9VQsNq1nzy/ZCtlftE4
	18jSe/3fyT5QKv/VJ+eExNXE/z/fADl4MGuNt7vKHFVpZoJX7ZcRMK+Cd2biKKWaf0SatMhFjsx
	DbfKwOXzFb6OTPJm//F9sZKHBDYPv0/HrMHRo9Z4T2NzZZGtuX/zQ6cogmDNuQXvc59GxxYZQfu
	qGrshisU7U7wHLlbGRoXgprlvhO1+ZKyqsYce1T1MvVIpQK7vVy/U6UiaiW23gfkLJDdKosVxAC
	0IZ/+oj6nf83qTDzekEn2T3jQ1HEpqxFv
X-Received: by 2002:a05:600c:3550:b0:490:e913:6564 with SMTP id 5b1f17b1804b1-49249083bf1mr121077945e9.3.1782081091024;
        Sun, 21 Jun 2026 15:31:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3550:b0:490:e913:6564 with SMTP id 5b1f17b1804b1-49249083bf1mr121077755e9.3.1782081090605;
        Sun, 21 Jun 2026 15:31:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f563dsm18451019f8f.3.2026.06.21.15.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 15:31:30 -0700 (PDT)
Date: Sun, 21 Jun 2026 18:31:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Message-ID: <20260621182119-mutt-send-email-mst@kernel.org>
References: <20260616115912.513183-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260616115912.513183-1-dongml2@chinatelecom.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E15K0UmD-3N7sxdlJVm7TvEaO9HAvrb0hVTRnZkV9d4_1782081091
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 07:59:12PM +0800, Menglong Dong wrote:
> For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
> in the tx path for example: we set xsk_set_tx_need_wakeup() in
> virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> anywhere, which means the user will call send() for every packet.
> 
> We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
> is empty, as we can't be wakeup by the skb_xmit_done() in this case.
> Otherwise, we will clear the wakeup flag.
> 
> Race condition is considered for tx path.
> 
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

thanks for the patch! yes something to improve.

> ---
> v3:
> - remove the confusing comment
> 
> v2:
> - add the Fixes tag
> ---
>  drivers/net/virtio_net.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..6e099edef6e9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1440,8 +1440,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	struct virtnet_sq_free_stats stats = {};
>  	struct net_device *dev = vi->dev;
> +	int sent, vring_size;
> +	bool need_wakeup;
>  	u64 kicks = 0;
> -	int sent;
>  
>  	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
>  	 * free_old_xmit().
> @@ -1451,8 +1452,25 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	if (stats.xsk)
>  		xsk_tx_completed(sq->xsk_pool, stats.xsk);
>  
> +	vring_size = virtqueue_get_vring_size(sq->vq);
> +	need_wakeup = xsk_uses_need_wakeup(pool);
> +
> +	if (need_wakeup && vring_size == sq->vq->num_free)
> +		xsk_set_tx_need_wakeup(pool);
> +

why are we doing this here?
the check after virtnet_xsk_xmit_batch not enough?
I vaguely think it's some kind of race we are closing?
Pls add a comment to explain.

>  	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
>  
> +	if (need_wakeup) {
> +		if (vring_size == sq->vq->num_free)
> +			/* we can't wake up by ourself, and it should be done
> +			 * by the user.
> +			 */
> +			xsk_set_tx_need_wakeup(pool);
> +		else
> +			/* we can wake up from skb_xmit_done() */
> +			xsk_clear_tx_need_wakeup(pool);

But what if we don't have get tx napi so no wakeup in skb_xmit_done?


> +	}
> +
>  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
>  		check_sq_full_and_disable(vi, vi->dev, sq);
>  
> @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	u64_stats_add(&sq->stats.xdp_tx,  sent);
>  	u64_stats_update_end(&sq->stats.syncp);
>  
> -	if (xsk_uses_need_wakeup(pool))
> -		xsk_set_tx_need_wakeup(pool);
> -
>  	return sent;
>  }
>  
> -- 
> 2.54.0

