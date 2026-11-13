Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563235;
	b=dFwautUqJV3eRCCiJScrXYZO4poB3KFKphPMytpE1fyGbRgcaEQY6vdmBkPim5Hbps62
	 oe8+GZtd6UPztbNt9X7wXEQy4y4zDBSbzpfd04lkgJOw3aDuVPlL7uB5Ic4lMmNkVG1Sr
	 AbhLcWMTm3u15QLuYOf7P5hweXqstB7XjlAjB3N5pSY+9siAhFUCOB2XIffKSodnHH6C7
	 bEzNkhes4J3MQcAYO7Q3CT7OfFzJo4p60Fknn7aOlnvw4C3luKO103qxjmy1r1m5Tpe3C
	 D4D4aL4Ls07y6hhG0554NQSdXYe1NlwQko8ReJhGG52n/JvghLh2ipsIhcHOH3x39ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z9HfWRYiyQyT/WllZFk0JTw1H/M+tqma12fA0l3loxI=;
	b=l8yOxmxH7fvn7OHWfzitrNwNR8Cjy1uQSCjS2jkWCWgf2ehc37KVF1wnKdxWsWlCDEw+
	 OOxMTPfiNUTBbldyJzlA7Rdl69ugD45Vgxhsavjsxt29aKkp8LnUlw3nCwoh8G1ImBdrK
	 P/pHG2u7r14rfngLvx405ubIrqf3QIi6fqKf0JaabxCCHfUyfWKQuZNg2ELMZR1VJi9u3
	 RiP0kzF5RzRaSnixcrxIweJB93YqoTKL9yVEAi5qJlHByWgLUrINIAI803hU7iENI7kmG
	 FexXcd6ap5Qv6MSD78u8rHl/PnuyGwbxbADBaqxxMsz5/Zdxe5+xQnon3cHgE7LVROg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPx1VyKN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25284606A323
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPx1VyKN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841F31F000C4;
	Fri, 13 Nov 2026 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563234;
	bh=z9HfWRYiyQyT/WllZFk0JTw1H/M+tqma12fA0l3loxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LPx1VyKN9lohNPuJxqTQGgK58VOAkEN/dYknQ12uhjAMnwU4j9r1fO1p8NQ0nG+j9
	 0ZoIkpCtqsknEPS0IaxpZL/3xWaUgijx9y42v8k+3l715LaTrwm28aV2brtvF+oC/b
	 uMbWbRYRUlDJTky/8nYEbXDoFIJtZ8EVAuQurrKmQwGN5lPS+3TuMPmIuzlVoasdZz
	 gQuMS0Pflt2ZKPziIxl5e+1yb/w4yE8SRy0gnqbEIuPtHPr0y+kBU++HL+5l/V149v
	 0R+vHKKEng96JO1Sk3JFFPgrXwNzSvGWyuQJDGkz07hxXSOFMQxmqxJFc5vX99gcpN
	 mp8Obhok+b8Jg==
Message-ID: <sashiko-outbox-212568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 07/18] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-7-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-7-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:47:14 +0000
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
> [ ... ]
> wait without submitting RELEASE again.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D7

