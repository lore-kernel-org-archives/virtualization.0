Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462416;
	b=ggN2/eYWkDmf0wM3KCvpGdkRUJz0VcKDCvBqrHBGROBY8nRd/g6H/8gDPBSRATnuln91
	 CJeLUG2itaz2Sgdt+kki/5GMWXoueFIAqZ/5iX12Qj5rTr30jaVmbVKf4Xt2lwW2znwZJ
	 Pn6lw2msTM20zDoWFzKEYTDHk/5H8Bq5+CQ5gQrfEHUnsGPhoRiagmDAbAPC0aRWBY1bV
	 JocOK9g3oJ0w7uraWOyN3Y9yAefBYXTVqcnH4SzCBfRkfv647SEz3rCnLd2yWqF01QGxN
	 sJdKYq39YapNyFwlhxT+mAI4Fv+894kQDKKVeFo48+N0bPCAZME5laGnvb39V2LoN8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462416;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=li8VDF9zmd+SDzHcSsZREPm/DxtgwBwgG6+oLu96Qwg=;
	b=xiI4m8JuAMMnTBMJE+cCKXZ6SJbqymGby+09SStm0ExAF6mIyK3XOAt1Jv16nGCaQQSb
	 SxX6gZeIL2EYNx2u8i36rXTZTruvj8VfI8sowmd+oymY116kB1Xrvpo4C8Y5w91H7uXBj
	 vw4Cn9zMeHJWq+sQ4YxgmP4VxHfSgqK7s7xAy202mSYGF5cSrYXnq3209/XnIrynZT/B6
	 T7UdxxgBrB/jFsjbqP6OQTZcy4UjtWqAwyxAnTua8ydMcK1DVyowFrQQ3enSyEqo4Oekq
	 lowhSeSn0s0l7ys0PZUnbiOIjTBBSFqnWNt+aagFdvrMb8jN4cyyvNKcpmPT45GsSLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyOuW3GG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B76606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyOuW3GG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8791F00A05;
	Thu, 12 Nov 2026 05:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462416;
	bh=li8VDF9zmd+SDzHcSsZREPm/DxtgwBwgG6+oLu96Qwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JyOuW3GG5tEhRswmGJGbx3bx7Wea2+jVL7rSyQaHNt63e23OtPjQwqTad4ZY4+Z9F
	 /msl4O7K7ZdAUb6cx9y3kmIpVaaTP5F2HLMhaNGVLKgMnPI0uBIsDPra7LtDsWbdGC
	 fiL4HLhzqnFru4NZ4JVktvZ+XTB0nlGwffwv3cskf2MRg4wYGRiXCJ2PRaMzbUqmP9
	 SGBhJUkxAWOWor58jfvYMKC5kd1ilxEEz82fCTkaw1sUlWX1YJJB7cRsJt47esGapH
	 5Gz7SMneuvNBecU72/S/45KLcpqKKDv9s2YTeeRz2sEK62O9YdoVxy9rVz989hOHU7
	 0s75SDiOHBRhQ==
Message-ID: <sashiko-outbox-210479@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 14/17] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-15-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-15-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:46:55 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document request-owned capture in the ALSA configuration guide. Describe
> `capture_packed_status` as default-off, reading a packed trailer after
> returned data while the fixed status scatterlist remains the default.
> Describe default-off `capture_pause_restart`: pause uses STOP and
> RELEASE, then resume uses PREPARE and START; disabled mode uses STOP and
> START while retaining the prepared stream.
>=20
> Note that on MMU systems request buffers are vmalloc-backed and
> page-rounded individually. They remain allocated from hw_params through
> hw_free, and capture data is copied into the ALSA ring.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D14

