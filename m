Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553081;
	b=F/in8oRtift+5I94q5I6CgvfSDLFph2Oo9XlJhgThTqhHlaocsuXQnN0daFB6SUNo1rh
	 j6ahbn62uqYvf7VZuXqjwNGruv5KOl6miHb01QZN4ShXUIRQCbnO4hNNC7WE4chcd5VwG
	 JaftuaqfH2AoSt4LiBnQIYzbFxzq/HoImN3ddJ7EAUF+E+q+6ETmUGByYSAqAmJD/yyAn
	 Ik/4+IC665RKbE95Wq/XkjISZCyZrwO+g03gsu3YwDHBWz0gExCrqLcxql6RtR+FLnm0h
	 IWZKDgvfzQUk0gAl1I0WnlJrf4UgqqMRSt21dgE+ZorS0sXBoPHxjGrqdd5TjxYihDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553081;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yUgJ0H29+MkBfPcLAd9Mr1u97Dl4sPw7jtD9I4AQ3q0=;
	b=WWg/Vi8omgz5935gg0nOas51uHWL4A/gUqAx4QuGmTUFRuqUIaOTOXjJT7FxjQFmCCrr
	 LBUfK10qO6CT+aPKAenGyhtCuNjNo+y32b3nB4N/c+o42qcuZk0XEonKhRzA/SImI+JJ1
	 nOPF06vmNfXsYLEY7Q7aDMRoaBoC508yAQuZOnk0Az9pyyA7IuimhS5RwobmMIXT4Ur6D
	 /hIQjHl6aRVH2S+aHQqh/R1EVauwDRp2iQ+23s1bylQPXNMidG8NmGnqd4686bJgNVdj6
	 B9wtymPefyGluBOj4uYuIKxHJse4Ghwai9WscE/LW4HdoBPNVDkIsvhnvTcT/S15reA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UmcHcY0/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4F606A880
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UmcHcY0/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F3A1F000C4;
	Fri, 13 Nov 2026 06:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553081;
	bh=yUgJ0H29+MkBfPcLAd9Mr1u97Dl4sPw7jtD9I4AQ3q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UmcHcY0/jxMtK/CMpkfZxdriW7aa943PBWmWIv5qqguOmf5dge5Y7RxCVv8tEERfn
	 DI+RWmZK2gfGPSsrGnDby/ZNzYtrM0k7Oy+OnnKNj8UPAB+GGVADJ6TOG/p3EX7ReT
	 pIjYODAi1NDWVfQyN2ahMogrDN8hhj55k7JDmDmSzx5u3PxPkxWMqmuQvTLNJV9PdC
	 4xAhfb5ncojUrBK999RU271bHts1rhJUAPLKSC3pqHBcbibK3MrigPrkagMtfBLitk
	 RlNjgcuxnAhefpHToDy/rpSxJBmnphNIG3tcDR7OXXeRTmDTxVFYm+kDyzsrCIuRat
	 nhXfIA3HlC4VQ==
Message-ID: <sashiko-outbox-212301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 11/20] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-11-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-11-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:58:00 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D11

