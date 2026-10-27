Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086361;
	b=slTOG1UU3NZk+ps0hIrq3DJxcx8cuAuT4YDXWo8l7xy2Czohqzt/mlUzoBSQJeDXL73v
	 LjSCemXYI9aCW4g0CFOl37RWj/YWp7/+pVZvcJ3O7p3eYX/PUhaP9wHXUJU8VD+z8JPJQ
	 gw5BE0gotsYd8hMk84oWE4poy8pNVUqnY30aNbM86b6uVZjpLjfgr9k3F7Uw1Ho2f6OkO
	 RZzEFZFs/gsrQjnK64LYtkv/9WT1I0lscBj/O2gtAELevwIh8Hu6getE5tfeNzPDNr26D
	 eZv9PFZZn8QluoLMGb8+tkWoKh+zMhX5BZrRIVXUJW2pZnmNndpU+dBFcXBKIyEED+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6RU6HDvEWGF+bxMWooDejJE2QmO4M64ZldsQyolf/lk=;
	b=ULwlMa4e6fP/AEWY4ckoi9Nq5euwxRO2SQmoDZSPmjQbdQuHICjiqNCg7DEFwh8MUuEG
	 5kGlHXhTqzYrUng6gF6Fux3v1cVol2jrcVlrj45CKXgqrZeYR+X+sodt2upXLF5rYahDv
	 YpVwb/mHN/51zlfUxiXA2Euruw3cJxspGHkonqD/k6SaUHaqGqQX2a2GL6n1OfWd9vrfq
	 veiR1/y89+OdY1G8eJpFlT/vkfm0ayJyAWhuLhAodRT2bzACWBF4ZPSAxH3orSiQqcCrQ
	 BfSZpIG2NXYLUakY0CyM3iIxuuA1rG+fpKcaqXgsqscUNDjQWdLuz0CwxHRqPRE/UVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eO304oYR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E8606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eO304oYR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5A81F01825;
	Tue, 27 Oct 2026 07:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793086361;
	bh=6RU6HDvEWGF+bxMWooDejJE2QmO4M64ZldsQyolf/lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eO304oYRoPL2mIpuYJY/t2ibT+uRKJvy8JpMxvR7OZmAGnB6qPmcy3vy7Kk4XUxa5
	 ZS3mAVtVQxfvoVJNV+ShNor7j1vBw7WgoPAVuGu8szpuCapls/jIIfg+gzneLaxyRj
	 Ic/Z57u6Ql956knrWOA2723xHyllHU1jYWtu1n2ZUQzFUlGEA7uJ3F1A09mGPpyrtN
	 0CjtO9tFYfRBWeNP/3Ui2HJMarOm2eJSJeWjeXz5tF0d8GqBqURMumDFksI+zfRkn2
	 J+4/IP1Jg877MihANB6mYoisUu0fURorOqkkssFbo5tAHW0TRf78O+q1FjGHMQUJMb
	 aGVvBnHWuSTwA==
Message-ID: <sashiko-outbox-186208@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add spi-virtio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027-spi-virtio-bindings-v2-1-67927b24b9d4@valla.it>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
 <20261027-spi-virtio-bindings-v2-1-67927b24b9d4@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 07:32:40 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add bindings for spi-virtio based on virtio-device, allowing proper
> validation of SPI controller nodes declared as children of virtio
> transports (e.g.: virtio-mmio). Such nodes are not used to instantiate
> devices, which are registered by the virtio transport, but to define
> their properties and establish dependencies with other nodes.
>=20
> The compatible follows what the virtio framework already searches for,
> "2d" being the hexadecimal representation of the SPI controller device
> ID defined by the virtio specification [1].
>=20
> [1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html
>=20
> Signed-off-by: Francesco Valla <francesco@valla.it>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-spi-virtio=
-bindings-v2-0-67927b24b9d4@valla.it?part=3D1

