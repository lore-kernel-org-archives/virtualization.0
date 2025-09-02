Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7735AAB7
	for <virtualization@lists.linux.dev>; Tue,  2 Sep 2025 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848707; cv=none; b=KARerCsoKoOOAcWfFpxwZQPJFkJQQ9spfPgqi8Cx4q5v3Q2zXaEprAHAl85HlSHGv6Ndfznag3CLBwJ7Go72VaZX4WttsA1IFYByJDvYFHYRaYXs781XApTDOkDkCi6zedmxrjpezmzeHT4NBmkKAend++IAZHXUdlEVoar/XF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848707; c=relaxed/simple;
	bh=Fhr1X2s81mKv666A5gstY8vVQTMahtF+o9XOsgjlsEU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HpQ7xZdgUTDCbzqBTISI/Ea0Z7qPkVdO2KtUI78txDtDg8dcDwnN0VoWRsGeuUOq0l5in0I/nCHv/ErJ2p2yFEUcl7RItAevnLlVlJfwgxtl6wYW3Y8n6cmrj3Nmu4b9jcVGranxuYwSlhJKwXElcsyo0BhiaQn8qqI33z+cF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHdCvOUJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHdCvOUJ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70ba7aa131fso65404456d6.2
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 14:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756848704; x=1757453504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ccBuzbs+BrHDDKe4TyRzIoAM5cAJ6pCAgSin1bdA9A=;
        b=XHdCvOUJAHZBESv3Gbz4L1BBAmw5bTuzKmPtBcaocW1dWwEmYiUw+QNQ15HNAfrIgt
         pSFsISqo3nWIi4Yufj2H526ZEMO0d0J4tQZ4X/kCWr+j0yLfI+CQu3bps5Yc5zRwH/0C
         SNr2WggGqdxdD3BJF/S+swCWErfGqM3J6wruaNwT8fy9W9nRHn+PwVNrlzWM4QQL22xE
         5lEcRUWOp5b4zVow7C07vfI5wakxUKJo0I/FYTc4FKfXqKCWs8nhErHx9wqbz0TXvxWa
         bTgKCIbwVy+pedxnOInvkcq6CQI8Q8T1CYYbUNr9mEhehunmlMFaIi6kXJ5xyB5QD9z2
         u+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756848704; x=1757453504;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5ccBuzbs+BrHDDKe4TyRzIoAM5cAJ6pCAgSin1bdA9A=;
        b=Zp/pB7F4yTXY9e0r7gU0flpX05LKNJgigGXHUGVTCgv0zJmAi7cQ1kfgSZGi4DLh9u
         Z/01RuK3lh8bUdo9xlyOaowUq9FwPAroU1nXAJm5XE44ennkeNrfCdrL1Wbt8Uq7Btmj
         oUuy85jJL5hc+jN+EPo0AA1o8SyWGZIIWsliETxSN81VwxbUARxONmLyOGl5A99lv6IG
         8690oBXPMLT0dv0VEh3eyu/ToAgvYkGBguOkK+e1iBPwi3YCMMLIMDbqvy6WdgsII9dJ
         E7Cfaw+nGa8yhM1yfFsgwZ3BD6fI/6sKp8AYg5G3kfTC90Mh0s1KcL1/NrLVoHTvsuUe
         lP+g==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZdVjmHdT9xpVJlMTJ4I0RCgRix/zPWcwfzE08ykU1JfRZxOMhxZOLhfgUUFMckvqrf+u+9buy+GbvaLR9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0GbKhx5b55EDUO2KTR20cpetxFRldnwfWU347naz5ISLhUUQD
	2VL8xwAlzqaEEItxHDJMZ4nKRT4vxMRT6dkl25GhHAwC7EfsLbNF50B8
