Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418706;
	b=KE6RHM4QiWGGw4ib+5NTjYZorACoDce01qkAdfQZOxMFmdbN4/W+RsBUW7vlDmCIeeuK
	 EqaL6jDWrQLj5VkLXV2ncs/UWKIrt29soqGDUyX+W2HtykcQOcxTJ6bOwisEXv1g7hdhe
	 47UwrjTj6HlyeCRu3Hg78XfW7wQTek/no5kp1Xrr7cXOV9pycDHu4EmR3yr/jOAeMxiTQ
	 P6zhhz8MJOCxGTmapeIrFHptmarZQSX/khgq9zUPRa0dlyjzVch5pmk3W0jqxTZ8Yhhfh
	 JoRiTgNK2uD0+kd4kwzfwJj4M9WAgCWP1tBg0xo+RZCi+pmsei1/ZyMEc8nl+Jzlj7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418706;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WUb/yfC+DJwRadclgurbV0EUfQM50wSbUWF0DnMdrpQ=;
	b=d9dEMco20lKqxbYCpjW3fL4mORrx5J5ZeMUACRXlLblAefAEux9jE82nKbLsfIne2aQT
	 Q2w07tN4l30f86a8IviKhooWatFDeZ29I0Txv5Z3U3565s75zKMYW/Roy5c5Ee05M/+xB
	 ZEwHF2rTuiZAmXGfO2ui52RW4JKGVWesdYFXlNM7zjJzMIQYbyjmtNjNjYAwyvVdGk1+3
	 BxBj/njLOflm+qiN2rB2J1zb0BnOdo0Wj8T5QklHb58SeJbu8mdqUKI7qoiT0PDN7gGDz
	 ZPPEvjzxu3OKGfru/w1W/bxV3kdv/dPBICjfU7hx2uxMhLa1igQ3lUrfEDLIs/NMicw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J99hFfrJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D3606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J99hFfrJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D41F00A05;
	Wed, 11 Nov 2026 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418706;
	bh=WUb/yfC+DJwRadclgurbV0EUfQM50wSbUWF0DnMdrpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J99hFfrJVU7+O+/Xk9SHeXAJrgufoOan8uB8sXzL0FxlyGVTqtRGdgBEYESEOFb9K
	 fhmJrnSpgLGNSgRxvj3W0Xe0QM0eimq+CEV1V4UjksvGyNxiDyaCpSNyaA4CeWRUTm
	 64qnnER1ddtiWTKZ0Q3kJJuDMhsJe8wATsm19CQAO5xzHZXEkVY1Pjyv4bPovr+fbv
	 0MeG94EkEA1Sxb1y7Syjg5c9UKmBoFFeHQDQdj/GNxrLyfSFYFuc90fmtjEvR0aODA
	 WAO9zvbkDSkyaj7a9C2k1El8D/XSwJ5SUvYWXUMGtGvBvymY0niM6oWW3JO3ZSGi46
	 EF1BIeKYyfYbw==
Message-ID: <sashiko-outbox-209427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] virtio_ring: reject a split ring size that is not a
 power of two again
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stjepan Poljak" <stjepan.poljak@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111172947.3579982-2-stjepan.poljak@gmail.com>
References: <20261111172947.3579982-1-stjepan.poljak@gmail.com>
 <20261111172947.3579982-2-stjepan.poljak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:38:25 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The split ring indexes its avail and used rings with num - 1 as a mask,
> so its size must be a power of two. Commit 2a2d1382fe9d ("virtio: Add
> improved queue allocation API") moved that check from
> vring_new_virtqueue() into the new allocation path, which
> vring_new_virtqueue() does not use.
>=20
> remoteproc calls vring_new_virtqueue() with a ring size from the
> firmware, checked only to be non-zero. With 100 entries, for example,
> the driver would put buffers 4 and 8 in avail slot 0. The device would
> look for them at slots 4 and 8, possibly reading the wrong data.
>=20
> Put the check back for the split ring; the packed ring has no such
> restriction.
>=20
> Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
> Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111172947.3579=
982-1-stjepan.poljak@gmail.com?part=3D1

