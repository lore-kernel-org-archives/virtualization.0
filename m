Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157169;
	b=bZ/ox/RrWfA1rwmQ528iMjqGu8DUQ19vwdVCnE8ZdmuIGViFun+b0TOLj+EMzC8TuMiG
	 acRU/uZ1f47WZ3dmOcKIn+jx07JNZotDkz5HNqx4Zw9N1Jd3mfotL8e6TcdMboQufcr1O
	 EKmmDoN2bbVy0d/SHP0u0zCfL1Tm4IH7OZWnoRiWS1oihSrROkcmzfuUdCxlGwELB0aH4
	 tP82TJrPDjxTOzZVPv46UGYx8/xr8Ngu9RygxU44xwwxX/8d/s9dRe1gb7vJHIyMAtz5b
	 V/F7OMs/N0GqJF/0KrWWQ5M0WVVe9IYaqjO9H5RQtMvpWLvMykd4Od+DVUhIkiCo9NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157169;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/VnWQhZqBlnPxkVW7ghGQegERuSNV6JhycCkmVvAI9c=;
	b=3C07Kk14aIcczA8P+PgjmG525lti/nMNmovh9xkDWSlVMgjxImg/0WSoFHtucvC4nbMk
	 w/5dUPLb2BtAPKcx9G8DqO2dJVTGr4jBHuZzOLrprjzPi6vVWk3ZRjVO/Y0tmHrjCiPs0
	 5CGmM7r533+dPr1vbzPiKEo+6XkoqyrhiZW41O3qXz6qYd9Q0VHMLrtfmnPhVGQvMFbdj
	 e1tJ0O0k6G9o1oiYiu3y24gto7ynwKRK974sQg9e1cFGxWrntDje/UWf53npGSZnUaB8m
	 Z/+CFqxispZD2uuoHLmab0KOB9xhfm6Tb66jW1Vwen7kn7HUwJta/wRaCGS/ZaIfy7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcskYLf8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5408B606A330
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcskYLf8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B663D1F031E0;
	Wed, 28 Oct 2026 03:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157169;
	bh=/VnWQhZqBlnPxkVW7ghGQegERuSNV6JhycCkmVvAI9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YcskYLf8hK+7E5Q01oLVhloKSOHpIQ3zshBus8eSkjkFx+Qcno+bpPfEHEhsIb6ww
	 txR6Uh01TcBjimkHP+X+Uz5sTEtwcbLqvLTrybS/I74xlWV4o0Fq4r/d2M9klzJY9a
	 U2ziQdortlpCu0pY2q7VDeb+Bk5qdrpwE4tfU5oxTawlO7Veoh/nFRUfM9FKJ7FUE0
	 Pbzqly9xyhtb8V3doPEXl03pCqwaW+ognw6G0xZVf1iUw7uOuCvkWHstAT3tco0VLW
	 Niawkw5QjHmxYgVtXLFRS+bqs1IHRM8/tz3sCw0q4mcmB7eWAFjzLjD7eVFr4VqdOx
	 NjmLShmAu1rsg==
Message-ID: <sashiko-outbox-187396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/14] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-7-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:12:48 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request is
> still pending. A later teardown may then submit another RELEASE before the
> first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels t=
he
> pending request and wakes the waiter.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D6

