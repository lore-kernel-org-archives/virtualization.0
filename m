Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E623BF9C
	for <virtualization@lists.linux.dev>; Wed,  2 Apr 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606653; cv=none; b=P950GYXZW49JlsDYQeUX94rGlPi2KaHrd/SSwAPqrQrTrAhM7s8/NMKOottbnsW+5TfRwrhS+NuoBTooQR+pFRj7wGXG/2LJqt2dFUZ5SaSeYFAitkXhryipBNd2tXHdDWu9zpEJ4YkvM4Xld4c9+c8Km4QXC49LgoESGry+BPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606653; c=relaxed/simple;
	bh=Wx5M90e64E3MjDUr9Ch34zKCK7GOmg4VU1BOjCbGR8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f9gJCjajGU+Tt67TQhX6d5W+ueZRjXvd6ejFQy4cEAri86qx38bu9U6imJK5lI9YAboHEyCKNZum4Q6aNDmWHRIhr7lPhtePiv1CBo3agSRNd9PRP4Qw+NPHKCl5ypG6fkBIVEWB8WOc8a0TjYwqJmuda4nLwpBTK0eR00+/9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKdSDMLX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKdSDMLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743606650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzfUkUzWq9fRRQLrkAOKjL9y8AZLP6EYGawplPp5Jr4=;
	b=MKdSDMLXJI/BMhUvVpTF32Hd3/uc7HUcv2aASBZu/gbO8+TKSpQs/rn0tQZprcmGKbo4BN
	39buaBTL7rSv0jJJw0g7V+BQ47FmlaXq1J4evP3hrBz4ANDXI9JBn4gTXs5TDnoU/MLu2f
	2q+K0OdnvLImBkL0rt3aDp7YDbMjdr8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-HRJYRw3fOdaddMihhl-P7A-1; Wed, 02 Apr 2025 11:10:49 -0400
X-MC-Unique: HRJYRw3fOdaddMihhl-P7A-1
X-Mimecast-MFC-AGG-ID: HRJYRw3fOdaddMihhl-P7A_1743606648
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39abdadb0f0so3578898f8f.0
        for <virtualization@lists.linux.dev>; Wed, 02 Apr 2025 08:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743606648; x=1744211448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzfUkUzWq9fRRQLrkAOKjL9y8AZLP6EYGawplPp5Jr4=;
        b=F+e5gA3tpCj5C9c2eTOCo3jmPlZ3rjUdYDcoc9RWX6OUnSIlKO5KIhA2/HeOAyvYtQ
         pHncykKOmRmlJGUJjqrNlk8rMZikfVOFy4nG2l4RhUqWguyECn9CpiZv6Mn1QL3JQPEU
         8BM4p/R3bWqgiV8mYJ5KNw33Q4XLEXCDOJgDOQ20rdNxsCs4cwgKi5Vl0aqQ+GtiSLmF
         k6oaWNiJJYtz4JFChXBFweuuDTFo+ZA/4bbe8nKsEh9p6QRJ+qsNGeaxKhqu449rHl2+
         Wt0ET6jKVwTjjC1ETjPkx7Nov0KA9fpkc/By02EJlQUJ1WmgWAn90SBuvpKBVepl+KXX
         sjeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Cnqq70mP57CGqvzkHaIh9Sb70PZ6sVlHHfeEsCrVBsvkD/N+4S4KMomBHwIXo2m/++8HxpbnUzM3BZEwIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQBuSldEEYdFu8sgYqjFoqzFaroxtTB8Wq1DQiMnewcQVRljNf
	10xPr+h3IT0aMFp4uJFNfAndOrIuU25FVy+jwn1Wq0ed1x4xmA9Z9G4RAeYLrUOKhdv+4Uhh8Ko
	f5Zb3OQsv2PAEjAbfC/pgjGVKW2E+pwpS68TJmx/YFuBqC5OJgkIAIXOJF4RSePV7
X-Gm-Gg: ASbGncvS4AkR+odm1bEL5/y5salkhhkXWx2IbLX40iwNxnLBj4k1y0dbyJ0QeFifMyF
	5yvKehjn0oFy6tdHAzx2KY/D9tCMRUcJWvEFa6H+zqOiJddGZQ6uTu78N7xCynkDuRRvCrI7Gcq
	pBPGCAqSz850Vh/Sq020ZfmXrQmjpim3VC9ECerV1qQktS4UYN3XnTKaEEOmjW3KL/3vWh/PbgE
	Ir/zXW+y5YBCaADAKKQ/Jfxtdl4NckOwLzMl16b7zqFu5GhSgFWTkmscec0QlAOCS97rbKseZiP
	VHXL8CC0mQ==
