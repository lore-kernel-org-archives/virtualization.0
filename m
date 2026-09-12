Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A703ACA5C
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789236433; cv=none; b=LSqcNX9zIqeysEf5bRWAdYdheBM55qU2u40RG6ySIfaPv1puBhV11GIrLCFkmLGtVTjvkWKx9DSqvAc3NUgdx5CjMfe8X4RR0BTp/aqeUdg3X0BLiIgR5pGzEx3ilGxtp+3eissy3OnuVeAkZV3yChN4uHwWXPTyf8gz3sbaxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789236433; c=relaxed/simple;
	bh=w+fN042jq2NWvYjKx8FktCHcPmPY0STBt+KDQ7dtrnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kP4PaX+viVnSVmhmksMdDQJhiJlIqt+idrN8XpO+jhmgRRuzOlhsaXPVCiYwwiq/xMm8u07oDkOjmJCyXN6Unib+MroC5A7lG6W9Bb8YXehxqXJLSPVbwwZ5SNRJvboesUkNX5pWzQ8bNFrP+9crIY7cbNJ03fxR15RnzBW0YSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrnxChJM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrnxChJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36C61F000FF;
	Sat, 12 Sep 2026 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789236431;
	bh=w+fN042jq2NWvYjKx8FktCHcPmPY0STBt+KDQ7dtrnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jrnxChJM9UAVclXTP3F9zh+pHsu14VQzRHvZi2SXw7JrHld7a83KgNpM9cHNGQX7h
	 pMv4sr/z09nBs42fjKr+7GMYzd/CXRNFqWPTPiuERFW4dlARyXUaStkFoXb80hJ837
	 268B0VV2LqLz8IJyPU54u9SxPMCwQXlUVYx4tRaCeQfRV1Lr+YZ9hMTYQaAyQDPATI
	 DU0FdyOmV2f2gtpFDaXcgJNjPflAMPx34T3CX+4EKrZCvz3DDqxKgVeisqK9MCacAw
	 2UfRQ/o2ggJ9dX84mvOlOPGe5tXpokNmutexdTYSgjd4R1X0+eIYYZ6lH/spopA8BR
	 H3wktMOQNcPnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_pci: add missing newline to the pmcsr error
 message
Reply-To: sashiko-reviews@lists.linux.dev
To: Maoxia <2312891301@qq.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <tencent_031B923A83E0DEE884BD05D49030890C0406@qq.com>
References: <tencent_031B923A83E0DEE884BD05D49030890C0406@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 18:07:11 +0000
Message-Id: <20260912180711.A36C61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The error message emitted when the PCI power management control
> register cannot be read is not newline-terminated, so the next kernel
> message is appended to it on the same line.
>=20
> Add the missing '\n'.
>=20
> Fixes: dff4fa0e5785 ("virtio: Add support for no-reset virtio PCI PM")
> Signed-off-by: Maoxia <2312891301@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_031B923A83E=
0DEE884BD05D49030890C0406@qq.com?part=3D1

