Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D8449B11
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790454419; cv=none; b=uZqYEOf0aceciYjSRfWryyOmUbft0ELCiHHPCpFnfd+1AAeyD0khiC8OiFZYhHgulFJ8Ke+IQf1/CTEfmLFvEDUaSYKHivIpItp92G+7iO7YqpABQG4TeRXa2xm2h99gtbIM2rTU0BOSMpEAoO1CWAozAo5wOmmtAvJZT13bBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790454419; c=relaxed/simple;
	bh=MDpB++OXgphrlXMIsBfhJXooDzyrXgiN7rbftC+knj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VNdnsVu2xnf/Q8UO0BtxLMCjF4PQevzlpcfDtWr5G/LkebfgSB4ph5jRGJWt2OutHRrlU+7IBfY4m9Wvi4/aNrOlZDnw9/82nk0GjMQQt5eZ/p0CEkCjT7VLLsaCRSXQbv0KuoWUn+pBGhL9s9Zm5BzxpNcL4TEjUH5hcK7tsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhmr3DQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhmr3DQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722131F000FF;
	Sat, 26 Sep 2026 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790454417;
	bh=MDpB++OXgphrlXMIsBfhJXooDzyrXgiN7rbftC+knj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vhmr3DQCmCHnJ6jQrVFyuI2WHqxmADEzd+EnLqoPlvYV/T/BFAESrSfl0Q7Wxm+uM
	 jOi+XuycAbRPEriCR7t1lC7Fwdvpdq5mwRh3pVT6P7KwP7y0d0v0CWrgWBT48C7rpc
	 ChoqPtOvEOP9z45m91aXPFq8wXUE693YvhF37h5dD7Rv4VEwD8KLAaJtmt/URtGBmp
	 3B8rpe8PPY7L2WFSgoccsqa86+bJAEqygqCXbN/t/2LqP8Wq50aXTBy6LDqNfjmdbn
	 DhzALNwFIWXXKiFTLB+qbCaXF1jzBX0ZtWKJ/KFngMPP1i9+/aTJ3xsavjStFmIh/4
	 tg5JMlP/sDqgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/virtio: Reset device before deleting virtqueues
 on freeze
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260926202040.1313385-1-oss.patchbox@gmail.com>
References: <20260926202040.1313385-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 20:26:56 +0000
Message-Id: <20260926202657.722131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtgpu_freeze() waits for the control and cursor queues to drain and
> then deletes the virtqueues, but nothing tells the device to stop first.
> del_vqs() frees the vring backing, but does not provide a generic device
> quiesce operation. In particular, modern virtio-pci keeps enabled queues
> active until the device is reset, so the device is left DRIVER_OK with
> its queues pointing at memory that has been freed and may be reused while
> the guest is suspended. virtio_device_restore() only resets the device
> later, on resume.
>=20
> Reset the device before deleting the virtqueues, the way
> virtio_gpu_deinit() already does on removal.
>=20
> Fixes: cad6a879a7fb ("drm/virtio: Freeze and restore hooks to support sus=
pend and resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926202040.1313=
385-1-oss.patchbox@gmail.com?part=3D1

