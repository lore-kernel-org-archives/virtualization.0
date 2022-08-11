Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9582AC25B0C
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 13:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30E08830E2;
	Thu, 11 Aug 2022 13:32:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30E08830E2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ue4vpGV5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ec77Uli7W0Gk; Thu, 11 Aug 2022 13:32:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E384830C2;
	Thu, 11 Aug 2022 13:32:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E384830C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECCC7C0032;
	Thu, 11 Aug 2022 13:32:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 545CBC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F94C830C2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:32:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F94C830C2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GJraaLqctZ3e
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:32:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64603830C0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 64603830C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660224734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odp95haNMb4xtSH9uF1GucOHS3sHvyl+wPc5kWmZ0oY=;
 b=Ue4vpGV5q5+omQsyGjZDkidcE5JkrdQdAjLBBKypwhcdBimWuzPkvP1gvPPw+F/YETQEnB
 Aqzt4BBYGY+OezetcSfFS+OBZ49T8vjcZKc5PYGV77WJ/mgeLeRAjc0PeXxtMOm/nF6L6O
 X9KKW0mfE1vvva615ak1vscxWOc5KrU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-445-8BvN_ApWNR-393OlS3Jubw-1; Thu, 11 Aug 2022 09:32:12 -0400
X-MC-Unique: 8BvN_ApWNR-393OlS3Jubw-1
Received: by mail-ed1-f70.google.com with SMTP id
 v19-20020a056402349300b0043d42b7ddefso10825979edc.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 06:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=odp95haNMb4xtSH9uF1GucOHS3sHvyl+wPc5kWmZ0oY=;
 b=HULPJ9LW9npoVzVysi2MeWdR19ZQJv03q3AD9+toa+pa6v/hNhbcJ/ZtM7gmmHob1V
 JHPI6d75J20BNRqs9Yr/MSEVaBCIbxbsgZwQ1jIULQQEMbcs3NYWIyhYnrGhnipO2DhT
 hmy4ClbYqsVIt6v7yymSolBRREnyaR2TOn3UZe4DXQrdyUM/QSCD0cPfo/tijx/Lr3vx
 3HJzk5idQ6I/11GigGHjnjwtEWM9qqYgbZ5OXKsG3lGU3NfNgjJoVu0bE1+/MHbjhXV3
 s+V6G5x5iXY2knJ/yPHVyB0R70UU5n6qQMLOvf2Y+IhvPEdpnUAtCwebXi0WBrU6uEPL
 RvBw==
X-Gm-Message-State: ACgBeo06JnI9SzVih1T1BNA8+DZogWf0bjV+T3gx4CHqQfPzXd1IVVhG
 zp7KXmxB5slvSLhVfx7lOnqnAAHgkc7laNmPnzQYmqJzI6g9II2R+Geg+WtUL3yJUXwqEo5zaeN
 iiCzxNKAuxh4YRCreMesR+pKavhWsaMGHXxv1AfQqtQ==
X-Received: by 2002:a17:907:e90:b0:730:8f6b:c14e with SMTP id
 ho16-20020a1709070e9000b007308f6bc14emr23485746ejc.250.1660224730581; 
 Thu, 11 Aug 2022 06:32:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6qTPi9dqokNrvBAZGj1+t2CfwCG0QcGEEAZG5fp2Gxf57ChPcXXXjmLbmQXhncPQtn2sKXkw==
X-Received: by 2002:a17:907:e90:b0:730:8f6b:c14e with SMTP id
 ho16-20020a1709070e9000b007308f6bc14emr23485719ejc.250.1660224730149; 
 Thu, 11 Aug 2022 06:32:10 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 f26-20020a170906139a00b0072b55713daesm3532126ejc.56.2022.08.11.06.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 06:32:09 -0700 (PDT)
Date: Thu, 11 Aug 2022 09:32:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Subject: Re: [PATCH v4 2/2] docs: driver-api: virtio: virtio on Linux
Message-ID: <20220811092436-mutt-send-email-mst@kernel.org>
References: <20220810094004.1250-1-ricardo.canuelo@collabora.com>
 <20220810094004.1250-3-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
