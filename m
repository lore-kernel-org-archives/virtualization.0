Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5045D908;
	Sun, 11 Oct 2026 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728753; cv=none; b=PL5c49e1RuJUlQSj1tKrw+/uuUWQZCAkvjFAzDrZqmSOoXHt88mrshjQnyLyxiayZDYyJKfd7S1aW4KVYwovovxmZ74X3sP+7hd6wrNPacjxXY0c0L3duaBqNWQVRsyMjo1Ks5JPnJqoIjMrw581Ock7uZUCWHVp4iPYQn2jfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728753; c=relaxed/simple;
	bh=tDLGr8D6+4CbOIIp41FC/R/Tkv/VzAhsRKQh5QYKFUU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZV02cuFZRu5gPe2QnKHlwMgbsNjE1vmcBQeyLMrCw6h2KAqIPmjz5iD8fOcV2Zhv5dEVT+i3Y0VZZBMhm41NlWTzH4HMq72Uyf/Sdv4Lb1FHXBV3pgVq1EiXhS9IsHUaM7NmoPN1F/ebJH92lWsc/XBij2fUYyKblnZr3hBg0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfNtoelG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfNtoelG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD901F0089C;
	Sun, 11 Oct 2026 14:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791728751;
	bh=bFKuojTLG79Q0A+FPiE0eVIN06QrJSxb8mTqimdD0xg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PfNtoelGqLlAyuYA38QBdLiq+CAmk3LiT4oFcaiUMxE+ffcAFy/XVAqm9dDRgTIfs
	 5VvtS8z1g74rI5qV1SsBGJPDavWilqjU7VIt7gKEXwJrQTNYMt118Jov1h0ockUoB7
	 WThToOW+eylkmXMuTyVAKne92uPjTcusXSG5qGN3htgn8iJdOtDr9C4nZlzTw4+Hcg
	 gCC9G/UMe34svAetysZ9dzbsw7hMOC8NS1d8mSB5mhMOepohMcq/WRXUIKY5GnfnM9
	 io33AiRQmPWyf2j8wKWHIF2InoDLFFwxjlK8sG9nU2Or36cJfx03YHGD1lAyqVUEOx
	 bLcdHv3fZylDQ==
Subject: Re: [PATCH net-next v2 2/5] vsock/virtio: amortize RX socket locking
 for stream packets
From: netdev-bot+sashiko@kernel.org
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 14:25:50 +0000
Message-ID: <179172875064.434549.11523805098508702702@kernel.org>
In-Reply-To: <20261010142247.99223-3-physicalmtea@gmail.com>
References: <20261010142247.99223-3-physicalmtea@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch is presented purely as a performance optimisation
  ("amortize RX socket locking") but gives no throughput, latency or CPU…
- [Low] Removing the local skb_overhead declaration from
  virtio_transport_inc_rx_pkt()…

--

vsock/virtio: amortize RX socket locking for stream packets

This commit keeps the socket lock held in the virtio-vsock RX worker
while it processes a bounded run of RW packets for the same established
STREAM socket. A batch is limited to 64 packets or 64KB of payload. The
commit adds the exported helpers virtio_transport_recv_pkt_batch() and
virtio_transport_rx_batch_finish(), and virtio_transport_inc_rx_pkt()
now shares the skb metadata headroom check.

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 4f9aa9c4c3aa5..ef076732158d4 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -629,8 +629,16 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
>  	return seqpacket_allow;
>  }
>  
> +/*
> + * Keep a bounded run of packets for one socket under a single socket lock.
> + * Limit packet count and payload size to bound the work done while locked.
> + */
> +#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS	64
> +#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES	(64 * 1024)

[Severity: Low]
This isn't a bug, but are there throughput, latency or CPU numbers for
this change? Which workload does it help?

The commit is presented only as a performance optimization. To get that
benefit it adds a new struct in include/linux/virtio_vsock.h, two
exported symbols, and new rules for when a packet can join a batch.

It also keeps lock_sock() held across iterations of the loop in
virtio_transport_rx_work(). As a result, recvmsg, sendmsg, setsockopt or
close on the same socket can now wait for up to 64 packets / 64KB
instead of one packet.

In this patch, the batched path in virtio_transport_recv_pkt_batch()
still does the lookup and refcount work for every packet:

    sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
    ...
    if (!skb_set_owner_sk_safe(skb, sk)) {
    ...
    if (batch->sk == sk) {
        /* Keep the batch reference; drop this packet's lookup reference. */
        sock_put(sk);

virtio_transport_recv_pkt_find_socket() takes the global
vsock_table_lock and does a sock_hold(). That means only the
lock_sock()/release_sock() pair is saved.

sk_data_ready() also still runs while the lock is held. A reader it
wakes can therefore go back to sleep on sk_lock.wq until the batch
ends.

Two later commits in the series remove those costs: "vsock/virtio:
reuse same-flow socket lookup in RX batches" and "vsock/virtio: defer
RX readable notifications until batch unlock". Even so, no commit
message in the series has numbers showing that the change is a net win.

Could benchmark data be added to the commit message?

[ ... ]

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e3e75e59896fe..a73e37b3fa62f 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -576,10 +576,16 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,

[ ... ]

>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),

[Severity: Low]
This isn't a bug, but removing skb_overhead leaves a blank line right
after the opening brace of virtio_transport_inc_rx_pkt().

checkpatch --strict warns about this ("Blank lines aren't necessary
after an open brace"). The blank line is still there at the end of the
series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010142247.99223-1-physicalmtea%40gmail.com
