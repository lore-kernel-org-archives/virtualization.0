Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184575;
	b=LlcjF416JmG1z6ONcdvz/xN15oTng7qw8tH8lxFAMRhp3joOSCj2GDXA54Ql2aZRRMU8
	 yvtm9Eml8LCd6DQ0XHKJjmkNl/t3n/J2DnhOgFPfkwgXfl5a2rpY8NgfrNDdFa9DHZYVH
	 yBkKAX6I0la2rggFobvRnrU4p7t/+xyTt1l08WemJsGKpbOYqhqDFVyJB8yIIJmhiQJrG
	 fZYNnSh7ZJgVcaocZGpB8YbrHxXO6vbVDCZaazdcwZf9P+78ChTK/wY7geAuEO5bV3qKl
	 OliGCE6q12HkyOsvfQzN+o7PEcRqsUoXdLxdN9yskk7NhKYREHz0tsadSnIJ26WdqyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184575;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MrgV9fXwBYVj4uLezFVa59Hg+/XXAINskq6Fghy76zs=;
	b=Y3QEe9UDXU0sDI1lJOXCIsjy/rr8+8gCM3hQ6DkdoVv61vehcj608GYkjHDEo2XHNoN6
	 BQ7n8EsBUISgzKosUxj8oE9ImGkvlDBdFkx5FUv+ofpEliSgFdAXQcQnqfQ8cQNkDoku5
	 CRvgJ6Czh2RUxN9LWc7q9CJefhxZgvuogd0U41kizGHt0q17ESS+nxIfV8gUjYGUMXQ2L
	 IAptQNcezbNK5rEobLQzQfMCKP9aatyWNgqgClUyY0IWpEic7qTlnk+K8dFanNmytdRTE
	 oSvoEgiuwBRsvHkbeJjMruxvXE5dQ/yJw8DzFDF+MNA0+YoWA0K20B5HIYxmP9CqdmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcaNjP8t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40173606A31C;
	Mon,  9 Nov 2026 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcaNjP8t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B21E1F008A2;
	Mon,  9 Nov 2026 00:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184575;
	bh=MrgV9fXwBYVj4uLezFVa59Hg+/XXAINskq6Fghy76zs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FcaNjP8t3uYt8wwOigY7Jj/L+2eMml7Pwt9+M+mSCd1uTIiJ83mLqNitjPNkzxUnX
	 TsKJW2EWvaOxz/qgCVLIwh0jhIWJlg9k+SYK8XoJxUcsnlcuFTIt7jL2qPnzYMIA8R
	 6krCikJbxLI2mJdOEGp8WOzf4MMc9CDjLNnKTzeThgGr2tyouFKgK4intwgZGpiLoS
	 /x/DQo3vqldDdcI0gSz57AHQb/FWFeohWbWHnzN9xNdZkMLb9NPkjyHrUc8n1aNzeS
	 pvAZYnTMqKbllCvLgeWkhpc5ZQPor3KR9NYmKlgR8QYkjl84Eob3FSR3nH53DNfCK2
	 7LikZBOQtZ2/w==
Subject:
 Re: [PATCH net 3/3] vsock/virtio: queue at most one credit update per socket
From: netdev-bot+sashiko@kernel.org
To: green@linuxhacker.ru
Cc: sgarzare@redhat.com, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 bobbyeshleman@meta.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 00:36:13 +0000
Message-ID: <179418457356.994134.15621990093990477357@kernel.org>
In-Reply-To: <20261105000141.3617241-4-green@linuxhacker.ru>
References: <20261105000141.3617241-4-green@linuxhacker.ru>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Both the guest and vhost transports call
  virtio_transport_credit_update_xmit() before the packet is actually…

--

vsock/virtio: queue at most one credit update per socket

This patch limits how many credit update packets each virtio vsock socket
can have queued. It tracks the last queued credit update skb in
virtio_vsock_sock and suppresses new ones while that skb is pending.
Transports call a new virtio_transport_credit_update_xmit() hook to
refresh fwd_cnt/buf_alloc on the tracked skb and release tracking when it
is sent. A tracked skb holds a refcount on virtio_vsock_sock to keep it
alive.

[ ... ]

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 74a8fdf825d50..65d6e0790e724 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -604,18 +604,68 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,

[ ... ]

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

[Severity: Medium]
This hook can't be undone once it has run. It clears vvs->credit_update,
advances vvs->last_fwd_cnt and rewrites the header. Do the guest and vhost
transports call it before the packet is actually committed?

In the guest driver, virtio_transport_send_skb() calls it before
virtqueue_add_sgs(), and that call fails when the tx vq is full:

net/vmw_vsock/virtio_transport.c:virtio_transport_send_skb() {
	virtio_transport_credit_update_xmit(skb);
	...
	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, gfp);
	if (ret < 0)
		return ret;
	...
}

virtio_transport_send_pkt_work() then puts the skb back at the head:

	ret = virtio_transport_send_skb(skb, vq, vsock, GFP_KERNEL);
	if (ret < 0) {
		virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
		break;
	}

When the fast path fails, virtio_transport_send_pkt() queues it at the
tail instead.

The requeued skb is no longer tracked. So the next
virtio_transport_send_credit_update() is not suppressed, and it queues a
second, tracked credit update behind the first.

Doesn't that make the per-socket bound two, rather than the "at most one
credit update" the commit message describes? Any later updates are still
suppressed by the second tracked one, so the unbounded queuing stays
fixed.

In vhost, vhost_transport_do_send_pkt() calls the hook right after it
gets a descriptor, before the checks that drop the skb:

	virtio_transport_credit_update_xmit(skb);

	if (out) {
		restart_tx |= vhost_vsock_drop_skb(vsock, skb);
		...
	}

	iov_len = iov_length(&vq->iov[out], in);
	if (iov_len < sizeof(*hdr)) {
		restart_tx |= vhost_vsock_drop_skb(vsock, skb);
		...

The copy_to_iter() and skb_copy_datagram_iter() fault paths drop the skb
in the same way.

Suppose updates were suppressed while this one was queued. Their fwd_cnt
has been merged into this skb and recorded in last_fwd_cnt, but the
guest never receives this skb.

Before this patch, the suppressed update would have been a separate skb,
delivered on the next descriptor. Now nothing resends it until more local
reads happen. Could the guest-side sender then stall waiting for credit?

Moving the hook after these checks would not be enough by itself, since
the suppressed state is lost whenever a tracked update is dropped.

The commit message says:

  So a suppressed update always reaches the
  peer, either in the queued one or in a later packet, and the fwd_cnt
  the peer sees never goes back.

Is that still true on these drop paths?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105000141.3617241-1-green%40linuxhacker.ru
