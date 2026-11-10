Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268975;
	b=CMLgISMLCU2xr75LK2ynb3vdQ9KvjWtQB9aUqw/XnPFgz/IUhDXi1yCsIc3bitOVqyG6
	 9bgYBGap3hFozJJvGVUnYv/Ra+RPWJ/N+XjrENPq8CmNT9t8EvxgMNhUih5Fdw1paFjud
	 hw4j4a3q5rNzI0rrq4V/RIwZUldn8euyUAuV/qQf1/yItkeb73l42NP5P7dn3SZwprzJQ
	 syKIbk/FMMl6FfS7ipSZRc4SKEFBinx+N7c/7kdQp4u3sewg1MFnblh/R83fxQ0PImotY
	 LNyx+eF/muK1N55+TK0zPAPJJM2dD4GRYDcwVuj8FJCiVvzMwD6/gWnojMWBAgYn00A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268975;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dEFKDy9qIn7gTmf2U4sc1RcmonLd/2IPHHDLfnCZFZ8=;
	b=ZXdvEoayrwwqU864fB47IARwIVh3zbi9Qc21v6jOenU8GKxbjiZAZxEum9UZT54wCSKj
	 zi7+4EbpyDB+zWI8l5REpfmdSWXWElfLDk5oVeae9VFjg29FQzUOQTx+VwyqeirrOiiGW
	 GnWM1MkAAWe17a7o5pxeGQun6rYmUWGAb8Qz5w8O/lqtSI0iOMPrxhVv+XDy4QfoCpqPw
	 hBtrvjnmDZHwJChke3SkXq+GCUIHsWJNowiQKxE4TpiHJmCMYevntYzgtujm8oDlBK+z9
	 ufVhB1xjvUsz3cTrxqxEpBtTIdtZONc3ZjBh+JD8eYWEDf/BbkKBydzxnywezQwbyhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQ90Er30;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E988606A338
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQ90Er30
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E5E1F00903;
	Tue, 10 Nov 2026 00:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268975;
	bh=dEFKDy9qIn7gTmf2U4sc1RcmonLd/2IPHHDLfnCZFZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VQ90Er30IerCYTGeqQV1haAe9tWar1UdpQkPkr+IK3rwt/u3FCUt7PHa5Y3Cul2Ef
	 RDLLxVzrCWJttXs/lL+T16kSmrXnQgA/tJxhG9pz2kxD//VFxuvUqRqhmvLdiUAaYJ
	 SAMJoFIJRZcwqTXOWL5F5pLpHxlboat5bHnNV8rnUrwr/ddDtQ1Dt2iOniYurNi9Yn
	 bzwSdiRgnoL2A4+0y9dZAjfcnlUHVLTI90QDFCBXQbrArkTPiI/kemVoavhFJOsMfl
	 PdaL5kpdm43cmUV7NDllR/jeDHMYq1LsHIhxLzm1I/eUupjZ59VYblehjEN1IavwDQ
	 PuNx0LTMkpgiA==
Message-ID: <sashiko-outbox-205806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 08/14] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-9-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:02:54 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D8

