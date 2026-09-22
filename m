Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDB32B115
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081125; cv=none; b=QDSVqDhDk41yN+fVfGyaqqGpEHqCnh4E8WIdcYfr5hXhYWku/gH13aANgfMVFFHbQGMahb6ujH3uDLWGe+zHaXP56raFh8f817B6sloWuTG03zktj/ap26gqgmeoX738Bqc1n8xbdwi4t5s7tF0cQigBMi/pcd8rpk1qoEHhM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081125; c=relaxed/simple;
	bh=l/ux5nQ5TTzm1cXTetqJqjmK1suhlg9cZwUikoqq9PA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qETi8MYM/boWJ8ByNUJXY3YOLYCSgOLS5Dom7epdn4fB0xxlQmxSgXuifDE7gTTttHGYENd1nOv6HNB7DO1jL1NlJilGs+3QLwW/maI9A/3N0T4iIgD28kEIjtFv89DChfALAFjY9om3Qx1TRteMKFAfTU08N9IEuOK6FhZ+4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiY80DeU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiY80DeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4541F00893;
	Tue, 22 Sep 2026 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081123;
	bh=VEpfFWLfkytfjHd7EqR4qSKVQl8m/YJYpp/38BGxQN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IiY80DeUIB7lj4j210qgEbQSdlbV34VeMhkphh+4w4NLGRo7kZOqRVG/aSNAwZdiH
	 OuwRuLsdCyNhEfr8cyxQpeRAkPh6A2/EAWHUPvwTcYX7EKFNbE3zfeT0/NJ/uWdU2p
	 h+2GwhEgwlQGd9y2/ag1LPltFIlLS6dXloY62CC3nBl7p40+dby0/woSEjE4WirwqP
	 mQnLg6nek74Mjr9jwiuxxKn9F542DNHMIELE2pCvr11A1730F6wnXbXvC5yypgkLG8
	 NosqAdH615ucR9480oixOYOfTnafozUbF8CuLCnSMOe5RMBPpasN6/bedTDYEUJmLi
	 PpZPlDDbQsTCQ==
From: sashiko-bot@kernel.org
Subject: Re: [virtio_pci?] WARNING: possible circular locking dependency
 detected
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zenghui Yu" <zenghui.yu@linux.dev>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <98f2f4f9-a7fe-413e-a366-7bed08290697@linux.dev>
References: <98f2f4f9-a7fe-413e-a366-7bed08290697@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:45:23 +0000
Message-Id: <20260922124523.7E4541F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] virtio: missing indentation for if-statement body in vp_setup_vq()
--

commit 109e547b3fda2539201c9831108e08b3f9d3dbe9
Author: Zenghui Yu <zenghui.yu@linux.dev>

WARNING: possible circular locking dependency detected

This commit addresses a circular locking dependency involving cpu_hotplug_l=
ock,
the MSI mutex, and the IOMMU group mutex in virtio_pci. It caches the Linux=
 IRQ
number in virtio_pci_vq_info to avoid calling pci_irq_vector() and taking t=
he
MSI mutex under the cpu_hotplug_lock.

> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_p=
ci_common.c
> index b90c174450b20..df2774fb6d845 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c

[ ... ]

> @@ -224,6 +224,16 @@ static struct virtqueue *vp_setup_vq(struct virtio_d=
evice *vdev, unsigned int in
>  		goto out_info;
> =20
>  	info->vq =3D vq;
> +
> +	/*
> +	 * Cache the Linux IRQ number so that later users (e.g.
> +	 * vp_set_vq_affinity() from cpu hotplug locked contexts)
> +	 * don't have to take the MSI mutex via pci_irq_vector().
> +	 */
> +	info->virq =3D 0;
> +	if (msix_vec !=3D VIRTIO_MSI_NO_VECTOR)
> +	info->virq =3D pci_irq_vector(vp_dev->pci_dev, msix_vec);

[Severity: Low]
This isn't a bug, but is the body of this if-statement in vp_setup_vq()
missing a tab of indentation?

> +
>  	if (callback) {
>  		spin_lock_irqsave(&vp_dev->lock, flags);
>  		if (!vp_is_slow_path_vector(msix_vec))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/98f2f4f9-a7fe-413e-=
a366-7bed08290697@linux.dev?part=3D1
