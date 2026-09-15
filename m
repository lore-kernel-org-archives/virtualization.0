Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0E405C29;
	Tue, 15 Sep 2026 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442756; cv=none; b=YvxUX2fK70t/eBkWEbibBX7qrwJ2SNYjeMYY5HK0HEfq0b8GM9su1n1VVow3jAYeuApW83iIMLL3pFb3uEpkgFn4ANMBCCniu4sbFZM5yUUv8awEVa2Q1S7BHKIZkJAVyuJyLNT2XiUyMIBFSLsM6fUUDhq10ifaoVxF3qQBTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442756; c=relaxed/simple;
	bh=0v0bi3VFzmT6srQjjT4mksuGWKVBrhOnBMLpa43VQwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtB4tVM6CKv0qDdNeENO/dTcikGj+q8MT6+W9DGjwKYoiXodagECjtI/BmEfyIlqUhDs+gmD1hB2y7W/le2QYY9IDheMBSo7y+DXipvtjxCztvRKTkFWYjUjjHFGPxhzN/T/LKEaCKj6LntMD3Rdw0tdWYtAlm7CemYyGQDp91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrpZqO+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrpZqO+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D841F00893;
	Tue, 15 Sep 2026 03:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442754;
	bh=0v0bi3VFzmT6srQjjT4mksuGWKVBrhOnBMLpa43VQwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrpZqO+YtTFlLM1qpkyUloumqayS1saSqaHTF2ck4IyXowVXMpD/y6ouGddPn2t6w
	 lvyIJxSOBfVu67S0CkUGfd4rRMEU3CQos/6sStlRPT1Yqh4sDDeVZ5p1LYZz+HlbU+
	 hNiqMhpGifC2psMPBFzQ+tkPxo1XaN2pEn68b/VnUBy72uxZHy36a5bEz2tdVXaPk0
	 V+b8xdx/dTA8UEFxnX161CeJp+cYM6GOjfjqt688vMffFApI/3FnkFy7OE6iSSvxFf
	 jTO0Q/3Ukhzdy7cXMqn5sHcVK+6T7lMPC3Xe1cyNLE0LfIVp331VQVPAeC8m6XrRuW
	 RlP/3WtXTD9Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/17] locking/mutex: assert static storage for
 DEFINE_MUTEX()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-rt-devel@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915030336.1192299-2-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915030336.1192299-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:25:54 +0000
Message-Id: <20260915032554.80D841F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_MUTEX() uses a static lock initializer whose lockdep class key
> requires a persistent object address. Reject automatic local declarations
> with ASSERT_STATIC_STORAGE(), in both the regular and PREEMPT_RT variants.
> Align the VMA and memblock tools stubs with the kernel declaration.
>=20
> The two automatic mutexes in the WireGuard allowedips selftests already
> call mutex_init(). Replace their redundant static initializers with plain
> struct mutex declarations.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D1

