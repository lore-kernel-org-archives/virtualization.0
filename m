Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37A0C4167B
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 10:55:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C2460FDA
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 10:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96C2460FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35C2060891;
	Wed, 13 Oct 2021 10:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DByJjrcxfhNC; Wed, 13 Oct 2021 10:55:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 24189606C6;
	Wed, 13 Oct 2021 10:55:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2A5FC000F;
	Wed, 13 Oct 2021 10:55:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BD72C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2CA1080EA4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:55:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbeQCkQos7Dd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:55:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF5EA80E00
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634122548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=HOHQBuq5n1jvyoAk83wUOf4Uik9+loiLDFU1S+KWwJc=;
 b=GSyHZdpJoWPX8JmAMmKAlvUOeIPKmWGMROlcYUw0ZK36y8CV3rn7l2LpIUNTWSf0heVOXn
 MMl99gRcJNUx0H9PVKaiTuV/CddQnehZhI2Z1no/UB84RGXOqIpJ2Kc3NDajF+dPumRrWi
 08drjIN2tTkA8GeSpb9p/z9/Q4cL4S8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-9dmMCM9xOBywYDgpcPr5HA-1; Wed, 13 Oct 2021 06:55:46 -0400
X-MC-Unique: 9dmMCM9xOBywYDgpcPr5HA-1
Received: by mail-wr1-f71.google.com with SMTP id
 41-20020adf802c000000b00161123698e0so1644576wrk.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=HOHQBuq5n1jvyoAk83wUOf4Uik9+loiLDFU1S+KWwJc=;
 b=k2pADWmGO3uzURFYa4Kb0+k1iBsg9ZRDC4CRDL4AZxCl6Ynzro7B8O0TFcUQtWjo5Z
 6Wb5Xc8tPtyiOMH993uZf8ITwO3N6CPAN3iVkkWD1cH+MUBKYDxtKy7TJrGnJMhloc1z
 Xq5inx9M+JZc0aqz856QqLNfGdKb7PyZSWcFn/uSeEdqA3NpGU8R2STZB0f8EBaE56qj
 6t/aVtL/7yO7aTgtmWBLe9Q2SSDPmCNfA9YVNzP5f7HKjsJb8jjBCiFwgf0/XIAeANI/
 tmgmgvcHgMZ8NDC22vXGkK2QjEh3WMI0fXTXEqdPoRYEW0fZHDlhNCN4QrmK6gU1bR7t
 ebJg==
X-Gm-Message-State: AOAM531CudjaGGVdGaLFkJ62oFdGbas+pr2SrKocRZ0FQe0K8UJ+01aW
 ofcMGkCqajgWVHWHqTX2JAoX+vb8yF9p55EPPzTWBzurOqqn9yTmjzKWO0r47Pn63ubPJMqNrl2
 D17jCmQyTncAwXsBMPR5K5LtigttOKDEH3LeJpfIA7Q==
X-Received: by 2002:a1c:f216:: with SMTP id s22mr12239189wmc.27.1634122544689; 
 Wed, 13 Oct 2021 03:55:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIFKVzN3wSeM2Mpi+3ebMvrIe+xpiLg9sofnH/e5wmfza96yWoV1W27PJsbS9IH10+WwuJlw==
X-Received: by 2002:a1c:f216:: with SMTP id s22mr12239123wmc.27.1634122544323; 
 Wed, 13 Oct 2021 03:55:44 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id a81sm5721952wmd.30.2021.10.13.03.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 03:55:42 -0700 (PDT)
Date: Wed, 13 Oct 2021 06:55:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC] virtio: wrap config->reset calls
Message-ID: <20211013105226.20225-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: nvdimm@lists.linux.dev, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 Will Deacon <will@kernel.org>, v9fs-developer@lists.sourceforge.net,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-arm-kernel@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>,
 Richard Weinberger <richard@nod.at>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Kalle Valo <kvalo@codeaurora.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, virtualization@lists.linux-foundation.org,
 Marcel Holtmann <marcel@holtmann.org>, Vivek Goyal <vgoyal@redhat.com>,
 Ohad Ben-Cohen <ohad@wizery.com>, Johan Hedberg <johan.hedberg@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 Eric Van Hensbergen <ericvh@gmail.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-block@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matt Mackall <mpm@selenic.com>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Cristian Marussi <cristian.marussi@arm.com>, Jens Axboe <axboe@kernel.dk>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-gpio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 linux-i2c@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 "David S. Miller" <davem@davemloft.net>, Joerg Roedel <joro@8bytes.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This will enable cleanups down the road.
