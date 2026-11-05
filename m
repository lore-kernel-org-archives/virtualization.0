Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847017;
	b=3oC1zQqFM2sylIq+Vo8YqKy9oaCzFP0rqYN/N9H9j74KT6s8te00/A8L58k6HWM2HTma
	 jwQbt/6eTlm6ipg8e670jhLW+RutAj8AejPIWKU6fDVuj9kUnuOTzhASedy8IgTAtm6lb
	 74W3v5LroJqf8B7YSLN6RT7KcFX4EQeIUYFltbnKj8rtR8H+gTqWQp5p0XsfSoPfdH7H1
	 CMo9y6jrziGVfSu+xwIdyHVkcC0dw//zwUfAegQttP8z6xri0P3Xk7VRxyt7UiuZTh1M0
	 G4IhKuyQvNtf8GbGL3vPzyiWqREn8hEfzFFKhiQxaN/RRH5/lcGKPAq93Yj1reuKWiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847017;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mHulQ83znwYeDTFDtGAoR26WdhJ83Lx68s7z/BhbkP8=;
	b=jI69Vvu2uv0q5aYrBxVKRrYhuEBwQPaUqWvq6FoRrQDZZc+EDea0L7JBE7Xj0RxEmrt2
	 pOeu6UJFALhFER+L8walb+xAtob7KG+Yr6Zsk3vhhU2Gy5dcoOcmfGDoMMC9JZLl8zni9
	 7VlAW0LtV97futohCp+zPQnnXYh3K2KjO0C84H1Rj36oTgnIX86uhzJ16GH8NgwCDY9hl
	 2KAKUoktliHpKGpB6CUbDulhvyybOm4ILo50Vj3stsnhiBD3KGM1/gSSAlu7YA2CjAlaN
	 aC3WGjX+J/hgYOPftTU056jKR6iU8v9ygzgbmIAwC6zEpkZ12BuReh8JGgXv1FCH0sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0SB8pCm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358A606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0SB8pCm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7D51F000C1;
	Thu,  5 Nov 2026 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847017;
	bh=mHulQ83znwYeDTFDtGAoR26WdhJ83Lx68s7z/BhbkP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0SB8pCmNRev/FcVwIVt/epu+wtJTZ5+3hkDvcbQxlAn0GpBtFV0VOPMX//7U7+MB
	 h/A+aL5r/qCnTnoVf5LnIGaEptZB5FqGWyuZzEkYh4mILk0MwNPZK7Z1i2OCMscZ8n
	 ryRv3qJbULZ7iyri/angb90SaD401XgZVgNCWzrpF8BGGORCq9cRkgCTdlt+VluHu4
	 e6C7hZUMb2QvA2BLybBE8hITCLdk+ZfuHn72s4nYSHhqdxuop3Ijd57z3eioSTzoHJ
	 Afvt77i8WtGnP50LckWxZF3aIHBNFB1hdAQvAsM3Fb2GoJERuzTxQQ5cokqO1L9sGu
	 Xol8uPAvQTQeQ==
Message-ID: <sashiko-outbox-198485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 09/12] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-10-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:50:16 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request
> is still pending. A later teardown may then submit another RELEASE
> before the first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels
> the pending request and wakes the waiter.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D9

