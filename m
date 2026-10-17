Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275763D3CED
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792217000; cv=none; b=boRq3pOXgFBXk/UAjC776lOIjF+Z9pel+9QmSODyyzkS35oTO7rQOZiZnELMcyoKV4YI4I/tDCxW3YyhGo412T5LHAD0hYj9K8N9lCVinu+iq3T9NoOEWE1n8oecWpZPTWCB3junQ8fz6CV2MkSvJ3sbu37d6GLfbqrb8ai9REU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792217000; c=relaxed/simple;
	bh=dZUqDySn7SZyfiq8NEXHCjPhMYKMYywJqsKsmUiTP00=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r1F22KCx32Ur32HnaXhlijnW4Hp6FRvuD34FqXwQL0Rz8wOEvlFxWdCCQEpVs7+3eRRYMj/bX0JKLmvTjYS6bBlNr3HJdodzt5GRu7fX+uswDUSm6HvnDu0xrOcUMZ1bdiUaXqqCAS4RTVP7r25xM+ISwwmmqc8BfqB9X5gkE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2SpCFBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2SpCFBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B721F000C4;
	Sat, 17 Oct 2026 06:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792216998;
	bh=dZUqDySn7SZyfiq8NEXHCjPhMYKMYywJqsKsmUiTP00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a2SpCFBlf93vpsPNWb5VSAy+YlofAO96ezDZtPvF+P4fvqGkPCTBllAe5Cd0N6LkY
	 HDur4ZkQ/k/869uXMZGKJcZCG2QtTe7qj0PmIo6BetLepfjVZvZ1wfJOOpcGx+aFYK
	 3qdnoDaI8J9mWW7fX9mYA0au6w1WQJmlxSHrKAxQKcOcQ5/Hq6H/0mHEMTNsdih18D
	 N6CsT8szAF7i+eDMDWF+HFsX7Ad7UqhcO/ROpy2tVyIwhuikmkpAbadKTxO9zw+T62
	 wAs3iBt4oNXCpruN8FQLEueR35kjNoh0KzUA/+3iI0hXDuZoSV3XgzTDJJ3jZpjQCm
	 MLutqjweViCeQ==
Message-ID: <sashiko-outbox-175327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] ALSA: virtio: prioritize staged capture period
 work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <rfc-virtio-snd-capture-followups-2.f2737c95c12e45b4@gmail.com>
References: <rfc-virtio-snd-capture-followups-0.f2737c95c12e45b4@gmail.com>
 <rfc-virtio-snd-capture-followups-2.f2737c95c12e45b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 06:03:18 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/rfc-virtio-snd-capt=
ure-followups-0.f2737c95c12e45b4@gmail.com?part=3D2

