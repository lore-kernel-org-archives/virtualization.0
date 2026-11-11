Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364542;
	b=qLz8zLYq3XKTl0Ybyiw8qxzS58mDxFbQg1WSL7c/Up6tqXT80Z2o26l+f4P6yL0ybcFZ
	 wwQNJSs07joEcShOOFRr85vFCs3hx95YJiaa1UeNxky6ALsAKaHtSge4fGnnt9vF90xs3
	 MFHqrwBEPX+nGb8Rm1DD6b6aCtJp0n1uIrXRrgYM/nMS5v6zDiUXoEnJ+rBhqeT9HOUPM
	 k0Pe9JtNvICrXwLgxq+aboO7U7rO50FWFZ7HXUqK5g9NdrfJ6J0LRUd6/8uWN/zUJ/Oy1
	 s/Q4DuumshQo6at0Fwm3zewhy9tIJjevu9pVoseVtskTDmHNDPucnQbPfE6vINTfvng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364542;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RF7vMLe/P03oxWNWePpvrn0R6uRlQB/syvcBeLrEHeE=;
	b=lnc9BXURL8IawtmbTcBuRSzJwm3JGq1b6OzX7cijGKytnAjZOf/xpVvoh4KoKCo3BcXO
	 2HNZPychLi8YhaxSx9GVZnAfvBqK7xcDJolPp8mRlMdkci9QkqvVjgqWqsg/muQTVjRPd
	 rAR8Kj3PqPtBL0y+MZMSqZHqcdE5LUtE71cMxmPwamkMSG+9bJfcQFiAc76hIZzh/FTDc
	 Uf10UPhXGOJBRuUk8cx6UNR3glzaJH7tSY/O/7aixxzvGP2Bgtfie/r+kVYs3i+lzxi7z
	 5tDzM8ecy8PBKItw3YTZedxCh55UIvsgYo8yyxUsyc+0xVu/a8HzEbeUetasOmcIOGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fC4DYmCn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAF606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fC4DYmCn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8501F0089F;
	Wed, 11 Nov 2026 02:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364542;
	bh=RF7vMLe/P03oxWNWePpvrn0R6uRlQB/syvcBeLrEHeE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fC4DYmCnk0V8ZPthDhj7VqHFjgpuNoLp9wTIRoJhLkF26yHhg2ECbvEovacCZEx3k
	 vtPvjk4ae/E6Ai6N3oV2H5x4986hj/nueUWkJih7ZtXAD83sS6AQxNQGOB5mNiYrTr
	 H+gDlZ/lPD4RxAQ4aah1Wp+IHwFMifopR3Ob8MTDR32FHLN42nth7qrnlZCB7C80+b
	 dbUb7QPLK2R92Cp81nA7u17vTCgvFzRX1X/65AVKrGHrekG0I4NQ76HkD5aLhjYu5a
	 vK/W2dXdcCoMKV06S3ah1bJPRA44h2oqHmD0F/kcQoOziTpnN8ZnUzYs7SaUTCb8W7
	 rScbgFELE0zMQ==
Message-ID: <sashiko-outbox-208100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] fuse: don't move pipe buffers into the page cache
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S2lyeWwgU2h1dHNlbWF1IChNZXRhKQ==?= <kas@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261110145241.536019-3-kas@kernel.org>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-3-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:35:41 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A splice() into /dev/fuse with SPLICE_F_MOVE lets the reply to a read
> request steal full pages from the pipe.  Each stolen page replaces, in
> the fuse file's page cache, the folio that the request allocated.  The
> page can be a page cache folio of another file, a page written into the
> pipe, or a gifted user page.
>=20
> Always copy.  The server sees the same data, and the move was a hint
> that splice() never promised to honour.
>=20
> Keep advertising FUSE_SPLICE_MOVE.  libfuse fails the mount of a
> filesystem that asks for a capability the kernel does not offer.
>=20
> Preparation for removing ->try_steal() from pipe buffers.
>=20
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110145241.5360=
19-1-kas@kernel.org?part=3D2

