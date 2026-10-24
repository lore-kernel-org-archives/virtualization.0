Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792854590;
	b=r2uQMTBF8NbVLbG8a/0hJZr8SCoWIbMO5S1vQDgMV3t26EyZDCDkFbbEAvk/h7kDJlpO
	 Gjmy90AdnqE98qxCTDLUJmLa3KHpQOsEYiV2qU3II+i085qa+BTT1Yrv3n4wgYJKuxVPQ
	 OFNjitQuDf4HCGDsnWLBHpAoamrRTVcaa5wPxap6VqHaKjwf+AHbUjlmbpkT3V7wKWIta
	 AIlfd2aX703hxgiMnFVGL16f++KwJB1R+p0OrUzPbVAN6KpJ6AMvf2vszMlb5w16VRHOW
	 4uRhGOyhQsj53FDis9EfV1uqdyD2OCaJku+we9fPYVR1lCrDxt2mQe8ddPZl5bYZZFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K+Qu/mt9HK6/JYDs2chvIX2ymUGcU4jkVA6pv/lmlC4=;
	b=KKX8VydAO5G+MJmJePWENW25/hq6UqRJrQjEuhfMJUTJ7XJB3ImV/gezzUkG4Sby6qsL
	 aRGAOSCKZpwH7weJI+gLCxFC35ht8keTiIkPkYCR8Ax1tsEVb9+hOxPJUJBEDnRNJzdB0
	 Pls4DsXBlAMxrNHVeplslk23pjvA1Evs05onYtv+CsnbkRnqrnG1dzWETZ/DUkytuw6Zy
	 OK/ztiGTTK3dv3Y95lvQWlK8awBi8PTEvFyBDBlO7bLz0Dv6MjR/nplE3tzti0eRYUveM
	 xg/7tzN+lSDA4n1S5yl1WYIsJGLxp3cMAIXPn8JkQ5pCYUZAFPAFqw4Wz9kIoln50eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXWun8pQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232A606A31E
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXWun8pQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83691F01828;
	Sat, 24 Oct 2026 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792854589;
	bh=K+Qu/mt9HK6/JYDs2chvIX2ymUGcU4jkVA6pv/lmlC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXWun8pQQVDVnlT7kZsKkn8/xT1Dr4EIefvFArloK02qJPZru0Thq5fYXIq2iqBZg
	 PTQ+yelVXpPFVDL3w+otLSw4CLm3e0ZWSMfrsZGPzD1RtYsLAy+YyTn6XfpssbOkbW
	 rMk4i6JO8ckA/qFC+lVKn5IcL5SqFo8QxO1rMaUN3RCklpr4UOFz+fedbrHj68hxUv
	 QJr3aIu5tCRc20MYvYuTwxWU0+gpM9fKK9FdKLk+u75JR2eSsZFi0iYcBDqF19UEgI
	 tiVq/r/fpodYMtjn/BLSWVXRZmzU6/rW4LkCPeGrydJ6OwmW1JbqvPqGWTu4alrs5k
	 g3oDz2zA5pVew==
Message-ID: <sashiko-outbox-183768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 2/5] um: vector: trim skbs before verifying the
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <dbbe73d2ce720e333aa8fa7c58b7bd01994a4216.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
 <dbbe73d2ce720e333aa8fa7c58b7bd01994a4216.1792768096.git.mst@redhat.com>
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

> The vector receive path over-allocates the skb and only trims it
> to the received length after the transport header is verified.
>=20
> A follow up patch will complete the packet checksum in software within
> virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
> checksum would be computed incorrectly over the unreceived tail of the
> buffer).
>=20
> Trim first, so the import sees the packet as it was received.
>=20
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792768096.gi=
t.mst@redhat.com?part=3D2

