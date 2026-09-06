Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8A3BADBD;
	Sun,  6 Sep 2026 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714244; cv=none; b=pW0KCHIhGebHmkmVZqrkgTvpQxIVwdb3srsYENICNjvRxRghPSXMGduycfPshPyJabSSxt/1a3TusmtAzeoe9XXCSMymNE/sIlrTrRJ13+hNcRn4BvkncX7u+ICNzhuj4zA8WEaza8h/8lXrLL97PjuG6sMg7IDPQchn/gI8JCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714244; c=relaxed/simple;
	bh=8VgBEAbt0xsZpXbwbYgxafafCuO7l43LSn5lXqD5tzI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NFXOu5UIK0dorVxLu0SAIxCa8ZRNwLDtsMgq2khHV+/Y/8ggdZx/pZBRkJ2lC7XbnQURHvaOomaG2kMDUPoAgNPr0oyWacefz28xbQQxhkgoysa17p5esl+xlX6AddoE4mC7ZhTJDwOO/XuIiA/OdA/uzEwlPo5Lf04h5jQP1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VztSSM3m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VztSSM3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8588E1F00A3D;
	Sun,  6 Sep 2026 17:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788714241;
	bh=DTeL6kSncI5+vVHl6QIu0fq+Jqf6xb+YgHno+v0S+bQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VztSSM3mSHxMQ2EQzArfKRubMLt6Or4iiCHqJekha6vUhsmXmepe/bn3uSQjy4g6q
	 HwysRBaYdE8xDkeYQQiSxNfVoubxpOvKxryAsi/vKgioSbKYEHy2feSbOQ6JiMEPD9
	 fl5tP5OlTzkhsH3WtS4esNaaKb2XQxOmPf7xySqtwaCPatX7o6RIf0CI7KSMnki1yZ
	 cyLsv/L/SatgL+fgpifI95PDLeKjrd0Zht6EOGS2xOzhGkxgkojFgbUDmYDTC0WFJR
	 Kv2gzBTq1mRnmQPjbsG3BiQKC/FJm7Wc1cD6aCRlwokGE0byunPNSxwAhdHDBmzpTe
	 DQv9flEL5zpWw==
Subject:
 Re: [PATCH net-next 3/6] vsock/virtio: support guest device network namespace
From: netdev-bot+sashiko@kernel.org
To: bobbyeshleman@gmail.com
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, rdunlap@infradead.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
 bobbyeshleman@meta.com
Date: Sun, 06 Sep 2026 17:04:00 +0000
Message-ID: <178871424008.219967.3871778320530098163@kernel.org>
In-Reply-To: <20260902-vsock-guest-ns-v1-3-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-3-9995383e9a8b@meta.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 1

- [Medium] After IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS becomes functional
  (this patch adds the only .netns_assign_allow implementation in the…
- [Medium] vsock_maybe_set_connected() makes only the table insertion
  atomic with respect to namespace assignment; the connection-setup…
- [Medium] virtio_transport_rx_work() samples the g2h namespace once (net
  = vsock_g2h_net_get(), before mutex_lock(&vsock->rx_lock)) and reuses…
- [Low] In the new `!net` branch of virtio_transport_rx_work()
  (net/vmw_vsock/virtio_transport.c:~694) the code passes `&init_net` to…

--

vsock/virtio: support guest device network namespace

This makes the virtio-vsock guest device assignable to a network namespace,
adds a .netns_assign_allow callback, and switches the RX path to look up
sockets in the device's namespace. It also exports
virtio_transport_reset_no_sock() so the RX path can reset packets that
arrive while the device's namespace is going away.

A few questions about the new namespace assignment behaviour below.

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 4f9aa9c4c3aa..a453a4f828dc 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -540,9 +540,14 @@ static bool virtio_transport_msgzerocopy_allow(void)
>  	return true;
>  }
>  
> +static bool virtio_transport_netns_assign_allow(void)
> +{
> +	return true;
> +}
> +

[Severity: Medium]
This is the only .netns_assign_allow implementation in the tree, so this is
the patch that turns vsock_g2h_net_assign() and its reset sweep from
-EOPNOTSUPP into live behaviour.

The commit message says "every already established vsock socket that is no
longer able to reach the device is forcibly reset".  Is the host peer ever
told about that reset?  vsock_g2h_net_assign() only runs:

