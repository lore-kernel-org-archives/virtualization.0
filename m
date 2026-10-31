Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793414569;
	b=R3DixWEGjTfzZxA5JiAwlGvlLo4O4Zx9cM/hptBheO0bIoBP76WIpSi5969THIx3iZpq
	 1IrnLM2+b66yS/oJbJfDQL+aUJIMOna4QQ9LQNGAKdkt8QhCHXKvZ7pQh/e0RRB6cz1hk
	 mxQDN1uKaZPCXn+6pFXt7zZ7TFWfWYaSINucjX6/QkvSTs3Iuk5OGzJ6tlqsNA0KdLTAu
	 t8OVratXe0TKsBoc4pYyvMwYXcyYgER8RkYoXyEOP3QRXoF+PFQjgwMAZkoa1G9MHqnaa
	 6cfhWCNq3nSeMXW/RF3UR1ZsBpktzmp+pvqtVsdMVa9DGJM26RASidBROD7QaBAOwnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793414569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=baCOq91cROc2B6skxH5D5/iBrGJUeVBfpY89A9U787w=;
	b=mIGoZngdsrOL7D4m4yQE4tPKR3RmE6EGBxHK9VdkKRkPo5+8Id8SHW5TEH/EFMzGu3H4
	 pFZnyeqMEC8/7mAu3ec39mknOI/gZJQPFrNfGiN3b9S6E59bUalri2vE7ECggYQu6nfsa
	 TGMTkHAgjYm3T744r8VzTfLPzU4rnuqZjbn/Li2vOGIQzsDpuAo/Sy6tiCmWfBJ+tsR9Y
	 xvNqEerplo6lh34wZWbhuTgYsCoHJHtmaHxB8sTPXry8qdM6SVH5tzHvORWZfz/rvc37c
	 bxtw2sSlH29+Pno9TX9TKMpSQKQrothto3PoZ3CNxpKx5kJ7rxBZBP58wbiLOvuEhXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccy96Ydy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F5606A31A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccy96Ydy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA71F1F000C1;
	Sat, 31 Oct 2026 02:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793414569;
	bh=baCOq91cROc2B6skxH5D5/iBrGJUeVBfpY89A9U787w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ccy96Ydy3z2h+CwxctK9k35cA7Ib31W2y7CHDUZN1AuztCSJi15TKWS0RVp/+xhKe
	 jydXwBvx49CAXxrQf7ifTbNYYIILPzds8YdddrSPcdQjHm/xX0MUfyTd132fKKYkgC
	 MdIxxj3ZU7+4lwfVeTJIIvN7QDr0aG/8xHN6K0+Xccv9vD38XHVcg2kfG0C2QaUstO
	 O8gWnaUVgoRc/Wn8FIgBKPGsPTsXae5O1PbC76Z5TEwwGMAjvbtqZkiRJNQPZr7Tiu
	 hjzTQLzb8ICVPmUYq75CoooJ/xadQK7Zet0TTBcd5dZTrd/lj7ZckB4Y+Q9grBJkX/
	 1wXLiafp9d9dw==
Message-ID: <sashiko-outbox-191716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/14] ALSA: virtio: synchronize staged capture
 accounting during RESET
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-14-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:42:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D13

