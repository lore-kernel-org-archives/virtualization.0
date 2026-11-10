Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307267;
	b=pAZEwsGwaVxfaxOEUP8QV3Hj1d7y25fOmr/tVOuewHc3ATAAjEQbYQChbvx6PJiv7LfK
	 7p1xxiIyRKJI6oT+eOU9q5E8sgFr/s2CsW++tY8uvfmQVLxxR6zXgRgMXpzMx0Qyc7U46
	 Ql7PoLHe0r2OIeGJAqvhnu3NaKFAl9yGc3pD2OgDNwR6ftNdLhyND4Iby9FAuMM4H4ggQ
	 bKfeOzdrNxNPihF0cYq4ZNDYECJAe/lLKvBJpcSCCC+1rsxmJu4/klaIe6HLvi+MN1iRd
	 2smndlQSN336dxiUZT12tjjvaclsr6ozDtzjy1wtwE/q4TkGsKVGTGJdxdoUY8jKwuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307267;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=9RvJebEHN0ToJdhmNwuM3zN40XxviuMMEwwuGiw6/Qg=;
	b=ESNM9crmHs8GLuhY+hkzmsza4M74+NGSYwDrQu+EqOrO9Qy8hoq8kNRvUoZWTPlzGBf4
	 cHmU61DvS03aalYyeh25X1jiJqMCA3WRGV/WZRBx1jjr5YdKPtPbjoQeyHfBMI73zq+fP
	 yud4Qx0pZpMYp3PErTjNxQUnJHg3YAKb2Lp09t3ieuUBKIq1OaVAyzxAA4H23xZ6yE/oh
	 77GMBeynnpH53JfhNOTiw4BEoHoJnJki9KoERQ0Tk7yJRDvCTVculfmI9eXGD9VPuiFgi
	 hBY7cA41y0wJTQ9W+W4hCkVkjJpn86CpejslI9lHwRfHO4TxMEcYvpvvNRaSiIWKPfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="P03nS/Ld";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D7C60A2600
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 10:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2D7C60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P03nS/Ld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794307266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RvJebEHN0ToJdhmNwuM3zN40XxviuMMEwwuGiw6/Qg=;
	b=P03nS/Ldtp+4AFEbkhSkxUlbKTzCwozXPvCJZZ3CaNT6YmxKIhFY3KEDs6nk5EuDF/zNPD
	Lnb2ljqSEimaZgekknytZa8FY/+M7lLL51LyGeTajt7mm66mwoCc7OZMxQf5vwnsWLc+eG
	xrvBf/9/xqUmerBPYYAU9FmfjDHPWwI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-TOY0otYhNVWo4ajIt8-xfA-1; Tue,
 10 Nov 2026 05:41:01 -0500
X-MC-Unique: TOY0otYhNVWo4ajIt8-xfA-1
X-Mimecast-MFC-AGG-ID: TOY0otYhNVWo4ajIt8-xfA_1794307259
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B032D18004F9;
	Tue, 10 Nov 2026 10:40:58 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA62626C;
	Tue, 10 Nov 2026 10:40:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: bobbyeshleman@meta.com
Cc: sgarzare@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	stefanha@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	shuah@kernel.org,
	rdunlap@infradead.org,
	donald.hunter@gmail.com,
	edumazet@kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sargun@sargun.me,
	jlinbox@meta.com,
	bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v5 5/7] vsock/virtio: support guest device network namespace
Date: Tue, 10 Nov 2026 11:40:35 +0100
Message-ID: <20261110104035.225429-1-pabeni@redhat.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-5-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-5-48179b9b66b8@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: qNNoUIdn29xpMNQyQIbg6verpbDWS1PHDbs2Pn5GSqY_1794307259
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [5]: [PATCH net-next v5 5/7] vsock/virtio: support guest device network namespace ---
I found three issues in this patch: one functional regression, one commit message problem, and one existing tap leak that the patch now reaches.

commit 074136a5d2f57598d227b743b7c490274cb32bed
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock/virtio: support guest device network namespace

This patch makes the virtio-vsock guest device assignable to a network
namespace. virtio_transport_rx_work() now re-reads the assigned netns for
each packet and passes it to virtio_transport_recv_pkt(). The listen and
connecting receive paths now call vsock_maybe_set_connected() instead of
vsock_insert_connected(), and virtio_transport_send_pkt() gains a
reachability check.

> Make the virtio-vsock device assignable to a namespace and initialize it
> to init_net. Because virtio-vsock and init_net are both hardcoded to
> global mode, nothing changes until the assign command is issued.

[ ... ]

> it wins the race to the table and does NOT pass the reachability tests,
> then it will be reset. This is the purpose of the new helper
> 'vsock_maybe_set_connected()'.

[Severity: Low]
[Finding: main-1-1]
[Sources: opus-5-5]
This isn't a bug, but does this description match what this patch does?

The previous commit in the series ("vsock: add a netlink command to
assign the g2h device to a netns") already defines and exports
vsock_maybe_set_connected(). The same commit adds netns_assign_allow to
struct vsock_transport and initializes the g2h netns to init_net:

net/vmw_vsock/af_vsock.c:
    static struct net __rcu *vsock_g2h_net = RCU_INITIALIZER(&init_net);

This patch only calls the helper and sets .netns_assign_allow = true.

The reachability check added to virtio_transport_send_pkt() is only
described in the v4 changelog below the --- line, so it won't reach git
history. Could the commit message say that virtio_transport_send_pkt()
now drops packets from a netns that cannot reach the device and returns
-ENETUNREACH? That includes credit updates, shutdown packets and RST
replies.

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index eced6929405df..06df82b130cff 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -256,6 +256,15 @@ virtio_transport_send_pkt(struct sk_buff *skb, struct net *net)
>  		goto out_rcu;
>  	}
>  
> +	/* A socket reset by an assign can still send credit updates from
> +	 * recvmsg() and setsockopt(SO_RCVLOWAT).
> +	 */
> +	if (!vsock_g2h_net_reachable(net)) {
> +		kfree_skb(skb);
> +		len = -ENETUNREACH;
> +		goto out_rcu;
> +	}
> +

