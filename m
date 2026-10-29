Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253640;
	b=jz2PEKiUR6+17HuMWOBKXMLsJnUxF4qFswhbEnveDFWMu2NHkdAMn0a5lQXNaZYMZvQR
	 Bhfc0mabRk7p0Jlqvg8qVME3Ahg6KSza60Rqr4as4bwb/v6f2yWhzIDP9ca+ikOp0aeWF
	 nYBzHv/3jxytBiKJBx0sxgD83JMqFp/5AhWS+g2lPdABL1Ehp/oyqY2NGoo4yicUxhEiN
	 UxKsvEKTaPdNy+c7zX22M0zjIlb7hUh+dpjlG4vW5dQAFJSZrhbYxNm24oBXTGWpkZz6O
	 LXd30NM3hVjnB2QMYBfdjISN5WO2bi/UoYGlwcD6esk8Bdsy9lpPhS+XXO5vTR1JuVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253640;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xGcmFaw/A7g+hfKdBUS4vstI+rVQ6JIhu0iokO+rrQ0=;
	b=CQIm3hDM5NjuIW+tgbmK1OJbNBGmhNySwwt6dkW4n6JiYsWoEMNxaGgCyRsiCOQxZ0rN
	 xKxYumWTOQfEg/p9Tvo8X59n7w6YhXdDgDr6WF99Cr3wHFkMIDHsqhZi2/kedlnb/a7BP
	 p6HQgHUvf8y03UXTAwupWoAXlyqDixnQ716QwVjsV/dE8p8O2h8fS4CyLtC93uFmIys6+
	 Ys99fPuOGM2k+HuXkHs51BcITnsDixda1nd2CFYjPVBYPk26D+vrPSSQcAz7AH6+pQfiB
	 zcTTRW7KIu/Jao3JiKr2ipMCZQ4ZGuMQx5MjL2fDsVcznjLgcnfj+iImHsIkBVNMYKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOnUroq8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AD606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOnUroq8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A221F01825;
	Thu, 29 Oct 2026 06:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253639;
	bh=xGcmFaw/A7g+hfKdBUS4vstI+rVQ6JIhu0iokO+rrQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOnUroq8GW5rGhjRhskcDFhVBjo4mRzknoSoK8/g61mbbzm9Ai1ns4ANeel19ynDK
	 79r2N4/aVQfNZ7cxRQj/Qbx1VKzyFJCg9/dxzLY5dLnHosAAVIgc2R2bUV6RMGiQmN
	 4hLLqFAGJdTmd18oReVtePo8twxPreZP6n7FR6o2oGqH4rdPyW6OxBqFBxC/YmDiT6
	 UfZRWJte/Y6dJHgitNzetXq9C9yOA0EvNZEdS2nqXTpGPaTDt/falEfTdaKbymk5D2
	 HkaK4QJD+ukdFEYa547rt4lHvp58nUj1PHMKAuyspjBqr4JZRV7aqocNRG7W1YPY2/
	 e0Q8xjZlj0uFg==
Message-ID: <sashiko-outbox-188785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/14] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-7-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:00:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D6

