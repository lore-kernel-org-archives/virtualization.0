Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720EC37475C
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458624; cv=none; b=Dp6OeFA3IO3ZTJaUtFFC5VQshJUAYPHFeK8GiC3neBcFXRyDKX9Tp/fatpzDxrO7wEy283rwWs9GwrvlwSK3jeg6z/76PUWVJW4gqH7ntTcLyCrXr2awAFGywRslQa3ULN0u3j3Jq9cN9KKTbr3/l/qpf6RVr/Qx+Fw0rJ9ViC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458624; c=relaxed/simple;
	bh=EF2ymQ4tW1U2Z64algIG08ECO7Om/xa+Jf4IPs5eDTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RjrEmj35ncYHl7BKM0Wfciu3sl1lKkoWMAvVVsDd56Q7u+hyqPYkbsiy561U5LSwlkeSYeYFxCspejG5eGwlI+Lx8jhdWCTWxZesI/TQ2xOYQYHNlvXHP6RRZbfY5M9K7Jlc9FR172FjemjZWflUr5oa0Jk9TmPQJmG2vleApQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq5MLTPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq5MLTPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ECD1F000FF;
	Tue, 15 Sep 2026 07:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789458623;
	bh=EF2ymQ4tW1U2Z64algIG08ECO7Om/xa+Jf4IPs5eDTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mq5MLTPf8XCnZZZ0ibD++gUf7DNS6VpJCqgyZDTaKehNtgfs1/I9ctgxCbmEOEnrH
	 PxbL5vxuXy5Hoi+nMTNUtjWW+GdhrwkW1ULU9lwqHvslNdVrNezAUHH/FmCOj4r1Qs
	 tHfqfaFFraJBZ57ARkXy9DzCHizU0TuSAAvd2oNO6R//C4jH2rIYs0bRys0KP8KHYH
	 b65auMxLL/+Av5IxJiQMAW4jo9Z0nMHKvCJtcCO6ELnttWVm6ZY9bGmiaAT3t2lgNR
	 +a2PCJCI56igHlWuBDkUaRB9GIylfCAYELTmePW57r1LUruK4sJAaOluoMNt6tZizo
	 q5/W+etvqhsOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/virtio: release the GEM object on
 virtio_gpu_vram_create() errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260915-fixes-v2-4-a0d799e4db66@outlook.com>
References: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
 <20260915-fixes-v2-4-a0d799e4db66@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 07:50:22 +0000
Message-Id: <20260915075022.C1ECD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> virtio_gpu_vram_create() frees the object with a bare kfree(vram) on
> both error paths after drm_gem_private_object_init() has run, and on the
> second one after drm_gem_create_mmap_offset() has linked obj->vma_node
> into the device's VMA offset manager. The freed object stays in that
> interval tree, so a later lookup or insertion walks freed memory, and
> the dma_resv and gpuva lock are never destroyed.
>=20
> Call drm_gem_object_release() before kfree() on both paths.
>=20
> Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vra=
m object")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-fixes-v2-0=
-a0d799e4db66@outlook.com?part=3D4

