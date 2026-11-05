Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838480;
	b=uphYLW8QseQSPyMCR+R2Wrp0mvPH3MUTZJ9b578F8welFikhuzirNRXoMWadnqEFzOZ6
	 yWaGSNpcl+Nyn3QYjkgSJZPdYmUsh+3pmkwd3yzmggabYlf2uUZEAC1Szr4pdAvF9F8EH
	 TlrAG0tpDz/5whRqwcaKqeh8vJcg3yZJq1S4iSkg+vsZBVHlciXZcwZmoWlBwDdS+tcxk
	 sWBvOAl5amvT48ON9OOySAntctKnN4cuXx2pBlkQXqkL3veIq0WVThAfx76TGougBLBB8
	 Y+PdjO08XPby1BilEMBStciC4L+WFGfhvkw4KHSDSA2bThL35tejP4nbY0tVIIGZhCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838480;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RVHLQl5F/7JDX6/+ZvQUMMnDwB2vAM+OdvC3HhSA5n8=;
	b=ume3XjqVI0RyFKihRSWvmHG6ViR7w+YEewE94qpmT8sLiTTny8WQmHgFtGtNQfoXTHb7
	 CuxVSpqX8csyXucU6dPVVc0DVK+bc8DwKCXRpjgTSmY67qdYdR5idyWFqaPcFpJLnndFx
	 L4dmkX/lYluBw3nJ91zZvWgyEwQhTN7cZ8ds3bdiZRj6aPy79iB9QpDaWjuUl9ACHQ3s5
	 VXPFqi/udYBsU0JT7i3Da1TsB2nYO3Mner4YLCscRp18kIeAzklwIWAXBOAtadAkf4A34
	 J4pPg3DfJbnIjOqpwKPYeAtSbVv1+ba3MLvWvfTxLeJI/Fm9MmOuIE7ytHhtiRy+dwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7Pqrbcy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5E606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7Pqrbcy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473E31F000C1;
	Thu,  5 Nov 2026 00:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793838479;
	bh=RVHLQl5F/7JDX6/+ZvQUMMnDwB2vAM+OdvC3HhSA5n8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7Pqrbcyk9I/bjD30E02GGX5NJ8duM63deS78PN3yIvH/OwZYiC0wM3WEkLClUuzL
	 9XLtxdUSUgLBZ42AAD5k5WDt8EQHNVarJl0bX17A01UHGNW0I2GdOFXT1goWHuXezl
	 mFhvQcdDfPpA2CawiHnjOCOahQtkkho5OurUMHdpeEvTq92gdOUwVwZ20MVrdgVyuO
	 2i23OZUGvqs5Vl8t7LqpeUVZUJ5M+QVhnQXQXW8ckAL7wnxZW8JDHiRuAgHJxqVi1R
	 iLyZDLTWWtRcqdgxrJjs9Cy66jlH/h8VnHSiIejs3XO56RcrrTf7uKLVSKLzCgR6gh
	 0RdKMP+VF9vsg==
Message-ID: <sashiko-outbox-198357@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 09/12] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-10-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:27:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request is
> still pending. A later teardown may then submit another RELEASE before the
> first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels t=
he
> pending request and wakes the waiter.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D9

