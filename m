Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063230;
	b=D3D/XBW10Vhqt1MWMM3mrPcKDSJGVmpYH6yjXGeCJA/C3wJwTzFC5hMtX53GdAMqFYGS
	 z126xhcGZaUbrmX7WHkuGngJ9wnkvXjE8/Q5o4LcSQ3j0Zhu3/tygAqlnngm1QBxBt6mg
	 xtjml1ezzzeD5hauQAj9NcUZac2qT5/wxOcX1jIwmsuZjko5RINw5eh1ikG3xFyjXaPjv
	 uHD8LHYAVg0JKqtHuBnUAFMROrhzA4enHcBiztUCkcXZDUCNWyFXuNXsVoGwek8ZzpQLx
	 e6ebEFmlxCGDSo7oMHbC7Wt4g8/dCLBGp5u5DSTizMSqlfsrpRwaj2YCgUI55ptKiog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063230;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vpT0RQW8kUXG6sJkqhA7X+B5xJTtiPSiSjNE2nrxkTg=;
	b=QzXyJ85EItexGeD09kgrd+gPvST9984BxIg4eFhxXDPiIIBGTSm/2KG3lKJ69aDEdX7s
	 h1Hz8xO5WDv5T+EoFQ1YxHhyDSJAGwGXsAKNXlqddYkMA8bEbfmi71Wf8G/UYSCZQDTkb
	 6MMx9ao48bEBmJkD1GuU7jd6r4kTSxaCEPkug1VYiEjyQaNKPUxhURMzy7chDh0YDPPP/
	 tlJ3Ca3LZSOPhxX98be0JjJ/3FGoFspX1t4E+Aryd8UqwWRdXYHP/ljNcN3cy7BHv6tQG
	 ZpdMInXM+dasEauISHv87bxD45SDCFGUdUqkL562HleE7XN4bxk61v6afXNTDwIPigQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZvwYQRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEA606D82D
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZvwYQRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800961F008A1;
	Sat,  7 Nov 2026 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063229;
	bh=vpT0RQW8kUXG6sJkqhA7X+B5xJTtiPSiSjNE2nrxkTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HZvwYQRYClo35FAPs1iUKyGP1CLMUIcn+vb1PyWR2Q5Te/cyZf2MAhsoLqljT3Ole
	 DiOUdTWLPyemTnmGBa5z9RnOjT2+egH2u2lkJx/XrlRmLC+em19PTLl8Lv8f5GKjsv
	 4kOpxjkoSIf4jldHu2KORW7bKsC51FvRni86wA0Vk+c4uSuF9IeSvLgAe9QDyxx6tV
	 /DtEoInbxnnMK/QGJ7cZwBT7fGXro88sSknKezaATDoilMLecUQEVTjfZZJGY37qjd
	 vOfTnxtWe0PrGIVemJtGP1Hpx9RuIpAOnFLElAWPB2RbLwRytjiuREvFBOo4erhXTh
	 B+lVHvOxoqKYA==
Message-ID: <sashiko-outbox-202973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 06/12] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-7-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:53:49 +0000
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
> Track successful virtqueue initialization so teardown and failed restore =
cleanup call del_vqs() only for an initialized queue set.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D6

