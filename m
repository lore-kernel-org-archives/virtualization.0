Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC804393DE6
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115851; cv=none; b=UnrK4PMg1n1NpxmmeH7OUVQ0bSF/VgalH329U3kQXQBruoJtD9YhqMd/RYLAeiYbLsLD80EhcX6jLo1i7DF03imz/QOifkiKNPxtxy36l8+W3EqGAC+1+mc2N08mJNPHnZzDq6ULfPlMtVUDKuCqYTssHQf+Z1g2dfnTViUGsbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115851; c=relaxed/simple;
	bh=EKdSBjEUuU45itwlowRX3+zb54ZdrXb3joGWmVhRNes=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gta3tr68cLK9bHwwqreBjJY1ovUpNkS7dKVSpmJRC6MIS4H3QUu5b/H94iC3g1bdbWzl8QjR5fI0K9a26htgRLWPwDsE9J1b2iPXrm5rapYlp4wL/h5+W6Tu1mqinevon7I5r7sgsJZzIYeBArihC4OYh4iOVLn2lIoUbPsSBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B53mHCoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B53mHCoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590941F0089A;
	Sun,  4 Oct 2026 12:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791115849;
	bh=yzz42xnJYOR58R8GdLBZ58bybo5cd4s62o3r0LnGx/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B53mHCojOTumfhPht8SPs2cKC1dKoHdJ0f/khqdKcTBBhaXUqRzEex1z/KjQBqxRb
	 aMYtmYfkMGgNkvDupEr/TlvLEL23Hz/dwpcU8NWYfTw3Mr04VkGT5otEbBJu5jNX/i
	 aOLvPsLQfso0wYIiSHFryRE85V1ajDvKfBDpVuzvrQW3KLThjaBW9cly3hJHvub7m9
	 2VuhL4Z7DlxltKDutqWHtVUDNIBKH8bGDD6T62guAmWA62AmFAEANEX4Qh1LjDFnx+
	 35eT3ss/SSiCKEzhsUXVTdz9r02Y+xrclX4+iXFyGZa5yNwnJhrF+pt48nFBE9Y3YU
	 qKepKwcqRSBWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] iommu/virtio: batch the mapping replay on domain
 attach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_ED730B6C7A1FCF7E8C5BA1E836D75257620A@qq.com>
References: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
 <tencent_ED730B6C7A1FCF7E8C5BA1E836D75257620A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:10:48 +0000
Message-Id: <20261004121049.590941F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] iommu/virtio: memory leak of queued requests on device removal
--

commit db185ffd41ba01e7309f7ee2d8c108a5d39c6450
Author: Anlai Lu <agicy@qq.com>

iommu/virtio: batch the mapping replay on domain attach

This commit optimizes the domain attach process by queueing all mapping
requests and waiting for them once, rather than sending them synchronously
one by one. This significantly reduces the IRQ-off window and attach time
when dealing with a large number of mappings.

> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 4e578d4255f6b..7b883f59221f5 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
[ ... ]
> @@ -656,23 +698,57 @@ static int viommu_domain_map_identity(struct viommu=
_endpoint *vdev,
>  }
> =20
>  /*
> - * viommu_replay_mappings - re-send MAP requests
> + * viommu_replay_mappings - send every mapping of the domain again
[ ... ]
> +	while (!done) {
> +		struct viommu_mapping *mapping;
> +		struct virtio_iommu_req_map map;
[ ... ]
> +		ret =3D viommu_add_req(vdomain->viommu, &map, sizeof(map), &status);
> =20
> -		ret =3D viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> -		if (ret) {
[ ... ]
> +		if (mapping->iova.last =3D=3D ULONG_MAX)
> +			done =3D true;
> +		else
> +			next_iova =3D mapping->iova.last + 1;
> +		spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
> =20
> -		node =3D interval_tree_iter_next(node, 0, -1UL);
> +		if (ret)
> +			break;
>  	}
> -	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
> =20
> -	return ret;
> +	/* Wait for all of them outside the lock: this is the batched drain */
> +	viommu_sync_req(vdomain->viommu);

[Severity: Medium]
If the virtio-iommu device is removed (e.g., via hot-unplug or driver unbin=
d)
while we are queuing these batched requests, could this leak the dynamically
allocated struct viommu_request objects?

Looking at viommu_sync_req(), it short-circuits when the device is removed
without draining the list:

drivers/iommu/virtio-iommu.c:viommu_sync_req() {
	...
	if (!viommu_device_live(viommu)) {
		spin_unlock_irqrestore(&viommu->request_lock, flags);
		return 0;
	}
	...
}

Any queued requests would remain in viommu->requests. Since viommu_remove()
tears down the virtqueues and sets viommu->removed =3D true, but does not
iterate over the viommu->requests list to free the pending elements, it
appears these requests would permanently leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_85AC6E749F6=
A912B7BB9FF360F8ECB3F5C09@qq.com?part=3D6
