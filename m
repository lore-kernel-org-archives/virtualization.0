Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062874;
	b=rHL+4pyxw4aFLjkyYkbXW0XvNcjNg8yYEqAWIkMgr8UMWE5Eq0JSe41ddQRSZQXGtVH9
	 MvYO4nt42GdYkMFkXuZ6NOhUKOybVIVx00jh4acQ3BPKawnzxMWjuFEEHqhLFGmdXEece
	 rPKK477rDTnrTnJS8GntyAAmX+vIL5/wCaxng3n2f4UYDnpbC6jImbnDk6NqOJi/4zVFQ
	 7mEfj3taBV8liGjfwkmqFcQCMZU/U7J+HfSYUXdJ6uzoSy6HlB+IEM+EJ4Mk8fuQTDett
	 +ODpFq2ikeHa2LWfdUxw1EwNxECl88dwkQA9azPmkQ2B8KQCQlrInCZdCwWXf7QoZmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iXHvZMofd8R5g2Luh11TcwOH1F+GGzZT4OdQQffEZAE=;
	b=ezZkVdc7Ao13TqvzWlN0lcxUfV2pZ6RVjGepj3YWW99IEeY1+QDOk9TtknSTRoMZs6vK
	 yLx+S1qt4biQ5jSi64KIZhBq21sT9jxbM9nWx1s6Po2VRw1J7fs2UDD2IfbdsBQSWfrCD
	 /RpnXCNyNHUbP0iON0+Yf57TR1kQHOWxGHWRHgXaAIxwPcfUEhGS2Pd76JawgNCIxRQ1A
	 LIzJuoclCk3N2p4n9dHZMTnT5hAhGt4Tr1OqSnFQhXokGt/k3eXmq83hSLVnvQYIx37nk
	 QaL0Q/vj3UUQuAXX3+H8HNL1VYsagNxxGj530Ey72zrjbnngL+NwsodmYzbqC0ASa5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULgMfMsT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092A606A336
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULgMfMsT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655F61F008A1;
	Sat,  7 Nov 2026 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062873;
	bh=iXHvZMofd8R5g2Luh11TcwOH1F+GGzZT4OdQQffEZAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ULgMfMsTEc9V5jCF51VVhRqwITYZ/pODwZHpQQy3H4L/FC+Q4GAhU7WplQ48nf4uO
	 DQOuHHvvpzHaMKitaqFVOH1+mdAM6Qli06VfQyKM7nZt+0+ifk9UbOv/Bmv4BVqMhs
	 JMfmWHoweg3H+m49e9ja8M8vBWvSPBsZydek1drCBH2XGqt8VGiL/nfRDk+9dXkWzu
	 Nq/+hsKIwVoiSG1gP5OLtYKblhIvwgtA6Dz0TrRuoGaRtASVDj9svcoB1R+kXKFMga
	 1waqla0Gbc7GY47kxtOsoTITexr+hyhwioA+RMku5Jafl19d8w9LavjYXlCstnexow
	 8j5AdAlojkE+A==
Message-ID: <sashiko-outbox-202970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 12/12] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-13-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:47:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document the five opt-in virtio_snd capture module parameters. State
> that capture_allow_empty, capture_allow_short, capture_packed_status and
> capture_pause_restart require capture_staging, and use the ALSA kernel
> parameter restriction tag for each entry.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D12