In-Reply-To: <20220810094004.1250-3-ricardo.canuelo@collabora.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-doc@vger.kernel.org, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, bagasdotme@gmail.com,
 kernel@collabora.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Aug 10, 2022 at 11:40:04AM +0200, Ricardo Ca=F1uelo wrote:
> Basic doc about Virtio on Linux and a short tutorial on Virtio drivers.
> =

> Signed-off-by: Ricardo Ca=F1uelo <ricardo.canuelo@collabora.com>

which tree is this for?

Applying: docs: driver-api: virtio: virtio on Linux
error: sha1 information is lacking or useless (MAINTAINERS).
error: could not build fake ancestor
Patch failed at 0001 docs: driver-api: virtio: virtio on Linux


> ---
>  Documentation/driver-api/index.rst            |   1 +
>  Documentation/driver-api/virtio/index.rst     |  11 ++
>  Documentation/driver-api/virtio/virtio.rst    | 144 ++++++++++++++
>  .../virtio/writing_virtio_drivers.rst         | 186 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  5 files changed, 343 insertions(+)
>  create mode 100644 Documentation/driver-api/virtio/index.rst
>  create mode 100644 Documentation/driver-api/virtio/virtio.rst
>  create mode 100644 Documentation/driver-api/virtio/writing_virtio_driver=
s.rst
> =

> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-ap=
i/index.rst
> index d3a58f77328e..30a3de452b1d 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -106,6 +106,7 @@ available subsections can be seen below.
>     vfio-mediated-device
>     vfio
>     vfio-pci-device-specific-driver-acceptance
> +   virtio/index
>     xilinx/index
>     xillybus
>     zorro
> diff --git a/Documentation/driver-api/virtio/index.rst b/Documentation/dr=
iver-api/virtio/index.rst
> new file mode 100644
> index 000000000000..528b14b291e3
> --- /dev/null
> +++ b/Documentation/driver-api/virtio/index.rst
> @@ -0,0 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D
> +Virtio
> +=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   virtio
> +   writing_virtio_drivers
> diff --git a/Documentation/driver-api/virtio/virtio.rst b/Documentation/d=
river-api/virtio/virtio.rst
> new file mode 100644
> index 000000000000..921758fc3b23
> --- /dev/null
> +++ b/Documentation/driver-api/virtio/virtio.rst
> @@ -0,0 +1,144 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _virtio:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Virtio on Linux
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Virtio is an open standard that defines a protocol for communication
> +between drivers and devices of different types, see Chapter 5 ("Device
> +Types") of the virtio spec `[1]`_. Originally developed as a standard
> +for paravirtualized devices implemented by a hypervisor, it can be used
> +to interface any compliant device (real or emulated) with a driver.
> +
> +For illustrative purposes, this document will focus on the common case
> +of a Linux kernel running in a virtual machine and using paravirtualized
> +devices provided by the hypervisor, which exposes them as virtio devices
> +via standard mechanisms such as PCI.
> +
> +
> +Device - Driver communication: virtqueues
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Although the virtio devices are really an abstraction layer in the
> +hypervisor, they're exposed to the guest as if they are physical devices
> +using a specific transport method -- PCI, MMIO or CCW -- that is
> +orthogonal to the device itself. The virtio spec defines these transport
> +methods in detail, including device discovery, capabilities and
> +interrupt handling.
> +
> +The communication between the driver in the guest OS and the device in
> +the hypervisor is done through shared memory (that's what makes virtio
> +devices so efficient) using specialized data structures called
> +virtqueues, which are actually ring buffers [#f1]_ of buffer descriptors
> +similar to the ones used in a network device:
> +
> +.. kernel-doc:: include/uapi/linux/virtio_ring.h
> +    :identifiers: struct vring_desc
> +
> +All the buffers the descriptors point to are allocated by the guest and
> +used by the host either for reading or for writing but not for both.
> +
> +Refer to Chapter 2.5 ("Virtqueues") of the virtio spec `[1]`_ for the
> +reference definitions of virtqueues and to `[2]`_ for an illustrated
> +overview of how the host device and the guest driver communicate.
> +
> +The :c:type:`vring_virtqueue` struct models a virtqueue, including the
> +ring buffers and management data. Embedded in this struct is the
> +:c:type:`virtqueue` struct, which is the data structure that's
> +ultimately used by virtio drivers:
> +
> +.. kernel-doc:: include/linux/virtio.h
> +    :identifiers: struct virtqueue
> +
> +The callback function pointed by this struct is triggered when the
> +device has consumed the buffers provided by the driver. More
> +specifically, the trigger will be an interrupt issued by the hypervisor
> +(see vring_interrupt()). Interrupt request handlers are registered for
> +a virtqueue during the virtqueue setup process (transport-specific).
> +
> +.. kernel-doc:: drivers/virtio/virtio_ring.c
> +    :identifiers: vring_interrupt
> +
> +
> +Device discovery and probing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +In the kernel, the virtio core contains the virtio bus driver and
> +transport-specific drivers like `virtio-pci` and `virtio-mmio`. Then
> +there are individual virtio drivers for specific device types that are
> +registered to the virtio bus driver.
> +
> +How a virtio device is found and configured by the kernel depends on how
> +the hypervisor defines it. Taking the `QEMU virtio-console
> +<https://gitlab.com/qemu-project/qemu/-/blob/master/hw/char/virtio-conso=
le.c>`__
> +device as an example. When using PCI as a transport method, the device
> +will present itself on the PCI bus with vendor 0x1af4 (Red Hat, Inc.)
> +and device id 0x1003 (virtio console), as defined in the spec, so the
> +kernel will detect it as it would do with any other PCI device.
> +
> +During the PCI enumeration process, if a device is found to match the
> +virtio-pci driver (according to the virtio-pci device table, any PCI
> +device with vendor id =3D 0x1af4)::
> +
> +	/* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
> +	static const struct pci_device_id virtio_pci_id_table[] =3D {
> +		{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
> +		{ 0 }
> +	};
> +
> +then the virtio-pci driver is probed and, if the probing goes well, the
> +device is registered to the virtio bus::
> +
> +	static int virtio_pci_probe(struct pci_dev *pci_dev,
> +				    const struct pci_device_id *id)
> +	{
> +		...
> +
> +		if (force_legacy) {
> +			rc =3D virtio_pci_legacy_probe(vp_dev);
> +			/* Also try modern mode if we can't map BAR0 (no IO space). */
> +			if (rc =3D=3D -ENODEV || rc =3D=3D -ENOMEM)
> +				rc =3D virtio_pci_modern_probe(vp_dev);
> +			if (rc)
> +				goto err_probe;
> +		} else {
> +			rc =3D virtio_pci_modern_probe(vp_dev);
> +			if (rc =3D=3D -ENODEV)
> +				rc =3D virtio_pci_legacy_probe(vp_dev);
> +			if (rc)
> +				goto err_probe;
> +		}
> +
> +		...
> +
> +		rc =3D register_virtio_device(&vp_dev->vdev);
> +
> +When the device is registered to the virtio bus the kernel will look
> +for a driver in the bus that can handle the device and call that
> +driver's ``probe`` method.
> +
> +It's at this stage that the virtqueues will be allocated and configured
> +by calling the appropriate ``virtio_find`` helper function, such as
> +virtio_find_single_vq() or virtio_find_vqs(), which will end up
> +calling a transport-specific ``find_vqs`` method.
> +
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +_`[1]` Virtio Spec v1.2:
> +https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html
> +
> +Check for later versions of the spec as well.
> +
> +_`[2]` Virtqueues and virtio ring: How the data travels
> +https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-trave=
ls
> +
> +.. rubric:: Footnotes
> +
> +.. [#f1] that's why they may be also referred as virtrings.
> diff --git a/Documentation/driver-api/virtio/writing_virtio_drivers.rst b=
/Documentation/driver-api/virtio/writing_virtio_drivers.rst
> new file mode 100644
> index 000000000000..3e5e4648dd5e
> --- /dev/null
> +++ b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
> @@ -0,0 +1,186 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _writing_virtio_drivers:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Writing Virtio Drivers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document serves as a basic guideline for driver programmers that
> +need to hack a new virtio driver or understand the essentials of the
> +existing ones. See :ref:`Virtio on Linux <virtio>` for a general
> +overview of virtio.
> +
> +
> +Driver boilerplate
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +As a bare minimum, a virtio driver needs to register in the virtio bus
> +and configure the virtqueues for the device according to its spec, the
> +configuration of the virtqueues in the driver side must match the
> +virtqueue definitions in the device. A basic driver skeleton could look
> +like this::
> +
> +	#include <linux/virtio.h>
> +	#include <linux/virtio_ids.h>
> +	#include <linux/virtio_config.h>
> +	#include <linux/module.h>
> +
> +	/* device private data (one per device) */
> +	struct virtio_dummy_dev {
> +		struct virtqueue *vq;
> +	};
> +
> +	static void virtio_dummy_recv_cb(struct virtqueue *vq)
> +	{
> +		struct virtio_dummy_dev *dev =3D vq->vdev->priv;
> +		char *buf;
> +		unsigned int len;
> +
> +		buf =3D virtqueue_get_buf(dev->vq, &len);
> +		/* spurious callback? */
> +		if (!buf)
> +			return;

most drivers need to do this in a loop, this code is only valid if
there's just 1 buf in flight - unusual.


> +
> +		/* Process the received data */
> +	}
> +
> +	static int virtio_dummy_probe(struct virtio_device *vdev)
> +	{
> +		struct virtio_dummy_dev *dev =3D NULL;
> +
> +		/* initialize device data */
> +		dev =3D kzalloc(sizeof(struct virtio_dummy_dev), GFP_KERNEL);


I dislike how we set dev to NULL and immediately to a different value
just below.

> +		if (!dev)
> +			return -ENOMEM;
> +
> +		/* the device has a single virtqueue */
> +		dev->vq =3D virtio_find_single_vq(vdev, virtio_dummy_recv_cb, "input");
> +		if (IS_ERR(dev->vq)) {
> +			kfree(dev);
> +			return PTR_ERR(dev->vq);
> +
> +		}
> +		vdev->priv =3D dev;
> +
> +		return 0;

what is missing here is registration with Linux core.
depending on device you might need a call to device_ready, too.



> +	}
> +
> +	static void virtio_dummy_remove(struct virtio_device *vdev)
> +	{
> +		struct virtio_dummy_dev *dev =3D vdev->priv;
> +
> +		/*
> +		 * Disable vq interrupts: equivalent to
> +		 * vdev->config->reset(vdev)
> +		 */
> +		virtio_reset_device(vdev);
> +

you highly likely need to detach unused buffers from vqs here.


> +		/* remove virtqueues */
> +		vdev->config->del_vqs(vdev);
> +
> +		kfree(dev);
> +	}
> +
> +	static const struct virtio_device_id id_table[] =3D {
> +		{ VIRTIO_ID_DUMMY, VIRTIO_DEV_ANY_ID },
> +		{ 0 },
> +	};
> +
> +	static struct virtio_driver virtio_dummy_driver =3D {
> +		.driver.name =3D	KBUILD_MODNAME,
> +		.driver.owner =3D	THIS_MODULE,
> +		.id_table =3D	id_table,
> +		.probe =3D	virtio_dummy_probe,
> +		.remove =3D	virtio_dummy_remove,
> +	};
> +
> +	module_virtio_driver(virtio_dummy_driver);
> +	MODULE_DEVICE_TABLE(virtio, id_table);
> +	MODULE_DESCRIPTION("Dummy virtio driver");
> +	MODULE_LICENSE("GPL");
> +
> +The device id ``VIRTIO_ID_DUMMY`` here is a placeholder, virtio drivers
> +should be added only for devices that are defined in the spec, see
> +include/uapi/linux/virtio_ids.h. Device ids need to be at least reserved
> +in the virtio spec before being added to that file.
> +
> +If your driver doesn't have to do anything special in its ``init`` and
> +``exit`` methods, you can use the module_virtio_driver() helper to
> +reduce the amount of boilerplate code.
> +
> +The ``probe`` method does the minimum driver setup in this case
> +(memory allocation for the device data) and initializes the
> +virtqueue. The virtqueues are automatically enabled after ``probe``
> +returns, sending the appropriate "DRIVER_OK" status signal to the
> +device. If the virtqueues need to be enabled before ``probe`` ends, they
> +can be manually enabled by calling virtio_device_ready():

let's be a bit clearer here that they must be enabled before add_buf
triggers.

> +
> +.. kernel-doc:: include/linux/virtio_config.h
> +    :identifiers: virtio_device_ready
> +
> +
> +Sending and receiving data
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +The virtio_dummy_recv_cb() callback in the code above will be triggered
> +when the device notifies the driver after it finishes processing a
> +descriptor or descriptor chain, either for reading or writing. However,
> +that's only the second half of the virtio device-driver communication
> +process, as the communication is always started by the driver regardless
> +of the direction of the data transfer.
> +
> +To configure a buffer transfer from the driver to the device, first you
> +have to add the buffers -- packed as `scatterlists` -- to the
> +appropriate virtqueue using any of the virtqueue_add_inbuf(),
> +virtqueue_add_outbuf() or virtqueue_add_sgs(), depending on whether you
> +need to add one input `scatterlist` (for the device to fill in), one
> +output `scatterlist` (for the device to consume) or multiple
> +`scatterlists`, respectively. Then, once the virtqueue is set up, a call
> +to virtqueue_kick() sends a notification that will be serviced by the
> +hypervisor that implements the device::
> +
> +	struct scatterlist sg[1];
> +	sg_init_one(sg, buffer, BUFLEN);
> +	virtqueue_add_inbuf(dev->vq, sg, 1, buffer, GFP_ATOMIC);
> +	virtqueue_kick(dev->vq);
> +
> +.. kernel-doc:: drivers/virtio/virtio_ring.c
> +    :identifiers: virtqueue_add_inbuf
> +
> +.. kernel-doc:: drivers/virtio/virtio_ring.c
> +    :identifiers: virtqueue_add_outbuf
> +
> +.. kernel-doc:: drivers/virtio/virtio_ring.c
> +    :identifiers: virtqueue_add_sgs
> +
> +Then, after the device has read or written the buffers prepared by the
> +driver and notifies it back, the driver can call virtqueue_get_buf() to
> +read the data produced by the device (if the virtqueue was set up with
> +input buffers) or simply to reclaim the buffers if they were already
> +consumed by the device:
> +
> +.. kernel-doc:: drivers/virtio/virtio_ring.c
> +    :identifiers: virtqueue_get_buf_ctx
> +
> +The virtqueue callbacks can be disabled and re-enabled using the
> +virtqueue_disable_cb() and the family of virtqueue_enable_cb() functions
> +respectively. See drivers/virtio/virtio_ring.c for more details:
> +
> +.. kernel-doc:: drivers/virtio/virtio_ring.c
> +    :identifiers: virtqueue_disable_cb
> +
> +.. kernel-doc:: drivers/virtio/virtio_ring.c
> +    :identifiers: virtqueue_enable_cb
> +


maybe clarify that they can still trigger even if enabled.
if you want to disable reliable you have to reset the device
or the vq.

> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +_`[1]` Virtio Spec v1.2:
> +https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html
> +
> +Check for later versions of the spec as well.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 779f599f9abf..6ecdddb89da4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21488,6 +21488,7 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-vdpa
>  F:	Documentation/ABI/testing/sysfs-class-vduse
>  F:	Documentation/devicetree/bindings/virtio/
> +F:	Documentation/driver-api/virtio/
>  F:	drivers/block/virtio_blk.c
>  F:	drivers/crypto/virtio/
>  F:	drivers/net/virtio_net.c
> -- =

> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
