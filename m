Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181460;
	b=Sh3Fk1mnDHVsy1+ChSJkHyo0rwwCdJMC+6GctW0eIsQ08SJCjE5xfvqItjEYZXgEmpId
	 dkvIm0tq50CvrkBAaLwoMlMvrnYj6dXkOVEi6PlsgNmzDYp94ai+F3b7Com7oRA8pNOLH
	 FT+6K+R9n5deHKmHn5cllLmbd+L5YVNHy8WxfkJTNUwayKBVVY/LPzQjc0fKLRh8CixYm
	 onLvk4/IEMuf1yDjPPkpo48NUnxbebOJYgfcZe222b8jEp+RmedlstEfKCjNyvyiMrnaY
	 Mms9lJKx6ngMrXAOP30r/abLDeLyM6mhSDfyFrd+TLuaRliDcv8GPTrd1Od7FM8CB1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181460;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=al2KZH+Lfil4ZRwXM7QkmsV9VKxCCHP7F5h/MFiuMwo=;
	b=H+/vrnNSVXyx1MbHKexc6YMWHUWs2SIcXwweoE0ud/M5mNKD7jQnH7Yk/ndzr6NqUvCn
	 4gPyu8Rp6oaBm5O0jktkOZ11bn2qoMae8zQZ9QFNxCBVtu7fHFOysI3FYIm/n7PnDOucS
	 G6FMIlvvLHPdsJuqk4crno4dRV8pfJ8/rlQuPwq91ibpCCgr11g8UZLyK/8wkMEnBYcKM
	 mpbHOO8YufstdnE/iJ44gU323pDhqChRnmwJgu793oPBpgF8JQBCrSfllbs3TuvvH8v1A
	 hEvIwuyIOmjpeicg/ruVUlS/jBiFvHJ6P1S6L5IKGqTgBPXEjm6uAsm6Q9jqJEqq88g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZO/PzKC7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0898606A32C
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO/PzKC7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA051F000C6;
	Fri, 20 Nov 2026 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795181459;
	bh=al2KZH+Lfil4ZRwXM7QkmsV9VKxCCHP7F5h/MFiuMwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZO/PzKC7bZoXwdw61O8aUllsZVaMtpEmzg66eKjXXR5Fl+you7YWmXJUiYLZmldAn
	 kQjmCXFuFDnGK/5kS7u8G9lzhNEfnrXDqqn1pHYrNqJm/OTRnQf8e5yXF8hXX5TXZ2
	 Nmjq1MCBDxUeuO9sLZ83ghj+KOaX8BviNyAHvqLDjDw8hcUxFO3hNzUoUOfcZTGicG
	 oVOBWqD2/6TSAAIwzxqIojp1WMJciuVLtcD6SVCn8Tzb9zjMDK9bCg+zDBTVnZouTI
	 ZFdBFv8N67NM30yJvn22nUs1oHulLjqYOo3A4kzPoaeN4X/ly7Q7g/PdINcdWCWRRC
	 0BEAgKRTMHnoA==
Message-ID: <sashiko-outbox-225243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vdpa/mlx5: Bound the KLM count of the user MR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Petrzhikovskii" <vladimir@dfb.sh>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120-b4-mlx5-klm-v2-1-5b37ace483ff@dfb.sh>
References: <20261120-b4-mlx5-klm-v2-1-5b37ace483ff@dfb.sh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:30:59 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> create_user_mr() builds one indirect MKey that covers the whole vhost
> IOTLB. It fills each gap between two mappings with null KLMs, one per
> GiB, and never checks the total number of KLMs against the device
> limit, MLX5_CAP_GEN(log_max_klm_list_size).
>=20
> With a virtio-IOMMU the guest chooses the IOVAs: the VMM (QEMU)
> forwards each map the guest makes to the vhost-vDPA device. If the
> guest maps one page at IOVA 0 and one at IOVA 2^58, the driver needs
> more than 2^28 KLMs. create_indirect_key() computes the buffer size in
> an int, which overflows: the driver allocates 336 bytes, and
> fill_indir() then writes 16 bytes per KLM, 4 GiB in total, far past
> the end of the buffer.
>=20
> For a huge gap the count is also wrong: the number of null KLMs of one
> gap does not fit in the int that holds it, and rounding the gap up to
> whole GiB wraps.
>=20
> Refuse a map that needs more KLMs than the device supports, or more
> than fit in a CREATE_MKEY command, before any key is created. A normal
> guest is unaffected: memory at 0-3 GiB and 4-68 GiB needs 68 KLMs.
>=20
> Found by an LLM code review agent auditing vhost-vDPA backends. We have
> no mlx5 hardware, so the fix is untested on it.
>=20
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Co-developed-by: Nikolai Kalinin <nikolai@kalinidze.me>
> Signed-off-by: Nikolai Kalinin <nikolai@kalinidze.me>
> Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-b4-mlx5-kl=
m-v2-1-5b37ace483ff@dfb.sh?part=3D1

