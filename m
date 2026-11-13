Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563355;
	b=AabhVOZxsLJcDRDbh+0t6AK0xr+jE4F/buBtX6aqQyctuKlOv3YPaK/jeJmV6KtT0q3q
	 zMp9HK0N92r2x1xBsv+MR3TpS4Tw4uTzE43qJz/wWLHC2BVwkkwQr9GyCnizyik1W38xF
	 vqkNef5/4nB6sQzBnIS5CD7/q9lTynOlQJz1k7GOybWaVh/ScuKLPrVKpTnkl0DZb3aWo
	 9RJfy3SYLcfVQL9btI/m2Qq2j+5Wu0DJxOZKEHIYbWz7J91LGsu5p4FTWvlccystkijMr
	 2muuH0yQEf9J5hJhDTnp77pZGurc9+dCwpcXPClwi0tfQXhklbc9DOqESRZlwj8TG8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563355;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ypaEbA7F8bM8JEaOPaQUMTAvnnS/hRdMiHn3HsbeS0Y=;
	b=jd9watr/ZDodQ4JgGdVQGTsIECA3ogmOpNXxH4a2SJmDj0h9L7/I3c2sO0dI1Ydg2Ufc
	 m4r8HQ5XlQiS9toLSEeZxMzBjZiTf1SQzxqUeSnDqewIfi64ZPlyybTZsonHW1UH2mAKS
	 rrZiRrlh48Jdo4ICDc7wTC3i9Y/lwJMssBT6AK0slFoNnSKRE4I0Rs0QFijL2J5lAwnPo
	 L50mH/fWsCOL3SOzbmoz5/iZS4uXDERdLZj2zNyC4qt/n3hxIUq/Mqjbx/tYJC0+Vj8lI
	 FjDJl5ujDvivy2YvNJ9VyyfxFigZbMpi/f0vGwDkTrIYArZt6NRJNdDlA480VPELuQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3EaPPXP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B2606A323
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3EaPPXP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797BA1F000C5;
	Fri, 13 Nov 2026 09:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563355;
	bh=ypaEbA7F8bM8JEaOPaQUMTAvnnS/hRdMiHn3HsbeS0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H3EaPPXPRBrAmMSOQSGyKZCahmDs9sVgvFwip6lDmlVCs4lVOxbKQZbUbZrGaI0j5
	 baaRfqtxG+YDOqXIp9DHFCFygOtk4JU6wC3bAglovkW0CRcSGbN5AOjUUqhato8+nT
	 hc6Rf2TmSzusuKENy5JiXO83met6UN08SXKjZWfzMOWqRfgoqntcbXUA0yVKcz9f4a
	 8I/uPEC1tVcVKlg+Ik5XGfijQR1w3JUO9ytJtObLexCrJwh8MG02QQTwrVFuBs+HKo
	 eYoSEvC9GQw6sMDau0rA8pR6oUhuNinQFEpKwwsf9fen/0F+YuB2VMH92nvOtdXUxf
	 AeO3+58mi/Qhw==
Message-ID: <sashiko-outbox-212574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 12/18] ALSA: virtio: use request-owned capture and
 serialize recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-12-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-12-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:49:15 +0000
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
> Receive capture into request-owned buffers and commit completed requests
> in submission order. Append actual frame-aligned payloads contiguously
> to the ALSA ring, preserve a valid STOP tail, and retire empty requests
> without inventing data. Bound occupancy and report overflow through
> XRUN.
>=20
> Add explicit, default-off compatibility options for packed status
> decoding and capture pause using RELEASE followed by PREPARE. The
> default capture path uses request-owned buffers.
>=20
> Serialize control transitions and preparation by generation, keep
> payload and DMA ownership separate from the ALSA runtime, and stop
> admission after uncertain control completion. Preserve linked prepare
> [ ... ]
>=20
> Link: https://lore.kernel.org/linux-sound/sashiko-outbox-210240@kernel.or=
g/
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D12

