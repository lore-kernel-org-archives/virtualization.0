Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562111;
	b=cYn68gvAK2ID5qrTqYiiSl969y3qgnDsjuBsmWnSDa0aAwq4HpUDTpt5fK53Uwg2u8VX
	 2mDF3t09+cOvj6FoRljeoZgCsJDD+Vkw3hdIoktPzuz4iCQGLkhbeqFLPy3iirhoCFR4C
	 l9LlqFCLfHHCNrsCkUwRwmBofyRqNi1Wx6TntSKxyDeORBvVb0/yV1yfHIhD0aQWHbdh0
	 U1czpYTnY28FZzOuEnJQPc2LPxwEWxSqn122zFwVL7PL4NPLXmQ3cytU/0mbQBZrS2EPW
	 lHHwiyKbvRPl+s+ACdEcvv1zj3D23Pzy/dyJDCwCAkZeZYAEZVsuINKHPZ0lfta8CBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562111;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kbKn7RsEMxawzVPsqCt/o3YMzh2tPPq6Vn76LoeZirk=;
	b=Fr676+wE3o06PVT0LZ17tKOTtLU3dVVtG4zCXBSMOdrdw8Z/oiq6StRGzhNBHlehPym3
	 QOZJzWhvre09RaidYDpP7oyPfjAwO68Rddg3nVl3ZUqTDFdN3amQWwOeCpnwDEcvbURFl
	 ebDbWZ3h8c1VFwPUrF7IpagNZdNwhgvoqFt36MDa1CPeXecczPOB5M5F3wR1WmP4aa4AT
	 5RHR/P3IBqScbyOjXSyM+ddV1zVQoaRWF0KkMProzg8kN+p8CGgPS/hBpB1vWXwTpwyOq
	 fvu0m1yr+G6Dv/x4DxcHF3XQLnFouyANepJgZ6CRYlE3pml2vteXfHwHalqwe6me40g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y9S/YBFg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8A606A880
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9S/YBFg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9830E1F000C7;
	Fri, 13 Nov 2026 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562110;
	bh=kbKn7RsEMxawzVPsqCt/o3YMzh2tPPq6Vn76LoeZirk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y9S/YBFgZVY7iRNSXNiBkdyUQtRFupIUz/TiH/wwuy827Vxiw6MO9vVbSXOFpgw9F
	 cI9zzk5NfiAbijDjiQAK6pjwBFqsgSCGkS1KejZijkpyBfcjYOa0sRDFYPQpJxuOG7
	 22BlADtc9p9PW9b4H9HdSh5VH1BrZV2oBhP8675CfxMU7B6gfON4vSO3UcFSgD6gOH
	 SEpE0vzQrX8mNxl8CqdfnTvK2iDF2fF9G70pY6BVQtcremjXlQDL/7fRtbVecGPBkn
	 wi1AEAIvM/aHgFTO6w70XrKv+qotG0bqy4U1xrdtyl5tUfnuqskuMv2Q0/t29Cuxw7
	 4G3w7gMvL8zCw==
Message-ID: <sashiko-outbox-212538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] fuse: virtio-fs: fix lost wakeup on a full virtqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: Qihang <q.h.hack.winter@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113091758.77678-1-q.h.hack.winter@gmail.com>
References: <20261113091758.77678-1-q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:28:30 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> When virtio_fs_enqueue_req() returns -ENOSPC, completion processing
> can run before the caller adds the request to queued_reqs. If no
> further completions arrive, dispatch is never scheduled and the
> request remains counted in in_flight, hanging queue draining.
>=20
> Track completion progress under fsvq->lock and sample it when
> submission fails with -ENOSPC. After queueing, schedule dispatch if
> the sequence changed; otherwise completion processing will see the
> queued request and schedule it. Each failed submission keeps its own
> snapshot, so concurrent submitters cannot consume each other's wakeup.
>=20
> Fixes: 106e4df1206b ("virtio-fs: improved request latencies when Virtio q=
ueue is full")
> Cc: stable@vger.kernel.org # 6.11+
> Link: https://lore.kernel.org/all/sashiko-outbox-204365@kernel.org/
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113091758.7767=
8-1-q.h.hack.winter@gmail.com?part=3D1

