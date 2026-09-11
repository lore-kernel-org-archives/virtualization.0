Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B91A3166
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138541; cv=none; b=K+G6hNXY8Ro+2z/4DaQ8DdW0kfxiT6kEdEvyxghCJWvH99cmTkCS+1h8BpKys7hhlcaib5dTq+aw87qjPazgsgi8IR36o8hWG4E+DLqrMx3638zvXgVSn0oHUXDhjsJFVe6qcVWxDci03ajQywPcKVYFjaksAMXfg7wrKLlbAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138541; c=relaxed/simple;
	bh=Ehlxs4vtMgR9RcAlIZUqnFbAgU2juQBBekf61dpk1gE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dxh8U8bRNdvYtDW4hn+ZBvDmVxeEr5TuyBNZwWqOIPJdy1ZNhNpbGewaFkn/finzr1RYN9RgW865i/V5Xy+6s4eUHLoiH81cFozvRuIpn/TisGaxaJ+9Lp8HW7uyWUmIvdEEEt4y7TId5RuBsBTwWTAiGkhOqQpBiUE93fcLS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjR9zfv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjR9zfv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23C51F00899;
	Fri, 11 Sep 2026 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138540;
	bh=Ehlxs4vtMgR9RcAlIZUqnFbAgU2juQBBekf61dpk1gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FjR9zfv4KmsnbMNjNP8zMHEVtTLrSZIKhwZoINZiiIWxAEvJ2hGhu6t7rV34Ww4Rt
	 rScV7PUuqn+/Pzc/WY9c44DO7Jq5vMCDBdjMg1KEZh2/AYGexor8ZJnZAo8LfmtnYP
	 i0Il5CZkeZfP9UIlCjbl1xDKn+Zn2Q0WfCXIR46PDdkLRb9v2LVxfCzYm6UeAjfTqa
	 evuksuBhBTzGvFDf0j0bUvGcf0WeX0sC/TStxcU2IzVw/t4CEW9mBLc2/u94yg5SNU
	 +6cVp8QaeX76boFziDXLC4kCsnx6jeNueZIc+Afm7CTIrYPFQYtIYmQJkLVNO6ox1D
	 4+ovlQYjqrzfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] Revert "drm/virtio: Allow importing prime buffers
 when 3D is enabled"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
References: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:55:39 +0000
Message-Id: <20260911145539.B23C51F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Guest userspace may import udmabuf to vrend. Vrend doesn't support guest
> blobs, and thus, further 3d operations with the imported blob are failing.
> Typical scenario of the problem shown with mouse cursor RGBA image import=
ed
> into virtio-gpu, which previously was rejected by virtio-gpu driver.
> Revert enabling guest blobs importing into vrend to fix the regression.
>=20
> Link: https://gitlab.freedesktop.org/virgl/virglrenderer/-/work_items/674
> Fixes: df4dc947c46b ("drm/virtio: Allow importing prime buffers when 3D i=
s enabled")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911144204.2089=
401-1-dmitry.osipenko@collabora.com?part=3D1

