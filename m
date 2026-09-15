Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618F3D4107;
	Tue, 15 Sep 2026 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442768; cv=none; b=Rfdyljfv2LCabn+uIY6pISdhrS+x9FZ1Z3tWvBaoRCzo3vctnKOUfx42qazCriMMkueNnMV8fF3og3CKUuVjU3gMkp2rwqtzxi5SQhF+jSrs6Ijj4isyqXPTDW541n9rkfpG3tX7uA915tm2P9HUFmRl3x9YJQD503E1FWjeg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442768; c=relaxed/simple;
	bh=UXtDpQoVvENSMZr5qt0lSJjg56acKE8xjplcKXODIcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FfxXvkosvL0r8P4xPibtbrdYQPem57Runh4St10nPukWLmWXzq27voNzMMgkhMFmMSCYgZdhZ76AAvpjWADKdzR23SKuCtdrtqkKjn/jr39lEVXTt68SCEYt9C7iNrVn26odk9UXClhoVPTvO02NjnoF4TAsXpsv/IXhrWN732U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0h0PjgL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0h0PjgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8302B1F00899;
	Tue, 15 Sep 2026 03:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442761;
	bh=UXtDpQoVvENSMZr5qt0lSJjg56acKE8xjplcKXODIcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0h0PjgLsK1omCvuSFrC+ya9EcJX7ye972kUiVnZHtXRAQ5GJzTTLWDqKSVUttkhl
	 +6ezfmKaX4NCzXr5taezJu2zMtSS9cnIF8KJhYePEHSpvTdOWKA1SzKt40spdOSS2t
	 nzy7tFdHXM79ZbNk9YiTvGWmYHPKiuZuF64JMRHDlmJvbwxEImHh1r7NZjIIisDIeT
	 YfBOQ+xHl/y7P1CSR+jxh4hST/rvS89Qo0cdy65z+y+WlpkM38SJufqDDM33bu8HBo
	 iQoQuxr4J51jRdkBSWwP8p5ktfJljhlL4Sc5N1B7VrDqTC2/TClgAqFFDUFA2Bx1Eu
	 lhhlhuA1Zow+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/17] locking/rwsem: assert static storage for
 semaphore definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, virtualization@lists.linux.dev
In-Reply-To: <20260915030336.1192299-4-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915030336.1192299-4-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:26:01 +0000
Message-Id: <20260915032601.8302B1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The static rwsem initializers rely on persistent lockdep class keys,
> both for their own maps and for embedded locks or wait queues.
>=20
> Enforce static storage in DECLARE_RWSEM(), including PREEMPT_RT, and in
> __DEFINE_PERCPU_RWSEM(), covering both public per-CPU rwsem declarations.
> Automatic objects must use init_rwsem() or percpu_init_rwsem().
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D3

