Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022536;
	b=f0CtqPwNCtimqF7ce3KqhiauBjR0EGfLuxsHBUEo+C4wWX8wx5uvGLVraMddv1sXE6k2
	 +hTWhN/CGpEP48ZMgcdrwmx4uMd/Oe9UG9533+5Zi4SVkziVe0bP3yGJLHU0bcHMaHw2i
	 Y5Pxv7A0pzziR2GxbicL30X8bFZ9tR/c0KQhcBFLEejU5b3BqaidwaP6zBKK9d0xbEHcH
	 Jq7CUD4Wmb4VEY9iRd1uYjeTnfQzgAKOk0bLdPZuqUz7C3OEswv8EWZFA/qgvtPL6UvXw
	 io+dXTeYpQugBZs0LJKPuSWTTZtF3UvlLTTPjjWzxClOVtltY8XC8KeZ0Foz3YBYBIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022536;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/9XlINn99WvynbJ499qLFY4wryJuVWfdRErasiFIsS4=;
	b=Djkm6L4QF/fY1PuwDtLoE7VkyT33O8WC7DK1g2YGeoUbJCPlz8WyQE3doPRp/baFiEEm
	 jrPBD3IPMeMkobKF24VX3/mi1fDvPJKnMLPK57qM9M7no+yiskAd2bD78Wa8RssA76LXY
	 kAtuQ5uNwyQrBvXzGtrIOdsfM+PdvKItl+2EWUOwNCFkk/itU8wHMNcmagJIy2CLNVA8W
	 Cb5LngBd04JYPpanSzEIHGc45Vc3YaQsOwrIRW6FN3TBQGJzLDfUmx2F+SfxiqV6uv1Ih
	 xIbhmohhUP/pkUH7yuuBFyAg9+WkROd4YD1aef7WBjaFdIL5wEthtVTGvB9r6w2FGvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WO/WjWRa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C24606A31A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WO/WjWRa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C561F031E1;
	Mon, 26 Oct 2026 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793022535;
	bh=/9XlINn99WvynbJ499qLFY4wryJuVWfdRErasiFIsS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WO/WjWRag/gV3AUosi/uaBpvZXRuyIOnTWHl9KDnXGE6L3Ry5ywVCo6RndV04N+e8
	 uTdC69bCssBtgBb9NSXkYQTAofBA1uJNpSBv/+b+2vsCYHumWeaX6gQdVk+51bo7hq
	 zPt4eR514AChtcicaZNTN/Okn9dcLXJECG3+NZexbPcYHTIOq5QeOKbOB2q51p2o5z
	 Q1fZDjzDg3b1R2cNxZyn1F0Wkl+kBlfZpY/SR3bMhE76388hl/KwUOpQWzf9gsNlMc
	 OvvBKVX0X2ApKKljQhaRuaUY29JMreZ+mbgRNuKkNN9p8VdSfByh9c2Yi+RNsbDbYn
	 R3aLi91DqcPKw==
Message-ID: <sashiko-outbox-185342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/23] virtio: Add Qualcomm Platform Services
 Firmware Interface ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:48:54 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The Qualcomm Platform Services Firmware Interface (QPSFI) is exposed
> as a VirtIO device with device ID 52. Define VIRTIO_ID_QPSFI in the
> common VirtIO ID header so transport and function drivers use the
> shared identifier.
>=20
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D18

