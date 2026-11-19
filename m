Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053335;
	b=loLHphIOpJZdB/78X2ZIAYdOnOlqBS3W6iqiUcvEWH9OwS9a39aYZA44jSalvMcKJEh8
	 6/qP388MXOxEwZXDDw3v/44+QjhdnzkKdk1qxf9aX2KHv8GqjM3257sCDVc1Ro5yrHH6e
	 LrYuq4Z4xLLmHlyEQ5iCoc3cdy2g112uVEMUdHdX9cZPTmPwxrkcS3IgkvTzzbs/VJTrg
	 F4w8eNlPaAqo1WxEFR/mSkDTqfhxCftPDlVOeLFbKh7XXzLUJE+Ta1YS1KRYy/viCDKiy
	 k5iyVUClHJXLCy+aQI5vx+iwGG/yEssBoGhneunZVzltTEhtjbfeX4h4m/8y8driyUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SmkEGwZ5ZF3OMeojoT9MeRlQPWPvuGCm/Zn6t8UYanA=;
	b=GQ2GDQETu8riozxnl10zl3gMpFuYo0cP+17S57nxNepV6oYPb1maCongEWs95ODyNqmq
	 smHyORM1fvorXNmiTGjgyKsE8Mj8ejOWpke9B67xfn4kTiZ0ZXPBSkvkRLlLm1DcPJ8lz
	 mFhOGTbSHXRfRthpqg4KLGk/JFfjoKX6xzhXZeMSngX6msKGK330m9Ler664MQC4FcZA8
	 Bf7SN14g8QzTWQ7oC/rnFujpy5G+RGn7ySOylyJyc6UwxiQj6xQGFOZe5UHUUV77Dx3EW
	 Rz3w69EwE52MLWhcTxkyY1K6DNxGIXSKWz4cjcYWoX6E6z9YG5J0cVV5UL4eWPmiTWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESkHa1PT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBF606A33D
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESkHa1PT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E124C1F000C4;
	Thu, 19 Nov 2026 01:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053335;
	bh=SmkEGwZ5ZF3OMeojoT9MeRlQPWPvuGCm/Zn6t8UYanA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESkHa1PTEL2EUxs+tK8aRRLBvSumMqxijENZ6TxkXL+kthZwJAfGmMp6gOnVPRVIS
	 bsFSPw07JhPr70l3WdGjvVRpNiw0styZOvj5l8kcoAfFOXSSbal+xdNYhiLL57l/Es
	 aX0H1xIf+pYZkISUiXpjoGO4/EenUc68SWe/rVij73z1eoD2CUDbjSbbjabqYqllgA
	 2YPHTV3BnH2C48lKUe3LPli0r924wC1CdRERSvk4Un2STsl/ztBvK6BFVE7eG02x0R
	 PNDJWw9dCjAx5uZiGbqiwFMPGjyz7imEB2WzHAHFk1GE+Y8zQJBLzqProUuM9gVjCD
	 /X8AlJiHkn1aQ==
Message-ID: <sashiko-outbox-222308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 2/7] vsock: rename the vsock pernet
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117-vsock-guest-ns-v7-2-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
 <20261117-vsock-guest-ns-v7-2-7e522ea9dd9b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:55:34 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

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
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-vsock-gues=
t-ns-v7-0-7e522ea9dd9b@meta.com?part=3D2

