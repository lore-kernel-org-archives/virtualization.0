Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449710;
	b=UYdoFRO1FxA1WpxCt0crPSgW/eZLlx430SdYCxu47rd/MIrsxzijeNoMwBqN4rFn+VOg
	 EtW0Shx40XkW6Sz3F5G1ry9EiEUANqWaYhKX00+Ce5A7AvETLprvWpbrvd/I69jmSrI35
	 lZbIVGNy/biZftq8RC2WWFiraCbgXcfzXAMzpAKwwi/ZWVoCGiM0TyiEGhRDMpfdZPZEu
	 OF0gKkppg/sMWx6eUBuwvKqv3hYX3kHMe+zykHOOjMu/BzzHvYzUJs2tQUE89B9Km9bDq
	 c2QsahGxeGcUUKyg5hsEmW26VSdjbKlWlza184hkjbxhQ1/lnYRoeZHtwx9voAxyCMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NUcZky1YVFmoe3Pp+g+iqCZnLYc1gYrmP596nStwx6E=;
	b=UPcTNNe/1WhAwIkTmZd+xL+nQAEifhhnz1GK1gkK66gdeujJSLzev0WbMwyxB1dDj6Li
	 8JfQeGgM7R+hKqz3l5Se0Bm0qvHR6SU4OS6RuUGvf2gm/aOvsm3evwmpGl19lAvFhOnsQ
	 VmfCPTtor6wryhf0Wmw9WCOMqncu4Q4QccgBYnVCdHsDx8R6RBkNULcy+Uqhwy6lN4wtx
	 JT3K8667dJVWMK2r/HTpAJ7AdgrUwj/ufCh6LXjyH9V4TExZCAyODeZZtjvd8oF6QhqJN
	 gx/yeiWjQshWv1qBop/qxUiukHEr+3zNHeQD/GBhF8SQo4Vz8JLVXcsZxn6/KdG/oCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvaOM9zs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81B606A326
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 02:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvaOM9zs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E21E1F00A05;
	Thu, 12 Nov 2026 02:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449709;
	bh=NUcZky1YVFmoe3Pp+g+iqCZnLYc1gYrmP596nStwx6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IvaOM9zsaNK7mg749QwPVICtey+/nYw7Q10Nvf/5cR5xWibkME/9IMAiGE+vsZVdq
	 7lrXTNCj08wEUSKl5ZT+1mJ75r3qSImPIcX0ktUsZ3OTXPgAueJwUv8DddE9dHmNoY
	 j82jnsuG/9cKClEkt4YIdefL06Sz2vXvLdTyMxiSn/4YE5T/poyyjnY5O0dhI5Ccf3
	 cI3sZhD44lEUL/T9NIgPNgYxDHluTIn021MDJg7voQ1QlTGwJF5YbqRh+AKf3HWJvU
	 e2uCTOqaQYuws16DWSRTojXJD8p0GV9GDbMLAqVgLh2D7nqFIvm4lnj9OPlVgTO4Ep
	 2Fgxs3SA4zAXQ==
Message-ID: <sashiko-outbox-210167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 07/17] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-8-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:15:09 +0000
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
> Latch a transfer XRUN in both playback and capture, and schedule the
> existing period worker so a running or draining core stream sees the
> pointer error. This also retires a failed playback START during drain,
> where drain-init can already have advanced the core state to DRAINING.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining
> fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE is
> needed.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D7

