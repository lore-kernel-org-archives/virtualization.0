Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371470;
	b=07M5Rjp93161lJHAL1hlM/Tiz7C+OH4iviXPELQm7kCOyn0Xv/ScLQU0uLjh8L3KnLN4
	 7bPKA7uvYjdazjDLzR3o6l5cqaDJIBOHG1izodjc1DUSgRfdx3n+g2hG48COSc75Ztjkl
	 pbzVHc8rjLSW3FjgqoBdVaveJg4EogLHwhBqZ3+xfmUZ1InyiqgIC+PzkaXoTpV5qZ0o0
	 jIp4If7VFvaBV6C8Ny7CMMFS8jz4ZzRAnJzgpIxF7RyasTa2mv6kR89HH9jnYSX6z61n5
	 JmkUxDkiHpGCQkQJukLJItlWir4DJauNFV5Z/rzRERHFlPNpcB3XTqyxR2wknNxU5bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371470;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5LjKgFDR/T2GSwZxJM2GrEMm9PkE5p952etwSRQC9aw=;
	b=AxNmjRpig5LE3uD7TUghjnaYq+LBOmUMkWuggalIxrfkc5QhTKw0D/jOOHbYH3Xy1r0B
	 yYWi1a2fxL/9wz28+/p777M3ziyVefdrKT7pweLnuybFsOpCijqDovke1vqJ+He/XEzkQ
	 4J4LIKuzhypbvrFIIcBAeS2oFaCBa5yCcA/QU1/u6aQe8hstNOPJF6qFqDqHlb8xTfgLM
	 2Hzmku85Z7GAp3f3Gusonm6dqQrpmVYKW98JrX2siCkAImwi5HdqzCDfhgwPBeLYr+oaV
	 fPHWb3D/v9m0yaOEDkB597aeyJEwRTzdeDF0gE9qpkc0e18P2kyEVqYkQOOjLc2fzww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Kjv81CS/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C090606A321
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 04:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kjv81CS/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D8F1F0089F;
	Wed, 11 Nov 2026 04:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371470;
	bh=5LjKgFDR/T2GSwZxJM2GrEMm9PkE5p952etwSRQC9aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kjv81CS/ltIG0Ne8tnkC1oMG1IxYhpYe59BuC26xPFTGBOuA+OP++GB9Trn5RSDMt
	 54Q3+mBDs0zxkMarxw9mONet6OPvSvzCHWTn51mlTpXBZFl9VnMZY84jvkdxDUgOyS
	 Z45lNiAwSOAX+yipCkcoSgezvklWvz/i1TXdulclutqhtiIyQQIBkRIFFVB/sDVAmB
	 DXTcc+V5sBQVrFubbWhTIN4NF+L/SsHt5wG3wv/Rp+Yp6YvBREI/071lLvmoQAUW2g
	 Rj3yxBJd+emWcygncRAKBm8EmEHQSIHDLDreSIy/VnYeVc3rT86Ji9vDGuVa03DMLX
	 gRnlB+pteX7RQ==
Message-ID: <sashiko-outbox-208287@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 06/16] ALSA: virtio: propagate playback send
 failures through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-7-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:31:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Propagate playback submission failures through ACK and commit indirect
> accounting only after transport submission succeeds. Keep the PCM state
> and buffer-access checks synchronized with playback transfer admission.
> The existing capture ACK callback and initial queue reservation behavior
> remain together until the request-owned capture conversion in patch 12.
> That conversion introduces RX reservation, validation and refill as one
> contract.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D6

