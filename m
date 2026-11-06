Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793924406;
	b=Emt3c8r4OaHSqsF2UD9iEpjolDPtEa9PD8wmWnJ/o8UxI22t87+WTlHNSwZ5RgB/ifHc
	 vR8mn5gY/FHraJtVnbVJyUgcueItAOdOv6nBEOnGQT0tDcim9q8d0h6EGqF45PCz+jqM7
	 /zZ/ZFM37Kxz3nk5PJ/XA0doHxGYDGmTFcNumbAuKZ/5JI/64XKQOI4rZLv8FprvPxVAt
	 wpIbBl2SQ7SihuGqu3QV/LPWW1y6w+MK0nt9uqJBKFTZmlnkGsEok5ObUm/y6jjH+QDa2
	 9nl/81ow4KVFgnxPBJz5Hxv1P8kPqBr64F/yXXIO/SCD13ELoXIO5z/IOm20hqR1cOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924406;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Pt9rRtbReRuSITPC1rskmK8kbHNalDkIofRmPHbf5UA=;
	b=lMAz3ABu3IKfpEURiZRY64ZKieRCeVOpnPshbPE+y+m2KWevmutMcsqE7daPtai08Fcw
	 W9NPf90uU17r83Qlpuy/eKLFf8YI8Jbym+3OvIBA2yFxFExvfVLG1MEuPXJXjr2+UrYPw
	 5BuFgwCTgo5mbPe2mo0gbp1knTWa5VdAKeqbFGhcdeO25aliJlsKtgtolvs8s2Gl9x/xH
	 kYgc0olbQrwNYIDzjj8jXkhD41BB7OFjyBBo5RYPgABZah+0E4pmYIGK44p4NNDIWuDto
	 9K6Z3Aa6svOJ7l3NRrGgtYCdmLvWqe/sBKXjwWlthHHKvoVrVYiB/RhwNzjp5BmkFbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ISsNCsgZ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B2606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F4B2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ISsNCsgZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793924403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt9rRtbReRuSITPC1rskmK8kbHNalDkIofRmPHbf5UA=;
	b=ISsNCsgZT9Usu3eLezaUcm05rG23BzOeZlCIK/+0RlqDrhyjc3jm9a1gVU66bb5b5RzZ/g
	4neoALgK/i977o6rlT2VyKaJV1xIlckJvN0sL2XH4RGlP5Abvgl36KWqPU0oMbsmQpNZUN
	tbhTG/G+yj8ds6aybo5vCdVjw4M24EE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-BlI80h4yMI-ZzYcrpyWA1A-1; Thu, 05 Nov 2026 19:20:02 -0500
X-MC-Unique: BlI80h4yMI-ZzYcrpyWA1A-1
X-Mimecast-MFC-AGG-ID: BlI80h4yMI-ZzYcrpyWA1A_1793924401
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a211bff50bso727365e9.2
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 16:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924401; x=1794529201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pt9rRtbReRuSITPC1rskmK8kbHNalDkIofRmPHbf5UA=;
        b=k0r8tSTnDgEYufXNaVUjt0Ms8lGWjtaQ1Gb0xh1kqtodK7xAUcAbgzDyisjJJynCKh
         2PuDdAQBSptbE+MFVO3DNJSRwi+peBTjUTr1pklafyMj1aq+EOOO8C7kc19d8OoCXw9L
         LVMRV+7kKJI81BIRKPl2B51NVexi275Nr7ZJrkoqYbaO4RzWBAAA2aXShPpaj6evQ4zd
         5YisE91wshqXsJ3ZF6OkW4aEcVq5tg1z7wLBpOzER9R8WBH45pmuHXaHZDACfTQZTygy
         9ZhLf6mKmIdtp6sIBI+r0IHwkont3dKy+gq/o8hzN7L4KIgNO3r0sGyMqbsgBNIeRdpS
         tRyg==
X-Forwarded-Encrypted: i=1; AKwUvBwUbsHfvU7s/gXcrO+mThy97/Ha8BoQiEeHDcUbPgvCLMb1devvXf88tFp4hBTKbcNt4wFQTITuyKMQ1RwWwQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Z0KnBSH+cti0chfyFLK9UcDJ6m5Af8l6LE+HMhoEBuOqeRnpx
	ji4feH+JcFL7BHeCJwnbNd+UIG9sM4v98OCocz9Ov98IpxaDDOqD1426ZhxdFf1rYyB9pQXT68d
	pOIxjlMlcwvO/uyE83hj1Zy2CwoSBZu0ma48nBW+rEhN5Ruf0F4qsF375I1gVJBC3CKv0
