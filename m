Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D9A361666
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807599; cv=none; b=O8Yo+Ru8kOz/ALZeHErQoxF3WyMABFM7dXr7fu9ZFL77IfURASkCDjKiWMqmKRdlV6LoN7rqFMF8dA5wM6MznIBFEhkgvNj/KZuwTU2NvT1hRSsFd6L/ObZgYywTeloKoeL5vznPbbqlvvC+25I5fMvnpsK65LXBuNtEyIXmxKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807599; c=relaxed/simple;
	bh=XpopgWyl7lpgWS/u3Ahg9jQWQh0bgRs/NKCxCuhZieY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Svwbxp5EtAsIlhZ0Oso4oZfeMrF0hj7h3DyWNhYsdy0dyDM3VApY4s+/VSiPm6bCZS/8+X9vlFiAlVJGSiDAzc5WswR74Gax8PdFA8qJmh/RB8TpstKy0wlOrXSsKbZYzjZ8v8udcYQ0B5ekH/NajliGExRcN55Jz4h1RcDwhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqH3ihkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqH3ihkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DDA1F000FF;
	Sat, 19 Sep 2026 08:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789807595;
	bh=XpopgWyl7lpgWS/u3Ahg9jQWQh0bgRs/NKCxCuhZieY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqH3ihkz9vuNnDv/EomkdI/kv71yUBwX61EIe0m4NPTOclkbPtSsacDJsD/djwtNg
	 8yKmH0s8yhrueshI/sLAxHPUnkb1CDLJBg/B77Vkmxsb34qAU2O7PLrLZkMQ4fqQqI
	 HhOTdJmO9ZBqy9vZ7Y4RJqISuykG2H+oVq7Nzbk9XNxM3V9u+Rk17aLFyfMT5L+wTY
	 DdaIFUqQzKYQ5sM71RXBUlhtyCpktGH3eBYtIBlDGsh7griQpXRG5Wn2C7uNongTsi
	 X0fIcaqpUPXoAmdIjRaP9vd1PdSmJb5wEUuCuOYh1bsnmCOP3OPbDNpZK+GJlv5dbX
	 x3qjgRxupAmNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vduse: avoid infinite loop when no affinity CPU is
 online
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260919083933.104437-1-physicalmtea@gmail.com>
References: <20260919083933.104437-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 08:46:35 +0000
Message-Id: <20260919084635.94DDA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> If all CPUs in vq->irq_affinity are offline, cpumask_next() walks to the
> end of the mask, and the loop then resets the cursor to IRQ_UNBOUND and
> restarts the scan. When VDUSE_VQ_INJECT_IRQ is issued, the intersection of
> vq->irq_affinity and cpu_online_mask is empty, so the caller busy-loops in
> kernel context on its current CPU (e.g. CPU2).
>=20
> Replace the while loop in vduse_vq_update_effective_cpu() with
> cpumask_next_and_wrap() to find the intersection of vq->irq_affinity and
> cpu_online_mask in a single wrapped scan. If the intersection is empty, s=
et
> curr_cpu to IRQ_UNBOUND and let the existing unbound workqueue handle
> injection, avoiding repeated rescans when all CPUs in the affinity are
> offline. Use cpus_read_lock()/cpus_read_unlock() to keep the selected CPU
> online.
>=20
> Fixes: 28f6288eb63d ("vduse: Support set_vq_affinity callback")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919083933.1044=
37-1-physicalmtea@gmail.com?part=3D1

