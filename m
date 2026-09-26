Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096A207E00
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790460172; cv=none; b=TJTNa83EySIDk/zQMCIkQiq1Di78UHG4NMpC6grK03SD5PIJ6T9sDqe20S7WwAbbubBXlY+rtxyNtwy2wTWmDSb7btBnlcLQf+Itf2mvdTtfNwhewh9KxMOqo8nGPKwAiZJmCotFyGm0alqTJ5l1vQ9Y1LT0qy0IJhg4sdK51pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790460172; c=relaxed/simple;
	bh=5LxD8HrdFOSeXhQRwxj1KT+RA3yvcAAxxV7vBp1GdtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QkVVMJmxA3VIYfO0Gt0MTD8JQkt85dFksjMnHOBfZwvL+Pn9kXneXhY5KdCsaRjwtzfE/cSs+iVfySZzMnykFlSH7Cgc2ildp+8SY4vL61HXg8IJS/FY/JVQ6hExjqjWUiyt839RMOZo2Tp2ToTNCz5Vb7J0mmbWv1Xbrt8gZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcTUrrXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcTUrrXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642371F000FF;
	Sat, 26 Sep 2026 22:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790460171;
	bh=5LxD8HrdFOSeXhQRwxj1KT+RA3yvcAAxxV7vBp1GdtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GcTUrrXHhT/7GGpgBMP9JTp0tPwYKU2aM0HUwV7QHemj1WB/oENK30IndBqjpAZgS
	 W1KlQwT9QWoRIrU73iqJ2ys+Uvt2cl0U/tMta4RCCTmIYWwjjqdGNQl1plKBf44V+e
	 HiZsU7R6Z1qyOfKKvSkvwmgy8V5kaHz4qgE6BXFNIh1f9yM4DVle1mBkLU34JehSRu
	 6Mcl9qbxHmSx+Vpc/m3zcF2ueu7gIHH0VESSCwIFBfM5ULIpqhIjDnQHS3QwzGyv5W
	 saBNLtbBALv/6dwvNKm6l+4P8S4OGruP+NiKw/omMrhzvjdspxr8IN9h7T7vdlXaiL
	 eQKMDu45rurJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] vdpa/mlx5: Don't free QP buffers if destroying the
 QP fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260926215632.1343807-1-oss.patchbox@gmail.com>
References: <20260926215632.1343807-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 22:02:50 +0000
Message-Id: <20260926220251.642371F000FF@smtp.kernel.org>
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
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926215632.1343=
807-1-oss.patchbox@gmail.com?part=3D1

