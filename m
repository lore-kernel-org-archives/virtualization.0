Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743693D565E
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885209; cv=none; b=jcG+RgL/ea0pxdxD3H0d1WbKbO5xs/yPC3KXgCc8cankpoQ4dc32IdLo5KNRxnDVJVHVi/NBON8VodTHrX6QH2m698uTkkOzZhKXMOMzoN/KeyCKIKf9fxv5o5m9lTSz/Os0BIL3s3nx2kUoIqLN1s03jRDbHqy9HSb4D8jTXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885209; c=relaxed/simple;
	bh=lnTobVplCWaVJ1YzfDJoUigsliVaLuroA19DWySl8/A=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i2lpkAdod1M/kdMVdkwW3qcnMNUBfhZEVj6VPND0Ojk0mW5rVesCPPh/DOsASnYnKQ6WKrSg8EjAiiJkLqKDog/j0oW2KuxmzKAvXbSkKlJUfY1It4cZS87OcqOtwrdIAPhIk9eXs/EYbwEflcLONMVwdvnDtWa8XRlr/9pIpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhnrJfDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhnrJfDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6421F000FF;
	Tue, 13 Oct 2026 09:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885208;
	bh=lnTobVplCWaVJ1YzfDJoUigsliVaLuroA19DWySl8/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nhnrJfDfLxLpHqdzv1Pl+tEzWLpaWbMbShTKayaCKwyQhB0nY/4O9lT1RYxNdarNE
	 bBQa6NKMYltxjgSt8VFI1gICUQYiqE2LMHszHvdd2GhaZ2sBk2RQlw85w6CUENnM6k
	 Mc0BnG8gfwrU//6QHJRW9acoHKZ5ao4YRqyyJI0naNHKB/dlZPJOEPF91abXmJeCvm
	 qkfS5SpbUtu3aosxphBtyEYYmTDJ2j0thgNAfAhkP/G3J/VEO2WMgMJrSFLhI4ztxj
	 Z63lyXhiOt5dCC0YTKrzHzrvr2VltJnYHge/yQd0sH+45FlKhMitG5J+E88GBOgNvj
	 65xPmj29B+Qjw==
Message-ID: <sashiko-outbox-169398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] ALSA: virtio: Keep PCM DMA buffers alive through
 device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <dd4afdab8acaaabddcc2b699ba379bf992ae4786.1791881787.git.mynameisjune111@gmail.com>
References: <cover.1791881787.git.mynameisjune111@gmail.com>
 <dd4afdab8acaaabddcc2b699ba379bf992ae4786.1791881787.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:53:27 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791881787.gi=
t.mynameisjune111@gmail.com?part=3D4

