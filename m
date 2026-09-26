Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA92D7398
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790402566; cv=none; b=s7f+81RelvovRd06vpHA4yh6wYBdacdaFNC+//5dGxcO0pr1YfJX3vYrQZlcsG0UvOXFb6p2EEDwAx/UPOsZiU+g/WQ68kS1zoT/tg51munKCiBd1oIaus9w/tTvw2i5uc99eaRIBykmeuV/Wps/slI1qbiDedGUCs7ufT8unyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790402566; c=relaxed/simple;
	bh=zY2BuMFLH9FKiydFLSpZM8BLHRxN2EXqseQRrrQQx0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XJKtzPPUbMyLEvnmFuEON+du643TCZZGhBgHQA+iDUO2J0Cxd2UlB2pNfrd2Gt/i07zRdaK1c+Mh358H9tIys2frTwoX54niJL+gbJniGasdoZJaU1/pc20sUZyrlnFCcX8WrRqiJf1qoV5MRHn4iBFs9FitgJx4AAQD8h2btP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5IRwVHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5IRwVHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BBA1F000FF;
	Sat, 26 Sep 2026 06:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790402564;
	bh=zY2BuMFLH9FKiydFLSpZM8BLHRxN2EXqseQRrrQQx0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g5IRwVHu5qmbPj2/wyTWBCHaqr0+n0LEFI9WYeywwi8BXZRvYhcxkndp2AnSKDjL8
	 jxC9JluzATKpTZD9jNOxNvIN81I52zAOJ5VcHBTxLyrCjEEVkWLT2JrQ/goRBjfRqj
	 AjVcSWi1kpHWGj3xIBdKmJds+bDmJPl6mIEN/F6I7Tpool2w1ikktthuPFuCxf7r4e
	 9hVDWeD0JXfT6pUb2NNrMWrPcuOMlNEDG/RmZXUGv2DV5IIKnuwrD7/4O7adqLo12z
	 72no4V9OUGzH1calUfSop/1PjNqI2d4oV+6XPBoevhIm2RrpYhyTm2FN+w3x0FOMtH
	 r2c194+SJCpww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] hwrng: virtio - use snprintf() in probe_common()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260926055853.4868-4-blum@kernel.org>
References: <20260926055853.4868-3-blum@kernel.org>
 <20260926055853.4868-4-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:02:44 +0000
Message-Id: <20260926060244.80BBA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> While the current code works correctly, replace the unbounded sprintf()
> with the safer snprintf() to follow secure coding best practices.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926055853.4868=
-3-blum@kernel.org?part=3D2