X-Gm-Gg: ASbGncvL6oyQjyr/ss36AhqyGnm1UIWGdetU9PRBwLI4vUhh/eN4bDsWpqwM6SPPYiV
	p9AZffzdBCcJY2Sc8wOCM264FK1R9rLI5t4LYWillefUV1xbcWZ2TfljWOqE6H9BJKEAE5qJlyT
	wTVxUbD1v0IsGyTdBAnhWtUJwz4G8X/WAdr9dkjYTjIY6THdWJyWwnhOoFH11X+2GQFnVV9vRH6
	rxpO5cHebXeWWB3UipdeS/lBisiA/w2FSssSzJ20q5ENdqUYj4OUpOfzRlzy47Qa6itznPrSsqI
	dJ4PuDX/GgTHTkfaRnNrQIRLOd4xNey2BrqIu7OBSYKZzI4QG2Ivx+NJFD/kxVayV40yfn/4J0S
	UQdOtn2WqR7rKOl+khWdbVVK3kSM0qNIichKALDze57DiNOT+L954JZiimmZol7zDRxxKcAt8z6
	qQGg==
X-Google-Smtp-Source: AGHT+IHuSLao98z09CKcRFnRmWQxJ8TrKeoPQyY4lPLQgQdvitTmSna4yO9Wv7pVlwi66WpRyj7GFg==
X-Received: by 2002:a05:6214:1925:b0:721:7a6a:b703 with SMTP id 6a1803df08f44-7217a6ac7ffmr26477986d6.53.1756848704343;
        Tue, 02 Sep 2025 14:31:44 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-720b644f2c9sm18578666d6.63.2025.09.02.14.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:31:43 -0700 (PDT)
Date: Tue, 02 Sep 2025 17:31:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 stephen@networkplumber.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, 
 Tim Gebauer <tim.gebauer@tu-dortmund.de>
Message-ID: <willemdebruijn.kernel.1b33a2385592@gmail.com>
In-Reply-To: <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
Subject: Re: [PATCH 2/4] netdev queue flow control for TUN
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Schippers wrote:
> The netdev queue is stopped in tun_net_xmit after inserting an SKB into
> the ring buffer if the ring buffer became full because of that. If the
> insertion into the ptr_ring fails, the netdev queue is also stopped and
> the SKB is dropped. However, this never happened in my testing. To ensure
> that the ptr_ring change is available to the consumer before the netdev
> queue stop, an smp_wmb() is used.
> 
> Then in tun_ring_recv, the new helper wake_netdev_queue is called in the
> blocking wait queue and after consuming an SKB from the ptr_ring. This
> helper first checks if the netdev queue has stopped. Then with the paired
> smp_rmb() it is known that tun_net_xmit will not produce SKBs anymore.
> With that knowledge, the helper can then wake the netdev queue if there is
> at least a single spare slot in the ptr_ring by calling ptr_ring_spare
> with cnt=1.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index cc6c50180663..735498e221d8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1060,13 +1060,21 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	nf_reset_ct(skb);
>  
> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +	queue = netdev_get_tx_queue(dev, txq);
> +	if (unlikely(ptr_ring_produce(&tfile->tx_ring, skb))) {
> +		/* Paired with smp_rmb() in wake_netdev_queue. */
> +		smp_wmb();
> +		netif_tx_stop_queue(queue);
>  		drop_reason = SKB_DROP_REASON_FULL_RING;
>  		goto drop;
>  	}
> +	if (ptr_ring_full(&tfile->tx_ring)) {
> +		/* Paired with smp_rmb() in wake_netdev_queue. */
> +		smp_wmb();
> +		netif_tx_stop_queue(queue);
> +	}
>  
>  	/* dev->lltx requires to do our own update of trans_start */
> -	queue = netdev_get_tx_queue(dev, txq);
>  	txq_trans_cond_update(queue);
>  
>  	/* Notify and wake up reader process */
> @@ -2110,6 +2118,24 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	return total;
>  }
>  
> +static inline void wake_netdev_queue(struct tun_file *tfile)

no inline keyword in .c files, let the compiler decide.

> +{
> +	struct netdev_queue *txq;
> +	struct net_device *dev;
> +
> +	rcu_read_lock();
> +	dev = rcu_dereference(tfile->tun)->dev;
> +	txq = netdev_get_tx_queue(dev, tfile->queue_index);
> +
> +	if (netif_tx_queue_stopped(txq)) {
> +		/* Paired with smp_wmb() in tun_net_xmit. */
> +		smp_rmb();
> +		if (ptr_ring_spare(&tfile->tx_ring, 1))
> +			netif_tx_wake_queue(txq);
> +	}
> +	rcu_read_unlock();
> +}
