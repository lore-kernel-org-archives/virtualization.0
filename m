Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E81B3EDE63
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244241; cv=none; b=jG5AOMbjOBTRTNGKJ1FvZry5CMB85bouweda2WkDEqP/i8nOCOCu7ISSzdVk/9XRztYDZwqhqLNDkbGle61kLtjAbkG4ET9yYFrP6zbngyQGJOLO+nH3ZVc2eAc8rRtaD959Papm43jviVekKeQcbOpNI09Xeccfbl+F2dfzWq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244241; c=relaxed/simple;
	bh=+HblMzgUHnVQDLjO/UL0xqNapo4MemRaXVTdF4YjU0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HUT2aiAh7kToUIwtooGyJryf760jvpcYAKEGdLMIiWn/W8+0IzPeGPQOzJ4WY7WP0h9IY2nn/cMICWz3IWj6j9TGzG6J5jB/TgDMhDsQrxSP1R6v0D4yVOvzpeFFZ5Aw6SoCucUJ1b+dKkg/rJxGFC/sECvgd/ebuWR965TKRZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW5G3QSR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW5G3QSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4CD1F00893;
	Thu, 24 Sep 2026 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790244234;
	bh=+HblMzgUHnVQDLjO/UL0xqNapo4MemRaXVTdF4YjU0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JW5G3QSR/1PsI6AP59hEP/Mg67m9mz9jHYhWdTq/CUZ2uWZj1OPmRlMsHWi/kSCDD
	 Trp1RShvkMuByWE3yBYVnvhCsFyQdYrcXasvN1coSqFaOJtbLktu17MCav7WwlZfbD
	 eV4PM2bsB7TvhdpfdEfPIRy9xqzuI+4F6oNk5RDbJyAKiiyC6dY8V2RRfDI+EUI7Is
	 f606NcwNz6rKzQ2bJhazsELfqO4IkqFaNWS7sEmyAyE9hTTpCRWg0VGF6h+dJ1vELK
	 q6ih5cfB4/VxvoGNyxutc8ZtX2MNEsJlvltrblRIFQcB5lMrH2iW919cXA1ZNMBfS0
	 FnfxEb5i61feA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v9 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
In-Reply-To: <20260924095556.1326164-2-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:03:53 +0000
Message-Id: <20260924100353.BD4CD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
> ROCm compute workloads in virtualized environments.
>=20
> ROCm (Radeon Open Compute) is AMD's open-source software platform
> for GPU compute and HPC workloads.
>=20
> ID 7 is already used by VIRCL, and gfxstream's rutabaga_gfx has
> already claimed IDs 7-9 ahead of any spec or kernel header update,
> so ROCm uses ID 10 to avoid a further collision. A matching
> virtio-gpu specification change is in progress to register this
> assignment.
>=20
> Also add the matching VIRTGPU_DRM_CAPSET_ROCM alias in virtgpu_drm.h
> for consistency with the other capability sets exposed through
> DRM_IOCTL_VIRTGPU_GET_CAPS.
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924095556.1326=
164-1-honghuan@amd.com?part=3D1

