Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053339;
	b=YywEkbA7SBI7DJs2wCRZzgAMu2+6h7LvDBXZ6NkN9zYSKlXZAeEMN9nv52XNVR98+MLI
	 z+LjAC0WRiynlw8CtV6VBEcKy5dsRN+d6Fy9eEt9dR2+47/F9Q7SuJUj0rIJYiGw82mxo
	 I2CiDJEcIfyKQfZoZTWnb0PF7RNv0QuFxbqnBWbPNxvqW8nyqN6CQWobeE3226HvCp/ch
	 ADNzA+ZgH/1b6FCJcmrDyhylqrzaKeWbMGP+nzfha8LA03NYwFvNSlW/3shFJMssHyr8c
	 gU8lay3Q9mX/bayYfLSrer1dMZMQlQx7BJ/5mDAGn7wIkjD+wdquUMZaTZdbnUDTAhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053339;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ioakOCldH616ewFT8Oyz0jMajR5099RGYErDeigIjT8=;
	b=2yxxjlgLBVYgJkFie3c125aM4wExadRcFhN2M62ddfCZ5I/oJwBdvNi0/zhKLr/Ne76b
	 3EfwwgJZluIh4ov9gxff8fZnLrClCnFTpFg5RPd7aceAZgcuxo/LMS3qByaLFeWgof2ok
	 cdVxWbiUwWWTuijNMiyPAw/eXGBaKGafvh63SfvT+FvS3AtrcI6IJESTORvHpuqhF3nYj
	 /5PTrbAklzaQ1/7gbxeOFBBzOLiJ+czPLfg6Y67UibYoFz2lSeDoC07LafaJe1hQNGC8f
	 3hC2+VOfrqYghkKQiZmDDI1Dlq+QgDe3BP0YkUlVttci2JF2x2NI+BLhEcUJRvT5VIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FwZ0R/Y3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731AE60A262B
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwZ0R/Y3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146DF1F000CC;
	Thu, 19 Nov 2026 01:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053339;
	bh=ioakOCldH616ewFT8Oyz0jMajR5099RGYErDeigIjT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FwZ0R/Y3HSfblPKAR48OxTKqjX0/ozj3Ez/LIFQIbQ2kUdrkJz8ebcSDckSPknMBh
	 01IpUi5eGfj1sfcNYR7L+UGSQOv/rcsbxrV6SHi/cuYUIvFkUWAwlWvgzLs7m+Rx5E
	 77+9Sq0j8ZylpOSaAUm9aVgdb4e1St+2K7ZDBL/aUITxROGbVLTTyc4bLnFmKTmRzf
	 7FPeb5Pg60UUN2e8fGpJSFnvePrb3P3Ewy/BgVRD79O/ETvB8qYejTI+yxt0kMS9aO
	 3uSj+MRxE6M8i70g8wDhCeDvoSsoNZa4YYmjXSK7uM/E3kKJ/odmL+zQW62+BGAdZc
	 KHIkXL0sZEU8w==
Message-ID: <sashiko-outbox-222313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 7/7] selftests/vsock: test the netns assign
 privilege checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117-vsock-guest-ns-v7-7-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
 <20261117-vsock-guest-ns-v7-7-7e522ea9dd9b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:55:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-vsock-gues=
t-ns-v7-0-7e522ea9dd9b@meta.com?part=3D7