X-Received: by 2002:a05:6000:184e:b0:39c:12ce:67e with SMTP id ffacd0b85a97d-39c12ce0a68mr12277112f8f.41.1743606648029;
        Wed, 02 Apr 2025 08:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyFq5Tnvi7enL0SUDt0uHwYKISkamtGT6zUksHsWiWDGWdqNqB3l2rTc3msrHjpqW6D7lF+Q==
X-Received: by 2002:a05:6000:184e:b0:39c:12ce:67e with SMTP id ffacd0b85a97d-39c12ce0a68mr12277078f8f.41.1743606647538;
        Wed, 02 Apr 2025 08:10:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb60d34dasm24054065e9.23.2025.04.02.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 08:10:47 -0700 (PDT)
Date: Wed, 2 Apr 2025 11:10:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: netdev@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Asias He <asias@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>, nh-open-source@amazon.com,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v3] vsock/virtio: Remove queued_replies pushback logic
Message-ID: <20250402110955-mutt-send-email-mst@kernel.org>
References: <20250402150646.42855-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250402150646.42855-1-graf@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9fKNMYNO6DBZgGXkfi4HzOg2_yL83iU5swNc36fLU78_1743606648
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2025 at 03:06:46PM +0000, Alexander Graf wrote:
> Ever since the introduction of the virtio vsock driver, it included
> pushback logic that blocks it from taking any new RX packets until the
> TX queue backlog becomes shallower than the virtqueue size.
> 
> This logic works fine when you connect a user space application on the
> hypervisor with a virtio-vsock target, because the guest will stop
> receiving data until the host pulled all outstanding data from the VM.
> 
> With Nitro Enclaves however, we connect 2 VMs directly via vsock:
> 
>   Parent      Enclave
> 
>     RX -------- TX
>     TX -------- RX
> 
> This means we now have 2 virtio-vsock backends that both have the pushback
> logic. If the parent's TX queue runs full at the same time as the
> Enclave's, both virtio-vsock drivers fall into the pushback path and
> no longer accept RX traffic. However, that RX traffic is TX traffic on
> the other side which blocks that driver from making any forward
> progress. We're now in a deadlock.
> 
> To resolve this, let's remove that pushback logic altogether and rely on
> higher levels (like credits) to ensure we do not consume unbounded
> memory.
> 
> RX and TX queues share the same work queue. To prevent starvation of TX
> by an RX flood and vice versa now that the pushback logic is gone, let's
> deliberately reschedule RX and TX work after a fixed threshold (256) of
> packets to process.
> 
> Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
> Signed-off-by: Alexander Graf <graf@amazon.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
> v1 -> v2:
> 
>   - Rework to use fixed threshold
> 
> v2 -> v3:
> 
>   - Remove superfluous reply variable
> ---
>  net/vmw_vsock/virtio_transport.c | 73 +++++++++-----------------------
>  1 file changed, 19 insertions(+), 54 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index f0e48e6911fc..6ae30bf8c85c 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -26,6 +26,12 @@ static struct virtio_vsock __rcu *the_virtio_vsock;
>  static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
>  static struct virtio_transport virtio_transport; /* forward declaration */
>  
> +/*
> + * Max number of RX packets transferred before requeueing so we do
> + * not starve TX traffic because they share the same work queue.
> + */
> +#define VSOCK_MAX_PKTS_PER_WORK 256
> +
>  struct virtio_vsock {
>  	struct virtio_device *vdev;
>  	struct virtqueue *vqs[VSOCK_VQ_MAX];
> @@ -44,8 +50,6 @@ struct virtio_vsock {
>  	struct work_struct send_pkt_work;
>  	struct sk_buff_head send_pkt_queue;
>  
> -	atomic_t queued_replies;
> -
>  	/* The following fields are protected by rx_lock.  vqs[VSOCK_VQ_RX]
>  	 * must be accessed with rx_lock held.
>  	 */
> @@ -158,7 +162,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, send_pkt_work);
>  	struct virtqueue *vq;
>  	bool added = false;
> -	bool restart_rx = false;
> +	int pkts = 0;
>  
>  	mutex_lock(&vsock->tx_lock);
>  
> @@ -169,32 +173,24 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  
>  	for (;;) {
>  		struct sk_buff *skb;
> -		bool reply;
>  		int ret;
>  
> +		if (++pkts > VSOCK_MAX_PKTS_PER_WORK) {
> +			/* Allow other works on the same queue to run */
> +			queue_work(virtio_vsock_workqueue, work);
> +			break;
> +		}
> +
>  		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
>  		if (!skb)
>  			break;
>  
> -		reply = virtio_vsock_skb_reply(skb);
> -
>  		ret = virtio_transport_send_skb(skb, vq, vsock, GFP_KERNEL);
>  		if (ret < 0) {
>  			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
>  			break;
>  		}
>  
> -		if (reply) {
> -			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
> -			int val;
> -
> -			val = atomic_dec_return(&vsock->queued_replies);
> -
> -			/* Do we now have resources to resume rx processing? */
> -			if (val + 1 == virtqueue_get_vring_size(rx_vq))
> -				restart_rx = true;
> -		}
> -
>  		added = true;
>  	}
>  
> @@ -203,9 +199,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  
>  out:
>  	mutex_unlock(&vsock->tx_lock);
> -
> -	if (restart_rx)
> -		queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>  }
>  
>  /* Caller need to hold RCU for vsock.
> @@ -261,9 +254,6 @@ virtio_transport_send_pkt(struct sk_buff *skb)
>  	 */
>  	if (!skb_queue_empty_lockless(&vsock->send_pkt_queue) ||
>  	    virtio_transport_send_skb_fast_path(vsock, skb)) {
> -		if (virtio_vsock_skb_reply(skb))
> -			atomic_inc(&vsock->queued_replies);
> -
>  		virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>  		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>  	}
> @@ -277,7 +267,7 @@ static int
>  virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>  {
>  	struct virtio_vsock *vsock;
> -	int cnt = 0, ret;
> +	int ret;
>  
>  	rcu_read_lock();
>  	vsock = rcu_dereference(the_virtio_vsock);
> @@ -286,17 +276,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>  		goto out_rcu;
>  	}
>  
> -	cnt = virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
> -
> -	if (cnt) {
> -		struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
> -		int new_cnt;
> -
> -		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
> -		if (new_cnt + cnt >= virtqueue_get_vring_size(rx_vq) &&
> -		    new_cnt < virtqueue_get_vring_size(rx_vq))
> -			queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> -	}
> +	virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
>  
>  	ret = 0;
>  
> @@ -367,18 +347,6 @@ static void virtio_transport_tx_work(struct work_struct *work)
>  		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>  }
>  
> -/* Is there space left for replies to rx packets? */
> -static bool virtio_transport_more_replies(struct virtio_vsock *vsock)
> -{
> -	struct virtqueue *vq = vsock->vqs[VSOCK_VQ_RX];
> -	int val;
> -
> -	smp_rmb(); /* paired with atomic_inc() and atomic_dec_return() */
> -	val = atomic_read(&vsock->queued_replies);
> -
> -	return val < virtqueue_get_vring_size(vq);
> -}
> -
>  /* event_lock must be held */
>  static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
>  				       struct virtio_vsock_event *event)
> @@ -613,6 +581,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  	struct virtio_vsock *vsock =
>  		container_of(work, struct virtio_vsock, rx_work);
>  	struct virtqueue *vq;
> +	int pkts = 0;
>  
>  	vq = vsock->vqs[VSOCK_VQ_RX];
>  
> @@ -627,11 +596,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  			struct sk_buff *skb;
>  			unsigned int len;
>  
> -			if (!virtio_transport_more_replies(vsock)) {
> -				/* Stop rx until the device processes already
> -				 * pending replies.  Leave rx virtqueue
> -				 * callbacks disabled.
> -				 */
> +			if (++pkts > VSOCK_MAX_PKTS_PER_WORK) {
> +				/* Allow other works on the same queue to run */
> +				queue_work(virtio_vsock_workqueue, work);
>  				goto out;
>  			}
>  
> @@ -675,8 +642,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>  	vsock->rx_buf_max_nr = 0;
>  	mutex_unlock(&vsock->rx_lock);
>  
> -	atomic_set(&vsock->queued_replies, 0);
> -
>  	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.47.1

