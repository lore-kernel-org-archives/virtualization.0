Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925089;
	b=anNZKBougav1n6oNX6u3rvYAOPFroQgGo1fOKg30PY+O/Z2vu96kY+29QrR0kqrdq77X
	 uN2ZzJrE6UqaKeTv9nDdG3v4E9te53lfnWmpLIbuKZ64/qMUos5q0CWIi5coayb9Mo9jB
	 clnlEk/h1zCvAQASw9UGuIjCzxQYnM63CTN8ytjWrU+79Bn8u6Hx0kRQ1DD0IPEX2SkJ3
	 sRSNTfjXpxGDqZghUSwyJP3z2QrocM86YDBpdTtu58y8ol+QpJ6hjug1hgVkR5OCocCXj
	 i++9hzcoyFMAQpPXBZedkkK2QtSDHc7YjeSd7szfXVggglfxVqnDD7JXQsBbvmeTHqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tbg/usjN+V20vDd+vXlIMdA167Du50qvfHuQQr1q1ME=;
	b=FW8gV9cBfH82XYM7LkahaM2S2U4hFVlEauvVo6lbB2ujf3a6Im6pPlAHPDUZzt+tzIPk
	 LthRdYXwcg2lBQGI9FX7FMyfzrutD3fwQ88ENuHFFmAIQLGbpsa313RC7ASGFtuxhEnkL
	 BUTR5lefpWLbmH9rXhIsRk2Y+fRgOds9XRvKr0VDv22XQZsXd2uypLhlkO11YptQIyEYe
	 l3tiE98pbJFyLHPZ/7dM6E0bqK2PeCK3WHF5xTUa7fyEefoW4/DF7YQHD5MoM7S0QOwDX
	 oYrAQ2AcgGzSuYrXM2KrJe/vjN6nMG7l1ubfXclwe4K+btcy5lEQgt7nXYv3B4VcSSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRFAliaX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C63606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRFAliaX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F181F0089F;
	Fri,  6 Nov 2026 00:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925088;
	bh=tbg/usjN+V20vDd+vXlIMdA167Du50qvfHuQQr1q1ME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRFAliaXvug8NpuBeuM2yH47ybyGo6z5Mi3aCpblyJddK+iZrq3svDlkErvi4X5PP
	 e4sQg9eyHwsDr2ZCJmokDK+lh+9Rb0pZtVeE4CfYTQl83A7uI3DyKBcNzFXkyYa6AK
	 1lhrNjdWNEkX/r/Dme6y4C96FTptW8dBix384OHQuqZ7ZXZsyEDujBVIUeO9VFGbmT
	 IIaOfK/Rsopfy733dz7K86OjXjLmVF9d+2G7KWMPjYdldxPPCN2ar5dicL2K+tiwBM
	 hx2AFX06mNEoOC3mxY0HLxaign6aXmE99961Nzasbm666HeF+OOJ1HRUdXnPPwU7Xw
	 faAtpjd+P0/tw==
Message-ID: <sashiko-outbox-200449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 06/12] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-7-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:31:28 +0000
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
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
>=20
> Track virtqueue initialization across partial restore so rollback deletes=
 only queues created by the current attempt. Clear freed event-message owne=
rship before a later remove can reclaim it.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D6

