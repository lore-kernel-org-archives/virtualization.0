Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764217;
	b=WDfcDEykUSGGMTgnlh7CYCOVaaO/o8NYAFGlH3zKt4ftEtnL4hLrrXqXpW/Wo0j0fOLT
	 TZOj9EvmXNNg0IYhhWpqEzgGNvkca83jfHMBT1aMiHDM9FUX1kk6IXYYgAw+Pws8Z65jG
	 EZWpyBUo+XSLB6yGB9iz4HaH1iyU7QhTwWBkPzIMcy3a1ojscJId5QUQl6ecFDYDO9+D4
	 iAUGKeXYkwr7TUv9Zs2Ytbqdj77EVJHy74+TYHNqhFRDwJxHh149hY6gjpskZ07xlz9MQ
	 sYDfFvqg2tSbsqk1mqNSri4LBOShTf1J+uGyDszJZQ/hV6DODf2pgB4iGFTthGBbMWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764217;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z3dnmN9k8HHbXI9Us00ihbPA8aSvosWZzZvJWfWcdiI=;
	b=PbpC2JS3lnCVvDXY6wykE701/mT9Nxx0RHmTfMFo8BaDkSuyKfMhm876o6d/5Aew6BSh
	 YN+yclI8i1wY5QRVTFhUYtQ4J9MCbxmK4+1i9ZNNTY4c9pMJPy8dVZaQnXQrRrhfP9SV9
	 4zpGMkWf3A+2i4/yrCk0Ij/eCjGNNZEukhJpPbZKPukA6e7l3fR30qJyBpw4ciBM3pCVU
	 tOGy/Oi8T35zaR2AQLwAqCyDUh6HZ9mjSO852q6AHPOGOIa17pIJlsoMUUmdAdGeGlf6k
	 hb9SYdR9WqIPj4KtXQLns8RX/PM14vTdhKh25Q9LskaUKdDEsms4lNa/M3Beo8if5jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIw3Uh0x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E68606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIw3Uh0x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949721F000C1;
	Wed,  4 Nov 2026 03:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793764216;
	bh=z3dnmN9k8HHbXI9Us00ihbPA8aSvosWZzZvJWfWcdiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EIw3Uh0xMAFLWqch0ll9ppBriBzQyGp8O6ICC0jd8MnRLI4HCRgvHHTNE7hdnP4Ba
	 uI7wACMSHyaqTq5tT91HCVpPT9MqWfWuPpTGfr6O68GoQbQ+kTf2liaI9KdWmE2XbC
	 vlEQP6fBLtYLOL+NVLHob2z+ArIlhYlM1sniB74+oqd4F+2URfyzzuWjcs7UQ56Wyy
	 DsgpbS/MvBj4N1UX4YMrb3RlRcyT9Jq2ntSNXh6e19pAO2fYMYj7ZMz+Vs+dhK8CMZ
	 roitkYjrAhfNPU9o9m4NImhyt4cxsvHG5ifN81KAU03m9txiGW8yiTHcPgGzjZGAVP
	 7ejliT17UehmQ==
Message-ID: <sashiko-outbox-196637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 10/12] ALSA: virtio: add staged capture and
 serialize PCM lifecycle accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-11-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:50:16 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use request-owned RX storage and separate produced, observed and consumed
> positions for shared capture clients. Serialize lifecycle operations with
> lifecycle_lock and ACK accounting with the PCM stream lock.
>=20
> Close ACK admission before any sleeping teardown and keep prepare's gate
> through the core pointer reset. Reject unavailable epochs with -EBADFD.
> Real transfer XRUNs arm stop_operating in ACK and pause/restart triggers,
> so DROP and prepare retire the remaining device state.
>=20
> Track RELEASE completion and rearm release_required immediately after a
> successful resume PREPARE. Publish the resumed prepared state before RX
> submission because a device can complete RX before the START response.
> Record suspend state even when the stopped stream has no queued messages.
>=20
> Account staged ACK progress in runtime->min_align frames. Advance the
> [ ... ]
>=20
> The capture compatibility options remain opt-in and disabled by default.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D10