net/vmw_vsock/af_vsock.c:vsock_reset_unreachable_sock() {
	if (vsock_g2h_net_reachable(sock_net(sk)))
		return;

	sk->sk_state = TCP_CLOSE;
	sk->sk_err = ECONNRESET;
	sk_error_report(sk);
}

There is no virtio_transport_reset() and no VIRTIO_VSOCK_OP_RST here, and
SOCK_DONE is not set nor is the socket removed from the connected table.

When the guest application later closes the socket, does anything get sent
either?  virtio_transport_close() returns early for any state other than
TCP_ESTABLISHED/TCP_CLOSING:

	if (!(sk->sk_state == TCP_ESTABLISHED ||
	      sk->sk_state == TCP_CLOSING))
		return true;

so a swept socket in TCP_CLOSE emits neither SHUTDOWN nor RST, and
virtio_transport_release() just sets SOCK_DONE and calls
virtio_transport_remove_sock().

Does this leave the host side of each connection in ESTABLISHED until it
happens to send something (at which point recv_pkt's lookup misses in the
new namespace and replies RST)?  A host peer blocked in recv() would then
wait for its own timeout, which is the same failure mode the commit message
rules out for the dropped-packet case.

>  bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
>  {
> -	return vsock_net_mode_global(vsk);
> +	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
>  }
>  
>  static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
> @@ -587,6 +592,7 @@ static struct virtio_transport virtio_transport = {
>  		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>  
>  		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
> +		.netns_assign_allow       = virtio_transport_netns_assign_allow,
>  

[ ... ]

> @@ -634,6 +640,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  	struct virtio_vsock *vsock =
>  		container_of(work, struct virtio_vsock, rx_work);
>  	struct virtqueue *vq;
> +	struct net *net;
> +
> +	net = vsock_g2h_net_get();
>  
>  	mutex_lock(&vsock->rx_lock);

[Severity: Medium]
The namespace is sampled once here and then reused for the entire batch,
i.e. for the whole inner for(;;) drain and the outer
do{}while(!virtqueue_enable_cb(vq)) retry.  vsock_g2h_net is re-pointed by
IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS under vsock_register_mutex/RCU.

Can this snapshot go stale mid-batch, so that after the ioctl has already
returned success the remaining packets are still resolved against the old
namespace via vsock_find_connected_socket_net()/
vsock_find_bound_socket_net()?

For already established sockets the only fence is the assignment sweep, and
that sweep does not take the socket lock:

CPU0 (rx_work)                        CPU1 (assign ioctl)
virtio_transport_recv_pkt()
  lock_sock(sk)
  /* re-checks only SOCK_DONE and
     vsk->transport, not the ns */
                                      vsock_g2h_net_assign()
                                        rcu_assign_pointer(vsock_g2h_net, net)
                                        vsock_reset_unreachable_sock(sk)
                                          sk->sk_state = TCP_CLOSE
  switch (sk->sk_state)  /* read TCP_ESTABLISHED earlier */
    virtio_transport_recv_connected(sk, skb)

Does that let host payload be queued into a socket in the namespace the
device was just moved away from?  Would re-validating reachability after
lock_sock() (e.g. vsock_g2h_reachable_sk()) close this window?

> @@ -682,10 +691,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  
>  			virtio_transport_deliver_tap_pkt(skb);
>  
> -			/* Force virtio-transport into global mode since it
> -			 * does not yet support local-mode namespacing.
> -			 */
> -			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> +			if (unlikely(!net)) {
> +				virtio_transport_reset_no_sock(
> +					&virtio_transport, skb, &init_net);
> +				kfree_skb(skb);
> +				continue;
> +			}

[Severity: Low]
This isn't a functional bug today, but is &init_net the right value to pass
here?  vsock_g2h_net_get() returns NULL only after it has already rejected
init_net as a stand-in:

net/vmw_vsock/af_vsock.c:vsock_g2h_net_get() {
	net = maybe_get_net(assigned);
	...
	if (!net && vsock_net_check_mode(&init_net, assigned))
		net = get_net(&init_net);
}

So reaching this branch means vsock_net_check_mode(&init_net, assigned) was
false, yet &init_net is then handed to virtio_transport_reset_no_sock() as
"the namespace of whoever sent the invalid message".  The pre-patch code
passed NULL, and virtio_transport_recv_pkt() below is given the real device
namespace.

virtio_transport_send_pkt() ignores its net argument, so nothing breaks in
this transport, but the function is now exported and declared in
include/linux/virtio_vsock.h, where the vhost and loopback send_pkt()
implementations do use net.  Would NULL (as before) or a note that virtio
ignores net keep the two call sites consistent?

> +
> +			virtio_transport_recv_pkt(&virtio_transport, skb, net);
>  		}
>  	} while (!virtqueue_enable_cb(vq));
>  

