Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863461;
	b=zTTydQTE3g7lHRa04Pg2VjP7KKV3KTBjYUyiiJc1nwAaBk/Xc3amZykpB0GcKe64Fl2r
	 w9vMUsNJdESBcqBXI9UsXd+84yc/uIomZTQN3JcETKe/4buyadKMNUQA66AOVp1QOtpSn
	 oBY2lathgcmPNEDlHqwIPeNARZvLrBAsQJttss2yilsbB8DgLSabl5d4j/mInWCMunUm4
	 dxRcbbT9rG0sDtsJNGpIxxmHyix/lP1pXRXaN0zbbI5ZIMAjLAdqWho7r9CZpHRWvXg2i
	 x3AltV8DnDqfzaVlr08CJVVUZE0ix/urJnmbcqeWLvgMyBngdWoqWb4/BLNDA5YXQag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863461;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+NylKrAh/f1x1lJrTDpWIBKhd2tGqrjF43/vG0OvpVs=;
	b=tXa4rN6Vs7sogoB90ICD9lfU256YlbVLDjLkRAU17+8neuHqUjbCAsSH3d87tydMw37/
	 bNmPQ36S28r/pAzqVYTTdVma7km/WVbkLSjs/FAHsJHbaew4jUsY/r4o7NzHahYlsKxhb
	 gxWvac8BCWkBhcZLDY/maTmGmgHUCcstqo48VwpojDflaDXAYFz6yDDG3pYoIDEU/iQg6
	 SvhNj0S0+iaFZqpdspRUCRmaoCYH6WWDRjWWF6GE2CNI3UxFCDYxImuyFFnkd7kIzEl/I
	 Wihlk95Yu+Hia3zkfNGMtQIoEFEXLb/44CD0X+LsCUZ0R/7n4bui0efVCCbj4fzge5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ew6huJAT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FCE606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ew6huJAT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466BC1F000C1;
	Thu,  5 Nov 2026 07:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863460;
	bh=+NylKrAh/f1x1lJrTDpWIBKhd2tGqrjF43/vG0OvpVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ew6huJATpo3IP5L+gBJreFXm6YM/NHGwAVrEmu9S88cuHa66C9CXJF8i2yuabYtTt
	 o8lzRnlL8fhnIytb0dSykiRhE0ZVv53ksPYaMBhWZUXvTvT+zPLsHa20a7BUC+QkOh
	 u+NE/nbYJBa7B7ugj9U4BViLqgTmG0kUv27THpGtOYd4RlsKf0KLV+jLIT6fTtza1P
	 EAk1oLPYD/gxKykH4/qO7+Wy1UZJ8Djz9w5ZtLvo5E5/u7yBOcSWkEmcUqqQ8DKNs9
	 T97SdTxzUNTiJprSlspq2pikqOff6q7bLjQFndwKwTFdoMNUR5VnKY+eRkV7ylSY5G
	 Ks7honyqh9chQ==
Message-ID: <sashiko-outbox-198663@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] hwrng: virtio - fix copy_data() handling of partial
 reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Lei" <leixiang@kylinos.cn>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105071736.65932-1-leixiang@kylinos.cn>
References: <20261105071736.65932-1-leixiang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:24:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> vi->data_avail is decremented on each read, so it holds the remaining
> bytes rather than the total length. Subtracting vi->data_idx from it
> again in commit e3046eeada29 ("hwrng: virtio: clamp device-reported
> used.len at copy_data()") undercounts the bytes left after a partial
> read. This can leave vi->data_avail nonzero without queuing a new
> request, causing virtio_read() to hang on have_data.
>=20
> Clamp vi->data_avail to sizeof(vi->data) - vi->data_idx instead.
>=20
> Fixes: e3046eeada29 ("hwrng: virtio: clamp device-reported used.len at co=
py_data()")
> Tested-by: Wei Liu <liuwei@kylinos.cn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiang Lei <leixiang@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105071736.6593=
2-1-leixiang@kylinos.cn?part=3D1

