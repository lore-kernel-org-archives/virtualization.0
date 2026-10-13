Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F6A519922;
	Tue, 13 Oct 2026 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931928; cv=none; b=UMfadM5iQoSWVAI2cxW2rPQ+EsSjHPqsfsiB5vUzC7SJtPBkFP09VD3zB0M+HnRHJfRgzxtX2NA6B+3TjcAZUuxv05fYz67B49U0mCsMfq4hDkOVGT3aWoE6QyQ8LNRF4wwhpasKxKLcKKTd90ZxOaRs2I8cepXO0UyFz4a5iTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931928; c=relaxed/simple;
	bh=zvmrfl0wIlPrQzTG6BzYpoFiY1TWBC1KaLC3+hI5dpM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QvvtHIOfl+lNLsN60t2KX8tFOonOebPKDs0aTsAyWuSnvi0/g3fNyBEGh9jllCMRNnd+oFb3LA7Yt1bLzro7DCcN7FJJhg2MJFi4iBz0pNR5iDGlrmBpkxKogyC6oEvoHdg7rgdMAhsyptqjXR7VdVWh4Di+yq+9L1y++TEWW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXyNhdS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXyNhdS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D041F00893;
	Tue, 13 Oct 2026 22:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931919;
	bh=SxFpD0jFUukbA8RESTUQDKcCYWdjCShdI2BwwoNvpEs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NXyNhdS/xbrhc0XdQeQZtaipaPCTHAD2MfiNpLo8oVOgmfUxBEojHsWPuG7NO5ai5
	 SRiT9jgR14kBOFTw0I2anDlpK41EiqiULO1Wpx0SBOU+pDNr64J7KiviqD9d06MmwP
	 OGJHEBx6Mkv4Y4sK/P66823jS11ZgVWtslmUFM7NwKcHnz0ytGjbmqu2li8fOmtTj7
	 PFrxVa1nrg/5iIYtrJ2JdtrBl7cfVEDmS0Uolg0JffPlc17ROtx4GvzrTeqHueMsBa
	 tFjf0zscZ2ZivXD2FQiT8jviM2WJYKAThqW4miAtAGKO2gxr6+J2DBS5ppnA9DkuRV
	 HGZEyrfrLTxlg==
Subject: Re: [PATCH net-next v3 5/7] vsock/virtio: support guest device
 network namespace
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
Date: Tue, 13 Oct 2026 22:51:57 +0000
Message-ID: <179193191764.434549.1279241501217519580@kernel.org>
In-Reply-To: <20261012-vsock-guest-ns-v3-5-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-5-b32447c66b23@meta.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A socket closed by device reassignment can still send packets
  through the device it supposedly lost access to.
- [Low] The implementation-notes comment at the top of
  net/vmw_vsock/af_vsock.c still gives virtio-vsock as the example of a…
