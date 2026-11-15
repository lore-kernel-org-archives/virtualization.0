Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715294;
	b=Eo2p9VyvOrCmZsuh+0UGbUzy1trKB0+t6sZXheFyv8J4g1kA5o0UZK8qzX4isDssALNq
	 Q2R1g9+mArHDzIqxGMEhFS8xR5UmMqOjw0qbhvL7t5P3/NsCRQjvtwApjpzoyyQEJxZcQ
	 svk97LJ8aegg75z8/avHKorSga81Vw2oQ006j5FsPVUTXOBJcvf9dmqvi41bTVvyD81Ew
	 Sit49bBI5jfdofedXFvPOdGJ+wkfxW8yweUqTvEzkJd0yhpKRQCbFvvmj0VlD9IJO2BeL
	 DneqBYGBbGw3J3v5/4naiK9mFlV7oOi7l5UI8qcIlpFeRRcBNsNduh2FWAMDx+dlOOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715294;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dDBB/PrCsbnJoiZ9fWeG5CxBhHurG8CpOfxKo0LPRF4=;
	b=MhDHL8GhUPlmA9uj11s93ub4uvdFRlJFQynsZ9D1tsCgLAe2IptYgu3GaboIlI2boAkc
	 a5q1Uu9Nqi3EFqt1372Wg22/RSRLKQon0/4UUj7cdQjqbLah3RdaXdvo8J772cKFkiZGF
	 G5l/reetNC1l0zUn/8URMT15ma8PoFTA1K4ksIlcgDnGAwrAGYtQ5CqN4AFYCDLj5UeYx
	 zhNPaQ4rudK5Rzvua3coCwpucvduWhRjzaOiGQdHv4B9jBviLpMBd+Di2fZoXen7qJEVd
	 1NLWnxEC5RqtVum3ELIoDgNtWsWjR/jxjnb2yLCPNtlVg7fyoB+aH0o0fds+yg7MIZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WIAs3/T+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19371606A8B9;
	Sun, 15 Nov 2026 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIAs3/T+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153A91F000CA;
	Sun, 15 Nov 2026 04:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715293;
	bh=dDBB/PrCsbnJoiZ9fWeG5CxBhHurG8CpOfxKo0LPRF4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WIAs3/T+W86ySrwAhEF3fnokmIOqXfgv7KUTQBkG1XTvoBF8BfKvIj2MnXaLoIMHd
	 U8Fq2oS8fJXG/kg2jUdlBRJ7nbeuQpfGlsBQCMW7ll/KTMfLwEo6mpcyOJEFIF6KUn
	 w00o6wcRi2Tt4hhWBD2Z9z+obxwyVMRNj/i8YSpbXsRbcKRYKj5JkStQT1c1SWzOm5
	 o8txtsywp4LOSGBcXG41dkutFkftHG/bQDpqAw63sY3WpQHbf8ZAo3yiBWhNsrVgZ4
	 8s4OyG3ZpTpICuK933FUcXEUr0UqlMx7zq2KeaS/55lpmOV9To1bxBAXy4Sw9CrOMC
	 r0ZswlAxRReKA==
Subject: Re: [PATCH net-next v6 6/8] vsock/virtio: support guest device
 network namespace
From: netdev-bot+sashiko@kernel.org
To: bobbyeshleman@meta.com
Cc: sgarzare@redhat.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com,
 edumazet@kernel.org, georgezhang@vmware.com, acking@vmware.com,
 dtor@vmware.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
 bobbyeshleman@gmail.com
Date: Sun, 15 Nov 2026 04:01:31 +0000
Message-ID: <179471529160.2199510.6782021249952655251@kernel.org>
In-Reply-To: <20261113-vsock-guest-ns-v6-6-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-6-3737ce4673c0@meta.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] vsock/virtio: swept sockets still send packets in
  virtio_transport_send_pkt_info()
- [Low] The namespace-mode header comment in net/vmw_vsock/af_vsock.c
  still uses virtio-vsock as its example of a transport without local-…
