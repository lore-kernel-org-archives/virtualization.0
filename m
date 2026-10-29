Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264976;
	b=kQyEy7k3D8kAwliMbfVClS0eFt1vsW9xR8tY+3nHvxqTgxTXbV5RkODMerK0Ar9qekfH
	 lw2q/Eh05YG3nYg2XotjYCySj5TrlcVZdkipugfc/M4xQcuuBIMQddGfnPsGBSJPIMOw5
	 ZPiseFiXht9o8R9EsVq08juLC0SO/zTCfdigAjCxduj6PqKG+LfBjzmkRo9Ae2HWvkgZs
	 p9a/cVXJ1cpOcG8AUd4mAD97UJFPCBkeBo7ejJs7pALmZqHaOgalVOhjbyVgCaomMJqfT
	 89GyrednjrNa8pwmDgtWfV/CkwaA/UPvZDZ+81oawlhKhYBwYhBcJWyrWsXmK83l7EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=75ZBONE6/etvWXLufPo+S8U/9u3wa5CTXw+sdIVlb7E=;
	b=U6VfKHzVO2h4hu9j86mF+GjLNXE6KUtXkrgE4NWP8U+6L/v2uDKTQ5r91SOPkPpaqSP3
	 1Xo6BIUCZ9Jau6p28BHjgL3SCfDTFYKiJuEK0Vqh4hHgMgRvcjAzv+OdEKZqkrXT3ut+o
	 43Y6c1X/aWqFas2ibXrVCT0GWqQcdI5f+LS4Yfi58x919+dibDXG1WECyagJ75pX8nE3b
	 i58DPuPstqp2hoF4hebKT67Sj6mawuVrhZClpRC+a7dTeYuOkpjVO/Z4s8a5mTr0miofx
	 6YHVB0AFfwuVnTRzHpzZKBzzuGk9hth9Sfa1e8qp8nk99h7bCI+F/isw8HHnpAqZ4gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eb7yCgU+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C7606A31C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eb7yCgU+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35921F01825;
	Thu, 29 Oct 2026 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793264976;
	bh=75ZBONE6/etvWXLufPo+S8U/9u3wa5CTXw+sdIVlb7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eb7yCgU+8dITnmG5k4wEffggJ50DKmQWd2stGLOP4SXOlRfQXWeVoxwDkTQVMJyM5
	 q8V1rLNF2jX+tadTWETJwZenCUlA6EWXqw2sNpf7u4bgjIou33RB1LaOVcYsPtNcbn
	 Xqj9yoMshvQJFEC2zHjCJQJmCCJ2ukg/hjDzaAjcHjpUcAkH52ctwiPYwlWLK/RN2n
	 7Mbx4KOorqAyAA7sPF95mXSObkHLqn74O9XDvIFWldSZItkfJ96ZvIkzXBLD0u4dNl
	 C2qbg7wPIFufnS4SFJ+q9CfnQTNmeYHaSapCbODxZzGmIBtz7lcgPzLAviWEgOpE58
	 0mB8HNMBnrjTg==
Message-ID: <sashiko-outbox-189003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/14] ALSA: virtio: synchronize staged capture
 accounting during RESET
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-14-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:09:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use the locked PCM reset operation for staged capture. Reclaim RX space
> at the same locked pointer observation used by the common reset and keep
> completions arriving after that observation. Rebase the notified-period
> counter there to avoid replaying old period notifications.
>=20
> After common pointer mutation, finish the matching core rebase even if
> refill fails. Latch XRUN and schedule notification. RESET can return zero
> before the asynchronous error is visible; userspace still needs ordinary
> XRUN recovery. A nonblocking read can initially return -EAGAIN and later
> -EPIPE. This avoids leaving core and driver positions partly rebased.
>=20
> A forced 90 ms RX interval reproduced -EPIPE with the earlier accounting.
> The corrected sequence matched the next 48,000 deterministic frames and
> passed reopen. Linked RESET and prepare partial-failure fixtures also
> passed with atomic and nonatomic stream locking.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D13

