Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139B3D8104;
	Thu, 24 Sep 2026 03:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219635; cv=none; b=GEhN4A48/sYYi5KgyedFTnN/4wsYYTQo5m+/GrDnn99rJ7BfzAb+Ewa9dW0HkSUidPAhzYK02bUKG4Qy+J3WqpUdiWAMQldz+MXQKKgdDrUhnBIrGXN4cvrw9/rzcRYeY6BRedwDoUsjsfe+ehR8JuSdx/GF7xJQdxtOkun+by8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219635; c=relaxed/simple;
	bh=Xvxg/8GRuEILNmOnzW2BXq9J+76STO06duynEz7CLWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nUrHhQGpBGL3uLRBMZFUzlupS92Pr81mxk5Yd+ud+hPKQ6+kfcjoGU/KhC6B/vDu/S+oVvKbwLIia14pxkg07ayjML75i9/Obum01bYvS1kaWGmQNrtlcJuuT/RTrzVGwdUNl2u/tRqIdCI0zcGffizcTzmxo2XWL/vMffqMy5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6boigoZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6boigoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8721F0089A;
	Thu, 24 Sep 2026 03:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790219634;
	bh=AJmid2fBfdz8xrk3hjnnJBqgVKYuQfanfnHytMtCwEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y6boigoZhl5Srd8YUzYq7daSHSOcFRj0JNY/IU3oL9Y/43sl6B/yjHADyMdjW5Ejr
	 /hE+uVI554tnDLMmgPoZeokc0AXMIw1N0ioSc1MWV2tsoBsJL8yrWK/xYConSxma4I
	 v9oSn8adw2mt5jsy1dvaHAeLpk5q94S/hKSzBzBvF27+w4W1RMIkaYAUf2pjbGZ2BN
	 6PPuV2mq0M3KMKb0xjyEH7bq4ylfnhAyRq2v1ynzLtrAjrMckvJIiTGCWh+ZgkcPOG
	 sKkJvVJU4bJc0WoVQ2EXOrGb2M1be1mOXtlkuvboZRoJiimA5552Ykw6WS3gMgQ9aX
	 q9gRe1Ee4USGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vringh: reject empty / undersized indirect descriptor
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260924030627.13287-1-fangxy@xiaopeng.com>
References: <20260924030627.13287-1-fangxy@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 03:13:53 +0000
Message-Id: <20260924031354.1C8721F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> move_to_indirect() rejects an indirect descriptor table only when its
> length is not an exact multiple of sizeof(struct vring_desc).  A guest
> descriptor with VRING_DESC_F_INDIRECT and len =3D=3D 0 passes that check,=
 so
> *desc_max becomes 0, yet __vringh_iov() keeps walking the (empty) table
> and aborts with -ELOOP only after reading one full descriptor past its
> end -- leaking 16 bytes of memory adjacent to the table into a kernel
> stack variable.
>=20
> Reject any len smaller than one descriptor, before the existing stride
> check, so no descriptor is ever fetched from an empty table.
>=20
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924030627.1328=
7-1-fangxy@xiaopeng.com?part=3D1

