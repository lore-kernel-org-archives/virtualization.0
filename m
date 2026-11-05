Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873323;
	b=hJB2XbMXTExszyuhJwyRnDsRJnmhXipCOMTYl7LYlhHIrz+vMnXXvPkFWXGH1MIXJFcW
	 htBP8ollc7GSmUXw+BWATSrTNel0wc23Os4/xyu+YHjuVZjvvb9/F7of6vWbkScqYFgN6
	 EQoy4UXxBPoiCoJh6aktD3bYzUmwGF67Wa6LFQvF7eGLaAfHwxktH5bGNkF5/t8713kXo
	 tMJqF52KKyeIWZClB1mq2PWWx7WEY1CpE23N8yrDGPNVHqt660uRigbNXePyNLUw8bXd8
	 GnPu/Ogq8I2dOmsTArLpsnScdIKwswvnu6coxjbQaZ02hiqXXo6R1cg2Aw5x5WjKtoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873323;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1m2BkGSmJW9g/I7g3XHucs0qjlE/laWWEx9Emt7M2sI=;
	b=qYNcp41UDx5nJ3nfWWhjmo8hwIpNwWRGS+W49TwpA/ECMIoqmkZpYD1c65gDR5JdvzGI
	 6/KyChMHr+CPWO9PaAJ7J8c1QbCydZYooS3TwVvTelvPfiddfs7vrFMMH3G5ihZxlUhPv
	 qkAsm+mE7GuLiAqlWv9cFEtTqwlQmf6PvuA7wkuBL1OTZshvgCczqwNCDWd14bS+aECqc
	 P3QkhUoljo/jgtAW09eYCSSChgZe20R86hOz7BMkAwUtrWR2nEp3n25y9G/Ov/TjSODiX
	 7/6Njq8goMakYqUJXoWGdjmNw09qRMKlrwwL6uW7xe7F0yVuN5pN7MzRI1vMX2m9r3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFFnh7MF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F0606EE86;
	Thu,  5 Nov 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFFnh7MF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05831F000C1;
	Thu,  5 Nov 2026 10:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793873322;
	bh=1m2BkGSmJW9g/I7g3XHucs0qjlE/laWWEx9Emt7M2sI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VFFnh7MFZMGhqhdw6TWxETCDX6K6hGqGYOWmD9HR1XxbnwvWLflaO7BjNpG8cMSuG
	 XT/sSCcg1xNli6cgNQGW7GO2yD1HXtBy9WQb/dKBqNYOCYc+pAQ0DGFpIDhjnZw08Z
	 VPvCjrae3AqzvwlVcul/ov5YuTq4mZCt5iHPgDv+pjvBAli0G0Kaw1NPfJfQv+djMS
	 IpJR3YLPPR7xJtkPxFBbVh8rY4/eYWxP8ucksLqoqRD+j+dkhDHmWWj3KRhSGblP6x
	 NoJld2OsnhjmVARXpgJvQjkySnr7fjVzGIUMkVLsjVK1MtLmzLkl/lb+eWs/CkxHyn
	 AeTDUOozYq7sQ==
Subject: Re: [PATCH net v2 3/3] selftests: net: tun: test outer protocol of
 UDP tunnel GSO packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 eperezma@redhat.com, hassansultan@google.com, virtualization@lists.linux.dev
Date: Thu, 05 Nov 2026 10:08:41 +0000
Message-ID: <179387332145.488856.1149073246990672028@kernel.org>
In-Reply-To: <20261104050131.629967-4-edumazet@kernel.org>
References: <20261104050131.629967-4-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new tun_vnet_udptnl_proto and tun_vnet_udptnl_proto_l3
  tests do not work on big-endian hosts.
- [Low] The new comment in virtio_net_l4_start()
  (include/linux/virtio_net.h) says the code does something it does not.

--

selftests: net: tun: test outer protocol of UDP tunnel GSO packets

This adds tun selftests that write single 4in4 Geneve GSO frames to tap
and IFF_TUN devices with UDP tunnel offloads enabled. They check that
frames with a matching outer IPv4 header are accepted. They also check
that a mismatched outer ethertype, tun_pi protocol or IP version is
rejected with EINVAL.

> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index 34de2580e32ec..81410afbbcc8d 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -683,6 +683,275 @@ TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum_64k)

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
> +	/* The buffer is reused: do not leave bytes from a previous frame. */
> +	memset(buf, 0, TUN_VNET_TNL_SIZE + hlen + payload_len);
> +
> +	cur += build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 1400,
> +						   AF_INET, AF_INET);
> +	vh->outer_th_offset += vlan_len;
> +	vh->inner_nh_offset += vlan_len;
> +	vh->hash_hdr.hdr.csum_start += vlan_len;

[Severity: Medium]
Do these new tests work on big-endian hosts? In struct
virtio_net_hdr_v1_hash_tunnel, outer_th_offset and inner_nh_offset are
__le16. Here they get native-endian arithmetic, applied on top of the
host-order values that build_virtio_net_hdr_v1_hash_tunnel() in
tuntap_helpers.h already wrote:

    vh_tunnel->outer_th_offset = eth_hlen + outer_iphlen;
    vh_tunnel->inner_nh_offset = vh_tunnel->outer_th_offset + ETH_HLEN +
                                 GENEVE_HLEN + sizeof(struct udphdr);

The kernel always decodes the tunnel offsets as little-endian. csum_start,
on the other hand, follows the tun vnet endianness:

include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb() {
    ...
    inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
    inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
    outer_th = le16_to_cpu(vhdr->outer_th_offset);
    if (outer_th < outer_l3min ||
        inner_nh < outer_th + sizeof(struct udphdr) ||
        inner_th < inner_nh + inner_l3min)
        return -EINVAL;
    ...
}

tun_open() never issues TUNSETVNETLE. On s390x or BE ppc64, csum_start is
therefore read in host order, but outer_th 34 is read as 0x2200 and
inner_nh 64 as 0x4000. The offset check above then returns -EINVAL before
virtio_net_tnl_offsets_ok() is reached.

Wouldn't outer_proto_ok then fail on BE? And wouldn't outer_proto_bad
pass there without ever reaching the new outer protocol validation?

build_udptnl_l3_frame() does the same:

    vh->outer_th_offset += IPV4_OPT_LEN;
    vh->inner_nh_offset += IPV4_OPT_LEN;

The helper's host-order writes predate this patch, and the existing
tun_vnet_udptnl tests share the problem. Could these fields be converted
with htole16()/le16toh() here and in the helper?

> +
> +	if (vlan) {
> +		uint16_t vlan_tag[2] = { htons(100), htons(l3proto) };

[ ... ]

The following is about the first patch in this series, commit
fca58b5faf90 ("net: virtio: validate outer protocol of UDP tunnel GSO
packets"), which adds the code that the outer_proto_bad tests exercise.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..b9c8babb1fd73 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> +	if (proto == htons(ETH_P_IPV6)) {
> +		const struct ipv6hdr *iph;
> +		int flags = IP6_FH_F_AUTH;
> +
> +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> +			return false;
> +		iph = (const void *)(skb->data + nhoff);
> +		if (iph->version != 6)
> +			return false;
> +		*thoff = nhoff + sizeof(*iph);
> +		*ip_proto = iph->nexthdr;
> +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> +			*thoff = nhoff;
> +			/* Find the transport header behind any
> +			 * extension headers, AH included.
> +			 */
> +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> +						  &flags);

[Severity: Low]
This isn't a bug, but does this comment in virtio_net_l4_start() match
what ipv6_find_hdr() does with these arguments? With flags = IP6_FH_F_AUTH
and target = -1, it stops at the AH header instead of walking past it:

net/ipv6/exthdrs_core.c:ipv6_find_hdr() {
    ...
    } else if (nexthdr == NEXTHDR_AUTH) {
        if (flags && (*flags & IP6_FH_F_AUTH) && (target < 0))
            break;
    ...
}

So for an outer IPv6 header followed by AH, ip_proto comes back as
NEXTHDR_AUTH and virtio_net_tnl_offsets_ok() rejects the frame. The commit
message says this is intended:

  Unlike the original helpers, ipv6_find_hdr() stops at an AH header,
  as Willem suggested in the review of that series.

Could the comment say that the walk stops at AH?

> +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> +				return false;
> +		}
> +		return true;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104050131.629967-1-edumazet%40kernel.org
