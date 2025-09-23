Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B124EF8C
	for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638883; cv=none; b=PV/6XzYuFL5wHAmNv2EPADQxd1S0w5bKWONlp8R0h2/Z5fCtgggxFI2j/gTygNy+VW2rewNE+yFcITTJdRK09HURJGxF+o8YS40QTmXsBTcf7lOkOZbKMiJTFvjKhyHxxdOnN7HQ9ho/0+8p07qZpDnKkcUsM31YazPJSNTYpUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638883; c=relaxed/simple;
	bh=KeqE1HEyB8QFnK2pN1rXqm6q+uT9Q0dbCDWcjv2Nc1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R8yyTOzw/00xCjEXOSn//OKk1OihlZ+fWq+CgbF9IQNQqwtwEAmGxv45LRIdTexZ3D6sCu1mm9mVaxJ33VV+fWKIdjh0p8gmpocybh2fDX4kgVcn1ADLrUYk0gzfEfWFEaAoxNsH5mVw9kqluUS0usOf1gzw2ZEeSde/XGyaRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0/29LKL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0/29LKL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lGsm6H7P2q74l6MeTkSvpQNEFLpHSBIxi1h0StSUMNY=;
	b=i0/29LKLkZQ6UxxsUcQd1JzmVJBGD09OQT5s3LxI1/uIkkTykf276CN8c9QyofmWMG6RYP
	KOjELBVYq2wwav0eDoXNUXxSyH+7zSp1Bg85/iU3rvKeAt0Pzp53i05/eTR9bjpj0u6r1z
	2CbvUOhjt+ljAlTi5e9p1qVYcpLuKTU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-1PFggW98PL-4fVNWLi8uFA-1; Tue, 23 Sep 2025 10:47:57 -0400
X-MC-Unique: 1PFggW98PL-4fVNWLi8uFA-1
X-Mimecast-MFC-AGG-ID: 1PFggW98PL-4fVNWLi8uFA_1758638876
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece0cb7c9cso4669570f8f.1
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 07:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638876; x=1759243676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGsm6H7P2q74l6MeTkSvpQNEFLpHSBIxi1h0StSUMNY=;
        b=SZ3etTbLORD55knnQneOoolij6nKLuUsiQh72wad1wbzHc6OYK0Sf4ZZclnPcFSh+a
         PNyCTn08oyWRnrBN6+5iwTAsdJ4oPew7H4yCcqCpGkGtbkdPYXWvQ4+MJqvnXsKr/qgV
         TnEZsl/aLRBSnFcav6EzmcR6NL1VSi6F2veuJCfoqd4SUeUpTIZlXcpvAoUrhMspMVAH
         kqOqST5/liMZHUesuz6Dz0p0aXT+qaeQ+83yMh4+NJfkPRUZnuD6Dh4Jh4Qe7GtPdzpQ
         r0TdCF0YW01c+J+k26tulJBWv9B/N6mUlEv6BILnYU2B9eNfvoJM7VJI1g44X/oOY91l
         KG3w==
X-Forwarded-Encrypted: i=1; AJvYcCXehknr64gI2O9anpIhZizOABCsUm2yneDt6bwScWoaXd/NkBYcHGUJ0AL6R/hrwuVJvzckAnxVz/DJsED1QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOx2qR710zEaR1ZGSm1zl5d9sPuV+1SJpJ0P9BwqZ1U/cxSOQ/
	GAc1PIdyWx7XzZw6v8roVN3rmvh72ZjycfUaY0XvWDXBZERoQAqtwyp7QoQkvvnAEUajrnOhxD9
	zgdZZVlr7VA35b9ZApMMXoQClvujx7JQtFNwLOmS+2rlV7h9i2ZMZxLBhepdXutMPuEBI
X-Gm-Gg: ASbGncvjfo5IeTADoGDOBZdtV/twdYYZeXlysMtywUp8fz7SEvidyVnX4MnXk2/WsBA
	2P6YItDYyF1wgDiQDdyAlw3AEPjpvX4pfOaQ73jrNVWqSZWCV8IaqULve4FpqfihGVwpZUvrPiA
	hp48zuBFWYfNerydPIxNCPlrconhSdqflmj0lkm1WYysNmMjOWejj+EbAgrGvv97E0XVwhkL2V2
	NdZvqOVkHWu07fKt2hHqsDDREpTVDJzFzamrDjRieMdB6QiwtB9/H3rudFA9ZIM+Oy0cL3Ng8yc
	rq3sQLlKGclOoqRcSmwB4+Y8O1WQcUgvnXk=
