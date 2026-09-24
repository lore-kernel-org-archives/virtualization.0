Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEBB38D406
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289626; cv=none; b=eOLICz5TE2vT7fwHNbewzRenQzCHiT94BBUYJpZCuIJksi2HCj3JNmY4QlyzIflX8ibWCjnJZeu+xfyeC6seZdLWbYDu5urXUDB8NogcKZ789VBlfaeXoHqGByYQvSwPEuQrjGDzFKB/bSsoE0wjSff3R26RXZaXMi9P2dlKRdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289626; c=relaxed/simple;
	bh=YGT5QUshc0eobNfRyISIsLqeiJQkeLgxi9V0/fkpF3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7veqYYb+9W1dqHO/PCgeRTLfAMvbbFcY8DKk5EQ0uRoLt50mnpRYKOXjAuHZYlNsripUNt9F46fXVHb7ArgfsX5nKsTkK3N+FvXyWDNpFyDp30HKPL4D0Xykb+okYiZKgneQPRT9HIGFA2h0fGFVPblb8k/VU+mIUsbf34zCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r07CiRfa; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r07CiRfa"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccdd7695so216771fac.1
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 15:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289623; x=1790894423; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m7BIDka3Egli6QEFlrOQVcPCPwpdHOatylapULQdLTY=;
        b=r07CiRfaqk7ogi79z2Kbely8xaCH4o4iGQwTA2xlFgJJ6dGrNiEBnNz8WeLx3EUG37
         IYS6nCS0GcXmlOAYrWfWJBcmcDcMEvJ5jtJ3/U1GalDnz22NWX8Ucbgezz0qILiRwx6O
         Ek2cbXLm7c77LW7Du6jv1/EZ2x1ORQtVUYOdsuhYZO+DTbbZFGJ02afglaUbZEYZMQTV
         xSlj02xCNTQh6oQ5xMPYAIinRD/shil7iCeh/C1c5/zP56RCRFSTuuKlDpoa9HnfnDod
         /p+DxnWx39pgZUdDsxWOqMrkkU872X4D5cYfJYdJN1oxUthcv7IKTyaNUnuRUWEZpD1p
         Dnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289623; x=1790894423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m7BIDka3Egli6QEFlrOQVcPCPwpdHOatylapULQdLTY=;
        b=2YIVk456mn262SDf/Bli2sYXWSWbVUlVAaZedIINBG1sds/eFPGPR+Qom/HdaVz4ab
         6OMDkjirSogIsNUIcmfs/9Pk4QgsUD/MVyx8JqH9/ARA51jn8C+RHJQr1/GJ2e9OB7J5
         t2v3wP6guD/Ltp7qIiBnN5khvKGH/820SR34Zyaf/gUlubo1/cJwWlzrOsyb2fT/HCNO
         U91sbCT5mB57ThYxXOh2R2rQjfqnZHANDXnGOocugS+9aiPVwuJ6lTytHEc/90PtZMki
         T10H1psqgSvHJyXUYWukewz2MB+hbgP3DOPphbGv5EeaJp1PAvGmLQ1YSNJNopTDKmS1
         LY/w==
X-Forwarded-Encrypted: i=1; AKwUvBx8KuQCYQBn8yBQjZJ3AQXyhEca4v+HdafsA9j0faF7kLFMAkIlIjGfqkPLQCDAoM1VWmxP9odfbgB2zTK2eg==@lists.linux.dev
X-Gm-Message-State: AFuF++ki6g/lj4B6p7ZgTDcJ1+kU7+uzGrCqFBPd6RdIXCCM50GfR6R3
	leU5LwT6Pcnvsrs4Un0UwOhV8M+1QRsxVhMelsYuGg1v9sBx9/O8JvHM
