Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2803EB11C
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884297; cv=none; b=QVmj0zoqgiy9Vc6GDLx34YuDIOQoao74HmMqP0yncjjwuq4jrk2gz0fzcTiahHZlYvkU2ufCUoAxVVkcvCC5UX7jP70pl8s7QzPdJ8WfQ8iC+FPSd5zegkepmIPa7BGrHr8ENPk+QkVd+q+m3AbeNMmH19HykGW7Gg24ijAQJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884297; c=relaxed/simple;
	bh=+8dDG47XMcCWEpZNJ8+Kk4+tTLpZMolCj/POsgshYhY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TRodXjjGWj0NXgk2wggiIrVnIuM+2rqjkHpY1hu+2RfAKmz0uv1xD4J40MvfZmmZAO0jv/MwOxQEyVqFUdzoA2k3OdRwap8Tyn02mJFtAfKbNHJAzkVlMT9oYMWkV2kXJ6IMmezLC1WR8ODloNnMKyfqeMMZXz25bcWl6I+IN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yot7VtfB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yot7VtfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7501C1F000FF;
	Tue, 13 Oct 2026 09:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791884295;
	bh=+8dDG47XMcCWEpZNJ8+Kk4+tTLpZMolCj/POsgshYhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yot7VtfBeW9zWwie1sM0bMgnqE2rKCuDcEIwZFlSoCpFwmmWmaKvbvSwUsukyZSFg
	 Cb7ofPqiXMCZi1UQCeuzNqoqYF9/eGhn70ifXROkPhfGeu+mysJIrWSG8sOEPqxc+a
	 Z1OAFUWX0boApJ+bD9E83vGvIn0Oe6rbxg5TBLZzGPYivWnd3Mi71SvGveRTHRFoj6
	 VdQNmKPjonei97u8BomwMhQ0HPCemk/jWryWlaTFUQ/pNoGneJ4HJohjrXj3nQjN8J
	 kd9ly430pFdE5FZdc6bPz6WQWi2mNplYQzczImVxmx/ZCOmPw9Elx7vzZAWjHT3y6e
	 tDSkGNwrvKl+g==
Message-ID: <sashiko-outbox-169360@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <c813ae359e4672b93d940f884903f99a29371434.1791881787.git.mynameisjune111@gmail.com>
References: <cover.1791881787.git.mynameisjune111@gmail.com>
 <c813ae359e4672b93d940f884903f99a29371434.1791881787.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:38:14 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

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
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791881787.gi=
t.mynameisjune111@gmail.com?part=3D3

