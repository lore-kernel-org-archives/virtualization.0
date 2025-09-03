Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF6302778
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905203; cv=none; b=b46dL024AeatlOMteO51IP2zuMjV0lFYwhzaAPqOVXmpP6EeAuA/uqlFBfgOVzOfuS/9AFkPuOwbl5h0vjJ43YPn3DHTADdkhZBdRDIYqKZ9FSMgqEJb8OnLKD5UKe3LElUH77artN6T15ZgMbnyL33kbokR8AuwTzx/5lrKF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905203; c=relaxed/simple;
	bh=mBGx6bKd//U8D94s4t2SoXU3lLXnSajCr2AAkuXi1ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rCHxUPTl9nYDRj3qZs8EldPa+oKR80U3jDLsc7AdXlGzcQKyuvZBcwK5h9kGQuaRuiumXnffi+to/BtnlqC7NiZB+dQ8dHY4/MvBSPAfuR4FSKDFEf6se/XR/K98kvJ5Y+Cyd1tL26AhyYzCBKrPTIaxXaxrOKBFy/b44tnqKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWrx27SJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWrx27SJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756905200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yc++Bk4gHq8rVQO2rd4UcrQ6O5BuxTUofo1WcPNdozc=;
	b=XWrx27SJpqY1/aRlFRahWuVDhJ5nZHXy5K6Zz/474DCeR8pWx/Wmip6AkyZWi3MpV8OSYk
	HiIM8aOOFIy1rZodAEqyYT6siZu+NDOGsYFgZ6R5Yy1DnEDq6ZN7Q6RkIiAX1+ca89r4Wf
	3H1ZVAJrZ/DceTUCm96Zz2TgWB11b3A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-zQj4KCDOMT6eKAtepwzv-Q-1; Wed, 03 Sep 2025 09:13:16 -0400
X-MC-Unique: zQj4KCDOMT6eKAtepwzv-Q-1
X-Mimecast-MFC-AGG-ID: zQj4KCDOMT6eKAtepwzv-Q_1756905195
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c6abcfd303so968930f8f.3
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 06:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905195; x=1757509995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc++Bk4gHq8rVQO2rd4UcrQ6O5BuxTUofo1WcPNdozc=;
        b=SEdmmet+MU7J965MYpR2IHxKH0LNTU6So8JBVDeAzW8yUj20oXpWDBZFnHQ7FeULdI
         IuIysWd/NU/Jkijm2GZxg01zCvmTltwTM11950TmqsRVpwDTqsUOrHKVwz80jkWImwoU
         5XP53x6kBnA0eXKj/hTAtpkcu474ycFBTjXNox3tTcDfe/2hJWHMEeHNf2HC7/XoFvzi
         q0eJyJnIRp7VHo+qcedyaIxCGFEOW3FlnwH0S8xrE6rwBDmcoToqqadkarqOgkq4z60u
         owPhoDuFoHE9n9g1lBrogw0iPQzXVGixnVVs9hcEjlbO2KpxqvFOtzJsyD98BIqDcru6
         rOaw==
X-Forwarded-Encrypted: i=1; AJvYcCUaPRbbxdx7nzmW+J8CXWiu/0C1q4lWy920rY3a3s8LH9Nccu4sn2tJOHrorf6L7dU5FTpVLOirlJncSPrO5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1FRftA5zBdu/JlZCobwSAlNn6XVlSiSJaZAm3V15HDvYvOKRx
	tPTL27Mb/WhtS8J8QCSXtetPGy1kPRfFuLN1gRAeoqlH+/E3qJZFwzDTMePVj+7Lrp7+rm/vwNZ
	pm6KAKKU95LqjXAIii200TXAfAP5kDpu9/cnUQAnRMBar+WKsJlFdmsWxWJw84zhPtoTl
X-Gm-Gg: ASbGncves3DuB+4ITw2kmWl0fIuxPtdKtMZmZ0vQP8/UvhghWjnFcamh/8WqwJko0Ty
	lKSrjmk/WPQSysMKvIWwB4w8yzIteEioqzYlldRXnM47ii8RKmG/msLteKJhRRcB5T9OA7g+8BP
	+VteKwL43MLjFqi7zKay86XPNu9rTyNBll7O6q3EQAB9R06zvdNjT+FX0G0nAxz2lEUu7bnqjCD
	U9S5U2LWsYIJMt4j22u+i4vR8r8F4dOScG5NhwVe294ls0tBC4KeNyA45jXq3EafC+MAlyu0kKg
	hLGNLrKYSI754MAZ3YVGBc6a2bXAcw==
X-Received: by 2002:a05:6000:25ee:b0:3d6:92ed:cae8 with SMTP id ffacd0b85a97d-3d692edce86mr10643412f8f.34.1756905195262;
        Wed, 03 Sep 2025 06:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Rd9SrgoaV2dgKrR38B9EwqokmCVv2zYCp6Unv9lrkeF9C49ix2kdTmzDinE3j4u/W7oa3Q==
X-Received: by 2002:a05:6000:25ee:b0:3d6:92ed:cae8 with SMTP id ffacd0b85a97d-3d692edce86mr10643375f8f.34.1756905194800;
        Wed, 03 Sep 2025 06:13:14 -0700 (PDT)
Received: from redhat.com ([2a0e:41b:f000:0:c4d3:2073:6af0:f91d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d2250115fdsm18102932f8f.40.2025.09.03.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:13:14 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:13:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH 2/4] netdev queue flow control for TUN
Message-ID: <20250903091235-mutt-send-email-mst@kernel.org>
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Ako0X-2VuGsG95xdHxuls8BkrAfiY1eszZhwjahuQ0_1756905195
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2025 at 10:09:55AM +0200, Simon Schippers wrote:
> The netdev queue is stopped in tun_net_xmit after inserting an SKB into
> the ring buffer if the ring buffer became full because of that. If the
> insertion into the ptr_ring fails, the netdev queue is also stopped and
> the SKB is dropped. However, this never happened in my testing. To ensure
> that the ptr_ring change is available to the consumer before the netdev
> queue stop, an smp_wmb() is used.

I think the stop -> wake bounce involves enough barriers already,
no need for us to get cute.


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

