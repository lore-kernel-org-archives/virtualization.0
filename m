Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447443;
	b=pNsKZupB6jnzzkpu+xXSO5NIqAv5bxzSUHau+yXHp37QQuwSivZML7B4+G/cqq4tZBy4
	 ATDUsRspKbcvrk8HnXNX2F2kUIwxODbtvZ/Vu6JHkC7N8uZIT5rNUfq8hvgeGfhod0WVo
	 02+V6Y/cJ1gsPLUFwF1XTWg2jI37JlyKLN/Kv2a05bDOII6MGqMhVdM4iLmb8gs3Sdid1
	 91VncD1OcWlTErJx9QzGJIPsY8WOzs1b0Iu7FOrPNb+HMIjYeJRhacO5dVTUe73Nxg3W3
	 cWWEVww+LRDIypWBtdUzKHalp5A5akgOuknHjRUJ2inQwhJET85HzqqhcqTxLGGl2qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447443;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7OEYyP+H0Q1Nqr+9/DTq0+fYvwYgPkbVR820kv00a0Y=;
	b=CbycrRH7y+ceID7c7HAmVALclAuxW4uKdcgEV1Tv+kr9KmqLHwSs13Z9lWis+b5w3Xb9
	 gKWeyaHGxAJ//iNgj3Wg9oCf///jmRCvNu1HGIIwFUnLaTIdpwjQJ1sCH7PTBm1Kov2tL
	 O9I7kTfgfmi8ge77tai5llY99Rgd6sTdNopjmlq/Mby5hbRjvQV/rNjj+gv9DkO8DbCVi
	 Q1UVMVWcSTsH0w4b6jdhcN/HQR7YnwRTmVVP6KXAT1WNc7gsrSWYEz3ELyw8X/gR5HPKO
	 mzXnP3rGXi7yFFKMsmDdnoiOJCDUKU9ZlUMBJK4OZs1iyh6gGa2r5B7dlrrFZLT+SwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HypN8F+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96053606A332
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HypN8F+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C54D1F00A07;
	Thu, 12 Nov 2026 01:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447443;
	bh=7OEYyP+H0Q1Nqr+9/DTq0+fYvwYgPkbVR820kv00a0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HypN8F+C6U/PJ1dXRrarTDj25sNndUPMIPF0C+55F90MuOau6709KE/b16Mgy0gJm
	 0+L7HvjM4WhKOSYgCOWHkDs5z9HwZ5yliNp0VDE5N7RHqyYLT0/IGZkhItTR8fgucr
	 gSlPIECAvatM6tzXU8I8w8uadxKYRJaXDRPpQrWq2AvJtAQ8qvWeTAbIKV0msGjkhE
	 fXDUqQVOmxeDiSNGPsYi6WjTrpa/x9dnfAnh72ziadlv6TPtfpKHDBubP6rkUiqSsj
	 KJVqpn4rtYpjx2gCuKa5r6wltH09J4UfaeqB9v2WRWWWgYS3rc466K/RcK1XWrU0bi
	 LiOisJt6/FRsQ==
Message-ID: <sashiko-outbox-210073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 05/17] ALSA: pcm: serialize linked buffer actions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-6-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:37:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Concurrent non-atomic actions on different members of a linked PCM group
> currently lock their own buffer first, then the other members. That
> acquisition order can differ between callers. Sibling buffer mutexes
> also do not close their buffer-access admission counters.
>=20
> Close buffer access for every member before taking any buffer mutex, and
> acquire those mutexes in the stable linked-list order while group
> membership is protected. Release every access gate on success and on
> failure, including when a member already has an active buffer access.
> The group action then uses the buffers already held by its caller.
>=20
> The PCM stream and group locks are not held across sleeping driver
> prepare callbacks. Single-stream non-atomic actions keep their existing
> buffer-access locking path.
>=20
> Fixes: 3c3201f8c7bb ("ALSA: pcm: Fix races among concurrent prepare and h=
w_params/hw_free calls")
> Fixes: bc55cfd5718c ("ALSA: pcm: Fix potential AB/BA lock with buffer_mut=
ex and mmap_lock")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D5

