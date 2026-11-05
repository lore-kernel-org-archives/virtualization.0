Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867539;
	b=Bf4x0bsqBW5vUDuoeRz6qidTLnknrbXnQI07BjX76Yay9xmEMKkl44oEyi59UL54GpcA
	 geYVGcgR2dYmaVdegAq5TMY5cRlH6CeucQ2cvx/RZDPcXrC6kO39mOcypKdvURHsuf5Bu
	 E5rMmVlC17Zpd9dkw/oI57j6ddevPKStBT06hPuabdBZC6TXQ+Qd+idSiPqlR6p65Ips6
	 ekHWpZB6Q8AQ4aHhHdyyBnWtxYbCWpzFFZ3faDqunUEyNg1xW8+YyayfK/Vfje90Kse3u
	 uEtKp3011xqP0WfkNgUnCUfB7Wm11N4pVxN2jZ0IaBzuttarNCM7nu0PzEJQeOqkY9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867539;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NVbW2BmaD9uKOnn7G67IrkamJB+FiKSrtrQf7TOH35E=;
	b=mcEhlVqV6RXbV/TAf4UJ0lpaI9nHjHwMkGP8kqGLNZKMYQ56KH0joqSXkY/opCks48Po
	 Y16+Wq08xft1ouNLmPYrytN0B6DhDYrZCsH8KH+eSQzQE4ZpIXg7zzYN+Rf7nl6Exy+SX
	 O0Ce5nIuObz7p8dkJsXJwBoNlbXdEL5Sl/mFQNQ3bz8SZ4TGyCR6403WGqsQck182KUa9
	 ekXBOaLvNkzi7BJKOLfQD0pfdy9FsizPsUak91GtBtHlfJDuAI+4hXhh8Iad4VVysEJFR
	 NBXvXxlgAfeZegciC3I3snNsL6RSGlMLNOxuGWggcmiuczQN/xzOOk/MFBY3eKD07hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4f4SU0D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD1606A32C;
	Thu,  5 Nov 2026 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4f4SU0D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED881F00919;
	Thu,  5 Nov 2026 08:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867538;
	bh=NVbW2BmaD9uKOnn7G67IrkamJB+FiKSrtrQf7TOH35E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O4f4SU0D8QIgL1X10PD9EVe0bw/EfGxKi4rbWrDIY5Q/Y9urMRJepmU1iI8zqSYxm
	 Ml+7pzp2epoG9bkg5Hocu4KklduGIonUPFnqj3jPu8grFbLrgjXZW0y7ekufemrQG0
	 qKyi8DzKqSbwNatkOhp0Ja+E4TfkYg2hSjJe0pElsCYldYYEgGr2/26glmErirx/WT
	 j4LL6CbYpIASfkqJJJT4XQneo+ThZZDws7oSSoXe6dwBipvvVwUB9uNo4Rz/88J1nB
	 JzllwV3Spt6ff5COQiPpaWan3MtU02VeACWvpblkLiEGNcprDWFIqBJN03OMpbtwEq
	 BXqMQEFS19rpQ==
Subject: Re: [PATCH net 3/3] selftests: net: tun: test outer protocol of UDP
 tunnel GSO packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 eperezma@redhat.com, hassansultan@google.com, virtualization@lists.linux.dev
Date: Thu, 05 Nov 2026 08:32:17 +0000
Message-ID: <179386753718.488856.13433005125725728519@kernel.org>
In-Reply-To: <20261103203113.550604-4-edumazet@kernel.org>
References: <20261103203113.550604-4-edumazet@kernel.org>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new tests cover only part of the fix they are meant to
  validate.
- [Low] virtio_net_tnl_outer_proto_ok() in include/linux/virtio_net.h was
  added by the series commit "net: virtio: validate outer protocol of…
- [Low] Both tun_vnet_udptnl_proto tests build several frames in the same
  calloc'd buffer (self->pkt) without clearing it in between.

--

selftests: net: tun: test outer protocol of UDP tunnel GSO packets

This adds a tun_vnet_udptnl_proto fixture that writes single 4in4 Geneve
GSO frames to a tap device with UDP tunnel offloads enabled. outer_proto_ok
expects outer IPv4 frames, optionally VLAN tagged, to be accepted.
outer_proto_bad expects IPv6 or NSH outer ethertypes to be rejected with
EINVAL.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index 34de2580e32ec..47a24b9c477bb 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -683,6 +683,136 @@ TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum_64k)

[ ... ]

