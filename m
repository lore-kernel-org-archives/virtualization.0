Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408D35E953;
	Sun,  6 Sep 2026 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714241; cv=none; b=dvANuwySAj3gw8ylNvQbvgDKgAUMqj8FAoyPte4/wH6Ex/jTrnDk6ir4D3DhcU+DZ4QvDAjrK/cthzqUBfDkdS67e9lXMMa7UKOHPOG0qEBT/X0rW7teFRb5loiwucM+HJA1VfLXOm9YIrBPFJX3ein+yu37CT/kBG+cdtkWktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714241; c=relaxed/simple;
	bh=MYGt/goz2YxcKBNLiTCOtDgRm7Te939HIktN81kX9u0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IW/yXtMex1rjFnKYIgZUKvovNgdltHaVRDyInNtx1M+Dh/tB+TU5Xgrt2u/EAFgCXF5CrRddsXeqC9HNf3gB89iUyGhE7hMCPYElIcfuaMBCoMPT+lJ6lxcwQdH1f3v/80T6w/O5RBmqYF0wrRnrl8VS2QP49WQcciN+e5bnPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG0ZWREz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG0ZWREz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DEA1F00A3A;
	Sun,  6 Sep 2026 17:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788714239;
	bh=yiFg3WA8eYzFRz4XD8gs7F68jVnn0z1bYOUFWOdeVtU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DG0ZWREzM2cZUReiwc8Hyz2YG6ief2XqF2XZtSiYfpI+xok6L1sBeUJ4tk9U0CFWP
	 E7pQ8V1RfC6TnvQ1c2LOQ8kbeR/Aeo8t9YM8gHq3QIGbjtI+OQD3XhOe8tHfi68h04
	 OZkzY9lpWr/36ZOKxu2Xhjg9JO7ahEVzGNlhfjpAuR2SGBEmd1oC2g960DsZfFPWTj
	 HcrkYJNJk9ar7fsd34Fq21bSmstQsbwpVA8ejWmbkJoR34E3596uwvEU7Jf8Sh8hRE
	 A0hEeoLsrDS2GvZrWF0wSXvcD+uXeD4zAdoNYnVjBIZoVqcUJJ1DIjKhu4hGxQu9jX
	 jXbr635NFFTvA==
Subject: Re: [PATCH net-next 2/6] vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
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
Date: Sun, 06 Sep 2026 17:03:58 +0000
Message-ID: <178871423810.219967.10502012402988056292@kernel.org>
In-Reply-To: <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 3

- [Low] Claim: the new ioctl is inert because no in-tree transport
  implements `netns_assign_allow`, and `vsock_g2h_net_get()` /…
- [Low] Claim: TOCTOU between `vsock_g2h_net_assign()` (which only sweeps
  the connected hash table) and in-flight connections — a socket in…
- [Low] Claim: the reachability gate in `vsock_assign_transport()` is
  skipped by the `vsk->transport == new_transport` early return (so a…

--

vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS

This adds an ioctl on /dev/vsock that moves the guest's vsock device into
the network namespace of the calling process, gated on CAP_NET_ADMIN in the
initial user namespace, plus a transport hook so transports can opt in.
Sockets that can no longer reach the device after a move are reset, and the
device falls back to init_net when the assigned namespace is destroyed.

Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

No regressions to report on this one. A few areas were looked at closely
and appear fine; they are noted below only so the review record is
complete.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 29cde17e08f3..ad11f0f56eb8 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c

[ ... ]

> @@ -548,6 +571,17 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
>  	vsk->transport = NULL;
>  }
>  
> +/* Return true if the loaded g2h transport honours namespace assignment. One
> + * that does not keeps the reachability rules it had before the ioctl existed.
> + *
> + * Must be called with vsock_register_mutex held.
> + */
> +static bool vsock_g2h_netns_assignable(void)
> +{
> +	return transport_g2h && transport_g2h->netns_assign_allow &&
> +	       transport_g2h->netns_assign_allow();
> +}

At this commit no in-tree transport sets .netns_assign_allow, so
vsock_g2h_netns_assignable() is always false and vsock_g2h_net_assign()
returns -EOPNOTSUPP, while vsock_g2h_net_get(), vsock_g2h_reachable_sk()
and vsock_maybe_set_connected() have no callers yet.

The following patch in the series adds virtio_transport_netns_assign_allow()
and the calls into these helpers, so this is the usual core-first split
rather than dead code.

> @@ -622,6 +656,13 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>  		goto err;
>  	}
>  
> +	if (new_transport && new_transport == transport_g2h &&
> +	    vsock_g2h_netns_assignable() &&
> +	    !vsock_g2h_net_reachable(sock_net(sk))) {
> +		ret = -ENETUNREACH;
> +		goto err;
> +	}
> +

This gate is skipped by the preceding

	if (vsk->transport && vsk->transport == new_transport) {
		ret = 0;
		goto err;
	}

early return, but vsock_connect() still consults
transport->stream_allow() after vsock_assign_transport() returns, and the
follow-up patch makes virtio_transport_stream_allow() and
virtio_transport_seqpacket_allow() namespace aware, so a re-connect from an
unreachable namespace is still refused with -ENETUNREACH.

For SOCK_DGRAM, virtio registers only as VSOCK_TRANSPORT_F_G2H and
virtio_transport_dgram_allow() returns false unconditionally, so a datagram
socket never holds the assignable transport.

[ ... ]

> +bool vsock_maybe_set_connected(struct vsock_sock *vsk)
> +{
> +	struct list_head *list = vsock_connected_sockets(&vsk->remote_addr,
> +							 &vsk->local_addr);
> +	bool reachable;
> +
> +	spin_lock_bh(&vsock_table_lock);
> +	reachable = vsock_g2h_reachable_sk(vsk);
> +	if (reachable) {
> +		sk_vsock(vsk)->sk_state = TCP_ESTABLISHED;
> +		__vsock_insert_connected(list, vsk);
> +	}
> +	spin_unlock_bh(&vsock_table_lock);
> +
> +	return reachable;
> +}

[ ... ]

> +static int vsock_g2h_net_assign(struct net *net)
> +{
[ ... ]
> +		rcu_assign_pointer(vsock_g2h_net, net);
> +		vsock_for_each_connected_socket(transport_g2h,
> +						vsock_reset_unreachable_sock);
> +	}

Sockets still in TCP_SYN_SENT, and pending children, are not in the
connected table and so are not visible to this sweep. The ordering here
covers that case:

vsock_g2h_net_assign()
    rcu_assign_pointer(vsock_g2h_net, net);   /* store first */
    vsock_for_each_connected_socket()         /* under vsock_table_lock */

vsock_maybe_set_connected()
    spin_lock_bh(&vsock_table_lock);
    reachable = vsock_g2h_reachable_sk(vsk);  /* re-check under same lock */

Either the insert wins the lock and the later walk sees and resets the
socket, or the walk wins and the insert observes the new namespace and
refuses, so a socket cannot slip into TCP_ESTABLISHED in a namespace that
can no longer reach the device once the transport side lands.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902-vsock-guest-ns-v1-0-9995383e9a8b%40meta.com
