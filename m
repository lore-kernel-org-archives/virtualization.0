Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349488;
	b=h7N6ih179zguUzGgoRzfCrdQ6qDtOBwL5sephaUIrG5fEj2d/IRLLKVpGEnMKhEYIwd1
	 IYl2w47vjfp2NuLjqfSFyrnI8tTWETPacfWEMBx8qBLktJW4fLijEYEPKFETrqvy4dbIn
	 Duvkm8jUuPPC1Ujwv+bczvcVfPeLs9iYA7v6NBUiyNFqsN7tlw7ifCsXzUwHEeCofQvfC
	 BFXCjn07Nvz8/cIdoa8JtUnqG4ZfdceorF5kc/+DK9Mqh2Vgc8uMI2WDh2WDHavdn5XXh
	 XwrsMrIFPblZbMYtXXi860ceAJRGIknxAhLSYpzxku5qfPpmjm0cd5nhOTFVEhDpFWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349488;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MDIB1CEJnE0DHs/6vW3NBj1AO185YaXA9DPJOErPHl4=;
	b=AYVQGG8wtLnhLLqlWnQDBttadG5ja3siZ0FzBH6LOR81UBIA4V5LOGD9XbY+aO4V/Ju2
	 MCC82Ncwo+SApr9JeKG8ATPK94WfhTwl5eaTry0OEqzlIwFqVj/2Y8T+l8DpD9ulVXoqV
	 oszRkx26EODZbdJjgZ5v+6r6wghL/flVsyuz+fqfoeJrxZn1jXAyhamFLOB3ntNFH33KE
	 J0SOG3sAGNSO30SFAyDAXRKyHtBwh6gfFI2x01YJHpjtoG/R6IcstaqO/H5QhgXDTat7T
	 TM9KKMKIj72yPmUxmWRhmRN0ugfcq9PyK16CCkSHyiDwkDp4iuxTWxXM+QEq33ZX0ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/FF6PVq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94692606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/FF6PVq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3597F1F000C1;
	Fri, 30 Oct 2026 08:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793349488;
	bh=MDIB1CEJnE0DHs/6vW3NBj1AO185YaXA9DPJOErPHl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/FF6PVq3bunY6pA79nGvWQS3I1clOxJ55a7gc09dcwdoty1J/1xf5abdakl+dIS3
	 CAKFL14fQIuhwQ69Pb+0rph1f3JJAsbWYy/51unLYbtknuK6rM/r8vTvUxmDY6L3ZB
	 uQxSPgR2iIYVAEqH7Alz9n3SffioEkuprN07DzAj6sYDGI9Lsj8kA3O0SAVdP4zjoF
	 iMcjouHK6m8kEOb5H08E7yMGSgzjnuGyolbBEAFp3M0lL2FLMXxGnJQD7DjYWAKo6u
	 tQ5EINrQaT2PXo0W7mHqacG0Mn9Z5jmhUgEcIDPQmky/yptJIzxlTkfaC+fcXJ0gaO
	 wNpGngiW0YRIA==
Message-ID: <sashiko-outbox-190702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] virtio_balloon: add tracepoints for free page
 hinting and migration
Reply-To: sashiko-reviews@lists.linux.dev
To: liuqiangneo@163.com
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030083400.66005-4-liuqiangneo@163.com>
References: <20261030083400.66005-1-liuqiangneo@163.com>
 <20261030083400.66005-4-liuqiangneo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 08:38:07 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Qiang Liu <liuqiang@kylinos.cn>
>=20
> Free page hint requests cannot be traced, and migration only
> provides summary stats. Lock contention causing migration abort
> cannot be distinguished, making these two flows hard to debug.
>=20
> Add tracepoints to record host hint commands, leftover hint blocks
> and balloon_lock -EAGAIN migration failures.
>=20
> Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030083400.6600=
5-1-liuqiangneo@163.com?part=3D3

