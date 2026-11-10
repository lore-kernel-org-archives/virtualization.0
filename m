Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339502;
	b=akZybUYfYzWBWPJRGpsAjeqfmSVNWe/lo/xmnoarZbuqdigkq9rOxbq6hdrls8N/oDQ+
	 1k8rjELqz4AGTSrziShMs7h9qstTedR4yAwY9tLPAcSCsn4SA+lknZ49JT2o0aKWwMG75
	 paEyD1NS48LHqK+kk+uliZfQ6y4x5mddP0gQRBk7105MrDZXThzM3zqxakUCJBFXBymn/
	 j7BpboAhnlXgu+TYiDy7Dlp+s2fsD9XYUrZiX7qbFalxw0Jdx6vSVHCxkizIA2JUlhc0I
	 JwzOk+ChJDDkdWdtfV9/kpbeGyUxKbT2EuFdQ0vXuwMZfFXFWw31/H3ePZ6yCQRHbvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339502;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KczWLl7i/PwGJvfx1CK6VpAYZMF7kfOV83kHxwP3sLk=;
	b=WfDpjaLwul/h63aj82riyDt7tWnQExOcYmH/54OefPMo3RXrpUsh9xAyjWicFRmdFOmj
	 B4uZdLGy9K6rksv+F9hCohyqCfanneZxNWZLI1k9d2KcxXDymRV7ZSPjDvcHhjQzwXz3N
	 rzfNY0fvkn/uvYZ1DLv54Db4pphmllzQsnMbD7mwFN1BV20yyuN6HG4vqQmlBIYRtu4Sm
	 KCT8uppVICCINWAXNBURMqqCaYnNqSMwqac5FZ81csV7HS90KW4cUo1fIzfwpzjfxeWF2
	 2Wq9VB0AQcIt3kNDXRkyoCaQ+3HBv2a+u77GGNYSVuZtnGszZH58WSf7gG8eN1ZGUpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxoaQN9T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77C606A320;
	Tue, 10 Nov 2026 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxoaQN9T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A4D1F0089F;
	Tue, 10 Nov 2026 19:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339502;
	bh=KczWLl7i/PwGJvfx1CK6VpAYZMF7kfOV83kHxwP3sLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lxoaQN9TYqSuvgxCFZz3LSglVjemYZhIgKDNOP/T50rwDRVKZ1F79PJah9ttRYX+2
	 Xz4v63IJJxydmqcn9OMmvyqdyT2sjrzRV/K9ntoeRhOHq4WCrE0LDIQPZMsvixZBDV
	 qQ1BDqMyLTpgJcxpYT4MexijlvUa68mVMi7SqtgIF4J/KlZVFhLCnljz3rtiops3jO
	 TtnLZ0w3APDHbtMt9QJy43BdItg1xgkVYw1Y5KKAg8wZxvniC8PJJD5nHJoOy8Z+MW
	 tgr++Iq0nmEYnhDrUgG3JKj2185zk6eT0I1FYDumVf/j3h2Ts3SW+VglqG9P84NTt7
	 Bp5kM3wEM3CPg==
Subject: Re: [PATCH net v5 1/3] net: virtio: account for the VLAN tag in UDP
 tunnel GSO offsets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, willemb@google.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 hassansultan@google.com, virtualization@lists.linux.dev,
 sashiko-bot@kernel.org
Date: Tue, 10 Nov 2026 19:38:20 +0000
Message-ID: <179433950084.994134.15100186606737698605@kernel.org>
In-Reply-To: <20261109163507.3102091-2-edumazet@kernel.org>
References: <20261109163507.3102091-2-edumazet@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] virtio_net_hdr_tnl_from_skb() (include/linux/virtio_net.h)
  chooses the outer-family GSO bit with `if (skb->protocol ==…

--

net: virtio: account for the VLAN tag in UDP tunnel GSO offsets

This commit adds vlan_hlen to inner_nh_offset and outer_th_offset in
virtio_net_hdr_tnl_from_skb(), the same way virtio_net_hdr_from_skb()
already adjusts csum_start. It targets the case where tun_put_user()
inserts a hwaccel VLAN tag into the frame, which leaves both tunnel
offsets 4 bytes short.

Closes: https://lore.kernel.org/netdev/179421814766.994134.3669228181251158303@kernel.org/

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..ab44342cf09f7 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -461,8 +461,11 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)
>  		hdr->flags |= VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM;
>  
> -	inner_nh = skb->inner_network_header - skb_headroom(skb);
> -	outer_th = skb->transport_header - skb_headroom(skb);
> +	/* Like csum_start, the offsets must account for a VLAN tag
> +	 * the caller inserts in the frame.
> +	 */
> +	inner_nh = skb->inner_network_header - skb_headroom(skb) + vlan_hlen;
> +	outer_th = skb->transport_header - skb_headroom(skb) + vlan_hlen;

[Severity: High]
This fixes the hwaccel case. There, vlan_hlen is VLAN_HLEN and
skb->protocol still holds the real L3 protocol. What happens when the
skb carries its VLAN tag inside the packet data?

Just above this hunk, the outer family comes from skb->protocol:

include/linux/virtio_net.h:virtio_net_hdr_tnl_from_skb() {
    ...
	if (skb->protocol == htons(ETH_P_IPV6))
		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
	else
		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
    ...
}

For an in-band tagged frame, vlan_insert_tag_set_proto() has already set
skb->protocol to ETH_P_8021Q or ETH_P_8021AD. Wouldn't an IPv6 outer
header then be reported as VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4?

The commit message says:

    virtio_net passes vlan_hlen = 0 and is not affected.

virtio_net has no NETIF_F_HW_VLAN_CTAG_TX, so validate_xmit_vlan() pushes
every tag into the data:

net/core/dev.c:validate_xmit_vlan() {
	if (skb_vlan_tag_present(skb) &&
	    !vlan_hw_offload_capable(features, skb->vlan_proto))
		skb = __vlan_hwaccel_push_inside(skb);
    ...
}

Its vlan_features and hw_enc_features still include
NETIF_F_GSO_UDP_TUNNEL. Take a VXLAN or Geneve device over an IPv6
underlay on a VLAN subinterface: it sends unsegmented skbs with
skb->protocol == ETH_P_8021Q into
xmit_skb()->virtio_net_hdr_tnl_from_skb(). Is virtio_net really
unaffected in that case?

tun seems to reach the same path in three cases: ethtool -K tapX txvlan
off, QinQ (outer tag in hwaccel, inner tag in the data), and a vlan
device created with reorder_hdr off.

Before this series, a Linux receiver used this bit only to compute a
looser outer_l3min, so the wrong value did no harm. Later in the series,
"net: virtio: validate outer protocol of UDP tunnel GSO packets" adds
virtio_net_tnl_offsets_ok(). That function walks the VLAN tags and
rejects the mismatch:

	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
		return false;
	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
		return false;

Once that check is in place, will tun_get_user(), tun_xdp_one() and
virtnet_receive_done() drop every VLAN tagged UDP tunnel GSO packet with
an IPv6 outer header from these senders?

Could the outer family be taken from vlan_get_protocol(skb) here instead
of skb->protocol?

>  	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
>  	vhdr->outer_th_offset = cpu_to_le16(outer_th);
>  	return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109163507.3102091-1-edumazet%40kernel.org
