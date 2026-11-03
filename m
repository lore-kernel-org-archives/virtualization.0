Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696507;
	b=PgrzW/1MCHZrX0qQ0SwIyNAdMI3hPex29dZx0IsUhpcDPcvB6PyT8y0JUIImzh+p2vbb
	 pr9Hf2GAnYkUd2I15YWUQKyUxTjNENQRf9p+B5syRlf0XOCSQx61levZArprOtSg8iQtc
	 YBp0z3QletHwYrgziK8VQdhhAB4YMxOflo7lS6jr/fjKbbskc4slcVPni/be8y+1L5iNq
	 vxVWSo8M2IVwbpWnZHkFQOtkUr4KjbU45Jny1j0+3nNujH5L6hKyxVJlfVeio+KpqSd1o
	 fbC6UwvWKXZZK9aQIprnz3401gbAU2POdePz+on0WSFfpK5JpMLJI1mKegC6N1J9xBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696507;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9AUH31kDlTYIlJij7Pz2EV0Hz0aZ8CmXwbCGQMg3fl0=;
	b=FiA9ygeGBcdCd65eF7Obuqyw79VCJZkW9vYsqn+T1dEgaQx1aC2auSTkBygp5kwzYWgE
	 EdmGoKQb6Dt1oR4KDsY+cYY6zpeZeiITpZqL72X3YyXyJ0yggCrXBJoHqx67YADgDVgFc
	 wG29pueniTOuw0bR9cUy5bxfPBNNNKMWHe+NKAn8g4741rn+EmNPHLUyroeu+JVTJzzyb
	 Og8MA1dWdIgkXfvJaoSkg/AMdhde54lga1FPXTznSm87huMVDZcnnssQblCRMqUu099GD
	 qv/OVjjXE9qLvtNhzkU87eKj1UYIgK8iFoWn4wTP+owZDoN8PxopkzrhntdiNu1CfOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYBcVAWk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C12606D81E
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYBcVAWk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05971F0093A;
	Tue,  3 Nov 2026 09:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696507;
	bh=9AUH31kDlTYIlJij7Pz2EV0Hz0aZ8CmXwbCGQMg3fl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XYBcVAWk9G3chygx1xLiidcz+qPQWLQ7QvJgFEfGDhlAqCRl2re5X8Udbb6QU8v4E
	 si87grD0EkMy+uvwd9dplM2kgEZ7BMX8yOWWDBbvENnrB6dVwt/xQvnDClbap47ct+
	 Bz4AlvrJxS3xiJ1CPFcNAxsSrUODcI329eHs1uSgxLUXlfWC/kB1CIhzezugncPW6j
	 xsFyNCX07qgFvPe4y/KtqHDbf/LAjdE96sKvZFw1ovsIu/e0iIndi3xtLFQSZag+u2
	 W/raxGpGMCU9bCevAy9qCwVLN31lZr/i6CHoSxDSwCiUNgNTueN8+hJypjH9tCv4t8
	 n515XZ/Qhb0DQ==
Message-ID: <sashiko-outbox-194912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/virtio: Put GEM objects when dropping a vbuf
 without queueing it
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WXUsIEZlaQ==?= <fei.yu@intel.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261103085314.3102802-1-fei.yu@intel.com>
References: <20260927040655.14531-1-ngocthang2710.1999@gmail.com>
 <20261103085314.3102802-1-fei.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:01:46 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
>=20
> virtio_gpu_queue_ctrl_sgs() drops the command when drm_dev_enter()
> fails or when vqs_released is set during device removal. It unlocks the
> reservations and frees the vbuf, but never releases the GEM object
> references that the caller transferred in vbuf->objs. Those references
> are normally dropped by the dequeue worker once the host completes the
> command, which never happens for a command that was not queued.
>=20
> If a framebuffer flush or transfer (e.g. the fbdev damage worker) races
> with device removal, the GEM object backing the buffer keeps a stale
> reference and is never freed. GEM objects do not hold a reference on the
> drm_device, so the device is still released, with the object's node left
> in the vma offset manager:
>=20
> [ ... ]
> Link: https://lore.kernel.org/all/20260927040655.14531-1-ngocthang2710.19=
99@gmail.com/
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> [fei.yu: also handle the vmalloc_to_sgt() failure path, pass the fence
>  to the helper instead of a bool, fix the Fixes tags]
> Signed-off-by: Fei Yu <fei.yu@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103085314.3102=
802-1-fei.yu@intel.com?part=3D1