- [Low] The dev-netns-set uAPI doc in
  Documentation/netlink/specs/vsock.yaml (added by the earlier commit…

Pre-existing issues:
- [High] This problem was not introduced by this patch, but the patch's
  new isolation can be bypassed through vsock packet capture.

--

vsock/virtio: support guest device network namespace

This commit makes the virtio-vsock guest device assignable to a network
namespace. It re-reads the assigned netns for each packet in
virtio_transport_rx_work(). It also uses vsock_maybe_set_connected() so
that new connections are added to the connected table atomically with
respect to namespace assignment.

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index eced6929405df..4123924536dd6 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -542,7 +542,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
>  
>  bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
>  {
> -	return vsock_net_mode_global(vsk);
> +	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
>  }

[Severity: Medium]
virtio_transport_stream_allow() gates new connections. Now that the
device can be assigned, can a socket closed by
vsock_g2h_reset_unreachable() still put packets on the device?

The sweep only changes sk_state and sk_err, then removes the socket from
the connected table:

net/vmw_vsock/af_vsock.c:vsock_g2h_reset_unreachable() {
    ...
			sk->sk_state = TCP_CLOSE;
			sk->sk_err = ECONNRESET;
			sk_error_report(sk);

			__vsock_remove_connected(vsk);
    ...
}

It does not touch vsk->transport or sock->state, which stays
SS_CONNECTED. vsock_shutdown() only rejects SS_UNCONNECTED:

net/vmw_vsock/af_vsock.c:vsock_shutdown() {
    ...
	if (sock->state == SS_UNCONNECTED) {
		err = -ENOTCONN;
		if (sock_type_connectible(sk->sk_type))
			goto out;
	} else {
		sock->state = SS_DISCONNECTING;
    ...
			vsock_send_shutdown(sk, mode);
    ...
}

So calling shutdown() on the old fd goes through:

vsock_send_shutdown()
  virtio_transport_shutdown()
    virtio_transport_send_pkt_info()
      virtio_transport_send_pkt()

virtio_transport_send_pkt() never uses its net argument before it queues
the packet on the device. sock->state never goes back to SS_UNCONNECTED,
so this can be repeated.

The wire header carries only CIDs and ports. Suppose the newly assigned
local namespace reuses the same guest/host port tuple. Could these
SHUTDOWN packets then tear down a host connection that now belongs to
the new owner?

Even without a tuple collision, the namespace that lost the device can
still send traffic on it. That seems to contradict the documented rule
"assigned to a local mode namespace - only that namespace may use it".

[ ... ]

> @@ -587,6 +587,7 @@ static struct virtio_transport virtio_transport = {
>  		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>  
>  		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
> +		.netns_assign_allow       = true,

[Severity: Low]
This isn't a bug, but the implementation notes at the top of
net/vmw_vsock/af_vsock.c still use virtio-vsock as the example of a
transport without local mode support:

 *       a different transport that *does* support local mode. For
 *       example, virtio-vsock may not support local mode, but the socket
 *       may still accept a connection from vhost-vsock which does.

This patch sets netns_assign_allow, and virtio_transport_rx_work() now
delivers into the assigned namespace. So virtio-vsock can serve a local
mode namespace once the device is assigned.

Should this example be updated? It also seems to conflict with the
sysctl doc, which says "Of the in-tree guest transports, only
virtio-vsock implements it."

[Severity: Low]
This is the first transport to set netns_assign_allow, so the
dev-netns-set behaviour becomes reachable with this patch. The uAPI doc
in Documentation/netlink/specs/vsock.yaml, added earlier in this series,
says:

        Movement to an unreachable local namespace results in sockets being
        closed with ECONNRESET. Peers are not guaranteed to be notified via
        an RST.

However, vsock_g2h_reset_unreachable() closes every socket that fails
vsock_g2h_reachable_sk() after any move:

			if (vsk->transport != t ||
			    sk->sk_state == TCP_CLOSE ||
			    vsock_g2h_reachable_sk(vsk))
				continue;

That includes moving the device out of a local namespace L and back to
init_net or another global namespace. vsock_net_check_mode(L, init_net)
is false, so every connected socket in L is closed with ECONNRESET.

Should the yaml text also cover moves out of a local namespace? The
sysctl doc already does ("from a namespace that can no longer reach the
device").

[ ... ]

> @@ -682,10 +688,15 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  
>  			virtio_transport_deliver_tap_pkt(skb);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Can
the vsock tap path bypass the isolation that this patch adds?

virtio_transport_deliver_tap_pkt() runs for every received packet,
before any namespace is applied. vsock_deliver_tap() then clones the
packet, payload included, to every entry on the global vsock_tap_all
list:

net/vmw_vsock/af_vsock_tap.c:__vsock_deliver_tap() {
    ...
	list_for_each_entry_rcu(tmp, &vsock_tap_all, list) {
		ret = __vsock_deliver_tap_skb(skb, tmp->dev);
    ...
}

vsock_add_tap(), called from vsockmon_open(), only checks the device
type:

	if (unlikely(vt->dev->type != ARPHRD_VSOCKMON))
		return -EINVAL;

Nothing on the tap path filters with net_eq() or vsock_net_check_mode().
vsockmon has no netns restriction either. So CAP_NET_ADMIN over any
netns, including one owned by a user namespace, is enough to create a
vsockmon device, bring it up and capture on it with AF_PACKET.

Once the guest device is assigned to a local mode namespace, can any
other namespace still read all guest<->host vsock traffic this way?

The TX side in virtio_transport_send_pkt_work() appears to have the same
exposure, and vhost-vsock local mode already had it. By contrast, nlmon
taps are kept per netns.

>  
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

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-vsock-guest-ns-v3-0-b32447c66b23%40meta.com
