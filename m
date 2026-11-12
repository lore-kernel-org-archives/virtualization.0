Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794463215;
	b=WBKSOPWWMsUo2Pmzp9dT6JPZCtCYSI/AWwFqklW0+s8W/p3jqNbW6iG3wNnEzuVu7zqS
	 NO5zJ5JKRWSbVaEqmgiFxmpFqJpCnFivc20PSFkRH+ORTccDB37HWKdTKFJIysTLsCNw4
	 XX6p75coMaiLSbkDDJDrv004tIfAKzcr7DrAsK6fcnmtak3wJJjCW/J7YLsiKrj5F/PV7
	 L1L+xjQWHaeXG1nE+XyZzZiMu1o5FFFkcLZgyz8wkfsRVs3rPg6NRTswtvVbOW7IaH9m2
	 Im8palzQGJIyWU8zt+OsVihbQa2JlcDzlaYdoBkHfuGSDTXCcadeHgDd+vJ+/KGF8sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wBpwafzi7aK/0ze8suzFQ3BOFx7jrwYiJiOwpqI6hQQ=;
	b=5nL8HJ9r78UuRjW3uFFmEQ1BdsLh0mKZruIuwM04v/gx9rejMwJ6CKE+ndMyN4nZSr+z
	 6gWMEfL8Lozt9cm9TpUwqyShn8koQMAMiR5O0uWcQfi+mWHn/o29VQUvhb2Zr3GaNc1cm
	 wDnWPr0+Mwuv7lBjgb7e5vcPiUM3b51NUktC4OydoRGN4m2qLnhQ0nfN+1tdKNiOPWjj4
	 0K7m37qy6pyKU0bMPcOozS0AEdDLnZQOGUDvrjY7jaRmnipk5gi0tS2Rsh+Edm2WGzc7T
	 TNY87YCma38hJ9K1Ua7OG43ozg/N3/hy3ltXSwFq3xrU8mV3+bTNIB067I/KHC+pJzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRKWLo0f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46600606A323
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRKWLo0f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF0D1F00A05;
	Thu, 12 Nov 2026 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794463214;
	bh=wBpwafzi7aK/0ze8suzFQ3BOFx7jrwYiJiOwpqI6hQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nRKWLo0f8gdzvdTlpnWf+eHD3y9Icxf+Yt/BGDnqxmIjrb55JKJARZinw4B5zc+ge
	 Y+KoOfj5tPVg7RzT0KnX2jIClFj4hOJVCyqFanRVHZI0ffxk6qvIrmNBvgvYcQeFwf
	 Twr6g5EnAs4zKsfEDWR3MeOd25WT0oVIKmL7/7mi9FZUGEB8T3T7f2Wfs4b9rUQfaw
	 0jo9wV0LjxZnZm8TxhAcnKxWqpCmUCjqg7GlKLqwgTlOQMUd3OvVAfM0jOBRmwQxZD
	 ypgr+qHcrFT8wJekXG6Tlrb8Zs4SZM8d8vJ/6FwEe1e5FQeAiiuUoiJ62qgLSK8MjU
	 9E80q6bgCiozg==
Message-ID: <sashiko-outbox-210489@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 08/17] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-9-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:00:14 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D8

