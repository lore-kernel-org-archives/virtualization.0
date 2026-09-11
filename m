Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE783EA967
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113325; cv=none; b=AE8hP5hpjo4ew4cAcdLsJXuMvNtsSSxf3xoJCBpBM8K0pTTLLOXqXro0bYF1fB4flOFaB5ksq1ifkcKcEb6xdKlFqqPucJjktA82AiAzOs15YprYQnl2naba3UxkEUtZRvPqkh+JnI28v59GK6nGxIwXQ8yM8DOSqN3VBBUGYkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113325; c=relaxed/simple;
	bh=Iav2Cal7UxGMUnX8KZfBEmYytr6Hu/Cg3/jqaiMq414=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mQ3nnm6whgnb0dc68xaOALFNx6VlxLUgnfNTkMNU6i4UY7NnIQRZnEGD8lIUCEs5bapfGy3eCxg7VlAzNufpyo2FL1UbqsC0qHZgJS5Nn8IZj5oGU7+8j1cZJHzqhLIL7em2lY0oUrUSoEE0X1YDEnQvsVAZErEbIRYhyntFpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7K5/jYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7K5/jYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418681F000FF;
	Fri, 11 Sep 2026 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789113323;
	bh=Iav2Cal7UxGMUnX8KZfBEmYytr6Hu/Cg3/jqaiMq414=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7K5/jYnxKZp7O0CU6JCYFpb3gPtq9garwehMIzC8qIGC8PhaZzIgW4D2OLZlfAxG
	 0/99eubn2Co3jBsp8Qctnkt+ZXuJZYjxW+5uPwj87ryqkRInpTpx41X8Ed/GhZ8tCY
	 Upmm+yZGB1nVcwzvYEdvVGejlXKDjxQ5mTbzyS3TQmItmOcnPGUCU4Lrn4joUSsWcv
	 jHz98ZYmdq1OH1ZgG5TYKGtMDlhnr7euckWitpPKGiAgvNuDuARaG0CtuZyb5uzUUu
	 w8hLxck0AJn6RPmot0PeWFPy/Sm9RX2eEnQnxnTnNecJJbfREcq6oe8D/HFo3+yTpZ
	 WfCs2vYDbXATA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/13] x86/msr: Remove rdmsr_safe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260911074530.3140830-4-jgross@suse.com>
References: <20260911074530.3140830-1-jgross@suse.com>
 <20260911074530.3140830-4-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:55:22 +0000
Message-Id: <20260911075523.418681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> rdmsr_safe() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911074530.3140=
830-1-jgross@suse.com?part=3D3

