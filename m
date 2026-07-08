Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9741931C
	for <virtualization@lists.linux.dev>; Wed,  8 Jul 2026 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508415; cv=none; b=If+M06zj7jGK4H80CBCjQFRlT04oFPoGKVFJI3e+sGlNa4xWLvN4yH4v0AEObt5LRcCEX/2gTdDXS978w77E/IPJkpiRUjNKIfIu4X6jHWrRB+p/jMpfHxURn/R1vxyh+3na+9SmmuS4QJiYgIlqMxlao1n2qqX+Fj/SAXM+Feg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508415; c=relaxed/simple;
	bh=/z59NgigRUT1t7wKHaZdXuB2mvaJJ3J4A7h7gfTV4bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DDdFef201QxIQl0K4IY1UA7Yfn1z96ysfWS7/A087eHMWACL1zVqVTGd/6q+/oUfK6jnN56vdchG4FAz9hsAw+/dPYwUsLZgWF6Utm1Fdod+RSutdn5H7gEoaGS394db1itP2g9efH5MtzHJTgGM2jWCip5fa6/uC46mrm9k4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ntlsj6Dp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ntlsj6Dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783508410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3XaPC9zE2h9RHiRdcpGWZIRteZhCC8n0qMjJjG4dNfo=;
	b=Ntlsj6DpUKXiebG8AFVxETxhUwmu7rQ8vgVdCFJdADVwapw153PwL4RFWVp933mvgN6s5d
	vo4p2vb7mcQVk2BdGpk+5kLiXsYrz/Hy2aN2aLyLH7ty7MANPfBUwnoaYMAaBBE80WajUz
	My6yIoi+bxaum+23ejeSh2XwDo1LH1U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-S0MuLzjBOtekJzZImlRCRA-1; Wed, 08 Jul 2026 07:00:08 -0400
X-MC-Unique: S0MuLzjBOtekJzZImlRCRA-1
X-Mimecast-MFC-AGG-ID: S0MuLzjBOtekJzZImlRCRA_1783508407
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47485fde05aso428342f8f.0
        for <virtualization@lists.linux.dev>; Wed, 08 Jul 2026 04:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508407; x=1784113207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XaPC9zE2h9RHiRdcpGWZIRteZhCC8n0qMjJjG4dNfo=;
        b=ILqtjBJbd0rwjcsFjN43B3CVLUkQFgi2I8vts2VCTYMGHXBF3wYlyTUIW+jx3PvWJJ
         4DFp7mEc80VMwH5cFGaXotQjqizUYoVK/hxUZ/66E/QhlKqZe0Q1ssppky+OwSNTTb8a
         qus/X76OSbXNgLGXy+TLS5O+YKGAiLZIAYUmvlM8miAT/cjyBHL+wz1rUNXOV8nWjNv4
         SkMXL1dbWhzV99ISqX7dr8T3qheYXwwkR/I+QllAP42vjCzpdxeBIK3Y5CcEZmcj1x6F
         yyBlHLciYMDIKqTJfSZ8rM6vzottENQti3T0dgcC0CYpWJOTXhL1SbviNMAbITHT1XTF
         +bDA==
X-Forwarded-Encrypted: i=1; AHgh+RrwY3qvg3EHwIHLhf0ZDIlYpPfiswjfcF/vCU94mJ6XRA9yk/HYzJMCJy3dqIXGCDFNjTeyOOpDaTvzYmMLZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2KaenCYs5ANB2kN2s3vc8OwHc025WbTh0BfOAabIlMG4+EzjU
	MFeChlcPT6AxUucDuklommz72jPxchuG30Q49ALnCm4dkbyHnPm/q6MmCD6A1qOliIXNikUKxIi
	/ANcixFYZ41dVm0H6ohTaQaS8671bRCsuwKpxaf+VAytXJsg++n4Olwydr+VxmcIDZ0s190oFPM
	vZ
X-Gm-Gg: AfdE7cmGZcvxQTJzhgtQfT23S7i/ScveymNpy3E5tFrtHpyoV0CM/KTxQpH0twYb8TB
	mcHTqD0aSp5A6NHUxElKoM80yyEPA8IJOqWQdk8Kxi8PIieg3c9RqTzCIoeOGnSznZQ0cleWDrh
	IikZw8LsFDFW9kBRjXMTODLBln3k6I/ekrE3y5SySCyadmdsyJ1G90IuRt0BWchVU5w3lLRaVUN
	TktD914zj7nnSx7/GbBBYUhF/PNMfMadOQyJF0/X8M8kYDPqJOp//ZOKnDj5QQT6iwUU2ofW0nE
	FY4G0DKghgZa+eHMAoyci0VqOieU9WKoVWLy+sk+wTL1nh0VQneUiJxlDrCi9cE/b1J/oK9QDWo
	o/Re3rAtwVXlveGrgoVZUpGpARAtt26H8
