Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451733;
	b=nM1HL6htc+lDnQbS+37g5uqeHURnbOUblkZmm3Qpbl2KiUn69fS7F73AavM5B+6E8LFs
	 9+NpkWaW6W48JRenV2YjmnnGQEp7+PUajpD5AUg0AhQKNMVpXq4WVe5dVPpQbDMOUgLyt
	 zwGsjxP3UT18wFFzxvRNhb7vnKK1b2At0kMCLzfKVXnxpl82mUG3bsRvxRUCHHX/U/QBI
	 e7kpw369OyUKTfc2Tj5qI0PqESOu+ptPVxR1l/Vf78z4yS2bYfS4LrnoiUO/Ix6ANwICm
	 9+6pWKltf8E/XR+opESnck3Pxex7nHZF/9z8LLx9NjvZh25j0YAy0+kURGykRdRE+OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451733;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MMad4+1hhpK1tEvAkyTKmZ59pN6QWbgb2ePR/qWfhXc=;
	b=L8temVlykefJE7GMIwOHgoSV4BM7FC7GqjJQVmOt54eAKaFgiiVzrMHLLvGJN1MLAKsD
	 d8M1Z7a30BoNBmUSnak/6RNbHBz26d1o1oxu4qe5XZ0R0VQoKul80l2sxqX+lIKp2G5bM
	 Sl9xD8+0eyJmZKsADc8E0v8/iqsBn6yFP/mvl5kEFCM6gsKmLFLHJYfdBr9ZnkkWQZtxF
	 1KjmgXPTpy72CzAJ7McpEmFj7r38hasXxH4/SFUawKhaHuDAt4P6uyAo0aZpuGvCsh3aq
	 rQI5TG0+XG0JiMfZMwnd9Xxt9PQBPi74KFwA7or80gzIAw2rgbwJgvMotx0rRtf7ALA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKJLgGje;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335B606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKJLgGje
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79181F00A05;
	Thu, 12 Nov 2026 02:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451733;
	bh=MMad4+1hhpK1tEvAkyTKmZ59pN6QWbgb2ePR/qWfhXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKJLgGje2Npwf6KPlJbXcwDypJ0vEZZDJlAx6ppiPRA+w9aEp0UBajKa9tIe7WhDp
	 KxdnyDjrjJ8IE0JBqSVsHxMj4t50EzlcjvVoAWMRIZvfUb7/i2Ixqtx2ObyipscKn8
	 PPrZHARkFdEMK04voQwUx8qnabFtn0VDf3eVmky4cHAWuDZhluR9EZQee2JEQJgXo3
	 p44C215NlajXXt8citnswCKZc5mY7iDsubB9sF7j0pGHilfYiAbQZr9FUX5aPT4hRP
	 EeECLmW+72nxwmBlAweaeWOvmZGbCGl5ufKjalFEBKC3NEZd6y27+lVX9NtKWO4NUY
	 9OmPtbOBfwMqw==
Message-ID: <sashiko-outbox-210222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 13/17] ALSA: virtio: prioritize capture period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-14-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:48:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use system_highpri_wq for capture progress notifications. Capture now
> always uses request-owned storage. Playback keeps the ordinary
> workqueue. This preserves the priority proposal separately from recovery
> and accounting. It provides no hard real-time guarantee and cannot
> prevent reader overruns.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D13

