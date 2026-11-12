Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451326;
	b=cnNTP5jJARlweIRu8TmwY6z+uEoi6vLg+dyg0YzRZyasAhOdjRwCpCNA9EpYk1fgzAwe
	 WdpUjxsN4KCamg8BadLEOJ9+em8NP0NOFSdFiQZ/8WV0odGOJfsMljhnc4YeDZXr4XbpR
	 nLpibbgLaKxLhJm4/fM6VA6YUsWPjhyyP0vb57btvk3S0KGvzFKg/K1ZtPq+QQysvtj0X
	 U3eHuQSb3qP+AIz0M/eGWxYY7sy+YxbDhbka8SlBjqWtKXVx+CMXZRODc5zu8YsPHHB54
	 QyDUBAJSCmepbcRVW84k+g9QVcGYayn6qPvyKKWwLpIxE3+6LK02xCoq9BvNbOXWovA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451326;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m79/rK+ywYXmd+6JvJNVDP5vTejndTc+t2CJQLKQkX0=;
	b=REWO3WHoYwRNw1as/DxTA/CiVOLDbShVUMb4PZlZZSWyd3x8Me2E/sT4IvldC9JtQ7RS
	 8lb86whm2ywnM6VWgwak1oa+qq0Eywp7zI9slVLc7EstiIO7a0OdbNLA+WqfaRx4swpzu
	 7wwx5qf0M/pwCGojMjCZUjzHPQLcI50/udgK5YCB6aP51B6tvVpe9x7O7ckQOp/jwjj8c
	 LSwdfpsGX/tPS8WAjVmVe2R0zjrmXs01HDxJIaYC5fxQovypBawi1D232cwemb+JmGkwz
	 jLE/2oUS2hLcUKo4o/6fZLfowcHpdAjpnJB2XFvbQZYe/NX6EFFuo7OZpeToFFbD4Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLNjSK9K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E182606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLNjSK9K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7821F00A05;
	Thu, 12 Nov 2026 02:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451325;
	bh=m79/rK+ywYXmd+6JvJNVDP5vTejndTc+t2CJQLKQkX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GLNjSK9KCTXZrisSrfewwKv57ZSINENRuR6n2WTxcwLm6wh8STMb6B+MM3Y+zC0Su
	 nDkTevsJXOrR+O0+i/eCSENLnkyb0gLZ/TC3/qI50QcBITOTMDxdUQ3RXrDhpxeX2x
	 WgOyPT98I1hFXjua9RErnQv2y0chm+pK/Cpb2xacwKAooS1sxdV12tyo52/ICKM8lm
	 KJRlKGebsmRFLheQu9Yaduo+ocD31443axxAxA8ls50wyRMRVbet6OvVtMJ9/qtvXo
	 9WYtF41m3UcESzT5TwJO+eieg+TqZ5pJKZvSsZn49rFD48bn7BxzPjQmDdsvlLuSy2
	 5rud9bf1QTp3Q==
Message-ID: <sashiko-outbox-210215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 11/17] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-12-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:42:05 +0000
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
> Keep timeout and wait results in the types returned by the kernel wait
> APIs.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D11

