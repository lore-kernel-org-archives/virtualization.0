Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA6849F11B;
	Wed,  2 Sep 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354753; cv=none; b=RYyckt8FYW4At2OgHSbtFuVGIMi4qElUxNMONORfl6JmaSNcXZPkfgD/SWkHEUOL56DDaMA+rKdROSALSX/F9R7Ly8kGWPvdlJv8F/MKiYbeJfNfRcMEGpR2P8zFobIBfKtyqT72Sa44/tDh3tuk2F14fYLhK4WZbhrbqXmpY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354753; c=relaxed/simple;
	bh=/b6s6kbiIIJqUgWR5egBxvs7KWj6Aa/oXEG6A+/0NhA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BInrYOlkDJIRgZiU5poH+Bb7pnxGBLOLyq+e0M1XjNLY2G/gPox156ai4BFNzISa3Qwkd1PWgyS/yqZ0aLHLg4o36otBHPVE27oLS/dt6NaOlPXvyQOnVIRfN2F9yZhPyTlOD5ML/zkdp1W8glhTYs1hEE7oc5i+O6KHxCm7sGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnxfuuOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnxfuuOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9659A1F00A3A;
	Wed,  2 Sep 2026 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354751;
	bh=mwHz6x6NRZoC/DVSl0Mn+g8LkE5Lxr1GgmcatYFCqes=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WnxfuuOPKhgZOj1+1+p1tB9QrZJBYOAihrZ4CWD96wBG0hC2k4uteFsxhNp2HiCdR
	 U+IasImatEb/d2hpBUIGIxJI4gmb6MirGWPi0TQsUtRCqWDX1RDrRPWpHY1KZORBLW
	 wQhs99YT+GvDMe+ifj6e/TkJuHGm85D9zZTabIOvgOo4h/379uO4TcYuSzAZLFTzba
	 PpdCj8MUSBN3vg7tSK3j/YZLG4UV99fWHkhh2H3OAxYgmbxgJPkgkP6jhDHvP9H6iD
	 UyFcmEXxiEih9ljLDakqcZz2hQ9e6537XoaF51UiELndXOJzGBqUTPKjoYpX7tMGe5
	 4V6adOc4pLMAQ==
Subject:
 Re: [net-next,v23,12/14] virtio_net: Add support for IPv6 ethtool steering
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:30 +0000
Message-ID: <178835475012.3394541.15260297346389800429@kernel.org>
In-Reply-To: <20260831161109.2999926-13-shshitrit@nvidia.com>
References: <20260831161109.2999926-13-shshitrit@nvidia.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The new IPv6 code overlays `struct ipv6hdr` (alignment 4, from
  the embedded struct in6_addr / __be32 s6_addr32[]) on byte-packed…
- [Low] Commit message claims "Implement support for IPV6_USER_FLOW type
  rules" but the implementation only supports src-ip/dst-ip matching:…

--

virtio_net: Add support for IPv6 ethtool steering

This adds IPV6_USER_FLOW support to the virtio_net ethtool flow filter
code: a new validate_ip6_mask() for the IPv6 selector mask, a new
parse_ip6() to build the key/mask pair, and IPv6 handling in
setup_ip_key_mask(), supported_flow_type() and calculate_flow_sizes().

Two questions below, one about alignment of the new IPv6 accesses and one
about the scope described in the changelog.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c33bbdda75590..bfe8f0bc2581a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5843,6 +5843,40 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
>  	return true;
>  }
>  
> +static bool validate_ip6_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct in6_addr tmp;
> +	struct ipv6hdr *cap, *mask;
> +
> +	cap = (struct ipv6hdr *)&sel_cap->mask;
> +	mask = (struct ipv6hdr *)&sel->mask;
> +
> +	/* mask->saddr/daddr may be unaligned; copy to aligned tmp for
> +	 * ipv6_addr_any().
> +	 */
> +	memcpy(&tmp, &mask->saddr, sizeof(tmp));
> +	if (!ipv6_addr_any(&tmp) &&
> +	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
> +			       sizeof(cap->saddr), partial_mask))
> +		return false;
> +
> +	memcpy(&tmp, &mask->daddr, sizeof(tmp));
> +	if (!ipv6_addr_any(&tmp) &&
> +	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
> +			       sizeof(cap->daddr), partial_mask))
> +		return false;
> +
> +	if (mask->nexthdr &&
> +	    !check_mask_vs_cap(&mask->nexthdr, &cap->nexthdr,
> +			       sizeof(cap->nexthdr), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +

[ ... ]

> @@ -5884,11 +5921,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  	}
>  }
>  
> +static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> +		      const struct ethtool_rx_flow_spec *fs)
> +{
> +	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
> +	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
> +
> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
> +		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
> +		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
> +	}
> +
> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
> +		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
> +		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
> +	}
> +}

