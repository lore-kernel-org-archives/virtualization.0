Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9F4CF472
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216362; cv=none; b=YfZkF/qNeEg6xIkkoQVIsSuy/UGIy7LItJU1K5LUiOj/CKYzchmO7cyuzJT/ncjOwIWN1fsD83ifkhdzXPjcHVOD0ALE7WejU3caHSk5kyVzOkR4BnU3ZVOSiq9odlASc1+zG1gDcz/T4hlk0xCCrjulB9VTwUfqqS1W4GGY+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216362; c=relaxed/simple;
	bh=Sn5CewIvRwRKonM8w4vkwIn0w17yB1AUu2UnFYvWVYs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CNGO9CzPUonwXa+ACPpiauJE2YmgL6SAzM9vm9+BcQe4DErgq3P0nlmFQxWm1RPHjKqRAbBz8eiv6u0EzF3y5KqH4VG3e3dHQeR+u9UZ/oKfXX68zDDUiFs427j1DcD9cly9pXTkGWJ4zs7uApoYDSiKi753Q4fE2ux6OIChLQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcAzn2QV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcAzn2QV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395731F000C4;
	Sat, 17 Oct 2026 05:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792216361;
	bh=Sn5CewIvRwRKonM8w4vkwIn0w17yB1AUu2UnFYvWVYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KcAzn2QV4mdX2BQOhgsHekKYwenENghtB2326Zl6dE4CwOHDMNtsO0PiKP9EVwFTa
	 DdbKKRl0uattv/p6bO0SRwClPeFwc8gW0lZYz8tDB4W4n4uRFWeuh8AbwD7swdlXhB
	 x5n41xEVKxOLvxvo0aIvOJZ2JTlbUrPPGVR9ziehRzNrBVwJKwTplX702cnt4ijcpy
	 UsPHV7tkWl5EmS52GSkFJ+lc+umBqvSlnaLDLriaCChYjL4Ey3SeX2E88JlAAMZ0OM
	 RkJewl3TKat1TJ2YQae/JR3mdHG5FK18yJgRtvSy8rsl/73XtTO148BWI5EQYB8HHv
	 GKi4/qdxo1FDw==
Message-ID: <sashiko-outbox-175317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/1] ALSA: virtio: trace control message
 lifecycles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <rfc-v2-virtio-snd-control-trace-1.60ead383067a41ae@gmail.com>
References: <rfc-v2-virtio-snd-control-trace-0.60ead383067a41ae@gmail.com>
 <rfc-v2-virtio-snd-control-trace-1.60ead383067a41ae@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 05:52:40 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> A timed-out control request can complete later or be canceled during
> teardown. The existing opcode-only timeout message does not identify the
> request or show when the queue gives it back, which makes it difficult to
> correlate control stalls with guest scheduling and device reset activity.
>=20
> Add a virtio_snd_ctl_msg trace event with a per-send identifier and phases
> for enqueue, response, cancellation and the sender's wait outcome. Record
> PCM stream IDs where the request layout supplies one, the enqueue or wait
> result, and the device's used length and response status. Mark optional
> fields explicitly and check the writable response capacity before reading
> a status for the event.
>=20
> Assign IDs only to requests sent while the event is enabled. Keep sender
> wait outcomes separate from queue completion so a timeout followed by a
> late response retains the same ID. Include neither audio data nor kernel
> addresses in the event.
>=20
> Leave protocol results, request ownership and timeout handling unchanged.
> The added fields increase each control-message structure by 24 bytes on
> the tested ARM64 configurations, including when tracing is disabled. No
> events are added to PCM data completions.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/rfc-v2-virtio-snd-c=
ontrol-trace-0.60ead383067a41ae@gmail.com?part=3D1

