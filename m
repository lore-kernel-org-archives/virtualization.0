Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8EF26C3BD
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458486; cv=none; b=RSgYU27jrL+zVRmDvTSt4glKa9TXZLMDKWUqQOLnxwuHvz+5+Tux+XYC2k7MoIBTcU8eMzrHizElIZicSgXAuV5mb8KUaylGn5fc8j78ZvzJPBnorseKU5LCtQlebwVI1JWmEq2cw85z0MxSBT6ic0jkTebnJz3rFfvTtuIUjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458486; c=relaxed/simple;
	bh=TvUcLf8+rRTmqvfUQTEHfEQ9bL4cSuj1HVAg7sRWVO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G7HCf/2Pi5D96UZs4njqN/Bvd7MY3xs7PrrYfPXM1oHH/T09fIdmguUYLfSgOqJz7ymz7WXNQ84BqyneAFDUagGwub7JQY3Czhte5y4yhmMWXMufwFvewQbpKTGhcos03GQ5v+GfZpu9/x3V08S74w79IHMvwpGNNvE+EIObAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWWyNloe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWWyNloe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9131F000FF;
	Tue, 15 Sep 2026 07:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789458485;
	bh=TvUcLf8+rRTmqvfUQTEHfEQ9bL4cSuj1HVAg7sRWVO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dWWyNloeUy9t2elOLgivLPH+Nw+qnyqwUl8rNlc68jQVNXZW8eHX36dl+krCKfB1/
	 G1uGwhZ5leA7OZPxwEIp716YL7pzPEBO129pdZCwv5hw39n821nffQtR4k1Vk8l9zD
	 JZyNg+as2qgbWUXImUoYaLWjzZg1LHn439QUwRV9zmQBWoTblFZ85tJGQ7wjO3gAXA
	 yzCV7qg6s91iznnPkHNNnDRlneQ786nRRum7Vne7mTG2OaDpi5t9Ez/tMtDMMKM+tF
	 lc/KeLP/uugvViALHdP8mfWK4Xep7v54BoOlY4oo8wFTOEoN2sXJVCKX6YYXo7+3TQ
	 0z6X2TPk+gQgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/virtio: fix object leak in
 virtio_gpu_resource_create_ioctl()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
In-Reply-To: <20260915-fixes-v2-2-a0d799e4db66@outlook.com>
References: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
 <20260915-fixes-v2-2-a0d799e4db66@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 07:48:04 +0000
Message-Id: <20260915074804.EF9131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> virtio_gpu_resource_create_ioctl() calls drm_gem_object_release() on the
> drm_gem_handle_create() error path instead of dropping the reference it
> owns, so obj->funcs->free() never runs and the virtio_gpu_object, its
> pages and sg table, the resource id and the host-side resource are
> leaked.
>=20
> Use drm_gem_object_put() instead.
>=20
> Fixes: 62fb7a5e1096 ("virtio-gpu: add 3d/virgl support")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-fixes-v2-0=
-a0d799e4db66@outlook.com?part=3D2

