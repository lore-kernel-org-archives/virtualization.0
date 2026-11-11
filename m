Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436913;
	b=Oevj+tMmYN9KTkgzlwaDXoK/uVydfynWWH8il67TPv1gg39sPaSyiAkUdMD1bzQGvMFk
	 lYldj/f0N42VLaSPeQR6B/IQdtQbUXDsAJuEa38/Xe9Iz2CLzNLJFDVX2+X9n0c/bgVVg
	 2IRv6GfWZIE5SvBrk8Kg6VBEfGHomhAmkvGcQet8FTHa43+bIe78dqk7CoOUd8HafymsW
	 5DT65Vdjv1lGqbHKBUMu0ozKcrJ7SpXkOLJKNYdPl+pex/ihUE+lT8RP0i7pXUzOtl9bI
	 Sia99CGulubR26dNHhRWweRLGohwsGe7Nwr8emCeZAdLkFKpAIdx+kEHtHKAEJwHOgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436913;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gPlb9TY3yxqLP5R0MkTTx3agLLAuMLawgbEDKwXS9tY=;
	b=FUCDUuyAP/n75AR2x57cAid4tGTlidK8st+ikIgPr0ZvQSvBDAZRC6LmdNVt1hB3yfeg
	 4JH0oc76CLPLPDaW37Jj+3y2Q40qmki4DVVEIxd4Zvjbh1vphULkQTyE8pU5r3lisqV2O
	 NmqLwcfjzxZcfL9wdyz+RqniQO0D6+eyXJ+87w8IdhbG3ySBcez/0Qc/I7guwUjrIp0oP
	 ZKv1/gfzIf+eratfJeInUGXUy/ciqkyDHVJx0xoW9UfBT4LtdpO87IkwQuVVXa16/heox
	 upd9aNroolyOem1E1KfuA1jcQ39fiR5SlfEVOa8j0ZLoa425BRX7aldhEPZSKifPvIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOhTmFK0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7BE606A8B9;
	Wed, 11 Nov 2026 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOhTmFK0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367371F00A05;
	Wed, 11 Nov 2026 22:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436912;
	bh=gPlb9TY3yxqLP5R0MkTTx3agLLAuMLawgbEDKwXS9tY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LOhTmFK0LIFpKGZSMhQVkNEaxjnUJRldr8arnonmKn0utY76gZOMAPTGPrq4dErEx
	 ZQmMQj7/jWfSb3gzRatKzGU3w8N9fQJ0VLN0kM+q7wGrWKkmUxBKHmDX8Kad9w9OKM
	 A5fHAK5rM74FOvKPYRJoouI3VOc3OZIodQTchyN03LJHyuKpyocZf3/6derXP0wykO
	 xDHMY9tSuhlT6RqCGNDtkAHq732YRz+TUt4NDnQQ4EJ4op5E+l48t25WEp0wfeVyhr
	 o/xDZb73HscM73YhkdoCzcu5x0HDekO6gYPItm6+hEqumlVjneBZ8/TgZ1DHDmchN9
	 S/Jl1DZ5WXE3A==
Subject: Re: [PATCH net v6 3/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, willemb@google.com, horms@kernel.org, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 hassansultan@google.com, virtualization@lists.linux.dev
Date: Wed, 11 Nov 2026 22:41:51 +0000
Message-ID: <179443691180.2199510.148246238688217560@kernel.org>
In-Reply-To: <20261110213628.3476051-4-edumazet@kernel.org>
References: <20261110213628.3476051-4-edumazet@kernel.org>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new has_eth=false path in virtio_net_hdr_tnl_to_skb()
  (include/linux/virtio_net.h) rejects almost every valid frame, so it…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a
  sibling of the injection the patch closes.

--

net: virtio: validate outer protocol of UDP tunnel GSO packets

This patch makes virtio_net_hdr_tnl_to_skb() check that a UDP tunnel GSO
frame really carries the outer IPv4 or IPv6 header it claims, with UDP at
outer_th_offset. Callers now pass a has_eth argument that says whether the
frame starts with an Ethernet header. tun_get_user() passes false for
IFF_TUN devices.

Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d1fcb25ab026b..ced5a1596e609 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1950,7 +1950,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		break;
>  	}
>  
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
> +				    (tun->flags & TUN_TYPE_MASK) == IFF_TAP)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err = -EINVAL;
>  		goto free_skb;

