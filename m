Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB713C76A6
	for <virtualization@lists.linux.dev>; Sun,  6 Sep 2026 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788667637; cv=none; b=Aj3pGQQFJ8zFH0aEeOkf72EjISkenvZvLIdRnXPZoxlw96W8Z0/cDOW9h06ubE/lEILDnT1u/MUqHuo6Toij5UnfDdkB6Jxmv+v5W4fUyBy4kxn0fTlgHqhSWcwb9LiJoQ9/xuoBXyTfc+ptzqeGCtjzGXD2bkxz2H2ZtGfwbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788667637; c=relaxed/simple;
	bh=urZRa0Lfe+xl3SjCEj+L3fJXmoqIEoagmk55A23lm9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VNt6HDoN4DzlF5z4el3jzpS23nYRciBDwQxrbWUJ7MbcG6T0dg3JSOHpS9B2JcuL39oYEVP/oTuwD9CKKCSqB3/TiU29y/ypntlCilPUmK0+c4IVF3kO84Qq5O6B+2evIepKICcAhOkBQn4hxxpjJVWi1N8FQAOH8h1E9d/kBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXtCEXQx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXtCEXQx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788667634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ByaWx9fs3FmH7s/refQwfhbkWp4eQ2bqZDqw/zD/lsU=;
	b=NXtCEXQxi+aBHBZvRxwnPK2Vkj1egdGXbOEF8AaM9dChUwpaBAecsyZ7ihfiE3/vI0ktwd
	i9drwPymtj8gaqCb8ROT5yS9k5sUMDZO8yFDWeBwu5Z6wr/i+fuBtwkMKmmlUPQdXvAXT8
	ogZXro+sXscaq2QQupvo2fr5EH+P/fU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-cwfovYIqOOCyHteOWoXuCQ-1; Sun, 06 Sep 2026 00:07:12 -0400
X-MC-Unique: cwfovYIqOOCyHteOWoXuCQ-1
X-Mimecast-MFC-AGG-ID: cwfovYIqOOCyHteOWoXuCQ_1788667630
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so27933685e9.1
        for <virtualization@lists.linux.dev>; Sat, 05 Sep 2026 21:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788667630; x=1789272430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ByaWx9fs3FmH7s/refQwfhbkWp4eQ2bqZDqw/zD/lsU=;
        b=m/i5nHKcMBfiMEusTec2BhZXDSw5v3Rjym2iRc7dDncxAR+pSwbVCD9CvwjM+zy1xu
         Ab9oBUKrG6+cBWwA2sI3fzh7zAP0vBJZ85y+afPCOGxxmWnOmMhtGywTVXa8CBQEWCo8
         O4FrLOmVFEXxHQ0AbUp0r6yPjwOs6tMS6iBEaXjQTc+rjQppIB5ui8mlqexEF32h9h3n
         VGjD7vhI1/tUa5mmunX5UCsnhP/t+rzxeF30eqDhokpPIx8uDAYdGUcb7+682eVCnhXU
         5uih56X075DAoJagUOJyyPi2606Or0OIchHWeXYBosB5w1qspgo+PSB48tQ0IYBDnqm6
         LBUA==
X-Forwarded-Encrypted: i=1; AKwUvBzMCmYu+hRsfeSC9PZrLh+7sjJ+L47mRUIRXlmRgXGBQSiAHL2QsS+MWQu37hTHeUOg5btYEvpgyjXlmkMv7A==@lists.linux.dev
X-Gm-Message-State: AFuF++kcY9MZp/dBgamXyF7vsmFc6neMrR8vx1EWtR7YVgYy7oCDX/qH
	LY3KF0e75fypGeNw8ASqkQwEcW+LJtHi5+nIQteui2rSi5gO94wdMEC6MBES9lU5eZSmQ1tRlZR
	chnuRbRCM6IZzejKBdlbnugWoKZH78up+DbPYR1srlhLo4EMfOGgLgMS7J9iR9V/mlBx7
