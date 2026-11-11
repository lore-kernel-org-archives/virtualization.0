Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356710;
	b=sM3HcBojEB0OcuoFfm1BGhor09EbGLNjv/8HcSf/ji25Df+CSyo3dUZQN5BBucVBdDdR
	 K/0TTKY5F0xgF0lOMTa/UuJa3g8BV3PgDOiyGcYD2ekALfePGd0tPcmtTHG54i4hnAV5C
	 bf4CK1lV9UPHaWfStSXHEbgf1/7ULumuKkV3Nfq2ufCDvDYZjM/ClQylyDMfGZZENfC2H
	 +KQIsx1N8dZPrvRxLEbIbfvnVKK4ohzA0GDUvU2GVsyKv1vfRkf56gicCAlR6b4yLBjur
	 T44uoBR4Izndmb9R6dVZp0SUIh/2e59HJEji6Hx0GPyEBWsZzzetiWApMWaSatByouw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9xo30eu51LzKXv7lBKem27uGY43+9ThZb0W87Y/gSoQ=;
	b=q5ZmnVUxNg2+6nP6m6a6euGmeHEGPgfRf8t9zsgsEbBgTjlTCF4DqK2ddZli8w8cKUcR
	 mGUiWZ5HD7GP6ZDpC8uZmAco0YQSKNX+neFd0TcJSurAJEJU/UisTtYoGxS1JjG5x9Eru
	 EWZYKAdbWcMqupwkjiodIKL2j4nfYlSkAVCekN9ZgCDlvADjC9xb36i81IEIV2lXk4/OM
	 vXNYuBPaUbCfw/LRhdL//iKCfvPLUzHkVf8v4n4K6cy6d/1fav3CixoLE3puLKra06nxK
	 83Cyat1+6IFmVnWOUM5MrFVwIhWzgx1OmCFtTBGKmyZ1JkoqApgMAXqDhaTpHN1GhkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfQkxvSt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F4606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfQkxvSt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EDE1F0093D;
	Wed, 11 Nov 2026 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356709;
	bh=9xo30eu51LzKXv7lBKem27uGY43+9ThZb0W87Y/gSoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NfQkxvStSI+t2QIRem+ZCGRQAr+ue0cI4LizvT2SpZKwFwkdXgJrILNFnevDQD6Pk
	 9zlNfZmpEpUzIaVUG2WTal+GD6OXjnQiS9ALTtQuJSXP3VH45JYf8sjaO8l96/+Enu
	 46bHlQizqxohWvXguBLqU97R6UqgxmqnEy1v43cJ1LVyrs9I9p6CeE1lq3CNrbwgWY
	 /yHp09gTpk4h1mFhXfyRCcgrCcWKqS/ASj75BwZrIwvphFzPizxQnEHEooE4L2irwp
	 TxrEoU0J6hFADsdBtD3O6CUo/DfMJw6DHEILBhtcLaJ8wPoJLxNI0DwT/RSf2ChKi7
	 vih0sXML8P2qQ==
Message-ID: <sashiko-outbox-208015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 08/16] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-9-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:25:09 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D8

