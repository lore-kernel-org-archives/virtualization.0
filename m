Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984226;
	b=25jSe0jXZfuS7rz8A6z015avrRkbqQdc04GvZTBTZ4l9z+rEkNDDDozaMfcTLE6a/eQu
	 p57bUUSMqg7xRgsWB5e2XZCByOfgRaLGp3kfOC82SOUfHTdg8DntYFzbpII6cNNNjZklC
	 EvmxRBmgkCy5+jJ/nw8f/xKhX7XWCo5ZW4KicTtyOiXI3CGWQ3qcSNy2kOCnEGXJszryM
	 LGuq4GJ6BiQ1IqX0SiILWnGhZWVMIjD3GSAJgWE595szJMkixO/FY+t59XiXfki3itnZI
	 6xowYMHv86aWekEbQ5K6GXvaYj0q5hnhjKtWeQ1RKVC9spLqdwybsRR5Vvt2UA4sXSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2xIMRgV+lMUbATqrRMOAaN8Z5sHbQChVKB/8mv/U0rc=;
	b=Ta5BFISOaXjKa5gfgPzPpELlGVrt0wbcglmA1RTjiIbFbckKdCZMkNOBAY16ltVA4XgV
	 z68tPWMV9e8OheLxhVMOum+EhbeC/ZBW9YgYTSb8tTryPoALVN21pqrEcsFI/eK6Wqfoo
	 inbhF2WPRzCDi26vtwyOnOVau5TGdeM8znpZ1e0YfKfB1Rhlq4mH3iz9ovrtcjrJta4p3
	 vfk7l4Lh+o5hSFk1cCcLLZZSgvraJTV2fet6OiCCbc6YSXJwtEu8bH7YVBB/7Hdsmv+yl
	 giRxYNNP/ohCWcMmWpGN11pDudfvhQOX+laNMRnu6H2E72EGM6h5qFR8gEFaFfGVxsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if6nWmwQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA528606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if6nWmwQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325B71F000C4;
	Wed, 18 Nov 2026 06:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794984226;
	bh=2xIMRgV+lMUbATqrRMOAaN8Z5sHbQChVKB/8mv/U0rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=if6nWmwQ8HJDXAmKXpPTJKRmqVSY5zv3rdwBaiGuBNMWLitoIedA0nXHnhszNzZ0j
	 ZlDQqVvd4iRGVK1Cql+Ato0DbLNPmmocp4kkFM4+gz4Sm/rveOlQF/b1m4av9Mjo3Z
	 bB2EvOBSdhr23smTGpNNVpie6/bXecdkwHvqcaK9VRb+j4Bj98B8VoCn90yPP4J2n+
	 3msaBiqAfmG7ePwHKGns6NztvshQ0MXLwIlkSN7vbcYmaACLmm7jWXIvGQIFl734Rb
	 wmAbcRDdganqEmv0Nkwa/9qWPhIoRwKo/5p+HKH51KbGuu3GA0Ma9YnVp4jS60cARR
	 RASK8NJnH+dBQ==
Message-ID: <sashiko-outbox-220268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] x86/cpufeatures: Remove unused VMware hypercall
 feature bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <bcc9b471c176d5b162e6935b2c0c7f96c65ac8a6.1794206170.git.zack.rusin@broadcom.com>
References: <cover.1794206170.git.zack.rusin@broadcom.com>
 <bcc9b471c176d5b162e6935b2c0c7f96c65ac8a6.1794206170.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:43:45 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The static-call conversion removed the alternative instruction templates
> that used X86_FEATURE_VMCALL and X86_FEATURE_VMW_VMMCALL. Their remaining
> users only force the bits during VMware setup; no code tests either bit.
>=20
> Remove the forced capabilities and mark both positions free in the kernel
> header. Neither feature has a cpuinfo name, so this changes no
> userspace-visible flag.
>=20
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794206170.gi=
t.zack.rusin@broadcom.com?part=3D3

