Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178920;
	b=cvs/m/wvPUkMapJ2uNHRWmiuXfKNvj1uF963BTmqIAwhzNisXcpP6gT9spov/sdnqK3h
	 WyTQeLAgUJ22Q/adySdg+aXsxbtStBgXpFa0WLyYc+zE9epNJ0y5LEMYJd71fPzAHuE1s
	 xQCg7KS+xbXjTbJZxDjf96ToiOg5TwqUeVsFKzHmEx6xQQBo4kO7uwgM36PsdG1MjDKpB
	 85DnRgLzfSwzrgMNu+hcW43rejotKuzIvMvxPVRaZNR9kNgn8JmSKVJH2kb/Ifnje/5kP
	 ci8uwbNW/LI3u4S+W41zEDYNJpV2BuFJXENTKv6cfLBqpjc3SlijKcktE/zFGeY4LWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178920;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zKx5R6i9AUhGBVwnmAlpJmhnW8ZyYNcifeunGVtyNv8=;
	b=lpQoGvMeIQ3le617Up2cp5RPFA5KGNNoM6lGaGm+8ZmR+QR4nP3HfqxEVPd2ExyZCW1o
	 1vMids9mKOtAedNh9Nc+y8svTFX7WdMN3U14Z8lEwSLMXMzuududKPmBiElksDhp/+szb
	 c/GS7/Wq86VxIMtxCSbU9D23jGgFE4A9OLSrTdFuBvQrYZv76n/H3fgF9NPkh7LuYrtca
	 xgrYX/47nmCdga/SK9nuPk8sQOUj8l2ILtRkT5+e7F/0nHJYXG6vF3qVs4zhvPXjnqWC2
	 r4j6I3a5Lne7OJxwiZ1JEEDdezYgR9KRThBHO1vPGQnjOpRKLGXV9l3cndKWA2I3z/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaTAtZ8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E64606A322;
	Sun,  8 Nov 2026 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaTAtZ8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1385D1F008A1;
	Sun,  8 Nov 2026 23:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178919;
	bh=zKx5R6i9AUhGBVwnmAlpJmhnW8ZyYNcifeunGVtyNv8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RaTAtZ8sAQWwuJEHl9M5It5XhW8RlO9VqHObl6A+XPgdBH3jmiJOR3WoJ/uasmcNL
	 LbLWLGaABD4SOp6hDWe9Pi9yPGOWe5GzmZby4gmaSRQ7Cq0VlDZMI5QypU/vj7Zckp
	 YDH7Xw4op4RAkzKCYRm+CP2hhhnWqLiKbRhMO7SzHFawmqtLXVpBQ5WYU9sG3ab+6I
	 4VPiI/vHe6+nHa1WdZ+4gngRRtpse4UuJQjn40hJetD/bH5LnYUiszTFSTYdNN5zee
	 DK1kyfaK16C2AY5eCqVt6kxnm+/Zv8/ekrZUIyyMKjPot/kIBFmkj2PmDyWzLEdOxl
	 JO53p6qo0CVcQ==
Subject: Re: [PATCH net v3 2/8] net: virtio: do not use dev->type to find the
 outer L3 header
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, hassansultan@google.com,
 virtualization@lists.linux.dev
Date: Sun, 08 Nov 2026 23:01:58 +0000
Message-ID: <179417891864.994134.2460720079613864614@kernel.org>
In-Reply-To: <20261105115715.1466924-3-edumazet@kernel.org>
References: <20261105115715.1466924-3-edumazet@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net: virtio: outer_l3min includes ETH_HLEN in
  virtio_net_hdr_tnl_to_skb()

Pre-existing issues:
- [Medium] This patch makes Ethernet framing an explicit argument
  (`has_eth`), but virtio_net_hdr_tnl_to_skb() in…

--

net: virtio: do not use dev->type to find the outer L3 header

virtio_net_l3_start() used skb->dev->type to decide whether a frame
starts with an Ethernet header. tun can change that type with
TUNSETLINK, so this patch adds a has_eth argument to
virtio_net_hdr_tnl_to_skb() instead. Callers now pass true for
virtio_net and tun_xdp_one(), and pass whether the device is IFF_TAP
in tun_get_user().