X-Gm-Gg: AYBFou3sjfJp1W2827H60+s3YVh6/aSPMgzB7jPUPX7rOzioIIDwlq8tUZtV1twM/aH
	gC68x1Pq4g9xq+4/xt8xDIeci2r98sraq4lCIZB2HEI5W5kx5fbmfN8X/M6imUQcJ8ujjXp8lUe
	Az7qBn2bVLeF2diJH6BkC1jfN+733hOoQtUBspxNlyWjZrsAVPYQU3jk+oZqHjyso/bli03QvkB
	a6k9Wbiw2Y6fbCnheJHq56VnY2emCUHElYQm3yKXmbuk/Jt1BbaQaoPtw0RpW0t9ZKiWOc0woT9
	KXfwRHZuHGFs2Q+o7K2dYqxkJ/oGl4ifWECEPQw84Awds6AnYABVr5TZtj1GNSYjBqcuukjNNBB
	eaPpv9/RHBZnqOCMlfC8sd46vDvQxwbsOaSXizDTGVQ==
X-Received: by 2002:a05:600c:1d0c:b0:4b2:612d:908c with SMTP id 5b1f17b1804b1-4b6df9beb91mr11444435e9.34.1793924400981;
        Thu, 05 Nov 2026 16:20:00 -0800 (PST)
X-Received: by 2002:a05:600c:1d0c:b0:4b2:612d:908c with SMTP id 5b1f17b1804b1-4b6df9beb91mr11443845e9.34.1793924400399;
        Thu, 05 Nov 2026 16:20:00 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1401:db00:7367:7b9e:e66f:2b7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6c776c90asm12554195e9.4.2026.11.05.16.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 16:19:58 -0800 (PST)
Date: Thu, 5 Nov 2026 19:19:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: sgarzare@redhat.com, stefanha@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	bobbyeshleman@meta.com, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] vsock/virtio: queue at most one credit update
 per socket
