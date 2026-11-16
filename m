Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826446;
	b=gZzYrVUjzcFi83auAbO/6ifN5/0cfO15pqPlhQnbyLX8pz6fWuGPZlocxrKbmXk936KO
	 qSFGzmqZpstcS9bYvxN2WiWHeNiw92wzM62S5qzivrHfgkexZ+ic8qw8NZpz9qeHkpeGV
	 et5sn8mHjinVlnYaEI+KN/rsKi/1+5tAyVtr6YaY+weeaaGexbqKI3OP5q3Gmk8ihgGRp
	 Pq7PVQafmoEU+26SRn3Ze2IJqpsTopqeQIHVlFgxE3WoMaXIQW5spI0+PFOkwtiOE4Ezh
	 ePFLCpLPjE9whWaYTVFZ2eN6hp6xNnH/L7H+8v5IOH0S9JtoKlSLaadN81k/MrhN6eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4gurq50p80/oLJ6G/qzQvcXPZQG9fjbfkZ/uA/k5MUU=;
	b=aeF5+3QHmKHVATP1vsHEytiFTMJnthlfIhIgx0f4N7tR8V+7Kqd+Luns0LTqZay4aaE7
	 Yp4TiJa50x+wrzKTtyG6lNyL3RMP2rw+hbgjF3KBjl/H8mIKfYhgZQVzYC90iS18E1uXl
	 EqrPef4I2qcdwhGursAaWM23rOfh4MEecLTFthZ3sqIMpLwUl3GeubGG5zTnqnAvsuTa5
	 PeLCbh2UarATZePpy5hgSv9wet+pGFYDAF1r0ruMcyNFzjf0evB3HkJysLJWkvfNYfncy
	 tEj/OZLoVLToqxFoNfPgPKo/gwj7bw5HvdFjVZk+GBfEL8drXaV90ufxaMqwAbKE5Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D1c/LSVY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39833606A323
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1c/LSVY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883B81F000C4;
	Mon, 16 Nov 2026 10:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826445;
	bh=4gurq50p80/oLJ6G/qzQvcXPZQG9fjbfkZ/uA/k5MUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D1c/LSVYhKjDVhiE0cmnidK2s8jSHD9BnzPEbBpg/L241QLvDCkOhRnaB3ck5tiQW
	 QF6+wvLbIRpaAk4VA18jNAemX4otTe4L/CwBcW7SOSMvRGdpwiRIMZenQd7FoezuMw
	 ZNfz/Wy3RNwYodYR5Hn0TS7ZjDmmLIBw6NQXeNpY+DNJkESEAxR+90RlxGsLCo/Aj0
	 W13KWBq12qzMw8D2RD0SchJMRl8/Uc3TCCH3SpYC6Czb3BP6vlBnvAytcbp6wncP2F
	 SpXIcx4bTofHyGG7fgb8GQLSo0psKf1IKhXwridvROKXMuw99+BVyKj3mS9q9oZtxP
	 /KSsSAcSJWaMg==
Message-ID: <sashiko-outbox-216791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 46/64] drm/cirrus-qemu: Switch to
 drm_mode_config_create_initial_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-46-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-46-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:54:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>=20
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>=20
> Switch to drm_mode_config_create_initial_state().
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-drm-no-mor=
e-config-reset-v2-0-0bb471f4d1e0@kernel.org?part=3D46

