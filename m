Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991690;
	b=0J3zTAJfFKTbb56m92KicDO1BxEHO/l6BSBwZxSvrmWjVOTONyrpbA3qxWzp9ut9ifKz
	 YxeTjuvjZQ0hgGs55zt8MErQDCzFd/a6heZEe0e3nREZBWOfmVD8v+DZER+GWMpMar2St
	 MyiaQcobxuf4tQ8eB6XCPNI5LPUbTx9GPAxTcL+9GSCgI3Ez3xkqcSX3UUKtU9uEXe1S4
	 pDDFhYOvgw6wNfA0qi31AB4tJSIG8iX3KDmqhUa7y0oQSdodUH2RS6YMSfaJwDY4FEk6X
	 AheXUKKUAvtJkWxUSrMXiwzNTdY/4AkhWzbVvHJ1KfhhesCdHDgGTLZLHAkWY0rxXIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DamiEuEBFrGqD7q2rsUuxIlEQjAIrpZlZHuwbm9BD6E=;
	b=aGfjIBsQnVSOrqjc5FoobwrN9pMnOL85TaSfD+EfyG0koJ4JU627BBZ1ovjECKGWCWWY
	 B1mB9QRufEmV4OtrsA9skWsfh2sJZHdqeYGZNN2SqMoR8FGgTdw+f1E3m44ZFvRHA2vPl
	 N26tabIK7I3v2X3uSJGXeeaI4vUwPDxNhXxouW6H6cYD2YIaGOuShthyaqVpEq8vPyLMz
	 pgmnDuD8TbXB8umLNwxuoBJNni61IOvZrJoZgjNBFubcKMP9L323ZxRWDpXD/km5q9cUd
	 j283p0FFAlvRbAaIbXOS5YJHqmq+zFCkvW3VXmzGUlPpkbDwQTvw69MJZ6mJapKrwIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtxxtdAf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CD606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtxxtdAf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490821F0089F;
	Fri,  6 Nov 2026 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793991689;
	bh=DamiEuEBFrGqD7q2rsUuxIlEQjAIrpZlZHuwbm9BD6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GtxxtdAf0M8uxWy3I33/Fcr2nvGaF2X7LHVETccUcRnA2tQiItWNMuMD96rkGCIcu
	 JcUOpXGBF3+WjFdP4Hi2OmHc4AE5n0RGMNZ3TSCryjPgo/pB/JDsXbQ5+s53f/N8CX
	 yXukIbsxI8KHLTBrc3FPOgNR6WS1BpSsfHEDoMVRYCW3b7jWradvyH4nnqnFGu6lCt
	 Tc/XiZEJxTameIUm6F3et+NukCFClHfKI2pJ9wW7lWkZVXlKQYYYtcfMCHqZWMKBLv
	 cLgpYMZwD/Gc2GKitfeoLrPhe0pSWwpcJoaq13P8KO0bJIh8OgSIjBEP+ZS2SBAIkk
	 B/Mru7mjrNPJQ==
Message-ID: <sashiko-outbox-202125@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 10/12] ALSA: virtio: serialize staged capture
 lifecycle and defer paused XRUNs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-11-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:01:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use request-owned RX storage and separate produced, observed and
> consumed positions for shared capture clients. Serialize lifecycle
> operations with lifecycle_lock and ACK accounting with the PCM stream
> lock.
>=20
> Close ACK admission before any sleeping teardown and keep prepare's gate
> through the core pointer reset. Reject unavailable epochs with -EBADFD.
> Real transfer XRUNs arm stop_operating in ACK and pause/restart
> triggers, so DROP and prepare retire the remaining device state.
>=20
> Track RELEASE completion and rearm release_required immediately after a
> successful resume PREPARE. Publish the resumed prepared state before RX
> submission because a device can complete RX before the START response.
> Record suspend state even when the stopped stream has no queued
> messages.
> [ ... ]
> access. DRAINING state alone does not authorize access after prepared
> has been cleared; retain the explicit PAUSED/RELEASED exception.
>=20
> Restore full-ring occupancy after active RESET requeues discarded RX requ=
ests, including native paused RESET. Keep linked XRUNs latched while PAUSED=
; publish them after successful resume so the ordinary pointer path stops t=
he running group.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D10

