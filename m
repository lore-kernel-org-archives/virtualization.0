Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4F92E9ECB
	for <virtualization@lists.linux.dev>; Tue,  2 Sep 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848064; cv=none; b=muhveKlkvcdNbie3IfNNIeKzOTjciWSLv1jKZGAFJi/k/SbqtM2++JZ2wXw21fS5GVldD/X9rnzffbLAg21b8hTRzSMCfR1sqGufmAJodi5eTCfYoll+Rr/N1+KboTORSgJl9hLX3BtC+Ye6iIFaMHFNVp9xP5yhqlLiscvLyQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848064; c=relaxed/simple;
	bh=QBs0BxXPPYnVgn9eUCRqkoZcgllTusHsEqOy4VqsvVE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mxjzyXmc2RM4xjwH75mWmEMKFxBNGcipKQwKvJLq8LU1fs2JX745kgNd/loZxWlPLaAAYXPQvzbgXNROXlO+70JItYCxhPTGqEBUxC3fsT2wnR4HuRRm6xpWypLzbidMBsBflN1bcwG3XFanv4HJ0YAgCDvZT50K0KfSJkPQ36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuKy9RAN; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuKy9RAN"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54492cc6eb1so2823317e0c.2
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 14:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756848060; x=1757452860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53hIoQImPlGDst5vzPSofTSU41eeRvNanKRKYwKta0M=;
        b=NuKy9RAN5hrL31fukRS/xrPeplkc07FmGgKVvxSF8ZwH5377sh3qHOFor4TDtkyyQl
         BdN0mNv0ILPK9kFcale5PN0QZtvGtGiYYnQI6XBWSx4pL+wwOKFACAEhN66RNV+05EXg
         Y5pUWYlDu0THFxWeITxvazLph9grwNs/vcDMogpYtShPB8f3saDKsQ3sP8gRsnkM06AM
         caxXiHwwZc/mcJCHzHnuBPW6tZgyqDutrA7JaA9pMzO0ejw78aEVSl9oT9S8rCN0ABOr
         YJTI7e2AWRQSYd7spWrMNrb39ciVFNFA5+Rxr+HScU5xgf0+10qpTCuO5cqr/UuzKR6j
         K0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756848060; x=1757452860;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=53hIoQImPlGDst5vzPSofTSU41eeRvNanKRKYwKta0M=;
        b=YxjyfR7BdPek0VwB3aLARGbxlowEaJqT/qR2C21IuPi8idlcJVEbOHZGk4bgIizahY
         AKzTg1dtPpWpAcLCARYSJvJonT/7aT2ayK064PCvKpo01xEyzjxGGPLwN24O6FSfx+33
         weBcNfMor0O5d5nsfhG0lz5tmh/LD0fL2dEZ/M0GQoYirhF+9611DZh6ddNVddzMnaVS
         ubwSBHIXjPkeiKLW93zFFfY4M5LuRpnPIanE2Ru3OLp7Uh8TfGvooEhI447IYY3scMue
         6et69eLtvzUSkSOk43Zvka/ctrOHwVCbl2A/0bELA/gGi56hq3DfWHra1PIX/1jzD/p+
         kTrA==
X-Forwarded-Encrypted: i=1; AJvYcCUN4R/NRJI4XgfsnvYBSLeBm54+eafnxhDuXZhpDXO5DqTClcwEAK6qtpOzg5auSqyeD+NiqCDrZ+jn6pe0GA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1Y8ShDF8w2ByTRSUTDca3xfNSB5RjccWNwp6Z3qb96zxwqAzF
	LfpKb3Ng/RnSCOFwDzUj2mUtFNd2/4gV4/H+IHaN9KKXGhhgLFiA+Ngg
X-Gm-Gg: ASbGncuWrqs8NsG/g0Oyj1/3Dr8syPMWlgw9OJZsq2uqOVQ6QAKpUFBA95utGvvKxGD
	tuF32HPSnh2ckTqk6nbGHBQ8yIHFaCXre6LfszlxcYxXESFz0KVlxQAQ267JjfhxvCWpmgJW8+Q
	BVI0P+Por7oL6jL/uVflPgStC7PgLirciTyW6rmQzyjLDUSEUNkUQe0MHDWc7DuRrqgyRvD8PuF
	Yeml6JZStdE5OsWVBhTll2LHbVCmWG1GzvifQoSuxrmBGi2XMfHv6HXPv41o6rUeic7zkOXuK0f
	LfUUFpes70m2zc/tbp8zRTBnZvq3miqRMhqvoJLzqcyh1lQ9Sys8qxHaq0svIqar1N9gCbQzKwQ
	H7lRgd30NnFDsvHPQLyeGuoHmtQxIHmNY8B++Hwmhz0ajLnO17nJpzmK1HSRQ5I1If22znyrViA
	/dZw==
X-Google-Smtp-Source: AGHT+IHyzqCUmnLp9Lx9HtQ8SB7WTRMOJVAnPBxQrEsa8zeDDc6Qfs4QckcRDY3laJFJYg93fmf1Jg==
X-Received: by 2002:a05:6122:179e:b0:544:98a0:4869 with SMTP id 71dfb90a1353d-544a01328b7mr4149923e0c.3.1756848059787;
        Tue, 02 Sep 2025 14:20:59 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-544912eef59sm6135401e0c.8.2025.09.02.14.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:20:59 -0700 (PDT)
Date: Tue, 02 Sep 2025 17:20:58 -0400
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
Message-ID: <willemdebruijn.kernel.243baccfedc16@gmail.com>
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
> the SKB is dropped. However, this never happened in my testing.

Indeed, since the last successful insertion will always pause the
queue before this can happen. Since this cannot be reached, no need
to add the code defensively. If in doubt, maybe add a
NET_DEBUG_WARN_ON_ONCE.

> To ensure
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
> +
>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  {
>  	DECLARE_WAITQUEUE(wait, current);
> @@ -2139,7 +2165,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  			error = -EFAULT;
>  			break;
>  		}
> -
> +		wake_netdev_queue(tfile);

Why wake when no entry was consumed?

Also keep the empty line.

>  		schedule();
>  	}
>  
> @@ -2147,6 +2173,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  	remove_wait_queue(&tfile->socket.wq.wait, &wait);
>  
>  out:
> +	wake_netdev_queue(tfile);
>  	*err = error;
>  	return ptr;
>  }
> -- 
> 2.43.0
> 


