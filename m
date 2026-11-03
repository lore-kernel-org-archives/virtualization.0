Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701030;
	b=breFpxg0v4kSfw9TxB2fWNTWwwbIvj9ubufD1kts55wkk+ENtrtnTxenC/+Y2Hl96F5v
	 BC0vj60c49NPP2IBT0CjKOrJuf+v3Rj4DBjD1yHTZnGBo8G0d7fjT9/hlWwMwWliCuTRE
	 vr7BBV4mTSVAn2ylQ7LzGlNMwxprqPzmO3yX79A0W1BZqUmkrtNUyH1eXJ7wlZKaNuChl
	 Xkrr62T3Qr4afF9G+3Wuokc/6oNjTNGlH89Q4kl0Tg1pP9+5cnICr6l9SJ0W0GlqEb3x0
	 nEwVUpBbn5eEFV9Yx46d4UI04hTl2jC46ImBCYC7uA2cBlqqdKdJsWBRJC03ZSv78dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701030;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PkBSgq1iANGhkBorWYDZdv/aZPUUT3f2DxK9faj9i2s=;
	b=n2O5Jw7MvJSs3PM2HMXFzbnGGcJdaXoYNRhPzZwT+w0mQ9u8xt4sVHEPagBW3YC9X2kM
	 Tv68b2MxDxHvMGdOyXyb2p4bbZeZL7CsQCjyB3UKWqTeOvy7Cx6G2sFSi9OckVcWHMEu3
	 F9F7+Y0cTgc679j16ai3OTX/+Y/ndsA8cCdKrF7pgouRGCcHXOje/+rkPsCwnrIed0DLa
	 4+UGVCg2H7fGvo3dXw2qlDS5l6l8XuDZKDdVDEnt6e68VfV8QkXwJeqgIvEeASJcOYv68
	 g1aYezWkM8kb8qMm/rEKhNy0t2KvILy0EVpQZD6RQt/aum4TS4L/ia/hvOAGxqn4ocg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMsOK2pM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F20606A831
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMsOK2pM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C686D1F000C1;
	Tue,  3 Nov 2026 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701030;
	bh=PkBSgq1iANGhkBorWYDZdv/aZPUUT3f2DxK9faj9i2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MMsOK2pMTM1PvQoWJlzG9f2JF74H3558BN21yxHnsnqfX6ksCm0AL+LJ5vlJ4ycYQ
	 LKQhqW7UeBfNcxp0MjFYt6PViT/4fAx5o8MyJz13wDCWEPHNczzR83CRglWPk1hChi
	 2d5rHNvZXLnPuzZsSvYkGEwuZ59l9XSZrpVqBRAzYReMmTjItgc4u4+OoCI92eu5MP
	 r4xcl2+caV3F1C+5Z2oHsRddyqGrj4oHPmn8+/t7n13maeeedeitQHwNoE1gBfPGL6
	 23l//ZwB46YBNUh9tGGavwc/5tshPjqvq49M/YGVHhyHZfRycHmDySS9eFHmSL01tj
	 uQEwrXtael0kQ==
Message-ID: <sashiko-outbox-195022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 07/12] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-8-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:17:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in patch 9.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D7

