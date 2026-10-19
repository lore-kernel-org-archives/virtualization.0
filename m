Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459855C9F8
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421359; cv=none; b=fqMvQ6kc1oA5yLEHQxHzT3UD7IhQBLab6xAQuJjKi9Zmn2xHq1q0seQmsTPhy0RJroes07PMrTd9R/h3N99Y+5GZtby6PQPk+nrY7pQmKXEuzs0ZfBUXxKIBW8Oh7WZteev4blMqvemeqA0BocISyBWCBQl6ZSqpRWJHVFtkN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421359; c=relaxed/simple;
	bh=ZZUxXEfSMKz0ePs2kA2veetKdseAuzepMMNKidcJ/Ns=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HA2/TUWz5+BvCdBSVIK1VUPASlvxDUO3M8KHHnMGeMA/YPAzlFm3yE2VyfgN2gxdHwduTlk4U7+mINPT5XrFF2qgpNQwDxW0J5p5yKhiaxRjM2fRreWq95wobk8rHlU5sI6hCzg8gD2H9zEGkJazo2LFEfe24QJgKFyVzi8uDGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/yzK5y3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/yzK5y3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E391E1F000C4;
	Mon, 19 Oct 2026 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421358;
	bh=PPtu/XTFURTDXk92hcEr1SRYcB5uzFacGgCebyOusz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a/yzK5y3f7UldJ3QCzPW7mBnZQFFkW58dM+eQVrKw2rBzQqhlFFgvOawqdyOVBgN2
	 KlupI6fG+hgzVlO8QLtHPhOmqfHKtDrW3z50SGcBbsIJjaJ4SqhGDUeREiW3gI74hf
	 8RFnb/sr7PWJSIK/yW6ZTizu8WuMDGFuM7/Kx10Am9dOytEiA5A91ht97pJRhgaJIo
	 S+aSoTDjgtVM3e9H24Fpaxq1Zicr3Duol9EZAMZW/rfxU8wCWGikVU/8rQ4rYo0lxV
	 hS5AbO18LSqm/dxLPtv5PdPbnvI3RXjvIVqcEVzbjCFGu3vBQyTOBXGAyYnyZZFqZA
	 iuF5jtrnc5/Uw==
Message-ID: <sashiko-outbox-177512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] vdpa: alibaba: add missing
 MODULE_DEVICE_TABLE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261019135441.1420968-253-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-253-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:49:17 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vdpa: alibaba: exporting generic virtio-net PCI ID breaks virtio_p=
ci binding
--

commit 56e367c85e2f18386c5a07775af8ff1e3da0457f
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

vdpa: alibaba: add missing MODULE_DEVICE_TABLE()

This commit adds MODULE_DEVICE_TABLE(pci, eni_pci_ids) to the Alibaba ENI
vDPA driver so that PCI module alias entries are generated for automatic
module loading.

> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_v=
dpa.c
> index e476504db0c82..fd6fdba460945 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -545,6 +545,7 @@ static struct pci_device_id eni_pci_ids[] =3D {
>  			 VIRTIO_ID_NET) },
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(pci, eni_pci_ids);
> =20
>  static struct pci_driver eni_vdpa_driver =3D {
>  	.name		=3D "alibaba-eni-vdpa",

[Severity: High]
Will exporting eni_pci_ids via MODULE_DEVICE_TABLE() cause eni_vdpa to
auto-load on standard non-Alibaba x86 VMs and race with virtio_pci for
generic transitional or legacy virtio-net PCI devices?

In drivers/vdpa/alibaba/eni_vdpa.c, eni_pci_ids matches the generic
Virtio 0.9.5 / transitional Virtio 1.0 network device IDs rather than an
Alibaba-specific PCI ID:

drivers/vdpa/alibaba/eni_vdpa.c:
static struct pci_device_id eni_pci_ids[] =3D {
	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REDHAT_QUMRANET,
			 VIRTIO_TRANS_ID_NET,
			 PCI_SUBVENDOR_ID_REDHAT_QUMRANET,
			 VIRTIO_ID_NET) },
	{ 0 },
};

These are the same PCI IDs (vendor 0x1af4, device 0x1000, subvendor
0x1af4, subdevice 0x0001) exposed by default virtio-net-pci devices in
QEMU/KVM and matched by virtio_pci_id_table in
drivers/virtio/virtio_pci_common.c:

static const struct pci_device_id virtio_pci_id_table[] =3D {
	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
	{ 0 }
};
MODULE_DEVICE_TABLE(pci, virtio_pci_id_table);

Previously, omitting MODULE_DEVICE_TABLE() prevented eni_vdpa from
publishing a modalias for 1af4:1000, so it was only loaded when explicitly
requested by userspace on Alibaba instances. With MODULE_DEVICE_TABLE()
added, udev/kmod will auto-load eni_vdpa on any x86 guest with a
transitional or legacy virtio-net-pci device when CONFIG_ALIBABA_ENI_VDPA=
=3Dm
and CONFIG_VIRTIO_PCI=3Dm.

In eni_vdpa_probe(), there is no hardware check distinguishing an Alibaba
ENI device from a standard QEMU virtio-net-pci device:

drivers/vdpa/alibaba/eni_vdpa.c:eni_vdpa_probe() {
    ...
	ldev =3D &eni_vdpa->ldev;
	ldev->pci_dev =3D pdev;

	ret =3D vp_legacy_probe(ldev);
	if (ret) {
		ENI_ERR(pdev, "failed to probe legacy PCI device\n");
		goto err;
	}
    ...
}

If eni_vdpa probes the PCI device before virtio_pci, eni_vdpa_probe() ->
vp_legacy_probe() succeeds and claims the device into the vDPA subsystem
via vdpa_register_device(), preventing virtio_pci from binding and causing
the guest to lose its standard virtio_net network interface.

Was MODULE_DEVICE_TABLE() intentionally omitted here to avoid hijacking
generic legacy/transitional virtio-net PCI devices from virtio_pci?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-253-sashal@kernel.org?part=3D1
