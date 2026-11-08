Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178924;
	b=vnfo7xR9B/jpmx0rAV5EqMah3nqEum38XeN3zKrtzZtsVEmEw3AhZIx+IirJBTN4Y+b0
	 cR4HRUZ6BQ3JDIwp+ffkLBqdN0mUoP6qiJO39im3MfOBbf2MXQ84T+VxE9xwLPVL2gpUG
	 iCTGvIzWYy29JEAnJII0kBKWd9FO/h3+yef4rDZSrAx/8MGvjMDgytYku635yREvflLOi
	 bvYrajSEL/e3u3IxAgPsuBLwpfhsv2TqrOsaqL283CkbfCuRklfkSIijZ9JKlG1d4437X
	 q68OHtApAkP5nya3L9z5jvWeyOK2t+CodOiB9ZndsoiUWiFfkWURVKh3k6C6pls6h0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178924;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HMEUsWObbcya/BQ+ZiHYQ/gNj2BmLLktTiCIx4+m6OU=;
	b=iTH88c0nvDbqx/8AXccJOP/zv5ktcc5ToImMynqgjQgipLpcKFzdoGrAAqqeWJM3CfAF
	 2RpsRbKImLske+5JI/GDv/IjG7FBWbdDVvUVrmZw/rsLb8kTZACwa8Cn2jvl9+dlZ6aQe
	 EmEIO2fDogloAzLuqr7JkWiGcLhH3bh5B+ISUPEQRAhG/fRXFK8qN5UlxSCjX/iND8E0F
	 6T3tufyn3xVePSwUxJ9FiGg6bLTqJgN+HdNFhh8MNBj6uuc7z5dqwExgTsYKFwagXnU+r
	 ehw4uwTzNe2in7V5NbGniP/Wdcc/jL9/JlGA4diyqZdZTtUDxHIotHU7kLFF7Hl+vxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F15xa+c0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDB606A331;
	Sun,  8 Nov 2026 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F15xa+c0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A651F0089F;
	Sun,  8 Nov 2026 23:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178923;
	bh=HMEUsWObbcya/BQ+ZiHYQ/gNj2BmLLktTiCIx4+m6OU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F15xa+c0viZfxeGdR/mUIpCHunEZLgcuIOyXEjG0kmA1zbD17rFFlG6XNXNOB4WRI
	 wjraZ7J6w7+D+YYQQl61JkpsblTqC5iLe1GvIYQfg51/Z+DGo9QOttY39KOTRkG/Ic
	 gHVFRtGrBfSw22hytJTQiznUCtIjI4K0gFMhC8Y/2kGQyYd498hxPwMwxC6rWqVRcq
	 Xgdsc0NiuI/RfiqCvHAdL6SSWEptMDQbaWJfTiL2gbpUvNZPON5c6+kJH8aDWB/V1t
	 gxQkzwkDPoM9vNA55dy6ngwsJWJe3jsaXrZqnppKs71GAgIIA8AcKmgeBhhSb5iSK1
	 fRCehAszttAvw==
Subject: Re: [PATCH net v3 7/8] selftests: net: tun: test more outer header
 mismatches of UDP tunnel GSO
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, hassansultan@google.com,
 virtualization@lists.linux.dev
Date: Sun, 08 Nov 2026 23:02:02 +0000
Message-ID: <179417892244.994134.4174875687099928209@kernel.org>
In-Reply-To: <20261105115715.1466924-8-edumazet@kernel.org>
References: <20261105115715.1466924-8-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new helper build_udptnl6_frame() in
  tools/testing/selftests/net/tun.c (lines 873-908) gets the header…

--

selftests: net: tun: test more outer header mismatches of UDP tunnel GSO

This commit adds tap tests for outer header checks on UDP tunnel GSO
packets. It adds a new 4in6 frame builder, build_udptnl6_frame(), with a
positive control and a family mismatch test. It also adds VLAN and L4
protocol mismatch tests that reuse the existing 4in4 builder.

