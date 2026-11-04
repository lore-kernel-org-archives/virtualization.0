Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758792;
	b=qEmiHYdqytHwdyyhZdM5tO0qczCs661KnDvlUHKwwPCmRyh/4Ux81rJ/GtUL+0RbHfi+
	 PKW7b6luCS3rJaGCZLkWIvxa1XBAZFbTldF6DJdpLo2q1qDqBAnxwN+EJDtvsOOE1DAwx
	 YjuF8D965xRFqRnpVqAFaib1TGNVYkG5t8yV8lX5CVvW0EB+rk7bDT/sGr5H8NLNSAnYt
	 ulJCFftoeJfI2EzTA7sjyDXleQ1csbOejGpt5Yqftt11zO0oMd14C24ngyuaopVePOw8D
	 BihocQHFKerPNsmCLqT1IG+1YsvH8/GxjJ3EESBAai96TwxO56m4Wzw5C6UU7xoNbGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wDPnb5kC0rdGQBK898MutD9eBOrINRLYSXUnCJrhCVk=;
	b=aCJA5rRvOtEiPN8RgHJVJ/PihDHvccsRsYflDGiypawg3nkuPtmupku1Z+RHHJ3P2SAs
	 qgPqpXWdYkyvZsxWLcMIrsxT7pn4SuDfwREmshMVSZn6gQ5/qhaJ7pO8o3eb1PtKaQTTi
	 01a0qbpj5S/WBjwWlnCyrdEFaBr0OE+eUzrW5deyHBisbM5u0OmL/X40tdZ2y6Z/yr+vJ
	 cKlazUdjb/vKLLrYErf0KWJyySeUZZsVkr+vOKwfHhcVRPXUtnGKmWdn09b9pZFrAT0ui
	 zTDZz3DZnrPuNgRA9M7rFPxp6g1V5UqA1quWoGeqsRI2Wfmw5zznvZcmm0Q/qXcOkaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBfR6bZ0;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCC4606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDCC4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBfR6bZ0
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-745497ac8fcso69949137.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 18:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758791; x=1794363591; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wDPnb5kC0rdGQBK898MutD9eBOrINRLYSXUnCJrhCVk=;
        b=cBfR6bZ0mdWPrZtk7d3t5ZmklQgMcJL6Wu/xJsqcjlX4gjDhodZZqg1gFP6FU93A2p
         XOjTvrAn/kg+EkQ+TrJD3YqdrKCV79Lubq5vHDCCC9+SQlHxjXu9ormCwyYCqwXefbXf
         ZCT7A6Y6ySeFt+IHWikOZxOsxfFPGF0/90nPLrbvZmm1OKR+k+B8uXM1MJyUsCmsab4N
         Z72EgO1qEydsdGdAsS4nhh7szWJWY4pfC3RXmRew2t4a0Zq+/9cloLuXXKJaGEy1W2fP
         Hy1yCPsughKArEY+uoNq8Wc6a2YZ5EtnrUaeJIiVgpFjCqiiI9q0WIFzyE2sJkPO4o5v
         4/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758791; x=1794363591;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wDPnb5kC0rdGQBK898MutD9eBOrINRLYSXUnCJrhCVk=;
        b=V/J9V73SBM+G0alfnUl9+yhaHy3vDBGVnqWSwpu/ICf+lc5+YEonsP5KCL+VYeZMqh
         nNv2+fB7LnZw1L5LfMCQVbETzpwKBuvud6UONjV+WDz3v+xpyvIILosnD/aJ408lUS50
         /GCQ5WCCrYLbTw6nOMJZ/XqRl+ZjBiKqE5elpSdZ0gat7VUmqVEjdhEVY9RNUsjHQesX
         WEnfN63S08XAL1O24wB7xtEiD+yvLBcBPUVh4wAOnNGtW6TzRws/hPFqqEMZ9t+8IBVJ
         UW/pUu0yymQc/R0dsku1zfCSq7ARq+Cqk46S3ClCLv+PVCvgzwAz51CJiMAof/KTlDL6
         c5BQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCCfJpHgXbdXYKACRmUpD85p8ssCT7vgSm4O/+vMMtZFyWlbXLizjSpPBz5Hi8jokC6SAegZ00yETUqmfKog==@lists.linux.dev
