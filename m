Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869591;
	b=X0oeyzJvUcHg8wyNQmgM3vkZZs8TJKmlVUeRzrXakfEEjIY0Rq0NhRXQ8AA+quUW/IzD
	 E/lXa0O6WxJQAWkcAGV7qMBa8LZDgbg2iwfdZSm25lj195/gJl6qHsPYMn/YmTmPEpt4+
	 ETwKJeCjeKpZgGs+V7G8Dk5Ap4DtJGHTXmtl7KoGgG/ekgIgqAn+4fZa8KMQ2x1eAXRZf
	 JiAN+WMpOCJUkBXSCw56diLVW8lNHjVLvkHUCOaREZsbuzrBN2C6TspKFSE6PtHGYtueU
	 KzGlaA9/5wAx2kvMk9mEfbMi9bnYXY/+VFVfrXK9eHb3QkJK90Skcx96ovVmn8EHk2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869591;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=sXaBx9Aij9/vZ7m2OstPYoIGvXFxlj8rEgSuIQIdBWQ=;
	b=vbfZ70RY/hlc2pe4CUdffnHXMe3WSFxgTnyMineCX8Cleyc3NJuMqG3obL9cyatmxJxE
	 QlYZPqLUGsITqXpGJSn1gBEWlvksOa5H412bSn/mhYFjMeTfLWyJLmyfn4uOpdQ7ekGpT
	 jJTMkeZqnd7zmSrI5OXUfeXgylViX1ZeW34oJkCCkhK6AnoWsgQReCwpvcYxLRXoyR8Jv
	 8vTyiBW+bTDe0fXf5psWUoLAFG1ZepXgL9G20wueIZZ7vRoCD7Thu5zmKFS11dAZ6vd4s
	 MXVQNABThlMrJry/Ij0fwOYkqqTkmwwHiz1gVawSjiQeyhwbeO1J4GQuKzFZaPqTGuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCaXKPc9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC53606A32D
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 09:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC53606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCaXKPc9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793869589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXaBx9Aij9/vZ7m2OstPYoIGvXFxlj8rEgSuIQIdBWQ=;
	b=MCaXKPc9aN0fAL8Vmah/490+jJGBSEw/qnPWHrn7yvGkqJkaepA6knzlUsynRNk24BEAoj
	XxsmAme8afGsvwlvkgN1KhptCbcaq6ZYwkHxAx7Q1I1ZuSMjUK3hzzmLdfFcKt5feIXole
	0j7czpxW+58iyv6+raNmxNifNlYvYGo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-1JXxTXBOPUea_Fc6MF6Tdg-1; Thu, 05 Nov 2026 04:06:28 -0500
X-MC-Unique: 1JXxTXBOPUea_Fc6MF6Tdg-1
X-Mimecast-MFC-AGG-ID: 1JXxTXBOPUea_Fc6MF6Tdg_1793869587
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-490ed502749so661700f8f.2
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 01:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869587; x=1794474387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXaBx9Aij9/vZ7m2OstPYoIGvXFxlj8rEgSuIQIdBWQ=;
        b=MAHvaybTZdVXOXrSuFUzWgjfeoeRy8MHz9D7Bq+IafMxxKQ5KIdAqesPZhwT6YJ5FQ
         oHlD/Tskl73qaqnezNg7ZsyLrmKU5YdRln+pHKUhVMMI16/aeQOmRfIrRY2GJKZ9eiLc
         QEgMJ15NAde+XPotQ0lzEGu5jyckRM9sYFqblX5566iRbq7rxagc/V5tcKqQSIOArqF3
         UDuB48lc67/qkVy6WOL8N9TI8qaqRGlyrfK3c+OxJfpqbUVWl6P6bOG+mX7hDKgcZvfN
         RaRZPjMBN30zcYs4e/BkpuMQme0RbAVfkW/xVNH5blVLMEEJ4M4cLBWt5QP5TvGJD7Go
         rowQ==