- [Low] In tools/testing/selftests/vsock/vmtest.sh, the comment that
  justifies `--skip=29` in the local-namespace host_vsock_test still…
- [Low] The dev-netns-set uAPI doc in
  Documentation/netlink/specs/vsock.yaml (added by the previous patch,…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but this patch
  extends it to the guest device.

--

vsock/virtio: support guest device network namespace

This patch sets .netns_assign_allow on the virtio-vsock guest device, so
the device can be assigned to a network namespace. Stream and seqpacket
sockets from any netns that can reach the device are now allowed. The rx
worker re-reads the assigned netns for each packet, the handshake paths
use vsock_maybe_set_connected(), and virtio_transport_send_pkt_info()
refuses to send for sockets that can no longer reach the device.

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

[Severity: Low]
This isn't a bug, but the namespace mode comment at the top of
net/vmw_vsock/af_vsock.c still uses virtio-vsock as its example of a
transport without local mode support:

 *       example, virtio-vsock may not support local mode, but the socket
 *       may still accept a connection from vhost-vsock which does.

This change, together with .netns_assign_allow below, makes
virtio_transport_stream_allow() and virtio_transport_seqpacket_allow()
return true for a local mode namespace once the device is assigned to it.
So the comment no longer matches the code. It also contradicts the text a
few lines further down in the same comment, which describes assigning the
device to a local namespace.

Documentation/admin-guide/sysctl/net.rst already matches the code ("only
virtio-vsock implements it").

Could the example name a transport that really is global-only, such as
hyperv or vmci?

[Severity: Low]
tools/testing/selftests/vsock/vmtest.sh has a similar stale explanation
for the --skip=29 in the local namespace host_vsock_test:

# binding both G2H and H2G CIDs. Because virtio-vsock (G2H) doesn't
# support local namespaces the test will fail when
# transport_g2h->stream_allow() returns false.

After this patch, virtio_transport_stream_allow() returns false there
only because the device is still assigned to init_net. A missing
transport feature is no longer the reason.

The skip still works in the current setup. If that setup ever assigns
the device, though, could the skip hide a real failure? Should the
comment be updated?

A later patch in the series, "selftests/vsock: test the guest vsock
device network namespace", adds the ns_guest_assign_g2h_netns_* tests,
so the assign path does get test coverage. Only the comment is still
stale at the end of the series.

> @@ -587,6 +587,7 @@ static struct virtio_transport virtio_transport = {
>  		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>  
>  		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
> +		.netns_assign_allow       = true,
>  
>  		.notify_poll_in           = virtio_transport_notify_poll_in,
>  		.notify_poll_out          = virtio_transport_notify_poll_out,

[Severity: Low]
With virtio-vsock now assignable, userspace can hit the dev-netns-set
reset path for the first time. The uAPI doc in
Documentation/netlink/specs/vsock.yaml was added by the previous patch,
"vsock: add a netlink command to assign the g2h device to a netns". It
describes only one reset case:

  Movement to an unreachable local namespace results in sockets being
  closed with ECONNRESET. Peers are not guaranteed to be notified via
  an RST.

The sweep in vsock_g2h_reset_unreachable() covers more than that.
vsock_g2h_should_reset() selects every connected socket for which
vsock_g2h_reachable_sk() is false. That ends up in
vsock_net_check_mode(), which is true only for the same netns or for two
global mode namespaces:

include/net/af_vsock.h:vsock_net_check_mode() {
    ...
	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;
}

So assigning the device back from local namespace B to init_net also
closes every connection in B with ECONNRESET.

Should the yaml text also cover moves out of a local namespace? The
af_vsock.c header and net.rst already state the general rule ("from a
namespace that can no longer reach the device").

[ ... ]

> @@ -682,10 +688,15 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  
>  			virtio_transport_deliver_tap_pkt(skb);
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

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
this patch extends it to the guest device. Should tap delivery here
respect the assigned namespace?

virtio_transport_deliver_tap_pkt() runs for every received packet before
the netns is chosen. It ends up in __vsock_deliver_tap(), which walks the
single global vsock_tap_all list with no netns check:

net/vmw_vsock/af_vsock_tap.c:__vsock_deliver_tap() {
    ...
	list_for_each_entry_rcu(tmp, &vsock_tap_all, list) {
		ret = __vsock_deliver_tap_skb(skb, tmp->dev);
    ...
}

vsockmon has no newlink restriction, and vsockmon_open() adds the device
to that global list through vsock_add_tap(). So someone with CAP_NET_ADMIN
over any netns could create a vsockmon device and open an AF_PACKET
socket on it. That includes an unprivileged user inside their own
user+net namespace. They would then capture payloads belonging to the
namespace the device was assigned to:

virtio_transport_rx_work()
  virtio_transport_deliver_tap_pkt()
    vsock_deliver_tap()
      __vsock_deliver_tap()
        skb_clone() + dev_queue_xmit() to every registered tap

The af_vsock.c header describes the purpose of assignment as "only that
namespace may use it. This is how a nested VM is isolated from the rest
of the guest."

vhost and loopback local mode namespaces already leak through the same
list. nlmon taps were made per-netns for the same reason.

Could vsock taps be made per-netns, or at least filtered by the assigned
netns, before the guest device becomes assignable?

[ ... ]

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -317,6 +320,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (unlikely(!t_ops))
>  		return -EFAULT;
>  
> +	if (!vsock_g2h_reachable_sk(vsk))
> +		return -ENETUNREACH;
> +
>  	src_cid = t_ops->transport.get_local_cid();
>  	src_port = vsk->local_addr.svm_port;
>  	if (!info->remote_cid) {

[Severity: Medium]
The commit message says this check stops a socket closed by an assign
from sending. But vsock_g2h_reachable_sk() only looks at where the
device is assigned right now. It does not know whether this socket was
already swept. Can a swept socket start sending again once the device
is moved back?

When VSOCK_CMD_DEV_NETNS_SET moves the device to a namespace vsk cannot
reach, vsock_g2h_reset_unreachable() removes the socket from
vsock_connected_table and leaves it in this state:

net/vmw_vsock/af_vsock.c:vsock_g2h_reset_unreachable() {
    ...
		if (reset) {
			sock_set_flag(sk, SOCK_DONE);
			WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
			sk->sk_state = TCP_CLOSING;
			sk->sk_err = ECONNRESET;
			sk_error_report(sk);
		}
    ...
}

Suppose the device is then assigned back to a namespace that vsk can
reach, for example back to init_net to undo the first assign. From then
on vsock_g2h_reachable_sk() returns true for the swept socket again.
When the process finally closes the fd, virtio_transport_close() sees
TCP_CLOSING and a full peer_shutdown before it checks SOCK_DONE:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_close() {
    ...
	/* Already received SHUTDOWN from peer, reply with RST */
	if ((vsk->peer_shutdown & SHUTDOWN_MASK) == SHUTDOWN_MASK) {
		(void)virtio_transport_reset(vsk, NULL);
		return true;
	}
    ...
}

virtio_transport_reset() goes through virtio_transport_send_pkt_info(),
passes this check, and sends an OP_RST to the host with the old
4-tuple. shutdown() and setsockopt(SO_RCVLOWAT) can send OP_SHUTDOWN or
OP_CREDIT_UPDATE on the same path.

The swept socket is no longer in the connected table, so a new
connection may already be using the same 4-tuple. The stale RST would
then reset that new connection on the host side.

The two assigns need CAP_NET_ADMIN. After that, the sequence is
deterministic: sweep, assign back, then close() or shutdown() on the
swept fd.

Should the sweep leave a marker on the socket that this path checks, so
the decision does not depend on the current assignment? I am not sure a
plain SOCK_DONE check here is right, since the normal peer SHUTDOWN
path sends its RST around the time SOCK_DONE gets set. What do you
think?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-vsock-guest-ns-v6-0-3737ce4673c0%40meta.com
