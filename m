Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755899;
	b=hgnXRFmdp/q6MG2YnIDAw+y90jqvOc+7tzLwdW8XPm24PSl2TihyRpJ4wJwxMGABc40s
	 Yvyde+CVlhtwFvD4Zm8sgYcxpTAD4RkIRMO0Ke+/WSStSx2O76f6Rx9ksLvhztNaCxWQv
	 wFlkVvkP+XLLCohD5HowDxkEpMyiKtXqbWBIuEWgReKXjnO3BogBy2SncYAhrFLfIKTMi
	 CK8IXXQxRWzi+z/axvgw2DxWjvEC/JWKq5a1hSNMD6LuitQOWOIdAjn/Ww6lP+gF9x+nC
	 +BHcO1ysTTOnAQP3bxhVA0ygc05381HJZbq5rtwFCt/R2Qj2kRFNKEbTLod7DLGdfVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755899;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jhLcxDDPO0shCq4Jl53ZZUnoIROxDQjqjXMxE3XnYBI=;
	b=C4/YA8fwnlac2SZccm5fPZQoIe1PxVTfMH/USKbEkU0ezcjYWrL7JRhk3T22Ci8r7Rxc
	 ygqVhTRc09fP9nuDjJJFBaRrpdZ3Zb0wOoYt4UHrbDtMZyCgX67XE4E28yBYq547Zw6p9
	 zzh7DLCdXeM5wYT+uHaUg6qN+J17T/My381vYxp5uTNBCStBZJJ/VGW/6nV0Fv7FGKyvE
	 vsUWGKDe1Zdbii0cyhus2SJaWeBl/iEOJ76JR/eS2L6KlmePHmn6FWbtv8TPIYLuSbRi/
	 6VjVaD8Pb2ca2i/u9iGh4vVLW4cfoGyb0l6tBSZPmWxMRNE/f6oc4WvEomH9oFDrk9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrEPtX9N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E750F606A327
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrEPtX9N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698D71F031E5;
	Fri, 23 Oct 2026 11:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792755898;
	bh=jhLcxDDPO0shCq4Jl53ZZUnoIROxDQjqjXMxE3XnYBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OrEPtX9Ns8mXEgCtn08kNVJj5NRTQWcMWMNZMlNUntTW8Ww965ca4SVVVQu7cmbLi
	 wo56Mvm9qZ4Xw2tMFkxKVzGoapebnBhvsRLOf+P4MUrj9zyYlQMifAJYGXj9z1BvQU
	 km5I0VTUU6gkQQpfPp5QRF3TUPRRDC4rSjIyU88NaR014w1dRM9mQL9x4zfj/nzmH8
	 jiny5UPUuoPB5/0umXBUSXt5E3sTeCOz0WvJQdkeYjmXjvWRVAL+pthRfWjH68hBnA
	 g+vLEPQDMqlMn+UiHuVP1e35Zk+kBHyzkeMIGVd4pDd5HUCRyj+jN5PCgE75V6JN2S
	 giaQE1GYlFWtQ==
Message-ID: <sashiko-outbox-182739@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost/net: initialize the whole negotiated RX vnet
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guikun Yang" <yangguikun19@qq.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_803981983647D9F9444561A4227F138C600A@qq.com>
References: <tencent_803981983647D9F9444561A4227F138C600A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 11:44:57 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> When VHOST_NET_F_VIRTIO_NET_HDR is negotiated, handle_rx() builds the
> virtio-net header itself and writes it into the guest buffer.  Since
> commit bbca931fce26 ("vhost/net: enable gso over UDP tunnel support.")
> vhost_net_set_features() raises vhost_hlen to
> sizeof(struct virtio_net_hdr_v1_hash_tunnel) as soon as one of the UDP
> tunnel GSO features is enabled, but handle_rx() still copies only
> sizeof(struct virtio_net_hdr) (10 bytes) and then writes num_buffers at
> offset 10.
>=20
> The remaining 12 bytes of the 24 byte header (hash_value_lo,
> hash_value_hi, hash_report, padding, outer_th_offset and
> inner_nh_offset) are therefore never initialized, and the guest sees
> whatever its RX buffer contained before in fields whose layout the
> negotiated feature set defines.
>=20
> Reproduced on 7.3.0-rc7 with a userspace vhost-net "guest" that fills its
> RX buffer with 0xaa and negotiates VHOST_NET_F_VIRTIO_NET_HDR,
> VIRTIO_F_VERSION_1 and VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: offsets 0..9
> hold the vnet header, num_buffers is at 10..11, the payload correctly
> starts at offset 24, and offsets 12..23 still contain 0xaa.  Without the
> tunnel features the payload starts at offset 12 and nothing is left
> uninitialized.
>=20
> Copy the whole vhost_hlen out of a zero initialized header of the
> largest layout, and rewind the iterator so that num_buffers keeps its
> position right after the legacy header.
>=20
> Fixes: bbca931fce26 ("vhost/net: enable gso over UDP tunnel support.")
> Signed-off-by: Guikun Yang <yangguikun19@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_80398198364=
7D9F9444561A4227F138C600A@qq.com?part=3D1

