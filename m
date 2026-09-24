Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C733EFFA6
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267021; cv=none; b=mBWb/tI8IF91Ym2hO6AVgJeqrndek3kPTE3Q67SarDrAtAXH4zX+KUah2z9beCMgRv606l4SwoeHQNtB5juSwLiorylxvySuUr2o02/3/WgwALXK50HFUYvYMTB7paNAflWWc/c5Uk4LuQlAsW7eRuE1ndgyJHMLoTHRJ0e0Rbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267021; c=relaxed/simple;
	bh=wttwUUNoMX7XXNplE0WIVLpN8SUpwWxyeQj3a/hWLKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qa+7lusj+boLVcARdJIuxJqRC0012OMTnVG9Vrk6K2hDqwZuRMFr/iU9g0T28IpeCqGwR5BGg49/7bRZ5xmM9c7pgZS2FtQBtdminPYD12hJUeVQMxTIuzIuswcQ0bo0xmXRq1Q4OlkouMf6Yp9t0mayALIokL4GPahsBjhDqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTvJFQ/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTvJFQ/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7888C1F000FF;
	Thu, 24 Sep 2026 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267019;
	bh=3dq7MV6F70X/8cbU7TeSJzTklNquav9qACx96LCTswo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTvJFQ/SNTxvc8i2cQMUfLbCOPGGZIqxGbIMmRoO0OrQI8ffnWwn/gW8igHZ8jSDC
	 +R1uoGJ+9iBA0v+uqL5OkVpLgqNCEVPvCy8KYWFgl3TqX3sJ5RLciFx2Bf9gHms5HQ
	 jk80ai6L4VHfGDExAROIhgT4xmpH6dEiFcYCDDiq3kDNPI//DV4V5RSxMcwI5cuF38
	 s3XPSMSBU2RBjYzBYH4W323WJ8W/PRdLpTRhhkol7nd4wx/bQbj4dgsW60xxwA6Ib+
	 ElB7g+dRPX/Erm3kEj/3b273wY0r+ruK1u/DZqIzH6LfJIlbh8tVh9ReeH0z7nNnH0
	 F9+tG/r9TrmJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] virtio-usb: add protocol header and skeleton
 dual-role driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Skalkin" <igor.skalkin@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260924160907.145405-2-igor.skalkin@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-2-igor.skalkin@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:23:39 +0000
Message-Id: <20260924162339.7888C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] usb: virtio_usb Kconfig allows built-in driver with modular gadget=
 subsystem
- [Medium] virtio-usb: 16-bit port ID in device UAPI structures truncates 3=
2-bit index
- [Medium] virtio-usb: missing bounds check on untrusted nports causes huge=
 allocation
- [Low] virtio-usb: redundant USB prefix in UAPI SuperSpeed enum constant
- [Low] virtio-usb: missing error check after virtio_find_vqs() copies stal=
e pointer
--

commit 326b99edf62be9a25cd868d49b2b33423f8607c9
Author: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>

virtio-usb: add protocol header and skeleton dual-role driver

Add the virtio_usb device and virtqueue-wrapper skeleton, the protocol head=
er
shared with the vhost gadget driver and userspace backend, and probe()/remo=
ve()
plumbing with no role support yet.

> diff --git a/drivers/usb/virtio_usb/Kconfig b/drivers/usb/virtio_usb/Kcon=
fig
> new file mode 100644
> index 0000000000000..bd377b9cbb43a
> --- /dev/null
> +++ b/drivers/usb/virtio_usb/Kconfig
> @@ -0,0 +1,21 @@
> +config USB_VIRTIO
> +	tristate "Virtio USB device support"
> +	depends on USB_SUPPORT && VIRTIO
> +	depends on USB || USB_GADGET
> +	depends on USB if !USB_GADGET
> +	depends on USB_GADGET if !USB

[Severity: High]
Does this logic allow CONFIG_USB_VIRTIO to be built-in while the gadget
subsystem is modular?

If CONFIG_USB=3Dy and CONFIG_USB_GADGET=3Dm, it looks like 'depends on USB =
if
!USB_GADGET' evaluates to ignored, permitting CONFIG_USB_VIRTIO=3Dy. Because
device.o is unconditionally compiled into the driver, could this cause
undefined references to modular gadget APIs from built-in code, breaking
the vmlinux link?

[ ... ]

> diff --git a/drivers/usb/virtio_usb/controller.c b/drivers/usb/virtio_usb=
/controller.c
> new file mode 100644
> index 0000000000000..2fc6f502b48f3
> --- /dev/null
> +++ b/drivers/usb/virtio_usb/controller.c

[ ... ]

