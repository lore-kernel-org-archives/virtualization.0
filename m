Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268434;
	b=ZiSJsVeJZn0T+tZYHbT/kOHvaQhGOzJZCuG10VrJ7cLJW+kxTfhydgF+ikwIJkl2w0Uz
	 NzePC5qyzYKS5+FnhotLxx3e41vN4gYbildLVYUvLGGaZ8sIL2/mBmClRtp38sZfT8kNT
	 RJdAsB5JJM4rwzzpCvELPbWOluYATc1FvSbXatHgDzYN4GDXiH+2zub+I+P6tFYkZvvr9
	 Kx4Yf4u/ugi48hhmWIa6o+xXVCWh7b9WbvmLZnSOzn1SpLXnbJsb8KUXNJZYjuiBxQwST
	 Os5D85Xqa6iAzOEwArM6bEJh0HTT0WK8oTL8OJ7LpF+Z4k4Qz5wdjWTAfqQqwDhliZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268434;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gOngaTMhq6XVMHfGunbJ9LJk7hne+/6HyxCSq26sopA=;
	b=ra72OjhTedBjdk68dLhoCbwqEcKUSM6R2TsjshTFNXf2M/GxW/NTbpiWh4y3CZ/vryh1
	 fRizmwAZypy2D1HFeret3G0i/Qoe7xyWQPqQ+1bL1/u/vNdlkdwmvLyuxV8PktHdpcxUk
	 OQZjZL4Lq3FJtfvuSaVS5UwBaoyaxnOhnfDrcgIJYXsGua5K44Hp890XZ6tCHscgtfYnS
	 BY2TnQ8s4+exjff/YKo9XMg6XyU7Z4StxfF3AnScClCXOdNuLjAp8U701xwgPRoAqZGH7
	 uydT6Rg3JevjPrEbtZz5rolvklba/OamC+pE1js/WtYhES+nWXoVDEOqymedTz+zlMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6eBDVTR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63F606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6eBDVTR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7601F0089F;
	Mon,  9 Nov 2026 23:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268433;
	bh=gOngaTMhq6XVMHfGunbJ9LJk7hne+/6HyxCSq26sopA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H6eBDVTRJ319H+GrFujXakCyb9P3Kr85MjbVjbNDiQMXTEacjqZthnOD3PXmjqR6x
	 nLgg5QADCxGcBNzRQPIwzel6mWjuqr0usgmPZtbwssiDk7rPQzvbVf5UYz4GQ2ftGh
	 +QlHfcwC/IhVBmy/3ot/lk2mqOgU3j0bMW7ghl+Jhzn86XviPK4QPiFzT0bo544/lR
	 WiOkx/hbDB7pBLXs4JjozTRhCL1a7zKmvvw5VpEhrHyZtvupFeYheA+hb2hs3Efbmz
	 CII+L8vK9gN6YNAr9EgpAJ3nVVPXaGXYYGzBTzdCVpSucMTgGAa5DHqTeFXCjjsEY6
	 RqhdFy6aFEsJQ==
Message-ID: <sashiko-outbox-205800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 14/14] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-15-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-15-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 23:53:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document the five opt-in virtio_snd capture module parameters. State
> that capture_allow_empty, capture_allow_short, capture_packed_status and
> capture_pause_restart require capture_staging, and use the ALSA kernel
> parameter restriction tag for each entry.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D14

