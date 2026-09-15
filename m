Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B733F9A1A;
	Tue, 15 Sep 2026 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442755; cv=none; b=Ir8BjUUNFKDsFEbowPSikOKdAvPW9MSwwiOqDKc+D1Yi5QF8KjDAtJSl0lUHxO9EREivqsqDhKz2CdadpHbv9Fh8buVwBTQW+9cLYWSi14Uy7aTQCwAiViVz5F8Vhf1YXd/1CCEiYgqKmKL5dbylD5u0igLQDo6aDbq4Zw/vIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442755; c=relaxed/simple;
	bh=V5elIA+AaMyn9ReDWnUPB9wO3f3Oea3Nr18U/bEicrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IG7hnZ4JrNEAz4luX4oDCJejZb3vlbo3lY33MOD9Z2M9EY4iB5TfGXDQKcWB9PAjylwLa0MVdXkf42XGPVIjp+31GwJgns+Ft+dDtSGq2SnHMkhXkbR2RpjgagAdkvYt0o1AHalKTsUkn2Yz4aboW4ZKHSfhoWoHV+ZtUgftlkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1spWCTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1spWCTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3D51F000FF;
	Tue, 15 Sep 2026 03:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442753;
	bh=V5elIA+AaMyn9ReDWnUPB9wO3f3Oea3Nr18U/bEicrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K1spWCTfIpqkCCdYsPDnvo23qgOH/4dtFNjqmKGcPld/CXorutsWsnqnYJtBqY6l8
	 w9k7pM65UqvrJ5OoUIP44fkqTKLvceNKtdFT/UHjtaNUQojxhFB4fRMgeXzpP+ZKrc
	 YKHacDgQycq9nip6HBuPF4JkkDls4W2qCQA40k9V7tSAJOf6bSYfyMaRsy/vC6fUIh
	 2914RC28YUTPc5yj6f1giKZL26SK8YfcbU0dhGKG4+HvoJdvMJzRhFVYcv+v1D2dZe
	 GhJTUGGR4eoCWPQQzXPnn6/sODoaoMYwMuhvwyJTsCUJ9OnatlJxpkRNveRL/py9Xo
	 Xk8OVuibZcZ6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/17] idr: enforce the static-storage contract of
 DEFINE_IDR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260915031334.1194975-3-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-3-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:25:52 +0000
Message-Id: <20260915032553.5E3D51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_IDR() is documented as defining a statically allocated IDR. Enforce
> that contract with ASSERT_STATIC_STORAGE(), matching DEFINE_IDA().
>=20
> Normal IDR operations use external synchronization and do not acquire the
> embedded XArray lock. This change enforces the declaration API contract;
> it does not fix a lockdep failure in ordinary IDR operations.
>=20
> Convert the seven automatic IDRs in the userspace tests to plain
> declarations and runtime initialization. Two already use idr_init_base().
> Keep direct IDR_INIT() and IDR_INIT_BASE() initializers unchanged.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D8

