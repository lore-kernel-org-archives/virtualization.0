Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5A2D73A6
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197096; cv=none; b=ICct54LzVosFvHGAZD7A9u5xftuUlQ5FrkjKRfY6B2FJIntOKSRtTEwBeoKfd/k1DfPG/g7B7dxyJA3hAnYQXiaDQPA22b8QRsS48vEoW6RthxthuIOxDvGqjCAjIdczCssmhHngxZcc7sNpCwZFAEzk4XkzT7P1hE9d0K5whGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197096; c=relaxed/simple;
	bh=xHmRw2cRQagCKkS8PJSihbgYajdbuGTI060lbUJ2Oyk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw2JvFpL0GVP/AAjmtlAVC3FWb2gNofqaCT99PdeBMfKt6omTQ5w7LJXUjo5FZNB8TXmevOa/zRBptfn3JNdxqXMVhCIcsaIQ4y/pgM8wxXoPC03hcvGgbtZJ9EL3n2U1fkXaT9rmbumiz0NQGXMbfS374hlO0c99gFcJ5k/XCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VyCBASqu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VyCBASqu"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69GNFjUY611926;
	Fri, 16 Oct 2026 17:31:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=zby02wAL5TpiWDd6bifHL/lm8nLGoWYVqnELw
	eQC2EM=; b=VyCBASquBzYKAzjY1W+65UoYOmwFqsxOYxfxIAN8L1KsSHDC2YgK4
	D+v0gY+gDeGF21MY4LW/PHxo/9W7FEnIf5qFQdEvvc4xLhdh/yQ15eAlga/AK4Ak
	bnxXyFPAXOl8e+JKAyFVl3wAj4e418pg2LrfyIDlMcrlOP6rGohIDyMumo7iYB9I
	XqE47CR2YXmQz8/jG+JopknlSqORe1L8ghhfsdm8Y7bUIamWtn2OFkuGGaV2VvOd
	Sa9tXXKIfgNMOM1rST0Tu7ayMPUw79qmpStrw0rcfkKEj4VdCzl0h9R/8g0LG1vO
	3aXCmAKC8nkYAIgCO1l28nLfqSddXLrJQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hb52n271a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 16 Oct 2026 17:31:14 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Sat, 17 Oct
 2026 00:31:12 +0000
Date: Fri, 16 Oct 2026 17:31:11 -0700
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <sgarzare@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <stefanha@redhat.com>, <mst@redhat.com>,
        <jasowangio@gmail.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <shuah@kernel.org>, <rdunlap@infradead.org>,
        <donald.hunter@gmail.com>, <edumazet@kernel.org>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>
