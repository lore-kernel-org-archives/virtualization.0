Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356859;
	b=HiQfrFQV3uNFUKhM99Nt9ihaJ7cgqilPhvmq7dRjqhsk+V89jj4eUWr29Xm4A+zmxOUw
	 Z8R5c8I1IkmlOVTPVLhIZxRDNn6XGCWpIyFAfXxDv4gFMtE41lsjnkMPQdXXhO1+UDVsp
	 hezMwsh3Klm7C4VXvKPi4/AzZrSdqxQ7sQPbCh+8ZjJH8coZasSlFGcc9FelIbMbOd7sM
	 M96Iq28Whb5xPPWZHadPLVw440vzwi3FA4OBcYhy6JkJQBF+qwcA9nTdby+Z+bh7wXPbp
	 vzCQgwntQ5bs98Th+0K1ReFslKBWMTJVafUoXTR/mJcORjxnqwuyH3BMpSI/0kNASEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356859;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p0lr2cJtEa0hudYZBLdV2qPKYbOgbJrOIRqLEKyYQqQ=;
	b=Nh6kfGU7o/nRbU99lsdQ9QQ3W0fsktfrej+LUGsiNVfcT75C5pAkJpehj8kll94GGksc
	 a1yo+1MOtPQjkMlRh++Pdvoyvg8YiFbKjFxIjaefOgtqT6WCDaXUp/UkYzLzaZT28dISK
	 +4waN+4s+9AmQM6lRel1PNI/WjQUbeNGPK1PCPBpYCuWorDAJbVBOVJ61oVNoRNprw2vb
	 jlNSvfb5N7H3E1LxQzHJbbAM6kp3yQXEz8YXg3+AOVGWln3Hqir6hwmmbRqP3VK+dgAvm
	 bMHN6m74KUK3ewX1Oahwc9CWP6UCanT3ktyF8DPyR0haW9DPzsilkAc1lhEw323CTnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7Ou02hK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080FB606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7Ou02hK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687951F0089F;
	Wed, 11 Nov 2026 00:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356858;
	bh=p0lr2cJtEa0hudYZBLdV2qPKYbOgbJrOIRqLEKyYQqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T7Ou02hKoH/Mzh6FvouUpAmUPQ/69yQB1UihZIZi/98lsNmHLkpCBjm7JkiQLkIsB
	 1URfgDx0d8ADe9l3eiwf6+1wSWGZIm7SE6ohptBQtjxE2nvtxB9xUxDSFqzKhAS2BS
	 H6InT7IYQnQY6u7XKLCs17TWTKQipRsIpdnGoGuXMR+X5m7obAIygaMkqXG+R4lZqb
	 GdqLy8wXSQohHEGKhyGQtUkcfFGVURgEj6jieKch5CuFlc8pJKSrWOHVPc2sof66c7
	 ylepB5x7gafA32wfhBUcA4fO7jdYgzXeY2Ul0eI0BKoIG2CLqW/JOgwiO3l+FRq9Wq
	 SYKZ6Kb24PP2Q==
Message-ID: <sashiko-outbox-208021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 09/16] ALSA: virtio: bound PCM transfers and retain
 DMA buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-10-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:27:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Validate ACK geometry, conversion bounds and queued-byte accounting
> before submitting transfers. Retain the backing DMA pages until message
> retirement. Check RX status and upper payload bounds while accepting
> bounded short responses, including at STOP and PAUSE. Preserve the
> legacy RX completion and ACK policy until the request-owned conversion,
> including the legacy handling of empty PAUSE returns. The fixed-offset
> layout still has short-response data gaps; request-owned capture and its
> queue/accounting contract arrive together in patch 12. Non-MMU copies
> use only the validated returned payload length.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D9