Message-ID: <20261105191917-mutt-send-email-mst@kernel.org>
References: <20261105000141.3617241-1-green@linuxhacker.ru>
 <20261105000141.3617241-4-green@linuxhacker.ru>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261105000141.3617241-4-green@linuxhacker.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T5soGSxPMJE1AR4ZnwE64YVpKgLy_wUynyeyB8OK9JQ_1793924401
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2026 at 07:01:41PM -0500, Oleg Drokin wrote:
> A credit update carries no data, so the send credit never limits it,
> and the peer can solicit one at will: with OP_CREDIT_REQUEST, or by
> sending data that a local reader drains (a read that empties the
> receive queue sends one). A peer that posts no rx buffers can therefore
> make the other side queue credit updates without limit, about 1 KiB of
> unaccounted slab each for a 44-byte packet.
> 
> Do not queue a credit update while the socket's last queued packet is
> already one. Every packet carries fwd_cnt and buf_alloc, so a packet
> queued later makes the queued update redundant and lets a new one be
> queued after it. When a transport puts a queued update on the wire
> (vhost once it has an rx buffer for it, the guest driver when it adds
> it to the tx virtqueue, loopback when it delivers it) and nothing has
> been queued after it, it refreshes the update's fwd_cnt and buf_alloc
> and releases the socket. So a suppressed update always reaches the
> peer, either in the queued one or in a later packet, and the fwd_cnt
> the peer sees never goes back.
> 
> connect() can move a socket to another transport, freeing its
> virtio_vsock_sock, while packets are still queued in the old one. So a
> tracked update holds a reference on the virtio_vsock_sock, and its skb
> destructor clears the socket's pointer to it and drops the reference,
> however the skb is freed: sent, purged or dropped.
> 
> A peer can thus make a connection queue at most one credit update, plus
> one per packet the socket itself queued after it.
> 
> Counting credit updates in queued_replies instead would not work: most
> of them are sent by local reads, not in answer to the peer, and under
> bidirectional traffic vhost would stop reading the guest's tx queue
> while the guest stops reading its rx queue, each waiting for the other.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
> ---
>  drivers/vhost/vsock.c                   |  2 +
>  include/linux/virtio_vsock.h            |  5 ++
>  net/vmw_vsock/virtio_transport.c        |  2 +
>  net/vmw_vsock/virtio_transport_common.c | 62 ++++++++++++++++++++++++-
>  net/vmw_vsock/vsock_loopback.c          |  1 +
>  5 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index b0004cb48999..f1b47a826ca4 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -176,6 +176,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  			break;
>  		}
>  
> +		virtio_transport_credit_update_xmit(skb);
> +
>  		if (out) {
>  			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
>  			vq_err(vq, "Expected 0 output buffers, got %u\n", out);
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index f91704731057..6c3fc8faca0b 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -13,6 +13,7 @@ struct virtio_vsock_skb_cb {
>  	bool reply;
>  	bool tap_delivered;
>  	u32 offset;
> +	struct virtio_vsock_sock *vvs;
>  };
>  
>  #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
> @@ -167,6 +168,9 @@ struct virtio_vsock_sock {
>  	u32 buf_used;
>  	struct sk_buff_head rx_queue;
>  	u32 msg_count;
> +	struct sk_buff *credit_update;
> +
> +	refcount_t refcnt;

why all this complexity? can you not just peek at the queue tail
instead?


>  };
>  
>  struct virtio_vsock_pkt_info {
> @@ -283,6 +287,7 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
>  void virtio_transport_recv_pkt(struct virtio_transport *t,
>  			       struct sk_buff *skb, struct net *net);
>  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> +void virtio_transport_credit_update_xmit(struct sk_buff *skb);
>  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
>  void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
>  void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 4f9aa9c4c3aa..82cd52249de3 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -104,6 +104,8 @@ static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
>  	int ret, in_sg = 0, out_sg = 0;
>  	struct scatterlist **sgs;
>  
> +	virtio_transport_credit_update_xmit(skb);
> +
>  	sgs = vsock->out_sgs;
>  	sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
>  		    sizeof(*virtio_vsock_hdr(skb)));
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 74a8fdf825d5..65d6e0790e72 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -604,18 +604,68 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
>  	vvs->fwd_cnt += bytes_dequeued;
>  }
>  
> +static void virtio_transport_put_vvs(struct virtio_vsock_sock *vvs)
> +{
> +	if (refcount_dec_and_test(&vvs->refcnt))
> +		kfree(vvs);
> +}
> +
> +static void virtio_transport_credit_update_destruct(struct sk_buff *skb)
> +{
> +	struct virtio_vsock_sock *vvs = VIRTIO_VSOCK_SKB_CB(skb)->vvs;
> +
> +	spin_lock_bh(&vvs->rx_lock);
> +	if (vvs->credit_update == skb)
> +		vvs->credit_update = NULL;
> +	spin_unlock_bh(&vvs->rx_lock);
> +
> +	virtio_transport_put_vvs(vvs);
> +	sock_wfree(skb);
> +}
> +
>  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb)
>  {
>  	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +	bool track = le16_to_cpu(hdr->op) == VIRTIO_VSOCK_OP_CREDIT_UPDATE &&
> +		     skb->destructor == sock_wfree;
> +
> +	/* The skb pins vvs, which connect() may detach from the socket. */
> +	if (track) {
> +		refcount_inc(&vvs->refcnt);
> +		VIRTIO_VSOCK_SKB_CB(skb)->vvs = vvs;
> +		skb->destructor = virtio_transport_credit_update_destruct;
> +	}
>  
>  	spin_lock_bh(&vvs->rx_lock);
>  	vvs->last_fwd_cnt = vvs->fwd_cnt;
>  	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
>  	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
> +	vvs->credit_update = track ? skb : NULL;
>  	spin_unlock_bh(&vvs->rx_lock);
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
>  
> +/* Called by the transports when @skb is put on the wire. */
> +void virtio_transport_credit_update_xmit(struct sk_buff *skb)
> +{
> +	struct virtio_vsock_sock *vvs = VIRTIO_VSOCK_SKB_CB(skb)->vvs;
> +	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +
> +	if (!vvs)
> +		return;
> +
> +	spin_lock_bh(&vvs->rx_lock);
> +	/* Still the socket's last packet: carry what was suppressed. */
> +	if (vvs->credit_update == skb) {
> +		vvs->credit_update = NULL;
> +		vvs->last_fwd_cnt = vvs->fwd_cnt;
> +		hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
> +		hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
> +	}
> +	spin_unlock_bh(&vvs->rx_lock);
> +}
> +EXPORT_SYMBOL_GPL(virtio_transport_credit_update_xmit);
> +
>  void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
>  {
>  	struct sock *s = skb->sk;
> @@ -667,11 +717,20 @@ EXPORT_SYMBOL_GPL(virtio_transport_put_credit);
>  
>  static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
>  {
> +	struct virtio_vsock_sock *vvs = vsk->trans;
>  	struct virtio_vsock_pkt_info info = {
>  		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
>  		.vsk = vsk,
>  		.net = sock_net(sk_vsock(vsk)),
>  	};
> +	bool queued;
> +
> +	spin_lock_bh(&vvs->rx_lock);
> +	queued = vvs->credit_update;
> +	spin_unlock_bh(&vvs->rx_lock);
> +
> +	if (queued)
> +		return 0;
>  
>  	return virtio_transport_send_pkt_info(vsk, &info);
>  }
> @@ -1086,6 +1145,7 @@ int virtio_transport_do_socket_init(struct vsock_sock *vsk,
>  	spin_lock_init(&vvs->rx_lock);
>  	spin_lock_init(&vvs->tx_lock);
>  	skb_queue_head_init(&vvs->rx_queue);
> +	refcount_set(&vvs->refcnt, 1);
>  
>  	return 0;
>  }
> @@ -1276,8 +1336,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
>  
>  	virtio_transport_cancel_close_work(vsk, true);
>  
> -	kfree(vvs);
>  	vsk->trans = NULL;
> +	virtio_transport_put_vvs(vvs);
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_destruct);
>  
> diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
> index 8068d1b6e851..84342a97a513 100644
> --- a/net/vmw_vsock/vsock_loopback.c
> +++ b/net/vmw_vsock/vsock_loopback.c
> @@ -134,6 +134,7 @@ static void vsock_loopback_work(struct work_struct *work)
>  	spin_unlock_bh(&vsock->pkt_queue.lock);
>  
>  	while ((skb = __skb_dequeue(&pkts))) {
> +		virtio_transport_credit_update_xmit(skb);
>  		/* Decrement the bytes_unsent counter without deallocating skb
>  		 * It is freed by the receiver.
>  		 */
> -- 
> 2.56.0
> 

