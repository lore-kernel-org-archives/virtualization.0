Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076063FD15B
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472054; cv=none; b=PHlhi7670thUoaNNP1ydkL4iK8mVINtSoZKOlkh/MpJ2VT5Do91sLXN+foG0j++eUY7I2ZmSxmIYt7r/4qyFB+6VlDjZCO3aIRduFQviU9jY6iUcbtjwV3Hm9uj0j1PlACqWyxvIvP5zFMzVXNPK+JEaWdZreyfyfUSyFW9Zmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472054; c=relaxed/simple;
	bh=6IYePC9mVPuBLjmvyass3h9zH+kXhifr6Gq04kZHrAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UIRz//5EaonNsRae4pOG8jqp1VH2GyRcD/MlYL76YGIg3+Orkc0kHLI9e3PhV6rd1O2+LD6x91SHx3sLrlk+jAxzRTQxogvwFtz6+J+DPzp9mzl3AXg/0yhAt59s9wTAeEsL1P8dGBvYWdX/+ZRFuYt64G0FKsC7xGaak/AUKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=Iu6B/GBf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UuVdds6z; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="Iu6B/GBf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UuVdds6z"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C958C7A00D0;
	Wed, 29 Apr 2026 10:14:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 29 Apr 2026 10:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1777472050; x=1777558450; bh=m91VKPh4PUBytU5kpYfhb4cVChEL8DyMvXK
	Y3Xve3Rc=; b=Iu6B/GBfj+HguUmDDVmVY//ympuSkvgQQFeQAfq07KKIrMLXJ+0
	sudJdqth9JicKBLFrihqDGb+n19HyqgCYfTy0DGSGUXXqO770uTVp9fZGPzIfRVA
	1UHAl+6zBsIkOPpPjzxDVODNcZpMpT/DmjfF2gKHQQk8LhubPG8zAmX+hnx3VMh7
	SnzXVZx2cf8fCpZ6nlpRZcoV4oiVNu0+WuOEs87s3e5Nk7JKWpSimflkpEeZVvCc
	Ck+nu1DEZfzy8/PQD470quElAi/jaVx58ZLESZxsiLQSb1gInIB85/xT7XP4wrGC
	ekBQ4PS40zY6hqRcRT6Oaqh0o27S18dm+CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777472050; x=1777558450; bh=m91VKPh4PUBytU5kpYfhb4cVChEL8DyMvXK
	Y3Xve3Rc=; b=UuVdds6zgumutc6n/Y4b3uziBXmJKtt1qwCJceMK/Sm/0jhz725
	2TJDTPcJKEDlJFWWot9pz7wVwy71gWFoHfTLtfgKnyDj8oQp3BlavSANW6h/tAhJ
	Ggz/woaxMBgYR2FYESeFNhl4gMBbaKVCvy5hQPcc4ZnngWzLLVomuKo9l2+H8Hif
	ZyvXE4faqNUW/4cvY3CgoDujBin/raOj0xMMSo/v4H+QmPTvIiry7amK6DB3XQGz
	k2F4eSdBgUHHbJ53sAQ7OOMFIqGxTmNh0ILKxzwxPAXVIIlUF8tXWvDhQSHqPUI/
	F5HUr4GVRglaU4aqbBuiLewRPsw4jp+HVZw==
X-ME-Sender: <xms:MRLyaSs1MhtiS_jwZWI-2NlNs3sgT3rLZJ8zpMdBwj4ew-AplPIc_Q>
    <xme:MRLyafpVO8BbeGLvvNcpQrd5FJdKnXsc1W6Zlkfgsh54eNWE8d0BvRueGnwlba0cp
    e4nzmrl-7c5zngl9fWRHbEh9wMYO6ze7ZF-1IgId4jXfp27EpA>
X-ME-Received: <xmr:MRLyaZX5dMBF8Un69nktuOctJFwRs2Z9mnoE57ciaFexxrhOz9aC0dUrXkQ2khA1QF2l-uaaD9rRJDdl6DhyJ9gWJrgwNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeggrghlucfrrggtkhgv
    thhtuceovhgrlhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtf
    frrghtthgvrhhnpefgiefgiefhveehgfegueevffdtleevueefjeekledtheevleevhedt
    jeehteeuudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvhgrlhesihhnvhhishhisghlvght
    hhhinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhhsthesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhgr
    shhofigrnhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopeiguhgrnhiihhhuoheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopegvphgvrhgviihmrgesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepvhgrlhesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmpdhrtghpthhtohepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhh
    ihhnghhslhgrsgdrtghomhdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinh
    grrhhordhorhhgpdhrtghpthhtohepgigvnhdquggvvhgvlheslhhishhtshdrgigvnhhp
    rhhojhgvtghtrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MRLyaX2o3rePuDkcVRJtIX3KO6aFQc9kas8W1deys4oBZBr2ezxZKg>
    <xmx:MRLyaetOuAW3EcarJ3iiQBG1FQtmvfhTYlWkd3gd2vC25WqWnQIOZw>
    <xmx:MRLyafWO6Ydls2uwNepFNat0ZpIyzBkUaxYYyBCil1afsLEGJeGb8Q>
    <xmx:MRLyaWwXicRoa71NbK9nLSihtHf1TV8dgLQCeYerQDHhTvmPAuKDag>
    <xmx:MhLyafJkU4ddbYB5qDJgGuMC0TzjGeEtOSrHIQFjy3CzcQLxFwn3DQfx>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 10:14:07 -0400 (EDT)
