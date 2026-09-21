Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C852BE053
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951678; cv=none; b=Czj7EWvKzLAljH+mcuxlGph4989cOkz+yA+5OuIADKGrxsY0g+HU+7DcZ03LqLUk9h9yKxmQVvCryeSNjKXnn0XJlCiIPyyBYxdrU8XdbKFkYmz0fkQ0d/RTah5+N38B+sqP//d/eujQARN3oBk8fLasZmjmG2XiUNOmlOC+1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951678; c=relaxed/simple;
	bh=dUzdwDDgyb1IySSqXocNI5twjl7cKyumNZitsoRdeL4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BxBc2ukIlNMEVO7GlrVfXV+7FExNrAuQYcA73rX9hUlcoGKs/PLiTVfTdG46tBJ2qb4/QHV0AqaNfOE8XV1YvcxMRsE2wRhfU4j75Y7yghN8tCBKL3bgLQttdubn+G4Wgppfc7myaeUro1HtJje5H68SI/tX8sLs5YRhtm/Qhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUGS6ELW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUGS6ELW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA031F000FF;
	Mon, 21 Sep 2026 00:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789951675;
	bh=3V1s1zeb/BuBqZhmSZmTOd2mJSd9fwTfL144kFkpWuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PUGS6ELWvHIuUGHc8bdGzIroEeJ28K0OEnYXqAcpJaf1/7Q/qIiv17oenD5SXHKk1
	 NMIe5z43dkroAM1Q3ZIyIqiTpNSJJHDk9HHaW75oDwHEkGTebLBVMtSTgziJ9VhiB4
	 NaEUKyQu1n/KCAxR3jQFrlp8K1n19Zj+aH2EyUkrPemmUbCtr0AndbB9zb3e9vLKVc
	 Glh+URCernFPsjndTWYa6o+u1ofYsBIVeGDMyEzHcDpIWCutI3WrX5grZ63oXyI90z
	 +Fmvr26Pknn+lTcK4w4rZIulRV3FW/S0IVntruycQMEW3QMhCjXnTyjeO/tdPmQtJ2
	 jy+SLXufDKwOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/2] net: validate virtio checksum start after
 network header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paulos Yibelo" <habte.yibelo@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260920004733.6473-2-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
 <20260920004733.6473-2-habte.yibelo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 00:47:54 +0000
Message-Id: <20260921004754.DDA031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: virtio_net_hdr_to_skb security check bypassed for TUN devices
--

commit 1c7e0adac42db0550277cf456f6845d512993ef1
Author: Paulos Yibelo <habte.yibelo@gmail.com>

net: validate virtio checksum start after network header

__virtio_net_hdr_to_skb() rejects a CHECKSUM_PARTIAL start smaller than an
estimated minimum network-header length. The comparison currently uses the
offset from skb->data rather than the offset from skb_network_header().

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index c381b916c1b54..a95ad465b9887 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
[ ... ]
> @@ -104,7 +104,8 @@ static inline int __virtio_net_hdr_to_skb(struct sk_b=
uff *skb,
> =20
>  		if (!skb_partial_csum_set(skb, start, off))
>  			return -EINVAL;
> -		if (skb_transport_offset(skb) < nh_min_len)
> +		if (skb_transport_offset(skb) < nh_min_len ||
> +		    skb_transport_offset(skb) - skb_network_offset(skb) < nh_min_len)

[Severity: High]
Does this check get bypassed for TUN/TAP devices?

Looking at drivers/net/tun.c:tun_get_user(), the virtio_net_hdr parsing is
invoked before the network header is reset:

drivers/net/tun.c:tun_get_user() {
	...
	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
		atomic_long_inc(&tun->rx_frame_errors);
		err =3D -EINVAL;
		goto free_skb;
	}
	...
	skb_reset_network_header(skb);
	...
}

Because skb->network_header is uninitialized when __virtio_net_hdr_to_skb()
is called, it retains its 0 value from allocation. This causes
skb_network_offset(skb) to evaluate to a negative value, such as -64 for
prepad bytes.

The new check then simplifies to start + prepad < nh_min_len. Since prepad
is typically >=3D 32 and nh_min_len is usually around 20, this comparison is
always false. This completely bypasses the security check and leaves TUN/TAP
devices vulnerable to the memory corruption this patch intends to fix.

While a subsequent patch in the series mitigates the consequence for IPv4 in
ip_do_fragment(), are other paths like IPv6 fragmentation via ip6_fragment()
still fully exposed to this bypass?

>  			return -EINVAL;
> =20
>  		nh_min_len =3D skb_transport_offset(skb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920004733.6473=
-1-habte.yibelo@gmail.com?part=3D1