X-Received: by 2002:a05:6000:2909:b0:475:3a97:8e3c with SMTP id ffacd0b85a97d-47df0738de7mr2106814f8f.18.1783508407034;
        Wed, 08 Jul 2026 04:00:07 -0700 (PDT)
X-Received: by 2002:a05:6000:2909:b0:475:3a97:8e3c with SMTP id ffacd0b85a97d-47df0738de7mr2106594f8f.18.1783508404895;
        Wed, 08 Jul 2026 04:00:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039afacsm39865443f8f.19.2026.07.08.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:00:04 -0700 (PDT)
Date: Wed, 8 Jul 2026 07:00:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net v2 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <20260708065947-mutt-send-email-mst@kernel.org>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260708102904.50732-2-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U2HGSetfjDRCu13kIeHyZBT-WEjAsmBA3ggOw-QaKT8_1783508407
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2026 at 12:29:03PM +0200, Stefano Garzarella wrote:
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
> The collapse is triggered proactively from when the number of skb queued
> is close to exceeding the overhead budget.
> 
> A pre-scan counts the eligible bytes to size each allocation precisely,
> avoiding waste for isolated small packets. Partially consumed skbs are
> kept as-is to preserve buf_used/fwd_cnt accounting, EOM-marked skbs to
> maintain SEQPACKET message boundaries, and skbs already larger than the
> collapse target because they already have a good data-to-overhead ratio.
> 
> Walking a large queue may take a significant amount of time and cache
> misses, causing traffic burstiness. To limit this, the collapse stops
> once enough room is freed for this packet and the next one, but may
> opportunistically free more to fill each collapsed skb to capacity.
> 
> [1] https://github.com/stefano-garzarella/iperf-vsock
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Cc: stable@vger.kernel.org
> Reported-by: Brien Oberstein <brienpub@gmail.com>
> Closes: https://lore.kernel.org/netdev/618701dd023e$063de350$12b9a9f0$@gmail.com/
> Tested-by: Brien Oberstein <brienpub@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


