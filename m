Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08BC56852A;
	Wed, 23 Sep 2026 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191267; cv=none; b=bkdw2AbWzRvAtOBx6cRH5RsxZB3IHemLGi+ESUUfz3VflTIfcKvWWwgbocPwRz8A9mF6425L+N6/Ct4en9rNZLPidVFdRxnfXIVh67I3xn5qxil+s3mLzmd1M9fLgruI3s+Jes5v1G5/vG1JT5smJPK3SFFkI72KUx7LiaOaFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191267; c=relaxed/simple;
	bh=BbvRAyUq5si+HS0OKOdfIlG/hjjuTRiLMlc9eYdaXGE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QejA0e1EVGTq1uJo9YlabR2jKeHZNtKBnj4rUmRKlgBaBrn2vkB8bvtgelwSW0RVowL+LXmEK2uYKveDJJnenAOTpGJKQXDr8n+tUkCzsO5YMFp9ECXu5XH7/8qVHPBMNzGvwaokPvc6XST+XaJaoNq/cdCd2uq00+5YgegrD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmemUDme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmemUDme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282411F00893;
	Wed, 23 Sep 2026 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790191265;
	bh=z32N1aXGLCLiP1S0LGtMEjOpi02MNIgclPWjnkfH/AE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HmemUDmenZkoqIDtAutmzKvcEoolHzyPkzatRlFZmbTDaE7rWAPlVIHabAV47wnXB
	 maIZYGqYqyI20tehlWtUB2S/6V831XF7wJCH1UoIcpX4GLunMPy4qxm5vK6R1lJTQC
	 JLdWoFEED/iGBPdkQRdbga48vTvSY1OB/CctyEZWH2mkn7HcROMRMyLP7LwDwCmub6
	 CwgLqfprr7kxIwjPyLs/r38YCQTiaHmwjHkz0fq8ZPZqDz5f/JNH0INcYdi5A2tLx8
	 iWwGHuN8VWlJ4dykjDViCmYN82DbwKaG0ydUn2WHxCFaGxV0kWpH+b0CBXqfKB8lEo
	 eIh+eAc0X0uoA==
Subject: Re: [PATCH net-next v2 4/6] vsock/virtio: support guest device
 network namespace
From: netdev-bot+sashiko@kernel.org
To: bobbyeshleman@gmail.com
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
 sdf.kernel@gmail.com, bobbyeshleman@meta.com
