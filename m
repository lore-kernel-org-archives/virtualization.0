Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925018;
	b=cTJ88MGdAglJGN0+rL2e4RBfKYOW/9t5ZFK7b4HCofpnqvMbVGDuE7NRy1O2dgY5vfb8
	 SlXt9KJU8UfRR2D9isVoK3gyIqcfwtLWStZv61BqPLeDggGOmvBlW7X9CPaofqCJzC9yu
	 wTrEHaEF5vblooKdpcyJYD6ab7XmrGkk8tXtOEXwJo/yQnzRE66xNhGgFfHR/tEWVhJJL
	 Vuf6j8/NAwHRZ6XiDR06m8p5CHYJb74UXLMtHVV+BwhAbWfxwl+53xdhnvY4d2TgzalIl
	 HFBjTSzdK91Ahih1zM77eHkxTlfQnP26G1tUHGqc07KdrUMo0L0C2abUgQvcHh+Qwtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925018;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=adhctAVukFmNPxFBpDmiW8LHaIubMYXLEKoj/H6RB84=;
	b=ls9lCFA7tfxdJHomb/KsrvDxojMS6FSXEJ2SQtJgf9DuBKg8El1v1Yy8R+IQvaiAlBQh
	 xzQUrB3LjjbyExwOjB8E8EDfc5MHlKpFdcc+AItGwXJ251vIdB0kPqR81P4NyHAXgcgQy
	 bSbDMIROXngFnAQmBx4sKUki9gmFih5f4uvLxdbpJ+0tZjDCwS0h++wh97uGo1IIW7NY8
	 k5U3bPc9J6o/Mjap8pD2hOUtCxmahoHGFNrUACOvd7j6hQ6B58D9uPulPLc7YsuIHqNx2
	 svaN1C4Q/W3tXd8b4jffOJz08eReQombeAXylet+877oNqXVPCOoJyqHriOz6qTW9gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1rc8fIA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A55606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1rc8fIA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E531F0089F;
	Fri,  6 Nov 2026 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925017;
	bh=adhctAVukFmNPxFBpDmiW8LHaIubMYXLEKoj/H6RB84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U1rc8fIAMSoTM7G+AZ1qA3xE6nm2O/BT9UYKBfVan+02PeTGClrU/qFaTtBso6a9H
	 FfUyaRjts5rNOSKjNRTyvk4RvwDZVYdTz8wLY3CA40d8dFmPxwXY+cFJ7sOvBhymKB
	 yOx5FjAxyrln2etuzlO7lICciPxbkVTN3EbHg98QZ5Rh41Q9APSxIuSHUnsj6EwTp9
	 /oN0mpfl9SA4dixXkomHLDDSc/TDpG1YkNi4DRvh3YWNDspIpnjuQWyUYyUi75SGsm
	 j7RD8xeqEelUC6lYYRXSYpmtMeud/bQdApBbBh5joUA3WAURTr/uJw0v/r5K60uaJM
	 XY9XMF4gd4mnA==
Message-ID: <sashiko-outbox-200448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 10/12] ALSA: virtio: serialize staged capture
 lifecycle and defer paused XRUNs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-11-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:30:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use request-owned RX storage and separate produced, observed and
> consumed positions for shared capture clients. Serialize lifecycle
> operations with lifecycle_lock and ACK accounting with the PCM stream
> lock.
>=20
> Close ACK admission before any sleeping teardown and keep prepare's gate
> through the core pointer reset. Reject unavailable epochs with -EBADFD.
> Real transfer XRUNs arm stop_operating in ACK and pause/restart
> triggers, so DROP and prepare retire the remaining device state.
>=20
> Track RELEASE completion and rearm release_required immediately after a
> successful resume PREPARE. Publish the resumed prepared state before RX
> submission because a device can complete RX before the START response.
> Record suspend state even when the stopped stream has no queued
> messages.
> [ ... ]
> access. DRAINING state alone does not authorize access after prepared
> has been cleared; retain the explicit PAUSED/RELEASED exception.
>=20
> Restore full-ring occupancy after active RESET requeues discarded RX requ=
ests, including native paused RESET. Keep linked XRUNs latched while PAUSED=
; publish them after successful resume so the ordinary pointer path stops t=
he running group.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D10

