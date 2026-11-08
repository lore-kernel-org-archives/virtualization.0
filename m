Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178921;
	b=LxnI+gj0+5H7Xkg18vatqbcG67vCIZlvLDD+i3IyltUt8eWLCB3EJ1f8cqC3Fnf/to/3
	 t6Mrn0kBVFiKJoGmsK9vdPQ7OgaWVKE8i5g6Z/YAd1YvWxg1R1AsNGOPiGsEq0yW0wVbu
	 +c8BHGQxN6l3b8RCt9zO1DMoJkCXPoxUz1UtPOKubpPvS/gmNb3zi5vwkQ98LzgVwUM9X
	 Y4qwuCdp0UhJI+8hWyKE0TzPUPjIJUwZJCKj9lAmLU7GZxyo9vg/cjInBr5YfEUkWAvBT
	 s0ECmhr1pZ7X+k+IY8eiGPaIC5uG6bLGoR+Gy0TRcypNVLXIodIVGVQSFx4NZAvYS9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178921;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dT/ct1xKJReQWJT7zL9ejsPw2m4cZVlBXXqSgJ273bg=;
	b=ynWM9YRj10lvkLLehi+ipVcKcp4nhbogzoDTnhBUMKUOsz2NqC5udP7+v7inTMY15Ojq
	 RJecjphHwtARCjVZUC387PmrwMV3ODcDhZ6SToHTAM5jTaVWTFjIgu/yEJj7CHIukWHUN
	 9w3C5jx+OVG+wv+rKy0ZE2pPhYqsdXXUbhyB7wYADEKJSN2uDHy9NurdBpZp4mlt/GSDW
	 4upHQnX3+yZCeGd2Qf4M+508QfBTL8x2bFXYrevqD3uBzfEf1T816dhGPX2ZCIgeoUcg2
	 R8uqqp+4u51IMEQmSnO9Hm8LTAJA9jCVLKYXwfynJO56kxm0lWgnb8jvPe63medHtng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbOQ5rKa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28931606A326;
	Sun,  8 Nov 2026 23:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbOQ5rKa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEAF1F0089F;
	Sun,  8 Nov 2026 23:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178921;
	bh=dT/ct1xKJReQWJT7zL9ejsPw2m4cZVlBXXqSgJ273bg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WbOQ5rKaMfP1ljQFlxFIENqNBUNkGNwERmkD0UO5c9DMFdvbsQexmwNaJp2o1eMdi
	 JguQUJS/00kay3WxLIQ3YtFQxJC4F76HdPj5c2EoHnBqvFMo/IMwP0Hczzb0zb5Gmx
	 TXCIW0uhuqD5hjghFug324lViUHj5t3hpC/PotqhG4q92XAVbcJcklddMRFe2dCHV3
	 zH8krbmd94c24kWfVc/vDsqcrn1aGkq4d+dL0jPpfvcRRk+S8bWE8TxG5MgwMYuk2i
	 OGyhHAsANxzklSbjcQ5IP3Aclfgvm3X8DyCONPofDRia13NwNUN45GS+PEULoP+aeP
	 BbWr1orgIMRhA==
Subject:
 Re: [PATCH net v3 3/8] tun: clear stale skb->protocol of NAPI frags skbs
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, hassansultan@google.com,
 virtualization@lists.linux.dev
Date: Sun, 08 Nov 2026 23:01:59 +0000
Message-ID: <179417891984.994134.14397350053196333026@kernel.org>
In-Reply-To: <20261105115715.1466924-4-edumazet@kernel.org>
References: <20261105115715.1466924-4-edumazet@kernel.org>
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

- [Low] The commit message understates what a stale skb->protocol does in
  the non-tunnel path.
