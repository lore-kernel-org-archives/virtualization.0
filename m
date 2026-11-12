Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462207;
	b=rhSrpGtc0hEXOtLD6dApJvwT54apQKLh5jeyuZllFFqLEHdBxJ9g7pTqcR6Se6K01CYk
	 PHjmK/fXRVMf1C2YbbYQCShQWbCevN7kAVNaICyS0GcZ3XAEH0Qvjw1xVbEk8parvrNRf
	 Cw6JcMo9iJNVVn133dEgGV7kyTz4nEw0M4cBm/ru8+y1RsF0rRyGg9PveEBtCqYTz/Lje
	 wqMLMVfH9t/2Uq6u2UKC9CIud4m53Oms1H7AOFKuN4QjYBfGX+IJM4axoJL1FdYKam7Fw
	 cajCXlQPzouUIOqCRxRJsvqtVae+9raCNgfmW07J28iZJMG03NRmCMo/MFlRVKlA5mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WeIFaNeMZsZ6hbgp15JyyRX8BP+YZRN0C4YSBcwx0Dc=;
	b=I1VsT0Gzzq8/SPnOUpPQDTasneibnarU6hVW/dSq/VpV2FPqfvF+2tsVL+akPAR4XOxR
	 bf3al/2Rhbj+2ZaZ2thyqZfH1g9iuotMgL1sGDnfz8aYS5f6ru9gps6Tak5a0sttPlFH0
	 x2rW2VS2gEv6Z86x0OA4L0LTPRV7qqgnsMSjVtYNhdf0ZBewdz8JNgB2bHs9rkejONwc5
	 KNMRjbK5pJ5ThIvQRojAmtkd0PaP0ovqzyQ11KL4GOD3fbY3pUZHsES12KwulPS3PuEA8
	 uDaLoQSB84PDTeDhhShscG5MutRcqrWlmBDPyqpdbJr1UvS3hxZVuAk+uTmTnnYP+/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXjVFqHF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D1606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXjVFqHF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9021F00A05;
	Thu, 12 Nov 2026 05:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462207;
	bh=WeIFaNeMZsZ6hbgp15JyyRX8BP+YZRN0C4YSBcwx0Dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZXjVFqHFzXmrJrREQNequnC+x8AhiPdX7t/CU/hwb53xlGREM7Fe1H0Wde/aO+9WK
	 nNlg/PWnXP+SnS0bJXmTDYJD8r7v30j4QrJHDMoB79HwH3mNaR8SABn8tR8bDm1HxX
	 SHIof6WoV26lIn+U8s4h3/CZ8ns6zIqxNWs5ja4bIY/YikysC8GJ7KVK3i5RV0OzFx
	 9tZGjNs3KRsWXnEXg1gt2pv+3frNd9p0i1iHL/Ja920a1i8Do8yWhEKfgcBBOJLAuP
	 d/OsTvIYTdklj63Ll7+PKsl706AV+HmpFOB1ZNl/imkeHvGjkBiD2WLbg+fkJYCzbP
	 aRN3+uhn3Lobw==
Message-ID: <sashiko-outbox-210474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 05/17] ALSA: pcm: serialize linked buffer actions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-6-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:43:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Concurrent non-atomic actions on different members of a linked PCM group
> currently lock their own buffer first, then the other members. That
> acquisition order can differ between callers. Sibling buffer mutexes
> also do not close their buffer-access admission counters.
>=20
> Close buffer access for every member before taking any buffer mutex, and
> acquire those mutexes in the stable linked-list order while group
> membership is protected. Release every access gate on success and on
> failure, including when a member already has an active buffer access.
> The group action then uses the buffers already held by its caller.
>=20
> The PCM stream and group locks are not held across sleeping driver
> prepare callbacks. Single-stream non-atomic actions keep their existing
> buffer-access locking path.
>=20
> Fixes: 3c3201f8c7bb ("ALSA: pcm: Fix races among concurrent prepare and h=
w_params/hw_free calls")
> Fixes: bc55cfd5718c ("ALSA: pcm: Fix potential AB/BA lock with buffer_mut=
ex and mmap_lock")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D5