From: Val Packett <val@invisiblethingslab.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Val Packett <val@invisiblethingslab.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RFC PATCH] virtio-mmio: add xenbus probing
Date: Wed, 29 Apr 2026 10:52:17 -0300
Message-ID: <20260429141339.74472-1-val@invisiblethingslab.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The experimental virtio-mmio support for Xen was initially developed
on aarch64, so device trees were used to configure the mmio devices,
with arbitrary vGIC interrupts used by the hypervisor. On x86_64
however, the only reasonable way to interrupt the guest is over Xen
event channels, which can only be acquired by children of xenbus,
the virtual bus driven by Xen's configuration database, XenStore.
It is also a more convenient and "Xen-ish" way to provision devices.

Implement a xenbus client for virtio-mmio which negotiates an
event channel and provides it as a platform IRQ to the
virtio-mmio driver.


Signed-off-by: Val Packett <val@invisiblethingslab.com>
---

Hi,

I've been working on porting virtio-mmio support from Arm to x86_64,
with the goal of running vhost-user-gpu to power Wayland/GPU integration
for Qubes OS. (I'm aware of various proposals for alternative virtio
transports but virtio-mmio seems to be the only one that *is* upstream
already and just Works..) Setting up virtio-mmio through xenbus, initially
motivated just by event channels being the only real way to get interrupts
working on HVM, turned out to generally be quite pleasant and nice :)

I'd like to get some early feedback for this patch, particularly
the general stuff:

* is this whole thing acceptable in general?
* should it be extracted into a different file?
* (from the Xen side) any input on the xenstore keys, what goes where?
* anything else to keep in mind?

It does seem simple enough, so hopefully this can be done?

The corresponding userspace-side WIP is available at:
https://github.com/QubesOS/xen-vhost-frontend

And the required DMOP for firing the evtchn events will be sent
to xen-devel shortly as well.

Thanks,
~val

---
 drivers/virtio/Kconfig       |   7 ++
 drivers/virtio/virtio_mmio.c | 177 ++++++++++++++++++++++++++++++++++-
 2 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index ce5bc0d9ea28..56bc2b10526b 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -171,6 +171,13 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
 
 	 If unsure, say 'N'.
 
+config VIRTIO_MMIO_XENBUS
+	bool "Memory mapped virtio devices parameter parsing"
+	depends on VIRTIO_MMIO && XEN
+	select XEN_XENBUS_FRONTEND
+	help
+	 Allow virtio-mmio devices instantiation for Xen guests via xenbus.
+
 config VIRTIO_DMA_SHARED_BUFFER
 	tristate
 	depends on DMA_SHARED_BUFFER
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..32295284bdbf 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -70,6 +70,11 @@
 #include <uapi/linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
 
