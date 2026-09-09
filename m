Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A6C1A6820
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945974; cv=none; b=qsti1sq/nfuxLd0wf5OUzLpC52m19O69P7UosVpYBlvsVx6noGYQtDIR90fM3Kywdce5E1ztM9pUPUofIAHkbKt3pBKCWaJoSNyNYXUgYOF872roaoQDXK6vVx6DX3hsmxH9oWkOk9ZknGOTZ7qAu45kPLYfBS3zXjGo3sZk660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945974; c=relaxed/simple;
	bh=5KGCXbxwbaeuMtbuVvIHDtuX8CqzafPqIx8ysqH/8Gk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HjJuFbYQQndg/ygM30A824kxVgEK4qPVAyUaqCfB7BHIBLuP+8lyvfGvAKolHWHapKyu9RT/ksUQoPWMFS82qDOPXkYDIcFCD6Jy6fQnfubi4u/yAyRzwf0E1L99/ILQ8887O0RltdCNAiAjxdHKyzD71w1hjjOgLUmZkDs+m0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2U+JrpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2U+JrpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6184F1F00A3A;
	Wed,  9 Sep 2026 09:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945972;
	bh=cn8uTcj86p9TaPCZfU0IC7Cn1+3zxTK1W5oEtMcVwu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E2U+JrpTNSjqlrvBgweOK1F0Doyiz2vb2w3RG7xGLkBbvgnXyLE529TP8c/pnLFhy
	 JQKSz1ByhiAlMsoMcTs5QIQaVWvHsi4gPmxN4+MBRwgKGLUA1Mcvf9VbE/KWwFtKiN
	 Pv3px4DlwzkJsrinuqtt0N7OtYrzaUPAlNRd7JpV6qazQ+jCrDZFdDB0TEePSMzScE
	 xXsNGehuyvnXJCcKTNuQbPocJP8d9/VZRIn9U1lpcs+bsds4HrDh1AlI0XM7YLzvOd
	 MZLrSiDbbYs9DxgByudTBZUmTPnh4lVsPJZLSi9GOvvcOcCuWBWeM3V9B1sjxE8+1x
	 64bZpBv85ijlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/virtio: add missing device-id/virtio.h wrapper
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260909092000.107827-1-lange_tang@163.com>
References: <20260909092000.107827-1-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:26:12 +0000
Message-Id: <20260909092612.6184F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Longjun Tang <tanglongjun@kylinos.cn>
>=20
> Since commit ecca1d63c1ea ("Replace <linux/mod_devicetable.h> by more
> specific <linux/device-id/*.h> (headers)"), includes
> <linux/device-id/virtio.h> instead of the old <linux/mod_devicetable.h>.
> However, tools/virtio/ only had a wrapper for the old mod_devicetable.h,
> causing the build to fail with:
>=20
>     ./../../include/linux/virtio.h:10:10: fatal error: linux/device-id/vi=
rtio.h: No such file or directory
>=20
> Add the missing wrapper header that redirects to
> ../../include/linux/device-id/virtio.h
>=20
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909092000.1078=
27-1-lange_tang@163.com?part=3D1

