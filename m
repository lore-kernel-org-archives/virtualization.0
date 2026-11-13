Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568833;
	b=mbh9knS8ueob6ICnF/Xfd/DhC46jC7Hgkz0WznikLXP6AbCmAJZurHribTppCQ0jBqKJ
	 Z4Lq/I7lmkSRmI8YnvI2MSC9fyhj4jmftJXXYuV6pPnKKYh8WNCMRAhb82FFKzwBp0QDH
	 Pg6GkSlqeQCGjEl0ZQTdgFZqVInELPePw7YZ9SlNZlW82c/VByn8Se31MPh9IiI6YqWCm
	 eCrVM471McldOQS/eXXq+1GVkEoq2KAvNU8hwuGRpJOFqheDt4UXRrHB1K5YyypEYo2Hz
	 DqqTxROMZ3LVzCWx9euBARUaWwokAHEilwFIO8586rr6a13WKRCSpgw1rng+R0VVoUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568833;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uWGIKcEy4jG68j2VJAd8m4D12uY7+M2+ubhCVRtWl3w=;
	b=Gb+jh6VZyYN3CmQWPm6HL3y2srWXxnzdRuG9WVyPnLMIQZwAuXprOOPhl/nPAYz4q0TN
	 yJvpajzg5XWEnlWZwLnmkH4ArB/G/Ntwy8IlCWGfHlp+Q4KBX9S1r1mUyXEzl+1zkNmcr
	 XeSztkznbeWD3BmdB+jbRAZdH5IKucUVZ6QUIjp1Qz7ukw3dA/gQyQdua3imW5mIbuAOu
	 oiPreeRAVxfGkPtJnPPiqn7+JOs9XpgRBdEekd8omRSziUs9BPYu7hj3Z1sEA8qiho6l9
	 X1qEcN7jQio/NEvxVmlU7CliddVTVaxt71n/Q1yrJZF4SkIOr3wVzqQAAPTfJ8+PgCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+mHtr5o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA70606A880
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+mHtr5o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D54F1F000C7;
	Fri, 13 Nov 2026 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568832;
	bh=uWGIKcEy4jG68j2VJAd8m4D12uY7+M2+ubhCVRtWl3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q+mHtr5oWRE7zVUxbd9znR54pN8Va/zbQB3zElUNQI5GAHGGQhfSxt7ruu4LHV46M
	 3gTEqfqJ1CUgGoX3HtrqZez74ve0bqGmKnln0JbKRNeiO8hXerfavmyWFPmVOoa/6n
	 kDc1Vi+BKiTxnWytMkns/PoUWyLPVrSeDQahvFtujR4NKdNCnmEMYYBTOFBUdaDwEz
	 +UKUqHkgMypCzpOBaXF5Zf540CidMNeC1HF5c2/+O/uybrHXII1VaNJ+9gjMqiW/1l
	 24nqP9tmqb25EYcXFAnxUu3rJFyU8v9fKodHdBQddCv5uoNYu4Ts3timY8euKOKi7I
	 STfPNPvQMczCw==
Message-ID: <sashiko-outbox-212708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 8/9] virtio-net: add XDP rx timestamp
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-8-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-8-7ab67b572f4f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:32 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> For the skb, the timestamp is read from the header before the XDP
> program runs, so XDP_PASS keeps it even if the program changes the
> packet. XDP therefore works with rx timestamping enabled.
>=20
> Add xmo_rx_timestamp so XDP programs can read the timestamp with
> bpf_xdp_metadata_rx_timestamp(). It returns -ENODATA if timestamping
> is not enabled or the device did not timestamp the packet. Install the
> metadata ops also if only VIRTIO_NET_F_RX_TSTAMP is negotiated;
> rx_hash returns -ENODATA then.
>=20
> Like the hash, the timestamp is copied into struct virtnet_xdp_buff
> before the program runs, so the callback still works after the program
> changed the headroom with bpf_xdp_adjust_head() or
> bpf_xdp_adjust_meta().
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-v6-7-topic=
-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de?part=3D8

