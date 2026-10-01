Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF894A5EAE
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847045; cv=none; b=TUXl1IKn8CIksA5o0QtqDp0hQBVAVbCJ//z6Y+MDH1VotGNu2Y5d0m7BLOgYqkyINaleont23mKGmrR/S9KdGLOaeo4TGKisTs6ETGUfW25yBM2lUykW5BqtpuUzvBaeyulq/B4gl1cGyKcxpOwdzwdwmklhHPBnsvaPcKxxSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847045; c=relaxed/simple;
	bh=99LV95f1xIKtrMVKjb5aRj2PTIljFKM7rgYHI41gAE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YVjfteBLNsr9lC75KC3ta8whjmBU+hfOn615lRu9jijMbh0Y/aqse1qyOszH+rkGX+89MiqLh7J2IRwtdhTP0mK4FMGD84ljNfLcgDArFORqkh1p5R64+OAQHZKDPo8DuUjdYVUEFZggrL+vpisaSvojd6CfoI92yqnR4XnZYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqBd1SuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqBd1SuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BA61F000FF;
	Thu,  1 Oct 2026 09:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847043;
	bh=99LV95f1xIKtrMVKjb5aRj2PTIljFKM7rgYHI41gAE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WqBd1SuRgTSK+7cAvzz3T4w2lVVpV6TvMkXKhkhWyXS/raBXIbFmMdVmwPjqOmBVy
	 ycQPc2yvvrzZxnY7gMsrg+QMQIo/REqgwvdKN4QRkBWhStePy2dZaH536oobk98fKS
	 70NIr1gRXnFLj4DitwLtEOwA+wdPigU0yx6gWQYNQkjnQSeRTBzDY39QKlNZicdWO9
	 ZuCrOVGj6AB2qarTqkNJtHsJCoTWTWcIHQRekrMjOAoz/jXGbCbbPx4AvThbnr083+
	 /Mjf+RCNhDIcUY5fK6qER1wxHKLT0brLganLigvEIHCRRua7HWzS+6vcOHwrCRh+Sa
	 DYXxGeXFQ6J9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/qxl: return -ENODEV for unsupported revisions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matheus Alves de Almeida" <matheus.aalmeida@inf.ufrgs.br>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261001092506.76201-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261001092506.76201-1-matheus.aalmeida@inf.ufrgs.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:30:42 +0000
Message-Id: <20261001093043.30BA61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The qxl driver currently returns -EINVAL when the emulated qxl revision
> is too old. This is not a driver initialization failure but rather a
> match rejection, which should return -ENODEV.
>=20
> Change the value returned when the qxl revision is below 4 to -ENODEV.
> Switch the DRM_ERROR() call to a dev_err() call.
>=20
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092506.7620=
1-1-matheus.aalmeida@inf.ufrgs.br?part=3D1