The idea is to disable cbs, then add "flush_queued_cbs" callback
as a parameter, this way drivers can flush any work
queued after callbacks have been disabled.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/virt-pci.c                 | 2 +-
 drivers/block/virtio_blk.c                 | 4 ++--
 drivers/bluetooth/virtio_bt.c              | 2 +-
 drivers/char/hw_random/virtio-rng.c        | 2 +-
 drivers/char/virtio_console.c              | 4 ++--
 drivers/crypto/virtio/virtio_crypto_core.c | 8 ++++----
 drivers/firmware/arm_scmi/virtio.c         | 2 +-
 drivers/gpio/gpio-virtio.c                 | 2 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c       | 2 +-
 drivers/i2c/busses/i2c-virtio.c            | 2 +-
 drivers/iommu/virtio-iommu.c               | 2 +-
 drivers/net/caif/caif_virtio.c             | 2 +-
 drivers/net/virtio_net.c                   | 4 ++--
 drivers/net/wireless/mac80211_hwsim.c      | 2 +-
 drivers/nvdimm/virtio_pmem.c               | 2 +-
 drivers/rpmsg/virtio_rpmsg_bus.c           | 2 +-
 drivers/scsi/virtio_scsi.c                 | 2 +-
 drivers/virtio/virtio.c                    | 5 +++++
 drivers/virtio/virtio_balloon.c            | 2 +-
 drivers/virtio/virtio_input.c              | 2 +-
 drivers/virtio/virtio_mem.c                | 2 +-
 fs/fuse/virtio_fs.c                        | 4 ++--
 include/linux/virtio.h                     | 1 +
 net/9p/trans_virtio.c                      | 2 +-
 net/vmw_vsock/virtio_transport.c           | 4 ++--
 sound/virtio/virtio_card.c                 | 4 ++--
 26 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c08066633023..22c4d87c9c15 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -616,7 +616,7 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
 	int i;
 
         /* Stop all virtqueues */
-        vdev->config->reset(vdev);
+        virtio_reset_device(vdev);
         vdev->config->del_vqs(vdev);
 
 	device_set_wakeup_enable(&vdev->dev, false);
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 303caf2d17d0..83d0af3fbf30 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -910,7 +910,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 	mutex_lock(&vblk->vdev_mutex);
 
 	/* Stop all the virtqueues. */
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 
 	/* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
 	vblk->vdev = NULL;
@@ -929,7 +929,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
 	struct virtio_blk *vblk = vdev->priv;
 
 	/* Ensure we don't receive any more interrupts */
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 57908ce4fae8..24a9258962fa 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -364,7 +364,7 @@ static void virtbt_remove(struct virtio_device *vdev)
 	struct hci_dev *hdev = vbt->hdev;
 
 	hci_unregister_dev(hdev);
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 
 	hci_free_dev(hdev);
 	vbt->hdev = NULL;
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index a90001e02bf7..95980489514b 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -134,7 +134,7 @@ static void remove_common(struct virtio_device *vdev)
 	vi->hwrng_removed = true;
 	vi->data_avail = 0;
 	complete(&vi->have_data);
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	vi->busy = false;
 	if (vi->hwrng_register_done)
 		hwrng_unregister(&vi->hwrng);
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7eaf303a7a86..08bbd693436f 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1957,7 +1957,7 @@ static void virtcons_remove(struct virtio_device *vdev)
 	spin_unlock_irq(&pdrvdata_lock);
 
 	/* Disable interrupts for vqs */
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	/* Finish up work that's lined up */
 	if (use_multiport(portdev))
 		cancel_work_sync(&portdev->control_work);
@@ -2139,7 +2139,7 @@ static int virtcons_freeze(struct virtio_device *vdev)
 
 	portdev = vdev->priv;
 
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 
 	if (use_multiport(portdev))
 		virtqueue_disable_cb(portdev->c_ivq);
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index e2375d992308..8e977b7627cb 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -404,7 +404,7 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 free_engines:
 	virtcrypto_clear_crypto_engines(vcrypto);
 free_vqs:
-	vcrypto->vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	virtcrypto_del_vqs(vcrypto);
 free_dev:
 	virtcrypto_devmgr_rm_dev(vcrypto);
@@ -436,7 +436,7 @@ static void virtcrypto_remove(struct virtio_device *vdev)
 
 	if (virtcrypto_dev_started(vcrypto))
 		virtcrypto_dev_stop(vcrypto);
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	virtcrypto_free_unused_reqs(vcrypto);
 	virtcrypto_clear_crypto_engines(vcrypto);
 	virtcrypto_del_vqs(vcrypto);
@@ -456,7 +456,7 @@ static int virtcrypto_freeze(struct virtio_device *vdev)
 {
 	struct virtio_crypto *vcrypto = vdev->priv;
 
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	virtcrypto_free_unused_reqs(vcrypto);
 	if (virtcrypto_dev_started(vcrypto))
 		virtcrypto_dev_stop(vcrypto);
@@ -492,7 +492,7 @@ static int virtcrypto_restore(struct virtio_device *vdev)
 free_engines:
 	virtcrypto_clear_crypto_engines(vcrypto);
 free_vqs:
-	vcrypto->vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	virtcrypto_del_vqs(vcrypto);
 	return err;
 }
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 11e8efb71375..6b8d93fe8848 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -452,7 +452,7 @@ static void scmi_vio_remove(struct virtio_device *vdev)
 	 * outstanding message on any vqueue to be ignored by complete_cb: now
 	 * we can just stop processing buffers and destroy the vqueues.
 	 */
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 	/* Ensure scmi_vdev is visible as NULL */
 	smp_store_mb(scmi_vdev, NULL);
diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index d24f1c9264bc..5029f01966f4 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -203,7 +203,7 @@ static void virtio_gpio_request_vq(struct virtqueue *vq)
 
 static void virtio_gpio_free_vqs(struct virtio_device *vdev)
 {
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index f3379059f324..6aa605b8d3a1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -257,7 +257,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
 	flush_work(&vgdev->ctrlq.dequeue_work);
 	flush_work(&vgdev->cursorq.dequeue_work);
 	flush_work(&vgdev->config_changed_work);
-	vgdev->vdev->config->reset(vgdev->vdev);
+	virtio_reset_device(vgdev->vdev);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 }
 
diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index f10a603b13fb..eb3261ac64dc 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -177,7 +177,7 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 static void virtio_i2c_del_vqs(struct virtio_device *vdev)
 {
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 }
 
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 80930ce04a16..1d4e1e7cf175 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1115,7 +1115,7 @@ static void viommu_remove(struct virtio_device *vdev)
 	iommu_device_unregister(&viommu->iommu);
 
 	/* Stop all virtqueues */
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
 	dev_info(&vdev->dev, "device removed\n");
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 91230894692d..444ef6a342f6 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -754,7 +754,7 @@ static void cfv_remove(struct virtio_device *vdev)
 	debugfs_remove_recursive(cfv->debugfs);
 
 	vringh_kiov_cleanup(&cfv->ctx.riov);
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	vdev->vringh_config->del_vrhs(cfv->vdev);
 	cfv->vr_rx = NULL;
 	vdev->config->del_vqs(cfv->vdev);
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 79bd2585ec6b..8c10fcad73a4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3274,7 +3274,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	return 0;
 
 free_unregister_netdev:
-	vi->vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 
 	unregister_netdev(dev);
 free_failover:
