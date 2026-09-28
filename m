Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21513B0AFA
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574459; cv=none; b=pwLjNMXlAocU+fENPtrxj1xUROdxW5oRXdfdxyjm19CvzL0d1efD4sq6bDpfyFmx+U7kiLMY5g4mTjhEo4XJPPTiuq5y3kzSk91yZhZZhXxqrwDVXI/WruxPrnTwlGvj52fFOJ8nzgUceqT92XciAdW2Z/F/oAvmkCjphWkkjQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574459; c=relaxed/simple;
	bh=JsOJenjao40KyHRpA+ZO/sz3qWwzHXo9gWTN4/BvIRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r0Pt8lme9iwcJy4u0VIUsL+BWLJPvIVl3o49JaSylUnrHV3biuaAZxtkMCMs87ygq0a+9VaMBnpoORDBqCkG7GLkNN0/buxrDHu7GNMpdGxgNa9h+0MDyJsOfSrTvW6WqmJ0ITvOefoBrPolzTKpc9UMEco7Eyd9TZ2g5vVF11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+Os04Jm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+Os04Jm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FFD1F000FF;
	Mon, 28 Sep 2026 05:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574455;
	bh=C5aP1YZA7tTW1ZNBTjpb5+37kVe6+hrXR838N7YD+kE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+Os04Jm0w7hsQncb4UBFvCj1epKUxM9ijLVYjLUB5SHffGzYn5Q0+/LZpfLkHeX+
	 IlILDz/BqW9I4bN5gpYUUWHvI7XOgTU6x0eEMieZDPVepXCRRBJALCiAhZBkCE8mag
	 fV4qT1lv1WUIV9T4TWSL9rp6HldV3xcm/uqDm1wjKWvu6z0XrHEyjpQZYCUB4kbu0J
	 /ip9gU/myHq3LJOWW8ADPiIX5PF4h1mqYfoKcukpAYfk+4y7VT+ZrlZY77hF+AhYll
	 0TkCbj668ZsXyVcy8XlToY0cTa5593EgCcgdSiSofserHV7zCueIV1SXsEOSHdudam
	 R9wK4nmVBXdyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 10/13] virt: Introduce steal governor driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260928053728.797539-11-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-11-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:47:35 +0000
Message-Id: <20260928054735.95FFD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Introduce a new driver in virt named steal_governor. This driver
> will compute the steal time and drive the policy decisions regarding the
> preferred CPU state.
>=20
> Note that this driver is strictly intended for actual guests. Hence
> block it on Xen dom0.
> More details can be found in Documentation/driver-api/steal-governor.rst.
>=20
> A new kconfig called STEAL_GOVERNOR is introduced in subsequent patches,
> which enables this driver. This driver will select CONFIG_PREFERRED_CPU.
> This makes configs driven by user preference/configuration.
> When the driver is disabled, preferred CPUs remain the same as active CPU=
s.
>=20
> The file layout of the driver is kept simple for now. The code is in
> drivers/virt/steal_governor.c, and the configs are part of
> drivers/virt/Kconfig.
>=20
> The main structure of the steal governor contains:
> - work, delay: Deferred periodic work function variables.
> - steal, time: Used to calculate deltas during periodic work.
> - interval_ms, high_threshold, low_threshold: Tuning knobs for the
>   steal governor.
>=20
> While there, add MAINTAINERS entry for this new driver.
>=20
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D10

