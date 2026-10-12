Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27CA3B42C5;
	Mon, 12 Oct 2026 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846317; cv=none; b=YNWdV6qWf7OPhdGsi/QJCUh1tmuHcZQ/oihQqiN++GNkn1OVW4rDKG/ONMIzEHHSFB9Otx5e3ZXRnGtXLXQkUptJQ1eHiK5KS8XUCfv33NilSH7as8ImfPM6o95KFq7skgFRI+2P6LvA9JkL3Vpq/v8vo7doy8wGCXRP4gRj1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846317; c=relaxed/simple;
	bh=j5EzflyY58Jrf9xSmHFuoAL1QUMWXrU33rxXbD++ZEI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bWyvuibLSDGA/nShWo8NEJ2M1tiZPDhpnAzlG0BeoB8qSqYm6rC0h0f5p8bCxIlkEShUvT5uOIBBLuq5yWAgrFRzOSjE25pbkkOmDCcUo8suliERHW7OCqL0H+26lgXxUHvfPN5AiJnb7p4HaB0jn4/Kb5W9VlwOID3bWxW1mDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgPSm0pB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgPSm0pB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEC21F0089B;
	Mon, 12 Oct 2026 23:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846316;
	bh=j5EzflyY58Jrf9xSmHFuoAL1QUMWXrU33rxXbD++ZEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dgPSm0pBw+rBS04ZEONrSc7XScBuimxZH/qiSKD0o5gY8hXzTc8wbkRQ5UiSfkW48
	 a61k7Zr055ifEDJ3lkX56si3j3wdHxa+8ka/lZX+0AxOjeNUCUIcskSqwrMUT5UVK2
	 pO52lJunZPz+Waa2TE7VDUeZLu4v3/KbHsldmCrUvR82kY2Xo5kDGboogputPwDSMF
	 LX20oRCbvZKmwvXXMHneSUs5K86OywN6RXXOl5i495Cx/Jo/sruQjs9AGwiB+vlUIu
	 ffFk4JmwwUmx+LdIfvilFIjvurL+EPM8B6iltkEJilym5Yd8YCEEwZenbamOTvDPgy
	 gqukOJXqHF8LQ==
Message-ID: <sashiko-outbox-168691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/7] vsock: rename the vsock pernet
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261012-vsock-guest-ns-v3-2-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
 <20261012-vsock-guest-ns-v3-2-b32447c66b23@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:05:15 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> vsock_sysctl_ops and its two callbacks are named for the sysctl tables
> they register, but the init callback already does more than that: it
> also initialises the per-namespace vsock state through vsock_net_init().
>=20
> Rename them to vsock_pernet_ops, vsock_pernet_init and
> vsock_pernet_exit, so that later per-namespace work can be placed here
> too.
>=20
> No functional change.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-vsock-gues=
t-ns-v3-0-b32447c66b23@meta.com?part=3D2

