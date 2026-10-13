Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB01F78E6
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878485; cv=none; b=Wip2Gtaapa/ezs+izj/gROQi7UIfz6sudjOK+RHF1zeKkdTCqYwb05cIpenyXvREF85n+pFSpwIzLjNTqDc90BNN47Ih1hHzu3Fn+YC4Vo5EQtWdV8iOifr2VsxLCnwhWFwcZj99osd7XtJX0MAmc5+ARFIo0IqRQyCFWVgC4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878485; c=relaxed/simple;
	bh=a5ehQsXN/jdJAw7iBQI2pozUCjXRWoEezxavWnCyRk4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Xcp8bDeR6zEwTHJaqB75X2Pbtd9Pmkn6epCi5O8nX8T1pUVV1Pn1zTwf0biaQa6qqZ2SxxIjZNUUdfLnYiDuwz1F1woK5NEaVJ9v9QNYR/st/efNuh1482gliIfXe0ysctANkNzUaq4VBuQBWJZ9xPZpShh+JI1R7oPQ6IgmwAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D28oHRPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D28oHRPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C58A1F00893;
	Tue, 13 Oct 2026 08:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791878484;
	bh=a5ehQsXN/jdJAw7iBQI2pozUCjXRWoEezxavWnCyRk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D28oHRPwddMi0MsaIq2AFfjqjDAuKZny5mZ4VBD8WNw6L+xQp9tTIKrfWdD8TQFJB
	 J/mc0gkoS2Z8OezGTrsOi6CvY1n9gqE/ROWj+5urw1ZZvRDlS40THXa089hTosajmp
	 r8RwDH1d7Smopt+qcpc51kvmTA37hTU4nPwwKLBNFOH74gQPSHz8N+GtI9x6kyBOe+
	 i5H3v7m//RaoLF/H0LJFQCzJAY1Qmu8N2Ki4KlLu4KJ5UBNSciUiMCT+fpgJdo0ibk
	 tWgoHHllINpHKEflpZwX5lDdsEm06aRHJl+1yFkciJeLDYxmVHz5HJvrI5QmWFkdK/
	 +sSqiVpYNTtDA==
Message-ID: <sashiko-outbox-169218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] ALSA: virtio: Keep PCM DMA buffers alive through
 device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <101a1771075d6ba980f25f4ac56848a1d38d8e4a.1791877396.git.mynameisjune111@gmail.com>
References: <cover.1791877396.git.mynameisjune111@gmail.com>
 <101a1771075d6ba980f25f4ac56848a1d38d8e4a.1791877396.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 08:01:23 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

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
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791877396.gi=
t.mynameisjune111@gmail.com?part=3D4

