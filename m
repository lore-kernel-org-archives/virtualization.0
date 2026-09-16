Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE041CB4C
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563488; cv=none; b=T+xFi4yG0VHieLVxHLiI64jjkhbIAI5VyjuKT01avpSuDJYNR6fnvhbUVwXSdCkLLDP4DBDfSm+bTk5LuplwA0J8cvSeP6l3x1Gt8Ih5Tgu+F7kcBxgLQx56Rsyk4LUM3BDu39P6/nhlnh4NSUSoaUxyzaXTqteLKv/wJMoB7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563488; c=relaxed/simple;
	bh=XtPpBw1QH8nWC5HzGrgI1eK910398/q/Oe8gdd92LpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HK6JCzv87/JJ8dcC3JviJKU38BL4XaJl25I6qEp1Gp2PA00T5XCFhnW2xtwgT/JK1IMt/wO5q8nwDbZNDQSCY70sUzU/ry6wos2D1tnzvuXB4PgaN2IdR33V2d9vhabaJ63dQWojvYeSiWSbF88wPb5qS2OTsJpVNfJKsB0ZOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dm1dZMun; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dm1dZMun"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789563484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hoPAB7dHaYgVjnpxXhRX3HsUt/cMJmwFIRFkXtozlmw=;
	b=dm1dZMunq4qyKLLE9ryM5iq3AhGGS0dhRX7GKt8uANkb5SOCUYDYd7Gbd26y8r+ewg9YT/
	E0vvBrz4N9UjVGmJ6IwXMA4uYXY/wY7IiTEw7QAx7u2iTcFhkKzHiqT3VybtXYp27TGYY0
	zRlevMSpWnwMAZBowCm6Mg1Hlh+FEts=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-eI7PDTuUMB-TuLYzB605jg-1; Wed, 16 Sep 2026 08:58:02 -0400
X-MC-Unique: eI7PDTuUMB-TuLYzB605jg-1
X-Mimecast-MFC-AGG-ID: eI7PDTuUMB-TuLYzB605jg_1789563481
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47d81cf0c4cso3131475f8f.2
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 05:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789563481; x=1790168281;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoPAB7dHaYgVjnpxXhRX3HsUt/cMJmwFIRFkXtozlmw=;
        b=Oe9BdgfZUG0N0veKSl5Kb0uaRU8HFVAFjWTz1o6bGvZinX3D3QR1v5UdrR3vSRx6/d
         th0SvtQ02gm2GisccG8TLoDrORiu3iJr4baETtEWtII/tUflMH/jBjuKadVg5xbB90TB
         7gxn/QwpsOQvzu/XeDoksnFmOqc/n0um7pMv1+/Zh1mZhHplvx6qAf8BrQ1rb6cxq3SG
         cMFaNsLFsiv+UhEg0NFUB1rp1RsSxV3FaDFnSlpQwdjbM2h5E9NQ8wDJ31+x/LVeD/5Y
         CZRWH88TKlM1DZS3pyQda52wZxwsCJdZnKlbdx2dDaZaAKCdNtwYdt/MmAmmzyVMvr6h
         feSg==
X-Forwarded-Encrypted: i=1; AKwUvBwuQmq0an5rYPPPiuRff7z6+Jj6Lg6G5eQ2nvBGi6gdTErPYeIKuPqTFxJFyvzhaMymqx5Hq/Q5p+ENQ3a2vQ==@lists.linux.dev
X-Gm-Message-State: AFuF++m6kPBVdXTERJaGO9c3pw7jKff6Gnd5O03w8KBdMjuP8dKylDYr
	IdVzqCgeP62r1HloBHlt6yrehR2ZG94FPvXeBPJ6mkM77kTYf+hJL0p8XCU2E8O+3oNReZHg0Wc
	70uMCbHz4VhG9U5ELpfSqSAZJQoUjGF3TlycxjT96VxVsecduSzqpgQ357kXc6qg25TKE
X-Gm-Gg: AYBFou38ZthNLiLhdAZRBfkI7KQ2IW4WuZN7SO/vOjaCjhIV2+Ol/EI9WAaSN/5ZDsj
	mA+JKRgvtGwLFz8POPIDAMl4azK7Bih51f/yG/swrPRUcfqf3RHzNVrjlC6Up1EGIAXUaENvM9a
	eJ2d4XbMjM1xw3TJpfLX/CgKoh3GBmovpnKH2Xc+znUL8ZxupqMRkAO3cbxrkLPZuidIBsDjzd5
	zIHt6vD7frfHKekzPvme8R1/UHzkgAxz0o0LyAKCF/bzzmgsLXttMGU+JJ66f7/ED6Xc4ipGoTi
	4LqulPV/olhGhbyCCYthOTk4MflmuoIAgraRQ1lFEtK/Opx25iAEzvAo9FKJdNomYjXU6KtLo2Q
	JyfWrmErW3QWAWbZTsB8TLvnKUEjUwVW4U35GVUax3UG+VA==