- [Low] The first symptom in the commit message ("the outer protocol
  check of UDP tunnel GSO packets rejects a valid frame when the two…

--

tun: clear stale skb->protocol of NAPI frags skbs

This patch clears skb->protocol for IFF_TAP frames in tun_get_user()
before tun_vnet_hdr_tnl_to_skb() runs. With IFF_NAPI_FRAGS, an skb
recycled by napi_reuse_skb() keeps the protocol that napi_frags_skb() set
for the previous frame. Without this patch, the virtio header checks see
that stale value.

Closes: https://lore.kernel.org/netdev/179386753589.488856.11455181721004759454@kernel.org/

[ ... ]

> On the IFF_TAP path, tun_get_user() calls tun_vnet_hdr_tnl_to_skb()
> before eth_type_trans(), so the virtio header checks see the protocol
> of the previous frame: the outer protocol check of UDP tunnel GSO
> packets rejects a valid frame when the two ethertypes differ, and

[Severity: Low]
Does this symptom really come from 90e33d459407? The outer protocol check
that compares against skb->protocol seems to have been added earlier in
this series, by "net: virtio: validate outer protocol of UDP tunnel GSO
packets":

include/linux/virtio_net.h:virtio_net_l3_start() {
    ...
		h_proto = eth_hdr(skb)->h_proto;
		...
		if (skb->protocol && skb->protocol != h_proto)
			return false;
    ...
}

At the baseline, the tunnel path in virtio_net_hdr_tnl_to_skb() never
read skb->protocol. A stale value could not cause a tunnel rejection
there.

With the current ordering, the two intermediate commits ("net: virtio:
validate outer protocol of UDP tunnel GSO packets" and "net: virtio: do
not use dev->type to find the outer L3 header") would drop a valid UDP
tunnel GSO frame with -EINVAL. This happens on an IFF_TAP |
IFF_NAPI_FRAGS device when GRO holds packets and the outer ethertype
differs from the one in the previous merged frame, for example an IPv4
outer after an IPv6 frame:

tun_get_user()
  tun_vnet_hdr_tnl_to_skb()
    virtio_net_hdr_tnl_to_skb()
      virtio_net_tnl_offsets_ok()
        virtio_net_l3_start()   <- stale skb->protocol != h_proto

Could this patch move ahead of "net: virtio: validate outer protocol of
UDP tunnel GSO packets" so the series stays bisectable? If not, could
the commit message at least mention the dependency on that commit?

> GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are dissected with
> the wrong protocol.

[Severity: Low]
Is "dissected with the wrong protocol" too mild for what happens here?
In __virtio_net_hdr_to_skb(), a stale non-zero skb->protocol means
dev_parse_header_protocol() never reads the real h_proto of the frame:

include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
    ...
	} else if (gso_type) {
		...
		if (!skb->protocol) {
			skb->protocol = dev_parse_header_protocol(skb);
			if (!skb->protocol)
				virtio_net_hdr_set_proto(skb, hdr);
		}
retry:
		if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
						      NULL, 0, 0, 0,
						      0)) {
		...
		if (!pskb_may_pull(skb, p_off) ||
		    keys.basic.ip_proto != ip_proto ||
		    !virtio_net_hdr_match_proto(keys.basic.n_proto,
						hdr_gso_type))
			return -EINVAL;
    ...
}

When data is NULL, the dissector starts from skb->protocol at
skb_network_offset(), which tun_get_user() sets to ETH_HLEN. So
virtio_net_hdr_match_proto() checks the protocol of the previous frame,
not the ethertype of this one.

A writer could then send a VIRTIO_NET_HDR_GSO_TCPV4 frame whose h_proto
is something else, such as MPLS or NSH, with what looks like an
IPv4/TCP payload at offset 14. That frame would pass validation and get
SKB_GSO_TCPV4 | SKB_GSO_DODGY. eth_type_trans() would then set
skb->protocol to the h_proto that was never checked.

The code change closes this. Could the commit message describe it as a
bypass of the check that the ethertype matches the gso_type, rather than
just a misparse?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105115715.1466924-1-edumazet%40kernel.org
