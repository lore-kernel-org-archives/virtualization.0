Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A8313293
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789858844; cv=none; b=K82gELMhMDamCNN0zZFG7MaMR1afgHoZmgB+BIKxcAxvamJ9n7JBr0RoH8pR5TT65NBx2QKCLAKyJTegprcX1yIdIloRv7nVqhsK2Rl7CcAGHEXq7TjGjUWOyfyh6k9f5cT3ezuyHlf+J52pVqf1Z04KuX3XGlFrEzEng1RB7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789858844; c=relaxed/simple;
	bh=/VK3JYgQ8JKiWHmKhiePQ3J1ORqJ+UbaQp8XPYVR7t4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gBlth1SACFZJOCNQT+NpIQ1w2dpi6Lqb7Jnh5ZUY38r0Tk5gEADcPKIE4BAwAgxttN7M4zzzROMbPa7aCpKxaSyCeFNBts36A4ledL9YYTwHT1CV5SRdPcSvZf+iRC7z6Wki8wPWVE+dXhBIe3CobQQb8tBbZuPpFDxRAhHdnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=desEpKzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="desEpKzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53131F000FF;
	Sat, 19 Sep 2026 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789858843;
	bh=C0d2ZWO4CyCK99h+SiUrTZNlcp/cT+ADhzqAMSenMwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=desEpKzCrRtL2ZYgsZehD+XpE9jw21k8q52TnisUsXNWKMkb7uIaKHume95RFo69Q
	 1xlwThUx5DWOWL1A5omcIew/raguCUJYldX7uV+kRsC4MeJ244hQIt8KxqheTg4da2
	 nD4ihfju7xmgM25U5kmMQ/x3+ikWoByjrr/D0ygOCAn22QIdaqkYl6Gi/+JHG/wkcJ
	 P05n9mniIuZhSjXaIk/T3f/B0MeOZaO0ieX71yF0iJIEvOWpX7aFOp9nBkB86abQlH
	 Prw6HLsDA7W+FQLE9wJl4WCO2GTm8Ij2E/gVuf5XYNOLL3g5jZZ72tA2CpFM8RxENi
	 iNEnV9uCqgbog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: fix vbuf->objs double-free, fence NULL
 deref, and sgt error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260919223440.3884176-1-benquike@gmail.com>
References: <20260919223440.3884176-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 23:00:42 +0000
Message-Id: <20260919230042.C53131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/virtio: double-free of vbuf->objs in virtio_gpu_reclaim_vbufs
--

commit 94995582490827616358d8c115ec5215d43b829f
Author: Hui Peng <benquike@gmail.com>
Subject: drm/virtio: fix vbuf->objs double-free, fence NULL deref, and sgt =
error path

This patch modifies virtio_gpu_dequeue_ctrl_func() and free_vbuf() to
consolidate vbuf->objs cleanup inside free_vbuf(). It also handles fence
cancellation and checks for exbuf->size in submit initialization.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -202,6 +202,10 @@ static void *virtio_gpu_alloc_cmd_cb(struct virtio_g=
pu_device *vgdev,
>  static void free_vbuf(struct virtio_gpu_device *vgdev,
>  		      struct virtio_gpu_vbuffer *vbuf)
>  {
> +	if (vbuf->objs) {
> +		virtio_gpu_array_put_free_delayed(vgdev, vbuf->objs);
> +		vbuf->objs =3D NULL;
> +	}

[Severity: High]
Does this change introduce a double-free when called from
virtio_gpu_reclaim_vbufs()?

Looking at virtio_gpu_reclaim_vbufs() in the same file, the loop manually
frees the objects but does not clear the pointer before calling the newly
updated free_vbuf():

	while ((vbuf =3D virtqueue_detach_unused_buf(vgdev->ctrlq.vq))) {
		if (vbuf->objs)
			virtio_gpu_array_put_free(vbuf->objs);
		if (vbuf->resp_cb_data)
			virtio_gpu_cleanup_object(vbuf->resp_cb_data);
		free_vbuf(vgdev, vbuf);
	}

Since free_vbuf() now also attempts to free vbuf->objs via
virtio_gpu_array_put_free_delayed(), and the pointer is not cleared in
virtio_gpu_reclaim_vbufs(), won't this trigger a double-free on device
teardown when there are unused control queue buffers with attached objects?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919223440.3884=
176-1-benquike@gmail.com?part=3D1
