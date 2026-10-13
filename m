Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8D38E5DF
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878072; cv=none; b=bo5fIN1glVawIgwNFX9cvrL8d4GUnNHALOqgpucIohC1A9kbGqbthzinCSTh8A7SV/OkOZCk0Hnb1+lxGmebAsdY1IJ+l0y3qG7nhXMmJtpgHGqqIylX3V4W0SV4U/nYHBMhEOS5wTVqtmXkXXgXVUcyBLWyXJ1NqjoWR7piRmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878072; c=relaxed/simple;
	bh=DH39QZk8fcV0wrLH5rudNL6xm3sKpIbifIJbG37Ue4c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eH9zC1YjIsQQKt/dE9mzSYGtE0222b4ALaBo0bMf8UKtzBepZrN84hFjxDi2WklaDsVF+RahfckhtEsEVMQZMZJMjLtvbE+fEcvS0LQSYIA6rgw45upPIOZ8CkwJUPGOOc5naE0R1uC+qgjmezdZFoTn6B6F4vtS1f8CSfh4EXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3ZUxhaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3ZUxhaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04B81F000FF;
	Tue, 13 Oct 2026 07:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791878071;
	bh=DH39QZk8fcV0wrLH5rudNL6xm3sKpIbifIJbG37Ue4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z3ZUxhaGrg7iDA0lcJrbY49+XC+bE1yq/16FsTG8qA/IkCnkRcjpyWYnni/5b+gFv
	 O4+MhIfhnGZTQd0/ix4pmWrMWWJbgTKlAenuob4un2KvvqV02vNqM42ylNK6znRzvL
	 1FIipJW1DCu2AQZSbvm3ton+8/ql38+5oJtVCxBAw+dS/AcXPtLN6o2DzXgWTtFFxM
	 nIjtVaJp1vrD1pFhUh0a1yv6hq6hE7+tVJu8Fzv/1DGM2xg82TcmwvuXX/SrQEMabY
	 Yvb7/LDSEw8+TaAvsQILRc++h3szaq+HepwSWIuK8IoQgy5C1WL974UhE0Mk1nZx4r
	 LR2B+4tgVNpsA==
Message-ID: <sashiko-outbox-169214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <d6c405ed4ac3412b376e5c2fee70cd66703f921c.1791877396.git.mynameisjune111@gmail.com>
References: <cover.1791877396.git.mynameisjune111@gmail.com>
 <d6c405ed4ac3412b376e5c2fee70cd66703f921c.1791877396.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 07:54:30 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
> failed message's length and notify the device about earlier messages
> queued by the same call, so they do not remain stranded.
>=20
> Propagate that failure through the indirect PCM transfer callback instead
> of discarding it. Commit the updated indirect state only after successful
> submission and stop further transfers when a send fails. Return an XRUN
> error to ALSA so the stream can recover.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791877396.gi=
t.mynameisjune111@gmail.com?part=3D1