X-Gm-Message-State: APuU4Z8qdg8KdvzBx08RabLI4NVG3pwYDU181m6W9AmMMRZvYH1bhfld
	z/zMYLOBY3a5YtAyzyRQV6FE2wkrBzlPbgIgc/xvTLwd5s+9vGYnLN6E
X-Gm-Gg: AYBFou2+jv1s0doXjDHLl0xLdz0zHyc9SV3g5Frea9S0dp8vo74wpROVmzRF7PdysMy
	RR0sPzpILskf5R80cDZDmm9QlB0suZxXV/iMzgAbr/JOdMV/hxTDuxqSpRRVjf7r+dvmearoWvx
	HSnwS7zxjzZN+zy3drTY31Bonr3cUvEq5q08de+aCIFlFYUhp5YA6UwTqwcnsgEiOxI5L+mVz8l
	2BHQ1cI5NseaEsTY2fPCQBRJgL/1NJ38jkSLwnV3aAo+T/HtkekgenNMVz91Dwf4kugqlj7Pr+C
	MEpvlVLL4m9+05btORPCmrgJ4xSKa7xTRaobUCmxKN8kJIoFl/vBWZk69ZUuzXX9V3t4x4rBuZW
	gu0bk04i0Xh67bc3E+wJjPEQm3EUMMiCDC7R6BORuHfgF5jm9dP24I6tqC0OgiLjgInhZw7sEBo
	WFnm3vXZIkPEio+cQa8boUftSPvociuUx3zuWR8EoqBA2BwL5XgP5eSgqp5MLSQqyma8e/+nARE
	srWPzoLfSvMefOnT3fvJSGgDVUCx766woXXrK09mLkar1R3vBPgvqcpsRq6focVwtlEffu0CGDX
	7s7l+bw5NivSrjaPyK5Gj3GWkqW0wK+l3kQf8zhepbrSWeAkAnf4uyS9FonT2oclbabWI/6supt
	RZQjRbJEICaTMix/jQGF5kK5470rgNuBFnZcropk63Zcn/bjWjiwkILFmkn3CK/NcIZuLE38=
X-Received: by 2002:a05:6102:5712:b0:7c3:881f:b620 with SMTP id ada2fe7eead31-7d072c56c97mr5453392137.21.1793758790891;
        Tue, 03 Nov 2026 18:19:50 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm658096137.11.2026.11.03.18.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:19:50 -0800 (PST)
Date: Tue, 03 Nov 2026 21:19:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.2bcc7ca0e8623@gmail.com>
In-Reply-To: <20261103203113.550604-4-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
 <20261103203113.550604-4-edumazet@kernel.org>
