Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0E3D4132;
	Tue, 15 Sep 2026 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442771; cv=none; b=PWte0dhUxcFjQxJNcVzZ5iC3L6FBomtCUSeiXxzcncugZ/xu9u7aVuzwdR2bjm289dofVdBInE0N8noSf9xbn8rQ9JzoczvLRICX6v350db++7Z3MCJylvrfg5s0rNSvUQcuWgz6VifXMhpsCNPO8EN4CmfNTnb+NQ/S863BWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442771; c=relaxed/simple;
	bh=O2V9M2xy6HEHtjtBwl3JuaM/1QrUyJmtv2Y6rwQASdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Deuc2W891JT7Oexvk6RY0NI4B4Q369+yToUJYf7alaRdXyazSPYWJ8fm9n3wJGVnGxnncMXFvyGK9Z9p+CdSVcF+bjThmbk/0o0lwy7dkeJgqfb9uM7XgWmnQR2DGVifTDMVUub03RL72l43y9ryF19Rj4H4RPkeFsruutydB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWnuVvGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWnuVvGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C820A1F000FF;
	Tue, 15 Sep 2026 03:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442768;
	bh=O2V9M2xy6HEHtjtBwl3JuaM/1QrUyJmtv2Y6rwQASdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWnuVvGw3vWUuHEEaMpNyJhmFACsKiUYbw6Gj79AcgH4AMyOVMmay2oxBPbzA3iZE
	 lKQia5NdsNl0VR7IEQPj6JQifDMq7Fg5DLrIkKIYD6oUYj4aeWmnzytOChAf5u39yX
	 QwNUQnN7ZibgMNzEfoCWDQAuXAz6HaygwchRM02TeKResMEq8wnY4WEaAhDUJP5UAz
	 K1rxwmk67yzXatQoasCuK6YGZAancC+mJDeXC9Yy0ctDK4GOtGxXNfNbtGAXozTBQc
	 ieGdksFPAue66QJWQGwFL7MKHmklV7SU/cpF7Gz2XjvTnTxGeaWBqIInkLZT+BYIeU
	 hARvIj9LUyPXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/17] sysctl: assert static storage for
 DEFINE_CTL_TABLE_POLL()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260915031334.1194975-12-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-12-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:26:07 +0000
Message-Id: <20260915032607.C820A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_CTL_TABLE_POLL() statically initializes an embedded wait queue.
> An automatic local poll object cannot provide the persistent lockdep
> class key expected by its wait queue lock.
>=20
> Add ASSERT_STATIC_STORAGE() to reject automatic declarations while
> preserving file-scope and static local definitions. Leave the underlying
> initializer available for embedded objects.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D17

