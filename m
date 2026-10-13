Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E432F7F12
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878041; cv=none; b=ZnH3YkNQsDhego8ajjBjzEhGtxRJz5TAB350orjksvCkU7NOkmc9gEVHf0ErOuR6uYyUoW2QVes4M2wg140ylugY/tkzAQKAK8GpPLAj5Msx02RhHVldpn4X0gDfl3Ix3sG4+bIcH8qV4B+oHWic6IeACvSzmBqseVXsTwVFTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878041; c=relaxed/simple;
	bh=6WLm4bJ6BsCAupLQ066fhi0qRDN0MMnfX28NXv148g8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K/A/JAk74pQwc1BoTB+TCHPwg/HK3qmzjSh2J/mB4bgJoClvCIWViTNKZEm585qFoQ0gV1iIpJZfb7XSx8eFWraWyXnhaZcWL7ejZICezny3RrLl23DBJJK5gzrrLnQd6qE7myMln0fB+Io6j0UyEtIqkEyuZ1DYMSKkGdw1SBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnuMQLpx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnuMQLpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35D51F00893;
	Tue, 13 Oct 2026 07:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791878040;
	bh=6WLm4bJ6BsCAupLQ066fhi0qRDN0MMnfX28NXv148g8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QnuMQLpxmc9ep3880/IUGqbIGDq76RF0ErJPPSUD318YMXdy3O4k+ct7RCyyRHf61
	 u2CBzLxBLiDl0jbBWSXAbQCbYYqGjikXf2ahDwUIz5nytTPVIUg9EvXSWwOCIHh2BW
	 OWtCRh8pINXp7U4kywFV/ccW0DE00X98thhH/vCDNmJRPa2N+YvW/fPPTptdMhw0E5
	 yBlvN1JnHS2ISN+YPjszlaDgLNdYuMN0EPquZmJgaQJqfm7NRq2QJd19BuFq57ltbI
	 n1TaYw6V8J3F5VUQcBztAycX5FsxFjscvQvIadSfpu2c1kcaDRrHDoPjAj0umFSqJe
	 JjZO/Xq+V7p6Q==
Message-ID: <sashiko-outbox-169213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <b103b82daffc34ac03dec844a5dd07fdfb3efa6f.1791877396.git.mynameisjune111@gmail.com>
References: <cover.1791877396.git.mynameisjune111@gmail.com>
 <b103b82daffc34ac03dec844a5dd07fdfb3efa6f.1791877396.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 07:53:59 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

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
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791877396.gi=
t.mynameisjune111@gmail.com?part=3D3

