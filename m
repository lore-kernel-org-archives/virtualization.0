Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409823BB9F3;
	Wed,  7 Oct 2026 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391514; cv=none; b=lHjCbJGEqG1XwY/ermTwYWf4Gad8imJDIAjqfoagArw9owqhgdZS1BSQ3Hbys1Q7fl5H81nbbaolAAQqUMMMBvMHuucnWXw/Qz7TdBFMRhnuq0JhD2XhHRXIXFhTmTEoNToooOhM8BIyLbpRjSQ0yVBOqYjr6spJuqyzf8B7Yn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391514; c=relaxed/simple;
	bh=2Bj6OyhyZCNvbCvpjkwoOzG6IZPWMw42ipzCILNXO6Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qTnt04hdiZ/O1abACyJMziWw/QHztrAf2Z5VwlzkByGbCsdbDu/he1NfO8u3IZ1OwA7yrplELYN8TxgKjSTnHkXLKRdSjFvzo9baYmLIqOs8oc966Vnrj3EPtxbv5K3gjU6cZPUxafhSGBfje8aF3lsklghCEmIIiW16krkdQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8nTSAF8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8nTSAF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D318C1F000FF;
	Wed,  7 Oct 2026 16:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791391512;
	bh=2Bj6OyhyZCNvbCvpjkwoOzG6IZPWMw42ipzCILNXO6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8nTSAF8O1YV3YYeOhpgGOn0/xK2aole9oWnc6en/MPidwYvLneYMTT0nJjUZTCm2
	 73jnFuQItrav5bjPqBAFk2FSnHIEj30DM+G3kmaOse2Ybx36/JV9ALZtdGQIf00Wlz
	 rRWShJpH3ChRHVf3TlaB/p6MtuB9IDExWbUa3Ygo/Q3M9sCBO6yGNCj5qFPWCV67+b
	 u3LvmAqBNFzYX/g/Ga185DCGsMkvoFy8NyuJtJKneBZNoR9G2YpAlmPzQlH/aIam+N
	 MO9kK6cm9GtpdRgis+2FiHW3p8I8J5umu7ZnCzEj/ZrUXbGQrsW9wS0Dom4KCGxr6c
	 DSO5CVwPHN9jg==
Message-ID: <sashiko-outbox-163204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-scsi: use FOLL_PIN for DMA page pinning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karthikeyan KS" <karthiproffesional@gmail.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261007163716.707102-1-karthiproffesional@gmail.com>
References: <20261007163716.707102-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 16:45:11 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> vhost_scsi_map_to_sgl() pins guest buffer pages via
> iov_iter_get_pages2() (FOLL_GET), which does not prevent
> copy-on-write or page migration while DMA is in flight. Switch to
> iov_iter_extract_pages() (FOLL_PIN), which does.
>=20
> Cc: Jason Wang <jasowangio@gmail.com>
> Cc: Mike Christie <michael.christie@oracle.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: virtualization@lists.linux.dev
> Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007163716.7071=
02-1-karthiproffesional@gmail.com?part=3D1

