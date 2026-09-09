Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A52F7F09
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936739; cv=none; b=c+ZYMPu3kfSF5+uwC7Lkv6nc27XStL3ztJZH9Xy3Ss3m8fQ5sJYEs/y6T49xp/i4JPs1Qv7ivou/nT48BY3pPDhOZrkzTWriYzlkZ0S8O5h2AI6n6DdaldnrIxyuYMYslZ5h0ZkfYCeG8HK8MH2nHwhZZxKh3AUcPB/T34catfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936739; c=relaxed/simple;
	bh=lATLO/WyySd6pHJn2OuRcVuNBWp9YWRsoXfFsx7Ck98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lvcFR3o2BSqlktxaSQAHciDMDv4XZHityzlMB05DWGmNi4uWFiiPrsSR8lKaxqLx+sfeDdKJIf3INqHDO0X0UjvRn/uTwexS2EcbY6jELxNu9fXYFIHGYfcxSnScL8hlsTvNOmw1pJNjq6aST+9rgtfa6C0/6c7rIcimEnx40Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlbNdUr9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlbNdUr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CB91F00A3D;
	Wed,  9 Sep 2026 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936738;
	bh=lATLO/WyySd6pHJn2OuRcVuNBWp9YWRsoXfFsx7Ck98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HlbNdUr9jCi80lbFd+raz7AT5qgURWPZIKqHavKQz1513Xprw21kWQghDdkPxU1N2
	 GvhYSoAfqqsQtm9NseJ3oJo4RgBJRtO1QTKq6zxT1Hyyan1e3JCeikrVfbNhafX349
	 dUj7fv4yq8O+0DP5skPc9Kx7hxx6Y3NwcmDn0448Oec0bhmGU+bcz9/Txv26ctxPhU
	 PNDTyq3SyqlfcTEYswfTFYJd/B8lsEhRMj2H+8gRfZ4rKsHTPi1IyrhurXDkqwoa50
	 /IeLp5yp51nTH+vrFSUB9/sg2zI3A1RYcEbdWMiFngAyJkN5zDMxSQI37vT+dBNpM1
	 mwSH/Madj/fww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio-spi: Fix virtio_spi_config kernel-doc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260909064938.90995-1-kmehltretter@gmail.com>
References: <20260909064938.90995-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:52:17 +0000
Message-Id: <20260909065218.23CB91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> struct virtio_spi_config contains max_cs_inactive_ns, but its
> kernel-doc describes max_cs_incative_ns. This leaves the real member
> undescribed and adds a nonexistent member to the generated
> documentation.
>=20
> Correct the spelling.
>=20
> Fixes: 6a1f3390fafe ("virtio-spi: Add virtio-spi.h")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909064938.9099=
5-1-kmehltretter@gmail.com?part=3D1