[ ... ]

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 88df82364f77..313ef263fd2d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1315,8 +1315,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
>   * loopback, this is the namespace of the socket. For vhost, this is the
>   * namespace of the VM (i.e., vhost_vsock).
>   */
> -static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> -					  struct sk_buff *skb, struct net *net)
> +int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> +				   struct sk_buff *skb, struct net *net)
>  {

[ ... ]

> @@ -1478,9 +1479,14 @@ virtio_transport_recv_connecting(struct sock *sk,
>  
>  	switch (le16_to_cpu(hdr->op)) {
>  	case VIRTIO_VSOCK_OP_RESPONSE:
> -		sk->sk_state = TCP_ESTABLISHED;
> +		/* An assign cannot see a socket that is not connected yet. */
> +		if (!vsock_maybe_set_connected(vsk)) {
> +			skerr = ECONNRESET;
> +			err = -ENETUNREACH;
> +			goto destroy;
> +		}
> +
>  		sk->sk_socket->state = SS_CONNECTED;
> -		vsock_insert_connected(vsk);
>  		sk->sk_state_change(sk);
>  		break;

[ ... ]

> @@ -1758,7 +1762,17 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>  	if (virtio_transport_space_update(child, skb))
>  		child->sk_write_space(child);
>  
> -	vsock_insert_connected(vchild);
> +	/* An assign cannot see a socket that is not connected yet, and the
> +	 * check in vsock_assign_transport() above has since dropped
> +	 * vsock_register_mutex.
> +	 */
> +	if (!vsock_maybe_set_connected(vchild)) {
> +		release_sock(child);
> +		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> +		sock_put(child);
> +		return -ENETUNREACH;
> +	}
> +
>  	vsock_enqueue_accept(sk, child);
>  	virtio_transport_send_response(vchild, skb);
>  

[Severity: Medium]
vsock_maybe_set_connected() makes only the table insertion atomic against
assignment, and it drops vsock_table_lock before returning.  Does anything
re-check the socket afterwards?

The commit message says "If it wins the race to the table and does NOT pass
the reachability tests, then the reset sweep will correctly catch it", but
the winner here keeps going past the insertion point:

CPU0 (virtio_transport_recv_listen)     CPU1 (assign ioctl)
lock_sock_nested(child)
vsock_maybe_set_connected(vchild)
  spin_lock_bh(&vsock_table_lock)
  sk_state = TCP_ESTABLISHED
  __vsock_insert_connected()
  spin_unlock_bh(&vsock_table_lock)
                                        vsock_g2h_net_assign()
                                          vsock_for_each_connected_socket()
                                            vsock_reset_unreachable_sock(child)
                                              sk_state = TCP_CLOSE
                                              sk_err = ECONNRESET
vsock_enqueue_accept(sk, child)
virtio_transport_send_response(vchild, skb)

The lock sets are disjoint (lock_sock(child) versus vsock_table_lock), so
does the guest end up sending VIRTIO_VSOCK_OP_RESPONSE for a child it has
already reset, and queueing that child on the accept queue?  vsock_accept()
inspects neither sk_err nor sk_state before doing:

	newsock->state = SS_CONNECTED;
	sock_graft(connected, newsock);

The same gap seems to exist in virtio_transport_recv_connecting() above,
where sk->sk_socket->state = SS_CONNECTED and sk_state_change() run after
vsock_maybe_set_connected() has dropped the table lock, even if the sweep
has already forced sk_state to TCP_CLOSE.

Since vsock_reset_unreachable_sock() neither sets SOCK_DONE nor removes the
socket from the table, and virtio_transport_close() short-circuits for
TCP_CLOSE, is any RST sent to the host in this case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902-vsock-guest-ns-v1-0-9995383e9a8b%40meta.com
