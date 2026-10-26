Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032373;
	b=LoL1bCrAedtTdN9ZJJw+ozYkRUuOvvwFtBCCKYfk9QgudZfctLST1hbCZ3HcQyNZBqMX
	 z59xT/5SY/Cm3ZB+BJVxmr9P1KkQzrgXfnX9qNtu7Tq4KPrzxA4U3ekoepwdmgUyRk0g/
	 wd6GeEHmwEmG4xjnQxVs+b0iWD6hM4rUSA1zJsceF+dFiSwSZWlMI6rxbTQ+WAtPvfcG8
	 kvys/eKo7XiCM89cUrv9jhQOZ/M5fGdoiDOEO0Hbi3egNYsMNLknVIheOf5u1AsoOyA0r
	 FWv+OHs+CsEwDSa013e6QpAP27YOH24D8eKbTbvKONdr0y2l8GVjZe6PhEKAito3m4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DTNSRAxLq67mRZC/GdOU4sQe0wMtXS1451+YdjHj7Kc=;
	b=fGLjdDHWmM7Rp2mltNVTXX2VvtoxdaHhsmZ+4bfq1LO/39Mc/zpf1Z1uouRdrNLEKFVI
	 fI8HqQHVtpCpW5PN5BULotVBCGp+jbJ7Dqa/BrlXr5wvFJgvofzyrdiMFH9CHAciZ3Apd
	 DMqyUws1FYeEx/qszTTm/IEUFVwtT2vTMjMGJnmL7a9b2LfiOJuBOtR3fjxVZ8EzUWUha
	 kq/glumF+LEjyNrhd9/MYt2m0sIa4M4PvkZx+odneRBaxFMNw+m70K0ff15CYVN6cXp3D
	 QffqJltJX4YEG3P40mqV1wTMSEcBwmhvaAv3TAhpCOl1Hrw4O59D/wOQPFK3VMR5pSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZOHDwVz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D04606A31A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZOHDwVz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E67F1F01825;
	Mon, 26 Oct 2026 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793032372;
	bh=DTNSRAxLq67mRZC/GdOU4sQe0wMtXS1451+YdjHj7Kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hZOHDwVzroidY2YinPokq53pct2SOkSKnUUmixn44yQCxw/FyMZqKWn5ktMBP+VtF
	 VxFkGnzzWPhtCRABmjWKUbKKEpwcmXa2LBC0sjvHZXJ7zGd5SaTw+5oDnJygpEwj/D
	 x1fn/lHnyFc+2d7ZQR6aY1ArLqcHezqZAue4P+1nAlFgynPi8lVyUL6H55VhhDOMFc
	 hwjxyi/YFXM5YejoWPrYywMf1OI8FLOKUFefFWfpoMa7sAy0RwpLWN7xTW21uKBL1o
	 x+HZLje1MPNuOrU80HAfBdpcsf4Ml6TrAJDO6+MTVUceU+hJ8ikxK05KH/UXhdeJuu
	 7nDlqFMffbxhg==
Message-ID: <sashiko-outbox-185525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/22] gpio: virtio: Use a named initializer for
 virtio_device_id array
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <214191c76607fa156b8c9d9209ec8f4e49a4b44d.1793030820.git.u.kleine-koenig@baylibre.com>
References: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
 <214191c76607fa156b8c9d9209ec8f4e49a4b44d.1793030820.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:32:51 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> This patch doesn't modify the compiled array, only its representation in
> source form benefits.
>=20
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793030820.gi=
t.u.kleine-koenig@baylibre.com?part=3D16