X-Received: by 2002:a05:6000:460c:b0:485:8b5d:96d with SMTP id ffacd0b85a97d-4870cf42bedmr7008671f8f.19.1789563481216;
        Wed, 16 Sep 2026 05:58:01 -0700 (PDT)
X-Received: by 2002:a05:6000:460c:b0:485:8b5d:96d with SMTP id ffacd0b85a97d-4870cf42bedmr7008586f8f.19.1789563480644;
        Wed, 16 Sep 2026 05:58:00 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fad3sm6355913f8f.12.2026.09.16.05.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:58:00 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:57:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 2/6] vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
Message-ID: <aqqPXr2LNJUM4yMW@sgarzare-redhat>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
 <aqlTlFvQL34-WViB@sgarzare-redhat>
 <aqmTYoCMmzx1BM1v@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aqmTYoCMmzx1BM1v@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xUthuvufmWvso-ybjFSHEqfHBWMiaDwBWEl5uYhCCig_1789563481
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 15, 2026 at 11:50:10AM -0700, Bobby Eshleman wrote:
>On Tue, Sep 15, 2026 at 05:28:25PM +0200, Stefano Garzarella wrote:
>> On Wed, Sep 02, 2026 at 04:00:48PM -0700, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > Namespaces let a host isolate a VM's vsock traffic to a specific
>> > namespace, but in a guest vsock traffic cannot be isolated to a
>> > namespace. The vsock device is hardcoded to global mode and can't be
>> > moved into a local-mode namespace.
>> >
>> > Introduce ioctl IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS on /dev/vsock that
>>
>> We already discussed about netlink, but I'm not sure how much work can
>> take, here just another alternative, what about adding
>> /proc/sys/net/vsock/g2h_owner sysctl that can be read/write where:
>> 0 - no owner
>> 1 - owner
>>
>> 0 -> 1 transition, move the device in the new nets
>> 1 -> 0 transition, reset back to init_ns
>
>That seems reasonable, but if multi-device support ever lands, this
>might be harder to adapt cleanly?

I see, but maybe we can have a dev0/ dev1/ subfolders in that case.

>
>>
>> > gives userspace a way to move the device to the calling pid's namespace.
>> > The call requires CAP_NET_ADMIN in the root user namespace. A privileged
>> > user wishing to "unassign" the device can move it to the init_netns,
>> > which is hardcoded to global mode (so no unassign call is necessary).
>> >
>> > A getter to read the current assignment back was considered, returning
>> > either the namespace's net_cookie or its nsfs inode number, but neither
>> > seemed useful enough to bake into the uAPI now. It can be added later if
>> > a user turns up that needs it.
>> >
>> > Add a transport hook to indicate support for guest namespacing, so that
>> > transports may opt in/out. A transport that opts out keeps the
>> > reachability rules it had before this ioctl existed.
>> >
>> > Sockets are reset when the underlying device moves to a different
>> > namespace, so as to prevent reachability from the previous and now
>> > disallowed namespace.
>> >
>> > Following the approach of netdevs, the device returns to init_net when
>> > its namespace is removed. Care is taken to not break flows when the
>> > device is inside a global namespace that is being torn down and alive
>> > sockets are in a different global namespace. In this scenario, the
>> > device's netns getter pre-emptively falls back to the init_net (always
>> > global) so that these flows are not disrupted. If init_netns ever
>> > supports local-mode in the future, this logic will have to be changed.
>> >
>> > Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> > Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > ---
>> > Documentation/admin-guide/sysctl/net.rst |  18 +++
>> > include/net/af_vsock.h                   |   7 ++
>> > include/uapi/linux/vm_sockets.h          |   6 +
>> > net/vmw_vsock/af_vsock.c                 | 198 ++++++++++++++++++++++++++++++-
>> > 4 files changed, 228 insertions(+), 1 deletion(-)
>> >

[...]

>> > +
>> > +static void vsock_reset_unreachable_sock(struct sock *sk)
>> > +{
>> > +	if (vsock_g2h_net_reachable(sock_net(sk)))
>> > +		return;
>> > +
>> > +	sk->sk_state = TCP_CLOSE;
>> > +	sk->sk_err = ECONNRESET;
>> > +	sk_error_report(sk);
>>
>> Should we send the reset to the other peer too?
>>
>> Or avoid to set TCP_CLOSE, so the user will see the error and close it?
>
>Sending the reset sounds good. At least the peer won't be waiting around
>forever. Will work that into v2.

If it's too much of work, we can skip it, it's not a strong opinion on 
my side. It was more a question of what we should do ;-)

