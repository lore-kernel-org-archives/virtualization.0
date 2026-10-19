Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E247085F
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421441; cv=none; b=HOXTDEtVYpwZSOpCKEf/KHYDokwX7Io89rs0l+5cSDSVaEvQ76+e5E20BXsqjAwQQobF4YCine8+SNAhbTq0p99ZXO4JMzfWHv4bGtqa6PtYPAmk23gr34BVevBX7TfERCtg1kaWDxZMZ2W/prPxjcf1rd2if/yehaZUNgAZPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421441; c=relaxed/simple;
	bh=5JL/rrBUKU3WMPVLuxe1+YtfoI7DIrNwlHEugCQfqSM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mmVVE90t61NqZupPnKQII0pnEPF9zodspqb+ImeUH0UE69BAvfubrn+8L39QIfF3OuSK4PRjFDv7yJNTdHr35rp58NewoocW/DxRfQcLhbpq+eqARbog9LvOXaBZwCblmXhZOlz1fNQUFjjRYCRTgV9VkwGAeR4zbyY+Mj0unTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSsN9VIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSsN9VIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281341F000C4;
	Mon, 19 Oct 2026 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421440;
	bh=YuhKA+E2dQIJ0zrndTuDg9BbfH7W4EhdwUuBAiukJC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KSsN9VIJ3j59nmhDGZicYVrKZa9UTyDm7C3Q/Nh7DPm2l2NCwmxm+lmvcBlve0Z5k
	 5ap0bv5DBao6jmu/SPRi5lwYodmTW/BlMSga/qVmWF0jFAVCs1G1Zf/fBEa61NEPpn
	 oPDhFYC2N0IaH1rKrAyPW+7kletO4saxKpV7jZFQ48RS2uy3Kp2jO2y+J4t/5JoI3r
	 IKo6fGJsw6a3fzYpR/VLilrg5wyVxnL2G98HTmeFYM4ww9MVVBRO8JuccKp0hEN6nE
	 3JDY9sRJfEPG7LH8kV6A8F2yuxQckDCI/mCC6x/xGOs7jmj/ADTNpxbpupHCqeyCOw
	 j/FoVCIz88z4g==
Message-ID: <sashiko-outbox-177520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] vdpa: octeon_ep: add missing
 MODULE_DEVICE_TABLE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261019135441.1420968-265-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-265-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:50:39 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vdpa: octeon_ep: MODULE_DEVICE_TABLE() conflicts with octeon_ep an=
d Kconfig
--

commit 2202a6588d5755d6dbbded2b962a2580a97810a5
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

vdpa: octeon_ep: add missing MODULE_DEVICE_TABLE()

This commit adds a MODULE_DEVICE_TABLE(pci, octep_pci_vdpa_map) entry to
drivers/vdpa/octeon_ep/octep_vdpa_main.c to generate PCI module aliases for
automatic module loading.

> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octe=
on_ep/octep_vdpa_main.c
> index 9e8d07078606f..3c7245ff32507 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -883,6 +883,7 @@ static struct pci_device_id octep_pci_vdpa_map[] =3D {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_VDPA_DEVID_CN103K_VF) },
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(pci, octep_pci_vdpa_map);

[Severity: High]
Was MODULE_DEVICE_TABLE(pci, octep_pci_vdpa_map) intentionally omitted here?

In drivers/vdpa/Kconfig, config OCTEONEP_VDPA specifies:

config OCTEONEP_VDPA
	tristate "vDPA driver for Octeon DPU devices"
	depends on m
	depends on PCI_MSI
	help
	  This is a vDPA driver designed for Marvell's Octeon DPU devices.
	  This driver enables the offloading of the VirtIO dataplane to an
	  Octeon DPU device.
	  Please note that this driver must be built as a module and it
	  cannot be loaded until the Octeon emulation software is running.

Exporting octep_pci_vdpa_map via MODULE_DEVICE_TABLE() causes udev/kmod to
autoload octep_vdpa during boot or PCI enumeration before the Octeon
emulation software is running. If OCTEP_EPF_RINFO(0) is 0 because the
emulation software has not initialized the rings yet,
octep_vdpa_probe() -> octep_vdpa_probe_pf() -> octep_vdpa_pf_setup() fails
with -EINVAL:

drivers/vdpa/octeon_ep/octep_vdpa_main.c:octep_vdpa_pf_setup() {
	...
	addr =3D octpf->base[OCTEP_HW_MBOX_BAR];
	val =3D readq(addr + OCTEP_EPF_RINFO(0));
	if (val =3D=3D 0) {
		dev_err(&pdev->dev, "Invalid device configuration\n");
		return -EINVAL;
	}
	...
}

In addition, all six PCI device IDs in octep_pci_vdpa_map (0x177d:0xb900,
0xb903, 0xba00, 0xba03, 0xbd00, and 0xbd03 with PCI_ANY_ID for subvendor,
subdevice, and class) are identical to the PCI device IDs already exported
via MODULE_DEVICE_TABLE() by the in-tree Ethernet PF and VF drivers:

drivers/net/ethernet/marvell/octeon_ep/octep_main.c:
static const struct pci_device_id octep_pci_id_tbl[] =3D {
	...
	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN10KA_PF)},
	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CNF10KA_PF)},
	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CNF10KB_PF)},
	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN10KB_PF)},
	{0, },
};
MODULE_DEVICE_TABLE(pci, octep_pci_id_tbl);

drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c:
static const struct pci_device_id octep_vf_pci_id_tbl[] =3D {
	...
	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN10KA_VF)},
	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CNF10KA_VF)},
	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CNF10KB_VF)},
	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN10KB_VF)},
	{0, },
};
MODULE_DEVICE_TABLE(pci, octep_vf_pci_id_tbl);

Neither octep_vdpa_probe_pf() nor octep_vdpa_probe_vf() checks whether the
device is running vDPA firmware rather than standard NIC firmware before
claiming the PCI device. In octep_vdpa_pf_setup(), OCTEP_EPF_RINFO(0) is
also non-zero in standard NIC mode, causing it to shrink BAR 4 via
octep_vdpa_pf_bar_shrink() and succeed, while octep_vdpa_probe_vf() queues
octep_vdpa_setup_task and returns 0 unconditionally:

drivers/vdpa/octeon_ep/octep_vdpa_main.c:octep_vdpa_probe_vf() {
	...
	INIT_WORK(&mgmt_dev->setup_task, octep_vdpa_setup_task);
	schedule_work(&mgmt_dev->setup_task);
	dev_info(&pdev->dev, "octep vdpa mgmt device setup task is queued\n");

	return 0;
}

Could publishing MODULE_DEVICE_TABLE(pci, octep_pci_vdpa_map) cause
octep_vdpa to autoload prematurely and race with octeon_ep and
octeon_ep_vf to claim standard NIC PF and VF devices?

> =20
>  static struct pci_driver octep_pci_vdpa =3D {
>  	.name     =3D OCTEP_VDPA_DRIVER_NAME,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-265-sashal@kernel.org?part=3D1