[Severity: Medium]
Are the destinations of these copies guaranteed to be 4-byte aligned?

struct in6_addr contains __be32 s6_addr32[4], so struct ipv6hdr has
4-byte alignment, but the buffers these pointers overlay are byte packed
in the virtio flow filter layout:

  build_and_insert() -> setup_ip_key_mask(next_selector(selector),
                                          key + sizeof(struct ethhdr), fs)

For the classifier mask, the first selector is an 8-byte
struct virtio_net_ff_selector header plus a 14-byte struct ethhdr mask,
so the second selector starts at obj+30 and its mask[] at obj+38, which
makes &v6_m->saddr land at obj+46, i.e. 2 mod 4. The key buffer is the
same: it is offset by sizeof(struct ethhdr), so &v6_k->saddr is
base+22, again 2 mod 4.

The IPv4 sibling in the same file goes through the unaligned helpers for
exactly these members:

drivers/net/virtio_net.c:parse_ip4() {
	if (l3_mask->ip4src) {
		put_unaligned(l3_mask->ip4src, &mask->saddr);
		put_unaligned(l3_val->ip4src, &key->saddr);
	}
	...
}

and validate_ip4_mask() uses get_unaligned(&mask->saddr) for the read
side. Since the pointer expressions here are typed struct in6_addr *,
can the compiler expand these 16-byte copies into word or multi-word
accesses (for example LDRD/STRD or LDM/STM on 32-bit ARM) on an address
that is 2 mod 4, and fault on strict-alignment architectures?

The comment in validate_ip6_mask() already notes "mask->saddr/daddr may
be unaligned", but the aligned tmp only fixes the destination of that one
copy; the source (&mask->saddr) and the copies in parse_ip6() are still
misaligned accesses through a 4-byte-aligned pointer type. Would using
the unaligned accessors, or plain u8 pointers, for these fields keep the
IPv6 path consistent with the IPv4 one?

[ ... ]

> @@ -6114,20 +6179,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
>  			     const struct ethtool_rx_flow_spec *fs)
>  {
> +	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> +	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
>  	struct iphdr *v4_k = (struct iphdr *)key;
>  
> -	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> -	selector->length = sizeof(struct iphdr);
> +	if (has_ipv6(fs->flow_type)) {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
> +		selector->length = sizeof(struct ipv6hdr);
> +
> +		/* exclude tclass, it's not exposed directly in struct ipv6hdr */
> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip6_spec.tclass ||
> +		    fs->m_u.usr_ip6_spec.tclass ||
> +		    fs->h_u.usr_ip6_spec.l4_proto ||
> +		    fs->m_u.usr_ip6_spec.l4_proto)
> +			return -EINVAL;
>  
> -	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> -	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> -	    fs->m_u.usr_ip4_spec.ip_ver ||
> -	    fs->m_u.usr_ip4_spec.proto)
> -		return -EINVAL;
> +		parse_ip6(v6_m, v6_k, fs);

[Severity: Low]
This isn't a bug, but should the changelog say which ip6 match fields are
actually implemented?

The commit message says:

    Implement support for IPV6_USER_FLOW type rules.

but setup_ip_key_mask() rejects any non-zero tclass, l4_proto or
l4_4_bytes, in the value as well as in the mask, and parse_ip6() only
ever fills in saddr/daddr. So of the struct ethtool_usrip6_spec fields
only the addresses work, while supported_flow_type() advertises
IPV6_USER_FLOW as a whole:

	case IPV6_USER_FLOW:
		return true;

A request such as:

    ethtool -U ens9 flow-type ip6 src-ip fe80::2 tclass 8 action 3

fails with "Invalid argument" and there is nothing in the log describing
the limitation.

There is also an asymmetry with the IPv4 support added in the previous
patch: parse_ip4() does translate the IPv4 tos field:

	if (l3_mask->tos) {
		mask->tos = l3_mask->tos;
		key->tos = l3_val->tos;
	}

while the IPv6 path refuses the equivalent tclass, even though
struct ipv6hdr carries the traffic class in the priority/flow_lbl bits.
Could the changelog mention that only src-ip/dst-ip matching is
supported for ip6 flows, and why tclass parity with the IPv4 path is not
provided?

> +	} else {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +		selector->length = sizeof(struct iphdr);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
