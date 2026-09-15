Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7DB40756E;
	Tue, 15 Sep 2026 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442757; cv=none; b=UEFFglMYGJxHQBlGMwxg+DZtoasU9ajdBC9CVpuhmOnCjyo2jtI7BxZZBLXCfFdyGSYc6zwRBs5D+IyAjZzBsce5KkNwtzuQ7koeXXUC8ua8fWgTPj1KvXUX22EbdmMkJaNNyWx1IK/7QS8fFv3DEMKyjc8G1zw3HaPFSb3hBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442757; c=relaxed/simple;
	bh=8FLWQEYpKO+cpipZWvsoo17N98YHItgwzh2rVz51tGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kQYdcmppOuVjxGpKPVHecZo51d+TyltemW0RmZKqcGFVKTzCZTpNf6+z948ovuIlZHKLiOyk/WnzvNPlgPxZrfl6/YARoCCfK5MyBYLKqSsDvpWAqnx9AIEwLOH1i9EjtrNhuq1bSSlJ2o0wVmq+p7onrB/cfZeCDDgBkb/7A80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUjUxQep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUjUxQep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C691F000FF;
	Tue, 15 Sep 2026 03:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442755;
	bh=8FLWQEYpKO+cpipZWvsoo17N98YHItgwzh2rVz51tGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUjUxQep19Wx795eeFWlYjIO84/QpOaR5aTnGwxRTt4phbTEdAv+o+BCKI4A5H4Yh
	 VFh241E+ahr8V8S0cigdpVLoKbsjGc8zgOiZ5gYjgBZJImKLykIDMLJmzoDx9AdjZq
	 eVNX1s1uEGhnxiWHn/Rp6KyPPxtc+o5UJ/yaF61rzhasT/DFsuRKgJv80mqzDhtR+u
	 BHcJkpXBY9va0zyH4o5ZZ28wZbMpgsNuCzYxvxLUCvERqpvosSQW3l6s/LF6+xvv/Q
	 4ootNhocSyxxo7roe2PC+vI3QlHpGt61mVcEKXXnx49AmzUYxUCNJY58VZuH7aEhIU
	 hjIcjIvVAhBWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/17] radix-tree: require static storage for
 RADIX_TREE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260915031334.1194975-4-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-4-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:25:54 +0000
Message-Id: <20260915032555.55C691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> RADIX_TREE() uses the static XArray initializer. Enforce static storage
> for this declaration wrapper, consistently with DEFINE_XARRAY_FLAGS()
> and DEFINE_IDR(). Leave RADIX_TREE_INIT() unchanged for embedded objects.
>=20
> Normal radix-tree operations use external synchronization rather than the
> embedded XArray lock, so this is declaration-contract enforcement rather
> than a fix for a lockdep failure in normal radix-tree operations.
>=20
> Convert the thirteen automatic roots in the userspace tests and benchmark
> to plain declarations followed by INIT_RADIX_TREE(), preserving their
> allocation flags.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D9

