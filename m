Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07452282F3A
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813194; cv=none; b=QKBEhLLzUMBjIV7T84gt317h8zpEqUmrLART/Nezph+m2+M7KPwj6EFkXw9/5/N3myI8YStWloHRxRcnWLlcSO1OWDVeKrTvrX4lLCdhksQHzRp8MzegGUVNXsmYwdtUmWFXVgvAvaPPRu25vR9Y8YTqexOqDnnsGwYAtT9GFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813194; c=relaxed/simple;
	bh=NbDEHp0gquR5Nq2A/cm+7E2L5SZ1Jhgmv94kZhkUywY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkvklrK4z6OR1CfuMJxMQwdORDEPjHHxfDRb191YIz7iyqyS3bZ3Vi4IJqklfcNrOdc1CtNdjL1roD3i4IUPuwMfOvh404g6GyM9MagrP0l0wFDmo/u3ITk9OHQejUMIoAPzgUth9T0+LOiiQ1slVRmjTQ5cI/FUMGUF3zqNZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5umb2BG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5umb2BG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782813192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wTpFP+uURpV7Es5gbDN0xr6tXZLlBB9VR1MULvKZf4=;
	b=C5umb2BGPMCRvH/AL2ijiS3Iy2RTgFJyXyE2AQmrw4nv273PJAV/8bLBAf21d5oeMWTcc7
	Y7NXcaq9vtEjPi7NU+Y2CI1HOFaY9COuAwFATAjL0AWE2NdOBl3Rcbb9wsOrvrgX2NmEmz
	6dMeiw8oDooP6bpOg74y/vcMmkZUeRg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-NSRaXPS2NPSDx5EmckHS1A-1; Tue, 30 Jun 2026 05:53:09 -0400
X-MC-Unique: NSRaXPS2NPSDx5EmckHS1A-1
X-Mimecast-MFC-AGG-ID: NSRaXPS2NPSDx5EmckHS1A_1782813188
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47162f83c75so281084f8f.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 02:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813188; x=1783417988;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wTpFP+uURpV7Es5gbDN0xr6tXZLlBB9VR1MULvKZf4=;
        b=A8EuDz+f5kQcJnSbuLW5nT0ZtqnIkMQBji2q3u9b0wpvtChMDKhzIDYKDHeFveNnJY
         1BFeYx28vF5df2PV4XDA52rXhf9EchYrrtjirY+RwKvvIed7m0gJm4T9ZLcWFf+cHl71
         Xb9Vuds0co9cONzQPCA2Rvg5UTUHz/dsYIegk2PjR4Rd6aSuajeuV9Xuy8IG+JL49VDn
         hyILbhVdMEfjuF2Zsme+atqmSKl/BbNA6mHMeuq/UhrKMjpVVnyqvV46//wPbNbj9udv
         iyD/7eefKlYhgFjLyoHw28YdLAYqCEQM2IDPITQN6+I5D3VZKC8p7u+qf99diE6vjPfm
         nIDA==
X-Forwarded-Encrypted: i=1; AHgh+Rr06TnabT0gGPeNkuDSmeKtTQVpoz3mYgRSEenkS2b3a4tPa73V90/jZirXR9NDEiyzsiYBNX+PcMEBovCx8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqMjJF0vn+YXtVnjIUIUWb5QNDeETTqq8pKGM6FJO3mZBsQqN2
	zymNL4QgfBvyPua6UpvYWztupmOxkNSuSV0S0jsL1/85M2YD5ExAUt9Z5Y0E7zDxfqhBr4/h/XU
	hlnKMpu5AankDRSBW7G9Rnt/axSxfDgA+7egbDpJWW4l+4mkVJD++4wJFh5l8hLvOfpid
X-Gm-Gg: AfdE7cmlXfxUPM3lRZnvh1Nvi1gUK+/DmiqPMOOrbfmDzQ9OOD1O8IvioW7Lkx9fTX4
	ilch8CpcqwA4TVgNcfJcpFd0EMSVxTI+w959Jdr5Kg+pFfBUiSt1a5/q8LQb65cvKowokDETDXK
	tQtyhj2t/6OqwYLbO+IuVdGb6f5ZSWUfV2hytNwkd7MI5e8O1EwRnd/e158dJ4xp/Pe5Asu6WIJ
	CQh2+8BMGXk6UMbkqWH75m/rlfpW0Uz11kfVQNHUec9DmH0olZ+fdyzULfe96U1c227FNMGR7ub
	dr9taDHAEkp0LOhdg5Wxdar51G8HrGgpwoOk78nW1rpaHmxL0m0IKIBIPZV28sjWKdEvwcYrya9
	3hONvxJI7twPlsW4+NoSFIiyWYGI82F8YYiVWUAV74Utq2gEWADXBvkw0AeuTJlcuATRejgMGDv
	VDDe67ZfRd+Q==
X-Received: by 2002:a05:6000:1847:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-475f4fb5d50mr1344045f8f.5.1782813188226;
        Tue, 30 Jun 2026 02:53:08 -0700 (PDT)
X-Received: by 2002:a05:6000:1847:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-475f4fb5d50mr1344016f8f.5.1782813187784;
        Tue, 30 Jun 2026 02:53:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf65sm6669391f8f.21.2026.06.30.02.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 02:53:05 -0700 (PDT)
