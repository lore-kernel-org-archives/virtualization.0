Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837314;
	b=co+gMZhKDhffoAlkRD88RjN+97/tOMXzzOaIXPKgp1Ams+fbcGZmCdGNWjrXcj7NsxtE
	 yys19QECXoQujGr2YerxLz6MDJUCOFNwbPA9eLolVrxPyNBsEhuK7ACfMrNjw7Rr0yiUT
	 jkh3n5unPlQMTO+pZau5sB8YKh3GWmYCL66LbX2dRubgXPMVxTbsu8czoAkJ/Ay8O+lV+
	 EVKtbahvGuDNC72DwPZ8G4u1cpJc9vOlGWQFHOnoJLrHb8k7llTIDHNWmXIV9uW5qkI2F
	 zvEGcWVgN1ALtPYG/foAn6h2Bjnz/OoQqOvF0slpplmSbWzE+fvdS3PNmG2OCfNlWFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837314;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JnDYP4q711g99WMuz663GPClfp62Sgpn5lVs7PGSx4U=;
	b=ryHTDMJHlRGdhid7CuanKMXl09cpAtJtKlknVhuJkrqUYaIFX25Hsa+SjgU6PXR0D+pe
	 9s4p4XnROS6bfGrFPeWHdwVqpCNpp7/2X0oIXIcAxRM29ueuU84InJ3bRTbOcBlpKEqoa
	 GA8627uMzGnnmjh77NCyd23XxRh98TXjjEvFA+7fewm7lR9ac+ns4ujCAlDBdM45Mqe/K
	 TZQnsdiUV6i1tb12kxjLhLWonL8y4/xldyR/ayUvQ4It7171wsGuZOG2xFK9qJBgACr4n
	 ry8d/VOUM8MlTqacsl42+CmXI2onF3bTmMf/GYd8HC5kJapx+qbNVdvnBZPTysosKyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuGeGt8j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063E606B747;
	Mon, 16 Nov 2026 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuGeGt8j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA9E1F000C4;
	Mon, 16 Nov 2026 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837313;
	bh=JnDYP4q711g99WMuz663GPClfp62Sgpn5lVs7PGSx4U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TuGeGt8jrur+vBdg0M3y6lOmi73bhAFmugfmmjuLpp8zULGhBxF9lLBuEGWlr8IEj
	 43AoHC9QDYmgkz9DMtfkmQjDDZ9szhGH2FRLd1mIh9D8ZM4qGZT2cXF2sJ0m2oRsEG
	 XRJeqJGaf3gGIbn2IzPjqRhfvCCvpGcZxP7A6gWJXWyjX0eaeLmRxdoHqw4Ua2+5pr
	 oIuxWNlAgl3PnyEXLiN8uJp/pmpAbse4X7LJtyr6rbmrY6DyxBvsykeWt/qouwLEbc
	 wWlzUhR+qQFgIcXvtOB6NGv2auB1zPRw3V6YTl/oeXSL6D6H9ysq0S77PIhrRaWdvF
	 q2XLf4M3Xnwew==
Subject: Re: [PATCH net-next v5 9/9] tun: add rx timestamp to the vnet header
From: netdev-bot+sashiko@kernel.org
To: s.trumtrar@pengutronix.de
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, eperezma@redhat.com,
 jasowangio@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, edumazet@kernel.org,
 andrew@lunn.ch, horms@kernel.org, kory.maincent@bootlin.com,
 liangchen.linux@gmail.com, hengqi@linux.alibaba.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org,
 kernel@pengutronix.de
Date: Mon, 16 Nov 2026 13:55:11 +0000
Message-ID: <179483731174.3136.9033275454370245376@kernel.org>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-9-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-9-7ab67b572f4f@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the TAI time is written "when a packet
  is handed to userspace or vhost".
