Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57C1A9F90
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119717; cv=none; b=Vk+0BRz3djcxKx2lxRB29qkNANAlNUmkPeUgz5CwzTXVSx4dlTvXgfxZ3Qby7kswpurcFrqdo0AGDioxKOTqzlCxNAY5rIR1tB9hsAgHfYqD/Jt5TCmwfIGgZnWKWbVCuiOd2/Qhq6zBRuvKUgvlGxLBVCw71m2+fysb+280aMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119717; c=relaxed/simple;
	bh=zgjiMgLjuoWTR1clda0npnXsAKrqAaiy4eNSt60Pl9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H+sz6xG/zyDiQCE9LCaFADc3hMEyJDn9pbmHg06PQ9fk7aFetk4U8k0qEIIsAHwyigIIDgze6hEdqjMSXgFSRuYrvDyxysLgaB181gJA0E0zLlMC099d4IBdSJ6lRhbToVJmFFS8q6cjCdJmH790FXTadHEZYHMAD1C4TxTLoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kR022rXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kR022rXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355911F000FF;
	Sun,  4 Oct 2026 13:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119715;
	bh=zgjiMgLjuoWTR1clda0npnXsAKrqAaiy4eNSt60Pl9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kR022rXEonx9HRYjUAKXR2IWEVStgliC0/7dV0p2v2fZWMtpnBwtoD/s4Kgg+LtuX
	 JOSZxJvvLSU/KirJ8u33eeDjHKaCtvkbChnWA+BPagTPWSunbbBlqoxHiBNnPbITJT
	 NDoDS6w0jhdvamB15sY+X1GS2FDbPJ8RSkONhAnKUOxUSckSM4obY6wBHpxfylsEvX
	 90BJcE0XlsEoiCF86VKvh6kVe78Yk2VtFoh5vsOYVuqt3zRVsf72ToUhXOEl/PrDCV
	 QKglRAzWNbK/IMP/h0QqSndmaf4Xwfi8AaCrjT/6CAsQEy6khKnvp32RMW3zZR8E2D
	 f8MIxLiwJySSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] iommu/virtio: queue an UNMAP for every removed
 mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <tencent_3459CDE83AD42E569670D36C0A1FAB7C840A@qq.com>
References: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
 <tencent_3459CDE83AD42E569670D36C0A1FAB7C840A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 13:15:14 +0000
Message-Id: <20261004131515.355911F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> viommu_unmap_pages() removed whole mappings from the tree and then, with
> mappings_lock dropped, queued a single UNMAP built from the range the
> caller asked for. Both halves are wrong in the direction the device's
> semantics are strict about: a device must not split a mapping, so the
> driver removes whole mappings - and an UNMAP whose range begins or ends
> inside another mapping invalidates nothing there, leaving the device
> mapping memory the driver has released; and between the removal and the
> queueing a concurrent map_pages() of the same range can put its MAP in
> front of the UNMAP.
>=20
> Queue the UNMAPs in the critical section that removes the mappings, one
> request per contiguous run of removed mappings, covering exactly the
> mappings' own ranges: a run's mappings are removed together and its
> request covers all of them, nothing else. If a request cannot be queued,
> the mapping being examined stays in the tree and the walk stops there,
> and the run whose request could not be queued is not reported as
> unmapped. That is not an atomic rollback: the run's mappings were already
> removed from the tree and freed, and the caller is told the bytes that
> really were unmapped, not that the whole range failed to unmap. The
> request itself is still allocated on the unmap path here; the next patch
> moves that allocation to the map path, where it is allowed to fail.
>=20
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Signed-off-by: Anlai Lu <agicy@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_D757B544955=
DDC509B5DC7161F425620BA08@qq.com?part=3D2

