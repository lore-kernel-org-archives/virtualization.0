Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DCE33FE33;
	Wed, 23 Sep 2026 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126325; cv=none; b=tjYpiAgx/SJQrC2dxR+Ac96rdgf7zgq8vMmWxQ+cBcl0Z0Qg4Ifz7ZFGc7eh+dadkoYbv15i+x+gJiHHRKhemjXKFurLQoHMsK5OXDJbjKtfJFvJAKIx88tT7ht/z+vbC3tGI8L78N8XzefDU6+ouvRWhefPNQBUrA2k3X/jJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126325; c=relaxed/simple;
	bh=EWvGYvZMrKA47YLN9XsLmGIbha4b03bzr9pWxtJOZ7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MoEI3sw//3LyJwYtyJliwOHUtXs1wFuM/jyW6HPgOpfhm9JZZ1CmCnC3RFKWjXkGAHG9HCfbo8LDb1i79oAG5KcG0BcNv6zuFizwUqNEV0TpF/nk5g3+vbalKtBQzim8kLZtaM6nQKilT2zR1m264lCefjdsJehm+VTDZu5H/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jltPK8nB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jltPK8nB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359C21F00898;
	Wed, 23 Sep 2026 01:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126324;
	bh=EWvGYvZMrKA47YLN9XsLmGIbha4b03bzr9pWxtJOZ7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jltPK8nBLcIudMbaPGz71Pyx7XQyPOppY99MCmrMIqap5jxQ/7ynH/iNk4uWtS9ze
	 tDqk/rTvpcw80AdzC4RLbY7d9aVXJIwdKz8Ci9j3VDVfWXHdlsEdOajCFjMliFhUvS
	 2rXzOsWhwvJUji7i8U/SaNKgLl/sGu/VmpLL2bJQMsaOeivtCp+1JmelMN+RuepM94
	 IWKSTGVsZX+5dMIyVEPCxmhvKkU/IFvSXAt2iURSHZvHT1QOM1sTtq8rljTdex3y2j
	 6Zg6OI6aacOVJBtS5dLPGiblIk0mLNeNW1gz1rngzZnkvFTM19ok1s19RY7E4PyhM4
	 r2zMDE9UvIUNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 6/6] selftests/vsock: test the netns assign
 privilege checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260921-vsock-guest-ns-v2-6-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
 <20260921-vsock-guest-ns-v2-6-693bd78fde9e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:18:43 +0000
Message-Id: <20260923011844.359C21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Bobby Eshleman <bobbyeshleman@meta.com>
>=20
> VSOCK_CMD_DEV_NETNS_SET refuses callers without CAP_NET_ADMIN in the
> init user namespace.
>=20
> Add two tests: one confirms that CAP_NET_ADMIN is required even by a
> privileged user and the other confirms that CAP_NET_ADMIN in an
> unprivileged user ns alone is insufficient.
>=20
> CONFIG_USER_NS is needed to test the CAP_NET_ADMIN + unprivileged user
> ns case.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vsock-gues=
t-ns-v2-0-693bd78fde9e@meta.com?part=3D6

