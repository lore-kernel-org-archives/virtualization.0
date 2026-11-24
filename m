Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536273;
	b=zm1HIp87xeB1SIu/isdNedy9kjXqg+w5pCkJSEUYIlUABmRrv9/mmMerNVr53BxDXniB
	 IyhnbsTOx+PCDqQkaYMeOXS0v2Yyvt98giaAGlgaM+mMkRF4A9fBPawHnF4WNSBj0eFND
	 z0OiRR+ku4OY1bmae6PFVxttFniQF5EZekgTqOIppr9QGBGXUqy7FWvqhgl1bLGVBr2IJ
	 s4qMMY1znqPpcMUmeYT3oySVoxs5m9IgvQqIh2E+MnBh3w2hBNXfLRZfjrEyAX16aacwO
	 VZG4eiwR73s+2TZccL8Cdyyu9MtSwsVLsgYWNBW4fk1t2xJ4s6tLp5NnAZyae1Wsilg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QweoijS3NxZtymUR7rB3FAPiqhoKCU6RIYf5lLQM6Hw=;
	b=F9KZ1Wy1k8H1aIPH65/I4KEjD7TjQaKfLMDlwYIkffKud4ROS7QZrbr71Pk7jZj70xvS
	 VnBe2uxuFXKYhfpv84IJiXrGCZ+BIbhLXZU3NNR424+RRUN+IP3N03CSq/l2YbRsDFtEB
	 QAJQt3qFwcb4rJxup2aOt/P6DHodfNaOLBzqS67PS1DZq0KEtMipc++gXHp0PJXku6INV
	 DfeS+pt8T7YSFrXDirH6r5k9eVCojje7HJHYUTW1z1kHUBEtb2GrsS5YGl+dyRanrhx3I
	 2Jo4qOhozybAP2pPGyHzFUTGWNP6ltP4QOCxVB1+KetOQ7T4VASGynGTUr9DmCrgasA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAbjYCCK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D5606A31E
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAbjYCCK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E351F000C6;
	Tue, 24 Nov 2026 16:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536272;
	bh=QweoijS3NxZtymUR7rB3FAPiqhoKCU6RIYf5lLQM6Hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eAbjYCCK93lC63kUwEcXiEL3cj24mfgU0pMlzkQhHc4i8NFpIJd8Cv0SBpE7et4vu
	 aF+cm/bOhdgP3UJ5TuhCXnwE3EiI9IUj7lZwwbbHamwGLM3tSjv93EREFf+PHF/BF5
	 3s2KGM/GMTvG8Ie2X0DTANkDTTvpLwrHqdKsGj89JoPusoXJuvNaqifNsmiSHs499Y
	 f32R2gsBVc1jgSgnGTeR2p3J+3rsd15ENnMgMZB1eLiN18FpEWVz9JW+Z3qpwdI6YZ
	 mjW9YMGpAN1YJ4y+ZrS0w4gTSC/aFZUzd2VnKwE5ihzKJPBjmwka9ivfFNZLK3MiNv
	 cT78f4ALODhYQ==
Message-ID: <sashiko-outbox-231523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC linux v1 0/3] iommu/virtio: fix remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cam Miller" <cam@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261124155410.768743-1-cam@linux.ibm.com>
References: <20261124155410.768743-1-cam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:04:32 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124155410.7687=
43-1-cam@linux.ibm.com
