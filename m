Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD23A5E91
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574165; cv=none; b=jYKS/Y5WZOYGIrqHUG8bSEUs77H84FDTJknEqIKpv9jzhzI6SrcbrPWA4Fk5JDeH/iaMa6l9ImMP8p7fMRJeNS9Qj3dkU3YRoMNfsgdtKAS3gHGPalBMOBtMidmoQl9CBNbEY740PhYlZKvWDyC6MxFUwc3atYipv9PwUDzs350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574165; c=relaxed/simple;
	bh=zAL8pY7s3Hi+gsLJ+fp4a1b+AOrnZSZ6mVGT7Lv+yeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJQ3g5AdPGb2Jjg6QudHN7vGcnKKV5FC+DCIUDjzCj9EnSTvXpZgMpSwGtZxirrlfFlPQSp9ssQ9RB4649wnGTSOJrAd93HP1rD3BNmkDZ6On8wVv9HHlZD1Ze2EasA4NMKeqcEpg0QUdUpLWEun1NiQ0I0IuEYqejLGwZgJg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECp7Sx3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECp7Sx3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676631F000FF;
	Mon, 28 Sep 2026 05:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574159;
	bh=zAL8pY7s3Hi+gsLJ+fp4a1b+AOrnZSZ6mVGT7Lv+yeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECp7Sx3fjtIme4DkrFSLNIFPGloGVHzHP7peC7fwnWw+i6YPCU5pgqD4PfBm/CxVW
	 1j3Ijk4QOgrnVdyvBeJdD2ptQurAlnNOwUQu2ew4IEmdlzr0xJbboMLYalDJRzNtA/
	 G7d9jr3g8c23P0d10IhyCm59l+Nr/p2vN6qlvhsWXFPuzg7jScpQYqyHyIeKJP2ROt
	 wHnzatHdo1MOsaeHkSCJK+2Wjh5qlnmsZ9P12b9CInQ9PJC2IxqFn5b0y4BQLoYyLJ
	 IY/LgpgGHsVjmzqqK4F2qBDwR0D/eQ6IZfMo/5Ue85HWEjlKvflwFRyzN2TtG57mji
	 JS1u8Mq22DkKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 03/13] sched/docs: Document cpu_preferred_mask and
 Preferred CPU concept
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260928053728.797539-4-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-4-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:42:38 +0000
Message-Id: <20260928054239.676631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add documentation for new CPU state called preferred CPU state and
> corresponding cpumask called cpu_preferred_mask.
> This could help users in understanding what it is and how to use it.
>=20
> Document the role of scheduler and driver for this feature to work.
> Details regarding the driver documentation will be added in
> later patches under Documentation/driver-api/steal-governor.rst.
>=20
> Newly added file could be used for other paravirt usecase documentation.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D3

