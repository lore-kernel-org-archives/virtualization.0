Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793924781;
	b=Rwfk8LpuU3u7DwLq6s9xJpYvXcTSsw8pq0TE5iBgcV8ZIZHa/erMnjCuB426LKn1pQHX
	 BbmhQUCqqek+OTujL5ULTm88CPCWRDjF/A0iG0WRXFzyFvOhb7xq2DS/Jlf3gyL2Q03ng
	 W1L2wy3TJ4l71G068Ka+3lecvCtPt46gnrQJlSkDy8WATnJQVVqR59eYuMw/zyi5c7/Sh
	 tED8WbdZD3C8Pqj39tzNx7F9I++o1tBZFWfNng+wdLeGTZZMEJ6IRiOydmeasiMmZ7lQ1
	 qkqhcWZ7NFvkLJN/cisMkd1nGmA4O+aXpWPr8taVDC0YSwIu7ZhIqyZ0/w7B773Ukrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QTL/1WZvuku6Pj4J6OfJSwUhVKtTC1YKhnpa8c94LoE=;
	b=doTL/LMhfu1cZVsfTHSghe7TJTf9Zw7K8EOT0gyC4EtzkSkGAnzj4R2D/+2sIWfHyfVz
	 L82Fd4xNj9dWMpLryLIL9JcQGPOeMDvcdUFhXgW3EkAcWC1BatjpPU3ROSVSBkpI95Nlg
	 SXrKaXDSUQjmmlDCu5EU7zeyiiMqDgMBaPZZGnl5iL58ApdrjD4WwssmtMyu2k6n8Boj0
	 9IE6zrCt/YGuQoWdPOqr2TohWUyCX4qjLGVpFw6tdGSDZbRx/ZKmlsfW3FDLtKaxF0XxZ
	 yF6MnmSENinOYbS2/A3hmIJLhJwTB7eD8W6p4ezdp9j1J/dSo8LNzypiT4YBlayYNzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQleZIQs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F46606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQleZIQs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C2B1F0089F;
	Fri,  6 Nov 2026 00:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793924780;
	bh=QTL/1WZvuku6Pj4J6OfJSwUhVKtTC1YKhnpa8c94LoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eQleZIQsdcHpcVRoptF83oL0rSYkAOQA4maZKOS5N6jpemTOR/ZGfw1TAqe8NrXsQ
	 Sx1y5cihCjbLvK9Xy11FyEpDEyzCppqmCGpj0OqivlznWlQTwtTGL+uVDxI8oM3Yb2
	 iBZfeUWbXxwmsGVhN2zwZajFCqYY96IBsB4Q2YE2n9M2Dmq6FeA7D+fr3wGEgspkAL
	 HLt0/wFCEfVWm2+f004ddN+AbLfMxBuN9h+k3VTfnPWux2cO8GCCxSgHmO3MVAhALO
	 238KFEhHtKm0UOuChv84V+VrvhvnFxd/kx3EiHnqjfZJG6QsdXjFjN7ZfQj0R0ZcyP
	 rXeIYgxtwflDg==
Message-ID: <sashiko-outbox-200446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 05/12] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-6-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:26:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Capture trigger queues I/O messages before PCM_START. If the START
> message cannot be allocated or sent, transfers may remain queued, and
> ALSA does not invoke the action undo callback for the failed trigger.
>=20
> Mark the stream stopped and disable transfers for every failed START
> path. Arm runtime->stop_operating so sync_stop releases pending I/O and
> prevents prepare, hw_params, or START retries until release succeeds.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining
> fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE is
> needed.
>=20
> Record the RELEASE obligation after successful PREPARE and clear it as
> soon as RELEASE succeeds. If the subsequent RX wait fails, retry that
> wait without submitting RELEASE again.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D5

