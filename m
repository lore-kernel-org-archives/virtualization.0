Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953001;
	b=udW5TD3sXMeZgfN9LvYYJz9w/LqpRspUVhXCTrUBAkOPB3LTLmjAdqZxemcLqp9u0n8R
	 TTAzIL2V6uaL9fmZBROUHEex+uoCqBTks0Ca7W+oJgfzamXHn+qJMf4urta7vuQD0e2nl
	 h/VPpX99JuU354gaEhZdQ7Ck1iBXZlkjXkcL6qMTqw17ABBJVYHq0cWkM9cL8nJs2Ffz4
	 ugY8JQQISL6Q4VV6jzXN4WEFCdXJICbRn8V6eMHgOjvaYPQHghWl8tkgPFY/KXZ6X2m3g
	 PfUEv5JOUyZ1A/MRFihkxa7nPok+pmBhI06Z1t6rM85+ZdXAEs1xzE7nzRHtSb2Lprg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953001;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p9kVwNJ+k2kaH70qFh/1WdebRZUPuoicFrMmjIfN+CY=;
	b=HsUlXeXZzKEpdRQrbScHoCg58DxSAYw4yyIb4lFm6ILXO5MH5G/5AwAm8EP2iU1YCuTV
	 viPCq93YmisF2wJvymVKKG+cyi9d8Pj5ChDvIVCde+w5gneuHESGFFLmBprMk4M4Mvc4T
	 IHchVn0uQToA2JhEc8yCGlTR440XOFw0SMa65Ccnmp9brX8gFRTb0Y/hQKuiF2MsZoCXU
	 glOJJzDh0Yy5f2B7erg3nzYT2wLA5f42YY081SDakF+VojqcuFyQjHukD66fSZuNiXKhx
	 fzpk76IbW7K2YsmdY7G/dRuL7sn7w943hGaxCZW7el09GcfszOMFGX+YkmQxlKNrsGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X+JpCI/i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A18606A328
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+JpCI/i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EDA1F008A1;
	Fri,  6 Nov 2026 08:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953000;
	bh=p9kVwNJ+k2kaH70qFh/1WdebRZUPuoicFrMmjIfN+CY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+JpCI/irhXDMzuv2lMKUKO3222PMzZ6DlUmhODCLp+yPoiTGEXhteik9per0dOTU
	 5axzkEG3DAcxs7chZpTf2Cr89KWtaz0jv4CAkYN3aBqWF7intVkLZxI4TGRFCwaCrA
	 N+7ohew1P92qMTwzDr5awj22zGCYteBjYoLkBUOT/L4Oxh2HfRhRjS+37UdMhqT42n
	 D4NEo40buV+UzevMQiLFuUk3lHHpBa4YVjj5fTiuEDiby9oOXUbO1QTR+VmrCP+UrN
	 DnUXhPz0PSoLXUbHz83QWftdXQ+ECjeMf9MNwWmSZCaPdteuaDyeHMcjwLJZX6LuTT
	 CkwEU05ckAMcw==
Message-ID: <sashiko-outbox-201039@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/8] net: virtio: do not use dev->type to find
 the outer L3 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105115715.1466924-3-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-3-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:16:40 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] net: virtio: outer_l3min includes ETH_HLEN in
  virtio_net_hdr_tnl_to_skb()
--

commit b246747b62fc4e9502b5e1a6192ecf203f97d1f4
Author: Eric Dumazet <edumazet@kernel.org>

net: virtio: do not use dev->type to find the outer L3 header

This commit adds a has_eth parameter to virtio_net_hdr_tnl_to_skb() and
virtio_net_l3_start() so callers specify whether the frame begins with an
Ethernet header instead of relying on skb->dev->type.

Link: https://lore.kernel.org/netdev/179387332014.488856.911195641361010795=
1@kernel.org/

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 357116c2a1489..b7b6b542f4763 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -452,6 +450,7 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool o=
uter_isv6,
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
> =20
> -	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +	if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th))
>  		return -EINVAL;

[Severity: Medium]
When tun_get_user() processes an IFF_TUN device, it resets the network head=
er
offset to 0 and calls tun_vnet_hdr_tnl_to_skb() -> virtio_net_hdr_tnl_to_sk=
b()
with has_eth set to false.

However, earlier in virtio_net_hdr_tnl_to_skb(), outer_l3min still
unconditionally includes ETH_HLEN:

	outer_l3min =3D ETH_HLEN + virtio_l3min(outer_isv6);

	inner_th =3D __virtio16_to_cpu(little_endian, hdr->csum_start);
	inner_nh =3D le16_to_cpu(vhdr->inner_nh_offset);
	outer_th =3D le16_to_cpu(vhdr->outer_th_offset);
	if (outer_th < outer_l3min ||
	    inner_nh < outer_th + sizeof(struct udphdr) ||
	    inner_th < inner_nh + inner_l3min)
		return -EINVAL;

For an IFF_TUN packet without outer IPv4 options or IPv6 extension headers,
virtio_net_tnl_offsets_ok() -> virtio_net_l3_start() sets nhoff to 0, and
virtio_net_l4_start() computes thoff as 20 (IPv4) or 40 (IPv6), requiring
outer_th =3D=3D thoff. Because outer_th < outer_l3min rejects outer_th < 34=
 for
IPv4 or outer_th < 54 for IPv6, won't valid UDP-tunneled GSO packets on
IFF_TUN devices be rejected with -EINVAL unless outer_l3min only adds
ETH_HLEN when has_eth is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105115715.1466=
924-1-edumazet@kernel.org?part=3D2
