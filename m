Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA844078F1;
	Tue, 15 Sep 2026 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442767; cv=none; b=PHZvCdlsKZqtw9jJL7UhlwMJGEOuS8iiUYS7e6I+eg7HzjkmYlMZzxbycJGE7FVOtj6sLbXoeGYANEBd2/dhMk22U5rhnolbixcq07v0ZFVHc3RlRLs9/J9iHsiM0E2Zr1umNcsyxEy2OpaDsmPdmX3rOIx6T2GHSnP7gMg9oUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442767; c=relaxed/simple;
	bh=hNJ+aJ/CvK/7keTV4UAbYX4GJE7hOlFu/Wey5q/bTEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dRvHYIC1+VEqNXO8PBUtt/l3aNNcRvcKf6Wo2OdOLlCqgJtw0zWTbsmesHTv5rN1Ynt8Zd6mCWDtY/IMYb3s3vrUho/pjfwJbqP8Ctaphfq3RDnzEPNTUiqT5u+Ax1fceVZ8pbQN+Wfb5smz1MiTsZb6jYy8XXycScCE9vZKKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvtqbIu2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvtqbIu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B821F000FF;
	Tue, 15 Sep 2026 03:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442759;
	bh=hNJ+aJ/CvK/7keTV4UAbYX4GJE7hOlFu/Wey5q/bTEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fvtqbIu2WxOg6i7qxwgrK2/ifEo+pW4kRba0IQxZtFosHGGfURu09QV/6G4t0d3rH
	 dG1g4psLyTtG+LIMGX3/1Yrx1xZ0Xn1Q11lm2q2PWEsGNgO6omRYD4eYD3CMrKuHpp
	 d4QfhvpKu2+D5WUVZS5epMlbTEU0Xx3wlVpofrHJoGGYJOrB8msG9J/a0NzLzx1hLg
	 v+x1J2SBNXe5hfPVvGJ78YvtINUfCqz4AQ1q2aYkUg7s7WWmAdVAdxw5hiiwmDae6O
	 ChSFqS+0pLQm2eHwp/Wj2gxvR3S/6IeGKoCQQSWKaXI0QvnGOh/PzQXF7/fS4fPYq8
	 2fY1CzaVjINRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/17] locking/rtmutex: assert static storage for
 DEFINE_RT_MUTEX()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260915030336.1192299-3-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915030336.1192299-3-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:25:58 +0000
Message-Id: <20260915032558.A6B821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_RT_MUTEX() statically initializes both the mutex lockdep map and
> its internal wait lock. An automatic local object cannot supply the
> persistent class key expected by this initialization.
>=20
> Add ASSERT_STATIC_STORAGE() to reject automatic declarations. Such mutexes
> must use rt_mutex_init(); file-scope and static local definitions remain
> valid. Leave __RT_MUTEX_INITIALIZER() available for embedded objects.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D2

