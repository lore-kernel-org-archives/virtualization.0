Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181244;
	b=zoujHIzWFUoZLDZc7zBFIHbwwGWYln7KzsfcTBL9b+Ep8L/FWXQO+jnzJdW3VuMUaYu3
	 yJw+XGbBwfsZlnObtt2+v6zsCWMJ3L6DIl1oDGXkiRIBKoQSBT3jWPDWeJRpBZ4uuz2/G
	 GKjeVegXVE7QoqoNz4NXoJYS6/RMTRq0ZjBi18SYF81EUT/2+d58sVH2wdVJYoUk5ce7e
	 UIaAHl9D7gsp3IQUSbWly8CfGEmi/KwCIF5iZtF/lruLk/lELMe9v0Mr82Wno2rF+yoPZ
	 M/4O0bBl1V9ZoBQsDfpD1dy2LsnIDX9EQZ4+/OtnzApMHjENBgmMW33OML2+DT+qN8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181244;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NDjzXPXxpsVvmivlicRsdNsx+AtIrJGFyd7gjh0sua0=;
	b=RAWiYMhuDml8ZWqqu3jcNUkBLH5VkH+GqxDzt1bSUlDcrYExC0QFXY5Q7ex8TqAiOsrA
	 tsyfDSq+7kCRS/FxEQDIVIQYPdYokY86uY7GM6Xcog7UnQfSedEnqZrYxf/7ZP04Y0zmH
	 Xll5PQFZdFHLnp7HElDWBz62L04zheGnV08UCRXUdMSkl/KUxkxbrUaxcKSCKKdMKyNLI
	 oYEcnSc8Y3GKiV8UpPDJLHqlSwOKZnnZDzpcollCzNRmz8cH84DbrwzBiA2cUicEtoXKz
	 A0fcsuguElsFk4ODnpU7/1//39Qme32GJKS1F3SHucp8athNWfh2LnsAnaYezP5bKNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gf8p8d9/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDD606A31C
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf8p8d9/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F551F01825;
	Wed, 28 Oct 2026 09:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181243;
	bh=NDjzXPXxpsVvmivlicRsdNsx+AtIrJGFyd7gjh0sua0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gf8p8d9/44ECSSKkmAihPt4JMWCluANMSdi6DGjMCj1Q/EvACb5MliV/Dq3eNxF0F
	 yXz7eEJn1IS8hGpmfFzWpCM7B9HiL3y6KRsnTimVVid/OhOikF+0inkxeq/56Qlv4k
	 HS9vS5p5sK/pxjLz743WuOCj6X3CjStCvPH9TPiIGkmbh/FtK7gIl72N+Kv/4DePAY
	 AORfORi0aB0ojR7jwiBWKrDCK+yqC+nqpxM5hfNcxVDQyU/lh3x2BkmLc9F0kW9O0W
	 6/Lf/BX7SjpDQHrwFhtBx73eUcr/XIrCnNMJMMd17uxSclrH/d6frw3A5q8zjiERmZ
	 VZLLjEOWSk93A==
Message-ID: <sashiko-outbox-187702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/16] ALSA: virtio: account staged capture reads
 before RX refill
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-9-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 09:54:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The RX callback holds the queue lock across a batch of completions. A
> reader that has copied samples can wait for that lock in ACK before its
> consumed bytes are removed from capture_ready. A later completion in the
> same batch can then reject data using stale ring occupancy.
>=20
> Account the staged read under the substream lock before acquiring the RX
> queue lock. Release that lock before taking the queue and substream locks
> in their established order to refill requests.
>=20
> Once accounting is committed, latch refill errors as XRUN and return
> success from ACK. A negative return would make ALSA restore appl_ptr while
> the driver retained the consumed-byte accounting. Keep pre-commit errors,
> ring-capacity checks, and normal period-work scheduling unchanged.
>=20
> Source-extracted host and kernel fixtures reproduce the stale-capacity
> race and post-commit ALSA pointer rollback. The candidate preserves wrapp=
ed
> data and pointer accounting. KASAN/lockdep QEMU lifecycle checks passed.
> The fixtures substitute selected backend helpers and do not independently
> establish physical-device acceptance.
>=20
> This follows pending staged capture support, whose introducing patch has
> no upstream commit ID for a Fixes tag yet.
>=20
> Link: https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc=
4691@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D8

