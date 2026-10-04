Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA26393DE6
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115799; cv=none; b=ET1Kj2NXLgHY4pDWo9AQyI8fMBSXVNlo7QuGVTRG0xPrjqIyeFCf+lZtn7XyE7Yepf9Oxrp/bpYhE6QWRO3wnDTkDMaRAeEQdM62P3nIJCA02RVKZZLKwKkpVFz6ewXrglfhCVze1RlnQ/4KGlXV472DFEI4e4PM2HffZvcSBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115799; c=relaxed/simple;
	bh=oFfJQIWIq4CYbpGfXTBradDyDdIStUGLeBNS66HVerk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DLncv568XMYbGv7tMDlVfRgotXRlYAceJYoXOtn0eRDFs+/jaIOWA1Oo8p5++sYSJ6EqU1yHQ6EsSAVQJILVWakkjk/gPeh0EfMgvl4+Sq8SOokjRgRsP2tMOjacgrH86MlwY0KKarTVQp9o7PDFN0UfBPSeHjUOOz3K5+hb30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoozN0Su; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoozN0Su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB961F000FF;
	Sun,  4 Oct 2026 12:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791115798;
	bh=LmrfE7zIT4QurttLNZvT/1VzvHPKBlxoYm/TrFFmqZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoozN0Su5j99iQsXmeo5GFkv5r2wIhx9fgqMHdnct712Spms+RDmV+2t3gLBtUttR
	 jhFkhP3xsS6UCPgfwkuMkJQctkdhnwLzTU+ux/DME5kvMVnoIE96wA15Js0krqQpmu
	 XBUuv1Dz4+bVgfDeg2dhhme75iJYUNm0LBUBXWd8N31lLjdyz0Axfxm2G0+cZ0uVEM
	 KJMND/0wmQIeBBvX6jiGMNA+mWp0ZkYgV43NnERUylsghep0PCcFSRLQLVGn+nKqub
	 cF39J5sosH2SdWAGypHcLWRYRWDyjVziVlnGMcvgU5atTknizR3UagAONmCmyCaPO/
	 ceTX0Mx30Bc5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] iommu/virtio: stop queueing and draining once the
 device is removed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_110F1F4156EDBA12B5409541DC2D9BA0C708@qq.com>
References: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
 <tencent_110F1F4156EDBA12B5409541DC2D9BA0C708@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:09:57 +0000
Message-Id: <20261004120957.CEB961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] iommu/virtio: memory leak of pending requests on device removal
--

commit 64ef340ce80cdcdb5ed14c36f584818573bc5be9
Author: Anlai Lu <agicy@qq.com>

iommu/virtio: stop queueing and draining once the device is removed

This commit introduces a removed flag to the viommu_dev struct to indicate
when the device is being torn down. It sets the flag under the request_lock=
 in
viommu_remove() and checks it in the queueing and syncing paths to prevent
queueing or draining operations from running on virtqueues that are being
destroyed.

> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 1a43664587514..ba1d78e4daa0b 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
[ ... ]
> @@ -206,6 +221,10 @@ static int viommu_sync_req(struct viommu_dev *viommu)
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&viommu->request_lock, flags);
> +	if (!viommu_device_live(viommu)) {
> +		spin_unlock_irqrestore(&viommu->request_lock, flags);
> +		return 0;
> +	}

[Severity: Medium]
If a device is removed while IOMMU requests are queued but not yet synced,
does this early return bypass __viommu_sync_req() where those pending reque=
sts
would normally be freed?

>  	ret =3D __viommu_sync_req(viommu);
>  	if (ret)
>  		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
[ ... ]
> @@ -1555,10 +1577,20 @@ static int viommu_probe(struct virtio_device *vde=
v)
>  static void viommu_remove(struct virtio_device *vdev)
>  {
>  	struct viommu_dev *viommu =3D vdev->priv;
> +	unsigned long flags;
> =20
>  	iommu_device_sysfs_remove(&viommu->iommu);
>  	iommu_device_unregister(&viommu->iommu);
> =20
> +	/*
> +	 * The queues go away here: nothing may be queued or drained from now
> +	 * on.  Taking request_lock is what tells a drain in flight that it has
> +	 * to finish before the teardown, since the drain holds it throughout.
> +	 */
> +	spin_lock_irqsave(&viommu->request_lock, flags);
> +	viommu->removed =3D true;
> +	spin_unlock_irqrestore(&viommu->request_lock, flags);
> +

[Severity: Medium]
When setting viommu->removed to true during teardown, do we also need to
iterate over the viommu->requests list and free any abandoned viommu_request
objects?

These objects are dynamically allocated here:

drivers/iommu/virtio-iommu.c:__viommu_add_req() {
...
	req =3D kzalloc_flex(*req, buf, len, GFP_ATOMIC);
...
}

and bypassing __viommu_sync_req() leaves them without a cleanup path before
the queues are destroyed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_85AC6E749F6=
A912B7BB9FF360F8ECB3F5C09@qq.com?part=3D4
