Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655442;
	b=nGPmQL/7A9Vszr0PNzM6rtez9eyplKL/JcSSq0Va6rH6EWNjd/rQOcZoDjm+4ci1r7Vh
	 pPnJAW4CxaCNmtipk0oGjaWhugSaofPtrpkLZrwplix9OBC7eAyKlRa4rIZeT5/LlnRDU
	 tdGITsj1cOjZMcGaRWVVhXKBcEEwDLLRsCvN4v34I8awo7H+aTBAgry3GiDjdx3uKdH9C
	 +uXeFdfS8uqK9EpxeijMp51VUrLJpVdtTI/eodY80vYtgtwGuEBho3jif0l3qtwByI5t0
	 36oSKE4wm+HwCsky6gUSPmI/TOLIhzH8AhHTGXfBzy94NZcn8ynmuUXCPrFFe6fG0Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655442;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K0fMMZE7Dsfm/cOUg/Htmc2gYwAQCkcMo0fMTdoeQRc=;
	b=mbSIev+/WicqKm2x91Xzt37ixLnGzTmhRwwpLhxwNAuBViqZyenztsYIC+ZPUECjZNWE
	 AnSiqfjrW5/RtlC5pZjH87cnQq4yxdpkZll24tGnixceDpiPPUL8m//3021dzm765i2SC
	 PcC4I4aDga0EfDsBip/tEEQRyKf406D2GKeGeAyGREEEkxDalSbWc1qSihkLB1cwoMK+w
	 SXljZ6i7vKa0NPZG0oAgZC0fRPldNYssd5V40kHuMmJGEdzQho6FNEKS4PpNATYY1X4pB
	 gZkEP5EWLouT/P0aZ0D0hjj9LxAzl8C+CNOHdht/b8YQVhnU9SpW74mEzshiyTtTj7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gu5R8zmP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D4606A31A
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gu5R8zmP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302641F000C2;
	Thu, 22 Oct 2026 07:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655441;
	bh=K0fMMZE7Dsfm/cOUg/Htmc2gYwAQCkcMo0fMTdoeQRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gu5R8zmP+lTqxiYipovuZ4aW/by1y5aAoHe/G1l3ypWaC6BN3/k5Rm5eaW05MPM+L
	 UbgTWaDHRWazxwJxaXzEjvsZeHSn3SaIiRUZXsQsI24hLLbC+F5nTsFCHKDDa38Kgz
	 2NBrOJ5Pdk/Vdk0V2YnEOWpzoNHNymjF3m1c2AKRWXcx5dvDJhfX3RLlcPP1llds27
	 t/x+I4xEz58qWM3AQ981zNIv3tZhpnAQikFUazV1Gx9/YV6Tlrul8hSOeaaU/PNY0+
	 CEEdoBW2nL8p16+p4mvlPmw4Ho7zciQSFHv46cD6qH7ixVuYkuuQkfF/he3fncthR/
	 A/sWY/S9EwHNw==
Message-ID: <sashiko-outbox-181143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 7/7] virtio_net: cleanup protocol calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <07a96514a8ec131b50c91d18a7df5f0d41a488b3.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <07a96514a8ec131b50c91d18a7df5f0d41a488b3.1792565282.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 07:50:40 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A trivial cleanup removing a duplicated code line.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v4.git.mst@re=
dhat.com?part=3D7

