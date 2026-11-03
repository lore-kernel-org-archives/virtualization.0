Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704161;
	b=bRQVuvo7zSvY9BPiyeaqMIuyKz0ylrWR4YtSjo0iovdiEL3o2OeGhhK1SvhyOadWpMC1
	 WbK/om3xtKPEJNJinxu3umtvMNzgeeEMWm8La3l+65SyWDifHbK7FUPEa5PjORyMHImh0
	 KPJaIRNLtXZczSXb7SNuqfDgbrtaAN19XWqsIEibycbyVlxDRbJVuZIUxNFoadZZhYVNx
	 IcMefYL1Ouh0IzG7sqetYDs/d8iMuhPoUklNcLkJ9kA+kbNqg2905/yU5PbppCcXvOa0r
	 pGCxf3Lncdwg7YziDruK1x7ayUuk88HtSNVzWqjDc0uEg4kZzTZA0+ibMmUpDpzT5sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RjLAdTC04cFsxYRf/4T1r5UR973gBMDOQBPz0/c2HFA=;
	b=5R7E814S0IXr8g7GLJvB59UQfllPBeujQX4ucJUgfgnFT81EuAu9X3c1l0sAuVz9nEid
	 M9an06jdCLhj2gOGZ2Qyvx+mxi3ouVvYR5IE+6MvW0v6q+VUC2TfBU6SYMWNnosaVkDQM
	 UQo6Lo44XbPRDrfMoUhyCa4AbKBoJumZcTlx/oTg/Wo9uIiOa9/LfuraQG2/wHl9ZEtOz
	 x5x42e8lh8cWknsYbj+lZpllozBeUBJZkl1KGFbZo7rXE8Y8Y7pqv1D5AWAPYJ0ompgmu
	 u8lcfi6plfP+3XwCUY5TkL6DyKD5qOMPepVoymYMbYPM7MdBw+lyr2PwPpzaZpcb1+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLBtfM4e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21381606A32E
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLBtfM4e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57B51F000C1;
	Tue,  3 Nov 2026 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704160;
	bh=RjLAdTC04cFsxYRf/4T1r5UR973gBMDOQBPz0/c2HFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLBtfM4e8KS+WgW/Ho37N3SSkyqVbOQ2kckV0DOhDbZ7NJ+x/UAybo6v+90uSHJ9C
	 7pIq+BWdTMay9q5ebvyk23Mn3RMwM5x1Oolwr+VNAzKVrAcuWw1AyymUeEXV5e5O4G
	 buHdI7X5SZNu7gRTZ2ZY6R8mdze39rNl9yk8usA+7H297dwi1qw0pW5/ElRef3C+ON
	 L1NRFdI+B2jUu7j3LGqHiQv9jLQMXPwSdIg18IU7uEzyN5IfhdZFMCgK+t9YiHrqSx
	 41B6BxrqUpclHokXv7z3wSsmq2aWV5d5eA49fbgE1jFLfG/sD8cmEx59Jtsq3MVtti
	 mmtVLsXn/buYQ==
Message-ID: <sashiko-outbox-195117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 11/12] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-12-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:09:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Queue staged capture period notifications on system_highpri_wq through
> the common scheduling helper. This allows capture notifications to make
> progress when ordinary workqueue workers are delayed by CPU contention.
> Playback and ordinary capture keep schedule_work().
>=20
> This preserves the existing priority proposal without mixing RESET or
> lifecycle changes into it. It provides no hard real-time deadline and
> cannot prevent a userspace reader from overrunning its buffer.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D11

