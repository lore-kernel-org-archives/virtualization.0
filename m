Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553733;
	b=5kU9l9oEV+nK4WGufAEXksc0DgmLKii1YqGxRU1h0SMp/EAHHnnZWCwCf5J1MlseAlDH
	 QpZoZ8qN++yYnvLs5WiBAu6zqVy9twlpt70RukPjOvr6t7lYR0ivrbo4H72Koaxx6ztMu
	 /kFqcCM3N2jArUJD+HcQT4XaonNLMzDLqfRvyHiWDwTDDcW5863p28o9ATuYiBERL5oJY
	 k/KD6kDxGY90u2FYwL3381nFXxeNwnem9eZdH+zoSVvC9wJeKLIgNbY0Zz0CeYuaB24DN
	 B/CBeYyUiPDMCJgrKIoJvbXFN/+4Odv7rNZfpZqODlAEowFz2JzQTmQtiztY3g4hEDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553733;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+WeySJ8mmGG5NbH76IMX8I8XJbWLLuuYgRnrwzsH9eA=;
	b=jfi1s7E7QmPyi7CREBBB/kOCYK7Xpn3HGpZ3niP1nwuUr0URaCcSZX7SnLk+WZ5ZloeP
	 k5AF35ZJYIoPzV4ik5ptcz5jdJQlKI6+PjJrMwA8raLClXpZD2fPz/5FO6IkeXuLhaqrL
	 FS6HYAcvwQbsNeRb/5s63m/rBFrJmMw3JcpgCIAIrBknB0l8bJi6iacHAVLuCzWWho7zN
	 mwBVbUHB1LzDnVRRBOB7VdHicGB4+xkxYzTE5RzphJTI4BoFC0GhN/TfwhYke6aYgqpsv
	 aUC9RmQ+rC1HlxtO0fhJnir/Q/Lpan/eLH9BQSJG+/a0ecNJw1tJPc4cK4isMd4i2/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MyAkpl/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7460A2609
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyAkpl/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C085C1F000C5;
	Fri, 13 Nov 2026 07:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553733;
	bh=+WeySJ8mmGG5NbH76IMX8I8XJbWLLuuYgRnrwzsH9eA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MyAkpl/ea2e0e283DZr4t6qzopjDogR1jnPwn4H/R27ITWoUeUyXYjhQbpoA1Eb28
	 dHiXbVu5y2NxdeWL5xftkT6SZxLiqc0iQhq0XHC/He/raW2BJaqIElbu39hpntP1SI
	 CS8+VtVqaCWHiGByLsBMBIhjtYED27th3u2dQVHirlHQa2JiSIJfT6Ipm4kFuRUq6H
	 3bKuJGFDeY9pZ7bmBDEOIEYJD3zblxZbgh6jOr5KoVALdScgwir50BFxg4KLKoGl0R
	 I4Z2LmH+DuJ5F6qllxbbsbdK6pKXtb92cUgK65/pOy1VM3oGV2S3tY7JgUEy9t69nK
	 tk047W03DNy+g==
Message-ID: <sashiko-outbox-212322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 06/20] ALSA: virtio: propagate playback send
 failures through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-6-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-6-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:08:52 +0000
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
> Propagate playback submission failures through ACK and commit indirect
> accounting only after transport submission succeeds. Keep the PCM state
> and buffer-access checks synchronized with playback transfer admission.
> The existing capture ACK callback and initial queue reservation behavior
> remain together until the request-owned capture conversion in patch 12.
> That conversion introduces RX reservation, validation and refill as one
> contract.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D6

