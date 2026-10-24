Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792854590;
	b=vOyBdM5jGGPepl6o6mSIJGB1L9QmtjZOmn25FQjpyut/UI5G2Tq9BmZx2fpyTh0HvnDM
	 XNA+isSayiHoVupQwRwK+yCN8r71OgZM1YdJqNSxvLQmkuMYS6HyyG6hpIw09JXJNtDiD
	 dF26cgWhJZjWm4Gv0SRfln5j0Oby8ZO1bdYZ6LL09S8tunn253tgV3Y5DJ8ms7MlXMrc3
	 0bbdd4ztsAyhZrBzQNHKdL6Q57gFRlg1HnxPpiC1JCv8/9HROP4esTpafOJNZ4ARnuu1C
	 w9fjeZBi9yyRo2kIRowHY3SvZche8qspgpwtQRxbF3pmm+ExDPNo1SLhG0LZLen3JJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=deDX656JGp3xk69v6wVGrb5ytFf+ncojoN8Y264dvro=;
	b=f2Nh0XGB0dIlWaZYhcx10ICd9hU9dAnpPSM6Cxh2UqZEfz+WvUKsHyqM8VeeUawmDlcw
	 aChoTef6eKmTel3M6OKPaGXrbJlGya0cpXKjiYwfv0GBoN9cnF84N9VoI4eIsOOfOpl2D
	 tGG44xm69hPMTl+0XCb0dD3XZ1hhli8w3H6M2Np+yNdPrAAszMNiKqWGPknB30EpL+FCw
	 o5ml25XhahMdWCA0C0jPIDqVgnaQuV/5EvX11ybwx5fo6q+RotinbCHTVe38DgqEGRkX/
	 wYHpjRBUdidPctFqrchhI7xTJCSf2kHnotTaq5CffYt/kxbjrSaxB9wDnhpYF/0wFCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zoc8S+Py;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D644606A31F
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zoc8S+Py
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3861F01825;
	Sat, 24 Oct 2026 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792854590;
	bh=deDX656JGp3xk69v6wVGrb5ytFf+ncojoN8Y264dvro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zoc8S+Pyq2s7OY0uVAK4zJQCF7mY8KnuLgSbq63qQ162sp6KFef5AqeHVPvANFilG
	 930uEzaI6uC2HeMZlSYi7Ew8BVbk5Uzrt9m4pQQDTW4TUDE6WMe3d1Tnp1mlN37KQv
	 I+cJngQgJeNvyZZSaBDj1wGB/Fk7cyQaV2rbeXNWer5sqY2WKWcObVhY3yjlSBUHKY
	 740Xq96YYFeiby2+BABaGHes0qIwIucy1Hv+/xgoSVW9PQGhZS0IVwVtVXCp7n0qPV
	 tSmBP1OzKL46uaoeMc873PZ//8nHdZtNFiBHFqb3ZSIbKNeuvd1voVs1/kbnHknFqk
	 DIuGSUvYox4SA==
Message-ID: <sashiko-outbox-183769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 3/5] virtio_net: parse tunnel csum_start
 little-endian
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <ac2b7e8b635da611f7f2bb0b42436a8155edc7ed.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
 <ac2b7e8b635da611f7f2bb0b42436a8155edc7ed.1792768096.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 15:09:49 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> All tunnel related virtio features are > 32, so none of this
> functionality can be enabled on legacy mixed-endian device.
>=20
> Accordingly, all tunnel header fields, csum_start included, are
> little-endian.
>=20
> The nested virtio net header import parses csum_start that way, but the
> inner transport offset is parsed with the endianness specified by the
> interface.
>=20
> If tun is misconfigured to legacy big-endian mode while the tunnel
> features are enabled, the two parses of this field disagree, and the
> value stored in skb->inner_transport_header - which is only
> bounds-checked from below - can point past the end of the packet, where
> GSO segmentation later dereferences it.
>=20
> To fix, parse the field little-endian in both places.
>=20
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tun=
neling.")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792768096.gi=
t.mst@redhat.com?part=3D3

