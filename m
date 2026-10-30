Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358858;
	b=iwSPeqX5C0tVhf8AH4K10MJ5FFSveu+MkLKCSMiqYlGvMqMQRfXyEf49FyLc6/+YGQvk
	 qm1pceBZAFLx1YnOLH9mrHPsk40Tch6GuQUJRLAcSz2Rn+Dt7UOvZD7BYCg0nTzn19Upj
	 VZ6iJpxTk8FfCSFPwmn/wjcpZheJabMZ8pG5eOr04BJrEIRLVBXPOZA9JxQj6KBpKxFYV
	 i6cd9JCXTCzVkCHrchdTwuDVOcOqVZiS1/ExzQ0fRR1dShFSJaFj84dzfEvzb59rQ0m0E
	 gP2InvJtNfwajpQ2tEipF6avhQYeBnzda9iyy3FSQWM1uf2k1l6sFAI/McxcIR63JxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358858;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kM5pnVhjS2kH/EKP6NpqjyaZ1cMA2cH2cM8ruYQH84k=;
	b=X1xII5Dj7Hzc4BCVNkXK3cWbX2ChkGes4cRsFe6Moqlr4epg1bpTBrZWLObUy6ZPbw8T
	 F/TYACVyRqQEZnyKBucjJeDm00tk+GFHhl1PK2iCbPgm6/7IG+D1klr8p7SijKz/kAu3r
	 6gdvjmU3+Wu6PJpkMPDolPLnjZEY1772EC41V1T20K0rykPrA1iwei7IPBvb9kPxuHbZ7
	 TdQqzVLKRSrXVP/eFi0uoTBI1xuL2OQX/9tWYTi/UF0rvYWpy0hyUCujR/F++mi6g9jIr
	 KsNJ4MAVJRNrTUcFQo7ZI/o0wx0DzvAHCjVWcLZiYR7Om2UOvPZTrM+Mv4amIRUpa9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElHV88aU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AE606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElHV88aU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CE11F000C1;
	Fri, 30 Oct 2026 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793358857;
	bh=kM5pnVhjS2kH/EKP6NpqjyaZ1cMA2cH2cM8ruYQH84k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElHV88aUqd0DFVNeBtHjXAavkgiAM4EW73q97jW9VO/UmfLxgD4XsxxeBjDaOeVCo
	 9Fsp/LZpLgKMq7apVJKyUoreooP96cUt4/FofHezcEJSa0P7FbP88HTnHhNqCiJGi/
	 DtelsodXfH6KJI1UAjZcDLtlW7qAMORbQniustqW9myTGFcofHbfu4Hl6oZGmS2MRu
	 lRiQgmzY+m+eG2F/Qcg22tAr35WIfG+nxSg57jivIrvS22wqOLuthSkylc6kxbNY/H
	 ZfQY4RwmVP0sqb2FLWXYtjMIMspQGPaKLd3jZMIQQV/i2TT/1lm7sZqKG8zWEMzA5J
	 DxPoBMpfWfm0Q==
Message-ID: <sashiko-outbox-190927@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arm64: paravirt: Mark steal_acc as __initdata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030111053.114812-3-blum@kernel.org>
References: <20261030111053.114812-3-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 11:14:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> steal_acc is only written by parse_no_stealacc() and read by
> pv_time_init(), both of which are __init functions.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030111053.1148=
12-3-blum@kernel.org?part=3D1

