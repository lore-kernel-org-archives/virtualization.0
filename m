Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992476;
	b=LtkaE3xvMw71YxGu/vHmfLWRcnXJbHjRRprBx61NCoq1ikYxEhhZloUGvI9IvqzLU49Z
	 8tdL8xI9YvjcHD3Q2mRW264ZwYroRfuskcFWh7hHiIotyz6TzE60Ds8VLoBqbV4Ad7NjP
	 Hprejh5E683UK32NFmy/hJ8LDZ1YQU/nm6zE/Flxcu6g+ADKBBhoUPwj82ELvd8ZHaApE
	 v4WZYkF1SIfHJRYeg7eGt5zAuQrztQ8z2MoRDXw802aoQde1ioYdKN/iUcVsSS2aPf+G/
	 YZlaYegLEWGF8HebiXiEuA3q8yhqyjcNZBGWODSNh3jxbW7Z+Jh/9u77geP9w91Yt3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992476;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mtl6+DWR3e9EJLIxZ8raEvhiqgZ3A5sQ4r9gl2adBsg=;
	b=sjNklsKy10GP8hWfIAAaayl0oX24/sKLsxHo+GdVDn1BBAKs6hktGulrrrxQv036bJ4I
	 EkK9SN9GryRMCJMy8Z1IX16GObwh/1Quhd5WDCOIhYYs8PbHXwcKk0Ullac2AW0mE5azQ
	 iOBSZBG/CxXarJkuiO8GqQBRle9NnuRNnBNQBp366vObsnCOyim0LcrGSgRsy7dL08N5d
	 iSY8EWqzf2MZsxEJbFJ7OrFg6R/f9jhvjenWbZPSGGeG4tPglMOeoeV2PIaLDcqUfMU0k
	 z0brn6BbCu3ClgXgQ+jG3CmJjML6vYzAzgtqpSCl9DVmtkgpKSNA2OyFV2WbrtVoKlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZPCKLC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A4606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZPCKLC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120B31F0089F;
	Fri,  6 Nov 2026 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793992475;
	bh=mtl6+DWR3e9EJLIxZ8raEvhiqgZ3A5sQ4r9gl2adBsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cZPCKLC9J1n8PaQ/QJRuqQHauIQS8PPmpAoDGKmFGziPzIj6bWlgUvU/VB+LvqX6R
	 T+AztkH8D+fE+FW7cTJ/RdrDGEH5Vv2qjgfkozE8gdYbP8TJt5JPwciykMerXCif0g
	 9BpULOpylBdf9yCuFALY3HeXG9z3oMcZuHGddaNuaGAZe3Jvs5Z6A11Trpu0I5o3RA
	 XjRbhuwRZAsGRLIk+HWJEyprZTOQ7XLpipHM6nOVMpjdTSpelWVQgGQ8DdMqpMQujD
	 xjb5erqziQxg7D8Ud0NHohP8pNwmmYuGwl7H3AbQxJhTYK+r3CrEM4YUZ4LsItlKec
	 nUv9QIMJ6SZ1g==
Message-ID: <sashiko-outbox-202142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 12/12] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-13-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:14:34 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document the five opt-in virtio_snd capture module parameters. State
> that capture_allow_empty, capture_allow_short, capture_packed_status and
> capture_pause_restart require capture_staging, and use the ALSA kernel
> parameter restriction tag for each entry.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D12

