Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699361;
	b=qvPSgUT5TAXAzw7bjChKXOvPfi+9kIH8kukAIVkpUbEUp+cUx1UDMf1iYat8ikhWOiLv
	 wul2l4KZSXVZV5CbliPei2kHd26xjnqHiZ3bEXN0YPj8CGiAqG+/3AHgzUdjxBdwA2a3/
	 VCQmD6aGp3uirYaXIy7TBQ+nx5TBk31yZfNq0fkXVk9PHexMMQNiqitBfTIRdR7+Pbf9z
	 abmDrqGQqRkwxXEEt9qcJfcAURm2R9gMH2HcFCWL+2VAZcNYgfouxknlcbD6KehnLn7zC
	 ndmF73hCmco2IYmpVuOeVpurI52ZROziUZ7DAj4QpzmKKBHC1AC37qDQGWEQnDfUm3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vU11Z9T4c+zNxvm7Ax9rfkIO1dhh8KK8bdA0G7g+JNQ=;
	b=x9VGvB3GCqXSu9VQC9oQBhYM4mmvr7KECCyhuQcVr9at875wlKPf+xg7/CwSJL+8GzsQ
	 RXTXg0fmHKO4lgHXIFiXAD72NWFZ+hN59UZ87bX2S4pju23SzvXxIXIHKoCYx1EhQaEiY
	 TrJlKhKRWEGX3R6O9rQMHNbOKVQK7F8ruf4EWV7CQuq2no9mHd1npmcnHEVnFTH1yCJfK
	 IPSwexo8YlUmIFgWozgRyGzn2kiCrkmIBM8Q2eW52T3QXPhQpzwn2/gQRQM7hLYrzl16l
	 0i5YNnAteCzZN6MMI4ul+xIxAa4TGE2peuSSIFlOJr2W+ptgSSShc10ak47/cAX+JTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5SwgdWi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF2606A335
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5SwgdWi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E161F000C1;
	Tue,  3 Nov 2026 09:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699360;
	bh=vU11Z9T4c+zNxvm7Ax9rfkIO1dhh8KK8bdA0G7g+JNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b5SwgdWivQvyJ95SlXlc91DM5s4prWKVEktPU+GRwD84NLp7O+h7koCAssEY+6ZIs
	 YZtkgAIa0nSfqGIjxV0P33gsefy7JyyXNlqUsP1FPgBJ0JrEhdU0vkW3A/CPqG3wNN
	 j6gu4WCLzh96HP4NeNrl+FsmTpuF1/6OzSMnUSPE8TDL+3hl/Btz1II0bPIwc4v7tx
	 f1nyqxnHCQoJnW70iPlazvuIbQfr5VFfWsPg/serOBe2w+l16IJDRlAgRDT1Dt4lFo
	 bbpPNHymgKTUJWMNzA907ruvdDS73aMSexsYPc492AtzuojgS+2n/oyz2yKoypV25z
	 ZYoNPL7LEIbmg==
Message-ID: <sashiko-outbox-194969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/12] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-5-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:49:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Retain references to the pages backing ALSA's vmalloc buffer until its
> queued I/O messages are freed. On NOMMU systems, use driver-owned memory
> for DMA and copy playback data before submission and capture data after
> completion, so ALSA buffer release cannot invalidate an active request.
>=20
> Validate the PCM buffer and each period before building scatterlists.
> Clamp device-reported capture lengths to the message capacity before
> advancing the hardware pointer, preventing an oversized completion from
> accounting bytes beyond the buffer actually submitted.
>=20
> Require whole-byte periods whose total matches the negotiated buffer.
> Check offset, length and the final message index before indexing the
> message array, including empty transfers and arithmetic wraparound.
>=20
> Seed the ordinary capture ring once per prepare. Native STOP preserves
> queued requests and unread samples, so PAUSE_RELEASE must retain their
> ownership. Re-enqueuing the entire ring adds another period to pending
> message lengths and exposes unread DMA slots to the device. Return
> consumed space through the existing indirect ACK path.
>=20
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D4

