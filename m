Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7E55D895;
	Tue, 13 Oct 2026 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931925; cv=none; b=DMfoKs9WRO2QnNmVJG6ke7HCnIwhon/TvE+JdPz6opmiqHrMtdSe0Mub5Qceoz7puSGev167R2r4AbC5kEtVIfJcsIiqyqjU5GAeEWwSkcg18uZjAqk4tdU7Ba2d/uW4tCufTMdedOI2sdgsUSj0jOjYTbjGM1pNIMXEPqifUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931925; c=relaxed/simple;
	bh=CCVIN8tDxFjyce8Qxi3ujZwuOTphI4nRXCsdICLjqTQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8exj/xgdgULt7DQFzJnP8De4D2yppNgP636F2XNWkMLkhF9ZR7waOUx69eDWrHCqAybPey4l53RwR/NwrW8luzlyboeLNlnmzkVYIxy/4S7O5gRa64umXa6/UeFbuPoeBQIn+DkDq5WgRymgJjfZZmgR67HM8rRrU1jyRmo2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgY35Fiy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgY35Fiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356E41F000FF;
	Tue, 13 Oct 2026 22:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931917;
	bh=ihtthPd1qtSs1WqvN2e62G8drpORFvU+QPjdaQHYU1I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EgY35Fiy4gFlNd/j2QzMrfvZOmCd1Mow8KC4gkJuxPq0As1NPJTKrMYqAIGHbaIOS
	 WxPEdEuXrFqZmxczkmTC5afQqTsY9qap0A/vcPAZznhqcC/pwt48j22bZodK7wkIho
	 mLDU9zBXfFq8lI7vLrgb6yti2rM9LsL7ywQ0N32ejy5oxCQHpX5dXOvg2lQjNUH/YO
	 pAdJ+RGGi0pjG/Yi3jVU4ha3U4GVd6sXhn/1mxdL+jwarwFL0+mrX2GEa3a2b2IHkk
	 WApXmNWLuPkQ6+ZKj/JwnB1WiXeyHQrwSbPvD0e0+TQNbLS+Iz/rm2HXRiuX0Yf29X
	 JV1ZDQ7gV3JYQ==