[ ... ]

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 83f801ff57006..fc9667176f23c 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -338,6 +504,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	if (ret)
>  		return ret;
>  
> +	if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th))
> +		return -EINVAL;
> +

[Severity: Medium]
Can the has_eth == false path be reached by ordinary IFF_TUN frames?

On IFF_TUN, tun_get_user() resets the network header to offset 0 and now
passes has_eth == false. virtio_net_l3_start() then takes the L3 header
from skb_network_offset(), so virtio_net_tnl_offsets_ok() needs outer_th
to be 20 for a plain IPv4 outer header, or 40 for plain IPv6.

Earlier in virtio_net_hdr_tnl_to_skb(), the offset floor still assumes a
14-byte Ethernet header, whatever has_eth says:

	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
	...
	if (outer_th < outer_l3min ||
	    inner_nh < outer_th + sizeof(struct udphdr) ||
	    inner_th < inner_nh + inner_l3min)
		return -EINVAL;

So an outer_th of 20 or 40 fails against 34 or 54 before the new check
runs. The only IFF_TUN frames that can pass both checks have IPv4 options
(ihl >= 9) or at least 14 bytes of IPv6 extension headers.

On the TX side, virtio_net_hdr_tnl_from_skb() computes outer_th relative
to skb->data:

	outer_th = skb->transport_header - skb_headroom(skb) + vlan_hlen;

On IFF_TUN, skb->data points at the IP header, so this emits 20 or 40.
set_offload() also enables NETIF_F_GSO_UDP_TUNNEL without checking the
device type. As a result, IFF_TUN devices advertise tunnel GSO, but their
ordinary tunnel GSO frames get -EINVAL and increment rx_frame_errors.

The ETH_HLEN floor predates this patch and comes from a2fb4bc4e2a6.
However, the commit message relies on the has_eth == false path:

  "tun_get_user() passes whether the device is IFF_TAP."

Should outer_l3min follow has_eth, for example:

	outer_l3min = (has_eth ? ETH_HLEN : 0) + virtio_l3min(outer_isv6);

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but it is
closely related to the injection fixed here. Plain (non-tunnel) GSO
frames return early and never reach the new check:

	gso_tunnel_type = hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL;
	if (!gso_tunnel_type)
		return virtio_net_hdr_to_skb(skb, hdr, little_endian);

In __virtio_net_hdr_to_skb(), the VIRTIO_NET_HDR_F_NEEDS_CSUM branch only
checks pskb_may_pull(), skb_partial_csum_set() and the transport offset
against nh_min_len. virtio_net_hdr_match_proto() and the flow dissector
run only in the branch without NEEDS_CSUM.

So can a tap writer, or a guest via vhost-net, still send an Ethernet
frame with ethertype ETH_P_NSH, gso_type TCPV4, TCPV6 or UDP_L4, and
NEEDS_CSUM set? eth_type_trans() would then set skb->protocol to
ETH_P_NSH.

Suppose such a frame is forwarded, by a bridge or tc mirred, to a device
that segments in software. Could the segmentation then recurse without
limit?

skb_mac_gso_segment()
  nsh_gso_segment()
    proto = tun_p_to_eth_p(nsh_hdr(skb)->np);   /* TUN_P_NSH -> ETH_P_NSH */
    __skb_pull(skb, nsh_len);
    skb->mac_len = proto == htons(ETH_P_TEB) ? ETH_HLEN : 0;
    skb_mac_gso_segment()
      nsh_gso_segment()
        ...

Neither nsh_gso_segment() nor skb_mac_gso_segment() limits the depth.
Commit 006c8b834aed ("net: gso: limit recursive IP-in-IP segmentation")
added the SKB_GSO_CB(skb)->recursion_counter check in
gso_recursion_inc_test(). It is called only from inet_gso_segment() and
ipv6_gso_segment().

A frame of about 64KB made of stacked 8-byte NSH headers could recurse
thousands of levels deep and overflow the kernel stack.
TUN_P_ETHERNET -> ETH_P_TEB -> NSH appears to be a second route into the
same recursion.

Should nsh_gso_segment() use gso_recursion_inc_test()? Or should the
plain NEEDS_CSUM path also validate the outer protocol?

>  	/* In case of USO, the inner protocol is still unknown and
>  	 * `inner_isv6` is just a guess, additional parsing is needed.
>  	 * The previous validation ensures that accessing an ipv4 inner

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110213628.3476051-1-edumazet%40kernel.org
