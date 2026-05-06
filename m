Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE324331A76
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105941; cv=none; b=g+bdInaCdGt+FbZc95M1QF4qBmV7lrKfnX9TOCkTv/8sZvIU8Ig916wT5lL6I2xWfraEBHqagcKW4KLoqAwB/HBLb6+XDvi/t5FblhAtzRGKO2JXNLt9W8FFxB/++eG1VV2tqxQPr+1Iv8bRII8Qm5CCR8WnvD1uqNyaHOmroZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105941; c=relaxed/simple;
	bh=xowx2aws2zk3Zd66+dpqpP2+/Ry8gOTMIEfy3bzK8SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uL/hOKQcMW4oS/pvoexipbJEg8it4CB48mPvwOMN/ab3zrIQBYEDgVV45wIN0oTr+s3UphoMXRWbiChWCPxbcwWti2Y9/6JmRyNqYMaFvJcMNiFJHoEgUUJz+DTDRp+PH67rBWx/uq8xbo/xEBWtauR1pUlmsEgZH8in13TpGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agkgkIeW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agkgkIeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778105938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y12GQ51sePHfLNuYSwUrWXfEMIUEYmPo7/Zy93R3cDo=;
	b=agkgkIeWjaDcSXrk8RVVPv1barPTldwfY+botHynFMTaJAtgYRbeXqvbRcA9i/XpKZO8nz
	qxK7tPkCE5ArhTr8J4xyGEYEeFsGcnu5yDJDqaMuRL90Od8GXtmxk4kPh+Z9e3FX/lK1e/
	HUgjGuOl9Kvi6T3aEpCN7bx50KJixwI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-IKCFrRD3NueqRpqWau-r1w-1; Wed, 06 May 2026 18:18:57 -0400
X-MC-Unique: IKCFrRD3NueqRpqWau-r1w-1
X-Mimecast-MFC-AGG-ID: IKCFrRD3NueqRpqWau-r1w_1778105936
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d83e45febso1085218f8f.0
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 15:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778105936; x=1778710736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y12GQ51sePHfLNuYSwUrWXfEMIUEYmPo7/Zy93R3cDo=;
        b=nS7AfK0p5zsRBl8hWDuPzZDiwqPRXQR6QQa2ozwBhM5Komyoty+CrqJPcKtjhLIGSi
         BJ2IQQ++k3THR3qcsvB/rpK9cgSbQGRNodBGHBCY4oNHdKqb/BeKEocUGyVLf7UAqS63
         T78gQ0yRyAinfQp8rV5fCBnmeNZKM2iM4hWlvn72wWaI60xqNX+RQ/wb2+uF/y2SQQVM
         k+/EQxW2IYlINZYXNzFDF2A0j76i6uHhDDA/igE4FnFJDxIXTiYoPoEfPmHDmrWJUFhv
         TyDhVCck7Gll6oo9kwuKw8OeWp+Avs6GKkeL3MNJx2aRSCdujbO3F7qpHwE21ARhvG0t
         TrcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oxxXPXekpM7mjLI606gmEyPMvMhbOpz5TxxcDZxY9UrKkO7HdCUYxe8xVmVnLnFhn7MHFTdud+2To2TMgZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjARgvWdKyrBtrZbfjpHKt9JPdPmEyj8SLeK95GPk3tFSzkkIx
	Ffw8GTlBS0p8Y6hMVhO5V6vsI2h/6lSVxszv9iyWY/uglV7hh0Yq9pmnsQvfYFUbtH4VQrhR01V
	qC/kd0iX41P7WpCkiLEG9zEf9OVgRpLX2tswa07EWSPTCbvW7m5STglL+HKXM77goRJph
X-Gm-Gg: AeBDiesmGhbBrE2JP7tdAbHh7PkeskfeLpFcgBD0KOvsLs5OJ+M6FGj+lfaMp8Yfn+H
	Sz49oLjpEUNLIpfB8adW9oeJ1QJz5c3aGEAp09zHTdiJwzlldYsu0pw0cXIE69HCozcp+eXq92M
	qjS67ysE1IHhDyccUvS5UkluW+z8LRolBpgdQhPv+Ls5PoNsClGMfYjOh8HArYBE+cyoc3AZGLW
	WKnoqaX1JdPgavIvyEPx0tD08/ljbszuJ6hPPeJ3viD/32U5PcfEhGK6Nzvwsf2JIV3vqdnvWlp
	jsC+C34R1JM+7gAMv0355novyp+hoWMTLUNsf85++MoA4ex3/8kKn5oLiz7FDPz3/F5JuDAiWQv
	JQCKG0DRdk5+6HqvKQga1BM4qPkVCYfpOSVJx8rjxYGblALipQbk=
X-Received: by 2002:a05:6000:2383:b0:43e:a75e:352 with SMTP id ffacd0b85a97d-452e78b35a2mr564062f8f.4.1778105936393;
        Wed, 06 May 2026 15:18:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2383:b0:43e:a75e:352 with SMTP id ffacd0b85a97d-452e78b35a2mr564023f8f.4.1778105935851;
        Wed, 06 May 2026 15:18:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48f63sm15004698f8f.16.2026.05.06.15.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:18:55 -0700 (PDT)
