Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD3265623
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135619; cv=none; b=mlZMN7c7PWYc8HDbDmKN/f2G0XlRzzGJ3JfoXXBvtG3nMvNeVo6G5pDoP9MAI7oVpzXGeJApfxgFYgE1jx7YfA7RnC2gWuQmJ49dmAlxMXiV7USkM3rdezY8Mr0yhbtsvybqq08Cn01plNZHNFOUowRQYd4c4jyTEQ1UO0NAgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135619; c=relaxed/simple;
	bh=gh3H6LDU2q4Z62BcGJIURQsXBsw0nwRHFRGHL2cbtzE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sU4Ib79GRCdpvz/PC8YhOFYpgGGGrNzDGtuBcPRjpDLrwc5DN4DiC+fQkmccgIL67j9KHfPHiybEfCTGHpZSXHe35yXWLSeBUHbpvLtRW+JUu8cqYEEuLqBBZFbUgDWoIfKDpk5MhxV68fkF4h0j4Y03xdTYaBDfLjMl1te7dBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhQBSB6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhQBSB6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EA81F000C4;
	Fri, 16 Oct 2026 07:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135616;
	bh=gh3H6LDU2q4Z62BcGJIURQsXBsw0nwRHFRGHL2cbtzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DhQBSB6/gpx4pGdGY2GB4XTb2bwwM2mNWxHtxd7K7hYLExbn5Tc08127B84qNmve+
	 3uZk9mKpjffqsY4fX7b/EzTFXJUVdRJRy7usDEmGWAwfQbsNzK50OdPi2APfxzFdKb
	 JDXWZpr8NpWK46sz/x48jXHDtyBQgJJhzZJ0+UxZ89Nez67pvMWJkeFIZPRo7QkHQy
	 F0stsG+bi+mY695RPm5/2AQPuAnJgi4ntMqQCwFa6GEy53D75ws/SHuSe13WxQBX8V
	 4JazuDiC1vWvLSJACf5pbG+VMNcHIjTmHkaS8smd+I843j1055K7A9xuwIYVjVRbcw
	 rRcGAnE6i7pQg==
Message-ID: <sashiko-outbox-173926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio: use consistent virtqueue terminology
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei-Shuo Chen" <tavhadia@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261016072318.24015-1-tavhadia@gmail.com>
References: <20261016072318.24015-1-tavhadia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:26:55 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Use virtqueue consistently in the notify function comments
> across the MMIO and PCI transports.
>=20
> Assisted-by: LLM
>=20
> Signed-off-by: Wei-Shuo Chen <tavhadia@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016072318.2401=
5-1-tavhadia@gmail.com?part=3D1

