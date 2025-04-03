Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672A2475CB
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682901; cv=none; b=ic89uEkIVkmwTXRvnKLbakFA4PDZQ6yvwUPQAEWOLNYCLD+tvI1YzgoHq2foRpj29gQV/DOiog2GeVFnDFzU9kRnw1xuHhOQvxFLISwdv8npWnCeg+UEH81vqod491z5JvoCLJCE2fQxrlkv4Mev5J4vnnEYUtaJgXnjv5Wf1w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682901; c=relaxed/simple;
	bh=F+Wjb2PAa2Zl8Fn/QXTMlBF4UDZm2GqA/wEyEtg/mLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Sfk1ekAGHSWabXTpM15gTjotmMRz+zQf8nqe/IyH4eflUddx4z1hsoXPsHIxIYUVosszEBEwU5hD63cQZwUUgS7s84HPY5daJ8yeDSwR5kl1taMQSXbSomVBT0ny4a4yDvhskLJPTaFik+dWG5x3djPTe27r9+3cXaQPKy93Npc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ON6uxijy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ON6uxijy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743682897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8Gfcm+NFwIGjnVvm29jTb/bNX3kKJk81JDFkpl4GLw=;
	b=ON6uxijykNWT236LkHc+NYrHvhuU+KHAXO0a+CxW+xLl6G6yqkjSXmVyZgF12oyrjIGKEq
	KyHuKYUPbS9y4A26R+jw9OFnqSICIWAUBIE0imw/y6QQukfZ9IbaUWcbrvbCNl4gB9N5r6
	vEPXuS78HTEwEqQV5Da+6KNpYJf5+84=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618--WMC1mZMNfCgnlXZWOoHIg-1; Thu, 03 Apr 2025 08:21:36 -0400
X-MC-Unique: -WMC1mZMNfCgnlXZWOoHIg-1
X-Mimecast-MFC-AGG-ID: -WMC1mZMNfCgnlXZWOoHIg_1743682895
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d51bd9b45so5600045e9.1
        for <virtualization@lists.linux.dev>; Thu, 03 Apr 2025 05:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743682895; x=1744287695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8Gfcm+NFwIGjnVvm29jTb/bNX3kKJk81JDFkpl4GLw=;
        b=Fm62vpMp2lL4+4OfWv7NHIylCIFW9sm+qQ3bWNLhMaGctVJ2KRTL075JrOJ+Uq8wrR
         hUeW4OHgDbnYmib5fc7rFkN+wjldQo5klv8W4jnfPW1im41Q7SUzGXb1w1KfK43f9g4D
         ChzfDUEhCpwkNo0iOBeZjuY3ETu2ZXSSCkKNSpn4cW9qxNy5upT5u5VqusgiTlGekrF8
         YzYWIFzqYaMA65jmi3Y49DvZBBlCx8mE/v+Ow5zMD/mSEPuGo5FHr8PaWNBv1Sy6z0/X
         vn++XwfiybOa+ueVhiw6NayLmsiCL+iOGzeEWksiNc78NT9Se7Of1epvJbPewY3g5wFE
         L+vw==
X-Forwarded-Encrypted: i=1; AJvYcCXhGGNk8VwonLaSzknXWiwKU5m5ZQrPed7J/vspEtmZqFBALXoW25Y0w7W6HZl5rd7fHwJoKPpDR4dtBFPeIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvOG/lgoPXa/gkHz3fHejP7T76Agmav/ksffhZvQ7LtUVVJams
	k6AXFKYmA9ONGkT1yy7E6ljYP/DhJ84dmHye9s30GCQQF4/4ArjHLXaLioynF6axqfj0RgtJfbb
	cOM1HlU1rdydMQCqH48jitV7WxL4mJBkttFWbTGnNY9t2K3USq3XgFqsdzIrr0yuw
X-Gm-Gg: ASbGncsBAe1qNRhAuQHStOqJMzf2+VShdxDFZ9dq+7GjH2r63vN+AFhvZqmx1N80AaW
	eLYeGj7FV6Am4w4BhO8qmgUY1C7bVmyDfX/u006+2Aw2jwOBVFYmAby9bFGSyK1wsXZa+bm/WB2
	YtO9GUoRbaDvJWnf9RGjv56rZGZD5c1ViM16Sz/4LwxkGgUeHMz7LCG8SCN2RAvzAjL4+9fs6dn
	bfcuCaiBh9cUI4qmSEeLeIWddcCmb5hbRsi4WuJpZGOFs4wsewyyJJ+uT66CHzrz7o88E6pGHmM
	Tqq/Y6lSlQ==
X-Received: by 2002:a05:6000:250e:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-39c30338008mr1939094f8f.25.1743682895233;
        Thu, 03 Apr 2025 05:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTJM52JwYnz0GT0/7IiYLnpZxDljYAqbP88387Bbsg8vdisAF7hoQrduxAOZGx+jEzKBRbmA==
