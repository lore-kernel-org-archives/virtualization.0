Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178922;
	b=LYWgJQwtpsfLP6L+JY9Kd7CW2i291E447v/Gw05lGkDCf2Zso8BZM01a1l7884YAgoK4
	 uouwu2J8fKYODn8R/R5m2KSEqwBlSQ9wgWcsrb846lAwEJv4mxw620NyINhOmCKhrRL76
	 /+QEmq9b60U9AJqpU/gAoIsGtSeq/T74KvbEZ6btgH7gimUijAIZ5OEcMalvFiD/tJzc6
	 QCny/8J0YY1bdriy4cyoPBga8xd3o8o+V0ZF1imGl/GgSGwGgW/nl4iUBU96Ysf7jR6Ei
	 NktxPxuz7/2SQohml7N8geCBGzbUCxBB91B+uK1bqlBYebyQ1rH5yTTj12NRiRb+XAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178922;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yM25/GugWtS5eYQw8jUKm3Ak+vyWwBY7qyUlPKTLzYI=;
	b=IpeCd0vnb4wcA8/iNvtrZL9XkU4zeCd+aosdcU3mhqSeQ28DqAg5Lpm+IKzGVaWdePhV
	 0RlSmyzJl2uKEC25v7V98YVL7uVzj3aGWavcDNDyIB85Wp6pjbFGd6m2d727j91IlDAuy
	 uD+veb+0bhV8r94Ew5Rh0YGZNokPj2iCaoi/MWc7eCENKRX8YWJNW6TP+257bL8W/QJjR
	 mUyi00p6HRgVCyO7KlFV+5CwHEDMFWTcw4r7O+hEbnz8YgTnOLWi4vMqh+x/n/0+J/KEt
	 44lFGU5exnmgeviOQPM35/1/sH4P0DuRWosXdMegOG8xuewF2yZLcgYw0ohzCYu0cnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWzpTQX9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6785E606A33B;
	Sun,  8 Nov 2026 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWzpTQX9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C851F0089F;
	Sun,  8 Nov 2026 23:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178922;
	bh=yM25/GugWtS5eYQw8jUKm3Ak+vyWwBY7qyUlPKTLzYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZWzpTQX9ntSJDElPFYuEJoalbwsUtLJ7oxrcLwQ9D2La0kIwTZWA9gvQbsENmc1cY
	 EBFMLVz1cAczeF91P0Cf+jLG92iGZFUshIm0uG2mIFThm7LDanBMAGwN+rHkZ8RVHc
	 K0zaARXg6P1cV5q7SXR/404pOxtn3xpEfHIHQo4BxzLl0FllIihmOnINaKBzIGSKvv
	 a2xFMwjfJPoj11rBRYY9w5FwUyGj9O2FZxODVaH8nNTurMxkDZUtxsCEBGAg87h8PC
	 GImDg+kU6KssGI+qOuq5Wst8/QWQolVvH6wrqZfZK9i1pOJ/5XjsHzWrYgJQsgMli0
	 IR0UNEbHZlE6A==
Subject: Re: [PATCH net v3 6/8] selftests: net: tun: test UDP tunnel GSO on
 retyped devices
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, hassansultan@google.com,
 virtualization@lists.linux.dev
Date: Sun, 08 Nov 2026 23:02:01 +0000
Message-ID: <179417892118.994134.13795421387066708306@kernel.org>
In-Reply-To: <20261105115715.1466924-7-edumazet@kernel.org>
References: <20261105115715.1466924-7-edumazet@kernel.org>
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

- [Low] In TEST_F(tun_vnet_udptnl_proto, outer_proto_link_type) in
  tools/testing/selftests/net/tun.c, the second write sends a VLAN-…

--

selftests: net: tun: test UDP tunnel GSO on retyped devices

This commit adds a tun_set_link_type() helper that uses TUNSETLINK to
retype tun/tap devices. It also adds two tests that check the outer
headers of UDP tunnel GSO frames are validated by the tun/tap framing
rather than by dev->type.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index 81410afbbcc8d..cfeca53863ce2 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -816,6 +816,59 @@ TEST_F(tun_vnet_udptnl_proto, outer_proto_bad)

[ ... ]

> +TEST_F(tun_vnet_udptnl_proto, outer_proto_link_type)
> +{
> +	uint8_t *pkt = self->pkt;
> +	int len, ret;
> +
> +	/* The frames still start with an Ethernet header, but the device
> +	 * type no longer says so: the Ethernet header must still be
> +	 * checked.
> +	 */
> +	ASSERT_EQ(tun_set_link_type(self->fd, self->ifname, ARPHRD_NONE), 0);
> +
> +	len = build_udptnl_frame(pkt, false, ETH_P_NSH, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	len = build_udptnl_frame(pkt, true, ETH_P_NSH, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);

[Severity: Low]

Does this VLAN-tagged NSH write fail on a kernel that is missing the fix?
The commit message says:

  Without the patch "net: virtio: do not use dev->type to find the outer
  L3 header", the frames expected to be rejected are accepted.

Without that fix, dev->type is ARPHRD_NONE here, so virtio_net_l3_start()
takes the non-Ethernet branch. For IFF_TAP, tun_get_user() has already
done:

    skb_set_network_header(skb, ETH_HLEN);

so the IP version is read at frame offset 14. In a tagged frame, that
offset holds the 802.1Q TCI that build_udptnl_frame() writes:

    uint16_t vlan_tag[2] = { htons(100), htons(l3proto) };

The first byte is 0x00, so the old code sees version 0:

    if (iph->version == 4)
        *proto = htons(ETH_P_IP);
    else if (iph->version == 6)
        *proto = htons(ETH_P_IPV6);
    else
        return false;

and the write returns -EINVAL. The old code rejects every VLAN-tagged
frame on a retyped tap, NSH or not. With the fix, this frame is still
rejected, because the protocol after the tag is NSH. So this assertion
passes with or without the fix.

The untagged ETH_P_IP accept case below also passes on both kernels,
because the old path finds a valid IPv4 header at offset 14. Only the
untagged NSH write tells the two kernels apart.

Could a VLAN-tagged ETH_P_IP frame that must be accepted be added here?
The unfixed kernel rejects it (version 0 at offset 14), and the fixed
kernel accepts it after walking the tag. The case is still missing at the
end of the series, after "selftests: net: tuntap: write UDP tunnel offsets
in little endian".

Should the commit message also be narrowed, since the tagged NSH frame is
rejected without the fix as well?

> +
> +	len = build_udptnl_frame(pkt, false, ETH_P_IP, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, len);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105115715.1466924-1-edumazet%40kernel.org
