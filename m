Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762842;
	b=xBH+l8mbdVKZzLLdCpysSEQ3EAbvWLQRXjRq7rHDB/LlI1JkQeB7mgdxef0V3X+u80r5
	 0UGI8QqzdZHwpmlWL70YqGKSUGNvguuWlwy9eQUcuSYX8v87ile1CeI0kUlcnfkCOM7O0
	 tuvPyDT/Xk7t18eIXJNqFi06iyxKJLBBk04HcvZWOESM9yI2McCshN59i0nyNx1c6tce1
	 7pMfunz3IKWFaey9CNXLxFpi9cGiYi9jRoIJFQunCnmI9WHW9pTLYBGW/DLDf/lEx0NLy
	 EQ2EzXjNgwdymFVhw2N3Wa7H1gdbLoP4Q3uHL5fnCdnK0PeCShs6y/QtBPVcpoDlKZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=saQDTqXdj0DkcEi0jgPiFQVe9mxx2eR2ZGA79B5w49k=;
	b=iCfCsP21WgtXVwOP/2TPB1iY6v69koqGfn6XHuiT1oHhMTVaJQiL3IjHlrWBDSBNataX
	 DZdwy1P53+MdxcvySl2jLvRSo9sv6bNi0She7lrv0REhg3nN5mX/lqj9t27+bXLP6R14J
	 NrKn0jJwdV+3iDGs4V08ookyVrnh8LNN8k0IBxlW/zZLv54nndFTBbowFJpMicz0yNoy7
	 cKaGthTsnBNK/7tFNmHKTMHwz9t2lRfr118KUmbonAhgoXXMoSxm02y+EgOOtHOLzFm+w
	 pRd8qmjcDtUsz5Q8j7fZlMAkm5gPn3wMZywi3AKRnlxi/FHwQ0UeIR/xE42BVftiupA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcrPL+AC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5752606D802
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcrPL+AC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD3C1F000C1;
	Wed,  4 Nov 2026 03:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793762841;
	bh=saQDTqXdj0DkcEi0jgPiFQVe9mxx2eR2ZGA79B5w49k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GcrPL+AC5Ccu2piYHeTwYKVp96rLEkjFYEsFlj+1aoJG0QC9s4mai7p+Qk0EE0ulj
	 0qafvud9tUNeJZq5Y8BRriTYZmJqf0/YircNa9G7iHjlvku/4c2no29V+YMWZ5i/yD
	 +UqbafJ4Xt9PB2TWRRuaiWU7bFUplcf+hjjGN1luu1ZqUkTFb1McwwniZrpGvF4ALL
	 xY0BBsl1Be4ZbdhhXL/YLYHIe01Pq6oMXpcs9dRUQ64Osg+DnJAl4r8WYXuD7c9CSe
	 ysHuGwLlu1hTioB4DcWO9b4IA9Bk72iKyw4Gj3NVEpKrOvQZlsAO2sX7gzU2mzjoi3
	 dLUxsC3EsGXiA==
Message-ID: <sashiko-outbox-196600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 08/12] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-9-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:27:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and payloads
> in the reference-counted message so caller cleanup cannot invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure. DMA
> cacheline alignment alone does not guarantee the structure's CPU alignmen=
t.
> Align regions to the greater of the DMA cacheline and control-value type
> alignment, and reserve prefix slack from the buffer base so typed accesses
> remain aligned while scatterlist regions stay on cacheline boundaries.
>=20
> Keep response values in a separately allocated aligned response buffer
> so INTEGER64 control accesses are aligned from this patch onward.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D8