Date: Wed, 23 Sep 2026 19:21:03 +0000
Message-ID: <179019126374.2160803.9294641399796135651@kernel.org>
In-Reply-To: <20260921-vsock-guest-ns-v2-4-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-4-693bd78fde9e@meta.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] virtio_transport_rx_work() samples the g2h namespace once per
  work invocation (`net = vsock_g2h_net_get()` at…
- [Medium] By setting `.netns_assign_allow = true` and `.reset =
  virtio_transport_reset` (net/vmw_vsock/virtio_transport.c:590-591)…
- [Low] virtio_transport_reset_no_sock() is promoted to an exported
  cross-module API (declared in include/linux/virtio_vsock.h,…

--

vsock/virtio: support guest device network namespace

This makes the virtio-vsock guest device assignable to a network namespace
and initializes it to init_net.  The RX work now looks up the currently
assigned namespace and resets received packets while no valid namespace is
available, and new connected sockets are inserted via the new
vsock_maybe_set_connected() helper so insertion is atomic with respect to
namespace assignment.

A few questions below.

> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index f91704731057e..5d15b6d6bdf7f 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -286,6 +286,9 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
>  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
>  void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
>  void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> +int virtio_transport_reset(struct vsock_sock *vsk, struct sk_buff *skb);
> +int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> +				   struct sk_buff *skb, struct net *net);
>  int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
>  int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
>  int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 4f9aa9c4c3aa5..5ad93af4bd2b1 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c

[ ... ]

> @@ -587,6 +587,8 @@ static struct virtio_transport virtio_transport = {
>  		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>  
>  		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
> +		.netns_assign_allow       = true,
> +		.reset                    = virtio_transport_reset,

[Severity: Medium]

Setting .netns_assign_allow = true makes vsock_netns_assignable() true for
the g2h transport, which activates the reset sweep in
vsock_g2h_reset_unreachable().  That sweep calls t->reset() while holding
only vsock_register_mutex and a socket reference, never lock_sock(sk):

net/vmw_vsock/af_vsock.c:vsock_g2h_reset_unreachable() {
	...
		sk->sk_state = TCP_CLOSE;
		sk->sk_err = ECONNRESET;
		sk_error_report(sk);
	...
	list_for_each_entry_safe(vsk, tmp, &reset_list, pending_reset) {
		list_del_init(&vsk->pending_reset);
		t->reset(vsk, NULL);
	...
}

virtio_transport_reset() -> virtio_transport_send_pkt_info() addresses the
RST straight out of the socket:

	if (!info->remote_cid) {
		dst_cid	= vsk->remote_addr.svm_cid;
		dst_port = vsk->remote_addr.svm_port;

Those fields are normally only stable under lock_sock(sk).

The sk_error_report() above wakes a blocking connect(), which then runs:

net/vmw_vsock/af_vsock.c:vsock_connect() {
	err = sock_error(sk);
	if (err) {
		sk->sk_state = TCP_CLOSE;
		sock->state = SS_UNCONNECTED;
	}
}

and returns -ECONNRESET.  If userspace retries connect() immediately, the

	memcpy(&vsk->remote_addr, remote_addr,
	       sizeof(vsk->remote_addr));

in vsock_connect() runs before vsock_assign_transport() blocks on
vsock_register_mutex, so it is not serialized against the sweep that is
still walking reset_list.

Can the sweep then read the freshly overwritten remote_addr and send the
RST to the new destination, so the actual peer of the connection that was
just torn down never gets a reset and waits for a timeout instead?

>  
>  		.notify_poll_in           = virtio_transport_notify_poll_in,
>  		.notify_poll_out          = virtio_transport_notify_poll_out,

[ ... ]

> @@ -633,7 +635,11 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  {
>  	struct virtio_vsock *vsock =
>  		container_of(work, struct virtio_vsock, rx_work);
> +	struct virtio_transport *t = &virtio_transport;
>  	struct virtqueue *vq;
> +	struct net *net;
> +
> +	net = vsock_g2h_net_get();
>  
>  	mutex_lock(&vsock->rx_lock);
>  
> @@ -682,10 +688,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  
>  			virtio_transport_deliver_tap_pkt(skb);
>  
> -			/* Force virtio-transport into global mode since it
> -			 * does not yet support local-mode namespacing.
> -			 */
> -			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> +			/* The virtio send path does not use @net. */
> +			if (unlikely(!net)) {
> +				virtio_transport_reset_no_sock(t, skb, NULL);
> +				kfree_skb(skb);
> +				continue;
> +			}
> +
> +			virtio_transport_recv_pkt(t, skb, net);

[Severity: Medium]

The namespace is sampled once per work invocation and then pinned with a
hard reference for the whole drain loop:

	net = vsock_g2h_net_get();
	...
	do {
		...
			virtio_transport_recv_pkt(t, skb, net);
	} while (!virtqueue_enable_cb(vq));

Meanwhile the assign path publishes the new namespace and then sweeps the
connected table:

net/vmw_vsock/af_vsock.c:vsock_g2h_net_assign() {
	...
	rcu_assign_pointer(vsock_g2h_net, net);
	vsock_g2h_reset_unreachable(transport_g2h);
	...
}

As soon as the new pointer is published, a connect() from the newly
assigned namespace is permitted, because vsock_assign_transport() consults
vsock_g2h_net_reachable() which already reads it.  If the host RESPONSE for
that connection is drained by the batch still holding the previous
namespace, vsock_find_connected_socket_net(&src, &dst, net) does not find
the socket (vsock_net_check_mode() of the local-mode new net against the
old net is false), so virtio_transport_recv_pkt() falls into

	(void)virtio_transport_reset_no_sock(t, skb, net);

and the just-established connection is reset.  Is that acceptable for the
remainder of an in-flight batch, or should the namespace be re-read per
packet?

In the other direction, between the rcu_assign_pointer() above and the
per-socket store in vsock_g2h_reset_unreachable():

		sk->sk_state = TCP_CLOSE;
		sk->sk_err = ECONNRESET;

can the in-flight batch still resolve packets against the old namespace and
deliver payload plus credit updates into sockets that the device no longer
belongs to?

The commit message describes the batch granularity only for the dying
namespace case:

  "received packets are reset until a new valid namespace has been assigned
   and/or automatically returned to, and the next RX batch begins"

Should it also describe what happens to packets of the newly assigned
namespace while an older batch is still draining?

>  		}
>  	} while (!virtqueue_enable_cb(vq));
>  

[ ... ]

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index f225f53ed4bab..c24049b2a3866 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -1315,8 +1315,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
>   * loopback, this is the namespace of the socket. For vhost, this is the
>   * namespace of the VM (i.e., vhost_vsock).
>   */
> -static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> -					  struct sk_buff *skb, struct net *net)
> +int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> +				   struct sk_buff *skb, struct net *net)

[Severity: Low]

This isn't a bug, but the comment above still enumerates only the loopback
and vhost meanings of @net, while the helper is now exported via
include/linux/virtio_vsock.h and the new caller in
virtio_transport_rx_work() passes NULL.  Whether NULL is fine depends on
the ->send_pkt behind @t: virtio_transport_send_pkt() ignores @net, and
vhost_transport_send_pkt() passes it to vhost_vsock_get() ->
vsock_net_check_mode(), which treats NULL as VSOCK_NET_MODE_GLOBAL.  Could
the comment be extended to say that NULL is permitted and what it means?

>  {
>  	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>  	struct virtio_vsock_pkt_info info = {
> @@ -1355,6 +1355,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  
>  	return t->send_pkt(reply, net);
>  }
> +EXPORT_SYMBOL_GPL(virtio_transport_reset_no_sock);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-vsock-guest-ns-v2-0-693bd78fde9e%40meta.com
