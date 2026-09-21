Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396F78F3A
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 03:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959691; cv=none; b=e+vAn1g74Av8n5mKMH5NnCNWHeLwDGimR5n0eHwyiSsP8YKVUyz6bIuAY5SzEA9UhPRPCfecrwh/Q8gT/YR5MNVj6ifZkas/6R7fp6pgxXmlLYL5LMqSP0LkwfrjoMvFpqwr1KG+57rsWlSHQiFlZl3jTCXO22OYTOfpXC4kdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959691; c=relaxed/simple;
	bh=7IcHGfPDRuZRHhw7rM6LkzcWnAUON/Yrjr7x41OZ3CA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GW0yAWzLcxxVTSfCAGvszjsey3u+TpT8t+AnjfxN+XM4sP1LyJ31slcygaM8bdm/m44AYl+LNkRx4dVx74/0jwj996L4jp01flm2cjSl3FWZR6gG1N5Hw1QsnKy6wTPAt+lLJi5y3QPTiZWGZ5l13ZBzIIupsxQqSJTyHSrPrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsVxmzBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsVxmzBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CA61F00893;
	Mon, 21 Sep 2026 03:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789959690;
	bh=7IcHGfPDRuZRHhw7rM6LkzcWnAUON/Yrjr7x41OZ3CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MsVxmzBNa2+TOOhNROyi2WUTeLM+ImP+1NH52BQ4Yf1KJMZvPf3D6fMDSVLb6RVuO
	 xM9vPF5NJT6cjPPxUolz69GLCarXvIhxZjogt8RXVK789o5vZ3LNRVYa76pB8A4gd6
	 ZuArqIUfba8O5AWmAAeElZY2UbiTh3QQ0ZA+z1Z/kCWq49BLLGftUeJfdgyPKkujQB
	 syDU272VMN0O9JejI9m8LOxnkMWcs82ZtwkVRlxNp3z8p2juX9w9i9n3t8f7mAgFhH
	 uOHALanGSuU/tgCqV41i3IVKtG8E7+Y15BJnadAyPPMdJQ8S1+aB/BTkva/r2aA6gO
	 PuiDF/lKv5zHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/2] net: validate virtio checksum start after
 network header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paulos Yibelo" <habte.yibelo@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260921025341.44846-2-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
 <20260921025341.44846-1-habte.yibelo@gmail.com>
 <20260921025341.44846-2-habte.yibelo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 03:01:29 +0000
Message-Id: <20260921030129.C0CA61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> __virtio_net_hdr_to_skb() rejects a CHECKSUM_PARTIAL start smaller than
> an estimated minimum network-header length. Its input offsets are relative
> to skb->data.
>=20
> Using skb_network_offset() here is unsafe. TUN/TAP, virtio-net, and UML
> parse a received virtio header before skb->network_header is established.
> On an skb with headroom, the resulting negative offset enlarges the
> apparent distance to the transport header and can admit a checksum start
> inside the network header.
>=20
> Pass the data-relative L3 offset to the converter explicitly. IFF_TUN uses
> zero, AF_PACKET supplies its established network offset, and Ethernet
> receive paths parse Ethernet and nested VLAN headers with
> skb_header_pointer(), without changing skb state. Use the same origin for
> tunnel-offset validation, and make UML propagate conversion failures.
>=20
> This does not require a virtual-machine guest. A TUN or TAP device with
> virtio-net header support is sufficient to reach these paths.
>=20
> Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_ne=
t_hdr_to_skb()")
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tun=
neling.")
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Link: https://lore.kernel.org/netdev/20260920004733.6473-2-habte.yibelo@g=
mail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921025341.4484=
6-1-habte.yibelo@gmail.com?part=3D1

