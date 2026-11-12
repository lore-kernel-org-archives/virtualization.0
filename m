Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448355;
	b=q3ZVyvsrMfln7EHI/X+e/0wD1SD9fy4O65eaY636kITSp5o8sMqF9khBAxSpjt0bzrAm
	 YUKhDMVe1u0qvk3M1KhVM+1Dx9Z1cV1cM10p0K5XkVb2YgjXBDMyaupqxCqL870p99uyV
	 KPrOvi6vzbiCVsIwAQBN0pjOt9FkuH1ofjJqEkKOirUsWllNrT6ksHJAocBVk1JFyQEh1
	 lR//PEMF3DFXuztY4x6f+5NuhCoyqT7/SBuvTutnLc+nXLVse6E8s2PIQqgd6fiezZINB
	 pmwPunW67DjEE7kNdKuGWXGkopDbmjd54JFD89T+gqiMzCn3Ort7u6aAWCtd31qOIbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448355;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gQ2lathQbfytVDgbbfLlX+3rI/tSusRtcjjaZ4ugH4g=;
	b=w8gmyTd0G5pOnI1+xZmMvFBVfJfcGfGPH+RHwREJ748hVsz0IDHk8NhurggmKWJ5Srvs
	 MeXIKtHmQ+ou6LqnX7BfqMKG3/dRhLDjf0MvIrGkc+1/+P1Yn9cCrWiXp+x6AFgxzjigx
	 MHFFgtQXuYrivO/ql9JQyyynESVGT1XPeRsSI8JpkGF7EwxJ+9/i0Hjf+Ow7qlAKWmzEE
	 lEaZOuXDRbAMIfy4bjRQY4gUt5dxvlC3h866z9YEN5Y8hWu5rzmq/hf+5ktyWuPrCetlO
	 mLQV9DU1cyYq5uSRi4PRgbEOsIJmxSPuStXzUMZc/HoBwsBtdl36cwOxxFJA639cCcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adtwh1Ft;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F1606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 01:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adtwh1Ft
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717E91F00A06;
	Thu, 12 Nov 2026 01:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448354;
	bh=gQ2lathQbfytVDgbbfLlX+3rI/tSusRtcjjaZ4ugH4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adtwh1Ft8Qd3R4lxfOhSBH66CuJ1VokbvaUQkMPozA6rzo1At/+4n+OQP8L38vLtt
	 3MDZLToSIhLmJMzzPdkjrdbQeyfe60PaFbRd+Liz1LJTGXZ+FdBugcm3tNHLBUAO9U
	 ZtnjssPMr53JdV6kumQqeMTBlyPwrESrzULUTApdt1dc5vpmWIpitjw7QZI8theMH5
	 ZWLHdtAYh3n2NMBWsJjxWAqQZLAF6XWwRpHzONgvuD9N8FunQQl8S0wSqyFtDhaH9s
	 syoCSxenDOKKDCipf5cepNkaBTWvsqQNp8B/KdFz5zuRhE46KjWTrtJrKATIOjlSDg
	 lWlrqYYEMDEMQ==
Message-ID: <sashiko-outbox-210105@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 04/17] ALSA: pcm: notify drivers after linked
 prepare completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-5-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:52:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A linked prepare can finish one member before another member's driver
> prepare or reset fails. Drivers that admit transfers after their own
> prepare callback can then accept an ACK while the group action is still
> incomplete.
>=20
> Add an optional prepare_complete callback. After all sleeping prepare
> and reset actions have succeeded, take the group and member PCM locks,
> publish every PREPARED state, and notify opted-in drivers before
> releasing those locks. Keep the buffer locks and access gates held
> throughout the operation. A concurrent DROP observes the group before or
> after this commit point.
>=20
> On a driver error, notify only the attempted prefix, including the
> failing member. On any revoked prepare, opted-in members in the affected
> prefix or group return to SETUP. Preserve DISCONNECTED members and keep
> SUSPENDED members suspended, but set both saved suspended-state fields
> to SETUP so a later prepare can recover. Leave unreached members
> untouched after a driver error. Preflight failures have no completion
> callback. A successful driver action canceled by a terminal state
> returns -ESTRPIPE or -EBADFD, respectively. A driver error keeps its
> original return value. DISCONNECTED takes precedence when a linked group
> contains both terminal states.
>=20
> Do not generate a stop-timer event while closing prepare admission.
> Ordinary legacy drivers keep their existing successful preparation and
> pointer rebasing. The new callback runs with the group and member locks
> held and must neither sleep nor acquire another PCM stream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D4

