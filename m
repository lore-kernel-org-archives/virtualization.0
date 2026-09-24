Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F027468C02
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244283; cv=none; b=IGckAMJvqv/5bqYZcuq+bc93ZX84jlfmFz9q2RzubtQV1oLfE/K+n2RrFWuop+wM83J1UjQKVB18jteoMir1OXPLOqaUWqcdfS93tQZEmW5vV2Nu2dB0Z24CMSMv0BWWFM4CwhZT5TkFCLmYeJ+fXaEap/9BK4hpR3w8YOIE1OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244283; c=relaxed/simple;
	bh=pw2Dwv9eJ5XaOUIQDeaTD0OPjPoDwEQ29j4rtPXCcms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CGHPJUXOgTO0I4lHv21W2dF2Wm0j7SDMI4yFpCR9dYWR1UaM4dQ80QN/DfRog3WeBezB53QVNp4Tux8gQTQfXHgHrPReiHezFJFd4FnpXCj9ftlRXKU2SzqGGdRku3TpWg3ktnRMmeksF47m/RU14MTDxUyo39En9aX4vwtJDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv7KPr95; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv7KPr95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19D11F00893;
	Thu, 24 Sep 2026 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790244276;
	bh=MHiXcNsBxy839ksHAvRHdUeWlT/N2Ox4T8wUTGeSj8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tv7KPr95dzpyTyv5wgpuiMhLmqH6LwTrZwhmtwIFyu/NHiPhCs1CrSlKgnpEnMf+Y
	 lFwjI0+auncujd/IqIJdFSysZREldSf0VESMvs4fCh2PsYIAe2qRtWeIGcGc63eySu
	 nJ6LFdEsWKdqUQXlVr1KZDq3aFZQf5spZTj+AdHlFwruQIH4+qWR+bJY40hVc++kuF
	 qTwg5Dl5Dysdq0dNWLj0AvpaBZsP4n6DvdjzWj+utuYTSe2bV87XYznBaHnPuFampi
	 BdGzUE1GC/eqQsmUhl2UCi4KmWcyIxvP5TcxDmC3PoNTHpxkC1HVPjWTeZ0GUpFtkl
	 IyWIF7BLa1edw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v9 4/4] drm/virtio: wire blob ioctl creation to
 userptr objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
In-Reply-To: <20260924095556.1326164-5-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:04:35 +0000
Message-Id: <20260924100435.F19D11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Integrate userptr into the blob resource creation ioctl.
>=20
> - A non-zero userptr selects virtio_gpu_userptr_create()
> - Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
> - Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
>   advertised VIRTIO_GPU_F_BLOB_READONLY
> - Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY
> - Add VIRTIO_GPU_F_BLOB_READONLY to the driver's features[] array
>=20
> virtio_has_feature() routes device-specific feature bits through
> virtio_check_driver_offered_feature(), which calls BUG() when the
> driver queries a bit it never declared in features[]. The
> VIRTIO_GPU_F_BLOB_READONLY probe added to virtio_gpu_init() hit
> exactly that: every probe crashed regardless of host support because
> the bit was missing from features[]. Registering it there fixes the
> crash.
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924095556.1326=
164-1-honghuan@amd.com?part=3D4