Subject: Re: [PATCH net-next v3 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Message-ID: <atLBzxk7MKIfjcOV@devvm29614.prn0.facebook.com>
References: <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
 <179193191574.434549.17107426250790354528@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179193191574.434549.17107426250790354528@kernel.org>
X-Proofpoint-GUID: rYRV4izQldbowqQDpsQbkvqZ4Wxxf07w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwMSBTYWx0ZWRfX1H+Z4ndQMHwb
 K3Oc9Y4lMwR1a2odi/8d/9MrN6pu09uo9sJ+Y99BsJHcP3olrukV8IlS/dn8oNfEabf2OuU/8hX
 EYErk/hpIfRhqwJpqr9B3S6ZYOjhHRyKHcvFbigPUH31YE08LqHARDGL8dQHHlPosnUSN6aOGR0
 F/SQDaIhzJqY2fzyLuYPTFhwFpiYO/xMGjPeKpCxvGmIoYOBW+K60l2x3Up+gf7Bn0rX5Dqhy4r
 da4bQLUeOPNoO76SB/x3kwUbs01zAl/9LFDtUiB/fVH2IzpoQQ63Zp5nwxu3FTFEBXSIJ1OFeh1
 QSOzr/ulGng1KM9F359UaJpe4Na5TrQyOcZMDrvx9zzgu1dcgp+4cGlAwK1fRuCSjRWEmNHz6X7
 +n9/YNAMOlmKqu6v9aRwANa4crIIrb/uboxNYRj7TauEQOsAHMSPS5WUQLJnaljoAqRviEx1hrQ
 vG6PSvdm4VtVbvsh2eQ==
X-Authority-Analysis: v=2.4 cv=KNrPn1Fo c=1 sm=1 tr=0 ts=6ad2c1d2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8
 a=9R54UkLUAAAA:8 a=VabnemYjAAAA:8 a=zjU2S2RF1nsdpTlKO_gA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: rYRV4izQldbowqQDpsQbkvqZ4Wxxf07w
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwMSBTYWx0ZWRfXzTs+hVolHVn8
 a0qQgW5jauiNKbTZAa2LoUcTsLH2vk6afuzGrJ8JYWqUUa5vG0V3UrKArMwXeZHtXFqzcuE4CgD
 cp2vD48U1/u2le2l7Zh4jUI8uO0kpA8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01

On Tue, Oct 13, 2026 at 10:51:55PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 � High: 0 � Medium: 2 � Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Take a namespace that cannot reach the assigned G2H device, on
>   a system with vhost-vsock (H2G) and vsock_loopback loaded.
> - [Medium] `vsock_g2h_reset_unreachable()` in net/vmw_vsock/af_vsock.c
>   resets sockets without lock_sock() while the device stays live.
> - [Low] No in-tree transport sets the new capability at this commit.
> - [Low] `vsock_g2h_net_assign()` in net/vmw_vsock/af_vsock.c sends the
>   success reply before it commits the assignment.

pw-bot: cr

> 
> --
> 
> vsock: add a netlink command to assign the g2h device to a netns
> 
> This patch adds a vsock generic netlink family with two commands.
> VSOCK_CMD_DEV_NETNS_SET moves the guest's G2H vsock device into the
> caller's network namespace, and VSOCK_CMD_DEV_NETNS_GET reports where the
> device is. After a move, connected sockets that can no longer reach the
> device are closed with ECONNRESET, and the assignment holds a reference on
> the target namespace.
> 
> Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
> 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index fe43e85959583..9276479004c0f 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -529,6 +529,43 @@ their hosts. The behavior of VSOCK sockets in a network namespace is determined
> 
> [ ... ]
> 
> > +Support is transport dependent. A G2H transport that does not implement the
> > +move refuses the command with ``EOPNOTSUPP``. Of the in-tree guest transports,
> > +only virtio-vsock implements it.
> 
> [Severity: Low]
> This is a minor point. Is this sentence accurate at this commit?
> 
> No in-tree transport sets netns_assign_allow yet, so this check in
> vsock_g2h_net_assign() always fails:
> 
> 	if (!vsock_net_assignable(transport_g2h)) {
> 
> As a result, VSOCK_CMD_DEV_NETNS_SET returns -EOPNOTSUPP (or -ENODEV) for
> every G2H transport. The new exports vsock_g2h_net_get(), vsock_g2h_net_eq()
> and vsock_maybe_set_connected() also have no callers yet.
> 
> The next patch in the series, "vsock/virtio: support guest device network
> namespace", adds .netns_assign_allow = true to virtio_transport and calls
> those helpers. So the mismatch only exists at bisect points between the two
> patches. Could this sentence move into that patch?
> 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 8f34bf68f9164..e663be3bbfa0b 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> 
> [ ... ]
> 
> > @@ -564,7 +632,12 @@ static bool vsock_use_local_transport(unsigned int remote_cid)
> >  		return true;
> >  
> >  	if (transport_g2h) {
> > -		return remote_cid == transport_g2h->get_local_cid();
> > +		u32 cid = __vsock_registered_transport_cid(&transport_g2h, net);
> > +
> > +		/* The device may be unreachable from @net, in which case
> > +		 * @remote_cid is not the local CID.
> > +		 */
> > +		return cid != VMADDR_CID_ANY && remote_cid == cid;
> >  	} else {
> >  		return remote_cid == VMADDR_CID_HOST;
> >  	}
> 
> [Severity: Medium]
> Suppose the G2H device has been assigned to a local mode namespace, and
> vhost-vsock and vsock_loopback are also loaded. What happens in a namespace
> that can no longer reach the device?
> 
> In that namespace, IOCTL_VM_SOCKETS_GET_LOCAL_CID in vsock_dev_do_ioctl()
> gets VMADDR_CID_ANY from transport_g2h and falls back to transport_h2g:
> 
> 	cid = vsock_registered_transport_cid(&transport_g2h, net);
> 	if (cid == VMADDR_CID_ANY)
> 		cid = vsock_registered_transport_cid(&transport_h2g,
> 						     net);
> 
> vhost_transport_get_local_cid() returns VHOST_VSOCK_DEFAULT_HOST_CID, so the
> namespace is told its local CID is 2. __vsock_find_cid(net, 2) is also true
> through the transport_h2g && cid == VMADDR_CID_HOST check, so bind() to
> CID 2 succeeds.
> 
> A connect() to CID 2 then enters the transport_g2h branch above, because the
> pointer is non-NULL. It returns false because cid is VMADDR_CID_ANY, so the
> remote_cid == VMADDR_CID_HOST loopback fallback in the else branch is never
> reached.
> 
> vsock_assign_transport() then picks transport_g2h for
> remote_cid <= VMADDR_CID_HOST and fails at the new check:
> 
> 	if (vsock_g2h_unreachable(new_transport, sock_net(sk))) {
> 		ret = -ENETUNREACH;
> 
> Should an unreachable G2H transport be treated the same as an absent one
> here, so that connecting to the namespace's own reported CID uses loopback?
> The later virtio patch in the series makes this path reachable and does not
> change this logic.
> 
> [ ... ]
> 
> > @@ -742,8 +823,267 @@ bool vsock_find_cid(unsigned int cid)
> 
> [ ... ]
> 
> > +/* Close every connected socket of @t that can no longer reach the g2h device.
> > + */
> > +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
> > +{
> > +	struct vsock_sock *vsk, *tmp;
> > +	struct sock *sk;
> > +	int i;
> > +
> > +	lockdep_assert_held(&vsock_register_mutex);
> > +
> > +	spin_lock_bh(&vsock_table_lock);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++) {
> > +		list_for_each_entry_safe(vsk, tmp, &vsock_connected_table[i],
> > +					 connected_table) {
> > +			sk = sk_vsock(vsk);
> > +
> > +			if (vsk->transport != t ||
> > +			    sk->sk_state == TCP_CLOSE ||
> > +			    vsock_g2h_reachable_sk(vsk))
> > +				continue;
> > +
> > +			/* If close has already been scheduled for this socket,
> > +			 * we can skip.
> > +			 */
> > +			if (vsk->close_work_scheduled)
> > +				continue;
> > +
> > +			sk->sk_state = TCP_CLOSE;
> > +			sk->sk_err = ECONNRESET;
> > +			sk_error_report(sk);
> > +
> > +			__vsock_remove_connected(vsk);
> 
> [Severity: Medium]
> Can these writes race with the socket's own state machine?
> 
> Only vsock_register_mutex and vsock_table_lock are held here, and neither
> one excludes lock_sock() holders. close_work_scheduled is read the same way.
> 
> The existing lockless resets, virtio_vsock_reset_sock() and
> vhost_vsock_reset_orphans(), only run when the device is going away. Here
> the device keeps running, so its RX path can work on the same socket at the
> same time.
> 
> With the later virtio patch, virtio_transport_rx_work() checks
> vsock_g2h_net_eq(net) for each packet but does not synchronize with the
> swap. That patch's commit message also notes that an assign can land while
> rx_work is draining a batch:
> 
> CPU1 (assign)                      CPU2 (rx_work)
>                                    vsock_g2h_net_eq(net) returns true
> vsock_g2h_net_swap()
>                                    virtio_transport_recv_pkt()
>                                      lock_sock(sk)
>                                      sk_state is TCP_ESTABLISHED
> vsock_g2h_reset_unreachable()
>   sk->sk_state = TCP_CLOSE
>   sk->sk_err = ECONNRESET
>   __vsock_remove_connected(vsk)
>                                      virtio_transport_recv_connected()
>                                        virtio_transport_do_close()
>                                          sk->sk_state = TCP_CLOSING
> 
> If an incoming SHUTDOWN or RST arrives at that point, doesn't the socket end
> up in TCP_CLOSING with ECONNRESET set and outside the connected table?
> 
> There is a similar window on the send side. vsock_connectible_sendmsg() may
> already have passed its sk_err check and could enqueue one more chunk
> through the device after the sweep. KCSAN would also likely report these
> unannotated stores against the locked writers.
> 
> Refcounting looks balanced, because vsock_remove_connected() re-checks table
> membership. So the effect appears to be limited to inconsistent socket
> state.
> 
> [ ... ]
> 
> > +static int vsock_g2h_net_assign(struct net *net, struct sk_buff *msg,
> > +				struct genl_info *info)
> > +{
> 
> [ ... ]
> 
> > +	ret = -EMSGSIZE;
> > +	hdr = genlmsg_iput(msg, info);
> > +	if (!hdr)
> > +		goto unlock;
> > +	genlmsg_end(msg, hdr);
> > +
> > +	ret = genlmsg_reply(msg, info);
> > +	msg = NULL;
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	old = vsock_g2h_net_swap(net, &old_tracker);
> > +
> > +	/* See vsock_maybe_set_connected() comment about synchronizing with
> > +	 * connecting sockets.
> > +	 */
> > +	vsock_g2h_reset_unreachable(transport_g2h);
> 
> [Severity: Low]
> Is this ordering intended? The success reply goes out before
> vsock_g2h_net_swap() and vsock_g2h_reset_unreachable() run.
> 
> This means userspace can see VSOCK_CMD_DEV_NETNS_SET succeed while
> vsock_g2h_net still points at the old namespace and the established sockets
> there are still open. Those sockets' send and receive paths take lock_sock(),
> not vsock_register_mutex, so the mutex does not hold them off.
> 
> The move also depends on the reply being delivered. genlmsg_reply() does a
> MSG_DONTWAIT unicast, so if the requester's receive buffer is full it
> returns -EAGAIN and the swap is skipped. Neither the commit message nor the
> docs mention this failure mode.
> 
> Could the swap and the sweep run first, with the reply sent after them?
> 
> -- 
> Sashiko AI review � https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-vsock-guest-ns-v3-0-b32447c66b23%40meta.com
