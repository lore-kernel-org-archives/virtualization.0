Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761162;
	b=bEVRgNWTWpMMKi7vkaZfH11oyzq9VYVNMffE2X5FKRXDh7oxKLwg+SarKpH47R7DoBfc
	 DAEhYPw7J9ineJwXlwZPrriUeckavFm9dgWyyCjfg8rk8hNaO5amZdAaU8iTtipGiS8V+
	 UkHrRsQekFrfpXnpfHpi2b1NT8mRxWObGZcpCmnnjoDOqj3NYNs+c0sGDrxsJlJiKu5+h
	 oglg7MAFd5mkoSiUhbVvazcODrxEy5+sRv2UImJoUfjMltr1XLDcW4a4uoW8oHs4wjlgf
	 wz0op7N8PqJWdsQgcwFJE+QhYa92mBDWBRTPnF6ty1QOF9UkVWc6bhsv6EhXgisAISg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761162;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wMTObaxRnezzdd7yDYtqbrJ78Ni5iVnnZgJMKCqllvI=;
	b=Trvsb9nVl4fcZr5U6F+Me8HiPnYmmC1A/PKbKQ+xWKos7gQdZh356QTFMAyt29uZaJUD
	 6DAmFeR8cyiZn75S48/0tfO88Q254aJhTz+BrXQrDzLFBOTmmp6gZSYDFCWhhrU3JxsM9
	 vN4ZfuOI59FvIYT85CFDNTA8sKcauihHrv6yKx7w+vkGSdnepGAaXfo0Szw8YnOyCo4GB
	 XG+Xdy8arTsCUFK+i1BHuwxamjsceTAtjdHGPkMlnX4pxdXvTVrqdy4PFC+njBcfca0PL
	 ySkmru0WViJFNkuyaPn4t7iIEb0X683+EpPBaYUIFbdoNcMhOcX4RphhA68i2BEAGhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sad/ZKeO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF3F606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sad/ZKeO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D025A1F000C1;
	Wed,  4 Nov 2026 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761162;
	bh=wMTObaxRnezzdd7yDYtqbrJ78Ni5iVnnZgJMKCqllvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sad/ZKeOIo/NO2/Ono5fV5ZRq8pM8DXqnRZyDq4hesx8iYJL7CNs50XXootcTyRjK
	 jp61t+7et5afbcE9iD8gRCTMfHxVvediqMREfHLldkJBdo306jGK8cWKOYH19G72ls
	 Xi1j1g1diHv+O8LzNqir7gVMGxcHCXmF9OcZ01rpZhBvJOvwVqUJnTYjYNXBOnIjZU
	 7s5W2TDE8XpRV5AaQjA2V5SavtK7IpamNSlsYS/rYARG9gGt8+UL5dWpMLnmiNDu+R
	 IlH70+9uxz/AwDNIXUdtm/gKlyHBr/8hRrpun231C/2cttUZHiswBkvloeeD6qDjri
	 wCPS24IBfgh8Q==
Message-ID: <sashiko-outbox-196555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/12] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-6-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:59:21 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Capture trigger queues I/O messages before PCM_START. If the START
> message cannot be allocated or sent, transfers may remain queued, and
> ALSA does not invoke the action undo callback for the failed trigger.
>=20
> Mark the stream stopped and disable transfers for every failed START
> path. Arm runtime->stop_operating so sync_stop releases pending I/O and
> prevents prepare, hw_params, or START retries until release succeeds.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE
> is needed.
>=20
> Record the RELEASE obligation after successful PREPARE and clear it as
> soon as RELEASE succeeds. If the subsequent RX wait fails, retry that
> wait without submitting RELEASE again.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D5