@@ -3290,7 +3290,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 static void remove_vq_common(struct virtnet_info *vi)
 {
-	vi->vdev->config->reset(vi->vdev);
+	virtio_reset_device(vi->vdev);
 
 	/* Free unused buffers in both send and recv, if any. */
 	free_unused_bufs(vi);
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 0adae76eb8df..9ee430c1d4a2 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -4369,7 +4369,7 @@ static void remove_vqs(struct virtio_device *vdev)
 {
 	int i;
 
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 
 	for (i = 0; i < ARRAY_SIZE(hwsim_vqs); i++) {
 		struct virtqueue *vq = hwsim_vqs[i];
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 726c7354d465..995b6cdc67ed 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -105,7 +105,7 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
 
 	nvdimm_bus_unregister(nvdimm_bus);
 	vdev->config->del_vqs(vdev);
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 }
 
 static struct virtio_driver virtio_pmem_driver = {
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 8e49a3bacfc7..6a11952822df 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -1015,7 +1015,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
 	size_t total_buf_space = vrp->num_bufs * vrp->buf_size;
 	int ret;
 
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 
 	ret = device_for_each_child(&vdev->dev, NULL, rpmsg_remove_device);
 	if (ret)
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 07d0250f17c3..f2502a8a5213 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -778,7 +778,7 @@ static void virtscsi_init_vq(struct virtio_scsi_vq *virtscsi_vq,
 static void virtscsi_remove_vqs(struct virtio_device *vdev)
 {
 	/* Stop all the virtqueues. */
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 }
 
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 0a5b54034d4b..a67dd0eca578 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -204,6 +204,11 @@ int virtio_finalize_features(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_finalize_features);
 
+static void virtio_reset_device(struct virtio_device *dev)
+{
+	dev->config->reset(dev);
+}
+
 static int virtio_dev_probe(struct device *_d)
 {
 	int err, i;
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c22ff0117b46..f4c34a2a6b8e 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1056,7 +1056,7 @@ static void remove_common(struct virtio_balloon *vb)
 		return_free_pages_to_mm(vb, ULONG_MAX);
 
 	/* Now we reset the device so we can clean up the queues. */
-	vb->vdev->config->reset(vb->vdev);
+	virtio_reset_device(vb->vdev);
 
 	vb->vdev->config->del_vqs(vb->vdev);
 }
diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index ce51ae165943..3aa46703872d 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -347,7 +347,7 @@ static void virtinput_remove(struct virtio_device *vdev)
 	spin_unlock_irqrestore(&vi->lock, flags);
 
 	input_unregister_device(vi->idev);
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
 		kfree(buf);
 	vdev->config->del_vqs(vdev);
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index bef8ad6bf466..3bab0a625a4b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2722,7 +2722,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 	}
 
 	/* reset the device and cleanup the queues */
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
 	kfree(vm);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 0ad89c6629d7..27c3b74070a2 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -895,7 +895,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	return 0;
 
 out_vqs:
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	virtio_fs_cleanup_vqs(vdev, fs);
 	kfree(fs->vqs);
 
@@ -927,7 +927,7 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 	list_del_init(&fs->list);
 	virtio_fs_stop_all_queues(fs);
 	virtio_fs_drain_all_queues_locked(fs);
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	virtio_fs_cleanup_vqs(vdev, fs);
 
 	vdev->priv = NULL;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 41edbc01ffa4..72292a62cd90 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -138,6 +138,7 @@ int virtio_finalize_features(struct virtio_device *dev);
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
 #endif
+void virtio_reset_device(struct virtio_device *dev);
 
 size_t virtio_max_dma_size(struct virtio_device *vdev);
 
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 490a4c900339..19c69821dd04 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -721,7 +721,7 @@ static void p9_virtio_remove(struct virtio_device *vdev)
 
 	mutex_unlock(&virtio_9p_lock);
 
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
 	sysfs_remove_file(&(vdev->dev.kobj), &dev_attr_mount_tag.attr);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f7c99dfd16c..fb3302fff627 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -665,7 +665,7 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	vsock_for_each_connected_socket(virtio_vsock_reset_sock);
 
 	/* Stop all work handlers to make sure no one is accessing the device,
-	 * so we can safely call vdev->config->reset().
+	 * so we can safely call virtio_reset_device().
 	 */
 	mutex_lock(&vsock->rx_lock);
 	vsock->rx_run = false;
@@ -682,7 +682,7 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	/* Flush all device writes and interrupts, device will not use any
 	 * more buffers.
 	 */
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 
 	mutex_lock(&vsock->rx_lock);
 	while ((pkt = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 150ab3e37013..e2847c040f75 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -350,7 +350,7 @@ static void virtsnd_remove(struct virtio_device *vdev)
 		snd_card_free(snd->card);
 
 	vdev->config->del_vqs(vdev);
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 
 	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
@@ -379,7 +379,7 @@ static int virtsnd_freeze(struct virtio_device *vdev)
 	virtsnd_ctl_msg_cancel_all(snd);
 
 	vdev->config->del_vqs(vdev);
-	vdev->config->reset(vdev);
+	virtio_reset_device(vdev);
 
 	for (i = 0; i < snd->nsubstreams; ++i)
 		cancel_work_sync(&snd->substreams[i].elapsed_period);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
