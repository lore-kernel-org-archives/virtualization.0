Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553293;
	b=fh2gPm2MP4zy5JWdwWdtX/XCr4HFoI/q0w4r6//kKohd9CbN6OSNuvr+VSnxQd7/jeyk
	 VFBlUpcKqE62eJo/4yw9txa07QnizvbP1qmulyceVYWh4MVKffzxFSvW9IL3aFhGwdme+
	 9vSsGaILDbte8kTw/lGMsk/WTYtRGKP7+3Jl8LjO5gXOJoVvafebjTc4/5TrQJKlMrNWV
	 mPjlUbpqkDFpdvXXDQJGfxgkhmC/hr+iOKIs9OLgaRNU31p9f2lprwtlSMkV9XiwBhqFT
	 mxZCrP0qXzHl37S57rcqSwKceoxbRCSOPfXTU5LHvsVNqyMQSJDZDXkimVGsIj+ByJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553293;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+lnP96FbbqSkx9pQegbvvI1PQEBhv951LUxRZyXldN0=;
	b=M36zrEgAGsW85iQpagBXfnMyjt0PxODo97lsua1e7G/qaLuph4uR00g+xoA8+4alRD4D
	 4Vdcl25aDkWi8siyoiLfy0TyYF6RaBWOJJPrHsv2X92zruK849MT/Dzc0IsxxPA6t/PZV
	 bQ77yGm0cxqjiywbe3Mqy903ymQL5Jnd19VWzaTFjL6PkXFkfApwdDG1bHhGg48Ea2/sx
	 IYeKu0SdqdeMbzDb6w+bSITFsjBT6d6hrOQf6zn9Ic3hkaC+63/3cSNV2IlndthNo4KCD
	 HInI4eyQimbi1V5E+eAo+6tKf4jzr8oe73zknBh7kV1QQjJ5tDUTzcGyMqeDk6z/OgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEvdoQil;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3A606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEvdoQil
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68591F000C4;
	Fri, 13 Nov 2026 07:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553292;
	bh=+lnP96FbbqSkx9pQegbvvI1PQEBhv951LUxRZyXldN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JEvdoQilfFxxxTRo00KoZ1xssd4kwQkPlXTTSfsfZxZi/STAOKcgA4Bo+vqXSeF9h
	 AXXmgrFWqFIfeJt9ANip9iAdbcyFGYWM4tx5+3PyjZzxgk7E2v0LZO2o/7qJC4BV1n
	 fByRqnPZTPFJ0YLPxUlVSqUyqy6p1VvQ70BezBqwxaRSOyMafQWqXdSZhjlPmcEpAh
	 7HvgYRzwlP8KZxnu7NqJDRtr1nLcDurmEwho8m59XOWQISYfd08pW8Ecie7SPsUa07
	 Ia84eXlYMZyySKQV+HYeXcwLD+9Cd6UFzBEXXoMiSxX7c6khl+ZGe2D+1ArYaZ125A
	 0gpKQcEYehDPA==
Message-ID: <sashiko-outbox-212307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 08/20] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-8-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-8-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:01:32 +0000
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
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D8