this is the right approach

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2:
> - defined MAX_COLLAPSE_LEN macro instead of using a variable [Paolo]
> - added a threshold to avoid walking all the queue while collapsing
>   [Paolo]
> - collapsed the queue before calling virtio_transport_inc_rx_pkt().
>   While working on the threshold, I figured out that the check I was
>   introducing can also be used to proactively trigger the collapse, so I
>   moved the call to virtio_transport_collapse_rx_queue() before acquiring
>   the rx_lock to have also a better diff to simplify backports
> - improved code readability (removed `out` label, `keep` initialization,
>   etc.) [Paolo + other small stuff]
> - Brien kindly retested this version as well (thank you so much)
> ---
>  net/vmw_vsock/virtio_transport_common.c | 165 +++++++++++++++++++++++-
>  1 file changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..8becad81279c 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -26,6 +26,13 @@
>  /* Threshold for detecting small packets to copy */
>  #define GOOD_COPY_LEN  128
>  
> +/* Max payload that can be collapsed into a single linear skb, using the same
> + * allocation threshold as virtio_vsock_alloc_skb() to avoid adding pressure
> + * on the page allocator.
> + */
> +#define MAX_COLLAPSE_LEN \
> +	SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM, PAGE_ALLOC_COSTLY_ORDER)
> +
>  static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
>  					       bool cancel_timeout);
>  static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
> @@ -420,6 +427,145 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	return ret;
>  }
>  
> +static bool virtio_transport_can_collapse(struct sk_buff *skb)
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
> +	if (skb->len >= MAX_COLLAPSE_LEN)
> +		return false;
> +	return true;
> +}
> +
> +/* Iterate through the packets in the queue starting from the current skb to
> + * count the number of bytes we can collapse.
> + */
> +static unsigned int
> +virtio_transport_collapse_size(struct sk_buff *skb, struct sk_buff_head *queue)
> +{
> +	unsigned int target = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +
> +	while ((skb = skb_peek_next(skb, queue)) &&
> +	       virtio_transport_can_collapse(skb)) {
> +		unsigned int len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +
> +		if (len > MAX_COLLAPSE_LEN - target)
> +			return target;
> +
> +		target += len;
> +	}
> +
> +	return target;
> +}
> +
> +/* Called under lock_sock to compact the receive queue by merging small skbs.
> + * @min_to_free: minimum number of skbs to eliminate from the queue. May free
> + *               more to fill each collapsed skb to capacity.
> + */
> +static void
> +virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> +				   u32 min_to_free)
> +{
> +	struct sk_buff *skb, *next_skb, *new_skb = NULL;
> +	struct sk_buff_head new_queue;
> +	u32 saved = 0;
> +
> +	__skb_queue_head_init(&new_queue);
> +
> +	skb_queue_walk_safe(&vvs->rx_queue, skb, next_skb) {
> +		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +		u32 src_len = skb->len - src_off;
> +		bool keep;
> +
> +		keep = !virtio_transport_can_collapse(skb);
> +		if (keep) {
> +			/* Finalize pending collapsed skb to preserve packet
> +			 * ordering.
> +			 */
> +			if (new_skb) {
> +				__skb_queue_tail(&new_queue, new_skb);
> +				new_skb = NULL;
> +				saved--;
> +			}
> +			goto next;
> +		}
> +
> +		/* Finalize if this packet won't fit in the remaining tailroom,
> +		 * so we can allocate a right-sized new_skb.
> +		 */
> +		if (new_skb && src_len > skb_tailroom(new_skb)) {
> +			__skb_queue_tail(&new_queue, new_skb);
> +			new_skb = NULL;
> +			saved--;
> +		}
> +
> +		if (!new_skb) {
> +			unsigned int alloc_size;
> +
> +			/* Check after finalizing to opportunistically fill
> +			 * each collapsed skb to capacity, merging more skbs
> +			 * than strictly required.
> +			 */
> +			if (saved >= min_to_free)
> +				break;
> +
> +			alloc_size = virtio_transport_collapse_size(skb, &vvs->rx_queue);
> +
> +			/* Only this skb's data is eligible, nothing to merge
> +			 * with. Keep as-is.
> +			 */
> +			if (alloc_size <= src_len) {
> +				keep = true;
> +				goto next;
> +			}
> +
> +			new_skb = virtio_vsock_alloc_linear_skb(alloc_size +
> +					VIRTIO_VSOCK_SKB_HEADROOM, GFP_KERNEL);
> +			if (!new_skb)
> +				break;
> +
> +			memcpy(virtio_vsock_hdr(new_skb), hdr,
> +			       sizeof(struct virtio_vsock_hdr));
> +			virtio_vsock_hdr(new_skb)->len = 0;
> +		}
> +
> +		/* Cannot fail since src_off/src_len are within bounds, but if
> +		 * it does, discard new_skb to avoid queuing corrupted data.
> +		 */
> +		if (WARN_ON_ONCE(skb_copy_bits(skb, src_off,
> +					       skb_put(new_skb, src_len),
> +					       src_len))) {
> +			kfree_skb(new_skb);
> +			new_skb = NULL;
> +			break;
> +		}
> +
> +		le32_add_cpu(&virtio_vsock_hdr(new_skb)->len, src_len);
> +		virtio_vsock_hdr(new_skb)->flags |= hdr->flags;
> +
> +next:
> +		__skb_unlink(skb, &vvs->rx_queue);
> +		if (keep) {
> +			__skb_queue_tail(&new_queue, skb);
> +		} else {
> +			consume_skb(skb);
> +			saved++;
> +		}
> +	}
> +
> +	if (new_skb)
> +		__skb_queue_tail(&new_queue, new_skb);
> +
> +	skb_queue_splice(&new_queue, &vvs->rx_queue);
> +}
> +
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> @@ -1354,12 +1500,29 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  {
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  	bool can_enqueue, free_pkt = false;
> +	u32 len, queue_max, queue_len;
>  	struct virtio_vsock_hdr *hdr;
> -	u32 len;
>  
>  	hdr = virtio_vsock_hdr(skb);
>  	len = le32_to_cpu(hdr->len);
>  
> +	/* virtio_transport_inc_rx_pkt() rejects packets when the per-skb
> +	 * overhead (skb_queue_len * SKB_TRUESIZE(0)) exceeds buf_alloc.
> +	 * Proactively collapse the queue before that happens.
> +	 * No rx_lock needed: lock_sock is held by caller, preventing
> +	 * concurrent enqueue or dequeue.
> +	 */
> +	queue_max = vvs->buf_alloc / SKB_TRUESIZE(0);
> +	queue_len = skb_queue_len(&vvs->rx_queue);
> +	if (queue_len >= queue_max) {
> +		/* Walking a large queue may take a significant amount of time
> +		 * and cache misses, causing traffic burstiness. Limit the
> +		 * collapse to freeing room for this packet and the next one.
> +		 * It may free more to fill each collapsed skb to capacity.
> +		 */
> +		virtio_transport_collapse_rx_queue(vvs, queue_len + 2 - queue_max);
> +	}
> +
>  	spin_lock_bh(&vvs->rx_lock);
>  
>  	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> -- 
> 2.55.0

