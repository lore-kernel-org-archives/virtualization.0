Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444791;
	b=xLh3pa/hg5Xwu4mA9OOetHK8NZ858US97d9u35XITbIZLjtJI4pYCRCHngKWBsCFBXkr
	 1c/PmJRgZCsNK73DsOIfCmP3oMnf0+cJUEFYVq8b/fZrWf8iEZkjlo/StLTas1/khNuwd
	 BdmPs39gno4Qn7L12NGlpHXG6peLCDRPyfwGGhi+mJK+pkVxtJXzaYZlXdKhyneMS3p6s
	 VWCciwdXk0pYKGCS3h9X/T3CD4hBXlWEPLi+4A+/8aE8nvImSu2ulXjvrt3G5MTgub6pS
	 C+MhzSBBbMy5+pVy2vHtj/2DfmapMQNJJD1nMQNqum5HmsBBK6wgWHCJCTn0IkNTq+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2TND031os0YA9pJxQAZ2TL2JBF6c0tRLrgdjyHJ8PzU=;
	b=bWGmzuXD8rrdl0erp4aNIdTKI74m6kvrQNae/QupyrnzSr+EID+V0cUyctOmyXKl1/Vg
	 lj2moDo24SMNdTVWFRhgwKOSbTLDrU9VSjg0mAx4tU0FoiB8X53VfjS6J0vBQ4fEDDFYf
	 t4egGSL/ULvLctnD/wPGbZDZHVB8Iak7nBuLtBPXPZvn1G4nJxbunczuoJzV8NuE6O1rp
	 zorM07hDXQQclpaEKNgBt6QefqY6lHO/vz+aYMqqzy7OZxpHOa2si18p0oVJkni/e1FFl
	 zr+1tivOvdHcUmS/S3hdXsnjdMTx7o2ejHteWRFXHe5FOL5xX/a5T7n3t+yKrlKJ41A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DV1gZhi5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA839606A334
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DV1gZhi5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698491F00A05;
	Thu, 12 Nov 2026 00:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444791;
	bh=2TND031os0YA9pJxQAZ2TL2JBF6c0tRLrgdjyHJ8PzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DV1gZhi5AyPxuCCrI1LndGzQaJZ6RgDE5ZzEe/f34DomARU5FjdjsDadDcs9p401N
	 1ed3/FitrbGTHF4u/mxYT/bAERYZ8p6L0fTniTx3YhoBrwbD+9JLrlkxXdgrisYk6a
	 oeRSmqoiMGbJlX2UP4uN1ml4ZdSJcbHM7DIoWO/vxe3o1qbRmGyfW8DeKG725tCIlO
	 9qOiCLCxYVtBXMVJqTuYe0KBPPuu2OdLasiTFwadMadx5ra57al+Dw14aiOWyCLVhf
	 ++cdtrsiu1f711YzUzN9AqhXr8Sk5mL1Mx8qfFJKFg5xaz38EGWzMKVs5MT2TQrv8y
	 fkwN6HccTs9ww==
Message-ID: <sashiko-outbox-209996@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 01/17] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-2-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:53:11 +0000
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
> staged-capture policy sampling.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D1

