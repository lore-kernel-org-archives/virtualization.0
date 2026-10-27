Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098455;
	b=acRblXSyZ5Bo1s+R/eO77k3sZG0H4fYafngOk7vHUkX+ceb1qfGk3LJlW6wq8/fAZFC1
	 z8mtMquilmIauNc7hobNp0/w//RRuh3OCrNhS17ZeiYhMFmfC50s0gbqAhKkuEFHaRNEE
	 K1pJ32/AI1Wo9qxQ6NfXpVdulZB3g2w9mM5TG8EQAsCKp7CqKegyzysjnhaxeT4SyksEB
	 WXsDKB5fLWaN2yvRVotoIm8OObLWmcPPSxCisSQwVJLkS2OiAlmof5ATf3fsxQgDu6+Zp
	 DDU7G+WbC3B+s6aOlI0meCv1Qkgw63KIitLZLLIgrf5ovwgLW6xMmXbYU1z7CH46FXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098455;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zjnq9RYvGg8D04XTho1IODbfQWbbPk2N/aqaY9z0g+Q=;
	b=N6cA0dPEwLjkoht+87COd3Y/L+jReqlTt6rQWA/XVgaiowCEFHOviOrHMAFxNb+L0Brc
	 1LdFvf1p+gpT1voPcsdUSJS+K357oCXW/7wH+CLx8c64ZeF5CUbss8WNrDL/gZcBbXETS
	 8Zb3wghbkdj7GRR8FjQz9VQz3XhnmurzdsV2ldXUHY4hkLfKpiLRQn/vl6moeO2n+QlYO
	 U6O2P0EsTm9WRAJHj83XYYT2GQuxT/F87Nkl1x990vtAumz8yo5pNMn63wEnUhnPkPZH+
	 YnMSU4UEciuqC34zaUCI6A4KwkhnzDT5dR8IZvANhZWtJoulTpokPjjz7tsrxFDvVOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLY+Q6HI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCA606A31B
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLY+Q6HI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631E51F01200;
	Tue, 27 Oct 2026 10:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098454;
	bh=zjnq9RYvGg8D04XTho1IODbfQWbbPk2N/aqaY9z0g+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLY+Q6HIcpT8t2KqexLYgscSDQibe3ls5TBltObNjDae75/KUTEkivmynWzXNkzhq
	 gKRUZWPIiGpSixxyzmCoR4lFdbCVvcMb9grOFXNfj0wYuBl5ssEVlRsQZf+Orsf2+f
	 w210f9YpV2vJ2mt/WwxeQ1Nvf2UkSi4Y5HDtcyFwrkj9lw3T2s7jhrQLBEEaq3OYTp
	 7kmmvQ+VHRQaU/9dQy7IE5EWHT/x/x3iuyDNzu2xyK4DI0YectOHrBm+PXhLHbeQ2N
	 Z/1qj+vGKrsSBzl+rBgnpRyuBTeG4hTxi28mDyU1Q/dKOo42XiKXHsN6zkVwVGB6gl
	 Fbkw0xVxBJhJQ==
Message-ID: <sashiko-outbox-186393@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/23] gpio: virtio: Use a named initializer for
 virtio_device_id array
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <0ff54324a8cdb1f036bd01f05dfaff75512d8abe.1793097104.git.u.kleine-koenig@baylibre.com>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
 <0ff54324a8cdb1f036bd01f05dfaff75512d8abe.1793097104.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 10:54:14 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793097104.gi=
t.u.kleine-koenig@baylibre.com?part=3D17

