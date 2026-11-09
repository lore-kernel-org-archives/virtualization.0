Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182495;
	b=wPMzSUIpHuuMifOC20aYfaZD6RrnURipnL6NdXgAOEXV326mm1dwEaTAs9YyhxOR8Ly5
	 a7Lr6kyEbC3WxniWY718wMaHLNrWnNu9m8v9Vddrtn3TAGSiP1o9Ff/hgxyjesGm4oTg4
	 m746ZN3fnok5RCG1n6PolUG9eVJVNfMJ0q6z+QSp10aIFclBSC4egibmlIrtzrk0l8eKd
	 bK6MBqkKtAna3/4geDoFpvAvJ9++5oTzEqd7yMfbI8TgwwEjYMi90AwfAJ+jqgBxOGhBu
	 7JW1VnwRZXl78yvkSoYoWEEN8zN/MxvBSXvp+Rq98SAwjGdk6pZpZHJLA9GwY7n7J1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182495;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LflWX7RzYagsWlpcxIwDGN8ECP1KFKxVUeU8hNooLVQ=;
	b=XKJkPchEkqIc2aEZtECwWJKFZ2aXO0EBjbZmyRZS6yH1lAlx0B9ENnUpBFFwjXi3p6hP
	 EZRW4DCpfw1ScXmL4Ar2zfuKcpe34q+5grJ0jnoHIgusfo8HzSFYjPGoYlD5o4TlFJL8B
	 Kt5LcGwPkNZlO1GQuTHC4HEUcG2UKygAgFtGMcI9mYnZGHfCnQUwk7l7Wp1bK9kKBq/GU
	 ZZnuzg8dCTU/rsMzqLrLwDl2PbTKGyTlF0n8InISZtI+7OraW3XbhZQX2gJGRxKIofNSx
	 ezkXxF+PVc/YvI2AIrTq4detASDCYnZbnv/aYCX/1V6T/SXZvEHj/WZ2bLIPVjx3K5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPMgImJD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E01606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPMgImJD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6C51F0089F;
	Mon,  9 Nov 2026 00:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794182495;
	bh=LflWX7RzYagsWlpcxIwDGN8ECP1KFKxVUeU8hNooLVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FPMgImJDz6OolDb6uhpfAWcYDXF3k5zlh9p+W6amGqqxAtXp4f/MK9rq0ZNskPVdP
	 4T2maO3m18msnzCldk9YuV4YPEuMrmyLrYclofO6At2lHwP2Ge4zdJ7oHObZ9pRG2d
	 1j0OE/78EPKCf7wTxnsrtfo7sRajRsGy54Gf5N/N3QlLpVfcQMEQBfYFSGubsY3zJ1
	 g/c4UfRpLDP19F7LDgYGr0D6s8SdusZbLA5vuXqtlN90E6HZBMj5e/6GhLjNX2tIgv
	 yY5drZXSXQ8I8v4P9yzAPn4so6nh2Xxu5G6KiOcp+dq1hoeKLqA5mQ//qKLh4pKN+E
	 xVixqW217JmjA==
Message-ID: <sashiko-outbox-204182@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 01/12] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-2-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:01:34 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in patch 9.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D1

