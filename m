Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794463231;
	b=0XnN6at2oj32HZPMLv0U5c59kcrBAwd5RWlNRyqUgPan/P7Bqmj/VpmKeluCdtRlMnPO
	 N4Djqw+22bLROCx2ahUPRT0464v2MB6w3bJtU1yhVTjFoDddUPOU3VF1bltLk7+p53FIV
	 Zw3ZpAChbwn18uyQAjJQH2ACG1dguDnGoheNyhyORm5bAcaQBCy4BMlTywm6vhdGd3Gsc
	 Adxjy5cYYgij47xzdmc35cFXTtc3H11EoNoCqq5J7u3OWHtQY1QkWcqP+/0J2rAtH3xLw
	 cVQJqd2ERS4xe4eOPmbJmNN9mxuXduqQBW1tLY9HdZekjGn4K4ZoEFR9bFWnjbWr2+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463231;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=udfRgTkSUTDPlxhd/YR11XMjwGzUBaKPK2sJp6PmThY=;
	b=FDsX7ap+ffg/vdL+FwRB5yscptDTAdLaXsbCy84UnrYs4rlgbVhxBjlVIQ33VsIOxgBL
	 sMTwwllRGZOk6fyNk4+rYMdEbm5xduYUjxu0iHcWvgGYvEeXrXiMA5eGEDPpz7omC76mn
	 +R5W1JqscO+ubKQ5Y/8xKDB8UO61ZBQ3krmoWFRRgyk3VEyqU2nmS87CVxxaspbTABWuo
	 6C84gtpVNwLSjC9OMkDUCTPeosYudlgGkFHQBTHJN9pjXac+SLt2ALGGIxfepGEyZiy4U
	 IzsofchC086VY6QGrEjjhxUnGMFcOEFN11GUfSh9JjuiU6A2nQQUNr4VzwczXStJ4IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2+1fE5q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49B606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2+1fE5q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3661F00A05;
	Thu, 12 Nov 2026 06:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794463230;
	bh=udfRgTkSUTDPlxhd/YR11XMjwGzUBaKPK2sJp6PmThY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M2+1fE5qq+GvA9qNDaqq+JD+GnNY1EFdOTo8D/+tOuo95qZ6KszErydIxbTCZE5E/
	 JtXzCzFxCMGJuLO6+u78qLaG3vv2dZuqpAXzhjhINcLR0ImfcFqM9FNz94oDYBoHeV
	 cTFCjqKMAJfOs+Irp+/lG8gL8/EQCHDWbPwz03fuUQ6qaVbCQln+iKyb+ngcNlAkMv
	 U9upeuvCBXbVetCF8aybzx/8WDFZlRJVW546KEARd4IUJgvzA5Kkapv1d8g4NWHKbU
	 lqLUgWbBFuYI+5jrEFQ3JchXPSdS19nvjsM7Lci1SGYself1P1xhLtNQt8HO+W3rUz
	 K6Z9ewFdmbaHA==
Message-ID: <sashiko-outbox-210490@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 09/17] ALSA: virtio: bound PCM transfers and retain
 DMA buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-10-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:00:29 +0000
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
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D9

