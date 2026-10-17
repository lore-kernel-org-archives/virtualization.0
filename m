Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE4379EE0
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214440; cv=none; b=ouZOUPxHi8aVr9s4GFuOh1Bi76t2aqnU+PEcLNM0aDyGqq4MUsJTlDzGt3ThkT9XoeNsCwJh0/m5E1Lh2r0ulHg+qwB0RdmI8lP5JV3CN4mZSR5qS2ekz+bf6xCDmx95nyXNcLEqkpz1Wp6DAPRKdvty7mOiKIhXWmY1cqiLWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214440; c=relaxed/simple;
	bh=6Qmf/KClz/iTcDu4hQqFO9ynxDSHetmZjKxpu2An3tQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TtqVAcdT2y9XpCq0eMKWhtmigjOObW8uroM8URoViwNp+gnS5ufVG+4IyLjXVUeme4Y40cv2FY4pcLCjAo09wsdqcFfqIa/wStNx3JKtfFxG538SxW9eV+D0v5fxcDjU53kfFbaNYzJ4XKPdri/hDeg1xadxw5Ryvv1Lcz4qCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW3MJsJM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW3MJsJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13DF1F000C4;
	Sat, 17 Oct 2026 05:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792214439;
	bh=6Qmf/KClz/iTcDu4hQqFO9ynxDSHetmZjKxpu2An3tQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WW3MJsJM+1IcjLLR7ZIQtCM4ZMMosGfqD5w5qULrLPjMws584iHv8LNcdKYDtCXvl
	 MNJnaUnLaNmOUXyK1berQQ4fbeGxlXpXeUpav9RrTwIt48ae+CqXbEtCO9mmqr+n5z
	 shuCaXN3mPAtrav/YT3hu/uSd5/G03GqIqXVxeE+fe9ZwxPnYqgtvmY/Ni3yNJ8MmN
	 eMhw0ryjw/uFaPU6n0m5a/t7JyACXF4l1ZzxI7lHLoTTWG2d7q/QeNOUTEFe/fFOxD
	 GE2qQB4mCluVT06RSPfF8nanssIlTcbgq8DZgIAVMEyB/9E85gyGJuWMWKV6Ipl84V
	 IF69r9hNdqeIA==
Message-ID: <sashiko-outbox-175304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/1] ALSA: virtio: trace control message lifecycles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <rfc-virtio-snd-control-trace-1.208f05ae8ea44e77@gmail.com>
References: <rfc-virtio-snd-control-trace-0.208f05ae8ea44e77@gmail.com>
 <rfc-virtio-snd-control-trace-1.208f05ae8ea44e77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 05:20:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/rfc-virtio-snd-cont=
rol-trace-0.208f05ae8ea44e77@gmail.com?part=3D1