> +FIXTURE_SETUP(tun_vnet_udptnl_proto)
> +{
> +	int flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;

[Severity: Low]
This fixture only opens IFF_TAP devices. That means the IFF_TUN branch of
virtio_net_tnl_outer_proto_ok() from the previous patch is never run. Does
the assumption behind that branch hold?

include/linux/virtio_net.h:virtio_net_tnl_outer_proto_ok() {
    ...
	/* L3 device (IFF_TUN): the caller already set the protocol. */
	if (proto)
		return proto == expected;

	/* Ethernet frame, possibly VLAN tagged. */
	proto = eth_hdr(skb)->h_proto;
    ...
}

The previous patch's commit message also says "For IFF_TUN, skb->protocol
is already set by the caller."

For IFF_TUN without IFF_NO_PI, tun_get_user() in drivers/net/tun.c copies
struct tun_pi from userspace. It stores the value as-is before
tun_vnet_hdr_tnl_to_skb() runs:

		skb_reset_network_header(skb);
		skb->protocol = pi.proto;

pi.proto can be 0 here. In that case, would the helper take the Ethernet
branch for an L3 packet?

The mac header was reset to the start of the outer IP header. So h_proto
would be read from the first two bytes of the IPv4 saddr, and nh_off would
be measured from ETH_HLEN.

For example, a 4in4 frame with an outer saddr of 8.0.x.x and outer_th >= 34
(IPv4 options) would pass the check. The skb would then go into the stack
with SKB_GSO_UDP_TUNNEL set and skb->protocol == 0, which the comment says
can't happen. With other saddr values the same packet would be rejected.

The downstream impact looks limited, because skb_mac_gso_segment() returns
-EINVAL when skb_network_protocol() gives 0. Even so, should the helper or
its comment handle this case? Would an IFF_TUN case in this fixture be
useful?

[ ... ]

> +static int build_udptnl_frame(uint8_t *buf, bool vlan, uint16_t l3proto,
> +			      int payload_len)
> +{
> +	struct virtio_net_hdr_v1_hash_tunnel *vh = (void *)buf;
> +	int vlan_len = vlan ? 4 : 0;
> +	int hlen = ETH_HLEN + vlan_len + UDP_TUNNEL_GENEVE_4IN4_HDRLEN;
> +	uint8_t *outer_udph, *cur = buf;
> +	int pktlen;
> +
> +	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 1400,
> +						   AF_INET, AF_INET);
> +	vh->outer_th_offset += vlan_len;

[Severity: Low]
outer_th_offset is always shifted by vlan_len, and the outer family is
always AF_INET. Given that, do these tests reach all of the checks added by
"net: virtio: validate outer protocol of UDP tunnel GSO packets"?

virtio_net_tnl_outer_proto_ok() ends with:

	return proto == expected &&
	       nh_off + virtio_l3min(outer_isv6) <= outer_th;

The length clause can only fail when a VLAN tag moves nh_off to 18 or
more. Without a tag it is the same as the existing outer_l3min check.

No case here sends a VLAN tagged IPv4 frame with outer_th_offset left at
34. If that clause were removed or miscomputed (for example in a stable
backport), no test would fail.

Every frame also declares VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4. So the
outer_isv6 side of expected is never tested either, for example an IPv4
ethertype on a declared IPv6 tunnel.

Separately, the commit message says outer_proto_bad covers:

    (IPv6 on an IPv4 tunnel, or NSH, with or without a VLAN tag)

outer_proto_bad actually tests IPv6 untagged, NSH untagged and NSH behind a
VLAN tag. IPv6 behind a VLAN tag is not tested. Should the message be
narrowed, or should that case be added?

[ ... ]

> +TEST_F(tun_vnet_udptnl_proto, outer_proto_ok)
> +{
> +	uint8_t *pkt = self->pkt;
> +	int len, ret;
> +
> +	len = build_udptnl_frame(pkt, false, ETH_P_IP, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, len);
> +
> +	/* The outer IPv4 header can follow a VLAN tag. */
> +	len = build_udptnl_frame(pkt, true, ETH_P_IP, 2800);

[Severity: Low]
Is the VLAN tagged frame here well formed? self->pkt is calloc'd once in
FIXTURE_SETUP and is not cleared between frames. The helpers in
tuntap_helpers.h expect a zeroed buffer.

build_ipv4_header() never writes tos or frag_off. It also sums over
whatever is already in the check field:

	iph->check = build_ip_csum(buf, iph->ihl << 2, 0);

build_udp_packet_csum() also sums over the existing udph->check. The
existing tun_vnet_udptnl test clears its buffer first in send_gso_packet():

	memset(pkt, 0, sizeof(pkt));

In this test, the second frame's outer IPv4 header starts 4 bytes after the
first frame's. As a result:

- frag_off holds the previous outer IPv4 checksum
- tos holds the low byte of the previous IP ID
- the checksum is computed starting from stale saddr bytes

The inner IPv4 header and the inner UDP checksum are shifted and corrupted
in the same way.

This only passes today because the kernel path checks just the offsets and
the ethertype. If that path ever validates the outer IPv4 header, for
example by rejecting fragments for GSO, outer_proto_ok would fail for an
unrelated reason. Would a memset at the start of build_udptnl_frame() avoid
this?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103203113.550604-1-edumazet%40kernel.org