Link: https://lore.kernel.org/netdev/179387332014.488856.9111956413610107951@kernel.org/

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e6011..3920b3dff1e84 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1944,7 +1944,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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
> index 357116c2a1489..b7b6b542f4763 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -452,6 +450,7 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> +			  bool has_eth,
>  			  bool tnl_hdr_negotiated,
>  			  bool tnl_csum_negotiated,
>  			  bool little_endian)
> @@ -505,7 +504,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	if (ret)
>  		return ret;
>  
> -	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +	if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th))
>  		return -EINVAL;

[Severity: Medium]
Now that the framing is passed in as has_eth, should the minimum outer
transport offset check earlier in virtio_net_hdr_tnl_to_skb() depend
on it as well? outer_l3min is still computed as ETH_HLEN +
virtio_l3min(outer_isv6), so outer_th must be at least 34 for IPv4 or
54 for IPv6, whatever has_eth says.

On an IFF_TUN device, tun_get_user() calls skb_reset_network_header()
and passes has_eth=false. virtio_net_l3_start() then returns nhoff = 0,
and virtio_net_l4_start() computes thoff = 20 for a plain IPv4 outer
header, or 40 for a plain IPv6 one. virtio_net_tnl_offsets_ok() then
requires outer_th == thoff, but the floor above has already rejected
both values.

As a result, the has_eth=false path only accepts frames whose outer L3
header is at least ETH_HLEN bytes longer than the minimum, such as IPv4
with options or IPv6 with extension headers. Would ordinary UDP tunnel
GSO frames written to an IFF_TUN fd get -EINVAL and be counted in
rx_frame_errors?

The transmit side of the same ABI produces exactly those offsets: in
TUN mode virtio_net_hdr_tnl_from_skb() fills outer_th_offset from
skb->transport_header - skb_headroom(skb), which is 20 for an L3-first
IPv4 frame. set_offload() also enables NETIF_F_GSO_UDP_TUNNEL without
looking at IFF_TAP or IFF_TUN, so IFF_TUN devices reach this path.

This isn't introduced by this patch, but since has_eth is now available
here, would something like this work?

	outer_l3min = (has_eth ? ETH_HLEN : 0) +
		      virtio_l3min(outer_isv6);

[Severity: Medium]
This isn't a bug introduced by this patch, but now that the framing is
passed in as has_eth, should the minimum outer transport offset in
virtio_net_hdr_tnl_to_skb() depend on it too? That check comes earlier
in the same function and still assumes an Ethernet header:

include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb() {
    ...
	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
    ...
	if (outer_th < outer_l3min ||
	    inner_nh < outer_th + sizeof(struct udphdr) ||
	    inner_th < inner_nh + inner_l3min)
		return -EINVAL;
    ...
}

On an IFF_TUN device, tun_get_user() resets the network header and
passes has_eth=false. virtio_net_l3_start() then returns nhoff = 0, and
virtio_net_tnl_offsets_ok() requires outer_th == thoff. For a plain
outer header, thoff is 20 for IPv4 and 40 for IPv6. The floor above has
already rejected both values, since it is 34 or 54.

As a result, the has_eth=false path only accepts frames whose outer L3
header is at least ETH_HLEN bytes longer than the minimum, such as IPv4
with options or IPv6 with extension headers. Would ordinary UDP tunnel
GSO frames written to an IFF_TUN fd get -EINVAL and be counted in
rx_frame_errors?

The transmit side of the same ABI seems to produce exactly those
offsets. In TUN mode, tun_put_user() ends up in
virtio_net_hdr_tnl_from_skb(), which writes:

	outer_th = skb->transport_header - skb_headroom(skb);
	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
	vhdr->outer_th_offset = cpu_to_le16(outer_th);

For an L3-first frame, that gives 20 for IPv4. Also, set_offload() in
tun.c enables NETIF_F_GSO_UDP_TUNNEL without checking IFF_TAP or
IFF_TUN, so IFF_TUN devices can reach this receive path.

The selftest commit in this series also mentions the limitation: "The
outer IPv4 header carries options, as virtio_net_hdr_tnl_to_skb()
expects room for an Ethernet header before the outer transport header."

Would something like this work here?

	outer_l3min = (has_eth ? ETH_HLEN : 0) + virtio_l3min(outer_isv6);

>  
>  	/* In case of USO, the inner protocol is still unknown and

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105115715.1466924-1-edumazet%40kernel.org