X-Received: by 2002:a05:6000:250e:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-39c30338008mr1939068f8f.25.1743682894821;
        Thu, 03 Apr 2025 05:21:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec163156asm20675695e9.7.2025.04.03.05.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:21:34 -0700 (PDT)
Date: Thu, 3 Apr 2025 08:21:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, netdev@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Asias He <asias@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>, nh-open-source@amazon.com
Subject: Re: [PATCH v2] vsock/virtio: Remove queued_replies pushback logic
Message-ID: <20250403073111-mutt-send-email-mst@kernel.org>
References: <20250401201349.23867-1-graf@amazon.com>
 <20250402161424.GA305204@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250402161424.GA305204@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5Au0mk_dIb2mZY67ovDFQh6FFOQYx0FextU8dyKj1uM_1743682895
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2025 at 12:14:24PM -0400, Stefan Hajnoczi wrote:
> On Tue, Apr 01, 2025 at 08:13:49PM +0000, Alexander Graf wrote:
> > Ever since the introduction of the virtio vsock driver, it included
> > pushback logic that blocks it from taking any new RX packets until the
> > TX queue backlog becomes shallower than the virtqueue size.
> > 
> > This logic works fine when you connect a user space application on the
> > hypervisor with a virtio-vsock target, because the guest will stop
> > receiving data until the host pulled all outstanding data from the VM.
> > 
> > With Nitro Enclaves however, we connect 2 VMs directly via vsock:
> > 
> >   Parent      Enclave
> > 
> >     RX -------- TX
> >     TX -------- RX
> > 
> > This means we now have 2 virtio-vsock backends that both have the pushback
> > logic. If the parent's TX queue runs full at the same time as the
> > Enclave's, both virtio-vsock drivers fall into the pushback path and
> > no longer accept RX traffic. However, that RX traffic is TX traffic on
> > the other side which blocks that driver from making any forward
> > progress. We're now in a deadlock.
> > 
> > To resolve this, let's remove that pushback logic altogether and rely on
> > higher levels (like credits) to ensure we do not consume unbounded
> > memory.
> 
> The reason for queued_replies is that rx packet processing may emit tx
> packets. Therefore tx virtqueue space is required in order to process
> the rx virtqueue.
> 
> queued_replies puts a bound on the amount of tx packets that can be
> queued in memory so the other side cannot consume unlimited memory. Once
> that bound has been reached, rx processing stops until the other side
> frees up tx virtqueue space.
> 
> It's been a while since I looked at this problem, so I don't have a
> solution ready. In fact, last time I thought about it I wondered if the
> design of virtio-vsock fundamentally suffers from deadlocks.
> 
> I don't think removing queued_replies is possible without a replacement
> for the bounded memory and virtqueue exhaustion issue though. Credits
> are not a solution - they are about socket buffer space, not about
> virtqueue space, which includes control packets that are not accounted
> by socket buffer space.


Hmm.
Actually, let's think which packets require a response.

VIRTIO_VSOCK_OP_REQUEST
VIRTIO_VSOCK_OP_SHUTDOWN
VIRTIO_VSOCK_OP_CREDIT_REQUEST


the response to these always reports a state of an existing socket.
and, only one type of response is relevant for each socket.

So here's my suggestion:
stop queueing replies on the vsock device, instead,
simply store the response on the socket, and create a list of sockets
that have replies to be transmitted


WDYT?


