Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182686;
	b=N+ciSsaI/S3OqI6dkts6aFI6xbtDsQWxj5u1jxrDz9OakfdTykQN5/4Z47JoJPnAwlhe
	 GT7h2JFIs3D2LPmZ68Ezpcd4OmIY9aNhuvtv25YwbQW2qFD06Q6zCLHiVBJIOaRvR9X9b
	 o6R6EdFUb+qdpbx0TkLC19v4ZCmGXJiMrQcF9Soa6JowyiNPvRUsss9PUDRr9NOkYsbTJ
	 uFT9bvv6bidQOR05KYEDPOlBQY255Hi+1AwavP010ra7uv1wpvU13HnP/3iQBW7vteSfg
	 8uupzBIhtwzhMl7cH3vvDs7O2DDKcAZhRqBwe0jRLwxvlGXN+nBR3E+KEpSmHACVwPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182686;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qbVcQA6OMihZ1/KHH/GgokJy/XWP6syC1wcVXAsbmS4=;
	b=ZFhxIP9cMPqyZuG0tL2AkeFF+7L/Ic4S4wGP/oyKxuoPildjxDjO96akMv6ZzrP4odZc
	 ILx4p0DF+FcJs5FgKHOW1dhurHb5lgxHSlqnQ8AGX5LgtkfcRyvAAfOpi8PKgKNDxxzTS
	 CFbYlcxw18EMeme5tcUb4TY5C6yUFkZAGuoDkhy5LbmeGj4mqGsaoZcvPW1x0HyiSsHE+
	 eUUKaQxlo8Zi3cmsbBTrGFJYXifizJIfSIHccBMJSY+c8Adu4c9NAZlfKexO3jGdU5tHS
	 JZEYC/aEahcT1lxl5S6ULJQmyoMFn/lDF6KrJk6SsWb5OYEeeSsilS2QKHKtCcop6NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNJQBRCK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279FD606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNJQBRCK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F891F01825;
	Wed, 28 Oct 2026 10:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182686;
	bh=qbVcQA6OMihZ1/KHH/GgokJy/XWP6syC1wcVXAsbmS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNJQBRCKckKFWe8rn1Q5Pl34oNyPBYA4mpPk2XdWzk5dXp3lhPYqd5LDltZPUx4ze
	 N6AK+T6PW54bwQTFOYgo0Egw+8eKVt0dFRYg5vuw402aShpIL4dvyy875PEG9W3Z9f
	 YaQlFAitVkbpWORhbgr3A+Z1vgetpkvU0zhyton65qj01VINPiHgYt8B/Uz1+X59Q4
	 riSy1bgZ1R2ijV0nZAQYRnQ9NLYIoa2CFhyrxOXmCe5suRtQ/pNznKzkpeNrQ3ZAJf
	 UMihMeDd0rFCdRLCqgA4qkS8Jfyvs/fQrmRICv5SYJ+qMwWeVbW8BGu0DfsBg5zNjo
	 rRFZliUKPCxag==
Message-ID: <sashiko-outbox-187740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/16] ALSA: virtio: Recover PCM state after a failed
 start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-3-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:18:05 +0000
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
> in one locked transition; leave it stopped when release or draining fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE
> is needed.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D2