X-Gm-Gg: AYBFou2IZZFi9SnvN0uXfTnj3GvBcrGiAa5x5wt2hLBpQpgZtxGixUereQKl028yoRg
	7YtwDa5/OE+DgKeLFa5rhRC8ESlr5Z7ozHmEDrgoDpfIoebGgRs6/Ac2r9KkHPJOs87Pw+5qqRd
	mOvyhM9gMzWxIzaJp0uUhtZKKyLG2OdHKF6tA6RM9g4qVd2m0EX+Mkwrluhz5IDjkqOaI51iuxo
	Mo80lACMWvYMOXKwDhfylQ5RvdT1IsFDtlO8L/SgXMsQQrjK0SSxR64YqZx5SZKSBYNAyqVYeN3
	BHSV/WmhtCmJ95f5wfqZhV6K3dSVkSKwN3Q/NS0A5U9nST0PvpUvVtTrRqdFCRALXf4KREslALl
	toAyzoQQ97g2P9jFt1rsOPP6R7PmorNn2Jy8AYdP3RUMTl5Pt+7UiEBA2kBgcug+/us9YOoON81
	cGigMqqoE6TPEC+tLutpiebp8pclmlO30OYo6qpxxZv8AiSo4/DTH7p7c5ggrfmlQIaRasIDBFu
	f6aXMWR3XOawnh5f4Ac
X-Received: by 2002:a05:6870:8111:b0:486:aec0:1276 with SMTP id 586e51a60fabf-491e5bf6b73mr3683175fac.22.1790289623151;
        Thu, 24 Sep 2026 15:40:23 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:15::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49335011458sm600452fac.4.2026.09.24.15.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:40:21 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:40:16 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, stefanha@redhat.com,
	mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shuah@kernel.org, rdunlap@infradead.org,
	donald.hunter@gmail.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
	sdf.kernel@gmail.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next v2 3/6] vsock: add a netlink command to assign
 the g2h device to a netns
Message-ID: <arWm0I6ypGK2ezXK@devvm29614.prn0.facebook.com>
References: <20260921-vsock-guest-ns-v2-3-693bd78fde9e@meta.com>
 <179019126153.2160803.2250276732411996714@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179019126153.2160803.2250276732411996714@kernel.org>