X-Forwarded-Encrypted: i=1; AKwUvBwq692spusjwiIlragUk9ePgpo8F8eYjLYGV0Y9g+yDT3UCvZGbGo+oNorexC18/31kVzK+umCBRvYgKOdlvg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/HxEqrqIwtGrn45t7In/iX4uEarhynPK0TeealEdzJ+huCJu7r
	UN5K9d+2M7Jagglt3PpsbNh6OGvyrexXJF3N9IhTNqyTsdQ7WZXXXpMBSDz2FWIge0e2yD2ZMBZ
	aFhLSqoVF5TqfQuWArcFHz8ljHGatPDLKE4KppY2TR/VI5NQTcJtUizozq6DMNjqvlgIT
X-Gm-Gg: AYBFou1hUUsOfVPE9OAbgQWVc5zlobqdfkgvmBHjDawPXZl4D5qQLjSg1L5N42poO8z
	fWLsrKKPJYyoPqIcGDOjxdpGTwqTXj9gnReBtMGhJBRffhU8oFhqrfl/5NkuwIQQHYZmRSZAR9t
	ApnxKJgJe+xv9wfeLWSXopfOES24GtvZscMgE3cSbO+5siSs9PiQyZkktP41gBZuSqpkZlZ3vZ4
	+5ttxSBBoam+8lswxyb7xf+E8hVPDmfoZswNALkxHhOQNUgz3tFoBZFUkwgWZEkQh32lrEvi8c2
	U/K3r6xlkAPkKmyQTpMG3tNlMavc8Z+fGnw9aYIHvhAcphKaZVQGVJYetxJLna7U+ID56ICP7uF
	O22we3pCa5kASpnPDamNt0lgjF9TbWvNOHMwzSzuQDKdwE2J6LE5Z
X-Received: by 2002:a05:600c:4ece:b0:4a2:40:8d2c with SMTP id 5b1f17b1804b1-4ac17b2c396mr392373365e9.26.1793869586740;
        Thu, 05 Nov 2026 01:06:26 -0800 (PST)
X-Received: by 2002:a05:600c:4ece:b0:4a2:40:8d2c with SMTP id 5b1f17b1804b1-4ac17b2c396mr392372195e9.26.1793869585957;
        Thu, 05 Nov 2026 01:06:25 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46489sm49581765e9.3.2026.11.05.01.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:06:25 -0800 (PST)
Date: Thu, 5 Nov 2026 10:06:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata
 budget check
Message-ID: <auxFXGVwY5IxlP5L@sgarzare-redhat>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-3-physicalmtea@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261103041134.33310-3-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _t4hOPtqOLOaswpf2nHpUDwGg6RqY8KLpQLzvxOd8S8_1793869587
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 03, 2026 at 12:11:31PM +0800, Jia Jia wrote:
>Extract the skb metadata budget check from virtio_transport_inc_rx_pkt()
>into virtio_transport_rx_buf_full().
>
>The helper retains the existing condition and will be reused by a
>following RX batching change.
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 43325d7aebbb1..2a9cfed085515 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -576,11 +576,17 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> 	skb_queue_splice(&new_queue, &vvs->rx_queue);
> }
>
>-static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>-					u32 len)
>+static bool
>+virtio_transport_rx_buf_full(struct virtio_vsock_sock *vvs)
> {
> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>
>+	return skb_overhead > vvs->buf_alloc;
>+}

As I pointed out in patch 3, I'm not sure we need this.
After we introduced the collapse, SOCK_STREAM should collapse rx_queue 
before hitting this, so not sure we really need this function.

Thanks,
Stefano

>+
>+static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>+					u32 len)
>+{
> 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
> 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> 	 * metadata. Check payload against buf_alloc to be sure the other
>@@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 	 * queue growth.
> 	 */
> 	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
>-	    skb_overhead > vvs->buf_alloc)
>+	    virtio_transport_rx_buf_full(vvs))
> 		return false;
>
> 	vvs->rx_bytes += len;
>-- 
>2.53.0
>

