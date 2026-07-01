Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0762374E7A
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923688; cv=none; b=CgzghzMw+2gt/7lVTd+shrsbwMSdPq61cDjihSY43LY1SxVezHwgoijb/igIKFOnYIGJJ29bz1WLJpoNcKzP05xwRQ3QfLoyr11eSnHPZG191vjpu7zt38YRn6t/JX1D96H88O8x0SKsDcANp/t9drOjafoNjpdAwoddZh8GS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923688; c=relaxed/simple;
	bh=IgxZJkAX83JEoUd7zhGT0HcnVVm/OyxbDgl2DsEOM60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjnj/gkQyFYQYOf4/leIL6QWGKvaIj8yndyU8NHDESSop5XX3dGl50b5YVBMTmCeyLwohzklu80acXdBpQLzzMyi5RDp1JpkaZNAW0AflWaQpClpF7FO3OLU5QSk9CKdKcbiCKPgUNieUJLkC3Ig5oK1SjG7CktzbPeWJtpkrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9jREve/; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9jREve/"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9f829d75aso548776a34.0
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923683; x=1783528483; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1aq9FrQ86evQJPeL1WihgSaD08JDHC1d1jP4T/r4tmg=;
        b=P9jREve/2TPT4yETOncDNI0vAWwXBwG2JqmUvVaup4zZAw0SxKdYrliv/rH/kDdyLs
         jagc5d9LmZpf9U8lqK4q3hrNQb8CrSG1FtT8qCCL42Vzz3abClWsIl9VIDdHiw/SDKhs
         csMtiPlLwthF0LMkdYcagNbkiTn0HWVBEtCVbD30aazxlSoXrCJXbR1MNjr4M15Z/YY/
         TxHJlYTeBbINay5xRDxGle6jQXD7Qa3JuZDO8g3K+IJPnpSEwyiH/JK9JJBqcjR/OntF
         /f8x1pjbYmTnXJgYjavQVuPu7xbwynFYIP7KGgIQ+YYXccUkwmDUutB8vouW6Vu2JrV3
         i78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923683; x=1783528483;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1aq9FrQ86evQJPeL1WihgSaD08JDHC1d1jP4T/r4tmg=;
        b=ekvImGq2o8vf+Cg2Q8UIQKcdKHKR16UerWAQ3n2MhOhiVqWWiw/PlF7Ec89jjqHBKQ
         UF6J3rSduP5GB/5MxT7YTX0NvRFjMFu0ygbLI1Nnd0kIJwt6sUx/Swe9UZprbghbim3J
         glLPIXvMDkEztHDE4f+cQCR1JQAteqvV+eYx4bTP9sPF9ijCy0aTd9P1E8JN+wtZfKd9
         rx637hwRgdtKCOCwFjj8W01BborVr8b8migE3sB1bllQQZBBfzgLlNA1AOMb8THwnHNG
         nkuR6YJdbZUSFKlU9gX5bYYVG3KrbhUb2A768SeoTtTcuKTLAth7RPDWZUNxe5a77E17
         nLhA==
X-Forwarded-Encrypted: i=1; AFNElJ+DvU5V+Q21hc9QLhROuBs7vJG845Xq5IN+R/WqdXnKrL0nXHbHeyieKMp8pOedc3g/eu92G7+7ywouxPH/Ew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3myAt7YqZrbnTeor95aYX91tnmIBrA+5eXj+zPYYpgDkQldAQ
	RzfU/9x0I3pIaY4RgvRP9oinGY50kmNclaWSW/y8bMJwNRYN+eEVFSoW
X-Gm-Gg: AfdE7cmqTTKtse+tGVqkI9/TmKSAHGfGLlmlf8iKn9aAftyJ3QPmR5KrDHl4uvDosdl
	bUuiJkXJ/dvNQCRvFeke1zQYfykRr6v0eVRty6nmU1JSBkgdbfGUWlRu7xt3DT/EHBNADDw02Rb
	0PL+2QDIbOe8E1/OC+/Juw+ZHl22H4RA7hod3eY3T/gH1t2IDBNwZtzvCo3s8qX5+J7Th/v8Kq7
	wgEbWznglCLgNjRSHAPxpXkysVaKsxADcJJfownSPG3MfnRaDZGk42+vfdRGIyIPjb0kQxKh6Kf
	9+XkyN1yJwpPd6syt3OPbhh1hUcqjsR0a3FWafqjvRMNlpMsc2vETdZ4O05ya7AjVY4W9juAzGz
	XsnvFiOEOeJDctr0SGWqIMwnTL9oMHBdpw4hIUBMU/5+JhGLCtv/Zc6Rmn+E58wSNwccrDZ+n4q
	EdAQhHDtYGhr0fr+t3BaOz+cH4flcAMKevcQ==
X-Received: by 2002:a05:6830:3784:b0:7e9:c2d8:1789 with SMTP id 46e09a7af769-7eb504be755mr1070845a34.18.1782923683262;
        Wed, 01 Jul 2026 09:34:43 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542d017csm410999a34.8.2026.07.01.09.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:34:42 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:34:35 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626134823.206676-2-sgarzare@redhat.com>

On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:
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
> +		struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +		u32 src_off = VIRTIO_VSOCK_SKB_CB(skb)->offset;
> +		u32 src_len = skb->len - src_off;
> +		bool keep = false;
> +
> +		if (!virtio_transport_can_collapse(skb, collapse_max)) {
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
> +		}
> +
> +		if (!new_skb) {
> +			unsigned int alloc_size;
> +
> +			alloc_size = virtio_transport_collapse_size(skb, &vvs->rx_queue,
> +								    collapse_max);
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
> +				goto out;
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
> +			goto out;
> +		}
> +
> +		le32_add_cpu(&virtio_vsock_hdr(new_skb)->len, src_len);
> +		virtio_vsock_hdr(new_skb)->flags |= hdr->flags;
> +
> +next:
> +		__skb_unlink(skb, &vvs->rx_queue);
> +		if (keep)
> +			__skb_queue_tail(&new_queue, skb);
> +		else
> +			consume_skb(skb);
> +	}
> +out:
> +	if (new_skb)
> +		__skb_queue_tail(&new_queue, new_skb);
> +
> +	skb_queue_splice(&new_queue, &vvs->rx_queue);

I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
when adding to rx_queue?

Best,
Bobby

> +}
> +
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> @@ -1363,8 +1494,21 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  	spin_lock_bh(&vvs->rx_lock);
>  
>  	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> -	if (!can_enqueue)
> -		goto out;
> +	if (!can_enqueue) {
> +		/* Try to collapse the receive queue to reduce skb overhead and
> +		 * make room for this packet.
> +		 * Unlock rx_lock since the collapse may sleep or, in any case,
> +		 * take some time to collapse the skbs, but this is safe, since
> +		 * sk_lock is held by caller so no one else can enqueue or
> +		 * dequeue.
> +		 */
> +		spin_unlock_bh(&vvs->rx_lock);
> +		virtio_transport_collapse_rx_queue(vvs);
> +		spin_lock_bh(&vvs->rx_lock);
> +		can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> +		if (!can_enqueue)
> +			goto out;
> +	}
>  
>  	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
>  		vvs->msg_count++;
> -- 
> 2.54.0
> 
> 
