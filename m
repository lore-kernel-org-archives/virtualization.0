Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372848;
	b=ehE4WBMgMt1itxK963mEJHQPzu8yGzK3bKXGO2oSH7MxTzSuyCVEmsILqYg2ufBNVglO
	 86pweKNf8IQ3RShP+p5S0l2wsvHHlOgyVept8sH8FsPJV6igRn7yJDjqI1GfciQYb5M6i
	 HbMNCAHD4ss/izyR3yUbIguA0nIef65UOL0Aqt8BcNz18XatqnFUo81PjGfOZHJQjYuJa
	 uG9/u4D64ih6VFASAFehs4ufWRmpKhamePenkUAR2a59xLduWCUmC/nAULDM6xV+ghHiS
	 2hzc28WEO7uIrOCkeCPy4ksZT94PngHC/A+Oe7VglydflRdFn4rjEKzckzps4rAZxGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372848;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oW7vz3hLplNQ/nfs/VOvfWqLPoTjLV9FSEiU2H/oEnQ=;
	b=deZqhMWisfaYhEmd3igccrrzRLs8eSaS0kgZwjPTp4PkFWV9dex0GWP2xB3JF7FSCb13
	 uCJhdlHoQM/3IZnoMIkD0j1FK8nukw4gvvR6/ymhNxNFT/B2ZHJqDRaNMQA8mmreJcPUT
	 QFmtrj0C3SwQs8ApYCLQptZM4PcvMMpkCmEpzJFJcU4T2aRFKgbQFopG7fd30yiVXAKSA
	 CbHghjBYNUL9J6HC81An6YeTuepo5SkLMaN67uO/NKfXLMBEH5V+qiJiQyKs1UlxQi9n6
	 6u5njFpv07i9Dgvslueb4Hj6z+uSrCyYfN9MFy7KDuF6ZDBEt7Qxd8LHdlHFTajf6yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqF0CjUa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577A606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqF0CjUa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF941F0089F;
	Wed, 11 Nov 2026 04:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372848;
	bh=oW7vz3hLplNQ/nfs/VOvfWqLPoTjLV9FSEiU2H/oEnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UqF0CjUaSS2Leke3HvXE3JJwCT1THTVwnSC3FA+tol7J/p4yFPudKQoEXxDgSMlzZ
	 /d6SK1mWCC6GrTRa75/8GpwYXswEF4bbaIfhZpwult7wlTDIa2TTOBdsXuD/4JkL/5
	 RNXEYGqCF1IjsY9AYERtj9ASRYrEkqgz2znAUBFo8enQCf59gNhjaFP8j9u1xI+4YI
	 IM5S3NtKyLvyIbfHkHJVHCgjIwTRkBRq3QEtTWjmQPYRzEqaufx0fzmoOyjK266jvO
	 LwHYAOwwnmXWcnQin3utelvvzepx7oHdi3+mBSVD3w83DboSGAQ38T4MhAbhXE2tcr
	 VMcAd0XKaNbIg==
Message-ID: <sashiko-outbox-208317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 07/16] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-8-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:54:07 +0000
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
> Latch a transfer XRUN in both playback and capture, and schedule the
> existing period worker so a running or draining core stream sees the
> pointer error. This also retires a failed playback START during drain,
> where drain-init can already have advanced the core state to DRAINING.
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
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D7

