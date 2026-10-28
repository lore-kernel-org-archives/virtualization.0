Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204623;
	b=cnfdA1ufiWKz/+wXnO/9dlJvT+b/yKUOuxa4g+NRLljeytptCWEr6Xhb+YFBPChdGaVZ
	 CZQGxcQVhZ8mtQtJ4tKZiSqSLE5wKyjodeWXrjhJkpHs1I7YP81rNsTkOOHVSGL8vBtrM
	 NEJe8Wx/KCys4iVj9K0h3DkYwswCsJx0x+pqALV7bVlAIDm9MnLiuAZm/DU1OXT8nd5Bs
	 +H98eewtRCWLz3I9Fk8PnWAZt4zlrlsRP76YgTN3bEyy50xKtWVLVZ6FkpZQW4AP6BneH
	 QH54KEtLMoRKJy2lf3DbL/n+TPj3JZYyuH5XbUE1w4tXnz0IiUsFSXtHYqd2ZiKnLUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204623;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FikRReG3Sveu0n6bWUwIOIf4tP2xvT9AMOSsLelJxMw=;
	b=CP0Wqof0quQBD25/8iE5kNr22PctKP7YptCI5C4hp5uVqYlD1orexrJw28tFXbh56fcR
	 F7ZXA1WciKQbCRN8zoXvGMcJx7hzeKwFzZu0Mte+XQZrPYPZXTSaqb6MQLERMrZ9ezdjD
	 cJ4d+8ImRLP3nk4Ar2Zz7j6jUp3qtiC9n9M1gSoOoM4oGOT/NCJJ1PyzAD+v3B80dmZim
	 HI9Yrw7ouL8pzqnYYd+Smm9J2ooczLaAGHEvH22GFknsZtnqvO7mKLuBVMI2cVHgb/nbd
	 oQq6Mz5QumfKiJjRTEPqiK24x3SrJ7TWBKjhS/7M2XMrbaFv6vvRJSlCOydrLP2wgDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iN8cKzGX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32E606A31D
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iN8cKzGX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE321F01825;
	Wed, 28 Oct 2026 16:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204623;
	bh=FikRReG3Sveu0n6bWUwIOIf4tP2xvT9AMOSsLelJxMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iN8cKzGXBamNaE43x80Oq8yx/6TqqIvBjIgnwO69OYmIPBWJzOTmap3vAnAJ19ZxF
	 641xfct3Lorpdi/I3P4rjjVfT2ZkehXiqdpd6B6KudFI3S35R3qbSMutvwOKV37MR/
	 rwx+ZRxrn6RBRUho1w/xa/UOk6UuH1DlxnQP1bIj8z2loEg7oD47ZDrYiRloNMzVbZ
	 L46LAuYvi6OUdJuOfDSHpVtjzfxSQpFgRLi0rtl+sLuplLdv0X1suNg/ooYy/6xL5P
	 mFOqNsQAZMZbcwRDvXDMjW8HQ/5XJXm1Ot/i4bCWuIi8TocuKW+Pc1JrLO8D0qufpH
	 IN6KM/pk/EXFA==
Message-ID: <sashiko-outbox-188161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/8] vsock/virtio: negotiate datagram support on the
 guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-vsock-dgram-support-v1-4-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-4-e457cf7cee78@sinrega.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:23:42 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Advertise VIRTIO_VSOCK_F_DGRAM and record whether the device
> negotiated it. Gate datagram socket initialization and destination
> checks on the negotiated feature and the transport's supported network
> namespace mode.
>=20
> Perform device capability checks at socket creation without requiring
> a remote address, which is not yet known for an unconnected datagram
> socket. The common virtio implementation provides the datagram data
> path.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-vsock-dgra=
m-support-v1-0-e457cf7cee78@sinrega.org?part=3D4

