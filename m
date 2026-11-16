Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798666;
	b=N2+ghvfa985KGnIoiSf1vpeKFdIXC6ipy5+qzAO2QnhAF3srO0FWnkG8zLUh8H93SmbU
	 fJikM1dTigzeGWvzVKxY4fPAm0NfpwBXtRt+A4h8RFtk6RyBi1utpgeBh7J2oWZNWYxXd
	 oPYkDyPQnowsjcETFtI/W7Q5w9XdxzfBv6iMPR7b+7EXoHjVPYJmEoaoU3c8CVac5voL7
	 NNffxd7vEcnfFU/dlnITl8uWn8mN++h/sX61PgkhD9szCHocNC7OnzfXCzVoKgInRoT0d
	 pINYWVVHum5a1a0bNs4wIUmBJGWnBXU44kvfNWSc7PKZBRjQ2F9RrGCrrLWPWJWkpOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798666;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qBWYz5KAYjCi9U50zw66rCvaeU1kmz/7YxXW/PYxMes=;
	b=rCtD9G1J1OojM1MjqMo1UwaalQfmdi2Cd/boS8G0G5FWvFHlvLBTgHO0ROYYTmny0gy1
	 AxU59x4Z1R4WzyrrIEHkEBjG1yP1VcAlseJv58CV/1LhN0tmHhQBa1ktHhXghMQMKwOYV
	 f/3nnpYEvus2Yk4yhUQ4GqgKS00vIfaQh6zBB0bh2JFavqsMBCFGgJOOQy0i4Z6Oy7Dcs
	 8w6gy+r9CsdW8p8PDGOwV3RJ94kbtA1eLirIlsrW3jRgs0J5a+HrKMYLtIJ3bZUTnN1uu
	 0ibPsoRzPgoON4DGU4GApAGL9VWVwi8bemD4snVuZzt75rPmjLpPPKS8pj4dpoYMPaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kaf8XCX4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8687606A33B
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kaf8XCX4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850A61F000C6;
	Mon, 16 Nov 2026 03:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794798665;
	bh=qBWYz5KAYjCi9U50zw66rCvaeU1kmz/7YxXW/PYxMes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kaf8XCX4BbQvOyS2M46F58Xo8MvGaEWCnd7I1Ry+MKYXVJvSSCjYxfcUjzRZDwEhA
	 3uP18yWYjgg4TJxOrFCjluaEy2IlqrV1R0luQ6EPDq9ohSfT+V44Uir+bpE4jGgmRu
	 wpFrhHgh92A+EujvDV4ZSTZwU4jxl8DJ7hllw4oStIYSDc9Bdqn+gMmZqak4VH073t
	 9/T+bkrO27jWTj5oDnUTrLUwJbfmEmTtCvCbs5dcEiltyDv+TCRM5HoG172QuXzswT
	 aPSMyK9Gm6jxuH+CvKj5bbFRhvb5bZ9Ejycr7MMAiRgSBnyB1CaCgAtuIGcfELLdnM
	 7QAkXhA0RqkiA==
Message-ID: <sashiko-outbox-216109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Wait for device reset to complete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116030152.1704527-2-oss.patchbox@gmail.com>
References: <20261116030152.1704527-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 03:11:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] vdpa/vp_vdpa: infinite loop in vp_vdpa_reset() on surprise
  removal or fault
--

commit 877ae67f265800ae2b653bd6932dd2f6fa55c959
Author: Yuho Choi <oss.patchbox@gmail.com>

vdpa/vp_vdpa: Wait for device reset to complete

This commit polls device_status in vp_vdpa_reset() until it reads back 0
before freeing the MSI-X IRQs and returning.

> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 646efd9384fba..eba82ff253ea3 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
[ ... ]
> @@ -236,6 +237,9 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
>  	u8 s =3D vp_vdpa_get_status(vdpa);
> =20
>  	vp_modern_set_status(mdev, 0);
> +	/* Wait for the reset to complete */
> +	while (vp_modern_get_status(mdev))
> +		fsleep(1000);

[Severity: High]
Can this loop sleep forever if the PCI device is surprise-removed or
fails to reset?

On PCI hot-unplug, vp_vdpa_remove() unregisters the vDPA device, which
triggers vdpa_reset() -> vp_vdpa_reset() while MMIO reads from
cfg->device_status return 0xff on every iteration.  Without a timeout or
a check for pci_device_is_present(mdev->pci_dev), vp_vdpa_reset() hangs
indefinitely while holding vdpa->cf_lock and blocks vp_vdpa_free_irq()
and device teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116030152.1704=
527-2-oss.patchbox@gmail.com?part=3D1
