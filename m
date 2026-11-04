Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763018;
	b=fWxKztEqyjrg/a4RmF5DykybQZGU/GtNGc027W/icqOmO0zbw5NosEXXTlcv3jXLqwos
	 h1Ru+lmxAy++VctKTIZfxr9pjp7ahmysu1COcHfGcXcKzZZGdBd6PC5CVdH3jwDYmBk5W
	 kISR/cqjdSDJXCHw0FQL1OQRP8qcOpDoI8gHhgWMv5jtnrfacPPpSdbxwWOJn1Ocdv/eR
	 qNIT9RbWgPHLLLfSDJUJxWL37cXZYFDWeCNc+1elLh5hove5AHtRpwPFOpOhak3RDcm0q
	 SG+jd9OwXpLH4C6KXEUMm4A8lkXCtiGBXUlLFp2VVIbVGlmgolE7EKsB8QjPMHYo6tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763018;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ldNHLLnOyiVdzlqPjxcC3ODDvZC7lZLw6Y5JZvle5cc=;
	b=NrSXqgzZuM6MFjCmcSQqdJt+Lr0KVRKWtchTkuui1k/D+Ho7hsrwD39Ry2bMAlPOfUCY
	 /wwNNDP3CpOHlLKxnDR/0Av0XhcWMIhBL3kvJ8zwZdEnP0APCnXHMbr0ifm9EssyABH4g
	 kvvNqNFPpzTLhLt+HX+mf7J9mUwaGvvXxTdF2vS08KVhUaVXVwY60FWkvEZcBHmrocVJ/
	 bp7zGxDj0RXzpLmCOubJe1+c7vWiBPY4OdXZzZ+4rvsgN7Rw9w7DHMC+WT/hQ8ChsDRMX
	 1otV/Hv/NH8N+NMd4XnnoiDMsDHIyr/2ONWwxwwEAogoj2+R8f8HEF5vN+P4ydvDAyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6t9YZbI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254E606A330
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6t9YZbI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A831F00919;
	Wed,  4 Nov 2026 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793763017;
	bh=ldNHLLnOyiVdzlqPjxcC3ODDvZC7lZLw6Y5JZvle5cc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T6t9YZbI40mjksbwsGXwi25sgotDAvngcskbG9ID9LzbWHOYSUNgkfiMbzfELjMBv
	 AFXDo9/6MwSaJkOrxZqb8joMRaoG2BhhEIyc2VV5I4s6DF+lw9B7H5iBQ+PmcCPX+n
	 WFvx2Fp2KkIrLb5tWyFpENGnltLcmx9xEy5Q4nFnwyVBZS/Cw17ZuSnt7qIaywHn4D
	 2rhZO1EMf5fpLl9t5xZfw1j9RmytNIYM8S+HPG0sW0dhP/VERCNJlEuq1slWphDPyx
	 Rzlk6UYz8fO36lc7sLGuwPohO+eXzqVnj8TdZYyULRouTfgzfyHdJedAkjsh0imK4/
	 4VjSzz4Z0IpnA==
Message-ID: <sashiko-outbox-196602@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 07/12] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-8-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:30:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Retain references to the pages backing ALSA's vmalloc buffer until its
> queued I/O messages are freed. On NOMMU systems, use driver-owned memory
> for DMA and copy playback data before submission and capture data after
> completion, so ALSA buffer release cannot invalidate an active request.
>=20
> Validate the PCM buffer and each period before building scatterlists.
> Require a successful full-period response for ordinary capture before
> advancing its pointer. Each descriptor targets a fixed ring slice, so a
> short response would expose the unwritten remainder as captured data.
>=20
> Require whole-byte periods whose total matches the negotiated buffer.
> Check offset, length and the final message index before indexing the
> message array, including empty transfers and arithmetic wraparound.
>=20
> Seed the ordinary capture ring once per prepare. Native STOP preserves
> queued requests and unread samples, so PAUSE_RELEASE must retain their
> ownership. Re-enqueuing the entire ring adds another period to pending
> message lengths and exposes unread DMA slots to the device. Return
> consumed space through the existing indirect ACK path.
>=20
> Copy valid NOMMU capture payloads while their runtime is still prepared,
> including late non-empty completions after STOP. If the source or runtime
> range is invalid, retire the request and latch XRUN without publishing
> progress for bytes that could not be copied.
>=20
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D7