Date: Wed, 6 May 2026 18:18:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v10 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260506181556-mutt-send-email-mst@kernel.org>
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
 <20260506141033.180450-2-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260506141033.180450-2-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o60SEtICrRCz6pHl3wXGMICdwGiBARsVWvIMZ6IlD0Y_1778105936
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2026 at 04:10:30PM +0200, Simon Schippers wrote:
> Introduce tun_ring_consume() that wraps ptr_ring_consume() and calls
> __tun_wake_queue(). The latter wakes the stopped netdev subqueue once
> half of the ring capacity has been consumed, tracked via the new
> cons_cnt field in tun_file. cons_cnt is updated while holding the ring
> consumer lock, avoiding races. As a safety net, the queue is also woken
> when the ring becomes empty. The point is to allow the queue to be
> stopped when it gets full, which is required for traffic shaping -
> implemented by the following "avoid ptr_ring tail-drop when a qdisc
> is present". That patch also explains the pairing of the smp_mb()
> of __tun_wake_queue().
> 
> Without the corresponding queue stopping, this patch alone causes no
> regression for a tap setup sending to a qemu VM: 1.132 Mpps
> to 1.144 Mpps.
> 
> Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
> threads, pktgen sender; Avg over 50 runs @ 100,000,000 packets;
> SRSO and spectre v2 mitigations disabled.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 54 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index b183189f1853..00ecf128fe8e 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -145,6 +145,7 @@ struct tun_file {
>  	struct list_head next;
>  	struct tun_struct *detached;
>  	struct ptr_ring tx_ring;
> +	int cons_cnt;
>  	struct xdp_rxq_info xdp_rxq;
>  };
>  
> @@ -557,6 +558,13 @@ void tun_ptr_free(void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(tun_ptr_free);
>  
> +static void tun_reset_cons_cnt(struct tun_file *tfile)
> +{
> +	spin_lock(&tfile->tx_ring.consumer_lock);
> +	tfile->cons_cnt = 0;
> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> +}
> +
>  static void tun_queue_purge(struct tun_file *tfile)
>  {
>  	void *ptr;
> @@ -564,6 +572,7 @@ static void tun_queue_purge(struct tun_file *tfile)
>  	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
>  		tun_ptr_free(ptr);
>  
> +	tun_reset_cons_cnt(tfile);
>  	skb_queue_purge(&tfile->sk.sk_write_queue);
>  	skb_queue_purge(&tfile->sk.sk_error_queue);
>  }
> @@ -730,6 +739,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  		goto out;
>  	}
>  
> +	tun_reset_cons_cnt(tfile);
>  	tfile->queue_index = tun->numqueues;
>  	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
>  
> @@ -2115,13 +2125,46 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	return total;
>  }
>  
> -static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> +/* Callers must hold ring.consumer_lock */
> +static void __tun_wake_queue(struct tun_struct *tun,
> +			     struct tun_file *tfile, int consumed)
> +{
> +	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
> +						tfile->queue_index);
> +
> +	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
> +	smp_mb();
> +	if (netif_tx_queue_stopped(txq)) {
> +		tfile->cons_cnt += consumed;
> +		if (tfile->cons_cnt >= tfile->tx_ring.size / 2 ||
> +		    __ptr_ring_empty(&tfile->tx_ring)) {
> +			netif_tx_wake_queue(txq);
> +			tfile->cons_cnt = 0;
> +		}
> +	}
> +}
> +
> +static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *tfile)
> +{
> +	void *ptr;
> +
> +	spin_lock(&tfile->tx_ring.consumer_lock);
> +	ptr = __ptr_ring_consume(&tfile->tx_ring);
> +	if (ptr)
> +		__tun_wake_queue(tun, tfile, 1);
> +
> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> +	return ptr;
> +}
> +
> +static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile,
> +			   int noblock, int *err)
>  {
>  	DECLARE_WAITQUEUE(wait, current);
>  	void *ptr = NULL;
>  	int error = 0;
>  
> -	ptr = ptr_ring_consume(&tfile->tx_ring);
> +	ptr = tun_ring_consume(tun, tfile);
>  	if (ptr)
>  		goto out;
>  	if (noblock) {
> @@ -2133,7 +2176,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  
>  	while (1) {
>  		set_current_state(TASK_INTERRUPTIBLE);
> -		ptr = ptr_ring_consume(&tfile->tx_ring);
> +		ptr = tun_ring_consume(tun, tfile);
>  		if (ptr)
>  			break;
>  		if (signal_pending(current)) {


So based on commit log I expected all calls to ptr_ring_consume to
be replaced with tun_ring_consume, but it looks like tun_queue_purge
still calls ptr_ring_consume.
I suspect that together with patch 4 it can sometimes leave us stuck
with a stopped queue and an empty ring, forever.





> @@ -2170,7 +2213,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
>  
>  	if (!ptr) {
>  		/* Read frames from ring */
> -		ptr = tun_ring_recv(tfile, noblock, &err);
> +		ptr = tun_ring_recv(tun, tfile, noblock, &err);
>  		if (!ptr)
>  			return err;
>  	}
> @@ -3406,6 +3449,8 @@ static int tun_chr_open(struct inode *inode, struct file * file)
>  		return -ENOMEM;
>  	}
>  
> +	tun_reset_cons_cnt(tfile);
> +
>  	mutex_init(&tfile->napi_mutex);
>  	RCU_INIT_POINTER(tfile->tun, NULL);
>  	tfile->flags = 0;
> @@ -3614,6 +3659,7 @@ static int tun_queue_resize(struct tun_struct *tun)
>  	for (i = 0; i < tun->numqueues; i++) {
>  		tfile = rtnl_dereference(tun->tfiles[i]);
>  		rings[i] = &tfile->tx_ring;
> +		tun_reset_cons_cnt(tfile);
>  	}
>  	list_for_each_entry(tfile, &tun->disabled, next)
>  		rings[i++] = &tfile->tx_ring;
> -- 
> 2.43.0

