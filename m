Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568829;
	b=c3ovkmZbh1iETFyB0OEJlr/fLHKXI8w+MbbAGJlkR/yb9kq94XEeDNm4GWdsPq4dRucF
	 8Un2g2XK2hDOUCw3rR9vBy88h779uYniQj6+tldj+8HtjJqHTfajkFqx7duAZsyq+1i3Y
	 8MO8sXMWmLFH/RMklEZJs9o3XndFYKeQJ8zsF6a6Wnrmd6t6FMPFlNWRuMR7GN947v6oE
	 Q/9g1T5fAI3CNlo5P2M/kKKxfxUyObjwATGO6zCJ81CIWB3pYgxBbJHtkzJoqeu/DZt5M
	 CwCTTIYrwZom4piE772C4Vw6LFdX9AkuTPgKheJnnf5RirZJdIX8bAbzmO14NLolC/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568829;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XKX5JxtiIxN+MvucIAFJrJ8RYLMmN7AfsUMLZ71WF+4=;
	b=N838lJQevxlylbwlwB0rwJcJp+/29gotEP7bAGsxD7i8HyQ/CyWUzRSlC7qYK7RBzwSS
	 B9bQL+JIzWAdJbAvDtlkFsRtLg3AtjJWDCgpKiDRoHW1WiLgS494KqUMcixUG00jVpj6g
	 /Bxmps38K5SwNr8ztdOh8JiUmOlWJUxXbwULuvfZfUI+jwsl0Np+jvo70HhKZQKbyyClC
	 SUfnl2taD5bG9DMKRw8mZQhnUhQbRSigF8uJAfENhfAEcI4e9x5voS9BqO9Nt/ApywZsz
	 RIAYU6fkSPMWt+7AKUwqEEPaRNg30UuHs5uXyz3KrsvJ3mug2cTdzuQf6EIzpbJYOTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GK2b9TXV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC152606A334
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GK2b9TXV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97471F000C5;
	Fri, 13 Nov 2026 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568829;
	bh=XKX5JxtiIxN+MvucIAFJrJ8RYLMmN7AfsUMLZ71WF+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GK2b9TXVfHXPCwxpzCFekOtlz5MiPKCkDGyLB8vWn/R49xU1o7cR0G6Lswo+W+hy3
	 /A0pcdkAv1OHJxqDmJ+/4fCcMMPsAsORXV4COEB0aYHO6TDWXCAWP/Uoar8KfbLriN
	 de7q27+GxeFsdVdYgAJirBqul99jvn//h86c/NqxKzsvijkI9dFMMZrTylQsHK16Cl
	 ryf+P+WbeRbhyGtEhOr0W3xghfwbFIzYxzTLkPcZuJztys93KqL6Pj7MJHD1P6SnyF
	 1scHrwoyOa4DW75CTL9/LPHyTDTNFEQX096vpibAHKysx9v4FtZ9fs/swIMQ7EID05
	 1u8+0xCBtbYaA==
Message-ID: <sashiko-outbox-212705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 5/9] virtio-net: support receive timestamp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-5-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-5-7ab67b572f4f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add optional hardware rx timestamp offload for virtio-net.
>=20
> Introduce the virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
> virtio-net header grows by room for a 64 bit TAI timestamp (header
> size 40 bytes), stored in struct virtio_net_common_hdr. The layout is
> cumulative: the field is at the same offset whether or not the
> features before it were negotiated. The fixed layout needs
> VIRTIO_F_VERSION_1, so the feature is cleared without it.
>=20
> Implement ndo_hwtstamp_get/set so the timestamping can be enabled
> and disabled at runtime with SIOCSHWTSTAMP. The driver cannot filter
> what the device timestamps, so any rx filter other than NONE becomes
> ALL. The timestamp is read before the packet is handed to the XDP
> program or the stack, and attached to the skb with skb_hwtstamps().
> It is a raw TAI value; there is no PHC.
> [ ... ]
>   host:  nc -4 -u 192.168.1.1 319
>=20
> Based on work by Willem de Bruijn.
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-v6-7-topic=
-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de?part=3D5

