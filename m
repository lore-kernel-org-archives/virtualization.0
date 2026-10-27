Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098475;
	b=5q2q/jsOfJtUyrzEUq1xScWLz9eGXbrT/8+IiTnCHttd6ICxs9T21RYANIDitPZ7Eh+j
	 MYNA+hRhMb0pU+OI1iazRr5v8YTFHvWe+GKb+ZVjWFidsvItBKQJucCTMW5Ap+AAG+b72
	 /YhHCp27WPE6O5T5ggK34lOU1nVkrqNGMo43fIkA6gCW4EgWwPp+C/PPPRcnhCrJtKFmv
	 gC47X02LTV09IDZLLDA8PKEJUE76KjvR5Iq/ks/3KUolRsBTcvDJJYViJ3ZPZyCQHqCZB
	 Hq1ga6U3j643FzaL9GfpHEa9AI78y4gtYsRI3o+93GD2ZosdcGlR2OpOlvy5ScaZHbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098475;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7/aajJ323IZKJcO8HCJUHnIVxL9q3QQzGHI0PsCoGh8=;
	b=RJUaVoGOVKul4f9v2iDNmXpssxSucmgM/ZAKyMUQjFdrJuU4sK5Ktz1pkSBBwMn1hzEU
	 lkxjcCMURqy+tS572tBRj0gHo7VwEUWk/wxy3wNqS9YRxZA3crw/QD19AIZW4ktk1VVwJ
	 LKoVyG5ZTxCEB6M6H9LddFidYvwsiHFTtHKO96YUaNdZdqGXwSc9zwLZwBHJLTVAvJ7hv
	 wDl+UmrWWxhRgOmtzdbHHtx8Brn29+zk/KXffDBpbJ5DwnJNR+L0Fnemj+2qMNYmoIBuK
	 q7Fy01sducLZiZuQCHzpzHLYtEgw6m9vKMcTkgTccTf4CvL0QWmFC1X2RCsypumjJrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owW9OhGq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A43606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owW9OhGq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9DA1F01200;
	Tue, 27 Oct 2026 10:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098475;
	bh=7/aajJ323IZKJcO8HCJUHnIVxL9q3QQzGHI0PsCoGh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owW9OhGqyVq9O1mF4a+5d/Fmew3IKp/6iz7h0hDCp+s3MKqML0JdLZM4uUGbBNzVS
	 mExgwRcjS+wbwq01ftL65ksIZoTyhNyPyuQPYog1/T2vo+8g/QkxYqIhBN971UPcWo
	 MCtB2PVVpnrPcqzXwmYEWjIJUygnmK415aOSLwGwBo5USpxlHwrzSWw86pR4dlrxOX
	 pg+bnPFIRg4WeOQPbKK+EARJ7qUrJhz0TCi++Xyt+Iq2wRILZHvBQpmSZDThpOT7tR
	 S0XRxlX7JyBok47b1m7K8Rguqa1jQ94jnZW9+AF+T1gx2JLfzDj8M2+hld1zSNGgfz
	 Tpa02j3c55bdQ==
Message-ID: <sashiko-outbox-186396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 23/23] gpio: Unify style of various *_device_id
 arrays
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <c4102fd9781c4a79071b8a149577fa8c451e61d5.1793097104.git.u.kleine-koenig@baylibre.com>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
 <c4102fd9781c4a79071b8a149577fa8c451e61d5.1793097104.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 10:54:34 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Update the various *_device_id arrays to conform to the most used and
> generally recommended coding style. That is:
>=20
>  - no comma after the list terminator;
>  - a comma after an initializer if (and only if) the closing } is not
>    directly following;
>  - no explicit zeros in the list terminator;
>  - a space after an opening { and before a closing }, a single space in
>    the list terminator;
>=20
> Adapt the few offenders accordingly.
>=20
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793097104.gi=
t.u.kleine-koenig@baylibre.com?part=3D23

