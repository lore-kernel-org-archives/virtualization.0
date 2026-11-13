Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563317;
	b=gkDynPpo9PEil5Y9/8PUsDECcmY7xLAwx4qVLxQZu7/2Yefz1jvr9P+5cDQFGkBbL8o0
	 vIhtaZcoMcyeuZVKQe8/rO8QaLCK+0287syqnqkhEw5pdTXL9NaRYx/5HXz5C8XemW8JF
	 t/Uh8RrH4xQCv+acf7+AnJges+GNn+c+avXVn+wt/jbeiClHk9fLk2wyWcCKi7FidW0Sv
	 WqgdsU7IXoVM7OcLr32TcfzVBxkoUbe/HM4OD4O64ZuqMT54gfxYBv1XtFKfevYMjDzlF
	 PD8cLt+01A01NGVOH+qagyIDZ+O37lHSnQNeLLLeRDPWIYlWJzfpMMuRub3/DT6U6VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sox3A8BupNtFkRmPCDR0olCjQJgWFR/HfO0XoXAh9FY=;
	b=jMxQ3c/gEzMPZPCF+5Twbp58vL+prnEAhtv35w0O8srisD9jBthFzZt5+DSty/7CaHwC
	 qj+2NfAmnTqVd0ELQoWhzvZoxdkiW0muR7n7GRJiyFYATa4DlVpDfiBSeNznXLCs8hERq
	 l09bBHd18e8UlYf9YTPa5rXanEWYtwYgFrzfc6Tx71i5ZQSTe/lpfqHtllxcqUl77zr8H
	 ZR40kz1LGuUyYtPdsRz+B8vypCzHINMq9u923onXLnPjY6gda/O/WBvhGFUy4zit/xOrU
	 6FDkdjLEk2UqirKZz0WosgYwUa1a2LQdOOYLXGCWBb+EJ6jMdutcWy38aQllfh/qQ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PInOMb8z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A5606A331
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PInOMb8z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90A81F000C4;
	Fri, 13 Nov 2026 09:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563317;
	bh=sox3A8BupNtFkRmPCDR0olCjQJgWFR/HfO0XoXAh9FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PInOMb8zEq9wGuzR+KUto5f2l3NmFnfUHpQW6epzoyYnJH4Fvis+18w0HtF6kBLqo
	 P4AUrcsvhIkMCYkwfozqnx4KGFJ0JpiuoW6A0ouw2eu9VLCcgYfdzJGuTqANgFZhXv
	 nSwMtpNAzc/J7TxSWVxuXjn8JxDQ6Cwhb3ZKkeVWKGm7f+e83+Xz9QqKorAZhe0nTF
	 BaZiyAgmgRY338fskjzgrTA5Q7kfZejzTeWNRu7YRlqZVs9fshFePCZGlQ/qrU07ke
	 qUNcPhZgeacjtS+L9ScRQcEpld4/UqRHlfWY8fPPhcoliIkn2+ROZksvM3ksKmPjEU
	 JJnKI4x8AM7lg==
Message-ID: <sashiko-outbox-212573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 06/18] ALSA: virtio: propagate playback send
 failures through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-6-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-6-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:48:36 +0000
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
> Propagate playback submission failures through ACK and commit indirect
> accounting only after transport submission succeeds. Keep the PCM state
> and buffer-access checks synchronized with playback transfer admission.
> The existing capture ACK callback and initial queue reservation behavior
> remain together until the request-owned capture conversion in patch 12.
> That conversion introduces RX reservation, validation and refill as one
> contract.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D6

