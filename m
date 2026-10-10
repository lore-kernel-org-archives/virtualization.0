Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C1495517
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791635842; cv=none; b=tBK7FkWHR161SSIhG8qY/3E1w0VSTO/iuyKTV2Cn/C66c2Gxd1zljb3gPqD/btSBK54HBoAjcdb3aSfwo4Wr/cpNDVFNWaWG1M4Q2KSVpe0kBW3AlA0aVUlQkyxTyz3KQwA6iqAHT9HRADGpujFKjJ+C5srHTbbtTk/4wreMhJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791635842; c=relaxed/simple;
	bh=CBydCweFLzY6MeGmL8CQfQKIn6kEgVXtqDEpggkY0Dk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BPJVBtgdo4tr7Y41c1kYZWsGzFFi8s3ALFWs0kFl1DfjS9elc/M/YMy9f/XksCgDb1pcr/I1JAJtF5LcPTfuJXVU8KBRlUQbMwuQiR2EFnkjoNMKZzIVH2nLlRsVxEOrLYNwq5znM2oVmhuh2gIH0ml29PxVmDURnUSgfjqW528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI7njXs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI7njXs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146C31F000FF;
	Sat, 10 Oct 2026 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791635839;
	bh=CBydCweFLzY6MeGmL8CQfQKIn6kEgVXtqDEpggkY0Dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BI7njXs0HREouXNfKJViJHkmhmQZYHNYVXzv+pVuKVbcS4sNrY3oQivF2QEb4v+Xm
	 YAfpj7NTRDoH+7w+QUTlEOubzCRbWnLC2+waY0C/lwROcFhwxe8+tlrpjNxbB7/vje
	 VxVQubnbyiEmBUPI2TsLXjzYvK5he5YSA4B52MBs5bCbTuqlWpsqPGfq934S9OFj0K
	 HV2j41fbDGrbBe30Kfn5/va5nB2tah+mNktL9bh9+jUxb2l38CBSRkAJ2sJpbAludB
	 Nj2YE7cSJIRgOIKRFGBryQlAl5ekg+GkKmpZYfZx6BvxxeTcIAE5s3K2kO/638HYf1
	 tihPXV1Qcx99w==
Message-ID: <sashiko-outbox-166540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] vhost-scsi: reject delayed virtqueue setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linfeng Sun" <linfeng.sun.dev@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261010-fix-warning-in-sbitmap_get-v3-1-33de562d1359@gmail.com>
References: <20261010-fix-warning-in-sbitmap_get-v3-1-33de562d1359@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 12:37:18 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Linfeng Sun <linfeng.sun.dev@gmail.com>
>=20
> vhost_scsi_set_endpoint() allocates command pools only for I/O
> virtqueues that are already set up, but publishes the backend for every
> virtqueue. Userspace can complete a skipped queue after attaching the
> endpoint, then kick it with scsi_tags uninitialized and trigger the
> alloc_hint warning in sbitmap_get().
>=20
> Delayed virtqueue setup is not supported. Leave skipped I/O virtqueues
> inactive and reject changes to the vring size or addresses while an
> endpoint is attached. Userspace must clear the endpoint before changing
> the vring configuration.
>=20
> I found this bug myself, though the patch was written with AI assistance.
>=20
> Fixes: 25b98b64e284 ("vhost scsi: alloc cmds per vq instead of session")
> Assisted-by: OpenAI-Codex:GPT-5.6
> Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-fix-warnin=
g-in-sbitmap_get-v3-1-33de562d1359@gmail.com?part=3D1

