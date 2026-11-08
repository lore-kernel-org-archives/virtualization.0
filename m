Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178925;
	b=bcXpRRBrkaJmr3Sqet8S4tPt3bmPSOWLulNqBo2oyR7IpO+wfVNvE38vB0BFkkJrEFO9
	 u2vhTfnTb/YMbKEXqQB4tAaMY9QFKSPiWcNOx2T+GZQNDnUf6/h/h4wRrXCVDEvY5VitZ
	 SaPz2CV5sC3cvBdGiUWwSVHgQ71OWF3eWbWKSMgtgy82tEWA9R1QjNzA1KW9EwQoG2SVv
	 hyTccXD+R8LaLoo4zK50Gqe3viO2eGdKItV3SGOa7ID64dWni94740Px3Fmnj2HfsN5Ae
	 xa+qSszK+b8hVVlnLCfj+tWT+N0F+7fSRZO5sDCAZkGZaIGkMEHP4xhb/tMr8gj7Vrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178925;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aHa9EsIbkQj3QkxuMW9rElf3U34lECQh15at03Vz2fI=;
	b=lS+EsmMJh+mh25ykWfNR2CeC0OC5YZpC1SXYqFx6CQPFgPQRTgGcQ8xJzkFx5+sBuzmx
	 aa0beaViAnpJTmaNTi58hg/SpGgUvpI2MayxNXrndtqR0Wzj6z04TMUKXovvyU84AGKMG
	 Lx6EQIoxCA4E6rIX9VFvGcWtKWMsTWEfYYfArQojty7zMNKuidhD/l3xcE9YP1Z7hKNs6
	 dHO01Nht1wuJXG9QtWKb2MVk8SuI1nbq8nsvFH4fLIct+IEVSlPq7GP3fGEjyibZkMjy4
	 dSXLiPv9ltLjKUfnj3OpZ5MZ9jF69/5AsB9NRCxD2UHb34NovUdatEnnj+DGevPMTXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4qJtvhG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297F606A321;
	Sun,  8 Nov 2026 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4qJtvhG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7BF1F0089F;
	Sun,  8 Nov 2026 23:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178924;
	bh=aHa9EsIbkQj3QkxuMW9rElf3U34lECQh15at03Vz2fI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U4qJtvhGCOle3g1eSa3RPf8a0E0hWvaU17lT+MvP+kiwbI279KOIZ9W1uHBIOrdwd
	 gdhjnodkCqCQfB+CDa0ZCzitr+BjCQf+OoUkZDHWe1N2mFCh9f4TG8ZTc5awPz7d1s
	 dnMJO95sAEj2Er8Fksrou0xxmavjCps9orG/hXuUZ5wioLAKNjjXMGBAOqPqMXqTWR
	 heLfdjD+Wqm+T1eigUUZtTiT5FOUKtFT5kdahGIZcoTLcT61kikZv7jopmluDFp1DK
	 K0RStBidWHiKLWBMFV24kWenO6flk2GpJJDp0fxp7/hEeJQ7DJYIGLlfQrah63Yeja
	 deHK7li9SXJdA==
Subject: Re: [PATCH net v3 8/8] selftests: net: tuntap: write UDP tunnel
 offsets in little endian
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, hassansultan@google.com,
 virtualization@lists.linux.dev
Date: Sun, 08 Nov 2026 23:02:03 +0000
Message-ID: <179417892365.994134.10585353902960139433@kernel.org>
In-Reply-To: <20261105115715.1466924-9-edumazet@kernel.org>
References: <20261105115715.1466924-9-edumazet@kernel.org>
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

- [Medium] selftests: net: tun: UDP tunnel GSO tests still fail on big-
  endian hosts

--

> diff --git a/tools/testing/selftests/net/tuntap_helpers.h b/tools/testing/selftests/net/tuntap_helpers.h
> --- a/tools/testing/selftests/net/tuntap_helpers.h
> +++ b/tools/testing/selftests/net/tuntap_helpers.h
> @@ -375,11 +377,14 @@ static inline int build_virtio_net_hdr_v1_hash_tunnel(uint8_t *buf, bool is_tap,
>  	inner_iphlen = (inner_family == AF_INET) ? sizeof(struct iphdr) :
>  						   sizeof(struct ipv6hdr);
>  
> -	vh_tunnel->outer_th_offset = eth_hlen + outer_iphlen;
> -	vh_tunnel->inner_nh_offset = vh_tunnel->outer_th_offset + ETH_HLEN +
> -				     GENEVE_HLEN + sizeof(struct udphdr);
> +	outer_th = eth_hlen + outer_iphlen;
> +	inner_nh = outer_th + ETH_HLEN + GENEVE_HLEN + sizeof(struct udphdr);
>  
> -	vh->csum_start = vh_tunnel->inner_nh_offset + inner_iphlen;
> +	/* The tunnel offsets are always little endian. */
> +	vh_tunnel->outer_th_offset = htole16(outer_th);
> +	vh_tunnel->inner_nh_offset = htole16(inner_nh);
> +
> +	vh->csum_start = inner_nh + inner_iphlen;
>  	vh->csum_offset = __builtin_offsetof(struct udphdr, check);
>  	vh->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
>  	vh->hdr_len = hdr_len;

[Severity: Medium]
Does this fully fix the big-endian case? The commit message says
csum_start follows the tun vnet header endianness, but that holds for
only part of the kernel path.

tun_open() never issues TUNSETVNETLE, so on a big-endian host
tun_vnet_is_little_endian() is false. virtio_net_hdr_tnl_to_skb() does
read csum_start with __virtio16_to_cpu(little_endian, ...) for the
initial offset ordering check. It then calls
__virtio_net_hdr_to_skb(skb, hdr, true, ...) with little_endian
hardcoded to true.

Inside __virtio_net_hdr_to_skb(), csum_start, csum_offset and
gso_size get byte swapped. build_virtio_net_hdr_v1_hash_tunnel()
still writes all three in host order, so:

  csum_start 84 becomes 21504
  csum_offset 6 becomes 1536
  gso_size 1400 becomes 30725

The 2800 byte frames used by tun_vnet_udptnl_proto and
tun_vnet_udptnl_proto_l3 are much smaller than that. The
pskb_may_pull() for the checksum location therefore fails, and
write() returns -EINVAL before virtio_net_tnl_offsets_ok() is ever
reached. The outer_proto_bad* cases would still see EINVAL, but for
the wrong reason, and the positive cases would still fail.

The receive side has the same problem.
virtio_net_hdr_tnl_from_skb() calls
virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen), so
gso_size comes back little endian. recv_gso_packet() then compares
vh->gso_size directly against the host order variant->gso_size.

So the UDP tunnel tests in tun.c would still fail on big-endian
hosts after this patch. Which way do you want to fix it?

One option is for the tests to switch the device to little endian
with TUNSETVNETLE and write the base header fields with htole16() too.

The other is to treat the hardcoded true in
virtio_net_hdr_tnl_to_skb() and virtio_net_hdr_tnl_from_skb() as the
real bug. The same function already decodes csum_start with
little_endian a few lines earlier.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105115715.1466924-1-edumazet%40kernel.org
