Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862845;
	b=XMTLrWBBD3tx5Hep+elJmM3pF7HcT0DIbmSHSafGvAPL+mLj9Q8b4Omfhophml1nmC3f
	 pFQ27apv3Zs4uvPjMG892ksr4Ssiu+ulQaIXl5CLJw3nxHzf+Q764jqyQWEZ1Gl+2edcs
	 sjglm//LbNmKhhApDw1MPb3HdNMraCGSA66TTPEcuSAh5AojaabWmuukaY/Lw0QTTwLFz
	 W/waK0ZBoMMK/Tb4pDLUw+UqbP7TCNstJj018gptVaTJo6aCa6H3Cnv04M24mpYWnVG+c
	 +gBrqfKn4t92wefaTncZ6IeRxpnjK4t2WXRIlHCPZe+rSA9pem1fffJALxETLwausuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862845;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y9YitnRxhrI1ZWBhhlkcxsh4et5pxaaEMhfqP7H3RH8=;
	b=qt+DsNpzNGFtEnyPu/FWUvW8gtZmKrwKs6W8FQ45rScwY/QjQzMjFpuPG8udH8LnwJKS
	 EaM62AOKIIEHWYPe+sf68zNefdZLHCzLl3MAfULuMJMFX6lNT8MucDv5TLrBAREknXRoa
	 ONq2WbUaOm6hnWXhbII7NM/EfC8XX4+jy2U61FKTR5RCyxLEsgmlsGu9Nwh0y3mZwDPxa
	 tgJnFnsG0WgXnNIMRhprzk5Kv1vVAL2/NAMviDLU/Li81mIDsxwo8INCtzMSfb3Kk9m9P
	 FMf5o5p5uKDY9ewkORUr/enDrwtSQcjfJrKMRlpp1vR4Bw5O7WUcWAti5FplTx8jHyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xs9NwtVY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA43606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xs9NwtVY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C1B1F000C1;
	Thu,  5 Nov 2026 07:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793862845;
	bh=Y9YitnRxhrI1ZWBhhlkcxsh4et5pxaaEMhfqP7H3RH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xs9NwtVYR9HhGeUQdQUP7CMhhATxmaUPZwc8GbDKL4fBW0GdFvGnQo4zxcQHz4P7C
	 GDVQcL8YuonQmsjNqgL/EE7G4m40D/eX5lPXU/Yd9jQP+Obp9g4kedwis6kA7CSITK
	 dmYj9vTPHcrW6g4eiIa4Vw7yKTmfZ2v9EClB6TG8fWnbZzSfJP8xKl4G9buBHqrLVk
	 YARI26HvjoDFuzp7wvUu0EQLhXgw1jzRdg60zYgyyi+64HCrsvDF8FoNBAmhy7cLFd
	 JxnUt3vVSsQcOxIukJ38ztmgE2BY6kZYcEzcAntPdgprnqmV3bOAOiwAOauD7woT2g
	 GCpJwM6abNvUA==
Message-ID: <sashiko-outbox-198646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 02/12] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-3-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:14:04 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Staged capture can make readable data available before a complete period
> has elapsed. Skipping notification leaves a blocked reader asleep, while
> using the period-interrupt path for this event can infer a false ring
> wrap when the notification is delayed.
>=20
> Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
> through the non-interrupt path and notify readers and fasync listeners.
> It runs under the caller's PCM stream lock and does not tick the PCM
> timer. The driver must release its pointer and trigger locks before
> calling it. Existing period notification callers keep their current
> behavior.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D2