X-Gm-Gg: AYBFou3vMY4LprqmbEgwdk56tqy7Dbwent7E9dYyS7CZs6ZxQvDtMl1KNnRlz95jvTI
	nO4F7l9iyNQDZKdgDpUSjxhMyWV3rH/ObLGu9LKMui3HQXMWOWR5TudenlFYY4ZTvFIzx6Mulg6
	TamTukzvHRtMGux3pjvRCBPEL6/oXDVRilPrzQ92Vrh9aiwQ3wsgHy7iLLPVnveUx6+3pyoMfp8
	hcYUKZyE3n6Nb/ZvSnycbjvcpfaUFNLmIlf6UmiXRZ5g2JbdUVBE+CjagxteRKuO7Oeb13Jf3/e
	JmgNHHlAOqwL08GVeVIjg5qWagbHS6K51HnSiWFj+07SSwXP47PiCq9dCdtnQV7F4vEwXmAI/Gw
	6CT1A9GWGtQVOyzxZb31gPwY=
X-Received: by 2002:a05:600c:3b9e:b0:49c:fc6c:be1a with SMTP id 5b1f17b1804b1-49cfc6cc121mr110344615e9.32.1788667629711;
        Sat, 05 Sep 2026 21:07:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3b9e:b0:49c:fc6c:be1a with SMTP id 5b1f17b1804b1-49cfc6cc121mr110344405e9.32.1788667629232;
        Sat, 05 Sep 2026 21:07:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm244482565e9.3.2026.09.05.21.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 21:07:08 -0700 (PDT)
Date: Sun, 6 Sep 2026 00:07:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: sgarzare@redhat.com, stefanha@redhat.com, jasowang@redhat.com,
	eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vhost/vsock: batch RX used-ring updates
Message-ID: <20260905234007-mutt-send-email-mst@kernel.org>
References: <20260906013659.517889-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260906013659.517889-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YYcnESUHk1vWYWwqDLa_PNnjeRbp9wF6mdhhtnKmyDo_1788667630
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Sep 06, 2026 at 09:36:59AM +0800, Jia Jia wrote:
> vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
> buffer even though it delays the Guest signal until the worker finishes.
> Each call publishes one used entry and updates the used index separately.
> 
> Collect the completed buffer heads in the arrays already allocated for the
> virtqueue and publish them with vhost_add_used_n().  Bound the batch by the
> ring size and array capacity.  Flush when the batch reaches its limit or
> before leaving the worker.
> 
> Each used entry describes one completed RX buffer and keeps its actual used
> length, so set nheads to 1 for every entry.  This patch does not change
> negotiated features or compress multiple buffers into one used entry.
> 
> This patch is limited to the current skb-based vhost-vsock RX path.
> 
> Performance:
> 
> The test used vsock_perf with a fresh Guest for each state and 20 paired
> runs. The Guest receiver used:
> 
>   vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1
> 
> The Host sender used:
> 
>   vsock_perf --sender 3 --port PORT --bytes 1G \
>       --buf-size SEND_BUF --vsk-size 64M
> 
> The table reports geometric mean Guest RX throughput.
> 
>   SEND_BUF   baseline RX   batching RX   change
>              (Gbit/s)       (Gbit/s)
>   256 B      0.0795724      0.0831509      +4.497%
>   512 B      0.1194885      0.1210297      +1.290%
>   4 KiB      0.7208273      0.7242053      +0.469%
>   64 KiB     2.1712797      2.1951941      +1.101%


I will be frank I don't find the numbers compelling enough
to bother with this trickery.

vsock wasn't optimized all that much for small packets -
first of all, it is doing most of its work in a work item
so we are already at the mercy of the scheduler.

That's more work but you will see a much bigger win for bw and
latency by just handling small packets directly in the cb
if you can.

Looking at batching: wakeup per packet in rx_work, lock_sock per packet,
sk->sk_write_space per rx packet are all high overhead things we are
doing in the data path that are likely easier to handle
and will give you more bang for the buck.





