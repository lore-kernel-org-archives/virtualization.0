Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760346;
	b=5XH99zPfuQDzMWjZE882Vc7ZbX095LvsoXzH9Pw+hI29zjJgm6hjvP1NEeIntesfQQdU
	 oj7Yt0/rNxNXnMYfEmhY1uJDJ/D79pG4Em8cn5y9gr+ZVQ5uSBOVPNfLfISqRMulCehN2
	 leJlbhBa1GbDPIV7DnC8fqeXXa/ikEiOz3hq01PJ6mnwQKMU0LfMiJ1T/H4unzZHZ64gF
	 hxjDZvP8OfNJaPDT2LTQ5za0s2BVLP2r19TZe1J2vIxENLUIMvt0nsHQPnusMhoViNamf
	 6HIGqzO8cXCwda0IunOzC2C7Gr66MedYhg+0r+NTd7yt1kSIypONANVi3gicsxCimHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760346;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qw6CFVXL2TgWCrbQ3LF2URCrh9pIcRC1caMrO4uk97M=;
	b=n5z8H2pqOce9vOOIXmisdRFjZmtyrfDciNw/CqsgUtnAdOqp7QegtNqMxyeG8/YH5jrR
	 KHi8ZAzOAcbX5dyw/8od+wv7bxLlwKvhW0aHckdg/hVhD1ESitfWvJnPbVuYdAW1BxrxT
	 p1/pC5AnPZtND74nO38iXXmtOYESqT4bnQ9B5PoG+IpcSylHkx8GbF9/MaHUzTzJYmyy/
	 J/AI0zt/G8EfUa6dmBg+Wqaxo+6+VD2Cv0SxshgFe8lNpTjBGIRJDhmorzD12O/ElPSzQ
	 MzuObjpAPzy7iYNojkIoWcdIDT1KH7Rf1Rg/WwTATuNs7bgzqyRMpa+PashaAQNlcEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dK0jCOZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56456606A329
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dK0jCOZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BA31F01829;
	Fri, 23 Oct 2026 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760346;
	bh=qw6CFVXL2TgWCrbQ3LF2URCrh9pIcRC1caMrO4uk97M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dK0jCOZEOzBc9Hx1WSfYVrA/A9v9HDHV0Vyvr3ePJ16R7db8Ubw6gkQAvMOgNIJIi
	 nOW6l13yiH1Q4qHEs9lzuCZmYMM/qIBGP+yjz9LSqbaWWJ+UAbKs1SYdvcf1cx1nC1
	 lcwTFVGwC2ooNY8Z+Sc769K8cTpTGpdDqwsX0BuZWDsODcx/ypfupoRWFhOMLp/AY0
	 u+GNHU08kAv0UnwBccKbnl+aQogbERkks49FMk9+dE3PWbgj1rCNewxAwctXMz0rXj
	 0imTrOk0zCNd1KhhLde4kku74YIGMxYkmaTwVmdAuWZVZKNKcka8wlcVa4sagfhHvd
	 Wl0JTCq+pRERQ==
Message-ID: <sashiko-outbox-182801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/7] um: vector: trim skbs before verifying the
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <1b2a0697662501fd4fe896a7dc2bba2d97885101.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <1b2a0697662501fd4fe896a7dc2bba2d97885101.1792668082.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:59:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] um: vector: NULL pointer dereference in vector_mmsg_rx() via pskb_=
trim()
--

commit 869705112c565c7836b0dd95f8fcf315b6c19398
Author: Michael S. Tsirkin <mst@redhat.com>

um: vector: trim skbs before verifying the header

This commit moves the pskb_trim() call in vector_legacy_rx() and
vector_mmsg_rx() ahead of vp->verify_header() so that the skb is trimmed to
the received packet length before header verification.

> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 8a70b3a625537..1afbef78df725 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c

[ ... ]

> @@ -981,6 +981,8 @@ static int vector_mmsg_rx(struct vector_private *vp, =
int budget)
>  	for (i =3D 0; i < packet_count; i++) {
>  		skb =3D (*skbuff_vector);
>  		if (mmsg_vector->msg_len > vp->header_size) {
> +			pskb_trim(skb,
> +				mmsg_vector->msg_len - vp->rx_header_size);

[Severity: High]
Can skb be null here when pskb_trim() is called in vector_mmsg_rx() in
arch/um/drivers/vector_kern.c?

During vector_poll() -> vector_mmsg_rx() -> prep_queue_for_rx() -> prep_skb=
(),
if alloc_skb_with_frags() fails under memory pressure, prep_skb() leaves the
header iov[0] active with msg->msg_iovlen =3D 1 and stores a null skb point=
er in
skbuff_vector:

arch/um/drivers/vector_kern.c:prep_skb() {
	...
	if (vp->header_size > 0)
		iov_index++;
	if (result =3D=3D NULL) {
		iov[iov_index].iov_base =3D NULL;
		iov[iov_index].iov_len =3D 0;
		goto done;
	}
	...
done:
	msg->msg_iovlen =3D iov_index;
	return result;
}

On IPv4 gre or IPv4 raw l2tpv3 interfaces, build_gre_transport_data() and
build_l2tpv3_transport_data() add sizeof(struct iphdr) to vp->rx_header_siz=
e,
and vector_net_open() initializes the rx queue with iov[0].iov_len set to
vp->rx_header_size.

When uml_vector_recvmmsg() receives a packet larger than vp->header_size in=
to
iov[0] for a slot where skb allocation failed, mmsg_vector->msg_len is grea=
ter
than vp->header_size while skb is null:

arch/um/drivers/vector_kern.c:vector_mmsg_rx() {
	...
		} else {
			/* Overlay header too short to do anything - discard.
			 * We can actually keep this skb and reuse it,
			 * but that will make the prep logic too complex.
			 */
			if (skb !=3D NULL)
				dev_kfree_skb_irq(skb);
		}
}

Previously, invalid tunnel packets that failed vp->verify_header() were
discarded via dev_kfree_skb_irq(skb) without dereferencing skb. With
pskb_trim(skb, ...) moved before vp->verify_header(), wouldn't this
immediately dereference a null skb, and shouldn't vector_mmsg_rx() check fo=
r a
null skb first like vector_legacy_rx() and the else branch do?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v5.git.mst@re=
dhat.com?part=3D2
