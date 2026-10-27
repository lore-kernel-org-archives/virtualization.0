Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106002;
	b=cLtnZWmc+cqx/nqFH1LmO21i3NdMuYv2KTZWfhd1Wz5923NhSw1PXbwg/P4qgRFBXRRO
	 FwPfTO0FZmqCI6o7wnoOyrLjTcfyaqZQFEwgf6NFC6Fq3icqShBtjOBAMez2HkBaJTKLa
	 ubK8mXsQlDwSGPNolA5/JozyDIB8/RSB4WhtRDba0UWlwfyolRlNvrhvcVlxujMsw29aL
	 E72NpqV5zqNrYh3XKZfN4Urqr63krwqM3AisuruSDuvxNlKlBbizKAbV39Av6Z+1GQsKP
	 kBaMiTj6UA9lOrivumQzhb5v7TQEJnylFkSPfYyUxGgvtwVWjUn2mpO6sc1bSVz5h3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106002;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6wp/+oathtvSc0lnxQcRESl1VpizS2wbCguEIsfM7tA=;
	b=bZkYMWZvs1CG0kVLWrmLc2vxIoIfIJkAaNny/XzzgvlLCpTqTfHhWGnl6nWxycqdfPpA
	 NqFGPGJDWtXtRs3Le+GQPsmTUsOSYXl/cc99ZZ4q563oKXQDtkDVRfjUD5quvzDdEtIED
	 SIPNVZ38XhmuAKG6EGeuxxBp7d8tbF0wITtPtn06639xglCJkDdbLq0UdNwuiw4Q5FvrO
	 i5K4h6YZgB9wAtRKVKmItBS00R7TmuWxVEIIDgwNqxlSM1fxuk/LPGx2cU1Sp+RZCLhse
	 GYZicL1M+QFUDD3PWjVItEAjpDQxcH3ASJEtnjj/JvZeFWuzpIf3Hoa2oXEWQhPtczA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fS5jbKLW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F4606A31E
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fS5jbKLW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0891F01825;
	Tue, 27 Oct 2026 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106001;
	bh=6wp/+oathtvSc0lnxQcRESl1VpizS2wbCguEIsfM7tA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fS5jbKLWbtHxhxmH6GRZCdxUs1hCN4gepnwi9z5DlrWf90TIcthQiXshO7pVzKvtm
	 h5yqQdTXYMu2174kKVHAUAgos7km1j0OLS8zQd/66t7p4YWiowbdmFVIkx1q6Q8dHK
	 WoaGPCuTRbWu3+crXrwU9Ccc+TFZJkMpjkfixLJH0+kW27cWl56AVCY7Ka4XtpwBFX
	 cWcq+KDfUK/Dk4meBBOo5pCrHB+YxhpHKZxlRecl6jlnn5Bfyg2ZrqSV4AbTuINeLv
	 NVnucgEp+/sRTwnI1xDV7TKxGSy9RXQn71zq0gTsC2W1E+gWPl92VSBxXdC09Hg6pA
	 CkvT5se5F3I3w==
Message-ID: <sashiko-outbox-186594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpio: virtio: convert to immutable irq_chip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027-virtio-gpio-irqchip-immutable-v1-1-f64ed13d4567@valla.it>
References: <20261027-virtio-gpio-irqchip-immutable-v1-1-f64ed13d4567@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:00:00 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The kernel has been warning about non-immutable irq_chips for quite some
> time, printing messages such as the following one during initialization:
>=20
>   gpio gpiochip6: (virtio2): not an immutable chip, please consider fixin=
g it!
>=20
> Convert the gpio-virtio irq_chip to immutable and add the relevant
> helpers. The exposed name is kept the same as before through the
> .irq_print_chip callback.
>=20
> Signed-off-by: Francesco Valla <francesco@valla.it>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-virtio-gpi=
o-irqchip-immutable-v1-1-f64ed13d4567@valla.it?part=3D1

