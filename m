Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339832;
	b=ka6crH6QfxT7HMp2/aKxW/X3QyUH4+AecA3yGhXXnK9LscvZADHPzOAhk2aEhYfhYEIv
	 YOhWAFFrQR5gYL9HSXGI5O5I58jU7KRpXZmddgWBhzR25gIAbciw+6CvAZMylcx6j8U01
	 isbfTi8HXiM7T7TE2H3lMGAknLF75zufaQL6d70GHoZsBWz+NfT0NOa27rlN0gBHmfkcR
	 FbVvQkuzz7T8u5rKEQaEdRvvjECJ51UN0kEXu8wPbt6xckN8GLz+wRPlATVCvCv1Qf0Wd
	 WeoXqo6Htot6PFT0rS7M8dc8ObmfZBzGiuC2xr4pshGw8F+iHzESI/pp9USAUjqws/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wwcit6kmFHQvVr02Ym3sg/7qLkSWWLcxd0g4wjdnxW4=;
	b=5gEecFOjiCFf0zkyl636PQvEKhLvh0eNBeUnbgrYZGKG/qlp4IuURhUCDCBkP7pdWQVD
	 jJ/PaMu4pgJd7zulFn2nH+ilfxbOxQKyBR+Su2wNeJTgPcnh/LD6sTJb4AxQhxvDIVuKT
	 JphMjY60KN0tHMLGb1zDIZQw7ZjPGz6M1hkFaDd9vxxNovWnWkxyKG9ACcCRNMBjfKh36
	 so5dzEfGWXYuAIrNg+XVJy93Q0rZZc0ePRDe60EWSQi9FdVkVEDJlG8X9OooT59PxQBrW
	 pVXlaGNjsiJTW00xHMK8PQOZEmujxJ2HSUJrNIo5eku5PqZwlWowj6IZ33V3WRX8qaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PtgrK1+A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB26606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PtgrK1+A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD341F000C1;
	Fri, 30 Oct 2026 05:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793339831;
	bh=wwcit6kmFHQvVr02Ym3sg/7qLkSWWLcxd0g4wjdnxW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PtgrK1+ACLocsOmDG90EoqSbXKJcTpBFnQT95aEuhOi40Av8UMCb7vrDx6NkAnqCP
	 8momPm0eLM5w4A7IXNh3b9j9POXnA/omUkK70zdpL1iLP1bERC+OIfiRG7TN0OI3i3
	 2KkmK70PPik+7/So8y1OfW7Yeew87Is80CiusJHaQGAhCYbzL3kRyMIamqLQVjuXct
	 b9dZTyDD3RItFfW/By7I5XN/JWdK3lFRa9q5IltTXkbDNOMpSPIzCqqvpcQVe4sXvk
	 xLZq2lxJqRr/Rk1+4pcTeB3o7LDeKNjwhLKVsgoN2oEn4hmhXav6cDP5VP2JV+EkKj
	 j1Zm0/2PvCYKQ==
Message-ID: <sashiko-outbox-190583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/14] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-4-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:57:11 +0000
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
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D3

