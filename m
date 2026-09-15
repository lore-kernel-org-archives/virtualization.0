Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A103AE1A9
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505469; cv=none; b=IyhG5HEUX8ow8iD9/hUxSGOhMD4fnly5EZPEJ2vD66m2GilY/ONV03HwzsoL+GiEGvDI8nBV+WHctJCKvJVa8uEQ9y5v4F6Lb7ypaA+ipO/LvRDgJeMgtefQdrXMXLRqUKHCwCum5gC97XhzwdNEn0HEMAG4AcXVVhYc7vCXzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505469; c=relaxed/simple;
	bh=lJw2pElolwQ0xkxqlbHubhJUkYaRDbDfiAQ8AvWJD0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WAnRah/0RpM38d3a6VJuCzAI/uaLGRmBZm3loWo8NEgMKM4j47hcUS3tOVOZJdO+l+0A/Xd+FnavL3eNcIqy47B0pSnOKC2qc/81T08/9F8NADJhr/vABHwdm4mDtjqTCtuMDsHtFN9QFNel/dyjwka+/0OxORph7lu2520Hiw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV5coBZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV5coBZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0C51F000FF;
	Tue, 15 Sep 2026 20:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789505466;
	bh=lJw2pElolwQ0xkxqlbHubhJUkYaRDbDfiAQ8AvWJD0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DV5coBZv5VudTgIXJcAA3lhIk59UUKJz2cbTxm8djTmJFgrk/qLhyPnhviqtAHe3k
	 FfCVoTOETuZi7jR1r7Jt/yGJSZr+qTFTY3WW44E9hOrySu5eOeHsO0Jc0luHU2k60I
	 ehpFD7rbFS24nOyhwcpNqe2KZyHar8YzrlkcsjHLbMn27LrkdGRIPBJChDHkIlr9y8
	 bvRUeUT0NGEAtAlc2nvTKrlMvPzeYg+MprF4eryaaNNQQU9xb9nOFAlVsN3JilMRu9
	 27DZR4AUJpdQSuAgh47BwXNtgWXuiW3ELOhKMkg5y/Nso88qHrnROPfN4rb50nS8hE
	 IpfyHAXbUjMcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] spi: virtio: fix max frequency setting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260915-virtio-spi-fix2-v1-1-7a474cb1b13b@valla.it>
References: <20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it>
 <20260915-virtio-spi-fix2-v1-1-7a474cb1b13b@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 20:51:06 +0000
Message-Id: <20260915205106.8B0C51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The maximum transfer frequency is read from the virtio config space but
> never propagated to the SPI framework logic. Fix this behavior and drop
> the useless setting copy from the driver's private data.
>=20
> Fixes: f98cabe3f6cf ("SPI: Add virtio SPI driver")
> Signed-off-by: Francesco Valla <francesco@valla.it>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-virtio-spi=
-fix2-v1-0-7a474cb1b13b@valla.it?part=3D1

