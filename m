Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759798;
	b=bBaPdzmjqCbhzYoShsF65LstV/z2Fv8BF7LJSAzfQEgPazbISpsgE8pJ2QYzK0xsn4vG
	 vpZ8nLEXg+zjpKThHVTLfFMGUlBULqpLH+0m8DXuTi9oNZue3dYXmu1tkBlyu9FGrZaRt
	 WvuVhpwVMyULOYhKn2TtIfljUXGmYT8ko2JyNuwATsj+QzkssOhd7UUmksQyO/N9nFfAw
	 4+cYsCkD0CETN3hXUG3pvKZDARIMeSUV115TZOw7zbaSNrQy2VKXztZ7u91puvM71yC9B
	 5BX2ACI/yZwlYxGyM9kg76zsLygioDhLhu0+bHnxrCYOQRpAoTk5Y0BFUK8QsD5KryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BO8qsIlsFtPyrVBMK0H01y6TxRi9RjNEXqKYXyrJSxk=;
	b=iBxL3vJkphrttoMxQAa3vlfOLifBpthCDdZpxSYENHD4SXT4RnMwyuw0Ry5VO7ZgNlZQ
	 iuwZxAFujvx5J8lUmtWJT5vnxxNUwKnIuXu6Y9Q4rxv72VD3CExWQ0smRu9k1RvBcDXUJ
	 VHrDUAXPSrUijqf2WqHKdYz+T+D6EWgyJm0+qbaqTKFPkZAq8Igxvbsr2YyTrnPg1rcaK
	 SGn6Es1+Z8/gAPraIbtTQ6yNpiVTHLfSDDVql3r/h04Vwei5wu1ZDuVPUEzjVaALUIAOp
	 me1O1AbhZhcsp0iUvjlJih00DgbHfnKTA1TjhxQzlu6ezVNCulSw9jz0yygUZN3E77w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diSoa8Yi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4CE606A326
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diSoa8Yi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467E11F000C1;
	Wed,  4 Nov 2026 02:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759798;
	bh=BO8qsIlsFtPyrVBMK0H01y6TxRi9RjNEXqKYXyrJSxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diSoa8YiDgmDdKzlJLot0nlyBNW+ZuH4ZOJK2Jm04nvONVlMT9AJ1wJM+4AFgvyDj
	 b5GtuHT9eTp6IbH6E2M2yH4a4wYU0jpa26W8UQ4Anycl26ovfIEl6V7N5uw7lTfCGt
	 FbIEjNXvDVkgjRoC9USKdDz4fH6ym/H8/4NuHZuXY4hgpxoy1VAWXV9uuDFrA/QrbI
	 GPjRdisKiqLXYAgd7/LTgUALQXoYSy2g/VO+bx5EYZ0K1XPEu/eJ8vhM8Xyn6eHP5e
	 ebl1UupRUbJM+I/F8u9BHW2h3wEg26iAxla8GrSF8iIS0e+hPmZMJrotcVLBzytjfz
	 0/NnG7dEKWKcA==
Message-ID: <sashiko-outbox-196501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 03/12] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-4-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:36:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery.
> A negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> Linked RESET and prepare stop at the first error without rollback.
> Earlier callback members may already have completed. Legacy members keep
> [ ... ]
> callback retained an acknowledged appl_ptr of 64, and finite-silence
> playback kept the written prefix while clearing the rewound tail.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D3

