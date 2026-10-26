Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004025;
	b=T1JHr0n1AxeFnUv9XzYWor9k11dYIsNr1bnm4ocTsQewBpkPm+AMw6L9FIhnAIj1Gd5Z
	 XhCA/o2b4oWF07vdDXgNZk8vG+s6CikZ4HiNr1WlWUBsyTn2amBl6yRhxONFrTVVKgK5R
	 114JLJJzenBC6QUu000h+iGLd3I8uOfR910mNEcpgbBXcQIlolEikF6MiNT91jKQdiO73
	 n3PZoxF5w31QL2dnhM8hLuTr3ybHc3Xz0qkcBE6Cb7Wmoxq8FpTnH0lEwyDiAgqBUsLIy
	 xpeFXC3Bl9nvZraRbZxTxE46UQ2obFytFaUW1ipXXp9edqyVTtvukS7KJEvu7cxicSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JPVZ3DwRfzh8ubt2lOKq+BluweFiw5skz4pnsit3rfo=;
	b=IzE/b93gg+o9jKS7Sv1KY4GbGl6/l2fwq3ESsXOuGhSSsQ0p0c+kATKA03apT8CY6tsf
	 GQOVCRUHvWO1QvB1ZHq48xCQ8gvHLsWNJZDiKnkdzV7A4+4cqrFdE2L7UIuRIJ1QjvKl/
	 4yqZEFto5XZcmkKYIJwWLrinY/92/HlqcVhysHUOXcIAVL5ZZyo3WLQrrYsGSjzH0R7z2
	 CvRWYQByHhxZ04U9ZvDvcFJFW4OF0+82hXjaGOkBElykrrPP+U7zPcfobWnxw35MscagS
	 MqZlbOnziXeZKhHTlrfwC7fNX3eWp85fyObRL92lezYkpyOjhKAreVF9S2lkGmCnooQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxNgKAq8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D75606A31D
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxNgKAq8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06181F01825;
	Mon, 26 Oct 2026 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004025;
	bh=JPVZ3DwRfzh8ubt2lOKq+BluweFiw5skz4pnsit3rfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kxNgKAq8VZ8xsdbeDid52fhBd7C08/24SaaHRt61qr7CrZV6rg8Priwd33jZvaUiS
	 XqNfXT3mcYSNzPJnuzdGv+0BZeNjNcNsuzBJCgDk4sMObLzglrnXYnjIYzVR5CwbbE
	 l4K7dcihrdIhY89sNVNi8hmc+cuCUbUzv0WXLx8lYERu9UiYdWZ6ColJDQ9pX58ph2
	 VCrV9ZO8OWlIkvwyzj2yVEHR16dQVDrOGx5NOitocDrBU2Ku6VRaNjn5if4RuhCTRw
	 vEDsUs5Qjzk3RRY4CkeeaGF+UUlAtMKyLtlaHqk13UrKSF4qdhYQOC1eMwNeupwK+i
	 0qxWuhPLW6ujw==
Message-ID: <sashiko-outbox-184679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 1/6] virtio-net: move virtio_net_common_hdr to
 virtio_net.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-1-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-1-008af03cd43b@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:40:24 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> tun and vhost need to know the layout and size of the virtio-net
> header as the driver uses it, e.g. to fill in fields behind
> virtio_net_hdr_v1_hash_tunnel. Move struct virtio_net_common_hdr to
> the kernel-internal header that they include already.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-v6-7-topic=
-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de?part=3D1

