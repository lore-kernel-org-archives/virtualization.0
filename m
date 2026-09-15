Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A53DA7E3;
	Tue, 15 Sep 2026 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442770; cv=none; b=d5jGiUO/4Vzp70MCdeTx4n1QbO3AU7n483qtnk0BphDEF7UJawlH/yv1GVKRgupbvkZ3MfcVnwrbMMp/YinfB+jnef2E+gOm03YcnMhiFNwJGiRf8wkCbBgK8AUEuf5+/DjIWdVEEiKvNrhQQWgE3ijaAKz2XZll9X427sxWG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442770; c=relaxed/simple;
	bh=w3HYVm+oRkLu3y1MBa+BsLztbLvNE0OkUgDKIDWyv8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GI5thP+m6W8pr5oP4LYvXGs/YDlXwy2tgdSj/p5n+0CUL1GmT9mpLPlCJD9QnExtUIo8nRx95lK8ZAM6KQOkKuWQGiAZRkrqqC8nBmOywE643gXcb3BZD93gBtOvlEicNHtF3LN0Hnf103EaS9CsqPkDAbebrWqf5roJuAJtkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jikOCpC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jikOCpC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654FE1F0089D;
	Tue, 15 Sep 2026 03:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442763;
	bh=w3HYVm+oRkLu3y1MBa+BsLztbLvNE0OkUgDKIDWyv8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jikOCpC46//G69qEBneTfy5bId58bAKnJ/iASydypjRqqm1asXwlWZVhEcju/YdTX
	 zD/FP5Hrk/M0DrqDUvLtgLVI9OajxSa8dZg3iNC/m0R7byJI1wT4uvki31oWCpi+EE
	 aS6DE+D3S1sYxzpPMJ0O99FxfNYp/YJHUdJ7pqTOVKCwUtrLSQMy0RQGaasnGtA/gD
	 lHg5MsuaPMvnjamMyiXeVCnl94yRJDsx23qH7RrNxqsJcMPm6e+8Xl0Eo8InQPRSq0
	 nJjEH/wXMq4hQB11Rj2ShFFzIrAitdYFLW6hOHWsx6gJuKLmz6LInyz3b/LCOM4oau
	 ox7E4xGt/3bvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/17] xarray: assert static storage for
 DEFINE_XARRAY_FLAGS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260915031334.1194975-2-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:26:02 +0000
Message-Id: <20260915032603.654FE1F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_XARRAY_FLAGS() statically initializes xa_lock. For an automatic
> local XArray, lockdep cannot use the lock address as a persistent class
> key and disables itself when the lock is acquired.
>=20
> Add ASSERT_STATIC_STORAGE() to the common declaration macro, covering
> DEFINE_XARRAY(), DEFINE_XARRAY_ALLOC() and DEFINE_XARRAY_ALLOC1() as well.
> Convert the automatic XArray in the userspace iteration test to xa_init().
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D7