Subject: Re: [PATCH net 3/3] selftests: net: tun: test outer protocol of UDP
 tunnel GSO packets
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Add a tun_vnet_udptnl_proto fixture writing single 4in4 Geneve GSO
> frames to a tap device with UDP tunnel offloads enabled:
> 
> - outer_proto_ok: an outer IPv4 header, with or without an 802.1Q tag,
>   is accepted.
> - outer_proto_bad: an outer ethertype that does not match the declared
>   tunnel type (IPv6 on an IPv4 tunnel, or NSH, with or without a VLAN
>   tag) is rejected with EINVAL.
> 
> Without the previous virtio_net patch, outer_proto_bad fails because
> the kernel accepts the frames.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  tools/testing/selftests/net/tun.c | 130 ++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index 34de2580e32e..47a24b9c477b 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -683,6 +683,136 @@ TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum_64k)
>  	ASSERT_EQ(ret, len);
>  }
>  
> +#ifndef ETH_P_NSH
> +#define ETH_P_NSH 0x894F
> +#endif
> +
> +FIXTURE(tun_vnet_udptnl_proto)
> +{
> +	char ifname[IFNAMSIZ];
> +	uint8_t *pkt;
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(tun_vnet_udptnl_proto)
> +{
> +	int flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> +	int features = TUN_F_CSUM | TUN_F_UDP_TUNNEL_GSO |
> +		       TUN_F_UDP_TUNNEL_GSO_CSUM | TUN_F_USO4 | TUN_F_USO6;
> +
> +	self->fd = -1;
> +	if (unshare(CLONE_NEWNET))
> +		SKIP(return, "Cannot create network namespace: %s",
> +		     strerror(errno));
> +
> +	self->pkt = calloc(1, MAX_VNET_TUNNEL_PACKET_SZ);
> +	ASSERT_NE(self->pkt, NULL);
> +
> +	memset(self->ifname, 0, sizeof(self->ifname));
> +	self->fd = tun_open(self->ifname, flags, TUN_VNET_TNL_SIZE, features,
> +			    param_hwaddr_outer_src);
> +	ASSERT_GE(self->fd, 0);
> +}
> +
> +FIXTURE_TEARDOWN(tun_vnet_udptnl_proto)
> +{
> +	if (self->fd >= 0)
> +		close(self->fd);
> +	free(self->pkt);
> +}
> +
> +/* Build a 4in4 Geneve GSO frame whose outer ethertype is @l3proto,
> + * optionally behind an 802.1Q tag.
> + */
> +static int build_udptnl_frame(uint8_t *buf, bool vlan, uint16_t l3proto,
> +			      int payload_len)
> +{
> +	struct virtio_net_hdr_v1_hash_tunnel *vh = (void *)buf;
> +	int vlan_len = vlan ? 4 : 0;
> +	int hlen = ETH_HLEN + vlan_len + UDP_TUNNEL_GENEVE_4IN4_HDRLEN;
> +	uint8_t *outer_udph, *cur = buf;
> +	int pktlen;
> +

zero buffer. It is zeroed by calloc, but reused for multiple packets.

> +	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 1400,
> +						   AF_INET, AF_INET);
> +	vh->outer_th_offset += vlan_len;
> +	vh->inner_nh_offset += vlan_len;
> +	vh->hash_hdr.hdr.csum_start += vlan_len;
> +
> +	if (vlan) {
> +		uint16_t vlan_tag[2] = { htons(100), htons(l3proto) };
> +
> +		cur += build_eth(cur, ETH_P_8021Q, param_hwaddr_outer_dst,
> +				 param_hwaddr_outer_src);
> +		memcpy(cur, vlan_tag, sizeof(vlan_tag));
> +		cur += sizeof(vlan_tag);
> +	} else {
> +		cur += build_eth(cur, l3proto, param_hwaddr_outer_dst,
> +				 param_hwaddr_outer_src);
> +	}
> +
> +	pktlen = UDP_TUNNEL_GENEVE_4IN4_HDRLEN - sizeof(struct iphdr) +
> +		 payload_len;
> +	cur += build_ipv4_header(cur, IPPROTO_UDP, pktlen,
> +				 &param_ipaddr4_outer_dst,
> +				 &param_ipaddr4_outer_src);
> +
> +	outer_udph = cur;
> +	cur += build_udp_header(cur, UDP_SRC_PORT, VN_PORT,
> +				pktlen - sizeof(struct udphdr));
> +	cur += build_geneve_header(cur, VN_ID);
> +	cur += build_eth(cur, ETH_P_IP, param_hwaddr_inner_dst,
> +			 param_hwaddr_inner_src);
> +	cur += build_ipv4_header(cur, IPPROTO_UDP,
> +				 sizeof(struct udphdr) + payload_len,
> +				 &param_ipaddr4_inner_dst,
> +				 &param_ipaddr4_inner_src);
> +	cur += build_udp_packet(cur, UDP_DST_PORT, UDP_SRC_PORT, payload_len,
> +				AF_INET, false);
> +	build_udp_packet_csum(outer_udph, AF_INET, false);
> +
> +	return cur - buf;
> +}
> +
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
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, len);
> +}
> +
> +TEST_F(tun_vnet_udptnl_proto, outer_proto_bad)
> +{
> +	uint8_t *pkt = self->pkt;
> +	int len, ret;
> +
> +	/* Outer ethertype does not match the declared IPv4 tunnel. */
> +	len = build_udptnl_frame(pkt, false, ETH_P_IPV6, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* Outer header is not IP at all. */
> +	len = build_udptnl_frame(pkt, false, ETH_P_NSH, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* Same, behind a VLAN tag. */
> +	len = build_udptnl_frame(pkt, true, ETH_P_NSH, 2800);
> +	ret = write(self->fd, pkt, len);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +}
> +
>  FIXTURE(tun_vnet_udptnl)
>  {
>  	char ifname[IFNAMSIZ];
> -- 
> 2.53.0
> 


