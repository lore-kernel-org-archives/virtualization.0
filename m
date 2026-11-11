Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373831;
	b=5SA2gFXd6VxEEq1tRCTPYI6aEBav43S9IFaWI3S1kWwWzxex4F+PmoJ6v7Gx5cQaAoA5
	 lFwe1QUdWhub8OR59o3VISrsb76TCICjtDrXhaU6H0LlppZBJ0mGMhLxN98CGkxNkRNl8
	 nzJaeQvT+KpBTaj6OPwVqDvreDeSpGy+kBnSZEmHOEBQOvFubLqRV+FhyNyxBxdLLNM6T
	 GkfoSq78W8SM/TOLJQOIoIxf9MEFsChHqMafSVxahSvrLIEC2tvuxsBFxDVuykq+rNHkj
	 BLn2NE+Kem04d+NF7KD5eFa/qkcI7modVIjS3wYlYV+Hw+czQSwjLdmfBSz0owcrUJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373831;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Fqnpnph3Uwm+WzJgDpNjc1S18saK3xz3xQcv4jyza8=;
	b=rhIGLka1VidONyL20TN99iLgTmidLkltUz+LMGEk0D6OGF1TEWkFmj9xQ9i0AFBrUNsa
	 2YAesR5AQoI1lYU+hTkD5jWNSQuJEzCvXzn+q/ECsq6zUtCd4xlNrC0JKHtcYG7n19RVy
	 n5U+yeyT6Rm/lgrvBzCmciivtVZGfBwjBCL2tKhGgpuM52cp3i8Dh4jYG/vT+swz1eUY1
	 TeteI2A67hRrV/aQYltu8blyEx6QzrnpoB2XLBHEbhkN/9oS7g7SRdNRtb+c+OB05/mzV
	 DYPjgvG0CdiDL3SaNAOA/naTAiWB93aoJVZwcvk2Ov3tBJ9rHAyGSbaI77BTesj8oVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SaEUxHGy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E6606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SaEUxHGy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DBF1F0089F;
	Wed, 11 Nov 2026 05:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373830;
	bh=+Fqnpnph3Uwm+WzJgDpNjc1S18saK3xz3xQcv4jyza8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SaEUxHGyrVKKqaTYxYukn3PQEGWkQ74XjQAzv3jfUiR5n0jk8shjnpT7SKn5S0LwG
	 GH6S5jISrugmIUp8HCoWvJw7YmxpQO+BzdmlN834OfEiJilJdRfYFZsBmmrdDq7EwW
	 3si9ftyd6emWX/JdiEG+ZHjk6Rq77zwEmGJsYjQxmhoj0yADqQHBjjBbQ2GtHudx2f
	 czohJpTdzqN1WkdGZeUHk4Ycp4/Ioj/XWLn24Ck9DbvoveiJbkpYXdLC1L7zToN7a6
	 LCSntCTDgWDTIYX1xOwWCK7C8zfjAB911Q7tcSDUxoV8A+RgD3s7rux/kCBIQI2NEX
	 81LuMZCdkfRfQ==
Message-ID: <sashiko-outbox-208325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 08/16] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-9-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 05:10:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Keep the control queue available through snd_card_free() so close-time
> STOP and RELEASE commands can still be submitted. Block new control
> requests and mark pending messages canceled before reset, then release
> their queue references only after reset and queue deletion.
>=20
> For PCM queues, detach each remaining virtqueue buffer after the device
> has stopped DMA and retire its message without reporting a normal
> completion. Detach all queues before deleting them so outstanding DMA
> mappings are unmapped and no token remains for a late device completion.
>=20
> Protect event callback admission with the event queue lock. Disabling
> events waits for an active dispatch, and later callbacks see a closed
> gate before ALSA objects are freed. Enable and pending-event draining
> share the same lock.
>=20
> Reclaim pending event buffers after a failed probe without dispatching
> notifications into ALSA objects that have not been constructed. Record
> the queue's prior enabled state under its lock before closing admission.
>=20
> Track successful virtqueue initialization so teardown and failed restore
> cleanup call del_vqs() only for an initialized queue set.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D8

