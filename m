Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467041A9F85;
	Wed,  2 Sep 2026 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354751; cv=none; b=fIGFcAUsYI0G2fZKhYaWoV+B568FJZAbtW7N/fIo0+UvpROBZeItri1NZhtQteff+iWru1nn90yOgVOoagHPRdBl17u7RdBZZ1wvfQJg1vIqUPChj38LoLPY2Rz0Be7tD1leNto2Yiod2/h+VkFZ7Xz/46HRz3MN+kYBIzLvW/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354751; c=relaxed/simple;
	bh=YWGe/A6UfxXhxw+1QTxNWnRgOVPiaxQ748NdXH/5B28=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiqy0DxYch5UudUjpk1w6DMgBRMRkrrUmf+A/ZzyaxjF4vQU6sEwz1hu5f2qY+NmQjFLzySoQYULmmwnM6JguQmjlTnWVeIXbfH4QN6kHquV0JzPETEjld2LyRak+OsWs6qgAulhzpRsVirm8zDBPsuVxOZWcZ4jyAeq0hI9tQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPyp64+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPyp64+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8131F00A3D;
	Wed,  2 Sep 2026 13:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354750;
	bh=JTOML5jIOL1orF9DnrYwAuCBj853upYavK7uXMfYR5c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GPyp64+1XF3RvCXsBVep7e+xI0Uy/MWaM9pwfE2yFOt3YNEqt1ZjNfChYRI6IFzTw
	 ezo8vfmfo4nl2Ob69WRbJTEh824nygw8ms19ASgWBpQ1u5CXzMETYHEH6xsO2IffN0
	 hS7AHe1WfhS/5JdKv+V9aerao3eYe1QpKIoseZyurgy5ySvJB2QJ+20E973luUxxcf
	 fF4DwWZqRPU2Kl6hOeeBnH7Hi8XyKsX1mgpneS03edd752GxtdDSH1eZAcpxWukTdq
	 Ws6qGJzAoh2Jb15KpFI1WOb0gLwYQBTSXEORPMaC3nRAZoSetTJXpNdcBCkyugFpV2
	 Z1YxrzRSiqjnQ==
Subject:
 Re: [net-next,v23,11/14] virtio_net: Implement IPv4 ethtool flow rules
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:28 +0000
Message-ID: <178835474877.3394541.3251614086995049997@kernel.org>
In-Reply-To: <20260831161109.2999926-12-shshitrit@nvidia.com>
References: <20260831161109.2999926-12-shshitrit@nvidia.com>
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

- [Medium] IP_USER_FLOW support silently ignores the ethtool `proto`
  match field.
- [Low] While adding the `int num_hdrs` parameter, the patch also de-
  indents the two pre-existing continuation lines of…

--

virtio_net: Implement IPv4 ethtool flow rules

This adds support for ethtool IP_USER_FLOW rules to the virtio_net flow
filter code, building an extra IPv4 selector after the ethernet selector
and matching on source/destination address and tos. The ethernet selector
is forced to match ethertype IPv4 whenever an IPv4 header follows.

(No Link: tags in the commit header.)

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6c07eab047afe..c33bbdda75590 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -5809,6 +5810,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
>  	return true;
>  }
>  
> +static bool validate_ip4_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{

[ ... ]

> +	if (mask->protocol &&
> +	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
> +			       sizeof(u8), partial_mask))
> +		return false;
> +

[ ... ]

> @@ -5820,11 +5854,41 @@ static bool validate_mask(const struct virtnet_ff *ff,

[ ... ]

> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> +		      const struct ethtool_rx_flow_spec *fs)
> +{
> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
> +
> +	if (l3_mask->ip4src) {
> +		put_unaligned(l3_mask->ip4src, &mask->saddr);
> +		put_unaligned(l3_val->ip4src, &key->saddr);
> +	}
> +
> +	if (l3_mask->ip4dst) {
> +		put_unaligned(l3_mask->ip4dst, &mask->daddr);
> +		put_unaligned(l3_val->ip4dst, &key->daddr);
> +	}
> +
> +	if (l3_mask->tos) {
> +		mask->tos = l3_mask->tos;
> +		key->tos = l3_val->tos;
> +	}
> +}

[ ... ]

> @@ -6016,8 +6091,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  }
>  
>  static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
> -				   u8 *key,
> -				   const struct ethtool_rx_flow_spec *fs)
> +				  u8 *key,
> +				  const struct ethtool_rx_flow_spec *fs,
> +				  int num_hdrs)

[Severity: Low]
This isn't a bug, but the two pre-existing continuation lines lost one
space of indentation here while the new num_hdrs parameter was added.
"static void setup_eth_hdr_key_mask(" puts the open parenthesis one column
further right, so the continuation lines no longer line up with it and
checkpatch reports "Alignment should match open parenthesis". Was the
re-indent intentional? Only the "int num_hdrs" line seems to need
touching. The same alignment persists through the end of the series.

>  {
>  	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
>  	struct ethhdr *eth_k = (struct ethhdr *)key;
> @@ -6025,8 +6101,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,

[ ... ]

> +static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
> +			     u8 *key,
> +			     const struct ethtool_rx_flow_spec *fs)
> +{
> +	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> +	struct iphdr *v4_k = (struct iphdr *)key;
> +
> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +	selector->length = sizeof(struct iphdr);
> +
> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> +	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> +	    fs->m_u.usr_ip4_spec.ip_ver ||
> +	    fs->m_u.usr_ip4_spec.proto)
> +		return -EINVAL;
> +
> +	parse_ip4(v4_m, v4_k, fs);
> +
> +	return 0;
>  }

[Severity: Medium]
What happens to h_u.usr_ip4_spec.proto here? Every other unsupported
IPv4 field is rejected, but a non-zero h_u.usr_ip4_spec.proto is neither
rejected nor programmed.

include/uapi/linux/ethtool.h documents the field for struct
ethtool_usrip4_spec as:

 * @proto: Transport protocol number; mask must be 0

So a conforming userspace passes the protocol in h_u with a zero mask in
m_u, which is exactly the combination that passes all five checks above.
parse_ip4() then only copies ip4src, ip4dst and tos, leaving
key->protocol and mask->protocol zero in the zeroed key/classifier
buffers.

Does this mean

  ethtool -U ethX flow-type ip4 src-ip 192.168.51.101 l4proto 6 action -1

installs a rule that matches ethertype IPv4 plus src-ip only, and
therefore drops every protocol from that address rather than just TCP,
without returning an error? Would it be better to either program
iphdr->protocol from h_u.usr_ip4_spec.proto, or return -EINVAL when it is
non-zero?

There also seems to be a disagreement between the two new functions: the
protocol check in validate_ip4_mask()

	if (mask->protocol &&
	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
			       sizeof(u8), partial_mask))
		return false;

looks unreachable for IP_USER_FLOW, since a non-zero
m_u.usr_ip4_spec.proto always returns -EINVAL in setup_ip_key_mask()
first and parse_ip4() never sets mask->protocol. Is that intended?

Checking the rest of the series, at 04f0a1ab the behaviour looks
unchanged: setup_ip_key_mask() still returns -EINVAL for
m_u.usr_ip4_spec.proto with num_hdrs == 2, parse_ip4() still never writes
iphdr->protocol, and the protocol key is only filled in for
TCP_V4_FLOW/UDP_V4_FLOW.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
