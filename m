Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793340;
	b=t5Fgzjn9xNpKju33qFCnhuRWn2bwgnpu97orUV0/3B8u/i6ZPX2B6bOFGC2G3A/URrmp
	 sK7lM3TzYO+NZ1EXoYdovQbuFkeKquhOmDB8Z9rltZj32jV/Rb3ioTa4h8V0SEVDVLArs
	 77afFJ1XbzV/HL5ts+SYsGcylopICS1AFj9XNqwCJU1ixnVprxVQFqmU82OWJDDULXKZk
	 1ycXAo7P9Yg6Vel3aNUK8sO0aWCkkil1zfFz9DJ+ZzPtgT6wbC1ENI/o0jBKL/NwhRQ33
	 rmY5DThgrXR+7MBn91iV5I/TFjmaYJXnv5FjBzuU+b8rg0rCuT6Fcp3TDuS8nezpUTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793340;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=gOOrV9m6B3oUuMrsbApNieFqj9oSqnExm9VloXX8/Mw=;
	b=jC19YV7K5hr85QHWhsPyOiVJVRMbNwE0GiwnjxYrPYqzgA3uDncGf/rhKd249umfRL40
	 Uccv68VNFkuWUCTboZ9zN3/THRFAdkJxgNYpr5k402F9zh+7/0Jn6rdueFZ1xS4XAC+So
	 rrVgt7XAO79GjJSi9wQtymTQW4lFJkq0Q2MTfpxa2PcFhAi0nHvg5i+U4BI+xiUmDiXXU
	 WyHj9Pm/v2eTxqu0e0rbjeX/MVXZXWovddNuT7luvRSQYRuke7+cmAT5YiAK7OXUgORRb
	 MWdjABw4EXvXx6ybOUqYNeOJyIthkVqs2Lr5qC9ew8io6IglU+mMRA/UmRLvlSToqog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WmpeXhUQ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE34606A328
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 11:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE34606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WmpeXhUQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793793337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOOrV9m6B3oUuMrsbApNieFqj9oSqnExm9VloXX8/Mw=;
	b=WmpeXhUQISZLrQN7DHVdQVyamfT7RepvTrC2XCMRFjl+1yg/ZaLhl5o/4ub6yCepzflX5R
	fr7btFbpZJcu8EYJHZR+mgbyIThjPl9UptKfndS7rgV1+t37iMsK7Q1wkPK/W8+WCl2mVn
	nB17PieFsnovqa7xw9rD8CzMwBsel44=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-ALEfU0KCMiWcufnVI43kRg-1; Wed, 04 Nov 2026 06:55:28 -0500
X-MC-Unique: ALEfU0KCMiWcufnVI43kRg-1
X-Mimecast-MFC-AGG-ID: ALEfU0KCMiWcufnVI43kRg_1793793326
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a214a5f8a1so8453305e9.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 03:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793793326; x=1794398126;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOOrV9m6B3oUuMrsbApNieFqj9oSqnExm9VloXX8/Mw=;
        b=c30ADz4o8I9F9MjtOiogr8oF7Sz7O+ZDJyOjJm51xlpIJlzB3pW1XOmSOqz/f0qZa7
         NYHmpZF6FntEnLzDnydoBWy/s5DiltIGgmrg4C+KSclEZTx3Pkgzir0dct8JcX/d5A61
         pKUlIs00T82ZAAxr8UWlA6w/pTnfloeZ2uTnMqVUdM2VZeZYhA1uhD91czunhkB6JnEO
         bQ5oom9kIt/KJDtEF38emEhWigtwQbkF6O74jwu2+jdC76zc3ysFlUIbR9vt0u250DQY
         EE6qksW5Cv1UNgsadVo4+huuOoHEnHtFCiZ7rNLYqZowpTKA6Gp1HQan+9VQt1/5kcLE
         bv1A==
X-Forwarded-Encrypted: i=1; AKwUvBz54MEm34KZl2BC37H2LSNqGP+64CH1NLN+6962dsLFSoQhOb/FPquzHNjD64TnVHPmKghd3/kFZb+NVkkN4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ctjZrc8iRSdzEpuKdoU0Om1b12DXzdqGflxi3w6cSwP6d8GN2
	HYfKQQeL+IpoDN8ueX4SKwBmgvCxJIY56/6YESXRR/IEP1Y+BRi0YtqcM4rDFYolg9ZJjzWrtlx
	8mVeFvQNasLCRjRBxXj8Rf6KO5Rrorlbvb9p9SQvbAOrRrnoiJXcmdo/F5tEGc29qkxRq
X-Gm-Gg: AYBFou2XjFucx31HZYojncLeD5APn02CjWXXf7wO3yA84B1mt0ORhgR+K/cIWkCmJ1I
	YpbVX75RdNfOBlhDe5uwQCJn+m0QatDS1vsrxMrnAlLAN3lp0PeXbCSndQvEfnetlepDU3zvjVt
	OMvdLaa0QOiURmM0ID8D26NOiexuF5REAkrRuBkgcwiyytMFU0Bmq/xYwMj3whK5JgURbQF4h3M
	d77Ko87UPZ0QR3udEtigUGvj61nkx4svEb50FGc8c8Eyrfa/Jzk+MT/jB4On0WaZNp5616fDfps
	jNnYx42Km/rqs6rc4uxZLAnWI6bMQr4Ds3eaD6zHDEvN28tGIqj6eyscz4xYYRYHJkKQwb5rzvK
	psoWgx5MLxavXpNgtYesGCgbYkWIfWWOcZqvGOl5V4g==
