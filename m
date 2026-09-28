Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63537207D
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574407; cv=none; b=GHUjMtrf134suBFmBRqW12hsPazheexjZJSNbBMUUdubJ3+kajuPY/yiZjSz6vPKZqfQUTfvaOVHzLkW6NvMwny4FCBYXJ4Bo5jsFK2MBm2SlRVOzW33vTbI86D9+5aWal/pNz0+B2DBAtvyIcM1XwJ/sgzJT3nJwSmDWrMJpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574407; c=relaxed/simple;
	bh=BilqNNB5+cXqqQah9FhKbdjH3YydpxyeZweHjpHproA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PdNsh1HsjWg9Px0giGwy4pjyyyHKRlKl1vAViWNyIJTKxT6FzB5cbgwhCdwBZzsQVWvj8I8SrmKNY5bBZs1XGwDqCO5tLw1f3OtxlW9xSB7l1VkE1qf5j8ZTA+sFata0pAK0Z+nEEgU7uTA3JShdus4So0H8q4qeMBJy64NKXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHWLP7Lb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHWLP7Lb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BB11F000FF;
	Mon, 28 Sep 2026 05:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574404;
	bh=BilqNNB5+cXqqQah9FhKbdjH3YydpxyeZweHjpHproA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LHWLP7LbunJrPb9PnQboQZEhKQmLvpbJjGfE3QVcTDMiMpKVsGRKbjtL1T6FQAAtP
	 9H6vZqBanhDk35qh+ymhdU0jZQ3h1pYQrW3E3txFVzzNLhXg2W7elMeE/XeDXiweey
	 eywnX52irXXuoXnXguoI6k+5vgBa+jUAYElxVl+r6+RN6YiGCxkD0tVRVOHMvzuXkJ
	 TNJ2zct2NuJ8WRte3B4hvpDvpwuJnDBWpM1XUF+1W7D3LG7oItgYUz2mePFuD0t6sb
	 esfRj3EsNFAKwM+qNMC9FetyvoqawDCkn5h6ecFjYIAP0LiqUBkpeaZrnipfNKJfJ1
	 1OZKx/CLegvbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/13] cpumask: Introduce cpu_preferred_mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260928053728.797539-5-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-5-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:46:43 +0000
Message-Id: <20260928054644.11BB11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Provide the preferred CPU infrastructure. Define get/set macros
> which could be used to get/set CPU state as preferred.
>=20
> CONFIG_PREFERRED_CPU will be selected by the driver which handles
> steal time values. It is going to set/clear preferred CPU state.
> This driver will be called steal_governor and it is introduced in
> subsequent patches. It periodically computes the steal ratio and
> decides on preferred CPU state.
>=20
> A CPU is set to preferred when it becomes active. Later it may be
> marked as non-preferred depending on steal ratio by the steal_governor.
>=20
> Always maintain design construct of preferred is subset of active.
> i.e. preferred =E2=8A=86 active =E2=8A=86 online =E2=8A=86 present =E2=8A=
=86 possible
>=20
> With CONFIG_PREFERRED_CPU=3Dn, ensure set_cpu_preferred is a nop and get
> method returns the active state in that case.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D4

