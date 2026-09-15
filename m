Received: from mail-oo2-f29.google.com (mail-oo2-f29.google.com [74.125.231.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BF4C8C7B
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498219; cv=none; b=fbhpchHbfktGs6HvGqccbqmZmDypRrAsfUHUiW4KSHVeNw8hMxqlfU3mxW9fpY73+mctMjpLzEy3I2xV42EtENFlxEDc55Ps4HJu0LKQHP0IaOiNnKk8ZZiGDQ5Q7TOf7ZWfKaqVPSgt559O8Y8jzymkPZTbJg3Rh52J1QApMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498219; c=relaxed/simple;
	bh=9A+eOjjaUwl25Jxh1i+EDm3Q5Oju7ez3vCDmq+bF4Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BamYImCglU4O0QEtlbXKGu6LTMWTplLOm7X1ybOnC4fZz5P2hg9awmw4BkoQqDE4PwPbb4y+5xKW9m+OYacY5sPWfU2xGY39qkSCkojG5JUje9EKX4hpcL+Bs4rtrhD5nyneh9lQu9NP5RSGbz10bWBI+TJ7SonPefVEwqRKP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnmHRsXW; arc=none smtp.client-ip=74.125.231.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnmHRsXW"
Received: by mail-oo2-f29.google.com with SMTP id 46e09a7af769-805cc8b4231so31704a34.2
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789498215; x=1790103015; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AcpHMxLCvgd7jq0fbJxq01dB0prdUBYM6HZf7cTnUwc=;
        b=bnmHRsXWKi4pKDSWgfOpB3DFatQiF+tV3vdUhgHL/cSZuxWUI63vZ2ZUtguOhU+UzH
         d1H05t2kEeWi+f6ijQ/rJJkuu38LpFQgK+PxkuS2VGlR9+Wyi8oS+b7Xyq1Dug2ZYAqK
         VmYEbRGiZ3NWPvX6WGMUU3e/EFNCasF3qY+dyZq/50OYqB+iBbwREjPqVNQ3OJLBKfHt
         45YEexUWPTT89ITkaSncHiIdcRlk1AK0HBmKdKtUXsdJkIOGny+5r/ob49bcOb1aeOGk
         bZRVfTqS7JVxorc7d1eavpbyZHp1PksPoE7ZJT/1ZRHArkZoz41nUgwzLRSeA3jXZ9s7
         YfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789498215; x=1790103015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AcpHMxLCvgd7jq0fbJxq01dB0prdUBYM6HZf7cTnUwc=;
        b=AeDLv3VnzWrM9CzJvb5rYrQToWgC3Q8YJVCaxq9LnMA+PVj5WKbkc1dGT4OhJy9m0K
         1vfp0N+NqWl/9YLUS08HDgwIfB5X89OdubP/BMpdVItr7RuH3P4V9DdMy1qq3Xn3eRkT
         z2VvTpGym9lvn4gHznbonIogl7s0k5FlyDTNesjeJ50G1ZXOu2SJkyH8ewuC8BkhP/My
         vYKrlX7uNqOf9doib2KNMnGCMD4NntdwLY7cv2rIGIgUX3bYT3jG9pRpRSxsZ0YHucBc
         KqTwBKHbG/+l+gqfPYETmhJHmg+diam+iFXbk1XGbcL3Wqzqu3GFMV3rJByhrSywsjTR
         hFRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcaKN0ec2Y6JBx5pjRQ78eGPSUuxCteWeY+fflg09pCV4hqAI4OLUqJ5f6dEjSunyucGkXTzx1bVdVHcN+1Q==@lists.linux.dev
X-Gm-Message-State: AFuF++k6tFe+DCFC+NW4JaUOxps4YnC5W5eTgbiGXTx9i+EdppLsJOAu
	CQeuCervYPloMBc5Xpciehx0QVdEMf3yfSm1JySXtfUTJdIrdZXxlfUR
X-Gm-Gg: AYBFou2xILYdiEllcP2zzQburu6OfC1lci08ItGlR/onWwU9nTB9m2bchDfIkGtQaXZ
	oT8qc8LVUgdt2S+rPe5fRDgB+eysi8N0v5Khgh7uINwwRq4l97yU60w4E31jNSHP8ratX39H63R
	RPhrNaq+AcGv9P9KZ1sXucek9C+1qRgLAwNjJjNtcMTkfYRoazMGeKoYWmLCpy77OK4P0/idlT1
	37XHEM554pINjZIrQH5EMrpUZIxFYR8s5Q95GFD5+914I0++TNSJEuGusfUSXbONwklb0hR8ip7
	7dDvOUppg2M58GslKejVFpf361GUnx1I5PTyL3wlmudapzNN5T5aCG5sTzWDePnPvpu6azKujK6
	Gs8X9+W0z8FYoTUJi2oPsOdLPgWVIXMbLwoUoUNv64bHiL0YleMZKThFwd83Q3aC8Giqm+qG3+T
	O6RPS0DBcKV6VzGRs5CIBjiKO4wFAoKqzMA1ftKTpLa6SfiABaDGUSuSU6O5mRJYKNI8+FtQOxj
	FvrVHfIPmKiHwvD3fp6
X-Received: by 2002:a05:6830:6006:b0:805:9b28:87d7 with SMTP id 46e09a7af769-80a7545c0cdmr2302738a34.8.1789498214786;
        Tue, 15 Sep 2026 11:50:14 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80b07ad0373sm160944a34.26.2026.09.15.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:50:14 -0700 (PDT)
Date: Tue, 15 Sep 2026 11:50:10 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sargun@sargun.me, jlinbox@meta.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 2/6] vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
Message-ID: <aqmTYoCMmzx1BM1v@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
 <aqlTlFvQL34-WViB@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqlTlFvQL34-WViB@sgarzare-redhat>

On Tue, Sep 15, 2026 at 05:28:25PM +0200, Stefano Garzarella wrote:
> On Wed, Sep 02, 2026 at 04:00:48PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Namespaces let a host isolate a VM's vsock traffic to a specific
> > namespace, but in a guest vsock traffic cannot be isolated to a
> > namespace. The vsock device is hardcoded to global mode and can't be
> > moved into a local-mode namespace.
> > 
> > Introduce ioctl IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS on /dev/vsock that
> 
> We already discussed about netlink, but I'm not sure how much work can
> take, here just another alternative, what about adding
> /proc/sys/net/vsock/g2h_owner sysctl that can be read/write where:
> 0 - no owner
> 1 - owner
> 
> 0 -> 1 transition, move the device in the new nets
> 1 -> 0 transition, reset back to init_ns

That seems reasonable, but if multi-device support ever lands, this
might be harder to adapt cleanly?

> 
> > gives userspace a way to move the device to the calling pid's namespace.
> > The call requires CAP_NET_ADMIN in the root user namespace. A privileged
> > user wishing to "unassign" the device can move it to the init_netns,
> > which is hardcoded to global mode (so no unassign call is necessary).
> > 
> > A getter to read the current assignment back was considered, returning
> > either the namespace's net_cookie or its nsfs inode number, but neither
> > seemed useful enough to bake into the uAPI now. It can be added later if
> > a user turns up that needs it.
> > 
> > Add a transport hook to indicate support for guest namespacing, so that
> > transports may opt in/out. A transport that opts out keeps the
> > reachability rules it had before this ioctl existed.
> > 
> > Sockets are reset when the underlying device moves to a different
> > namespace, so as to prevent reachability from the previous and now
> > disallowed namespace.
> > 
> > Following the approach of netdevs, the device returns to init_net when
> > its namespace is removed. Care is taken to not break flows when the
> > device is inside a global namespace that is being torn down and alive
> > sockets are in a different global namespace. In this scenario, the
> > device's netns getter pre-emptively falls back to the init_net (always
> > global) so that these flows are not disrupted. If init_netns ever
> > supports local-mode in the future, this logic will have to be changed.
> > 
> > Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> > Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Documentation/admin-guide/sysctl/net.rst |  18 +++
> > include/net/af_vsock.h                   |   7 ++
> > include/uapi/linux/vm_sockets.h          |   6 +
> > net/vmw_vsock/af_vsock.c                 | 198 ++++++++++++++++++++++++++++++-
> > 4 files changed, 228 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index e586e17fc7a5..1e9c0d2be7b8 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -515,6 +515,24 @@ their hosts. The behavior of VSOCK sockets in a network namespace is determined
> > by the namespace's mode (``global`` or ``local``), which controls how CIDs
> > (Context IDs) are allocated and how sockets interact across namespaces.
> > 
> > +In a guest, the vsock device owned by the guest-to-host (G2H) transport belongs
> > +to one network namespace at a time. The ``IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS``
> > +ioctl on ``/dev/vsock`` moves it to the namespace of the calling process, which
> > +requires ``CAP_NET_ADMIN`` in the initial user namespace. The namespace's mode
> > +decides who may then use the device:
> > +
> > +- ``global`` - every ``global`` mode namespace may use it.
> > +- ``local`` - only that namespace may use it, which reserves the connection to
> > +  the host for it alone.
> > +
> > +The device starts out in the initial namespace, so until the ioctl is issued
> > +nothing has moved and no mode has changed.
> > +
> > +Connections made before the move, from a namespace that can no longer reach the
> > +device, are reset. The device returns to the initial namespace when the
> > +namespace it was moved to is deleted, so assigning it to the initial namespace
> > +is how an assignment is undone.
> > +
> > ns_mode
> > -------
> > 
> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > index 87fdec60ba45..64c4b205a11b 100644
> > --- a/include/net/af_vsock.h
> > +++ b/include/net/af_vsock.h
> > @@ -190,6 +190,9 @@ struct vsock_transport {
> > 
> > 	/* Zero-copy. */
> > 	bool (*msgzerocopy_allow)(void);
> > +
> > +	/* True if the transport honours IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS. */
> 
> "if the G2H transport ..."

Duly noted.

> 
> > +	bool (*netns_assign_allow)(void);
> 
> What about having just a bool (and maybe we should do the same for
> msgzerocopy_allow())?

Yes, that sounds good to me.

> 
> > };
> > 
> > /**** CORE ****/
> > @@ -235,6 +238,10 @@ void vsock_for_each_connected_socket(const struct vsock_transport *transport,
> > int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> > bool vsock_find_cid(unsigned int cid);
> > void vsock_linger(struct sock *sk);
> > +struct net *vsock_g2h_net_get(void);
> > +bool vsock_g2h_net_reachable(struct net *net);
> > +bool vsock_g2h_reachable_sk(struct vsock_sock *vsk);
> > +bool vsock_maybe_set_connected(struct vsock_sock *vsk);
> > 
> > /**** TAP ****/
> > 
> > diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
> > index e05280e41522..894b0d65b458 100644
> > --- a/include/uapi/linux/vm_sockets.h
> > +++ b/include/uapi/linux/vm_sockets.h
> > @@ -195,6 +195,12 @@ struct sockaddr_vm {
> > 
> > #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
> > 
> > +/* Assign the guest's vsock device to the network namespace of the calling
> > + * process. Requires CAP_NET_ADMIN in the initial user namespace. To undo an
> > + * assignment, assign the device to the initial network namespace.
> > + */
> > +#define IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS	_IO(7, 0xba)
> > +
> > /* MSG_ZEROCOPY notifications are encoded in the standard error format,
> >  * sock_extended_err. See Documentation/networking/msg_zerocopy.rst in
> >  * kernel source tree for more details.
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 29cde17e08f3..ad11f0f56eb8 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -130,6 +130,24 @@
> >  *       a different transport that *does* support local mode. For
> >  *       example, virtio-vsock may not support local mode, but the socket
> >  *       may still accept a connection from vhost-vsock which does.
> > + *
> > + * - A guest has a single vsock device, owned by the guest->host transport.
> > + *   IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS on /dev/vsock assigns it to the
> > + *   namespace of the caller. It starts out in init_net. The mode rules then
> > + *   decide who may use it, and which namespace packets from the host are
> > + *   delivered to:
> > + *
> > + *   - assigned to a global mode namespace - every global mode namespace may
> > + *     use it. Until the ioctl is issued nothing has moved and no mode has
> > + *     changed, so the default is the behaviour that predates it.
> > + *   - assigned to a local mode namespace - only that namespace may use it.
> > + *     This is how a nested VM is isolated from the rest of the guest.
> > + *
> > + *   Connections made before an assignment, from a namespace that can no
> > + *   longer reach the device, are reset.
> > + *
> > + *   No reference is taken on the assigned namespace. As is done for netdevs,
> > + *   the device is moved back to init_net when that namespace is destroyed.
> >  */
> > 
> > #include <linux/compat.h>
> > @@ -208,6 +226,11 @@ static const struct vsock_transport *transport_dgram;
> > static const struct vsock_transport *transport_local;
> > static DEFINE_MUTEX(vsock_register_mutex);
> > 
> > +/* Network namespace of the g2h device. Protected by
> > + * vsock_register_mutex/RCU.
> > + */
> > +static struct net __rcu *vsock_g2h_net = RCU_INITIALIZER(&init_net);
> > +
> > /**** UTILS ****/
> > 
> > /* Each bound VSocket is stored in the bind hash table and each connected
> > @@ -548,6 +571,17 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
> > 	vsk->transport = NULL;
> > }
> > 
> > +/* Return true if the loaded g2h transport honours namespace assignment. One
> > + * that does not keeps the reachability rules it had before the ioctl existed.
> > + *
> > + * Must be called with vsock_register_mutex held.
> > + */
> > +static bool vsock_g2h_netns_assignable(void)
> > +{
> > +	return transport_g2h && transport_g2h->netns_assign_allow &&
> > +	       transport_g2h->netns_assign_allow();
> > +}
> > +
> > /* Assign a transport to a socket and call the .init transport callback.
> >  *
> >  * Note: for connection oriented socket this must be called when vsk->remote_addr
> > @@ -622,6 +656,13 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> > 		goto err;
> > 	}
> > 
> > +	if (new_transport && new_transport == transport_g2h &&
> > +	    vsock_g2h_netns_assignable() &&
> > +	    !vsock_g2h_net_reachable(sock_net(sk))) {
> > +		ret = -ENETUNREACH;
> > +		goto err;
> > +	}
> > +
> > 	/* We increase the module refcnt to prevent the transport unloading
> > 	 * while there are open sockets assigned to it.
> > 	 */
> > @@ -710,6 +751,140 @@ bool vsock_find_cid(unsigned int cid)
> > }
> > EXPORT_SYMBOL_GPL(vsock_find_cid);
> > 
> > +/* Return the g2h devices' namespace with a reference held, or NULL if that
> > + * namespace is being destroyed.
> > + */
> > +struct net *vsock_g2h_net_get(void)
> > +{
> > +	struct net *assigned;
> > +	struct net *net;
> > +
> > +	rcu_read_lock();
> > +	assigned = rcu_dereference(vsock_g2h_net);
> > +	net = maybe_get_net(assigned);
> > +
> > +	/* !net means the net is about to be destroyed, at which point the g2h
> > +	 * device will move to the init_net.  If the init_net and the dying net
> > +	 * are both global mode, we use the init_net as a fallback to avoid
> > +	 * disrupting global-mode flows. The per-net destructor hook will
> > +	 * eventually move the g2h device to the init_net anyway.
> > +	 */
> > +	if (!net && vsock_net_check_mode(&init_net, assigned))
> > +		net = get_net(&init_net);
> > +	rcu_read_unlock();
> > +
> > +	return net;
> > +}
> > +EXPORT_SYMBOL_GPL(vsock_g2h_net_get);
> > +
> > +bool vsock_g2h_net_reachable(struct net *net)
> > +{
> > +	bool reachable;
> > +
> > +	rcu_read_lock();
> > +	reachable = vsock_net_check_mode(net, rcu_dereference(vsock_g2h_net));
> > +	rcu_read_unlock();
> > +
> > +	return reachable;
> > +}
> > +EXPORT_SYMBOL_GPL(vsock_g2h_net_reachable);
> > +
> > +bool vsock_g2h_reachable_sk(struct vsock_sock *vsk)
> > +{
> > +	const struct vsock_transport *t = vsk->transport;
> > +
> > +	if (!t || !t->netns_assign_allow || !t->netns_assign_allow())
> > +		return true;
> > +
> > +	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
> > +}
> > +EXPORT_SYMBOL_GPL(vsock_g2h_reachable_sk);
> 
> This seems used only in af_vsock.c
> 
> > +
> > +/* Move @vsk to TCP_ESTABLISHED and into the connected table, unless the device
> > + * has moved to a namespace @vsk cannot reach. Returns false without doing
> > + * either in that case.
> > + *
> > + * vsock_g2h_net_assign() resets the sockets it finds in the same table under
> > + * the same lock. Either vsock_g2h_net_assign() sees the vsk in the table and
> > + * resets it, or it does not see the @vsk in the table and this function
> > + * refuses to add it. This avoids netns assignment racing with outstanding
> > + * connection responses and incoming connection requests.
> > + */
> > +bool vsock_maybe_set_connected(struct vsock_sock *vsk)
> > +{
> > +	struct list_head *list = vsock_connected_sockets(&vsk->remote_addr,
> > +							 &vsk->local_addr);
> > +	bool reachable;
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
> > +
> > +static void vsock_reset_unreachable_sock(struct sock *sk)
> > +{
> > +	if (vsock_g2h_net_reachable(sock_net(sk)))
> > +		return;
> > +
> > +	sk->sk_state = TCP_CLOSE;
> > +	sk->sk_err = ECONNRESET;
> > +	sk_error_report(sk);
> 
> Should we send the reset to the other peer too?
> 
> Or avoid to set TCP_CLOSE, so the user will see the error and close it?

Sending the reset sounds good. At least the peer won't be waiting around
forever. Will work that into v2.

> 
> > +}
> > +
> > +/* Move the g2h device to @net. Returns -ENODEV if no g2h transport is loaded
> > + * and -EOPNOTSUPP if the loaded one cannot be moved.
> > + */
> > +static int vsock_g2h_net_assign(struct net *net)
> > +{
> > +	int ret = 0;
> > +
> > +	mutex_lock(&vsock_register_mutex);
> > +	if (!transport_g2h) {
> > +		ret = -ENODEV;
> > +	} else if (!vsock_g2h_netns_assignable()) {
> > +		ret = -EOPNOTSUPP;
> > +	} else {
> > +		/* See vsock_maybe_set_connected() comment about synchronizing
> > +		 * with connecting sockets.
> > +		 */
> > +		rcu_assign_pointer(vsock_g2h_net, net);
> > +		vsock_for_each_connected_socket(transport_g2h,
> > +						vsock_reset_unreachable_sock);
> > +	}
> > +	mutex_unlock(&vsock_register_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +/* Move the g2h device back to init_net if it lives in @net, which is about to
> > + * be destroyed.
> > + */
> > +static void vsock_g2h_net_reset(struct net *net)
> > +{
> > +	bool reset = false;
> > +
> > +	/* Avoid taking the mutex if the namespaces don't match. */
> > +	if (likely(rcu_access_pointer(vsock_g2h_net) != net))
> > +		return;
> > +
> > +	mutex_lock(&vsock_register_mutex);
> > +	if (rcu_access_pointer(vsock_g2h_net) == net) {
> > +		rcu_assign_pointer(vsock_g2h_net, &init_net);
> > +		reset = true;
> > +	}
> > +	mutex_unlock(&vsock_register_mutex);
> > +
> > +	if (reset)
> > +		synchronize_rcu();
> > +}
> > +
> > static struct sock *vsock_dequeue_accept(struct sock *listener)
> > {
> > 	struct vsock_sock *vlistener;
> > @@ -2745,6 +2920,15 @@ static long vsock_dev_do_ioctl(struct file *filp,
> > 			retval = -EFAULT;
> > 		break;
> > 
> > +	case IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS:
> > +		if (!capable(CAP_NET_ADMIN)) {
> > +			retval = -EPERM;
> > +			break;
> > +		}
> > +
> > +		retval = vsock_g2h_net_assign(current->nsproxy->net_ns);
> > +		break;
> > +
> > 	default:
> > 		retval = -ENOIOCTLCMD;
> > 	}
> > @@ -2978,6 +3162,7 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
> > 
> > static __net_exit void vsock_sysctl_exit_net(struct net *net)
> > {
> > +	vsock_g2h_net_reset(net);
> 
> Why calling this in the sysctl_exit ?

Should we add another pernet_operations? I agree the name of
vsock_sysctl_ops does not really fit as a general "do all per-net
operations here" location.

> 
> > 	vsock_sysctl_unregister(net);
> > }
> > 
> > @@ -3104,13 +3289,21 @@ EXPORT_SYMBOL_GPL(vsock_core_register);
> > 
> > void vsock_core_unregister(const struct vsock_transport *t)
> > {
> > +	bool g2h_net_reset = false;
> > +
> > 	mutex_lock(&vsock_register_mutex);
> > 
> > 	if (transport_h2g == t)
> > 		transport_h2g = NULL;
> > 
> > -	if (transport_g2h == t)
> > +	if (transport_g2h == t) {
> > 		transport_g2h = NULL;
> > +		/* The device is gone, so is its namespace assignment. */
> > +		if (rcu_access_pointer(vsock_g2h_net) != &init_net) {
> > +			rcu_assign_pointer(vsock_g2h_net, &init_net);
> > +			g2h_net_reset = true;
> > +		}
> > +	}
> > 
> > 	if (transport_dgram == t)
> > 		transport_dgram = NULL;
> > @@ -3119,6 +3312,9 @@ void vsock_core_unregister(const struct vsock_transport *t)
> > 		transport_local = NULL;
> > 
> > 	mutex_unlock(&vsock_register_mutex);
> > +
> > +	if (g2h_net_reset)
> > +		synchronize_rcu();
> 
> Why we need this? (I'd add also a comment with the reason)

We might actually be able to drop it... I do think we need to keep it in
vsock_g2h_net_reset() because it makes sure that vsock_g2h_net_get()
doesn't dereference a destroyed net.

vsock_core_unregister() isn't on the teardown path, so even if we
re-assign to init_net the previous net is still alive.


One thing I realized when answering your uAPI questions and looking at
the code is that IOCTL_VM_SOCKETS_GET_LOCAL_CID is not namespace aware,
but I think it probably should be? I remember for host ns we strived for
truly strong isolation.

Best,
Bobby
