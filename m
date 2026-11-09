Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202956;
	b=eITPoRf0LCNGJ5tfLCMvh1pSf1u5KzhWVHhQEgcbfE8jrw7ATA4NwoysIqtkNul0PRsM
	 8/GxB3asuI17/w2JZktiX8O0+kTFvF2/LAY1dX7w8W7hglcVfJMvAHuKnEmcm9AbVNReA
	 DfdJ/m8f6wDLi+AErcyUatKFteScj6T6PxJ76mIvrLgbQL8euiko6n8C0pvaNUQCFzHza
	 xaOo0m0AXuUkFcU/PLpanWabzxFWdzLl6QqAIhXReRlEo7LgpAvz0TYx+60RlyIvPYfQ5
	 OEQwbc5XaSFnklmNgwOwzlN4iZkrw8dvOCx5zIW+Mx0mlWYPy2aL3IlyogkLDcT1jPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202956;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ORCniipg7uEcer22tI0nu/BDwfvqCRdYvOfx92Ea8ZM=;
	b=t+ghzPkUpPKUvLdAgFNMmJ2uijHd3VRFMqCtnUPUcY5ubYyWU0Ef1KkrNkM2ZHbF7Jnb
	 sZJDbh4sigo1vopLLaz9Cgi8d5ehBoiNpyrWVL6MjPNyZIPLX1weeIuS+cuMLzylk8Sgs
	 8z0Tmxa5O4mUAwQuRBckc2lPieY4/DTm/Hoe9s3gUYDJCIRm39FqLjIUZkTBrc6u/Za6h
	 FetmzAK5Ebg8BVECf07xP1uk6th9Byy6G8F1CNyEDDGi/ajNGEVdZtQA2W9KFsmIBn5Tk
	 uNNvpBrpbmapKzclhwpBkDcbDLrhJJsg7Llwou1D35cVQ5kvdmFhDbFQhxP22bNfPKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ioRXps//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94350606A322
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioRXps//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF5D1F0089F;
	Mon,  9 Nov 2026 05:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794202956;
	bh=ORCniipg7uEcer22tI0nu/BDwfvqCRdYvOfx92Ea8ZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ioRXps//DYej8Zt4FbAzjPcgam4s3iPWAtKG7HDxl3BlqIFERhLYAsUp2ISRRzK+4
	 NydjSKm/8Uyv54Grtv10bUb8qMsPUVkkmvK86fxfXOuWS9vjHrlgOcPYdbPKE5Neg0
	 c12a+MJmYVwubhSwf9Bwjc2aHjHNYLXpEEDhBa0WGolzVrIiGZ8V8NTIULMtBWMMNW
	 3VZ6gGF7rjDmwgR5pGi+QJQIpL/pnWz1jxzC0g21ji/o08UY+y+F6UcjoOuzrJTKxB
	 4xOa/ySZ3Dnu4BfyA2WX3/PM3kdIoZTlqUKc45BeS9MjIg9oA3zc/aW8iM8R5I9nBE
	 xvNGcaXnZs6YQ==
Message-ID: <sashiko-outbox-204452@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 05/13] ALSA: virtio: propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-6-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:42:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A failed queue submission can strand earlier messages from the same ACK.
> Restore the failed message length, notify any earlier queued messages,
> and propagate the failure through the indirect transfer callback. Commit
> its private cursor only after successful submission.
>=20
> Keep ACK admission closed across the linked prepare action and publish
> the prepared state from the new prepare-completion callback. On failure,
> leave the stream unprepared and reopen admission only after the core
> reports completion.
>=20
> Once the PCM core has moved a member to XRUN, return -EBADFD from a
> later ACK so it does not request a second linked-group XRUN. ACK during
> prepare remains rejected until the completion callback.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D5

