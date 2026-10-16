Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1947884B
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154535; cv=none; b=L6GUn8PJG9eElgKA5PuNa0PkLUdinRG9645CL4Ksv7VRbRC6JFb8isWp9hgFLbYRzBmKC2OhrJ/+ifLOY8VksW1AqEFG1DMtf3G0zABDsZFJOjoJJaHUttBvOUbtO2lSQ6f5nh8NiK0jw512b+GoUTQQs6kiwB2xS2/pmAgZGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154535; c=relaxed/simple;
	bh=zwQcDUPBFviczLRn4BuXaEim7+o66HzPcgbILXFNl7w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=c32AyBCD9WRR5rrsf+qfRTn2sW9grIUjcIdXT2QV1pYjyYqwBqPde/hUHuHHEEX1HzHuW+6B7XelIs3Ogb0cSrF0UyATAYzlsSthdd9jvq7aghBWA/ROoN2umvqRxDg6EHS7MAaLASo+pS7gmP74p/xYX8B6lAFwgM+HwT0Xrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX7zRh6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX7zRh6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC251F000C5;
	Fri, 16 Oct 2026 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792154534;
	bh=AsY+32e5uxaBs5EdmgOaZhiLlZTADeFquB8QpZzO154=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oX7zRh6+PJWCPyDMYI+0H1gc9/dlTdH8NmdTuy2FKGHAsUBXwxaDjmwqvc398jpHI
	 hgsmIXuP1A/3NytnMCJqX15UbSLhNJEHOuyNxeTowkScV17I5rdsRsgN76yAX2m0We
	 I39tA/kONihM4CwSmSXAo5M/Woch0NAMFTazZtDHd2PymZnGmNG8kEoD6Zf1Ka1UJS
	 Q7ByUZWF1tsRQTNnsxSDOJWnqHaxUA9dPNzUpeU1YeaQcydMP7dTnMijJqJ3KzKtBF
	 2/MPMzDJN78FeH8WNK1Yx9FzI345PS1eu4wS9uyCcsrlVcF/fa8xZDXXUkUzlXMC6Z
	 knuqt+0VSsSlg==
Message-ID: <sashiko-outbox-174320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: resolve uncommon partial checksums
 at ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:42:13 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: OOB read in virtio_net_l3_start due to uninitialized mac_head=
er
--

commit 7b948a860070205bb3211c20ccd737b2f0e9cfad
Author: Michael S. Tsirkin <mst@redhat.com>

net: resolve uncommon partial checksums at ingress

This commit updates virtio net header parsing to validate checksum offsets
and only retain CHECKSUM_PARTIAL when they match parsed TCP or UDP headers.
It also introduces early tunnel offset validation.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..357115ff0ec2d 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -332,10 +550,13 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	    inner_th < inner_nh + inner_l3min)
>  		return -EINVAL;
> =20
> +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +		return -EINVAL;
> +

[Severity: High]
Does this sequence result in accessing an uninitialized MAC header?

Tracing the call sequence starting here:
virtio_net_hdr_tnl_to_skb()
  -> virtio_net_tnl_offsets_ok()
    -> virtio_net_l3_start()

Inside virtio_net_l3_start(), if the device type is ARPHRD_ETHER (which is
true for IFF_TAP and virtio_net), the code evaluates eth_hdr(skb)->h_proto:

include/linux/virtio_net.h:virtio_net_l3_start() {
	if (skb->dev->type =3D=3D ARPHRD_ETHER) {
		if (!pskb_may_pull(skb, ETH_HLEN))
			return false;
		*nhoff =3D ETH_HLEN;
		*proto =3D eth_hdr(skb)->h_proto;
...
}

However, eth_hdr(skb) strictly evaluates to skb->head + skb->mac_header.
Callers like tun_get_user() and virtnet_receive_done() do not appear to
initialize the MAC header before calling virtio_net_hdr_tnl_to_skb().

The MAC header is normally initialized via skb_reset_mac_header(skb), which
happens in __virtio_net_hdr_to_skb() located just below this check.

Because virtio_net_tnl_offsets_ok() is called before __virtio_net_hdr_to_sk=
b(),
skb->mac_header retains its default allocation value of 0xFFFF. Could this
cause an out-of-bounds memory read (skb->head + 0xFFFF + offsetof(h_proto))
and a potential kernel panic?

>  	/* Let the basic parsing deal with plain GSO features. */
>  	ret =3D __virtio_net_hdr_to_skb(skb, hdr, true,
>  				      hdr->gso_type & ~gso_tunnel_type);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792067836.gi=
t.mst@redhat.com?part=3D4
