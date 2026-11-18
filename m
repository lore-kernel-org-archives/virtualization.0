Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010199;
	b=0k6l9HSdVuSwbM9fRRXfcti0uur9mx7ZV+3RY52z4O6TGcK6J6HH7mdSuPDC9GesubDj
	 bUmvh1Xmj2+xTdrsntmDl0fU1iLx2xfUsvShv1JGAuVlUPecLtn4GSJkc4d3es+UN1l4y
	 o8OXd9a5IubWLvfKnqp6Vh07HWz+AxkXnbP+JhABrSwZknNTcxYhVYvUyOpwk/eHddGZj
	 ClIEHha1MJC/o0Q1vUvVlZn9k4ax5GzCdAkmjI1Y6O5hS2ce0R//7SRdENRyLmatYxVd7
	 OcnYLYqKtmtcm6Kcz/qjS74ciXUmAQ37708GiNRNiN2Bm2UvD2Mv+147YrqPm63hjQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010199;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2EtOjRdRqkcnWzYfLcXGi4tgR+PCebMjiX/2wObsTLk=;
	b=nv3tP4wBo4J3I28k1dIn+t1TwcSrOcvowSBQxp48CxKL+Jd3mZlH+0sRPLXU7Cd7msLG
	 gB5E9wXtoIigarM5cuM4uISR4M+Y2kq6GEDjmJwPNgO/17ynlQxbcw1wSPEv25sA3eexA
	 FAaYcn8rTN3uCaieT4euzbh0/Ljemo8YkLYQZtWDlOWyKVOGDtJdmvyi0bjpB7s94gtgr
	 DsD2Jl1tcK+VsBUiVMcxWLmQngaks3fN9+Xp7889sguOeuhUN7NFZYMNMwzkm7eLJjQW/
	 6luSvSNMT6SzJzweDJsDlYIhmKQAZOlFsTdULE3mwJ2Bw6yzcYNYtaRhimDncIKC2kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6ZFhpq1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2B606A31C;
	Wed, 18 Nov 2026 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6ZFhpq1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E5B1F000C4;
	Wed, 18 Nov 2026 13:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795010199;
	bh=2EtOjRdRqkcnWzYfLcXGi4tgR+PCebMjiX/2wObsTLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m6ZFhpq1v3c2a4WwIjZlnd5ztUVkrSR0+xcEhg9qCgRIdgdFp+OxjglGgY9VnQsT7
	 3XV4mJmuuDJZ7nI9hbISNbbii0+Cob088H9uaOQDOPAk1ci5dJ640qTRKuSbNLYAsB
	 QYEAfZg6Ea3rFiFmgZ+FasD9mpb9P/34V0u41UhJfiroK72itTR7LbDiGk7c5L/dCr
	 FTiYK2PWG5tzxw6mtNJZoy/7fAuf0c0Z6PIJnW0VlD4g4QUWF5ZFYJElkp393mMAj1
	 LrhLT1hox187kuy/JVyKsrbYGNGsWGYEWZzw5ppEDRTZreO0TwnQ7+zn1eYTs+XOmO
	 XIoL8IPWI5oXQ==
Message-ID: <sashiko-outbox-221107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] dma-buf: dma-fence: Remove dma_fence_init64()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Philipp Stanner" <phasta@kernel.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261118134522.1646892-5-phasta@kernel.org>
References: <20261118134522.1646892-2-phasta@kernel.org>
 <20261118134522.1646892-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 13:56:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> All users of dma_fence_init64() have been removed. They now use the
> respective initialization flag in dma_fence_init().
>=20
> Remove dma_fence_init64().
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118134522.1646=
892-2-phasta@kernel.org?part=3D3

