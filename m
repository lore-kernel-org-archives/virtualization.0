Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858940;
	b=5gxLhcNKq/WeWF3Eqgp1/eIpYOFPk40wAK/AgRjqEKLNFpn8piYJ2T2Fz9tAqvZyfW0q
	 RRAiGguf2O+5G0FKfrL/ldRDpq/qg2eJ/yJByJR9I9LyXqhlvNBM810eWbcQatAh5pY4M
	 JJHQNHazAlc0/DWOjmeqmnGOwQaopnAW22eXMnUDgBlxKj0/iKPecPk4QH45RIduowCVD
	 ANlwsuUs9pMoI1kDqsXMUIi07XVd2FNowjOLi9ZmvMikquJ72irbXRoW55s5scBa6V7v0
	 gDCabpNYj9kcmCSbUCFieAlNGYUvbJEmDsjplra0INoExKRhTU4U40p3z5UIgAiR1Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858940;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i0WiKV3AQofOaGoq5O0r8jCt5BKHztNDyJLrZTJVFcw=;
	b=M0ESd8KPzVxqlppAGVBeE8OJvOlQjoGxfXrSk4NQAQokyt9PTjlXGCp8XVZu2jQm9y4Q
	 C9d+rTxIDOe1rIuee4KcHZJHzDpvRRd+Espq8th7Zs/gY3IWGId26aH7GL7Q8+W38a1EZ
	 1Pd9AYdyfVTRdaZ32WHO2459n5UYdRK0sHWNspwFumX9rhmK2RpAhhNX4DcgEXWjXw8El
	 dN5SkSr/SuMZcfTOiOT+H3cvNH8mp9Ta8WlqlFbSQYJyKGe0zCrQc7LKzDXO4QfVZm682
	 6YF86YVCLd51Jbk46RSWnnoRTXjdRbpCGpGMHcBUX2P7b6vy2yfkdE0ekP417Ty+D2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+Ze4F9o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41FC606A329
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+Ze4F9o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE0D1F000C1;
	Thu,  5 Nov 2026 06:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793858939;
	bh=i0WiKV3AQofOaGoq5O0r8jCt5BKHztNDyJLrZTJVFcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+Ze4F9oa8m+TxEuGyeD7Gjm/c/IPjDfhNeNcDL+RA6IemAhhh7IzDt+DSJ29Z9ea
	 RXAorDJ5w7iRX5iU+/IKi5jv6/MtnRZPe8cNGRfvSXhr+s3DCGmAOGRbfDRIdpjmZJ
	 yMX0ABzOiWZn4eK+agVVmnIsXd7XMzCEgHPHoc4SHNvpD3TN/R7koVp8NydKZbJX9X
	 HMOsU347qB1ZVdCBCoWedOEDyi3Bq83KEnKnFVkL0U8eCM+sEzfAy2RNNiLrvzg2/2
	 i+sn4F1djlWP6IkO/5QsnpSteuwl9YQhsrx7mfgUrNMvd2jEXnZSQjsEjE1Kri4HiZ
	 yJEhYdHx7VJKw==
Message-ID: <sashiko-outbox-198614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bochs: fix VRAM out-of-bounds blit with oversized
 fb pitch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Henry Martin" <bsdhenrymartin@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105055000.1873029-1-bsdhenrymartin@gmail.com>
References: <20261105055000.1873029-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 06:08:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The primary plane's atomic_update() copies the shadow framebuffer
> into the ioremapped VRAM with the fb pitch as the row stride.  The
> blit offset and length grow with the pitch, but nothing checks them
> against the size of the VRAM mapping.
>=20
> Addfb2 only enforces a minimum pitch, so userspace can pick an
> arbitrarily large one.  A single atomic commit then writes
> framebuffer content beyond the VRAM mapping, e.g. on mainline
> v7.4-rc1 (KASAN build):
>=20
>     BUG: unable to handle page fault for address: ffffc90002800000
>     Oops: Oops: 0002 [#1] SMP KASAN NOPTI
>     CPU: 2 UID: 1000 PID: 1258 Comm: poc Not tainted 7.4.0-rc1 #1
>     RIP: 0010:memcpy_toio+0x22/0x50
>     CR2: ffffc90002800000 CR3: 0000000110f75000 CR4: 00000000003006f0
>     Call Trace:
>      drm_fb_memcpy+0x37c/0x6b0
>      bochs_primary_plane_helper_atomic_update+0x36c/0xa20
>=20
> Reject framebuffers whose pitch * height exceeds the VRAM size in
> the primary plane's atomic_check(), same as the hyperv DRM driver
> does.
>=20
> This issue was discovered by Tencent CodeBuddy Security.
>=20
> Reported-by: zeroday zhao <zerodayzhao@tencent.com>
> Fixes: c3ac343c14485 ("drm/bochs: Use GEM SHMEM helpers for memory manage=
ment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105055000.1873=
029-1-bsdhenrymartin@gmail.com?part=3D1