X-Received: by 2002:a05:6000:220c:b0:3f3:88e1:9e30 with SMTP id ffacd0b85a97d-405c5bd85e9mr2624058f8f.15.1758638875928;
        Tue, 23 Sep 2025 07:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVQW7wtomtpR1qDlFcvwbCRqGqsve/Ts8yCwjgDlTYhRUQTsERWyfPd2452H8Z8mCijph+Xg==
X-Received: by 2002:a05:6000:220c:b0:3f3:88e1:9e30 with SMTP id ffacd0b85a97d-405c5bd85e9mr2624025f8f.15.1758638875505;
        Tue, 23 Sep 2025 07:47:55 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f61703b206sm14087074f8f.6.2025.09.23.07.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:47:55 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:47:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 3/8] TUN, TAP & vhost_net: Stop netdev queue
 before reaching a full ptr_ring
Message-ID: <20250923104348-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250922221553.47802-4-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250922221553.47802-4-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CYyDAqDmgFa9fgg5CeG4ScFCI6Nk4XKK1A1wi5djgsU_1758638876
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 12:15:48AM +0200, Simon Schippers wrote:
> Stop the netdev queue ahead of __ptr_ring_produce when
> __ptr_ring_full_next signals the ring is about to fill. Due to the
> smp_wmb() of __ptr_ring_produce the consumer is guaranteed to be able to
> notice the stopped netdev queue after seeing the new ptr_ring entry. As
> both __ptr_ring_full_next and __ptr_ring_produce need the producer_lock,
> the lock is held during the execution of both methods.
> 
> dev->lltx is disabled to ensure that tun_net_xmit is not called even
> though the netdev queue is stopped (which happened in my testing,
> resulting in rare packet drops). Consequently, the update of trans_start
> in tun_net_xmit is also removed.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 86a9e927d0ff..c6b22af9bae8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -931,7 +931,7 @@ static int tun_net_init(struct net_device *dev)
>  	dev->vlan_features = dev->features &
>  			     ~(NETIF_F_HW_VLAN_CTAG_TX |
>  			       NETIF_F_HW_VLAN_STAG_TX);
> -	dev->lltx = true;
> +	dev->lltx = false;
>  
>  	tun->flags = (tun->flags & ~TUN_FEATURES) |
>  		      (ifr->ifr_flags & TUN_FEATURES);
> @@ -1060,14 +1060,18 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	nf_reset_ct(skb);
>  
> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +	queue = netdev_get_tx_queue(dev, txq);
> +
> +	spin_lock(&tfile->tx_ring.producer_lock);
> +	if (__ptr_ring_full_next(&tfile->tx_ring))
> +		netif_tx_stop_queue(queue);
> +
> +	if (unlikely(__ptr_ring_produce(&tfile->tx_ring, skb))) {
> +		spin_unlock(&tfile->tx_ring.producer_lock);
>  		drop_reason = SKB_DROP_REASON_FULL_RING;
>  		goto drop;
>  	}

The comment makes it sound like you always keep one slot free
in the queue but that is not the case - you just
check before calling __ptr_ring_produce.


But it is racy isn't it? So first of all I suspect you
are missing an mb before netif_tx_stop_queue.

Second it's racy because more entries can get freed
afterwards. Which maybe is ok in this instance?
But it really should be explained in more detail, if so.



Now - why not just check ring full *after* __ptr_ring_produce?
Why do we need all these new APIs, and we can
use existing ones which at least are not so hard to understand.




> -
> -	/* dev->lltx requires to do our own update of trans_start */
> -	queue = netdev_get_tx_queue(dev, txq);
> -	txq_trans_cond_update(queue);
> +	spin_unlock(&tfile->tx_ring.producer_lock);
>  
>  	/* Notify and wake up reader process */
>  	if (tfile->flags & TUN_FASYNC)
> -- 
> 2.43.0

