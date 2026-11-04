Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785887;
	b=etcZtF9e7zP48Nroye5vbXDx5dD2U1cssqfJm2ksamk6ZZ84291mVcnre2hkkM6faYGT
	 T72usOJTLZwsX5vMTzpAayo/Wj293aHP6RDC43spangMcPKAuwqssOT0CkGLBaa08xlP8
	 C1Aslpr6qmt0rL6VZ3x4bIfqRvXUHd+Zu5f1G67IogZ+twZjelvOOllwFM+WPygL8VwWE
	 hT8jCl5jD8RHoKN6KT+r8SlE8G4D8RJc3BxJz0ITK6o3pIXf0DQ3lkhqtdaXh7zO0lVq/
	 dUGu9NOcZ+ieUkTiw0CQmEO702E1a/ucaV+x0jY4F0umxJ3WS9AdBaTI2CM/A2UXu2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785887;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pUlS0RBKg8C9dsbWHda4u/BwbjnugItE7zVXK8qrKVs=;
	b=VEU5dMBmuB/inVae0jtYhUngybUjvtkalro+eVBW/y7l/aQ/dvuns9zkkWErCJsNAvuP
	 Rxtv0ZJTORveRJVxcXEj/Sa4zALAjG3s2iuz0Cdpbnc64xij5ngRhIkruDB0rBlIYzSTx
	 8qN032OKvcUQ2jlLr61H1ZB/fgaAWq97hnLopUm46+xyAkSkFhunDuMNsybSFH6X9lCw4
	 qGubX4QsoUEH13wMJm4FMMqq8213Qdxk8jLIid1Nm43IoOQNKPIBhkYb0BXebewCxXjHB
	 lRQ7uGszb/NbmZU2DqI3TmV2EU6SkNcWt9TVdtqbPFkswaO/AMTqEq0xTFQP7s49gug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AV2oON14;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226A606A33C
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AV2oON14
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7201F00A17;
	Wed,  4 Nov 2026 09:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785886;
	bh=pUlS0RBKg8C9dsbWHda4u/BwbjnugItE7zVXK8qrKVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AV2oON14e5rcUzuISNYUttlpF1dZ6S46VnFW3qpFVIjJ4mBWyeJe1fj3P/lWX3nEo
	 /uFj82vTw9CByrMLuoSCJfzhr6rpkAULwBWSWCPv6wls9mM+DM0WiwW3k/0+TKwGwZ
	 Y8XOW/BYesK7FCKykRQL8etDuRPdq5vgQ1BR08effhfpQ5FdZGkDd2J+gRZEDeaPos
	 vnqoBJAgSSJgfj9zPOzqj4Nqv8KYEL/Fq0KxsqowkHSDB9UmsHJSlRqq6B7Sgj/bAU
	 xK7VLx8MYXf30V1BbG3aLfs8qvBUMR8MGPx8S05KsKn+vOS3gT2imfAL5JvIShWIAa
	 NknlooTMEOGcg==
Message-ID: <sashiko-outbox-197005@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 6/6] Documentation/admin-guide/mm: document
 virtio-mem memmap_on_memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolaos Karaolidis" <nick@karaolidis.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-virtio-mem-memmap-v1-6-308ae1da6240@karaolidis.com>
References: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
 <20261103-virtio-mem-memmap-v1-6-308ae1da6240@karaolidis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:51:25 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document that virtio-mem only uses memory_hotplug.memmap_on_memory with
> virtio_mem.memmap_on_memory=3D1.
>=20
> Assisted-by: LLM
> Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-virtio-mem=
-memmap-v1-0-308ae1da6240@karaolidis.com?part=3D6