X-Received: by 2002:a05:600c:1d28:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4ac1793fb6bmr421627815e9.16.1793793326174;
        Wed, 04 Nov 2026 03:55:26 -0800 (PST)
X-Received: by 2002:a05:600c:1d28:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4ac1793fb6bmr421627415e9.16.1793793325683;
        Wed, 04 Nov 2026 03:55:25 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4533873f0sm45067805e9.4.2026.11.04.03.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:55:24 -0800 (PST)
Date: Wed, 4 Nov 2026 06:55:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	"David S . Miller" <davem@davemloft.net>,
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
Message-ID: <20261104065405-mutt-send-email-mst@kernel.org>
References: <20261004235101.1464007-1-4ncienth@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261004235101.1464007-1-4ncienth@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kl3_9_iPWRIEAkaTNxBVhC193gE30XC9DZd3k0jfkZA_1793793326
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2026 at 08:51:01AM +0900, Daehyeon Ko wrote:
> vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
> descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
> rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
> guest controls the descriptor length and hdr->len independently.
> 
> A guest can therefore provide a 64 KiB descriptor while declaring a zero
> payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
> remain unchanged, and only the fixed queue-entry budget limits retention.
> This is not a lifetime leak: the skb is freed when dequeued or at socket
> teardown.  Repeating this across connections can nevertheless exhaust host
> memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
> a 262,144-byte receive buffer; a full-payload control retained 265,984
> bytes.
> 
> Vhost previously read hdr->len and allocated pkt->buf from that value.  The
> conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
> from the descriptor length, introducing the allocation-accounting mismatch.
> 
> Copy the header into a stack object and validate hdr->len before allocating
> the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
> capacity no longer determines queued memory.  Check payload_len against
> len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.
> 
> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>


Weird that this wasn't applied in net yet.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

let me know if you want me to apply this.

> ---
> Changes in v3:
> - clarify that queued skb memory is under-accounted rather than leaked, and
>   explain why a zero payload is the strongest case;
> - remove v1-to-v2 implementation rationale from the permanent changelog;
> - correct the Fixes tag from ab9aa2f3afc2 to 71dc9ec9ac7d; and
> - make no code changes.
> 
> v2: https://lore.kernel.org/netdev/20261004073419.4039011-1-4ncienth@gmail.com/
> 
> The issue was identified during an LLM-assisted source audit and confirmed
> with a focused in-kernel probe on Linux v7.2.  The code diff is
> byte-identical to v2, so its existing build and runtime results remain
> applicable.
> 
>  drivers/vhost/vsock.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index abed1fbcf66cc5..35f75e23c7497e 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -364,7 +364,7 @@ static struct sk_buff *
>  vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>  		      unsigned int out, unsigned int in)
>  {
> -	struct virtio_vsock_hdr *hdr;
> +	struct virtio_vsock_hdr hdr;
>  	struct iov_iter iov_iter;
>  	struct sk_buff *skb;
>  	size_t payload_len;
> @@ -382,34 +382,32 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>  	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>  		return NULL;
>  
> -	/* len contains both payload and hdr */
> -	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> -	if (!skb)
> -		return NULL;
> -
>  	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
>  
> -	hdr = virtio_vsock_hdr(skb);
> -	nbytes = copy_from_iter(hdr, sizeof(*hdr), &iov_iter);
> -	if (nbytes != sizeof(*hdr)) {
> +	nbytes = copy_from_iter(&hdr, sizeof(hdr), &iov_iter);
> +	if (nbytes != sizeof(hdr)) {
>  		vq_err(vq, "Expected %zu bytes for pkt->hdr, got %zu bytes\n",
> -		       sizeof(*hdr), nbytes);
> -		kfree_skb(skb);
> +		       sizeof(hdr), nbytes);
>  		return NULL;
>  	}
>  
> -	payload_len = le32_to_cpu(hdr->len);
> +	payload_len = le32_to_cpu(hdr.len);
> +
> +	/* The pkt is too big or the length in the header is invalid */
> +	if (payload_len > len - sizeof(hdr))
> +		return NULL;
> +
> +	/* Allocate only for the payload declared in the header. */
> +	skb = virtio_vsock_alloc_skb(payload_len + sizeof(hdr), GFP_KERNEL);
> +	if (!skb)
> +		return NULL;
> +
> +	memcpy(virtio_vsock_hdr(skb), &hdr, sizeof(hdr));
>  
>  	/* No payload */
>  	if (!payload_len)
>  		return skb;
>  
> -	/* The pkt is too big or the length in the header is invalid */
> -	if (payload_len + sizeof(*hdr) > len) {
> -		kfree_skb(skb);
> -		return NULL;
> -	}
> -
>  	virtio_vsock_skb_put(skb, payload_len);
>  
>  	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
> 
> base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
> -- 
> 2.55.0

