Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41E83B775A
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698002; cv=none; b=K+ApyXDjPLqvF7yvrdBt0g/xTLH5F9OTnUh4vslYUa7XOMvft8Ec4nV1Jw/fXwN3RFhjuM/pbwFNB/lyso4AeOuGZMPvqW+5DUore4hP1kD+kwW/zGiPk3/RVFk4b2/TXFR7aleze29gYGO+bEh/4wElChsiUfufDUNcYSIxJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698002; c=relaxed/simple;
	bh=rqI8oUFbsu9PuUkosgF75VCax/xZPd0/Uyevksoj5Ko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q8MF7dbhybZL7v8XNJJR0ff6ZZx/dPGKo+vaU7TJ/iL5pE70YLHCACPoAuo64W/9FuPghDXG3wW624oychDsKNgmMUSGyzZ8xFaEdi4an79V1/LNyVMeNgZhGLWawydBCZ8eDvmo9Qmfpe4QE5CZUVn2DQMcM0EQva7iok5Bz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2KH9j8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2KH9j8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3A21F000FF;
	Fri, 18 Sep 2026 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789697995;
	bh=FZ3sKjPiL35u4euseu+9abNWPjFUoUM67jyRj7sdo1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z2KH9j8M3yWhQ5uMKp474GySQeEs+jgbbT7354eWITyPLCl1aqmkvp6e9UXYXf27M
	 QOnw9f+IL+Omf6cSkn2NZjat52gxCkfQ3AYkqvjK1EotndhmTIru3+K9IrNKcmMyCB
	 fltaz2u8K/G/DG47J9wBwcXMYON2idhgh95Mg7tjkgNJq+sQf9htIndffUYIsTpvbP
	 wAh3gABo1GYbHLnXIWPVTfZngdjlFUUFvPUaP/ulfz+DHmoEPLSC85S9lMErqxyHI1
	 05aSIOPsSkJFRt2FyT42MADAJTWkQJ8n5TW2aEAWMdYX5mFyOyLzpx43iBZAuKjVCD
	 w33NQ4nic8/Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] drm/virtgpu api: add blob userptr resource
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260918021154.1432154-3-honghuan@amd.com>
References: <20260918021154.1432154-1-honghuan@amd.com>
 <20260918021154.1432154-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 02:19:54 +0000
Message-Id: <20260918021954.AA3A21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add DRM ioctl flags and a userptr address field so userspace can
> request a blob backed by an existing process mapping.
>=20
> UAPI changes:
> - Add guest-only VIRTGPU_BLOB_FLAG_USE_USERPTR and
>   VIRTGPU_BLOB_FLAG_USERPTR_RDONLY flags
> - Add a userptr field to drm_virtgpu_resource_create_blob
>=20
> These flags select guest pin behavior in the ioctl. They are not
> part of the virtio CREATE_BLOB wire ABI, so mask them out in
> virtio_gpu_cmd_resource_create_blob().
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918021154.1432=
154-1-honghuan@amd.com?part=3D2

