Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5304390204
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792217035; cv=none; b=lGpxavRAfDhMvGH0uiOyBhC3ShxaPWmuI5EFi4IV/wOXDb1GcHMvh3KmV5/1laoAdVZ5klVyEY0/azk+afGrTAciNMQJKq/FsahF7tyJU4ouaHiNmwDswxv5JL0tLjrXeWM8EBNjItEopRwIyJkUlZTLJnbI/1pYGMv7cIOdAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792217035; c=relaxed/simple;
	bh=q2+XmelCDQm8pozyFcQMY3hxKZ+pVDY0AYgnBEjJ418=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KyKLWyvM/jVBFbVgm1QYxoNPv7a8g7R/Cz8fhWyF6Reik7MF7L0whe2z759AmedbeB1ZrrAlmWoWrQ/xfUA0MC3KT7JZ1C01pRnyV6/KoxZQBPly4XBxPgsBLa4cTGUKykKla5pBY11esgzF42MQMF1riru0sa5edXIG7NKXQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH5YwjtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH5YwjtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEA41F000C4;
	Sat, 17 Oct 2026 06:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792217034;
	bh=q2+XmelCDQm8pozyFcQMY3hxKZ+pVDY0AYgnBEjJ418=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eH5YwjtUhsegXYQwyPVPUzrbTJzOqZad5edCsDc9qSsk/QScJhnbN+l0xoGlmfqwv
	 r+A0RkwJ8aXlCJxDQJXUPDJQu8fN6BXf5CblTNNaSyW+6/YbYlUn936KVSQywFrNW1
	 +m/OFSZm1/HfF9Ge8b6NZJzdQBKcR9tOZ4I8jtPbJnGDoDptj9rAj1NUMJ0WGfYcle
	 jTdzrOoCUogkhVt9q77H8KcPAqh7mKT2+SV2Do1ebmgMEANEt2zHV+IzaQUNejZay6
	 Q19j/nKJURprVbdyFK00RcysCGAQEkRNPgHAah6E936fW6dy8ickTIxLvApnMtuhg3
	 aBUhozYZH8CXA==
Message-ID: <sashiko-outbox-175328@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] ALSA: virtio: account staged capture reads
 before RX refill
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <rfc-virtio-snd-capture-followups-1.f2737c95c12e45b4@gmail.com>
References: <rfc-virtio-snd-capture-followups-0.f2737c95c12e45b4@gmail.com>
 <rfc-virtio-snd-capture-followups-1.f2737c95c12e45b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 06:03:53 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The RX callback holds the queue lock across a batch of completions. A
> reader that has copied samples can wait for that lock in ACK before its
> consumed bytes are removed from capture_ready. A later completion in the
> same batch can then reject data using stale ring occupancy.
>=20
> Account the staged read under the substream lock before acquiring the RX
> queue lock. Release that lock before taking the queue and substream locks
> in their established order to refill requests.
>=20
> Once accounting is committed, latch refill errors as XRUN and return
> success from ACK. A negative return would make ALSA restore appl_ptr while
> the driver retained the consumed-byte accounting. Keep pre-commit errors,
> ring-capacity checks, and normal period-work scheduling unchanged.
>=20
> Source-extracted host and kernel fixtures reproduce the stale-capacity
> race and post-commit ALSA pointer rollback. The candidate preserves wrapp=
ed
> data and pointer accounting. KASAN/lockdep QEMU lifecycle checks passed.
> The fixtures substitute selected backend helpers and do not independently
> establish physical-device acceptance.
>=20
> This follows pending staged capture support, whose introducing patch has
> no upstream commit ID for a Fixes tag yet.
>=20
> Link: https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc=
4691@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/rfc-virtio-snd-capt=
ure-followups-0.f2737c95c12e45b4@gmail.com?part=3D1

