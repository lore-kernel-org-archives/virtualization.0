Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423078;
	b=Do8Yo/dEnYkaGm7JNP2WurXvATQO4xYjpaLoWkb8TNVces4OV65GRti8C7617dV61HFo
	 KHyB15uhSdKVkH8HNi6eU6DjDjueV9cr8NxfTVC4BzuQXm8rR18VmTQ+ntBzyhttxOgAZ
	 rLCjzls5vp3nw8PAz5dPwD1P+TpnIOgivkvA/22QKD10JF8MxBk8jv8X4r9Gp1ej0QLJ0
	 Vk9Ghh3tpQ8fNZOmv5z7IMV+wywAzu03s+au00QJhldYqrujVWrYKp9fU30G2c7625zHc
	 ngmF+GGxqqWRzdsLnVbHqxgdf8KJXjMxUfB2s4h7gPhtt87pwQjQslABODmeGg7U33Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423078;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I/d8dmyVKrxP2/G4jtxON/Thd3nAk9Hd37oMBXrbs4w=;
	b=CJ+vSPYwRcJFT8847pMwNpsZYYI2/xVJhYfYBgB8QGlHZMrx7jbMU1WUagOlI2kXSsYa
	 Y30OdBr9/SNxRIvf7SSg42SgwPAArtgVKbXGd2u2ZtkB03hr2JqNMzGGOoL1CD4ownMMZ
	 7tRzRPS3X7eStdifv9Gu64sGjjZ1HgPbqHa7oYLmOF0rmE9lc8t4y5fPWgbYZdyTReB5b
	 DzLOo829uu9j0W8jVGrgxQeGMV5e5/WQLNAp7dcX+tYPnioPXm4PSfIUJPfO2vjFSuEgM
	 S5Addw172d+2iuEjW3wNZDRs0vvBhJbZ998QC6WpYb9pajG5tTeHme7ZTCQVwKI0yHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnsurzNT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269F60A262E
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnsurzNT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083E61F000C4;
	Mon, 19 Oct 2026 15:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423077;
	bh=I/d8dmyVKrxP2/G4jtxON/Thd3nAk9Hd37oMBXrbs4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZnsurzNTNuBBSYqOSSePjCIYqNXYuHoeFKz9+VCYSNmI/+v8ldAITHZnUpEyC7G17
	 vacEX0yhGkABCPUW4uTOgWqLqEI5reO+nGgT1QMD0BeGDwOn/MBtOjMIuH5GNpkPoX
	 3fJvoQ1wMzXzy6rHlDfOqUcPznFMtvge0493VEHXifItvn3zlhoSy/HOpQevB7BoMR
	 TDDAXb4JfJGjb7frWEWN3dDB4TKyv+Ei482bmWO6qEs1EEWMEJmOijLWqKXaoAoJEb
	 cWwFTORBWseRBvayKg1CnXziI7Syhda1oFNY5m90Y3M0LJDpmunV0JAMC/RnCQRnG2
	 l7u661ct8ME6w==
Message-ID: <sashiko-outbox-177671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] vdpa/mlx5: roll back MR update after
 VQ setup failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261019135441.1420968-442-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-442-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:17:56 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Weimin Xiong <xiongwm2026@163.com>
>=20
> [ Upstream commit 11f79e2780043ad94424a8db02a7a9022ba93252 ]
>=20
> mlx5_vdpa_change_map() must install the new MR before rebuilding or
> resuming virtqueues, because both paths read the MR keys from
> mvdev->mres.mr[].
>=20
> If rebuilding the virtqueue resources fails, the new MR must not remain
> installed after its reference is released. Keep an extra reference to
> the old MR before replacing it. On setup failure, restore the old MR;
> the saved reference then becomes the map reference, while replacing the
> new MR drops its map reference.
>=20
> Make mlx5_vdpa_change_map() consume new_mr on all error paths so that
> set_map_data() does not release an MR already released during rollback.
>=20
> v2:
> - Keep the new MR installed while virtqueues are rebuilt.
> - Restore the old MR only after setup_vq_resources() fails.
>=20
> Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Message-ID: <20260716054353.155805-1-xiongwm2026@163.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-442-sashal@kernel.org?part=3D1

