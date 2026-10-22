Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792631785;
	b=2RIaxVw+Snl1yK+GWXjyevcS9e4KxQv17Uan6KVh4Sn+xyfREDoAee3ElMUtjJSEisOp
	 FwXNEXRYnDavtQOjgvr1frFcAqycME6uEHp6RDmEWvMBLi1MtvC4jCoJTf/rcKFYbDEm3
	 gvfKSeT27u6X9KmZEXMT2lCMcaOCMqI0nXbgjVvJ5R2TMEJtslOZhJXQQ7t7UWb0puODv
	 c7W5gS34xKW/dI0I14QHdzdWSavzzYNORMUCtof4ZXy9JMm88+zMGeSw4FLvtrHbRn9LU
	 +xy+6i8lwigzXXZz16o+2Fh4DjDATRtHTojbeAGlZp0jrSTSGSxweEqj4z6P8l1/oLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631785;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=08G84J4WGssX2jXB0VoOhu/cQJM3/SyfK6gCp5QZ7eg=;
	b=hDLGKiplgQrO6yAtcY9uIyQ1LlS1wgdO+pb8M8Lg/BZisRMjw+f75P2762V/IHdsRsQ3
	 H47HzzjFrJR+g85rJZin2XU/v6h/I/ykUFsIooUBGCoR6EHx6jOJIXiU5hTg/NSV+nLOS
	 vonDLBFShS59S9T6b0SXhc4Iz5rkCnBrHvyx6dYgmmumnU/hPoFxT5i+KkA35+eQu26mn
	 QHfyTG/I6y3dE+ZodJ5NCJyJrs9VROUoVjNc4RuwXS8KXuybQskEJugUCGk9/EQNGNXHq
	 j37UxLnsS+g67yEO4iiDsV3PfE1dBs3Luk4joiXh5LGKZq8kRmDt4Z46XIaEmdiubpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfWdlo6s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8C606A329
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfWdlo6s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296B91F000C2;
	Thu, 22 Oct 2026 01:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792631784;
	bh=08G84J4WGssX2jXB0VoOhu/cQJM3/SyfK6gCp5QZ7eg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TfWdlo6sSmLQdD9U005739W1twdwaVHppUwZsU/+1ls1+KPKUX5kl9o4sJYMc1cqi
	 alR0cGvjv7GCpl8Dta/z2eqFW8MTH27/8DKwCP7cFJW4DKC6UHuZxlrXwNhx+P6WDO
	 M/jlw4v1n1NU7mmA0c6013s87NDzm7VghtND3LcP62RHUafSbk9BYX7a90jBhUFe0J
	 VLrjeJzy1esqMzDhdOlja7oeNsHBuMkr2gS4BNTJ2RaXZovlGN98smIyB2dz2rpvuC
	 lz5HXTUhKNjz4vB1EZo4s9jcMGwRgbuy7dyBmDen66nEtOHdrgUr9QYUNnU/7FoFeN
	 73RTbWOPG/4LQ==
Message-ID: <sashiko-outbox-180844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 7/7] selftests/vsock: test the netns assign
 privilege checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-7-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-7-047527cfccfc@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 01:16:23 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-vsock-gues=
t-ns-v4-0-047527cfccfc@meta.com?part=3D7