> > 
> > RX and TX queues share the same work queue. To prevent starvation of TX
> > by an RX flood and vice versa now that the pushback logic is gone, let's
> > deliberately reschedule RX and TX work after a fixed threshold (256) of
> > packets to process.
> > 
> > Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > ---
> >  net/vmw_vsock/virtio_transport.c | 70 +++++++++-----------------------
> >  1 file changed, 19 insertions(+), 51 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index f0e48e6911fc..54030c729767 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -26,6 +26,12 @@ static struct virtio_vsock __rcu *the_virtio_vsock;
> >  static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
> >  static struct virtio_transport virtio_transport; /* forward declaration */
> >  
> > +/*
> > + * Max number of RX packets transferred before requeueing so we do
> > + * not starve TX traffic because they share the same work queue.
> > + */
> > +#define VSOCK_MAX_PKTS_PER_WORK 256
> > +
> >  struct virtio_vsock {
> >  	struct virtio_device *vdev;
> >  	struct virtqueue *vqs[VSOCK_VQ_MAX];
> > @@ -44,8 +50,6 @@ struct virtio_vsock {
> >  	struct work_struct send_pkt_work;
> >  	struct sk_buff_head send_pkt_queue;
> >  
> > -	atomic_t queued_replies;
> > -
> >  	/* The following fields are protected by rx_lock.  vqs[VSOCK_VQ_RX]
> >  	 * must be accessed with rx_lock held.
> >  	 */
> > @@ -158,7 +162,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> >  		container_of(work, struct virtio_vsock, send_pkt_work);
> >  	struct virtqueue *vq;
> >  	bool added = false;
> > -	bool restart_rx = false;
> > +	int pkts = 0;
> >  
> >  	mutex_lock(&vsock->tx_lock);
> >  
> > @@ -172,6 +176,12 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> >  		bool reply;
> >  		int ret;
> >  
> > +		if (++pkts > VSOCK_MAX_PKTS_PER_WORK) {
> > +			/* Allow other works on the same queue to run */
> > +			queue_work(virtio_vsock_workqueue, work);
> > +			break;
> > +		}
> > +
> >  		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
> >  		if (!skb)
> >  			break;
> > @@ -184,17 +194,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> >  			break;
> >  		}
> >  
> > -		if (reply) {
> > -			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
> > -			int val;
> > -
> > -			val = atomic_dec_return(&vsock->queued_replies);
> > -
> > -			/* Do we now have resources to resume rx processing? */
> > -			if (val + 1 == virtqueue_get_vring_size(rx_vq))
> > -				restart_rx = true;
> > -		}
> > -
> >  		added = true;
> >  	}
> >  
> > @@ -203,9 +202,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> >  
> >  out:
> >  	mutex_unlock(&vsock->tx_lock);
> > -
> > -	if (restart_rx)
> > -		queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> >  }
> >  
> >  /* Caller need to hold RCU for vsock.
> > @@ -261,9 +257,6 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> >  	 */
> >  	if (!skb_queue_empty_lockless(&vsock->send_pkt_queue) ||
> >  	    virtio_transport_send_skb_fast_path(vsock, skb)) {
> > -		if (virtio_vsock_skb_reply(skb))
> > -			atomic_inc(&vsock->queued_replies);
> > -
> >  		virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
> >  		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
> >  	}
> > @@ -277,7 +270,7 @@ static int
> >  virtio_transport_cancel_pkt(struct vsock_sock *vsk)
> >  {
> >  	struct virtio_vsock *vsock;
> > -	int cnt = 0, ret;
> > +	int ret;
> >  
> >  	rcu_read_lock();
> >  	vsock = rcu_dereference(the_virtio_vsock);
> > @@ -286,17 +279,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
> >  		goto out_rcu;
> >  	}
> >  
> > -	cnt = virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
> > -
> > -	if (cnt) {
> > -		struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
> > -		int new_cnt;
> > -
> > -		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
> > -		if (new_cnt + cnt >= virtqueue_get_vring_size(rx_vq) &&
> > -		    new_cnt < virtqueue_get_vring_size(rx_vq))
> > -			queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> > -	}
> > +	virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
> >  
> >  	ret = 0;
> >  
> > @@ -367,18 +350,6 @@ static void virtio_transport_tx_work(struct work_struct *work)
> >  		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
> >  }
> >  
> > -/* Is there space left for replies to rx packets? */
> > -static bool virtio_transport_more_replies(struct virtio_vsock *vsock)
> > -{
> > -	struct virtqueue *vq = vsock->vqs[VSOCK_VQ_RX];
> > -	int val;
> > -
> > -	smp_rmb(); /* paired with atomic_inc() and atomic_dec_return() */
> > -	val = atomic_read(&vsock->queued_replies);
> > -
> > -	return val < virtqueue_get_vring_size(vq);
> > -}
> > -
> >  /* event_lock must be held */
> >  static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
> >  				       struct virtio_vsock_event *event)
> > @@ -613,6 +584,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >  	struct virtio_vsock *vsock =
> >  		container_of(work, struct virtio_vsock, rx_work);
> >  	struct virtqueue *vq;
> > +	int pkts = 0;
> >  
> >  	vq = vsock->vqs[VSOCK_VQ_RX];
> >  
> > @@ -627,11 +599,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >  			struct sk_buff *skb;
> >  			unsigned int len;
> >  
> > -			if (!virtio_transport_more_replies(vsock)) {
> > -				/* Stop rx until the device processes already
> > -				 * pending replies.  Leave rx virtqueue
> > -				 * callbacks disabled.
> > -				 */
> > +			if (++pkts > VSOCK_MAX_PKTS_PER_WORK) {
> > +				/* Allow other works on the same queue to run */
> > +				queue_work(virtio_vsock_workqueue, work);
> >  				goto out;
> >  			}
> >  
> > @@ -675,8 +645,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> >  	vsock->rx_buf_max_nr = 0;
> >  	mutex_unlock(&vsock->rx_lock);
> >  
> > -	atomic_set(&vsock->queued_replies, 0);
> > -
> >  	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
> >  	if (ret < 0)
> >  		return ret;
> > -- 
> > 2.47.1
> > 


