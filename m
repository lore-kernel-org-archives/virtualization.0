Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445372;
	b=nGVh5z6c0vy9RKJgI1xBcxKpSx23tSymUxcqy9/j/wV1atJ5DFaIDT1AUNzK6+nryVfp
	 YGU2U+TRrv//GLmYGcZf4+0m6MmwiVDRYDl5F6eOWEuC3iveoCGdVLN09g05ygsIvhIMi
	 qAR4jCDYBqCaFGwUEhgLuqsmwbgVKt58U/OzvYoteeWSlVMksaa8Ex4Z4c33tirbUYLPL
	 Gvo8j7C/AGJR9JKTW6SzlMvkx2O7+C1wmirYBEq/N3tUl16LNwltFxt1SM0lk9IEOzv1p
	 zqYJygJqRTkCn9ZQi82HruPk8OQVlzQwptC2NKbu+tqnD40JhTbY3cx1qIhMZVQ2QqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445372;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aLWiKmTpbUIw2ODjXtOYiBzI0hmVBAYtF9UP2q02Fgc=;
	b=4kSX3qni0R5IkLQ+F8uBZEigXPvkMDM6ArTMAJ36Hunv3+sxfbdH5YeEJcB51r2Yk6ED
	 2BoKpAN4c+o9K8qfjKpY6tdOyFeDEjFY6m+EKbASVYwGbkpkbv7wVpUjec8RxQUJlNmJq
	 GyEkWlD4g4r9fNCwZM+7XAntszsh7zZ+C8jxPz99dL7c8NcimgNwhSgMNltDviyDOo00V
	 GRv83Bl8VBoX4qLQ1YNbU0xumZO9z67wf3WSNE3T/AbW7PUeMB+XtF5GRpJnYJaxv75ie
	 cTY61ZKKBnUcSENhuPRcc4j5QWWZQY5fJaQ40kWadItVFUfRNKQQOmfq0iqKe2eOurg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrt1Q+Li;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832960A3806
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrt1Q+Li
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438EE1F00A09;
	Thu, 12 Nov 2026 01:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445372;
	bh=aLWiKmTpbUIw2ODjXtOYiBzI0hmVBAYtF9UP2q02Fgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jrt1Q+LiHFah2JI90yfl/wD7b7HMT+PpNcpda2k21CCxNjC16dMRQqu7gzi03r190
	 XWBIsyOkpKkgJFJbOPjYsR4pOfi1p+06aQ8yS1uS4lHOxkPngDDf13dr7zjOQz26e1
	 m+2uor4WO5nqCe9JAge/a9upKGyiaYUQfXW2idqQUuCcpamKszDH3eikHtTHnqBCKW
	 fjVsDnjvooO7LP9Z2vWV+IohYd2aNFWi1iGD61y42nLAvTAJ6zlVmN2S1HmZulBbWS
	 ORJ/bByAVIJk0ZefUvA7+ZitHhZ2ZNlCA+Y6PBfJXsZc77SYvSnxS87RfLk47D+1/2
	 KhE9EASqsPCBA==
Message-ID: <sashiko-outbox-210027@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 02/17] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-3-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:02:51 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Allow a driver to publish subperiod progress under the PCM stream lock
> without generating a period timer notification. Use the ordinary pointer
> update, XRUN and wakeup path. Capture DRAINING can publish its final
> tail while playback and other inactive states retain their existing
> behavior.
>=20
> Handle capture DRAINING separately in the state update: a full buffer is
> still readable capture data, while progress beyond the buffer capacity
> is an overrun. Playback continues to finish draining when its buffer is
> empty.
>=20
> Refresh capture availability after the unlocked copy and application
> pointer commit while DRAINING. A final tail can arrive during the copy;
> subtracting only the copied frames from the earlier snapshot can
> otherwise finish draining with unread samples left in the ring.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D2

