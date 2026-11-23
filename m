Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442802;
	b=Y/tlOdUeKPMFdqlz+24SiybN/qIR1eCRldJXHQ5VS8YoabSogf9crN+PFBV369ao8iiz
	 zZr4khSs6GtDL/XzkySeNH0oNEdf/esrZo06/IEx/6Gc1ilCsGUgcTWvJn7R0uUT9eD0+
	 vMI2S2yGFvv06QwbSqYlWjEksFsMujKdNS+Z+btDvLe2M75JkLer/rp8MmsvJm/z09iAl
	 Wy5w3XNb6WASfnDIzivOUqASoThcwonqVgR2lBP0DbUaliQXzd0CpaDJR2B12mloBFAiB
	 oPgEqPoXry5uNQvsKGsXsEXbw0+X/grYJeljHPepgdxwO6eaW+iDFbLJf86oTxg7I0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442802;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nKSXhoh4Oa4WS7pgI/NqYnRFGbbpLmUx/Bh6U8MWlAk=;
	b=fiqqeN/uCvUZK7dojL1IsRMMKxKtPZ81xvz4tO7h118bjngGp/wcVc+adQ7lBktWiiOh
	 j3QS5ZgYD7A+cVqnyJ+P5fL/PE5j9c66QuAE5LnsyUdgg8olQgvvaZEDowMbQuyijhcrN
	 UZRenXcM/Jj2uCPuOWOshTrOXEKzAR5Fq4x/7FrZox6PHjH0VnXXlIF5mSHj2sDtOrSTq
	 qs3Rmyyms13pkCSp8UULtv2lSZ1N3d78RuBzWGM16qV6oEW/fn9ZA/Ii0dBoqRb9SL3MW
	 OjaRKuX7SzSVHr1Op/ie/neuSDOb+xrj/zKQNOGLTFLmfS6VZ9KsgNZpdvC440r4ntA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYVWHtIc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E2606A31E
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYVWHtIc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011EC1F000CF;
	Mon, 23 Nov 2026 14:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795442801;
	bh=nKSXhoh4Oa4WS7pgI/NqYnRFGbbpLmUx/Bh6U8MWlAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYVWHtIcHD8TxnILpegxK0iqK3uGKZ1M7pdtCZc+NlE9zS1ssDcHvU/SRRqT+RPoP
	 p5RaDgTiUtO4KiWean0B0FfoV5Y4vi4UN53XUVgmFCYNB7T0tfAcYC1vMM30KmH5Pz
	 41UizErVqW0sRgfyPibuQfga8cUcHJN0/aUd/v/jHqKkoFqAhTnFcahJOey2xiw7cG
	 YAN9HHqjG1n1bguyz+lYpLNBTCKqSYM2pBUXiXyyQUuR8k9R5IgQzFETAQHSIUws3e
	 +HOnI2uDUet25ZUcxFvtlMIelOsDAf1MT1Cbm2g+f6zctvk1MhMIAtEGlFXjjd3ZxN
	 pCpUCRhboD7Ow==
Message-ID: <sashiko-outbox-229374@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/3] vdpa/mlx5: Misc fixes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dragos Tatulea" <dtatulea@nvidia.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261123135646.3962652-2-dtatulea@nvidia.com>
References: <20261123135646.3962652-2-dtatulea@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 14:06:40 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Sashiko has reviewed this 3-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123135646.3962=
652-2-dtatulea@nvidia.com
