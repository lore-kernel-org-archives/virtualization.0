Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795408642;
	b=SEdNE+ZSLfqR1QoQHVe6szdu+M9g10uSmEMGZ0b9jsKRjsMm5grAjQvlvxcbmWly90UW
	 0wVHmyxZgujLaWqLvG5KGy5EAc2ty21E0tSFlEFr/iqVJ5KqsaBh/KnNyg2BO/Qt75QUQ
	 eKuKIcYTr/2M+xoMyBcjHxq3NEtzPypgToT2/GMZrSa8fx7OJcVnAMALtd6BcjJWvjB8o
	 WVCFFLk7ifO2CjaYJvWa15lcJUS9g97ibWJeZpaXbXTbs+HtOC+/DG9jelZOy3Vrbik9g
	 EB5xjdw8Ke/JLjdT6lwQ8aay4XBw3TJmZj4JwlJKUvs/pb595o/nHBC9T/eGnHfJ+TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408642;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W5PTbcdavPoiZ3GZ2wPGpK4Ezp7jbKTQ7bdsaWDt1vc=;
	b=mYrgKwABdRIjNQM22Xn/rqoGk+57eRbyrzv28dd2XsF5Hl+n6AHnRITCHLfSbNUP4oCa
	 z78xbm8slh3zPmd5vXBWVLFvZzGNLlejcLVJocLCcUgGQ1G6ZBWRESzH0v5gFAbeWW7hm
	 okKwQlNye1Xv8WtTSdcuHM7i9wHkbIOH8yACOEx8K1AkBSfnrNEOxOsS71mqRRUpZrwR+
	 Oq0ucU1YyfbkOH8Ps+ZUGfrMn1DLHnLYS4FUNtuzTxx6RgQ5DqmzOCUJbkVwcsFfb+3Jt
	 JEyN/Tq0AZ/BQ3aavrYmud9i3pSGLASosfjzyJkp/kQkyfjTL1UQxfYxU4rgcI0R3zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mLQ/EcNy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBBE606A31A
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLQ/EcNy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603CF1F000D1;
	Mon, 23 Nov 2026 04:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795408641;
	bh=W5PTbcdavPoiZ3GZ2wPGpK4Ezp7jbKTQ7bdsaWDt1vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mLQ/EcNyQ6lKJmKsZiQeL3ucmJJxIORnp7RL7P/NZZjDrzW9TrY2QaGPTs0xCtqDJ
	 DW0jIekF9pYrRwLD902H/pxaTBTmXhLZvsXZoxGvuXinySA8J5lMXtIIA5gcpt6lwi
	 RmCgMzuzI+QHkWHfcfgnQCxzY8cZl3+QCoroowrgRH2mZrWOmxrVIpNzJbiLVEBYqp
	 XKExuP4mxP/9bAfvxai8fSTlRRHdBdjasGHSWruekxwWL2tPXpR8SHupzapjA2w4bU
	 tWiCnq+18pkVOfXgzwXs0kAkF0OiXPFZzG+h4hyy10oHoD7QuDbJKHpUKWgPuOJiBw
	 2hblM/LcokJ7Q==
Message-ID: <sashiko-outbox-228664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost/net: ignore extra words in
 VHOST_SET_FEATURES_ARRAY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hengyu Liang" <hengyul@cs.unc.edu>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261123042259.3484334-1-hengyul@cs.unc.edu>
References: <20261123042259.3484334-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 04:37:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Commit 333c515d1896 ("vhost-net: allow configuring extended features")
> added VHOST_SET_FEATURES_ARRAY. The ioctl reads the number of feature
> words from user space, copies the words it supports, and then reads
> every remaining word, one at a time, to check that it is zero.
>=20
> That loop has no upper bound and no scheduling point. A caller can pass
> a count of U64_MAX and a pointer into a large zero-filled mapping. The
> ioctl then stays in the kernel for as long as the mapping is readable,
> and a fatal signal is not handled until it ends. On a v6.18 debug kernel
> booted with preempt=3Dnone, two such calls from a non-root user, each on a
> 4 GiB mapping, froze a 2-CPU VM for 56 s with soft lockup reports.
>=20
> The check is not needed: the extra words can only hold features that
> this kernel does not know about, and they are never stored. Drop the
> loop and ignore them. A nonzero extra word is now ignored instead of
> failing with EOPNOTSUPP. Unsupported bits in the words the kernel knows
> still fail with EOPNOTSUPP.
>=20
> Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> Cc: stable@vger.kernel.org # v6.17+
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123042259.3484=
334-1-hengyul@cs.unc.edu?part=3D1
