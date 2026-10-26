Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045158;
	b=CwUPlRe68v50VCypW1lYYtyTqFqTuXFvYHDtJNTcfx9Xn+GdAwCqBRIYnAWenMPN4+N0
	 xcDQveHtlrF1TYcE+3yKtb8nhn99N9vsrQfbFm3vYNsfhTm21NrqlEmeOKV+EJpBQAYQt
	 pV6L2RhRiybLeE0Rcd2JxrjibP9CnYD1Qq/cWf9CnuNejsqGtXMqIqcyYVpxr/6TNTRoE
	 QTBrEjK9HL/ksu3t4aBRzZ944jNPZ0/Yi3uspXQmdjDs72RZdDJW7AuzSk07SDAraWdRz
	 dKHYHXFWuF01d4+mtmc2fjyWcS08LZTIQ9mdZCZKRa7zs1Jvyahe6KH9bYgtw5aIx1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045158;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kuDuiRXUwk71C2ETdwncQEdjuaIc42t5Jmm4e8PBakA=;
	b=mf31WtvuFY8IKTE49NaEVR1M9ZRTFc5qik+hqKYoBPRlZgi6WlF+GjkGnWEToT7NUPvB
	 61ZOufM++FBgOrBrCxIkOUxLw0h+x+K9rlDQvY+k5A6QGUecVattS+xja+bw2MmMZbZa7
	 hyaeb4RaZqk9f/c6vfvIV7s3EV7ModHaxrDYmSF80GmooDJC0GLgtrHBelD85VTPubglL
	 gX74zYW4vFS6pPESFBbG9zb3P89XkwcvN4MOLfdFFx/Rf7Q6YyJ3mYJQmawBSs3mwKahd
	 ZwPK1xKtI5mSoFhUlRwtnaM3wsMs20Hs0K54JIdn9GMG1xptK9K4L69Ts1gzlfIMD9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcltK4E2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62697606A31A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcltK4E2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43EC1F01825;
	Mon, 26 Oct 2026 20:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793045158;
	bh=kuDuiRXUwk71C2ETdwncQEdjuaIc42t5Jmm4e8PBakA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dcltK4E2nlF4660NRCHzw7rr2zyOaCHDAk624fotnxqi4gh4ZewIf7EXuOeVozyCG
	 z2g/i/IXihQOlpppFXNHTNoYk2RpcjWyOMzFr8L5gyXdWJEeLY0L1wRWmqhHIf819o
	 OYHcEqLIbARlnCnEUoJtM5+vUNfbrN4ugw1f//g1eDH7KWu9OKQ8FvYYG/nv4ax5is
	 npUhT/DSYZQpAXtqtphyLv5C7AtJoyrOtM/T24FMoJio3+gx5PZ+UVxHKnqqc2gVSr
	 XZ2nBXw5VCLCs1j4NEfKWN59GQsabx8L9wWRRGd30K1JtF2wdHdLUKryWsEvBZ9TDv
	 sphNQonitKxpQ==
Message-ID: <sashiko-outbox-185702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: Fix a missing unreserve in an error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bart Van Assche" <bvanassche@acm.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <4879712fc70d92a04de63eb81a673cd3d023af80.1793044836.git.bvanassche@acm.org>
References: <4879712fc70d92a04de63eb81a673cd3d023af80.1793044836.git.bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 20:05:57 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> If qxl_bo_reserve() succeeds and ttm_bo_validate() fails,
> qxl_update_area_ioctl() returns without calling qxl_bo_unreserve().
> This leaves the buffer object reserved and causes later attempts to
> reserve it to hang. Fix this by calling qxl_bo_unreserve() in that
> error path.
>=20
> This has been detected by the Clang thread-safety analyzer.
> Compile-tested only.
>=20
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux.dev
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4879712fc70d92a04de=
63eb81a673cd3d023af80.1793044836.git.bvanassche@acm.org?part=3D1

