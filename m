Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062733;
	b=by02DsZYs3Wu3u0Aaxn7+V7GGIP6Q42LJIK7lvUWXvsmXxjgCC3IgebsCz5TW+msB4ya
	 T46PRe2adyYJSaYuXVlYOtqu2Qpm35GMfI2RWl09TnhjzRFoaCxiRafSZvSL+EMRcYXcm
	 kMrgKJ5vC4FYN0yFIOUg8gBDFHUot8rJTMAD+qQAlfD+fAjZM6WrAa8yt1e3kd8Es5WIa
	 9d5xhe3pMClovAGOJfalRwfD7/QlReS9WkLRJohYFd8P5k3qnoXuumm3We2CzGmcbH3I5
	 vLFdqqCz288WoxJ0E75CYvgY6TRCUl5IvAHonS5KTjKZ/NzqGJ4+MLHRn8otXkE5dYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062733;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ENaUblYiuoTGBpp/N0Gu/D9G5pmWREluy1+ytzqOlUE=;
	b=EnLR+GkgSfEhLyfsGZJsBHjmafnq3aGbOGR+7sc9WYR12qOqddeFD1Q6J74APpMO/RDy
	 IkWFPBBB1ew4OfEk8f1y9KwQNHUUDUsixxwriCtNTtfR8Wal3nBjNZc7rWzjRE0IjKqfH
	 4KaseHsetinU9RDHzcQJJRo9AoubAxH660uYFfIiUzcZJOeoR1/9JciRfJWuk2QJ7kP2M
	 b8awhDk86c+pQ3YRhT6/gO4+OhVBAcmAZ1sBjMlHyoWD9Bc4m34/+bvjL28CYEQjF3vQ0
	 /EKh4ZPo3/Glhx8iujWQJo9DAcDmh7N29RXnLVrTIC6fkLOHEUwVvd1RoIZE7nAhqzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSyfY5xY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC403606A32C
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSyfY5xY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620681F0089F;
	Sat,  7 Nov 2026 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062732;
	bh=ENaUblYiuoTGBpp/N0Gu/D9G5pmWREluy1+ytzqOlUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FSyfY5xYeBuhXvOMW3708BJ4vdy79tQbkBHPx4s0mcLOM4aEOfMJ2teoy0hj8Ofhv
	 J6Qq38OcbO29/zbYhFxjXgA2bx+sIHcd6yGzFGAsq+kbDxU1MCbo+2hzd7S/2GJ5mY
	 C2A7dy/YmHsWKuQDCrANL0s2ZBGXnmJ7rgtkQb506OJ3yexV9sOA5e8rwjx5pyqLCL
	 npRDxUd7T/7lNwtN1+/u8a+6kE5vOaeT7DJoeqVQoFIANmLVjyYgQxZ2RVG5Zsl+Oh
	 wa2abWVCrGqOxgZioNIZk1Angej/0s/hBqFm5pZDOIbm8eK2II5froZ3Ro0jRlu71A
	 A1Bu4DLlxCkLg==
Message-ID: <sashiko-outbox-202969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 03/12] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-4-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:45:31 +0000
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
> Zero permits the position rebase; it does not promise XRUN recovery. A
> negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> Linked RESET and prepare stop at the first error without rollback.
> Earlier callback members may already have completed. Legacy members keep
> the existing post_action policy. Applications must recover the group
> after partial failure before relying on shared positions.
>=20
> This adds an internal kernel operation and no userspace ioctl or layout.
> Out-of-tree modules using snd_pcm_ops need to be rebuilt.
>=20
> Complete appl_ptr rebasing once in the callback path. A later linked
> member can sleep in prepare while the earlier member accepts SYNC_PTR; a
> subsequent unlocked post_prepare assignment would overwrite that
> acknowledgment. Keep explicit RESET playback silence processing and
> leave prepare-time filling to the normal START path, preserving samples
> written and rewound after prepare.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D3

