Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793924536;
	b=zL32DGV4ZcNkFQU46hS8H9kFY36VKC/X5tJ8DyOpqWZh6yJdPBENhqL7nq+A9HBB0++n
	 YwnLSC9HxPHLad1HDvTu6/+49HIguY1BCJLauxqBabHbQ6VAcg3zPP7tziZ2T+T5PUmr7
	 t1jOxiTB46eRBwJPnkvau/Npxf7PElO2zBTs81RnB0HYKBHJXSC9dFRZ9Cc7uwOdo8AeK
	 47xEuc+UQOK99iTrx+JGZVd39FE3QoaNIfOzp5PnjLZzGPL9bzszAGp5dyUkcL5O8u4q7
	 M9z2QLQeLJjKGjfpyG/qCkkTXSGBAk99mnvM4GR3HOsov86YNU+oqTU26CM8WcocoTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924536;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5/0l0R7QIP6W3g8IivoJgG1oOKevNv51/D6vwuvbh28=;
	b=AKnqh3pMo8SHcM00kWptmtT34bgIT9LLL9OQF2CrxrIDyxuV5dp4mTBgCeGvm6XdoFy9
	 RyqpZqe3jpDr0o4MrK4GYTvEzGfEqwR9WzEA3hrAWBGxL3vQwBe9+Xyt6eAxEOJ7poL4J
	 4pc+y9nyh3rNuYS9otj8gZ47Vyg9La4v3gsEjn4SuZDbcTmmN06mh7ge8MPsC5rgDFBqR
	 0CtkTiXyqEfg3QiXyLdvJ97gTe+FQvLQY6o8nvzf+g06sV8CGE2m7fiiu1pzU4JQSsGI0
	 UVCxP42W8H8aW+kf9sPxo4g+Ez0oQVLM/+IH0de/j3IMNNAUbzG1QqFm7lfn9RxiCRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJioZESU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EDC606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJioZESU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028371F0089F;
	Fri,  6 Nov 2026 00:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793924536;
	bh=5/0l0R7QIP6W3g8IivoJgG1oOKevNv51/D6vwuvbh28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EJioZESUFmi7+7k4avCHVUAO3c8itnrebPvtStZc779A1hIewCfsNZkf8udAfL/uw
	 x35L1dXoZ6lDzMvu8zJlqlayhG3erTzytTCbasY48hJuXNDZjJd+Awk+nNLnTaLZMb
	 FX4N7iHbIDPX6q3VVUsUOhOrXNwYCgJNg/skTALvoSwQmtoqybpBy9B4p+RYpLMEKD
	 MRVTgcPN+t12RpITv1rZTAhA4hfr1WxcMCQGt6wX9S664LZArKGgFuhU+PUD+bIZhg
	 c0CY3RpaIJ9Pia1O7ZdMqNXOL7BLqq/7Mzb7ysMwi0LWrrJUY1W8fUqRffcWtmVlgp
	 jrJOj+1jvPfVA==
Message-ID: <sashiko-outbox-200437@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 09/12] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-10-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:22:15 +0000
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
> Keep timeout and wait results in the types returned by the kernel wait AP=
Is.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D9

