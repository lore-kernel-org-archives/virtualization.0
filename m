Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865070;
	b=aynVX5PS807OPbBVu2p3wKSMsbLORErHRyQ+51wVSJG3GEyfjEs2ULla4R2UIhRGqC5h
	 biLu+Xf8nigr9HB8E2Sn/L+Iv+hVqHtSfLcSLDUY/VLZYG1SyLnFB++WxnezDjhHMSfw4
	 Gqh/E8IW9uO1qYui9kyGkrpZeZCdnFKIenKXopIHCizar1fLU00l3VGKkCdlsPqxSk9pL
	 hf+HqwK2z/OcT82SGnLvrm2bkWAo5PocHwv1OniVZQ+3DKLvPnxHpwqcXjkakOzwHqA1Y
	 g9JEo+mX6d9P92cJCFBjGI6Plx5A1ucGOKQzqb6I6kaJPqbzSzOxRTmMJC37A2qxoAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jqCBeyhOQF+4WdlNRiRBY5NvLd2DUsD3+4J4TwEty/o=;
	b=xXymc6gVbdbFcdRnQgfCl9f/QSU/SNVDRsB2hGay2CZIp7uJq8rcqFqpt2Y2s5tft9qV
	 cdxyeNWB6dzgcWwyxpsnmE5E0Zq7204DNaE1R8zO5k2fN9y+vrcFyh4EwYE4ESurq+7o1
	 Ztp7nHVT9Su1XUvnRsJO/94zGMjwB/KR4Ib/YkEzMhWZ2S1e5s8lUVZLXd35sVQ9Gs+GI
	 RGRHrhy9Rq/RknUpjWZ7/JAHLV+9imm5U4qmqmg3uEeTAJHA1iWe4Hwgu7GPFDXuyKkqP
	 cKtxP5LY+4j7Bo99Fov3o8bllN9fbBc9K85UqmNhGCvAA8uxMwkJUjyKud6N4wWDT5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9Z5lfBV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF7606A333
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9Z5lfBV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7E01F000C1;
	Thu,  5 Nov 2026 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793865070;
	bh=jqCBeyhOQF+4WdlNRiRBY5NvLd2DUsD3+4J4TwEty/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n9Z5lfBVqBDeuJFyaRTtt1lO9jEA6TukG7+JDzFA8sEg12eZE7b2FIoiWjTK7NZdm
	 zZv/Yzh1r52jTadWUsFvdubzPgKIFYhAmSBLhluH4ZaL6AGaw0e/MwuvpsnlKCU6b/
	 Ci35ui90Fsxr/1/IapnzMw+8cly1WETv0q5qHeqUf3X6mTUIJr3Pf7K3sgIFyBnB8D
	 I8f4ggAKU+PcdWQonuqXBeeVRE/CtwOQ5+FvJrFS1Kub4DaqFI5FoXv+TLUkYAwvop
	 auNLhBvGODE+zZCLsRTGfIiCc94tvhUffltK3nnC22Jv77IhCB7dsyEodGZtiaa8jp
	 3/Jc25HRspTMQ==
Message-ID: <sashiko-outbox-198699@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/virtio/virtio_test: advance next_reset by
 reset_n, not completed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105074741.2177-1-gubin@cmss.chinamobile.com>
References: <20261105074741.2177-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:51:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> run_test() arms the next device reset with
>=20
> 	while (completed > next_reset)
> 		next_reset +=3D completed;
>=20
> next_reset starts at reset_n, but each rearm advances the threshold by
> the absolute completion count instead of the configured interval, so
> the reset cadence stretches after every reset: with reset_n =3D=3D 16 the
> resets fire at completions 17, 34, 68, 136, ... instead of every 16
> completions, and only a handful of resets happen over the whole run.
>=20
> Advance next_reset by reset_n so resets stay evenly spaced, matching
> the --reset=3D<n> option meaning.
>=20
> Fixes: 264ee5aa81ec ("tools/virtio: Add --reset")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105074741.2177=
-1-gubin@cmss.chinamobile.com?part=3D1

