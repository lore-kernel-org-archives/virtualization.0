Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793414421;
	b=XVfYdX/jP+8ojocCDUjm89ERL6F1+cnC01vP5YsunX55Z9SIJGPuUXwuDvNsRnjOR6k9
	 HhGwigHweEx93orf8tP34W0MxSNgwAhWoZOr4SS6pdZIyjLOQMgP6e21a43J+4Ci4G5H9
	 HWToaJkmHev4fOSXO4wsRqGEbGFaR2O1Nq/TebN7BNhDsxUgUplCGKQfRrh9trHTmDE4b
	 4JT0NqBUug6kG5QOSpiUY3t6XFtXwUmzGnmiSsYPEqww+fXhRM1LrGDiUuhSMNpDHEGQq
	 McSgFfWrZcqZQOIaHsb7+FfiRfZpqKg7quRyKl+crDN0K7lX52iEl1p/iwwrMIY35lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793414421;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ie604QrCR+zZtXWwu5izfC2HG3f7XZRXPUsgbMgl6v8=;
	b=4J4gbuYCW8/VWV1SlhtsCplJllQqiAZ2NeA3dSWfdxPzdBcinjzG3S/iT6j2ytnltTWI
	 /xYTU3l9pIueFDq/kU5/yv3mI30M77lTvLyBgUXswwlR+YjtQn0hjdahQGIz/Elh+J6sP
	 ip6VTkpMEPmyp3gB2nnezJRFu9nqoGwBiqKyTqjgBDtoBkZY0uvERp9YHrR1sKeX+ZJLb
	 vNuHoZPrnwa1+WHDTRLf8ZdrEuEjJBTLmFtMXVv23fP8oksmgCMMMZkNlGN3Eo+uuvCpW
	 bnwM7Sss810lrCqhu8zzNUzA8fugiYqrUp8IeGzDaHcQIA2ew2pMVCbOxh76cgiW26A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLwrhSZV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96664606A31A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLwrhSZV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17B51F000C1;
	Sat, 31 Oct 2026 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793414421;
	bh=ie604QrCR+zZtXWwu5izfC2HG3f7XZRXPUsgbMgl6v8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fLwrhSZVzEiU2k7AMcJtBrGVtFn6XAZLkNhGikBZ48z70In7p9FoiIy72uMx6if76
	 RJR1Fr0+S9dCyM7bVqNfgUi1WgteSQLr33nbeGGQYptK4KoHozLC2dosnh7Och99Nf
	 D5t9OUlz/91eIrUUkXSJmoWvdqol9kN2m7MOyrUCqwwV2NfvrBJlWJ6y09Isho/eBc
	 ZEP4JItUXNVpTdazhA8odXaWOiFsNRR+aHPAV+A/r1PJatO6t3QuNk0qCG6aSMR4rC
	 zbdF8OuYh1ZOsgzmUeqHrbIz8SIQlOGN5d/kznd5TObJSJTIy3nAaEM9AuMbLvpp74
	 meC47ayZDbOeA==
Message-ID: <sashiko-outbox-191714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/14] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-4-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:40:20 +0000
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
> Clear each queue wrapper inside the same critical section that detaches
> its buffers. Check the callback's queue identity under the wrapper lock
> for PCM, control and event queues. This makes queue retirement explicit
> through teardown and restore. A forced callback test passed on both
> versions; the proposed detached-ring IRQ failure was not reproduced on
> the tested PCI transport.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D3

