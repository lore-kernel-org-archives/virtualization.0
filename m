Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563163;
	b=k4F1cqELK9qg2Sy+uDHBi2qIEQeOWyfM89gttRJUuMNQ2Tg1tiJbyk7n8cx/25cDhhyS
	 5OWzcxwk+IDmu4oPTp0x1Nrb/StAy7eOcuRvknUN03lY0Ty7PCTE/YNdBuCAGfr919l0d
	 9QPgPopiqCjY4BsNBa9qUjXuWrkU+oRTqovVAl9lecMVGMpzk05rWZtFEMNnBmn13wFA5
	 8LDRL6AmCS5CxKVJVCrr23/lrpvWPBnLcTMyrFDWXoIP/bSTISTb/syU3L6cqLL8uEf3a
	 EcMGOc5Pc0U6I5S8C8ZAZHbkjCTuw+RM/yJYKSPm3QOZUMyXiQp6SMS7pB3UgeKl13w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563163;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G2jkBOyxldOPTidU2waQ8CsTtnWVzIcd6HrlYrRYXVk=;
	b=OTwLpLNHo3oRP9EPHUETPa2bqCsNTu6Y6Rf0WrYvr+XA9KV5QJoU9NOcvVgt4xSfaSho
	 JFeDC0JGT+mqPs5bIiCQqOb7wjyzYXw85f/8zgke/ArMzP/rjZioAX2lM1HqQQzMMtGZF
	 RwJ8gUiJny9uGHYU2ywN9fu/0YLXsMDA6/ImIBlMhf/C7QXCars/h5PSsza1Q3c73wZM8
	 TuSu49EQIysEzGiQezfpK8KN8nPJqyfIPDQ9mxUzoF1I4wRIAyfH9x2swIfZvDh8tjPkN
	 chApkGSHCrTUrjfBUfNW0z2r6r5frmzpc7/2H1g8Al1PbwHAZplUNm0P0Vq3BOSvl3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GizaSb2p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5937606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GizaSb2p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D130E1F000C4;
	Fri, 13 Nov 2026 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563163;
	bh=G2jkBOyxldOPTidU2waQ8CsTtnWVzIcd6HrlYrRYXVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GizaSb2pQ7pwTfaJrxixKhx+fUReTPI8EQYfRn8OJQe6/btXczclz4C9Eu8VyVv7R
	 m4fiz7MSxF4hitCRzxv7GA/0e6WEsblOdVzCWE9hbHH047egCDZgPkea81xiv6pw88
	 SMss9MdMEbmrw2fQAx5wazKyoEgBPwNP893+dMbEr1hyOVDObtPjgav/NHSzC/QSHc
	 23iVAoQvs5oFX27tr0dI0rGayAlMze8J/EjfJcxpWzPpClW5FqhM3SvcLL6434lb+3
	 AjZzV4vXH4VofoNVRpniw1QbCOAT/k9exMhvtKLFomGoZql5F10sY/jFQ5B5DB/wGv
	 /SQ6PEAinoutg==
Message-ID: <sashiko-outbox-212564@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 08/18] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-8-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-8-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:46:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D8

