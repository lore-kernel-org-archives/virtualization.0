Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA07424D41
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119316; cv=none; b=Sj3f4uAspKxkWLKQEPhSJP4KiBiCzUFJEqOiZF+ahNXAPGhoVJFAwOrKQJTL5dmIgo/9ZdPfWYZIBfYSiM0qt7cSEJPStgtUCjy1lZ8Lruaq43AiAQZrARb7+c4/RUh5QnE7H6h4Cm1naFlOkUVyVqyWblLL67voKoGAB2ko6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119316; c=relaxed/simple;
	bh=LSb1Pj+y7G9cwuVfaUoNaoeCDXRtRq1dYn47TRlm/TM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dvAS6D3soOG6DSO75rzBYJsBJ1uvms4tgpxYxSjHr0e83a8669DNU+Zh8liAb543HIHfXNkwuVtdobVIcz/V+8ap8ucM5EnlWsL8lm3pptgEch3qnvji1zoYWmlDiRKf3h8KC35U0D/RkEYuLgvdHxlyB2AGzq8qpsJqfDXP59U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuxy69OU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuxy69OU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A635D1F000FF;
	Sun,  4 Oct 2026 13:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119313;
	bh=LSb1Pj+y7G9cwuVfaUoNaoeCDXRtRq1dYn47TRlm/TM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kuxy69OUc9XsTIG1UinFglmz+MzWSD3GHhO+UewsDIQUsYsOCodArP59TJuXrbdFN
	 pEqPizM+ajpt36K75tZAvGC0Ky+gcvueWmUzZv4B3vvx+MmiMVoG6kaCwMdLni0lCe
	 SqpVo4f1x1UltSE0CoPQlCkQSpGy7vsTxSbrFozmN3rhpWuEqY88mpZU0Za5mevYTI
	 x/PBPG5MHcENLXsUbt1TsORu/dXbHkzqCwCtSEgZNFIsZCo9mUax8Bg9DEPC6+fjMz
	 yIU52BOIigoQE9f+XTqFnup4GPY4DQDNPjS1n76gLeLq3YtdiOFgHJlmYNtNl9uCEW
	 BpuYMRKTCviCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] iommu/virtio: read the endpoint count under the
 lock in the iotlb paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_B82D6F251AF7CE66EA71E7479C15BAAE5606@qq.com>
References: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
 <tencent_B82D6F251AF7CE66EA71E7479C15BAAE5606@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 13:08:33 +0000
Message-Id: <20261004130833.A635D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> viommu_iotlb_sync_map() and viommu_flush_iotlb_all() read nr_endpoints
> without the lock its writers take: the one place left after the endpoint
> helpers were introduced. Order a sync only when the device holds the
> domain, and read the count under the same lock as the writers.
>=20
> Signed-off-by: Anlai Lu <agicy@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_D757B544955=
DDC509B5DC7161F425620BA08@qq.com?part=3D5

