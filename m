Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20444237C
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119392; cv=none; b=rTVOmn4oGjc6RBGwYwh2IwnvLDSmGppkQV+T4lC3bX6UYJeGgMApV3Vasg48hmp0liTR/QXcp0nSHsWDyaW7H+pC02vzyUmBH6i4M5bvHm2T9OGtWFZewFYn0Lp6DtBUge8x7i9kmucBE13sprMslStUndT7bC1deHkVC7tpeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119392; c=relaxed/simple;
	bh=m9t4wgMG6+ymg52IM/3D9Ah3538KXmRqc7/3LlyGeXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XJql6lyAVNgL353TR+gh50kXLHlyjxVMRxEipluOTAFk05jc8yL3lyCmhoA7oxnF/tIp33OwZF+G3nrQl4AKWdDxDEvW1MDSq82nbHn1Q6nEHO7AHiIGLHf15z1j+94cTfv65jl+OyHE37tGEWxI8mZv1tjZPu6mIWzi85YcqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVRJ/ICS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVRJ/ICS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1B51F00893;
	Sun,  4 Oct 2026 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119391;
	bh=m9t4wgMG6+ymg52IM/3D9Ah3538KXmRqc7/3LlyGeXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FVRJ/ICSutWgtZMEHiiLZf1beR3+BkLhL3288xZpx41rJzzgf8pWoleWyeQlJahMd
	 Az5mL4e2CsqpF6qrHK78JfUcY26//YYlDP5mGu1emaq4MI2FpSCVadRs99sqPiQDnO
	 /c5dWGW6TAJSWKjq8UQQPqEOsz3015xY/JRm+NBO20QrQ15+np8QmzpiTfOi8AIQsQ
	 RA+AHw5MwWFZJzXaJJ4yvAx8O0j8XxlMwjb4NKxuTA8E/9LZ173rHNUZQVvNExuPwR
	 A5GXg+69q64Nr4NqcBp/oUzzsHExz8+By0ibbQLFLrcfN9Bt1DFmtOU6dlq8dELiwk
	 2ZiXZ/+FYzOoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] iommu/virtio: publish the endpoint before
 replaying it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <tencent_D1D6479CD59F6E5CED7C653937DE66C73106@qq.com>
References: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
 <tencent_D1D6479CD59F6E5CED7C653937DE66C73106@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 13:09:50 +0000
Message-Id: <20261004130950.DD1B51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The device drops a domain's mappings together with its last endpoint, so
> the first endpoint attaching to a domain has to replay them. The driver
> published that endpoint only after the replay (nr_endpoints++, without a
> lock), while viommu_map_pages() used the same counter, also without a
> lock, to decide whether to queue its own MAP or leave it to the replay. A
> map_pages() landing after the replay's walk had passed its range and
> before the counter was bumped was therefore queued by nobody: the mapping
> stayed in the driver's tree and never reached the device, silently, until
> the domain was detached and attached again - DMA to it faults in the
> meantime.
>=20
> Publish the endpoint first, with the decision moved into
> viommu_add_mapping() under mappings_lock so that it cannot race the
> insert, and let the replay pick up the rest. A mapping that such a race
> sends while the replay walks it is on the device twice, which the spec sa=
ys
> [ ... ]
> change the device ends with exactly the mappings the driver believes in,
> in every run.
>=20
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Signed-off-by: Anlai Lu <agicy@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_D757B544955=
DDC509B5DC7161F425620BA08@qq.com?part=3D1