>
>>
>> > +}
>> > +
>> > +/* Move the g2h device to @net. Returns -ENODEV if no g2h transport is loaded
>> > + * and -EOPNOTSUPP if the loaded one cannot be moved.
>> > + */
>> > +static int vsock_g2h_net_assign(struct net *net)
>> > +{
>> > +	int ret = 0;
>> > +
>> > +	mutex_lock(&vsock_register_mutex);
>> > +	if (!transport_g2h) {
>> > +		ret = -ENODEV;
>> > +	} else if (!vsock_g2h_netns_assignable()) {
>> > +		ret = -EOPNOTSUPP;
>> > +	} else {
>> > +		/* See vsock_maybe_set_connected() comment about synchronizing
>> > +		 * with connecting sockets.
>> > +		 */
>> > +		rcu_assign_pointer(vsock_g2h_net, net);
>> > +		vsock_for_each_connected_socket(transport_g2h,
>> > +						vsock_reset_unreachable_sock);
>> > +	}
>> > +	mutex_unlock(&vsock_register_mutex);
>> > +
>> > +	return ret;
>> > +}
>> > +
>> > +/* Move the g2h device back to init_net if it lives in @net, which is about to
>> > + * be destroyed.
>> > + */
>> > +static void vsock_g2h_net_reset(struct net *net)
>> > +{
>> > +	bool reset = false;
>> > +
>> > +	/* Avoid taking the mutex if the namespaces don't match. */
>> > +	if (likely(rcu_access_pointer(vsock_g2h_net) != net))
>> > +		return;
>> > +
>> > +	mutex_lock(&vsock_register_mutex);
>> > +	if (rcu_access_pointer(vsock_g2h_net) == net) {
>> > +		rcu_assign_pointer(vsock_g2h_net, &init_net);
>> > +		reset = true;
>> > +	}
>> > +	mutex_unlock(&vsock_register_mutex);
>> > +
>> > +	if (reset)
>> > +		synchronize_rcu();
>> > +}
>> > +
>> > static struct sock *vsock_dequeue_accept(struct sock *listener)
>> > {
>> > 	struct vsock_sock *vlistener;
>> > @@ -2745,6 +2920,15 @@ static long vsock_dev_do_ioctl(struct file *filp,
>> > 			retval = -EFAULT;
>> > 		break;
>> >
>> > +	case IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS:
>> > +		if (!capable(CAP_NET_ADMIN)) {
>> > +			retval = -EPERM;
>> > +			break;
>> > +		}
>> > +
>> > +		retval = vsock_g2h_net_assign(current->nsproxy->net_ns);
>> > +		break;
>> > +
>> > 	default:
>> > 		retval = -ENOIOCTLCMD;
>> > 	}
>> > @@ -2978,6 +3162,7 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
>> >
>> > static __net_exit void vsock_sysctl_exit_net(struct net *net)
>> > {
>> > +	vsock_g2h_net_reset(net);
>>
>> Why calling this in the sysctl_exit ?
>
>Should we add another pernet_operations? I agree the name of
>vsock_sysctl_ops does not really fit as a general "do all per-net
>operations here" location.

Aaaaa, it's not really related to sysctl.

Maybe we can rename it or add another pernet_operations.

>
>>
>> > 	vsock_sysctl_unregister(net);
>> > }
>> >
>> > @@ -3104,13 +3289,21 @@ EXPORT_SYMBOL_GPL(vsock_core_register);
>> >
>> > void vsock_core_unregister(const struct vsock_transport *t)
>> > {
>> > +	bool g2h_net_reset = false;
>> > +
>> > 	mutex_lock(&vsock_register_mutex);
>> >
>> > 	if (transport_h2g == t)
>> > 		transport_h2g = NULL;
>> >
>> > -	if (transport_g2h == t)
>> > +	if (transport_g2h == t) {
>> > 		transport_g2h = NULL;
>> > +		/* The device is gone, so is its namespace assignment. */
>> > +		if (rcu_access_pointer(vsock_g2h_net) != &init_net) {
>> > +			rcu_assign_pointer(vsock_g2h_net, &init_net);
>> > +			g2h_net_reset = true;
>> > +		}
>> > +	}
>> >
>> > 	if (transport_dgram == t)
>> > 		transport_dgram = NULL;
>> > @@ -3119,6 +3312,9 @@ void vsock_core_unregister(const struct vsock_transport *t)
>> > 		transport_local = NULL;
>> >
>> > 	mutex_unlock(&vsock_register_mutex);
>> > +
>> > +	if (g2h_net_reset)
>> > +		synchronize_rcu();
>>
>> Why we need this? (I'd add also a comment with the reason)
>
>We might actually be able to drop it... I do think we need to keep it in
>vsock_g2h_net_reset() because it makes sure that vsock_g2h_net_get()
>doesn't dereference a destroyed net.
>
>vsock_core_unregister() isn't on the teardown path, so even if we
>re-assign to init_net the previous net is still alive.

Agree.

>
>
>One thing I realized when answering your uAPI questions and looking at
>the code is that IOCTL_VM_SOCKETS_GET_LOCAL_CID is not namespace aware,
>but I think it probably should be? I remember for host ns we strived for
>truly strong isolation.

Can you elabore a bit more?

Thanks,
Stefano

