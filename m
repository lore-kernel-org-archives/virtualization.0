Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664547;
	b=GdsctfMgbmB4mwJUjCYkFht4xjfof0XKCQ+DCI9OWn8247F0Y6kYy7OviQECTZ7fn76S
	 L64EUD3bs/hmjm7MGYlOL9A1A0Qvh1C4HVWlGUH/zwd09xKY53x9Z5rCjg1hfPbpdn2dr
	 vuHRkFqmAXHyvHg1dA/unNyCUX/wjLQo17qbCUgHr6p65lR1qdxWJPP2TdXBDwDtjC3yh
	 bxJARpf0Ucd/kHWeeznaZGP0t80imsKueSWNc1qA6o4RzQhcbpdYHY+30j1dXFirWg9s6
	 s3usYcbNaKxyCrZEDEonxc+vpgTzmSbbAB1XywZKVgwHLK05f64t/aHZpdx9P+o7LFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664547;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CcT3BEbBw0RVuI2BW1Q5CtG7Iz1cEURyfbZrMBFUEvE=;
	b=IsTNr/tMV1eIRuO0IaokgbzJwc+kiXMw3LfClNSci21jDA7QJXJbJPqT/P/UcFvjdpfw
	 /a7kixfbSjYUjI/fmrmPPg/8OTU22jfUpBVaL5qGTFroGW0KbbpdUBDKLnPIUVO3Goc3M
	 SceRDpjCEJGmx0m1/KVGMEaityVdhwqAF8+G21Q2ffrGfzRFNGYG2W/DoGvZo7qdTgp1D
	 tAB0JhYqVtYqPsJ3zywGNrLqUmUKsDufyJprDEvky9CeYzqYIgfD4fNDh+83yD6AWuLOH
	 fqLvSZClDqYFyZ8pcDRE7Y10YhD7RFFJqKlSxFjOyy1jGBN2fg1Pc9U3ERiypPNziiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6PSqC7D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B09606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6PSqC7D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E92E1F000C1;
	Tue,  3 Nov 2026 00:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664546;
	bh=CcT3BEbBw0RVuI2BW1Q5CtG7Iz1cEURyfbZrMBFUEvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N6PSqC7DVbBoisxzUFf1S/lPENBIgNwXgoqSesWz5Yp7Xh48kULDtv+SRxuxQNSRg
	 rUnCBS8yXyRUjz1AKuRQM0chQDEZX2rrFRlgoAag4QY5knHA+HY2motyfpoybhqLPA
	 xfjvDJ8d3K4XU+bX0sZp1NYdci/MeFINvMLT0V2vJPluyrJitEBiVphI2oeAnsuJAL
	 xx5dDNMYt/XSRRYHll01FpDdVAsBU+jIt5EnfRd46iO0z0ZUCxcLZR/eiD8Z7DgoqE
	 aE36KWE951jm4l2jDcqSWCkgPrMHl0yjiXBC2lulZ4W2gHiKlAuPo0asM3XvVROk5m
	 88rxCMRJ2P59g==
Message-ID: <sashiko-outbox-194362@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 07/12] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-8-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:09:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in patch 9.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D7