+#ifdef CONFIG_VIRTIO_MMIO_XENBUS
+#include <xen/xen.h>
+#include <xen/xenbus.h>
+#include <xen/events.h>
+#endif
 
 
 /* The alignment to use between consumer and producer parts of vring.
@@ -810,13 +815,183 @@ static struct platform_driver virtio_mmio_driver = {
 	},
 };
 
+#ifdef CONFIG_VIRTIO_MMIO_XENBUS
+struct virtio_mmio_xen_info {
+	struct resource resources[2];
+	unsigned int evtchn;
+	struct platform_device *pdev;
+};
+
+static int virtio_mmio_xen_probe(struct xenbus_device *dev,
+			const struct xenbus_device_id *id)
+{
+	int err;
+	long long base, size;
+	char *mem;
+	struct virtio_mmio_xen_info *info;
+	struct xenbus_transaction xbt;
+
+	/* TODO: allocate an unused address here and pass it to the host instead */
+	err = xenbus_scanf(XBT_NIL, dev->otherend, "base", "0x%llx",
+			   &base);
+	if (err < 0) {
+		xenbus_dev_fatal(dev, err, "reading base");
+		return -EINVAL;
+	}
+
+	mem = xenbus_read(XBT_NIL, dev->otherend, "size", NULL);
+	if (XENBUS_IS_ERR_READ(mem))
+		return PTR_ERR(mem);
+	size = memparse(mem, NULL);
+	kfree(mem);
+
+	info = kzalloc_obj(*info);
+	if (!info) {
+		xenbus_dev_fatal(dev, -ENOMEM, "allocating info structure");
+		return -ENOMEM;
+	}
+
+	info->resources[0].flags = IORESOURCE_MEM;
+	info->resources[0].start = base;
+	info->resources[0].end = base + size - 1;
+
+	err = xenbus_alloc_evtchn(dev, &info->evtchn);
+	if (err) {
+		xenbus_dev_fatal(dev, err, "xenbus_alloc_evtchn");
+		goto error_info;
+	}
+
+	err = bind_evtchn_to_irq(info->evtchn);
+	if (err <= 0) {
+		xenbus_dev_fatal(dev, err, "bind_evtchn_to_irq");
+		goto error_evtchan;
+	}
+
+	info->resources[1].flags = IORESOURCE_IRQ;
+	info->resources[1].start = info->resources[1].end = err;
+
+again:
+	err = xenbus_transaction_start(&xbt);
+	if (err) {
+		xenbus_dev_fatal(dev, err, "starting transaction");
+		goto error_irq;
+	}
+
+	err = xenbus_printf(xbt, dev->nodename, "event-channel", "%u",
+			    info->evtchn);
+	if (err) {
+		xenbus_transaction_end(xbt, 1);
+		xenbus_dev_fatal(dev, err, "%s", "writing event-channel");
+		goto error_irq;
+	}
+
+	err = xenbus_transaction_end(xbt, 0);
+	if (err) {
+		if (err == -EAGAIN)
+			goto again;
+		xenbus_dev_fatal(dev, err, "completing transaction");
+		goto error_irq;
+	}
+
+	dev_set_drvdata(&dev->dev, info);
+	xenbus_switch_state(dev, XenbusStateInitialised);
+	return 0;
+
+error_irq:
+	unbind_from_irqhandler(info->resources[1].start, info);
+error_evtchan:
+	xenbus_free_evtchn(dev, info->evtchn);
+error_info:
+	kfree(info);
+
+	return err;
+}
+
+static void virtio_mmio_xen_backend_changed(struct xenbus_device *dev,
+				   enum xenbus_state backend_state)
+{
+	struct virtio_mmio_xen_info *info = dev_get_drvdata(&dev->dev);
+
+	switch (backend_state) {
+	case XenbusStateInitialising:
+	case XenbusStateInitWait:
+	case XenbusStateInitialised:
+	case XenbusStateReconfiguring:
+	case XenbusStateReconfigured:
+	case XenbusStateUnknown:
+		break;
+
+	case XenbusStateConnected:
+		if (dev->state != XenbusStateInitialised) {
+			dev_warn(&dev->dev, "state %d on connect", dev->state);
+			break;
+		}
+		info->pdev = platform_device_register_resndata(&dev->dev,
+				"virtio-mmio", PLATFORM_DEVID_AUTO,
+				info->resources, ARRAY_SIZE(info->resources), NULL, 0);
+		xenbus_switch_state(dev, XenbusStateConnected);
+		break;
+
+	case XenbusStateClosed:
+		if (dev->state == XenbusStateClosed)
+			break;
+		fallthrough;	/* Missed the backend's Closing state. */
+	case XenbusStateClosing:
+		platform_device_unregister(info->pdev);
+		xenbus_switch_state(dev, XenbusStateClosed);
+		break;
+
+	default:
+		xenbus_dev_fatal(dev, -EINVAL, "saw state %d at frontend",
+				 backend_state);
+		break;
+	}
+}
+
+static void virtio_mmio_xen_remove(struct xenbus_device *dev)
+{
+	struct virtio_mmio_xen_info *info = dev_get_drvdata(&dev->dev);
+
+	kfree(info);
+	dev_set_drvdata(&dev->dev, NULL);
+}
+
+static const struct xenbus_device_id virtio_mmio_xen_ids[] = {
+	{ "virtio" },
+	{ "" },
+};
+
+static struct xenbus_driver virtio_mmio_xen_driver = {
+	.ids			= virtio_mmio_xen_ids,
+	.probe			= virtio_mmio_xen_probe,
+	.otherend_changed	= virtio_mmio_xen_backend_changed,
+	.remove			= virtio_mmio_xen_remove,
+};
+#endif
+
 static int __init virtio_mmio_init(void)
 {
-	return platform_driver_register(&virtio_mmio_driver);
+	int ret;
+
+	ret = platform_driver_register(&virtio_mmio_driver);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_VIRTIO_MMIO_XENBUS
+	if (xen_domain())
+		ret = xenbus_register_frontend(&virtio_mmio_xen_driver);
+#endif
+
+	return ret;
 }
 
 static void __exit virtio_mmio_exit(void)
 {
+#ifdef CONFIG_VIRTIO_MMIO_XENBUS
+	if (xen_domain())
+		xenbus_unregister_driver(&virtio_mmio_xen_driver);
+#endif
+
 	platform_driver_unregister(&virtio_mmio_driver);
 	vm_unregister_cmdline_devices();
 }
-- 
2.53.0