- [Medium] Whether tun writes the timestamp depends only on the
  configured header size: `vnet_hdr_sz >= offsetofend(struct…
- [Medium] The value the device side reports as the 'TAI receive time' is
  sampled in tun_put_user() (drivers/net/tun.c:2178,…
- [Medium] tun cannot see the negotiated virtio features, so it guesses
  them from vnet_hdr_sz.
- [Low] The patch adds `sz < tun_vnet_parse_size(features)` → -EINVAL in
  __tun_vnet_hdr_put() (drivers/net/tun_vnet.h:163-164).

--

tun: add rx timestamp to the vnet header

This is a reference implementation of the device side of
VIRTIO_NET_F_RX_TSTAMP. When the configured vnet_hdr_sz covers the tstamp
field, tun_put_user() writes the current TAI time into the vnet header.
__tun_vnet_hdr_put() now takes a struct virtio_net_common_hdr and copies as
much of it as vnet_hdr_sz holds.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8920c797acfd7..1a8c3377753d7 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -2168,12 +2169,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr_v1_hash_tunnel hdr;
> -		struct virtio_net_hdr *gso;
> +		struct virtio_net_common_hdr hdr;
>  
>  		memset(&hdr, 0, sizeof(hdr));
> +
> +		/* The configured header covers the tstamp field */
> +		if (vnet_hdr_sz >= offsetofend(struct virtio_net_common_hdr, tstamp))

[Severity: Medium]
Is the header size enough on its own to gate this?

TUNSETVNETHDRSZ in tun_vnet_ioctl() accepts any size of at least
sizeof(struct virtio_net_hdr), with no upper bound. Before this patch,
__tun_vnet_hdr_put() zero-filled everything past parsed_size (10 or 24
bytes). After it, any existing tun user with vnet_hdr_sz >= 40 starts
getting host CLOCK_TAI values in bytes 32..39.

The tstamp layout is only defined in the kernel-internal
include/linux/virtio_net.h. Its comment says the field is present only if
VIRTIO_NET_F_RX_TSTAMP was negotiated. tun cannot see that negotiation, and
the uapi header exports only the feature bit.

UDP tunnel GSO was added behind TUN_F_UDP_TUNNEL_GSO. Older kernels reject
that flag in set_offload(), so userspace can probe for it. Without a
similar TUN_F_* opt-in, how would QEMU know whether the running kernel
fills the field before it offers VIRTIO_NET_F_RX_TSTAMP to a guest?

[Severity: Medium]
Does letting a 40-byte header mean RX_TSTAMP conflict with the size-based
feature guess in tun_vnet_hdr_guest_features()?

drivers/net/tun_vnet.h:tun_vnet_hdr_guest_features() {
	if (vnet_hdr_sz >= TUN_VNET_TNL_SIZE)
		return NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM;
	return 0;
}

In this series, virtio_net and vhost-net use a 40-byte header for
VIRTIO_NET_F_RX_TSTAMP even when UDP tunnel GSO was not negotiated. On the
guest TX side, tun_get_user() and tun_xdp_one() still pass the guessed
tunnel features to the header parser:

handle_tx()
  tun_sendmsg()
    tun_get_user() / tun_xdp_one()
      tun_vnet_hdr_guest_features(40)   -> tunnel features
      virtio_net_hdr_tnl_to_skb(..., tnl_hdr_negotiated = true)

That means this check in virtio_net_hdr_tnl_to_skb() never fires:

	/* Tunnel not supported/negotiated, but the hdr asks for it. */
	if (!tnl_hdr_negotiated)
		return -EINVAL;

Could a guest that negotiated only RX_TSTAMP send the
VIRTIO_NET_HDR_GSO_UDP_TUNNEL_* gso_type bits, the
VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM flag, or outer_th_offset / inner_nh_offset
values in bytes 20..23, and have the host accept them? For that guest,
those bytes should only be padding.

> +			put_unaligned_le64(ktime_get_clocktai_ns(), hdr.tstamp);

[Severity: Medium]
Is this really the receive time?

tun_put_user() runs when userspace or the vhost worker dequeues the packet
from tfile->tx_ring through read/recvmsg. The packet reached the tun device
earlier, in tun_net_xmit(). Any timestamp already on the skb is also
ignored.

The guest stores this value in skb_hwtstamps(skb)->hwtstamp in
virtnet_receive_done() and treats it as a hardware RX timestamp. So the
reported value also includes the ptr_ring backlog (up to tx_queue_len
entries) and vhost/userspace scheduling latency. Guest PTP or latency
tools would count that delay as receive time.

The uapi describes the feature as "Device sends TAI receive time". Should
the timestamp be taken at ingress in tun_net_xmit(), or come from an
existing skb timestamp? If dequeue time is intentional, could the commit
message say why? A real implementation would likely copy this reference.

>  		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
> -						&hdr);
> +						&hdr.tnl_hdr);
>  		if (ret)
>  			return ret;

[ ... ]

> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index f4c652b1fa44d..d4cc56dac98d6 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -153,19 +153,21 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>  	return __tun_vnet_hdr_get(sz, flags, 0, from, hdr);
>  }
>  
> +/* hdr is fully initialized, copy as much of it as the configured size holds */
>  static inline int __tun_vnet_hdr_put(int sz, netdev_features_t features,
>  				     struct iov_iter *iter,
> -				     const struct virtio_net_hdr *hdr)
> +				     const struct virtio_net_common_hdr *hdr)
>  {
> -	unsigned int parsed_size = tun_vnet_parse_size(features);
> +	unsigned int put_size = min_t(unsigned int, sizeof(*hdr), sz);
>  
> -	if (unlikely(iov_iter_count(iter) < sz))
> +	if (unlikely(iov_iter_count(iter) < sz ||
> +		     sz < tun_vnet_parse_size(features)))
>  		return -EINVAL;

[Severity: Low]
The new sz < tun_vnet_parse_size(features) check seems to quietly fix an
existing bug. Should it go in a separate patch with a Fixes: tag?

set_offload() enables NETIF_F_GSO_UDP_TUNNEL without looking at
vnet_hdr_sz, and TUNSETVNETHDRSZ accepts 10 without re-checking features.
That makes sz = 10 with parsed_size = 24 reachable. Before this patch,
__tun_vnet_hdr_put() would then do:

	copy_to_iter(hdr, parsed_size, iter)

This writes 24 bytes into a 10-byte header slot, which overruns into the
packet area of the user's buffer. Next, sz - parsed_size wraps to
0xFFFFFFF2, and iov_iter_zero() zeroes the rest of the buffer before
-EFAULT is returned.

With the new check, -EINVAL is returned before anything is written. The
commit message does not mention this change in behaviour, and the patch is
marked as not intended to be merged, so the fix would be lost. The
underlying problem appears to go back to commit 288f30435132 ("tun: enable
gso over UDP tunnel support").

[ ... ]

> @@ -174,7 +176,11 @@ static inline int __tun_vnet_hdr_put(int sz, netdev_features_t features,
>  static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>  				   const struct virtio_net_hdr *hdr)
>  {
> -	return __tun_vnet_hdr_put(sz, 0, iter, hdr);
> +	struct virtio_net_common_hdr common_hdr = {};
> +
> +	common_hdr.hdr = *hdr;
> +
> +	return __tun_vnet_hdr_put(sz, 0, iter, &common_hdr);
>  }

[Severity: Medium]
The commit message says the TAI time is written "when a packet is handed
to userspace or vhost", but tstamp is never set here. Do packets that go
through tun_vnet_hdr_put() always get a zero timestamp, even when sz
covers the field?

There are two such callers. The first is tun_put_user_xdp(), which handles
xdp_frames on tfile->tx_ring (for example from XDP_REDIRECT through
tun_xdp_xmit()):

	if (tun->flags & IFF_VNET_HDR) {
		struct virtio_net_hdr gso = { 0 };

		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);

The second is tap_put_user() for macvtap/ipvtap, which also calls
tun_vnet_hdr_put().

vhost-net advertises VIRTIO_NET_F_RX_TSTAMP for every backend and uses a
40-byte header once it is negotiated. The guest then turns on RX
timestamping.

So a guest on a macvtap/ipvtap backend would negotiate the feature and
never get a timestamp. On tun, one queue would mix timestamped skbs with
XDP frames that have no timestamp. Is that intended, or should these paths
fill tstamp as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f%40pengutronix.de
