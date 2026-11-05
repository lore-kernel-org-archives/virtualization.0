Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862897;
	b=l1y1IcbLux5YFAcOT8V3pXNPvCZ8H2HaM/BBjIaX1ctlIFGlClZ6flLFfzaUCC7MYpeC
	 DSMpMeRu67smVk5po07TQsRP6td5bihvx7MUw0dftN2HCpkxGWO4kb0LhBV0rVy4A2dWL
	 9ioxiPSzVbJboumuUXW/+j5F352lMEG07mW1nW6BnK80B+SviphGPrCe/Yvda1g1aQkcI
	 cm4YF5sZHrOdwsiL880AbTEXLo5N23ONTfjYQ6y6z0etyoQYJGKmoSw0bv7uVxhhBicir
	 vtyY0iPXW7IGx3rNZzDA3qqEcJN/SqWTZDG8C1yJdGhjkMPMVV4nwOKipzzGi/iLYZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862897;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K2zbkjWeSjAVoVEc6COlkmqjHdkBItuEDdE38GQ68HU=;
	b=xCwHl0N8Bl5k6BVQhQK09R0BnutMWp3bo7fVPjFLgJ+U0z/UOwpIkq/eY/NfP/IUrwTK
	 ryqqaL2svFHDSDFZVYSaOO/FwNROpEYYmlkRVe5x648pZS2Mk/1+mYhRS90TulreUlQo+
	 /+a1rDnkNKzbIqd5SLsI4+E1V+ISj/bI4+gh2AWayv3sNVT0opmqRiURjQ94c/QY/DQjw
	 AoAI7Xa28gc08WYbGu7zObAHTI6P0ftfV2T2hBdTUnL347SiU/S88qCrNu4967g0J8w7G
	 lGknmdvWHOVHL/MN4OjVRg6V/+c/8FJ7TeMdDkS/FEd3l26nWxLhfN/TR+2Ttrr03fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvZoJtzs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8D606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvZoJtzs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B181F000C1;
	Thu,  5 Nov 2026 07:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793862896;
	bh=K2zbkjWeSjAVoVEc6COlkmqjHdkBItuEDdE38GQ68HU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dvZoJtzs8TAhHygzXdAhV5CxP1/2SKhFsjj05oHbSU8lYNjBMnzDkaykI89tyMMZ1
	 Aa9U9F8yZ6JnoV4OMsVN/EAWkhzr+momRwJznSdi7GUHPZ6SVO4LbbKU6hjgwuNL6c
	 Nvs3EysO1R4YCOtwCM/I900iDiXMdDaqYo3PG29VPE6h+Vq6UoSKMNO08Yo32QBuTm
	 vKfVVYMns3gLrQZ3aw27Ygqltza7BEMgWvlJnOOPQQ/Qe6W4iz7/lojnSh4Yz3Y7xE
	 iYuSyjkBd4hQshOFxFjzK8GY7tRH7okTGW171+QBHcXP3H1m82nW/WHpWjzULW3ewA
	 sS1g+YNDgJTRQ==
Message-ID: <sashiko-outbox-198648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 03/12] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-4-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:14:56 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D3

