Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC173009F2
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123479; cv=none; b=jg6UZhSN1jXvzXkJNYvwaC0OH2gZ6HYAgDPjdLugeiadVcnVxBf3SQFQQ2ekYVSU1+3T2NbwqFh37Ki/G+HPYXRsEWsthUw5LeKzVdDgtOKsDJDL7e84cPhpVKyngI0IHvd2QreD5ISRRyJNaJXg3yApm6YgMxaLDJJ9P9aGajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123479; c=relaxed/simple;
	bh=WYoq5I3EgZelyLxG0cZ8tpRMnMLoIlIMGrlM3mQgVMo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=l6XG0e+6vqNpNF5Fiylvr/4YExOdB3uv0ibltSMlDUppguSA1nxbt0959esdUs+72nyF5iJACjwOdAERXdFu9lBFxefw3AHtn+B+UXPy+W9UIa0L2LeVX8zqcPfcJ2BMvtBitgRm114oVlBCF3vZH6b/DgTx8OJrNnYmhr8bedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAFE7vnx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAFE7vnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907501F000C4;
	Fri, 16 Oct 2026 04:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792123477;
	bh=WYoq5I3EgZelyLxG0cZ8tpRMnMLoIlIMGrlM3mQgVMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gAFE7vnxZL98FC3mVpYCAfxO7Lr/AQcjDYhw2kMODINxleTyH4259M4sMdiVsJiBF
	 NCa5YsMEozlLBDsbpfXsFd490m5y0xxD0M5nczVOBTCgswg2VEl+gMa1rGt8uP8Hk7
	 /CXFOzLApxn28WOKlt22X0GSKCCpqhaYRYdoh6Z3QsPR4OtBXzENQ/nizqJ7tX5gBN
	 rmXHBwOYrHSrTB+Hl/3WUrUSgIAqkKYDHhOyvsNt85JjmS8684ufOEwVFU69YGPTww
	 EUp2ujLTEee2aHoNcX4Cuy0/lZkdS66vAc/TBZXPT+o5w+mWeu3d05A7CQTWzu1aaS
	 6soQ0Qa8ob53A==
Message-ID: <sashiko-outbox-173725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 RESEND] vdpa/mlx5: Don't free QP buffers if
 destroying the QP fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261016035851.771496-1-oss.patchbox@gmail.com>
References: <20261016035851.771496-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 04:04:37 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> qp_destroy() only warns when DESTROY_QP fails and then frees the RQ
> buffer and doorbell record of the driver-owned QP anyway. The QP still
> exists in firmware, so the device can keep reading WQEs and the doorbell
> record from memory that has been returned to the allocator. This is
> reachable from teardown_vq(), which destroys the QPs even when
> destroy_virtqueue() fails and the virtqueue still uses them.
>=20
> Return after the warning, as cq_destroy() does, and leak the buffers
> instead. A device in internal error is not affected, since the mlx5 core
> reports success for DESTROY_QP in that state.
>=20
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devic=
es")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016035851.7714=
96-1-oss.patchbox@gmail.com?part=3D1

