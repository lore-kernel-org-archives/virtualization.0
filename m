Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182550;
	b=wv7w9Jjo5Tmg/7K+OmOiw1HAL20nEkSiFxUH6eV37XHqjeeYLwK9YyaL32TIlMpPqBWM
	 AxEP/EkUOVALdiJk3vxinzmPgaz6IcHhQCTYrxbIAta5VwaWim5Gyq+rGF1p1SevaYjCW
	 1L898YaYmCi5k0wks0/1Y6fbRvdZ78subIv6+85aEAwTqMJl5DWxaPBjYJP4krrKtdPIV
	 QxMzVwez5MdmvKMdXUaAFkxF4ksQVwEkfXZtbKEWTxW8tkSlOFMcY8H5RVF3nB7xrXr8d
	 pYhKcPN68QqmYi+YpTkRn5zxqMRTNzV5LpvOl1s1ZO8/dweLQ7Cb791Ep2qdxX4KVHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182550;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CLCAvP9+w5zfkglm9iaLO1OLZyv3hAvsiFQ9aDMqzJ0=;
	b=POscpSXlaorYT1ZwdNHYpPi1PeIXir6sUSlSp6GX+L+Af4vU6sHHmWCMw1i8OYapkAtr
	 BJRbVi9VaJggGTClT7FHq7FIaP9WKFegAbLr8BU4b6NQgiY+3T4oUmL1K3tHLhVzYCjch
	 loJw3OKr8aw33j39YSme7vIeRVcJQmnoY7HmjGApVLDoph2hqrQMY77icmW9MSDp7S3tG
	 wkvX/xYlFBYxiFkL1vE3Mo8/dl5Rio5h3oY0OlbTba9JUrd6S4jHajYoi7n/24tR4MD9l
	 IJhOjoUSBiIE6YbCsAj16kmMJZWONU5OopXBPJJI0fbWaPt+CWFvpqvBbONYPC4aZBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGYuIT0G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095F606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGYuIT0G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9AC1F01825;
	Wed, 28 Oct 2026 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182550;
	bh=CLCAvP9+w5zfkglm9iaLO1OLZyv3hAvsiFQ9aDMqzJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NGYuIT0G/L8OzJu21IkezVa9pRLWjJeMo1hhmdHdrlgQTLWP37SGqwchGN9/fiahq
	 WZIYyRPWppYvm6eGZ6VpCE1Rw+U1/QtcFQNSCqM0KKcpyPnCspB9xt8ucvi9UIZeqV
	 /3fkhSlL15b96gM1EEzYGU/SQGL8fXrFvuaVEskwzYfEu7HwxqG2rae6ieyFFvHjfn
	 kxCeT3mRazXeNV7HJB0KcttfzwPBM5bdgBZHAuDNlbGp6TVonnxm7T4gF5faV+HKv0
	 kHkittc//aj/7mLvq7Fwoh0AiDEvtTE2lsf59xDbHNlVbwjwY6BeNf6brbARZp9peC
	 iYoewMaWA8xgg==
Message-ID: <sashiko-outbox-187738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/16] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-4-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:15:49 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D3