Message-ID: <6a6be4b0-e02d-46ca-b8bf-c27bd681d253@redhat.com>
Date: Tue, 30 Jun 2026 11:53:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under memory
 pressure
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, stable@vger.kernel.org,
 Brien Oberstein <brienpub@gmail.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260626134823.206676-2-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FS7EQMw1UGR7Asw7W8UScicK3gInm-kF_zz5-jY1R9Q_1782813188
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 3:48 PM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When many small packets accumulate in the receive queue, the skb overhead
> can exceed buf_alloc even while the payload is within bounds. This causes
> virtio_transport_inc_rx_pkt() to reject packets, leading to connection
> resets during large transfers under backpressure.
> 
> The issue was reported by Brien, who has a reproducer, but it is also
> easily reproducible with iperf-vsock [1] using a small packet size:
> 
>   iperf3 --vsock -c $CID -l 129
> 
> which fails immediately without this patch but with commit 059b7dbd20a6
> ("vsock/virtio: fix potential unbounded skb queue").
> 
> Inspired by TCP's tcp_collapse() which solves a similar problem, add
> virtio_transport_collapse_rx_queue() that walks the receive queue and
> re-copies data into compact linear skbs to reduce the overhead.
> 
> The collapse is triggered from virtio_transport_recv_enqueue() when
> virtio_transport_inc_rx_pkt() fails. A pre-scan counts the eligible bytes
> to size each allocation precisely, avoiding waste for isolated small
> packets. Partially consumed skbs are kept as-is to preserve
> buf_used/fwd_cnt accounting, EOM-marked skbs to maintain SEQPACKET
> message boundaries, and skbs already larger than the collapse target
> because they already have a good data-to-overhead ratio.
> 
> [1] https://github.com/stefano-garzarella/iperf-vsock
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Cc: stable@vger.kernel.org
> Reported-by: Brien Oberstein <brienpub@gmail.com>
> Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
> Tested-by: Brien Oberstein <brienpub@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 148 +++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..304ea424995d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -420,6 +420,137 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	return ret;
>  }
>  
> +static bool virtio_transport_can_collapse(struct sk_buff *skb,
> +					  unsigned int size)

Why passing a `size` argument here? AFAICS the actual argument is always
a constant and IMHO rightfully so.

> +{
> +	/* skbs that are partially consumed, mark a SEQPACKET message boundary,
> +	 * or are already large enough should not be collapsed: they either
> +	 * need special accounting, carry protocol state, or already have a
> +	 * good data-to-overhead ratio.
> +	 */
> +	if (VIRTIO_VSOCK_SKB_CB(skb)->offset)
> +		return false;
> +	if (le32_to_cpu(virtio_vsock_hdr(skb)->flags) & VIRTIO_VSOCK_SEQ_EOM)
> +		return false;
> +	if (skb->len >= size)
> +		return false;
> +	return true;
> +}
> +
> +/* Iterate through the packets in the queue starting from the current skb to
> + * count the number of bytes we can collapse.
> + */
> +static unsigned int
> +virtio_transport_collapse_size(struct sk_buff *skb,
> +			       struct sk_buff_head *queue,
> +			       unsigned int max_size)
> +{
> +	unsigned int target = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +
> +	while ((skb = skb_peek_next(skb, queue)) &&
> +	       virtio_transport_can_collapse(skb, max_size)) {
> +		unsigned int len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +
> +		if (len > max_size - target)
> +			return target;
> +
> +		target += len;
> +	}
> +
> +	return target;
> +}
> +
> +/* Called under lock_sock when skb overhead exceeds the budget. */
> +static void virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs)
> +{
> +	/* Use the same linear allocation threshold as virtio_vsock_alloc_skb()
> +	 * to avoid adding pressure on the page allocator.
> +	 */
> +	unsigned int collapse_max = SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM,
> +						  PAGE_ALLOC_COSTLY_ORDER);
> +	struct sk_buff *skb, *next_skb, *new_skb = NULL;
> +	struct sk_buff_head new_queue;
> +
> +	__skb_queue_head_init(&new_queue);
> +
> +	skb_queue_walk_safe(&vvs->rx_queue, skb, next_skb) {

If the queue is relevantly big, walking all of it may take a significant
amount of time/cache misses and causes traffic burstines. I think you
could add an additional stop condition, i.e. when the current queue size
is below a reasonable threshold (allowing the current packet to be
inserted plus some more slack).

/P

> +		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +		u32 src_len = skb->len - src_off;
> +		bool keep = false;
> +
> +		if (!virtio_transport_can_collapse(skb, collapse_max)) {

Minor nit, possibly something alike the following lead to more
compact/more readable code:


		keep = !virtio_transport_can_collapse(skb, collapse_max);
		if (keep) {

> +			/* Finalize pending collapsed skb to preserve packet
> +			 * ordering.
> +			 */
> +			if (new_skb) {
> +				__skb_queue_tail(&new_queue, new_skb);
> +				new_skb = NULL;
> +			}
> +			keep = true;
> +			goto next;
> +		}
> +
> +		/* Finalize if this packet won't fit in the remaining tailroom,
> +		 * so we can allocate a right-sized new_skb.
> +		 */
> +		if (new_skb && src_len > skb_tailroom(new_skb)) {
> +			__skb_queue_tail(&new_queue, new_skb);
> +			new_skb = NULL;

Possibly introduce an helper for the above 2 statements?

/P

