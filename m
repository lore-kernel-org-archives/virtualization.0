Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568824;
	b=IVDRw+51bi5H7aOA7sITzDwm3OSN/mBSfcgaJXgbvcvU1+2SEnf0Dp3Hb/+68K8pY9TV
	 aLuWhXaoMT4hgdIqTw34MdzePljg2NrLoXPqwt1AqLM19goRWOaScF2rtxkgfBsNv/oyq
	 zHqsVd/Lq2/1ByYNyoygGd6He3dJHEmplEPGjMMl1cqJ5jXXWo7rwpehFxk5cqPehcEul
	 99z27TTH4uXHB8X+HWxmT0fIwzQb4dcw92vTBgPM9FaRN7XqBcv84T7FVS0rbI0jIB1id
	 /+2IH9lguQ8uBsfrF6OTlu7ha8vbx+AHYttVP0oH3e1IYRJUS8U5MGK1p9D0Acdn/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568824;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iUFbI11wC2KOtmlESotdWcI3HHUETaLZWtdGOB1UdBw=;
	b=4jYnd4eddPNiGx3HvyzmkP+399D3uLH/YjwEacQ92p4b0PMd+U0n30cSSvqPGSzwawss
	 cHsilwx0C4EFmq0i7Jwub0vM9Z3wgtJ1JGAwguUADtrZCI0UZCH6b+w3iGqZfmM3w7pDJ
	 6zauFN7sNT8SwCj2Jes59J+OPaujaxpe31/tw/5MHDKKY3rUFCeDP7zpnBo+MjQP9338T
	 rbJ0Swnz3h50TKc2aGdUL3sU8mBI7ueKhnrN4Tj6U1wR3v25A76YD/8iEaWmq/unV9g7M
	 qJJFo2GZZoDTaQ89AEPcv9+Tl2Xl9aIPBUaK2uu7QEifPmlH0OTFMm+nwI5+ErtJIGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bdD+0JLH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6805606A33B
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bdD+0JLH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2070D1F000C5;
	Fri, 13 Nov 2026 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568824;
	bh=iUFbI11wC2KOtmlESotdWcI3HHUETaLZWtdGOB1UdBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bdD+0JLHDkrhQVNniLZlybPwC0KAWIbLNIA+AfELIC6+LR5uiafe0I4nRnzCszSbG
	 gY0uHbEWfyFkqOgBEMtYzseEzhBdWIOLXLiPqyInNlDFTnMUFmGxSrjTSDNYTCcOXN
	 HQ5Ukfl0/V8cWmMgHQyz5O2zHjbzlL5OtS0lctxPmZekRc0mdg8L/HxtPs8nAJQh5+
	 4NeqBI7YwEoKMgXB1JzHeSsn1t/oOFxn76xnwqIrjhzeKVzQNEQiFnt8gRliAgIPYV
	 pF46AWbc/OMx49leEYFRFRqoTntPvJRgW0Lwpx1sQ38g4iEF56/ma3O8YMPKJjEvix
	 R/bxAxjFVGXXA==
Message-ID: <sashiko-outbox-212703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 3/9] virtio-net: copy the XDP rx hash before
 the program runs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-3-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-3-7ab67b572f4f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:23 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtnet_xdp_rx_hash() reads the hash from the vnet header at
> xdp->data - vi->hdr_len when the XDP program calls
> bpf_xdp_metadata_rx_hash(). That is only the header until the program
> changes the buffer: bpf_xdp_adjust_meta() writes the metadata right in
> front of xdp->data, over the header, and bpf_xdp_adjust_head() moves
> xdp->data, so the callback then reads metadata or packet bytes.
>=20
> Wrap struct xdp_buff in struct virtnet_xdp_buff, copy hash value and
> report type into it in virtnet_xdp_handler() before
> bpf_prog_run_xdp(), and let the callback read the copy. The small and
> mergeable paths put the wrapper on the stack; for AF_XDP the fields are
> in the cb of struct xdp_buff_xsk, checked with XSK_CHECK_PRIV_TYPE().
>=20
> Move virtio_net_hash_value() up so the copy can use it.
>=20
> Fixes: aa37f8916d20 ("virtio_net: Support RX hash XDP hint")
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-v6-7-topic=
-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de?part=3D3

