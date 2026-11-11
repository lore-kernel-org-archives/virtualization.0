Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375813;
	b=BnMEYfdB8/LUbZ3EjMspZtEhvdRZBbW8OtICC6vJakUzYsmAmlY+MQ+1TfUM17epaXzr
	 L7Z7/Yen+Zp8hEy7s/Rb8YrlaXICm9sn82Rhf+JRnaD35yDSdDFqqxxsJq3WkpqYjBSmy
	 6Vb9ZxJcTKzIpHQSYdRxOOeRXOOccPynh2d9wpl5kCntN/7fHacvay4RVUZ+pnAfOpNPw
	 hSmZIK3zJDJnO5qYB1imuiBBwB0uXjuJjCoJ3LJUqsPHzgfdrbd76v54vbP5x6w1Jbkub
	 CqH+iWk56eoO4bYkMJajHQkvtkBLubbl5MNEsy9LF9+7Q1fWUGImjdejkgFjMkU/M2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ndE+zt+XoSGRVzV93adymNpNbfIulGvsCMMwy+hQV7I=;
	b=GtWoeEdh/rQpoRO52IJR5Iq+mlmSFK8nIO9AtH7f+C1KBHrLOGtW+cwvd5rpE7JFODSY
	 KIn8B5OgtESbHxinzmCZ1IeQ+T9OlxRlamhKR7vDVioq/zASmAjnqZ3Ixin6RvK6eURsX
	 aIevIJmeGkKpHt2qvOghBnKI373ycGk6JKzCWWu4EHgRyN4zXf7eQOTGWwxN877Pol1tp
	 xKFeqONzUPEMkuVPpChyfDXcb+Ncxsjq74zx86zGx8/f4+P6E0+v7PFVaZsvkIlEoIMln
	 sqf76NPzfHGFmJZyHGVVb65hggp01yLmefvSMduGyoEH5tt/Oohx8on0Ya6fvfSb81A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFUeMxX5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FE606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFUeMxX5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528E31F0089F;
	Wed, 11 Nov 2026 05:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794375812;
	bh=ndE+zt+XoSGRVzV93adymNpNbfIulGvsCMMwy+hQV7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GFUeMxX5RvlBZ81f1zFDRwxXmB6s6F5su6h+ZJ6PU84weRMS42SNFg2dgI//fc6l5
	 F9HiiOi82FgDRpclgR7+etvctb3K1cxliGAIs4C87jMlpUxP7laFABlyen4NuJpw9G
	 tfHClYn9M95sFbWoq4YycPJ+snbaXTN4ging9w/Qh013/T6QykIXZVsqQVcC+26sQQ
	 xcjd+2QbvguYXbE0TMqT6b8k/HuLvNdB9OgaIx+fh1H8WXhwecH/w3C9yCkmvYtH4i
	 4ttwO0biWrDoobkV1TPlrqD0ZomX74h4Rx9nMU16U/FE7yC7yXVrgWiRi7UAzFZtJk
	 jUhCdqW04jOsw==
Message-ID: <sashiko-outbox-208362@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 10/16] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-11-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 05:43:31 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and
> payloads in the reference-counted message so caller cleanup cannot
> invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure.
> DMA cacheline alignment alone does not guarantee the structure's CPU
> alignment. Align regions to the greater of the DMA cacheline and
> control-value type alignment, and reserve prefix slack from the buffer
> base so typed accesses remain aligned while scatterlist regions stay on
> cacheline boundaries.
>=20
> Keep response values in a separately allocated aligned response buffer
> so INTEGER64 control accesses are aligned from this patch onward.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D10

