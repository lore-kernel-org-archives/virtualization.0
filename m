Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A8405C29;
	Tue, 15 Sep 2026 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442769; cv=none; b=ptYZAYI9MQNgrXW4KaMj81cQYBoyf+1kYCX8ht7my7Hk7cazUVDhU9R3klZovRYbhMJanBMCuPDR4kVdunx+8U8mvMa1NvyDbn5Oki5wm2Z0Yq/duM/3UMZfEWPVtc0RUVELszY6ZB8Fo3AwDExmWWhTwe9LilxtHERHvQOzhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442769; c=relaxed/simple;
	bh=tciaB8A8wpdm19gka13cWjtbJNYa1z5HjVYtpc5abL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RLNY0/b8Ha/9RkeXeh5gWiz1bjtlu1rwZs/KQOvY8LTgbESY2SP6Ylt/YoFtqAcsAWm+uy5386ddtjVHAY433WVLwQU9lXr7+TNHWJj/Vsb/L+X+j4+xAJefitxLP0RgqCM7bi0IX2oUhLuNyD0F5iH7FvKm1jC1tqqHGFciZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQy2iwBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQy2iwBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470541F0089E;
	Tue, 15 Sep 2026 03:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442764;
	bh=tciaB8A8wpdm19gka13cWjtbJNYa1z5HjVYtpc5abL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jQy2iwBE1QcNsdNhbMzV+JvezQC8s8uPwmjl2/zjlOPSrbXrDiC7LcMS1TEO770pd
	 51N4ffUsdIqDX5m1BtIVjLyUtqTzqaO/HExUvtg7/817NYOSu/U3avU6uRuY/m7vG3
	 8TPAAyWJ+Zdvw3e6DYQT4JFPAvB2jmQbnrFS28pGnBIzBlFc5yEfI+mw5nkMEVzaY2
	 3qCxuzfnDeoOH8P2iGBfSBPdDUSeJn4r8ZN/cvvb4Ep1/9CHlZesFDXCACCLKTRJLk
	 JCUfDzF6vvQKM8ECjq/isMArL/NzEABmovOG9vmIDJNvk/XjgdUx27nBKV8sHarbnJ
	 81rAea/hxWSLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/17] locking/seqlock: assert static storage for
 DEFINE_SEQLOCK()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915030336.1192299-6-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915030336.1192299-6-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:26:03 +0000
Message-Id: <20260915032604.470541F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_SEQLOCK() statically initializes its sequence counter and spinlock.
> Their lockdep maps require persistent class keys, which an automatic
> local object cannot provide through this initializer.
>=20
> Add ASSERT_STATIC_STORAGE() to the declaration macro. Automatic seqlocks
> must use seqlock_init(); the underlying initializer remains available for
> embedded objects.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D5

