Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058050;
	b=FCEtW26JYOPkHfLyg04T0gjCPvRh7ZbYWPvUibqgxGYYp5BH/1wGp8s7IZ7AGD9FYpIy
	 s2FsDL1Ay8XX7Fv8LTiPYb9F4RFdtc+xiWAmVHmetlOGCuN8/rGxvzeI8qfg+nDWLA7n6
	 c/lYLx8ns+GQJqMmAlx655iLy2tQ1M31Hwm8VlSkqjk97yrkQBSHEcfdICrWOsKNThlVJ
	 idwp2GYMOZ6DyCme9XYEwxw02IdWzkBytJwl3ziD9GNhURD3E9o5GOTmoTCgw5copZQxC
	 iSk0NIIv2rQkuumFPbDpYz5zFqif5t/G/nQbasa8OXWYId6HLkHS34l5UAm/SaBBJDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058050;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QIfFZWnOPbQD40zohQLRWrY+sof0y7BkXNT45XUprQk=;
	b=uozGYoXcOsJuUBYMmxqGCAlD1lZd/T+YFyAuzmi9bOZ4VeEgACLdzwUAlfS9g150pFCz
	 azmPbwSn13LM73g802X+kNyi3NpH0marJOSaDwIFLHYrNZWe+HNcMZ3Wn6NWe/2ATgfQr
	 jT2Wk6B9Jq135WzZUNitPHwiHN0DABnEswVdY2Nn1kSOQ+kNA+SGFBmdVKomwAmkiA8NX
	 YNs1i4zrrrN+pLamvYVg9sMG84TsqrXi67jEVzfzQCv56x3ylfXqkvLy+kLcA4K7yoqhm
	 DAgZKq1uFKBXI/f/LYIPYgSL1s0P6CBmo8q8KTXQ0VrrmQTwrOpg+PxzZ6/3ZO9B43Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDBrHW5a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24F606A337
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDBrHW5a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B191F0089F;
	Sat,  7 Nov 2026 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794058050;
	bh=QIfFZWnOPbQD40zohQLRWrY+sof0y7BkXNT45XUprQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dDBrHW5auqUkBwPhJOvlPZUJgCuX0irBWN4bcpyjRoPKmKtjNWqTl53twLDqw2Fpg
	 sxLrt+g2h8I1JyjVFaH2afP2sEgM9HQO9kLTHGBBCxe4nasb2DIzshxelP8gA0/dys
	 ZAh6CHOE74p1kiWhmdweMH1SbSeQnEYDCxW/knTNp0YKp35eNfA3zjz7cLp4uLHkUN
	 G2N/pxAyRjoYxbnDnsGOeBitUlrN52Ry4oV/ixOzUff7LnIBW9WkS0eTVP008mm3/a
	 wrY3mAA/6NCk9/W6Hfm0n5QlGeqhBl9XhUroUHYMg2aqa5HUsS4/oFzYnJpGMC3M0D
	 rsno8msih8t/g==
Message-ID: <sashiko-outbox-202922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] iommufd: account the hw_queue page array to memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106131829.3228926-6-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:27:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Tao Cui <cuitao@kylinos.cn>
>=20
> IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> that a user supplied queue region is physically contiguous, and the
> page array for that check is plain GFP_KERNEL.  The size comes from
> cmd->length, a u64 that is only overflow checked, and the array is
> freed again as soon as the contiguity check fails, so the allocation
> can be repeated concurrently: a 1GB region costs about 2MB of
> uncharged memory per attempt.
>=20
> Every other iommufd allocation that scales with user input is already
> charged, and the pinned pages charge the mapper at map time.  Charge
> this array like the rest.
>=20
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106131829.3228=
926-1-cui.tao@linux.dev?part=3D5

