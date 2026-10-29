Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254461;
	b=M5Mkf+0LtqnwYLles7nCmwSOUm2jOeoeVVPf9K21zmh443bjXZGsIhQdyFCHw78a5bNJ
	 i3Mi7hVPzXIovXBOScGPSt59nqj4LXeIVrDOISoEUg6G0Np1J7M3VwbKjQmR5ekb1aH3C
	 QdOVmOp590d3+i3nqt21bYzbRvXICdiTnk/pAmeVC9JKcxPXKmawUzcJVO1RTnpmI+nGo
	 5KZ0lsQSPuol42/9vP0yPXSjJHHOBeZS53nmooSzp8GY5PspOPoM1YPtpKp6HtkYkvPUf
	 Xwv0xbPTHRR995ryCCa/ClJWYGSJJqBC3m1JwjyIOyiCE03Nt07ZdOn1svC9Q+gEYqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254461;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=udUA3gMATqx+/WThwLI282NMDj2N+yPNN0CkyzK1FNE=;
	b=Sjz5h58tduktZM3zzn0Kqv9AySBKRSrmvwwGwDO40KCLrn9Wio/+fjFlUFUcK9gd9qqC
	 XQNYZ8KKfiYbPR4SLphz7niTk6uYxBjuw8zsFnQ0BzZhqzRDNaKWkE9gUmwjAFnW1MoNW
	 Mr4ZAKNkNdtOV6Yi2itUFtL5rabmqaLoDUDXv/lSxmlmEMHz+UnOG36scpqkq/PR43+4k
	 ZJAwt8s1xHCLxp9LGbUaqu8uLRTBRRV04eJP4HPCBJk50lymwpEkzIis1I4Id6wdiFewu
	 2DTwyIdcSnglA3l7iR9TDiSo6w6aXHb2W64C0kEbXvs3yHkRph1PdCd4qIv/+A0+h/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M41lm7GV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59112606A31C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M41lm7GV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11211F01825;
	Thu, 29 Oct 2026 06:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793254460;
	bh=udUA3gMATqx+/WThwLI282NMDj2N+yPNN0CkyzK1FNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M41lm7GVgvTDW5Y3OmkEP2x+d8Fd5h5ICM537a7hb5mGzjBEswfWAudUe2XrD1/et
	 plmNzBUiMIqjyzXcu0V7tF6JO/JJOrrXX/VIlq9GoU1JV1LqnC3Lx/tbRfW5YLV9c/
	 h/DUO+OGaNU9mFL7xza0wtwVpNvV19Iby+4UOivC8Fo2NsM8HdGCpAlHnAU0MdSvm8
	 595vdmvhtG0RiqW8ogfXfuR4OWaOqRjzMq65hbiQ3psZnvLWWG7Z22G5roU4dBhHjP
	 kbU563AARompKmH7x9mUupMVdzLyeK4NuBuZjQ4nbXluekGAvklYwWOBcepBCREcUx
	 9Y68IxouC+DMA==
Message-ID: <sashiko-outbox-188799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/14] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-4-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:14:20 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D3

