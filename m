Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E4407CCF;
	Tue, 15 Sep 2026 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442769; cv=none; b=OkXixkW5y1hA4UFHS3wgTZZTNQJRUGf1ktYIIVkkaFMJfGQLYBzXB3y7E3OJGqAq+doIPBtb54j42HwOBciEYgjvkKyf5miD1hUROS/pyPhYjqISti+hJ6ZkJmHRbSipppGGuqQzMGXf4tiszWKV6FjP9mGkFDRZPrDgu7dAMgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442769; c=relaxed/simple;
	bh=henwLqIiR9uaMI14hR46qCZ/5lzhkAwg2DBXdTL+gXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kfj9T37YTwzWZ+KwWmMN2hUB+byRo+KWDV3ikAOJ9UKShemg59HLLuacYRt2Aq97NmVDwqX9LfyWKgniKdte6JTdhEatNvn6pJX+L/hYpDxyEV1e6iEv697T12DK0pmHL//x6M8EjhkRbXaPrnp8KIs/QLvdgKR9dqKGvRYyKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R23sM3Cq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R23sM3Cq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E361F0089A;
	Tue, 15 Sep 2026 03:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442759;
	bh=henwLqIiR9uaMI14hR46qCZ/5lzhkAwg2DBXdTL+gXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R23sM3CqATn1Bod+bqeYSF00w271ppA3cJ7jA1JTHdsWvTZr63EDV4VPzpriyqs/s
	 Fx9W4t4A479MPUMDthNJJiMnxurM2VATAlpFQf5Q0Bj3m291qIwuagSKSPX0jC2Y6x
	 AeJw2hHoIImx/nEyEfcOF469gvNc0ticdoAegGqQWEqjKowpYtfwg7H0lF8aMKCfR6
	 eSgdrUktGc+xLjEEstTz91DBpr4y1t3AlYh2JzfSizGHS7d2kGpHfBkRynSTw5qjQG
	 4U0aSXuZ+qWZcGacfchCUaj2Kq3aquFd0fTMiHA8etnPj7sQcAxbsdrnxQ/IsvBn8W
	 WzE1yuXaIAbgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/17] kthread: assert static storage for delayed work
 declarations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-rt-devel@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260915031334.1194975-8-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-8-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:25:59 +0000
Message-Id: <20260915032559.85E361F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_KTHREAD_DELAYED_WORK() embeds a statically initialized timer.
> Using the declaration for an automatic object violates the timer's
> debugobjects storage contract.
>=20
> Add ASSERT_STATIC_STORAGE() to reject such declarations. Plain
> DEFINE_KTHREAD_WORK() has no embedded timer or static lockdep map and
> remains usable for automatic objects with an appropriately bounded
> lifetime.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D13