On Wed, Sep 23, 2026 at 07:21:01PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 2 · Low: 3
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] vsock_g2h_reset_unreachable() marks a socket
>   TCP_CLOSE/ECONNRESET but leaves it linked in vsock_connected_table…
> - [Medium] vhost_vsock_set_cid()'s collision check against the G2H device
>   CID became namespace-conditional (`vsock_find_cid(vsock->net,…
> - [Medium] vsock_g2h_reset_unreachable() invokes the new sleepable
>   `t->reset(vsk, NULL)` callback with only vsock_register_mutex held and…
> - [Low] DISCARDED (resolved later in the series).
> - [Low] DISCARDED (resolved later in the series).
> - [Low] DISCARDED (blocked by the transport patch later in the series).
> 
> --
> 
> vsock: add a netlink command to assign the g2h device to a netns
> 
> This adds a vsock generic netlink family with VSOCK_CMD_DEV_NETNS_SET and
> VSOCK_CMD_DEV_NETNS_GET, which move the guest-to-host vsock device into the
> caller's network namespace and read that assignment back. Reachability of the
> device, and visibility of its CID through the local-CID ioctl, bind() and
> loopback transport selection, now depend on the namespace asking. Sockets that
> can no longer reach the device after a move are reset, and the device returns
> to init_net when its namespace is destroyed.
> 
> Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
> 
> A few questions below about the new reachability and reset paths.
> 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index fe43e85959583..f2d8e4e84f89b 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -529,6 +529,29 @@ their hosts. The behavior of VSOCK sockets in a network namespace is determined
> 
> [ ... ]
> 
> > +Support is transport dependent. A G2H transport that does not implement the
> > +move refuses the command with ``EOPNOTSUPP``; of the in-tree guest transports
> > +only virtio-vsock implements it.
> 
> [Severity: Low]
> 
> At this commit, does any transport set netns_assign_allow and ->reset?
> 
> vsock_netns_assignable() requires both, and neither is set by any in-tree
> transport here, so VSOCK_CMD_DEV_NETNS_SET can only return -ENODEV or
> -EOPNOTSUPP while this text says virtio-vsock implements the move.
> vsock_g2h_net_get() and vsock_maybe_set_connected() also have no callers
> yet.
> 
> The following patch in the series, "vsock/virtio: support guest device
> network namespace", adds .netns_assign_allow = true and
> .reset = virtio_transport_reset to virtio_transport and wires up both
> helpers, so the text becomes accurate at the end of the series. Would it
> read better to add this paragraph in that patch?

I think this is okay. We add support and then online the transports
later.
> 
> [ ... ]
> 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index abed1fbcf66cc..badc064964b31 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -828,9 +828,11 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
> >  		return -EINVAL;
> >  
> >  	/* Refuse if CID is assigned to the guest->host transport (i.e. nested
> > -	 * VM), to make the loopback work.
> > +	 * VM), to make the loopback work. Only when that device is reachable
> > +	 * from this VM's namespace, which is the same test the guest CID
> > +	 * collision check below applies.
> >  	 */
> > -	if (vsock_find_cid(guest_cid))
> > +	if (vsock_find_cid(vsock->net, guest_cid))
> >  		return -EADDRINUSE;
> 
> [Severity: Medium]
> 
> This collision check is now conditional on the g2h device being reachable
> from vsock->net, but that condition can change after the CID has been
> accepted. Is it re-checked anywhere?
> 
> With the device assigned to a local mode namespace A, a VMM in namespace B
> sees vsock_find_cid(B, guest_cid) return false, because
> __vsock_registered_transport_cid() reports VMADDR_CID_ANY for the g2h slot
> when !vsock_g2h_net_reachable(B). So a CID that previously got -EADDRINUSE
> is now installed.
> 
> The device can become reachable from B afterwards, either by another
> VSOCK_CMD_DEV_NETNS_SET or automatically when namespace A is deleted and
> vsock_g2h_net_reset() moves the device back to init_net.
> vsock_g2h_net_assign() only walks vsock_connected_table, so registered
> vhost guest CIDs are never revisited, and then:
> 
>   - vsock_use_local_transport(B, cid) computes a non-ANY g2h CID and
>     returns true, so vsock_assign_transport() picks transport_local ahead
>     of transport_h2g and connects intended for the nested guest land on
>     vsock_loopback
>   - vsock_find_cid(B, cid) starts accepting bind() on that CID
> 
> Does the nested guest become unreachable from that namespace at that
> point, which is what the pre-patch unconditional check prevented?

Sashiko doesn't frame this problem that well here IMHO, but it is a real
issue. The issue is about CID collision between g2h and h2g,
particularly if the g2h is in another namespace. In theory we should
allow a CID to be allocated in a local namespace if it is free there.
The issue is then if the user moves that device into a namespace where
that CID is already in-use.

We can reject VSOCK_CMD_DEV_NETNS_SET to handle that case, but the
relocation to init_net upon namespace deletion is more complicated.

In tcp/ip land when a namespace is torn down and a device is
moved to the init_net, it loses its IP address. There is no address
collision. We can't really do that here.

In our case, if the g2h CID 10 is in some other namespace, in theory
don't want to reject vhost trying to allocate CID 10 because that leaks
information about another namespace.

I also don't think we want to reject namespace deletion in this case
either, because then the namespace lifetime will be at the mercy of the
init_net's vmm process that holds the CID.

Right now I'm thinking that just preventing vhost from allocating CIDs
of any g2h (even if in another local namespace) might be the best
solution at hand, even if it exposes a leak.

I also considered the possibility of the g2h device falling back to some
alias_cid when there is contention due to a namespace move... but that
is a can of worms.

Do you have any thoughts on this Stefano?

> 
> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > index 370fcd3ddabc2..dbf1a6aa367fe 100644
> > --- a/include/net/af_vsock.h
> > +++ b/include/net/af_vsock.h
> > @@ -190,6 +192,16 @@ struct vsock_transport {
> >  
> >  	/* Zero-copy. */
> >  	bool (*msgzerocopy_allow)(void);
> > +
> > +	/* True if the G2H transport honours VSOCK_CMD_DEV_NETNS_SET. A
> > +	 * transport that sets this must also implement reset.
> > +	 */
> > +	bool netns_assign_allow;
> > +
> > +	/* Send a reset to @vsk's peer. @skb is the packet being replied to, or
> > +	 * NULL when the reset is not a reply. May sleep.
> > +	 */
> > +	int (*reset)(struct vsock_sock *vsk, struct sk_buff *skb);
> >  };
> 
> [Severity: Medium]
> 
> Which locks may a ->reset() implementation assume are held?
> 
> vsock_g2h_reset_unreachable() calls t->reset(vsk, NULL) with only
> vsock_register_mutex held and no socket lock. Every existing caller of
> virtio_transport_reset(), the implementation wired up later in the series
> (close work and close timeout, the recv "destroy" paths, shutdown), runs
> under lock_sock() or lock_sock_nested(), which is what serialises
> vsk->trans and the addresses the reset reads against close/release and
> recv processing.
> 
> Taking lock_sock() around the callback does not look available from this
> call site, since vsock_connect() holds lock_sock(sk) and then acquires
> vsock_register_mutex inside vsock_assign_transport(), making sock lock ->
> register mutex the established order.
> 
> The sweep also stores sk->sk_state and sk->sk_err under vsock_table_lock
> only, so a concurrent lock_sock() holder can overwrite sk_state and the
> reset is lost.
> 
> Separately, the loop performs one sleeping send per collected socket while
> holding vsock_register_mutex, which blocks socket creation, connect and
> the CID getters for the duration. Can the resets run outside that mutex,
> and can this comment state the locking context the callback is invoked in?
> 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 95a435aef512b..9938dd5010192 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> 
> [ ... ]
> 
> > @@ -654,6 +716,13 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> >  		goto err;
> >  	}
> >  
> > +	if (new_transport && new_transport == transport_g2h &&
> > +	    vsock_netns_assignable(new_transport) &&
> > +	    !vsock_g2h_net_reachable(sock_net(sk))) {
> > +		ret = -ENETUNREACH;
> > +		goto err;
> > +	}
> > +
> 
> [Severity: Low]
> 
> This gate sits after the same-transport shortcut a few lines above it:
> 
> 	if (vsk->transport && vsk->transport == new_transport) {
> 		ret = 0;
> 		goto err;
> 	}
> 
> so a socket that already holds transport_g2h, for instance one left
> assigned by an earlier failed connect, never reaches the -ENETUNREACH
> check.
> 
> At the end of the series nothing is emitted from an excluded namespace,
> because vsock_connect() calls transport->stream_allow() right after
> vsock_assign_transport() and the following patch makes
> virtio_transport_stream_allow() return vsock_g2h_net_reachable(...). Would
> it still be clearer to place this check before the shortcut?
> 
> > @@ -742,6 +812,173 @@ bool vsock_find_cid(unsigned int cid)
> >  }
> >  EXPORT_SYMBOL_GPL(vsock_find_cid);
> 
> [ ... ]
> 
> > +/* Move @vsk to TCP_ESTABLISHED and into the connected table, unless the device
> > + * has moved to a namespace @vsk cannot reach. Returns false without doing
> > + * either in that case.
> > + *
> > + * The reset sweep walks the same table under the same lock, so an assign
> > + * cannot land between the check and the insert: either the sweep finds @vsk
> > + * and resets it, or @vsk is never added.
> > + */
> > +bool vsock_maybe_set_connected(struct vsock_sock *vsk)
> > +{
> > +	struct list_head *list;
> > +	bool reachable;
> > +
> > +	list = vsock_connected_sockets(&vsk->remote_addr, &vsk->local_addr);
> > +
> > +	spin_lock_bh(&vsock_table_lock);
> > +	reachable = vsock_g2h_reachable_sk(vsk);
> > +	if (reachable) {
> > +		sk_vsock(vsk)->sk_state = TCP_ESTABLISHED;
> > +		__vsock_insert_connected(list, vsk);
> > +	}
> > +	spin_unlock_bh(&vsock_table_lock);
> > +
> > +	return reachable;
> > +}
> > +EXPORT_SYMBOL_GPL(vsock_maybe_set_connected);
> 
> [Severity: Low]
> 
> The invariant described here needs every connected-table insertion of an
> assignable transport to go through this helper, but nothing calls it in
> this commit.
> 
> The next patch, "vsock/virtio: support guest device network namespace",
> adds the calls in virtio_transport_recv_connecting() and
> virtio_transport_recv_listen(), so the invariant holds from there on. Is
> the split intentional, or should the helper land with its users?
> 
> > +/* Reset every connected socket of @t that can no longer reach the g2h device,
> > + * and let the transport tell each peer.
> > + */
> > +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
> > +{
> 
> [ ... ]
> 
> > +			if (vsk->transport != t ||
> > +			    sk->sk_state == TCP_CLOSE ||
> > +			    vsock_g2h_reachable_sk(vsk))
> > +				continue;
> > +
> > +			sk->sk_state = TCP_CLOSE;
> > +			sk->sk_err = ECONNRESET;
> > +			sk_error_report(sk);
> > +
> > +			sock_hold(sk);
> > +			list_add_tail(&vsk->pending_reset, &reset_list);
> > +		}
> > +	}
> > +
> > +	spin_unlock_bh(&vsock_table_lock);
> 
> [Severity: High]
> 
> The sweep marks the socket TCP_CLOSE with ECONNRESET but leaves it linked
> in vsock_connected_table and keeps vsk->transport assigned. Can that
> socket then be inserted into the table a second time?
> 
> A connector blocked in vsock_connect() wakes up, leaves the wait loop and
> runs:
> 
> net/vmw_vsock/af_vsock.c:vsock_connect() {
> 	...
> 	err = sock_error(sk);
> 	if (err) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
> 	}
> 	...
> }
> 
> so connect() is retryable while the socket is still a member of the
> connected table. On the retry vsock_assign_transport() takes the shortcut:
> 
> 	if (vsk->transport && vsk->transport == new_transport) {
> 		ret = 0;
> 		goto err;
> 	}
> 
> which skips vsk->transport->release() and vsock_deassign_transport(), so
> vsock_remove_connected() is never reached. When the handshake completes
> again, virtio_transport_recv_connecting() reaches:
> 
> net/vmw_vsock/af_vsock.c:__vsock_insert_connected() {
> 	sock_hold(&vsk->sk);
> 	list_add(&vsk->connected_table, list);
> }
> 
> on a node that is already linked. Does this corrupt the connected hash
> bucket and leak the extra sock_hold()? A self-referential bucket would
> make later list_for_each_entry() walks under vsock_table_lock, including
> this sweep, vsock_find_connected_socket() and
> vsock_for_each_connected_socket(), never terminate, and with
> CONFIG_DEBUG_LIST the second list_add() trips the corruption check.
> 
> Reaching the reachable-again state does not need a second netlink call:
> vsock_g2h_net_reset() moves the device back to init_net when the assigned
> namespace is deleted.
> 
> Should the sweep also call vsock_remove_connected() on the sockets it
> resets, or otherwise deassign the transport, so a retry cannot re-insert
> an already linked node?
> 
> [ ... ]

Can confirm, this is valid. Will fix.
