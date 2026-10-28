Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181885;
	b=ANJaX0bwlKuWXO5VM9Cxjk8UJEj6iG/pQD7dhk9x1FeODmEdENd+O/ywUMVOx0V0OjWQ
	 gEYnBFNmKc6dvaVLiep3SE8fHG8wJmJ90s7MV+DByT1d8zZvUPEybx/gYudcDfLXS6IdG
	 nrLHrLC2l/A/Met13Z3a9KZo/lvFKP6+ckOhdQbCxu3Stfad8eCWnj1rpWbnplTRM4ndh
	 Jnqi5WSrRYxbc8OZ7bnwwFuTlJLsReBwajrN9yxXlhU4dk6NKeV22BDKExdsun9S5/o9e
	 9LuAFALYOJjVq1kzrgkClLIz1H+dS+iwkcAEVYI+sJbI656aly/tcf7UE9tuwtpbLQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181885;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CKzVCBp0SfbPFCjeyqIrHtz9joOwCpgBww8naHOxiQs=;
	b=JHlk/Bx2OvQmSIn60q30zCnPAw9Z/K4qrtJQgctM6zoX0/QgF7DEF6TU8ca2FOJrN25M
	 ZOlHobvpIKrJ1W7rC9Zw/anU/CwzHqqRvHlyRduzeQhVXpA22EBxaZ7WSqZvw+AvjTklz
	 KMMiK7SX2iNEzqurpnMt28w/4nFlq9T+zPP+oec+TmfIMvH5f1Z5zELrxfeAD0nrMdAqf
	 YhHZKjWiBAGJY70gAiKHMdyFt4rfhQawFFvB5OKbFTbAYl93KPsRsZl9jD9i3FQQt6b/z
	 PWPlnvqNbesMb/T1CBbcWWi26wLOwpKQ4klse7erdY35pxxz5jawZZKrzPwVjDX8V1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tq0q3X/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A244606A322
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tq0q3X/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99041F01825;
	Wed, 28 Oct 2026 10:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181885;
	bh=CKzVCBp0SfbPFCjeyqIrHtz9joOwCpgBww8naHOxiQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tq0q3X/ex8AWo8fSPCYVN7dKQ7ez0vhugU+Di0LxexhjSo02LwJJPHCObUjqrD5KW
	 +o9M8SdZulwE0UxpWvRwhJ1KlJx8/4zUVuUP6B+N7MA3OYlCe7yHxZloLyzX9/fnOs
	 6ZjXc2jpPPApm4/JwBZ/p9RpCGtqg4bqsDffaCMdB9y/kmC+hS+nfjBzopnEEb2xLp
	 piIa4Gevygup61mrG3WnuNAFtJdCuN+KnUgkJkUpGO/NSB2ru2R/FOoeinNN0BWXRz
	 OWBpBSjy9hnUvroF7rJDdLNCUvnmknoj/pR4tQj7NYZ0lRzJeA/ZGZGqh4karXnQli
	 PzuYTLRLTUBnw==
Message-ID: <sashiko-outbox-187715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/16] ALSA: virtio: prioritize staged capture period
 work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-10-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:04:44 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> CPU contention can delay staged capture period notifications while RX
> completions continue filling the unread ring. In a two-vCPU VZ guest with
> 16 nice-0 CPU workers, the ACK-fixed baseline stopped with ring_capacity
> and EPIPE in three runs, after 11.74, 30.77 and 30.33 seconds of audio.
>=20
> Route staged capture period work through system_highpri_wq with a common
> helper at all ten producers, including ACK errors and self-requeue. Keep
> playback and non-staged streams on the normal workqueue. Initialization,
> cancellation, buffer geometry and capture accounting remain unchanged.
>=20
> With the same kernel, input, geometry and userspace priority, the candida=
te
> completed three 70-second captures and immediate reopens. Its maximum
> matched queue-to-start delay was 20.366 ms, versus 108.112 ms in the first
> baseline failure. The other baseline failures had pending work without
> matching execution, so matched-only statistics do not bound that delay.
>=20
> Reader scheduling delays were also present. Both arms passed a separate
> nice -10 reader control, and host load varied between runs. These results
> support the change for the tested workload without isolating a kernel-only
> cause or guaranteeing lossless capture under arbitrary CPU load.
> KASAN/lockdep QEMU regressions passed with the unchanged candidate source.
>=20
> This follows the staged ACK fix and pending VZ capture support. The
> introducing staged-capture patch has no upstream Fixes commit ID yet.
>=20
> Link: https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc=
4691@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D9