Subject: Re: [PATCH net-next v3 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
From: netdev-bot+sashiko@kernel.org
To: bobbyeshleman@meta.com
Cc: sgarzare@redhat.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com,
 edumazet@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
 bobbyeshleman@gmail.com
Date: Tue, 13 Oct 2026 22:51:55 +0000
Message-ID: <179193191574.434549.17107426250790354528@kernel.org>
In-Reply-To: <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Take a namespace that cannot reach the assigned G2H device, on
  a system with vhost-vsock (H2G) and vsock_loopback loaded.
- [Medium] `vsock_g2h_reset_unreachable()` in net/vmw_vsock/af_vsock.c
  resets sockets without lock_sock() while the device stays live.
- [Low] No in-tree transport sets the new capability at this commit.
- [Low] `vsock_g2h_net_assign()` in net/vmw_vsock/af_vsock.c sends the
  success reply before it commits the assignment.

--

vsock: add a netlink command to assign the g2h device to a netns

This patch adds a vsock generic netlink family with two commands.
VSOCK_CMD_DEV_NETNS_SET moves the guest's G2H vsock device into the
caller's network namespace, and VSOCK_CMD_DEV_NETNS_GET reports where the
device is. After a move, connected sockets that can no longer reach the
device are closed with ECONNRESET, and the assignment holds a reference on
the target namespace.

Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> index fe43e85959583..9276479004c0f 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -529,6 +529,43 @@ their hosts. The behavior of VSOCK sockets in a network namespace is determined

[ ... ]

> +Support is transport dependent. A G2H transport that does not implement the
> +move refuses the command with ``EOPNOTSUPP``. Of the in-tree guest transports,
> +only virtio-vsock implements it.

[Severity: Low]
This is a minor point. Is this sentence accurate at this commit?

No in-tree transport sets netns_assign_allow yet, so this check in
vsock_g2h_net_assign() always fails:

	if (!vsock_net_assignable(transport_g2h)) {

As a result, VSOCK_CMD_DEV_NETNS_SET returns -EOPNOTSUPP (or -ENODEV) for
every G2H transport. The new exports vsock_g2h_net_get(), vsock_g2h_net_eq()
and vsock_maybe_set_connected() also have no callers yet.

The next patch in the series, "vsock/virtio: support guest device network
namespace", adds .netns_assign_allow = true to virtio_transport and calls
those helpers. So the mismatch only exists at bisect points between the two
patches. Could this sentence move into that patch?

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 8f34bf68f9164..e663be3bbfa0b 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c

[ ... ]

> @@ -564,7 +632,12 @@ static bool vsock_use_local_transport(unsigned int remote_cid)
>  		return true;
>  
>  	if (transport_g2h) {
> -		return remote_cid == transport_g2h->get_local_cid();
> +		u32 cid = __vsock_registered_transport_cid(&transport_g2h, net);
> +
> +		/* The device may be unreachable from @net, in which case
> +		 * @remote_cid is not the local CID.
> +		 */
> +		return cid != VMADDR_CID_ANY && remote_cid == cid;
>  	} else {
>  		return remote_cid == VMADDR_CID_HOST;
>  	}

[Severity: Medium]
Suppose the G2H device has been assigned to a local mode namespace, and
vhost-vsock and vsock_loopback are also loaded. What happens in a namespace
that can no longer reach the device?

In that namespace, IOCTL_VM_SOCKETS_GET_LOCAL_CID in vsock_dev_do_ioctl()
gets VMADDR_CID_ANY from transport_g2h and falls back to transport_h2g:

	cid = vsock_registered_transport_cid(&transport_g2h, net);
	if (cid == VMADDR_CID_ANY)
		cid = vsock_registered_transport_cid(&transport_h2g,
						     net);

vhost_transport_get_local_cid() returns VHOST_VSOCK_DEFAULT_HOST_CID, so the
namespace is told its local CID is 2. __vsock_find_cid(net, 2) is also true
through the transport_h2g && cid == VMADDR_CID_HOST check, so bind() to
CID 2 succeeds.

A connect() to CID 2 then enters the transport_g2h branch above, because the
pointer is non-NULL. It returns false because cid is VMADDR_CID_ANY, so the
remote_cid == VMADDR_CID_HOST loopback fallback in the else branch is never
reached.

vsock_assign_transport() then picks transport_g2h for
remote_cid <= VMADDR_CID_HOST and fails at the new check:

	if (vsock_g2h_unreachable(new_transport, sock_net(sk))) {
		ret = -ENETUNREACH;

Should an unreachable G2H transport be treated the same as an absent one
here, so that connecting to the namespace's own reported CID uses loopback?
The later virtio patch in the series makes this path reachable and does not
change this logic.

[ ... ]

> @@ -742,8 +823,267 @@ bool vsock_find_cid(unsigned int cid)

[ ... ]

> +/* Close every connected socket of @t that can no longer reach the g2h device.
> + */
> +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
> +{
> +	struct vsock_sock *vsk, *tmp;
> +	struct sock *sk;
> +	int i;
> +
> +	lockdep_assert_held(&vsock_register_mutex);
> +
> +	spin_lock_bh(&vsock_table_lock);
> +
> +	for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++) {
> +		list_for_each_entry_safe(vsk, tmp, &vsock_connected_table[i],
> +					 connected_table) {
> +			sk = sk_vsock(vsk);
> +
> +			if (vsk->transport != t ||
> +			    sk->sk_state == TCP_CLOSE ||
> +			    vsock_g2h_reachable_sk(vsk))
> +				continue;
> +
> +			/* If close has already been scheduled for this socket,
> +			 * we can skip.
> +			 */
> +			if (vsk->close_work_scheduled)
> +				continue;
> +
> +			sk->sk_state = TCP_CLOSE;
> +			sk->sk_err = ECONNRESET;
> +			sk_error_report(sk);
> +
> +			__vsock_remove_connected(vsk);

[Severity: Medium]
Can these writes race with the socket's own state machine?

Only vsock_register_mutex and vsock_table_lock are held here, and neither
one excludes lock_sock() holders. close_work_scheduled is read the same way.

The existing lockless resets, virtio_vsock_reset_sock() and
vhost_vsock_reset_orphans(), only run when the device is going away. Here
the device keeps running, so its RX path can work on the same socket at the
same time.

With the later virtio patch, virtio_transport_rx_work() checks
vsock_g2h_net_eq(net) for each packet but does not synchronize with the
swap. That patch's commit message also notes that an assign can land while
rx_work is draining a batch:

CPU1 (assign)                      CPU2 (rx_work)
                                   vsock_g2h_net_eq(net) returns true
vsock_g2h_net_swap()
                                   virtio_transport_recv_pkt()
                                     lock_sock(sk)
                                     sk_state is TCP_ESTABLISHED
vsock_g2h_reset_unreachable()
  sk->sk_state = TCP_CLOSE
  sk->sk_err = ECONNRESET
  __vsock_remove_connected(vsk)
                                     virtio_transport_recv_connected()
                                       virtio_transport_do_close()
                                         sk->sk_state = TCP_CLOSING

If an incoming SHUTDOWN or RST arrives at that point, doesn't the socket end
up in TCP_CLOSING with ECONNRESET set and outside the connected table?

There is a similar window on the send side. vsock_connectible_sendmsg() may
already have passed its sk_err check and could enqueue one more chunk
through the device after the sweep. KCSAN would also likely report these
unannotated stores against the locked writers.

Refcounting looks balanced, because vsock_remove_connected() re-checks table
membership. So the effect appears to be limited to inconsistent socket
state.

[ ... ]

> +static int vsock_g2h_net_assign(struct net *net, struct sk_buff *msg,
> +				struct genl_info *info)
> +{

[ ... ]

> +	ret = -EMSGSIZE;
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr)
> +		goto unlock;
> +	genlmsg_end(msg, hdr);
> +
> +	ret = genlmsg_reply(msg, info);
> +	msg = NULL;
> +	if (ret)
> +		goto unlock;
> +
> +	old = vsock_g2h_net_swap(net, &old_tracker);
> +
> +	/* See vsock_maybe_set_connected() comment about synchronizing with
> +	 * connecting sockets.
> +	 */
> +	vsock_g2h_reset_unreachable(transport_g2h);

[Severity: Low]
Is this ordering intended? The success reply goes out before
vsock_g2h_net_swap() and vsock_g2h_reset_unreachable() run.

This means userspace can see VSOCK_CMD_DEV_NETNS_SET succeed while
vsock_g2h_net still points at the old namespace and the established sockets
there are still open. Those sockets' send and receive paths take lock_sock(),
not vsock_register_mutex, so the mutex does not hold them off.

The move also depends on the reply being delivered. genlmsg_reply() does a
MSG_DONTWAIT unicast, so if the requester's receive buffer is full it
returns -EAGAIN and the swap is skipped. Neither the commit message nor the
docs mention this failure mode.

Could the swap and the sweep run first, with the reply sent after them?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-vsock-guest-ns-v3-0-b32447c66b23%40meta.com
