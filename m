Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847367;
	b=s7H2rV8fp7b9sH+zAhBoltaYNwBjNQ95njoLXaAgDhRfX7hGuHph8vdYIOe+SYEofkug
	 Ykg87ZaZzGiDxiOK7a4r6qgw0gF1tqOMNOCAgnhcQD4yGNjDl9tcFSYnzS5cx9u77hgmE
	 SMrKjnyt2Sljul2NNETWbY3BY50uJa6Y7OGoEo+3Rw3wyPpsfQPuXTz5DJN+NJfv5ffb1
	 vkkrY+wQC3LTAJLlfUsXOjMinTF2IP2LyMIWLWOxq3k0uDTI5AqmMAN9+oAUYHhIdVz0g
	 nm22OtxJ9YuXWaBDxI7+7rbQT8KA/hsHCRmn0HzlAzgHuUhj5B1daN8fBXmqe+vN0Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847367;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qE6jYY+0no7pKhZwqePPTZe9NQ/SweuMNC1fhf1ecYA=;
	b=OGF6m2QX59MjPFDXPYESwwek0M8a/nQpjZUezyqho4ubl7ScKmFo5/dq4OdlQ7JKFw5i
	 vh/TCHUdIccVPB+INJl+/ughO4tuUuSCDI/s5jQV1B21p0Wdgr/ulFqj4mL7yZB1OueoJ
	 BfMvXrq+RUk0RR4+QBA4B5mG0h0n5AY6HDVxKhT/kYGxju5pVp/teyd4VVVgI+OJmViDw
	 BGNcbfXl6ZD1ccpaoEz1LVojiS5svwgx7CWhSvTG0L4In8ETZ+7oyaCAIvzGC1tMjeaE7
	 6+rb+y4bOcVSLXV0s0k8BVV0LlS3x7rEAKupMEM4NTQl3gt7t9aKbL3eoVzrPEkJaxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0w5q1na;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B20606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0w5q1na
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE82A1F000C1;
	Thu,  5 Nov 2026 02:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847367;
	bh=qE6jYY+0no7pKhZwqePPTZe9NQ/SweuMNC1fhf1ecYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n0w5q1na/fAqoz1UhXzcSbCo8YoU5x3yV1wbFEmoBwb0MyvkHc4mHMkLs7ahHGTnU
	 V3iGZr/KeVoj6buRsKrZ605+97e/cxyYQd5k7D2YcHrRmK784PWX1vh84T93p6GshS
	 FL4OopRlT3vv/0EQ06Jw49MY4aXYtyIaAV9cxWz2GMKlZgknTh3XZa6lb+0Jkbsa72
	 fGQ9OCgbHssJ2oiqU76HW8IsdlD7fLUpjEM8e82LXEFbfYfd6idrRYeCnJX7oPGLmF
	 rTTmsFbWZnh8QON1XvsX5tG0qE8fdZts2+03i0Zw3XWuzUmMlIBxd60JJFvxMJ5JPN
	 gqnOHneXzF/sQ==
Message-ID: <sashiko-outbox-198488@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 07/12] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-8-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:56:06 +0000
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
> [ ... ]
> out-of-order full completion reports XRUN rather than publishing an
> unwritten ring slice; this path does not reorder completed requests.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D7

