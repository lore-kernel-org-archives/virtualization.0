Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453953;
	b=t/AitLkye+ifkU9SXy3FgaR4PyAYPe3osLq9f8RCJy/z26sqkkfTzG2Wd8pNgdMJzC4z
	 8kq74C2OBRoE1UlYogdKSEEvnKvWJzuKYgU1ik8NtVx4nMf3G15dSg9chh15YM17k5aoE
	 36RkAXRXqadCwezzdLoylX0Kw7CHEPRk14DVGXWBp86COVFU5KNUjCwQDobs6+LT/BXiJ
	 1C96nUNgZCKbZlUhMiz6p0yY/SI+z/pOoSgZce/x74IGsubjss+fsF65a/RL5h7pSgTro
	 0uTn50S8tKTlwxGDY8yHFMiliF1TuLTpWy/ZdgDho1Q4+nvY1UbrH8ZBihWmoQS/vFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453953;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f1i8X5g4mwidTk3xEgmJvMUnUQV1nsQE3WZfUSFWBPQ=;
	b=RnRuy4SNjuWWpEme17a3GI0s9Kn/a8HRs4JJE52HIUj/P11tuwSQc50YpnobPPeMVAb9
	 0qiSl4reaWlGlfzgTe+WotnrFLOnVjOBgi+OEtA3yqtOqJQC+fcc5vYODC4P6Rdp79ftO
	 T1suZuZ9ak2XNrIr2uMLW8KtK5YfXngT/rjre4mI2O7sLcDMPaVCXxCCYm2wjxflntPdx
	 HrFb3EmF5/XeLdUy6JFw1IjCZRcDB3bbSruy3otUh4Pr9b0+wluBLS4xidqDdq+Y5mY52
	 LsxVTTuVFXmVCBG+SgfeyYcfSJBPVPV/zymIMVrDLVIl1a1eZMw5kSE7OPALwaoU0eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idY287ck;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E8606A331
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idY287ck
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11511F00A08;
	Thu, 12 Nov 2026 03:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453952;
	bh=f1i8X5g4mwidTk3xEgmJvMUnUQV1nsQE3WZfUSFWBPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idY287ck3r8O3M/IicH9zB+cg9PfkMyyz8sYNkc0/OCMfTD9gDoVgM/aptHXDt5AC
	 O2E9PqBSxs3NW1h9UaSj64dcdp1g8uET3Yk7F8c0osYwjD+k+vO+FMBn7mBKRyfSJJ
	 zdIRnX8wlkBSnSLVsOgwqZ5AwvwFNLIW1nnDp9mmAIvuE0qtYWIPo146DDfnzKFr4n
	 +cWPp9B411eMAhjHjO9VxBqjJ0jTrHKLVM4UR8IFb38SJV+OnYrq8vH2aC2kGxOsxq
	 x2g6VLyyWBOMWy7Tk2umkJZjecMpBtztn4rndpYifG1mUPSTynBqJaD0JWEAeJnK5T
	 ddypXZJ88y+dQ==
Message-ID: <sashiko-outbox-210273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 17/17] ALSA: virtio: preserve playback progress
 across pause and buffer access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-18-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-18-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:25:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> TX completions can arrive after PAUSE closes transfer admission.
> Preserve that progress and schedule catch-up when the stream resumes or
> a rejected pause restores RUNNING. Cache device latency in stream-owned
> state so a late completion does not need to dereference the ALSA
> runtime. Clear both the cache and runtime delay on prepare and before
> RESET observes the hardware pointer.
>=20
> A playback pointer callback can also invoke ACK while the core has
> closed buffer-access admission, after the pointer helper has already
> accounted for completed hardware bytes. Track that callback context and
> refill only previously committed data using pcm_indirect.appl_ptr. Keep
> rejecting other ACKs while the gate is closed, and use the
> explicit-pointer helper from patch 16 for the refill. If
> runtime->control is absent, route the condition through the common
> playback validator and XRUN error path rather than returning before
> [ ... ]
> audio were not tested. The tree through patch 15 was inspected but was
> not run as a separate control. Full-series runtime is not claimed here.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D17

