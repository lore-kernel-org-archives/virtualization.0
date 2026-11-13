Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562573;
	b=K+f41TZwot+ihSDWEEOvXKgVNCZmIWuT+w0YoSN53eyLwNK5jsJOryZeIrp7CxMtM6/Q
	 ddxViTa4Wl+CWxWxA+bMfNAWLRFLUtabvhzpX1BPARhMOn714cIVNrDi2tE1iPp0ulCLd
	 l5rrww7EAVD0+SF9YfFsmoWe2y82Mmi2hNpiJucZ+/JBgXJ1R6xLXufjsUyZ/I+4xMpkT
	 uBmEENgsyB8P5xdGiHr6x7KNVLw4ZjgyxioqBau63/DtsHHic3JwxI4juH4PfRIZg3nDI
	 rN4A6UBw953bK4wqur/4cZP9g1vjUwHti8K/FTtTe00atAF9BcsaM4IJ9aRKQtmmBcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2WkNkLqkHwqqM8xCNbDBBKZRVBf2OW35xtPNRT9vntE=;
	b=GMiqV/1ZYXrnltDxyYHJrxWQXOKAM2ArnW9dAjPM0iytUSXGZOVT7MNRcwqh5gp2lAv0
	 aP9rcQ9btZYNogtMFo9cTmGG0P7T4pLu8DJcEZorjkTT/aW42xdEneI6OtIPVyku/nNT0
	 DaXx8SPnouR3IjYNd2tdwUKWb5HyDuxpuD8ebcMda75SpCFb+qcWrz+courwufsSB5zPj
	 e0IqOi2pM5GWjLESUfgxB486mbMh9djleMrU6wUOQF8q2RarnBa5TGsFW7okICUqjD2Rb
	 COEkAXkTgMYI6NShCPNCzyUgN0+/LQJPJkh3rON/Mf+NZlQzhuL/1JYhVrok5UBSvuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kXrR/yWR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E3606A321
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXrR/yWR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F191F000C4;
	Fri, 13 Nov 2026 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562573;
	bh=2WkNkLqkHwqqM8xCNbDBBKZRVBf2OW35xtPNRT9vntE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXrR/yWRl9wJej+GMTuIPIXp42aUOSqZ47lFyC6dHDGSUgP7CdGzZpmWlFt2YZP4x
	 xzpL6WhpQ9khm3SFFFdhILjm0VbH4DTWB4CXTDQdA1MupVb770GaHvA1S4rWsoHJQW
	 5PhSlPBmvjEQVkaWiDOSzYHBF5s6uaENnxLIv8Gpt5XAEkLjqgsSS970UFekp7+YKr
	 HtfGgXmwCRdvxtj3UxulAtZaukVFFbCQ9096IfLjtCOLhqgSW4ysSUSJ1AIOcjg+c+
	 wTzyFozMhAh88O+bVcqMrYGG8DQsRN3+MGdOPRsFBhuo5BgsAvatlbXsMXqNwyy96M
	 Aa6pitYec9pqg==
Message-ID: <sashiko-outbox-212556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 04/18] ALSA: pcm: notify drivers after linked
 prepare completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-4-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-4-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:36:12 +0000
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
> A linked prepare can finish one member before another member's driver
> prepare or reset fails. Drivers that admit transfers after their own
> prepare callback can then accept an ACK while the group action is still
> incomplete.
>=20
> Add an optional prepare_complete callback. After all sleeping prepare
> and reset actions have succeeded, take the group and member PCM locks,
> publish every PREPARED state, and notify opted-in drivers before
> releasing those locks. Keep the buffer locks and access gates held
> throughout the operation. A concurrent DROP observes the group before or
> after this commit point.
>=20
> On a driver error, notify only the attempted prefix, including the
> [ ... ]
> pointer rebasing. The new callback runs with the group and member locks
> held and must neither sleep nor acquire another PCM stream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D4

