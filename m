Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673074;
	b=OWnZ0Y10BXbzFNDQDFQ8+FXBbf8S/iGIMPWSMuO9Gj/Tf0BpFoHp9EcFeGEL5LAYp6GS
	 Pl3xjw8tu5aGrGoAugFLypAOvqV6gdy5IzNut5oRX8JzNAggGNAzkfXMbyjOPB7d1yBvV
	 TcGetaO5UNWv9z2Eb+n/AUCmWtq3vfIE6UBQdd0Bck4iH1Bq/0NGj6JfB3DMDyX3RfeHb
	 GLLHaoOR3RhZLUXWQQz0L7N/bR4+h+UYGqbk2n9WUUkJaOPlWCyhgbMso5Daq4K0cagtM
	 jJZPrcXI22NskYEjQxJdPmv7niRSUHj2yaLpQhQGzemUbRaaGxJs0l7KnCv6DJ3Mxxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YYIQeR+KoRgaEjVak9B/mcH1L0DcYBY1ze+XY6rMydc=;
	b=bDLrdvVPfXmHo9yK/ni5MEjiGytnFDiryVKDl1rqDRIEhfU6hrEfDuRrkSZLx3sNhf4g
	 6MSmK1z6dMZ4yvDCXkSUD8Ax7fWjlSsdIOLdZc78H2+j9JCsJ6z3BdFPDcKxxdq/FzH9x
	 I0INXOo/lwf9j8CFtf5vVpkmYgf+UxoEyBmZVrNI0/fmHsa2/2FJYXwcQAZ+NBupOCQIU
	 VR8hGu67uwvMQGk0F9FyKN92dN5RXHh4+YAzyGXNJQ3SMRx60DD9yGs7zJMJzDN0SwnNZ
	 6+A9y+GlIPK/00Z84vdFpX1lN1zMXNtBs/QPoWefj3VCPWEOh+Uz5vUQk0o3qyH2XPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SH8AOB3L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740A606A331
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SH8AOB3L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB95B1F000C2;
	Thu, 22 Oct 2026 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673074;
	bh=YYIQeR+KoRgaEjVak9B/mcH1L0DcYBY1ze+XY6rMydc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SH8AOB3LB4kYHbJZFWRFT598t6zrR0ds/VEod6nMiJiSYt/np/A/Kr+2i7IIBnzT3
	 AyJa+i1FULKWORk/NM5Ez/O9uDPWSiIH2JeeBGa+2kpOx5X0u5ouZY68SlXr4wMxum
	 g8m2YfoOZaL8YaT+XrUI+144f0VLfF6Y16QQB9+aG/cFAZPbdxiC/hwfoJMwgKcfxj
	 q6Vz/7YuF9F2+39rtGFYxMKpo4vZI3NU/N5aGDLAWNGjvHgpu/4BiGbgkhuMBOz/n/
	 uTBzSl92hGE7TpuYoate/KoTqhRVCMS0ue2AEzsM0uA8+mr4WmQWCMhJ3ntIqxD2Vc
	 q/F5vcUznVKDw==
Message-ID: <sashiko-outbox-181489@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 41/59] drm/virtio: Switch to
 drm_atomic_helper_connector_create_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-41-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-41-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:44:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The virtio connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_connector_create_state() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-no-mor=
e-connector-reset-v2-0-0b7e4e85b1e8@kernel.org?part=3D41