[ ... ]

> @@ -682,10 +697,15 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  
>  			virtio_transport_deliver_tap_pkt(skb);
>  

[Severity: High]
[Finding: main-6-6]
[Sources: opus-5-5]
This isn't a bug introduced by this patch, but this patch extends it to
the guest device, which can now be isolated. Can tap delivery leak the
assigned namespace's traffic to vsockmon devices in other namespaces?

virtio_transport_deliver_tap_pkt() runs before the netns-aware
virtio_transport_recv_pkt(). The call chain
vsock_deliver_tap()->__vsock_deliver_tap() then walks the global
vsock_tap_all list without any netns filter:

net/vmw_vsock/af_vsock_tap.c:__vsock_deliver_tap() {
    ...
	list_for_each_entry_rcu(tmp, &vsock_tap_all, list) {
		ret = __vsock_deliver_tap_skb(skb, tmp->dev);
    ...
}

This loop never compares dev_net(tmp->dev) with the packet's namespace.
vsockmon_link_ops has no netns restriction. RTM_NEWLINK only needs
CAP_NET_ADMIN in the user namespace that owns the netns.

So an unprivileged user can run unshare -Urn and create a vsockmon link.
The module autoloads through MODULE_ALIAS_RTNL_LINK("vsockmon"). The user
can then capture on that link with AF_PACKET.

Wouldn't that let any namespace see the traffic of the local-mode
namespace the guest device was assigned to? The tap paths in vhost-vsock
and vsock_loopback have the same problem.

> -			/* Force virtio-transport into global mode since it
> -			 * does not yet support local-mode namespacing.
> +			/* Only grab a reference if the net changes underneath
> +			 * us.
>  			 */
> -			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> +			if (unlikely(!vsock_g2h_net_eq(net))) {
> +				put_net_track(net, &ns_tracker);
> +				net = vsock_g2h_net_get(&ns_tracker);
> +			}
> +
> +			virtio_transport_recv_pkt(t, skb, net);
>  		}
>  	} while (!virtqueue_enable_cb(vq));

[ ... ]

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 1e762a480df49..7efcbdc7e04fc 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -1478,9 +1478,14 @@ virtio_transport_recv_connecting(struct sock *sk,
>  
>  	switch (le16_to_cpu(hdr->op)) {
>  	case VIRTIO_VSOCK_OP_RESPONSE:
> -		sk->sk_state = TCP_ESTABLISHED;
> +		if (!vsock_maybe_set_connected(vsk)) {
> +			virtio_transport_reset_no_sock(t, skb, net);

[Severity: High]
[Finding: main-1-0]
[Sources: opus-5-5]
Can this RST ever reach the host?

virtio_transport_reset_no_sock() ends in t->send_pkt(reply, net). The
check this patch adds to virtio_transport_send_pkt() frees the reply when
net cannot reach the device:

	if (!vsock_g2h_net_reachable(net)) {
		kfree_skb(skb);
		len = -ENETUNREACH;
		goto out_rcu;
	}

The v5 changelog says the arrival netns is passed here instead of
sock_net(sk) so that the RST is not dropped. But vsock_net_check_mode()
looks like an equivalence relation:

	if (net_eq(ns0, ns1))
		return true;
	...
	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;

A netns's mode is also fixed when the netns is created: vsock_net_init()
sets it, and later writes to the ns_mode sysctl return -EPERM.

virtio_transport_recv_pkt() finds the socket through
__vsock_find_{connected,bound}_socket_net(), which requires
vsock_net_check_mode(sock_net(sk), net). vsock_maybe_set_connected() only
fails when sock_net(sk) cannot reach the newly assigned g2h netns.

So the arrival netns cannot reach it either, and
vsock_g2h_net_reachable(net) is false whenever this branch runs.

An assign can land after the per-packet snapshot in
virtio_transport_rx_work() and before the check in
vsock_maybe_set_connected(). That is the race the commit message
describes.

In this OP_RESPONSE case the host already holds an ESTABLISHED socket. If
the RST is dropped, won't that connection stay half-open until the host
sends something? A host that only reads would wait forever.

The commit message says such a socket "will be reset", but only the
local socket is closed.

The same applies to the new failure path in
virtio_transport_recv_listen():

	if (!vsock_maybe_set_connected(vchild)) {
		release_sock(child);
		virtio_transport_reset_no_sock(t, skb, net);
		sock_put(child);
		return -ENETUNREACH;
	}

Here the host's connect() gets neither a RESPONSE nor an RST. It waits for
its connect timeout instead of failing with ECONNRESET.

By the same reasoning, the other virtio_transport_reset_no_sock() calls in
virtio_transport_recv_listen() that v5 moved from sock_net(sk) to net
behave the same either way.

Would getting the RST out need a different approach? For example, it
could be sent on the newly assigned g2h netns, or replies could be exempt
from the check in virtio_transport_send_pkt().

> +			skerr = ECONNRESET;
> +			err = -ENETUNREACH;
> +			goto close;
> +		}
> +
>  		sk->sk_socket->state = SS_CONNECTED;
> -		vsock_insert_connected(vsk);
>  		sk->sk_state_change(sk);
>  		break;

[ ... ]
-- 
This is an AI-generated review.