> +static int virtio_usb_find_vqs(struct virtio_usb *vusb)
> +{
> +	unsigned int nvqs =3D vusb->nvqs, i;
> +	struct virtqueue **vqs =3D NULL;
> +	int rc =3D -ENOMEM;
> +
> +	vqs =3D kcalloc(nvqs, sizeof(void *), GFP_KERNEL);
> +	if (!vqs)
> +		return -ENOMEM;
> +
> +	struct virtqueue_info *vqs_info =3D
> +		kcalloc(nvqs, sizeof(*vqs_info), GFP_KERNEL);
> +	if (!vqs_info) {
> +		rc =3D -ENOMEM;
> +		goto on_exit;
> +	}
> +	for (i =3D 0; i < nvqs; i++) {
> +		vqs_info[i].name =3D vusb->vqueues[i].name;
> +		vqs_info[i].callback =3D vusb->vqueues[i].callback;
> +	}
> +	rc =3D virtio_find_vqs(vusb->vdev, nvqs, vqs, vqs_info, NULL);
> +
> +	kfree(vqs_info);
> +
> +	for (i =3D 0; i < nvqs; i++) {
> +		vusb->vqueues[i].vqueue =3D vqs[i];
> +		spin_lock_init(&vusb->vqueues[i].lock);
> +	}

[Severity: Low]
Is there a missing error check for 'rc' here?

If virtio_find_vqs() fails and returns an error code, the code seems to fall
through to the loop and blindly assign vusb->vqueues[i].vqueue =3D vqs[i]
using uninitialized or dangling pointers from the vqs array before exiting
via 'on_exit'.

Should there be an 'if (rc) goto on_exit;' before the loop?

> +on_exit:
> +	kfree(vqs);
> +	return rc;
> +}

[ ... ]

> +static int virtio_usb_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_usb *vusb;
> +	unsigned int nvqs =3D 0;
> +	int rc =3D 0;
> +
> +	vusb =3D devm_kzalloc(&vdev->dev, sizeof(*vusb), GFP_KERNEL);
> +	if (!vusb)
> +		return -ENOMEM;
> +
> +	vusb->vdev =3D vdev;
> +	vdev->priv =3D vusb;
> +
> +	virtio_cread_le(vdev, struct virtio_usb_config, ports, &vusb->nports);
> +
> +	vusb->vports =3D devm_kcalloc(&vdev->dev, vusb->nports,
> +				    sizeof(*vusb->vports), GFP_KERNEL);

[Severity: Medium]
Does this allocation need a bounds check?

The untrusted value 'vusb->nports' is read directly from the device config
space and passed to devm_kcalloc() with GFP_KERNEL.

Since there is no architectural cap checked, could a malicious host or
hypervisor supply a massive value (e.g., 100M) and trigger OOM killer
activity or large allocation warnings?

[ ... ]

> diff --git a/include/uapi/linux/virtio_usb.h b/include/uapi/linux/virtio_=
usb.h
> new file mode 100644
> index 0000000000000..b9dc448e38ef6
> --- /dev/null
> +++ b/include/uapi/linux/virtio_usb.h

[ ... ]

> +enum {
> +	VIRTIO_USB_SPEED_UNKNOWN =3D 0,
> +	VIRTIO_USB_SPEED_LOW,
> +	VIRTIO_USB_SPEED_FULL, /* usb 1.1 */
> +	VIRTIO_USB_SPEED_HIGH, /* usb 2.0 */
> +	VIRTIO_USB_SPEED_WIRELESS, /* wireless (usb 2.5) */
> +	VIRTIO_USB_USB_SPEED_SUPER, /* usb 3.0 */

[Severity: Low]
Is the "USB" prefix redundant here?

This defines VIRTIO_USB_USB_SPEED_SUPER instead of VIRTIO_USB_SPEED_SUPER,
breaking naming consistency and forcing userspace to use the flawed macro
name.

> +	VIRTIO_USB_SPEED_SUPER_PLUS, /* usb 3.1 */
> +};

[ ... ]

> +struct virtio_usb_dev_cmd_hdr {
> +	__le32 code; /* VIRTIO_USB_CMD_DEV_XXX */
> +	__le16 port; /* Port ID */
> +	__le16 endpoint; /* Endpoint ID */
> +};

[Severity: Medium]
Will this 16-bit port ID correctly route commands for all virtual ports?

Since 'virtio_usb_config.ports' and host UAPI structures define the port
count and IDs as 32-bit (__le32), a 16-bit port field here silently
truncates the index for any port >=3D 65536.

[ ... ]

> +struct virtio_usb_request {
> +	__le64 tag;
> +	__le16 port; /* Port ID */
> +	__le16 endpoint; /* Endpoint ID */
> +	__le16 transfer_type; /* VIRTIO_USB_EP_XXX */
> +	__le16 transfer_flags; /* VIRTIO_USB_FLAG_XXX */

[Severity: Medium]
Similar to 'virtio_usb_dev_cmd_hdr' above, does this 16-bit port ID truncate
the 32-bit port index?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924160907.1454=
05-1-igor.skalkin@oss.qualcomm.com?part=3D1