> 
> As supplementary data, perf stat measured the vhost worker cycles and
> instructions per GiB in 10 paired runs. The patched implementation
> reduced cycles by 3.846%, 2.162%, and 4.109%, and instructions by
> 2.548%, 2.084%, and 4.637% for 256 B, 4 KiB, and 64 KiB, respectively.
> 
> An AF_VSOCK request-response latency test with 10 AB/BA pairs showed no
> consistent RTT change: -0.102% for 256-byte messages (4/10 pairs lower) and
> +3.281% for 4-KiB messages (5/10 pairs lower), using arithmetic mean RTTs.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> Changes in v4:
> - Simplify the performance description.
> - Add a brief AF_VSOCK RTT measurement.
> - Keep the batch limit within the used ring and scratch arrays, without
>   duplicating the worker weight limit.
> - Flush after adding a used entry when the batch reaches the limit, and
>   remove the redundant flush in the empty-queue path.
> ---
>  drivers/vhost/vsock.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 9aaab6bb8061..7a13abe73345 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -103,12 +103,35 @@ static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
>  	return found;
>  }
>  
> +static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
> +				   unsigned int used_count)
> +{
> +	if (!used_count)
> +		return false;
> +
> +	vhost_add_used_n(vq, vq->heads, vq->nheads, used_count);
> +	return true;
> +}
> +
> +static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
> +				 unsigned int used_count,
> +				 unsigned int head, unsigned int len)
> +{
> +	struct vring_used_elem *used = &vq->heads[used_count];
> +
> +	used->id = cpu_to_vhost32(vq, head);
> +	used->len = cpu_to_vhost32(vq, len);
> +	vq->nheads[used_count] = 1;
> +}
> +


flush where? add where? return what? these apis don't make it
easier to read code.

>  static void
>  vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  			    struct vhost_virtqueue *vq)
>  {
>  	struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
>  	int pkts = 0, total_len = 0;
> +	unsigned int used_count = 0;
> +	unsigned int used_limit;
>  	bool added = false;
>  	bool restart_tx = false;
>  
> @@ -120,6 +143,11 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  	if (!vq_meta_prefetch(vq))
>  		goto out;
>  
> +	/* Keep the batch within the used ring and the scratch arrays. */

what "the batch"? this is the 1st time code mentions any batch.

> +	used_limit = min_t(unsigned int, vq->num, vq->dev->iov_limit);
> +	if (unlikely(!used_limit))
> +		goto out;
> +
>  	/* Avoid further vmexits, we're already processing the virtqueue */
>  	vhost_disable_notify(&vsock->dev, vq);
>  
> @@ -150,9 +178,16 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  
>  		if (head == vq->num) {
>  			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
> +
> +			/* Flush completed buffers before re-enabling notifications. */


redundant - i can see this is what it does but why? and what does flush mean here?

> +			if (vhost_vsock_flush_used(vq, used_count)) {
> +				added = true;
> +				used_count = 0;
> +			}
> +
>  			/* We cannot finish yet if more buffers snuck in while
>  			 * re-enabling notify.
>  			 */
>  			if (unlikely(vhost_enable_notify(&vsock->dev, vq))) {
>  				vhost_disable_notify(&vsock->dev, vq);
>  				continue;
> @@ -230,8 +265,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  		 */
>  		virtio_transport_deliver_tap_pkt(skb);
>  
> -		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> -		added = true;
> +		vhost_vsock_add_used(vq, used_count, head,
> +				     sizeof(*hdr) + payload_len);
> +		used_count++;
> +		if (used_count == used_limit) {
> +			added |= vhost_vsock_flush_used(vq, used_count);


bitwise or on a boolean likely not what was intended.

> +			used_count = 0;
> +		}
>  
>  		VIRTIO_VSOCK_SKB_CB(skb)->offset += payload_len;
>  		total_len += payload_len;
> @@ -264,6 +304,9 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  			virtio_transport_consume_skb_sent(skb, true);
>  		}
>  	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> +
> +	added |= vhost_vsock_flush_used(vq, used_count);
> +


and here.

>  	if (added)
>  		vhost_signal(&vsock->dev, vq);
> 
> -- 
> 2.34.1

