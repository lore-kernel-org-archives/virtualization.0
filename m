Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265487;
	b=XaULOW3z7wMhTHXUWwZ+w0z4iZO8h/bZhjZzU5ceT/BKLJY3l32ZUVxyNMZNbPwNqGda
	 roBpxI8OiQ4I/ie/BVN1Aef8a8papGUmcnkme4hhsGrDFkMFwIJ8w/eWMvyFjqJom91t+
	 DFRdQb1OqC8XDxEVu6zRUklevHSnj+pa6xE4HJ5c7G26wS0nMa+eqjpRzFYoFnKfTKJ+5
	 fizRuEZ0vzKHlmgb3x0sTNR/GnFq8Kg2vnqCDLBD1ucznXOdEzi1sPRTwTrj/ehnFDy6H
	 oun3pfN/+lKj+kYoI4a1vWOV1LSzFEnbxWX0kXObxx2rKudNBEINgUkaNNU0369YWlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YHlXRfQi9Jk2w0yRzWS7jQkfW3Kiwqncl2IuCTOejug=;
	b=OTb0qXpw27Q1MRnZxPcOVjt6miLpz63kWHtgIj4Zm2flCYDEU4tEINanfEcq4/vS50Mo
	 tC5KU5cZDm0wcnOm4Q8NcxsahdaH2QCzGe2lfyOQTwE5Yhi+kepIYVQPeDFftdQ2B1vNo
	 X8+d8cPbsCj2K6sgxd1LyVE0BFjGn247iUDDUgxkeq6bhH1E9ArVKJIGVWwxpqo6g27sn
	 cKFf4BO9dDGh/fOMh2zC8g/1hU7prBJeEiF8t5ahoyrrKV3ZRep3tQPh7fx07/9S/XCwr
	 e74jjngKYaU10E3wdsgYqnTpcrKh7ss/1dZJzsO5QYBwgzUPebgRzrO6Y9w6wMKwavg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsYZQdEx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA5606A31D
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsYZQdEx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8532A1F01828;
	Thu, 29 Oct 2026 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265486;
	bh=YHlXRfQi9Jk2w0yRzWS7jQkfW3Kiwqncl2IuCTOejug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JsYZQdExQp7rR/QyJOcu/mkEHkhPr8uFkISsBNCta9CYdoRTrb5yurbGakcptsjiX
	 pgMk+VYJNVr2ftKshqQ3apYz7mQZ2OGHk4L8udplI+3we9G6lZf+yHtaA/hNSUj+1p
	 U3/vYrgPp0ZSfVN23NjAbEf8OW5iXG4te+ksuVFQ6zul9qX/n9QJThckBD6IXPTU89
	 x18hH+EXntM7Pmq/bvLpfK2S/4JnpHuSFGzu0tX6BgSivKX4lFpWCwonYCj4hl8N9o
	 00JPtrG4nemLD1bHvy/xEIzWl928X/qJoJ/6wRoT8verK+/PfaHWUTsIaL7JmqUB5F
	 q55MgMgtqtLsA==
Message-ID: <sashiko-outbox-189020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/14] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-5-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:18:06 +0000
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
> Clamp device-reported capture lengths to the message capacity before
> advancing the hardware pointer, preventing an oversized completion from
> accounting bytes beyond the buffer actually submitted.
>=20
> Require whole-byte periods whose total matches the negotiated buffer.
> Check offset, length and the final message index before indexing the
> message array, including empty transfers and arithmetic wraparound.
>=20
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D4

