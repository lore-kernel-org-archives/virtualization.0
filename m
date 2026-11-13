Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553503;
	b=XZXBNAPW7d5/fdeAz/296EPqV48U+X9Xd09hFdZ9m8tMJ75BVAnzCJRoHsz2FMU7CgjA
	 8xe/QxM00rm7neQYF0XhTKJWzCjoyCfcLr8kdZtADlFwXB6BfW4RALRV5ToGgbqbokUpn
	 HvGhbjfOwUQGB78eUbidYaZ6X7X3l5DIT2Nj0tj5rNWHafJbEVc1f0/40QU1x16+dgk16
	 TUgypTnhy4sBVopRF0pvxlmHMZWupg70IYvrC27FgP2jf0xo3uRUWviKv9rXEY/P4AKtE
	 wZsp8CmTd61WqK+2Pj0QpsPPVVR16csInAqwt61fUT2SuweOhH5Znd01QydQp8EKtWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553503;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WB4HrucXuuI1cZsSXOUZvUUKzMfaPdvEBZyagl2YbWU=;
	b=mUS4KJ87QfXl4yvki98KHwreOiHkYptfmh65E89sjynz4kN+M5jenADLlw7ssBRcOKhl
	 K+h4B4ZKB2Chgx1OjD4Kv+9amrbdYTQOgapaTnaHiY/NzZRiuIhGHd9Bg12JiBqt8UXsu
	 jCtsI3f3YglsxYGHwgDp4dOaG9vyOMB2Fpmayz7IWYZNGcpjHT25Z2gqcMCM3ZvNswoq7
	 R4GQKg7rOIoC9rnEgqtoEiEBwzIZ7YiBmzf8bvbPbwM0yozlX0HlLJf/JxvnmI7nilYYd
	 IwXRVlLErDFKSmksfaVG3e67G/8o1RDYlZzVoujHAh4CAT/R0BzT9Ybxa56Opx31HmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aODlPtwO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968BE606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aODlPtwO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C28B1F000C4;
	Fri, 13 Nov 2026 07:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553503;
	bh=WB4HrucXuuI1cZsSXOUZvUUKzMfaPdvEBZyagl2YbWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aODlPtwOkdxBzElwpV42YBUes6nezHS4TeIVbHUCO4Ugntn1ynlTw3kynVVEpWVut
	 nk6bdx4JcDi4fNnYVeO39EcWgLgb9MGZs7Oe2zTFMGC3nscb/7gpaCb2yQnetAlN9f
	 dejuxL8kTayzufFWXZ83j454XjalF9ohHqhPbVR26CPKjAPmdiB8EZk/3ogdg8k2Ns
	 yyOgtMTDXwcZP2oOKkzyYJNp/Xq+IXum0FhDbyIiEOus5afQdpZ/i4O8Z9Si5itpxr
	 Wkm07q9nWupUcb8aOApZSJun3YqZ9ldAX+ssT41ljmtSQW5p0XbmHC/sRa/CA1fmTJ
	 b/BlZ8L3HOzKA==
Message-ID: <sashiko-outbox-212312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 02/20] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-2-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-2-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:05:02 +0000
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
> Allow a driver to publish subperiod progress under the PCM stream lock
> without generating a period timer notification. Use the ordinary pointer
> update, XRUN and wakeup path. Capture DRAINING can publish its final
> tail while playback and other inactive states retain their existing
> behavior.
>=20
> Handle capture DRAINING separately in the state update: a full buffer is
> still readable capture data, while progress beyond the buffer capacity
> is an overrun. Playback continues to finish draining when its buffer is
> empty.
>=20
> Refresh capture availability after the unlocked copy and application
> pointer commit while DRAINING. A final tail can arrive during the copy;
> subtracting only the copied frames from the earlier snapshot can
> otherwise finish draining with unread samples left in the ring.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D2