Closes: https://lore.kernel.org/netdev/179386753718.488856.13433005125725728519@kernel.org/

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index cfeca53863ce2..a135d3aa10d18 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -869,6 +869,103 @@ TEST_F(tun_vnet_udptnl_proto, outer_proto_link_type)
>  	ASSERT_EQ(ret, len);
>  }
>  
> +/* Build a 4in6 Geneve GSO frame whose outer ethertype is @l3proto. */
> +static int build_udptnl6_frame(uint8_t *buf, uint16_t l3proto,
> +			       int payload_len)
> +{
> +	int hlen = UDP_TUNNEL_GENEVE_4IN6_HDRLEN;
> +	uint8_t *outer_udph, *cur = buf;
> +	int pktlen;
> +
> +	memset(buf, 0, TUN_VNET_TNL_SIZE + hlen + payload_len);
> +
> +	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 1400,
> +						   AF_INET6, AF_INET);
> +	cur += build_eth(cur, l3proto, param_hwaddr_outer_dst,
> +			 param_hwaddr_outer_src);
> +
> +	pktlen = UDP_TUNNEL_GENEVE_4IN6_HDRLEN - ETH_HLEN -
> +		 sizeof(struct ipv6hdr) + payload_len;

[Severity: Medium]
Are hlen and pktlen both 14 bytes too small here?

UDP_TUNNEL_GENEVE_4IN6_HDRLEN counts only the inner Ethernet header:

#define UDP_TUNNEL_GENEVE_4IN6_HDRLEN \
	(ETH_HLEN + sizeof(struct iphdr) + sizeof(struct ipv6hdr) + \
	 GENEVE_HLEN + 2 * sizeof(struct udphdr))

The 4in4 sibling build_udptnl_frame() adds the outer Ethernet header
separately. It subtracts only the outer L3 header:

	int hlen = ETH_HLEN + vlan_len + UDP_TUNNEL_GENEVE_4IN4_HDRLEN;
	...
	pktlen = UDP_TUNNEL_GENEVE_4IN4_HDRLEN - sizeof(struct iphdr) +
		 payload_len;

build_gso_packet_into_tun() follows the same convention for 4in6 on tap.

In build_udptnl6_frame(), the virtio header's hdr_len is set to 98. The
real header stack is 112 bytes. The memset() also clears 14 bytes less
than the frame that gets written.

pktlen works out to 44 + payload_len. The data after the outer IPv6 header
is outer UDP + Geneve + inner Ethernet + inner IPv4 + inner UDP + payload,
which is 58 + payload_len.

So ip6h->payload_len and the outer udph->len are both 14 bytes short.
build_udp_packet_csum() sums only ntohs(udph->len) bytes, so the outer UDP
checksum is also wrong.

outer_proto_ok_ipv6 passes today only because the tun write path does not
cross-check those lengths. Would it start failing if outer header
validation became stricter? And could outer_proto_bad_family then get
EINVAL from the length mismatch instead of the family check it is meant
to cover?

The later patch in the series, "selftests: net: tuntap: write UDP tunnel
offsets in little endian", leaves build_udptnl6_frame() unchanged.

Something like this would match build_udptnl_frame():

	int hlen = ETH_HLEN + UDP_TUNNEL_GENEVE_4IN6_HDRLEN;
	...
	pktlen = UDP_TUNNEL_GENEVE_4IN6_HDRLEN - sizeof(struct ipv6hdr) +
		 payload_len;

> +	cur += build_ipv6_header(cur, IPPROTO_UDP, 0, pktlen,
> +				 &param_ipaddr6_outer_dst,
> +				 &param_ipaddr6_outer_src);
> +
> +	outer_udph = cur;
> +	cur += build_udp_header(cur, UDP_SRC_PORT, VN_PORT,
> +				pktlen - sizeof(struct udphdr));

[ ... ]

> +	build_udp_packet_csum(outer_udph, AF_INET6, false);
> +
> +	return cur - buf;
> +}
> +
> +TEST_F(tun_vnet_udptnl_proto, outer_proto_ok_ipv6)
> +{
> +	int len, ret;
> +
> +	len = build_udptnl6_frame(self->pkt, ETH_P_IPV6, 2800);
> +	ret = write(self->fd, self->pkt, len);
> +	ASSERT_EQ(ret, len);
> +}
> +
> +/* An IPv4 ethertype on a declared IPv6 tunnel. */
> +TEST_F(tun_vnet_udptnl_proto, outer_proto_bad_family)
> +{
> +	int len, ret;
> +
> +	len = build_udptnl6_frame(self->pkt, ETH_P_IP, 2800);
> +	ret = write(self->fd, self->pkt, len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105115715.1466924-1-edumazet%40kernel.org
