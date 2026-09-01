Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A53D6663
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227254; cv=none; b=nuzKJBmO8pyjyDR97Nc5MHQ+eS7MwwK9bScl8g1SFFWcLp7aBeXjJUyDGe75Ou5u7JpYybVRnN+RVx9k3wy2BA5k1GhLNCTTHlLpvbRlrrGyYLOUrFnD4vV4SLRCE0XbKZQWX93F5O61jmwOuDBvZxIWoinG4XVtXE14wCFWG6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227254; c=relaxed/simple;
	bh=AJU7kvyec/8/K9axi/CdS+dyi0PDMEtj+kkrf6c8WHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUHGTQdYoLK0mGu/RU4rQSjyYMG14foXuaGFbOcvZkz8xb/2OCeU83w6cOf+N0AtC3ezjcloHgI9PPciNafWek0PR8C1MWIClf3wUZCEIrfrQlFyQs0m9FuvUsVj5GGi1pvxX89MUCrpBSNZbA16lx3DKvDSuY3+W7dqNwyUlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q841m4ic; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q841m4ic"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so3266854a91.3
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 18:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788227223; x=1788832023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qn8m16h1ZIsyZncr3xk0OF7gEb6fuaXwGCP5imv6Fmk=;
        b=Q841m4icpRXB44L/s1/kGrnkDsHqB2jCaTz82GL5A4FxtDujZ1GJE0ZIDRPVQpXRN2
         aIiO/Ow7omdZE1fg74u8aawwR4sLGo84jBgKTWulA9ggQI93LyJl6O3Qa/q4W6OdrmGE
         KZZAePi2Q4IajPkmkMxeLnonTpXI/xzNGtlX27l0slB4R9Hvc7hwSsRBpy6Kp39qHh38
         Molx5XCOSsCv+1vzp6gzHjtol8tQ2vSesFgnxERFjKT6NspMPBTOsyjGN4FdyKkV5g5D
         TW39BTf7VhFYrwEXIB6TpSMB/THBZgp/onY89WdJvHNGjHKAsNc/QNoei5sAUEx5SPg8
         eWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788227223; x=1788832023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qn8m16h1ZIsyZncr3xk0OF7gEb6fuaXwGCP5imv6Fmk=;
        b=Y2ornKp5IpQRZ3TSAluZwt2tH7fTT+4m1r6W1yxpSRh/yCAaP/ZfAimCKs6Yyupo+9
         cgAj4NI49f9R2kHmVNO6tnPqD1pJo7U2XjBrjQNz5tIgCal5Ts9IhRoO9cWqudySlzfq
         TUOXQ8x6CAvYsnWG/GaVSD6XM8I8LikGssM/9WiGGxPDj/NCJhFJYGqIFFjtwOmnXcA6
         D8cpKTmCNVyf7GylieWMNMZJY2nJB36DPbptWtrD46hpywJAjB5c3VTw7ayWEFFXGUrw
         ceg2vIozlp8d9btzIjWIIj4TrSZwb9RncYsRR8MkFQ9FrJEAXvNQGKv6PKwWp/7Ai1OE
         8l7w==
X-Forwarded-Encrypted: i=1; AKwUvBx/+eSzgxR5s8l2Rj8waVCJPUTM5SJHwYv0UZVmX6qWmTjj+W26N0YddlemYOJvyfqGzOE094UPnUhzzXuddQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nKx2LV6d8TPqer3ZgYrqhVH7BODy3idUZT5KPg1pip/Ob6Dj/x
	eurZjyXO5w6TC/kTuqyLrdH399K3NryZU1rcbE79K70kbrIV8BJsYh16
X-Gm-Gg: AYBFou1n589jY+BoY1PKbiDLmv/IUFPLVV2iiuqYkHK0QxiWoht6OD271sysDnzg/3Z
	FBbRYTktqOt/HgaOgE5wBuHF9Q5S8agkNbuT48E7p27jila8lq9LrGhfWuZFp3oKWhcQsEW//di
	4KAIBwokVCEPnFADNQunpIlHxMw87BeCQLfTPOapTTY/T0HB8kRsa2bm/uVZ9bTbduO0AHy/o1h
	SnhRGnN/nG0xg9BlmiNDUkEunAD9+HBQo00OVSGaM66cNrpORYIKypOmM3ZMpUvtruGDbPEbr/V
	HS/cBWz+fl72ZmJV0s9Div/Z2EZo/r7rLd7QG27qMKYypyZfisgu0+NoNtcXdNHApCn0k3UwvE6
	tnqROS2uaqy7B6ICjYp6vKAmykYBrqXRXS0UFGAYFVZgP9qkAgEQjIdHy9P9QGYqR2OR5AHrJW9
	uyrp9ZSRlfYUDdokORef+42sl7dv3zItgYpgNZxR8m0V4/zpUYX1W2Pxbk4WrTj2STBabER4/h2
	4/ginVQg2/cJkRI
X-Received: by 2002:a17:90b:57cf:b0:398:d132:ba76 with SMTP id 98e67ed59e1d1-398d132c2e0mr19648664a91.21.1788227223247;
        Mon, 31 Aug 2026 18:47:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d62b807sm2561122a91.16.2026.08.31.18.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:47:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: mst@redhat.com,
	eperezma@redhat.com,
	linux-kernel@vger.kernel.org,
	xuanzhuo@linux.alibaba.com,
	jasowangio@gmail.com,
	linux-scsi@vger.kernel.org,
	mkp@kernel.org,
	virtualization@lists.linux.dev,
	James.Bottomley@HansenPartnership.com
Cc: alistair@alistair23.me,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/2] virtio_pci: Add a quirk to force DMA Map API for certain legacy devices
Date: Tue,  1 Sep 2026 11:46:49 +1000
Message-ID: <20260901014650.2728658-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901014650.2728658-1-alistair.francis@wdc.com>
References: <20260901014650.2728658-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Legacy virtio devices only have 32 feature bits and therefore can't
set the VIRTIO_F_ACCESS_PLATFORM (bit 33) feature. This means the
vring_use_map_api() function will return false.

Currently Linux endpoint devices use the legacy virtio interface as
they aren't able to advertise the Common configuration capability.
As most PCI endpoint capable PCIe controllers do not allow modifying the
capability list, and thus are unable to advertise the Common configuration
capability. This means the device's inbound TLPs fault on the host
SMMU because the vring descriptors carry raw physical addresses.

This quirk forces a subset of legacy virtio devices to use the
DMA Map API (vring_use_map_api() will return true), which fixes this
issue.

This doesn't affect existing devices as we are checking for an
otherwise invalid vendor ID.

Ideally we would update the endpoint devices (like scsi-pci-epf)
to not use the legacy virtio interface, but lots of endpoint
hardware (like the one in the RK3588) doesn't allow us to add
custom capabilities.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/virtio/virtio_pci_legacy.c | 27 +++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c       |  7 +++++++
 include/linux/virtio.h             |  5 +++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..7b529bd451bb 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -16,6 +16,7 @@
 
 #include "linux/virtio_pci_legacy.h"
 #include "virtio_pci_common.h"
+#include <linux/virtio_ids.h>
 
 /* virtio config->get_features() implementation */
 static u64 vp_get_features(struct virtio_device *vdev)
@@ -220,6 +221,32 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
 
 	vp_dev->vdev.config = &virtio_pci_config_ops;
 
+	/*
+	 * Legacy virtio devices only have 32 feature bits and therefore can't
+	 * set the VIRTIO_F_ACCESS_PLATFORM (bit 33) feature. This means the
+	 * vring_use_map_api() function will return false.
+	 *
+	 * Currently Linux endpoint devices use the legacy virtio interface as
+	 * they aren't able to advertise the Common configuration capability.
+	 * This means the device's inbound TLPs fault on the host SMMU because
+	 * the vring descriptors carry raw physical addresses.
+	 *
+	 * This quirk forces a subset of legacy virtio devices to use the
+	 * DMA Map API (vring_use_map_api() will return true), which fixes this
+	 * issue.
+	 *
+	 * This doesn't affect existing devices as we are checking for an
+	 * otherwise invalid vendor ID.
+	 *
+	 * Ideally we would update the endpoint devices (like scsi-pci-epf)
+	 * to not use the legacy virtio interface, but lots of endpoint
+	 * hardware (like the one in the RK3588) doesn't allow us to add
+	 * custom capabilities.
+	 */
+	if (pci_dev->subsystem_vendor == 0xFFFF &&
+	    pci_dev->subsystem_device == VIRTIO_ID_SCSI)
+		vp_dev->vdev.force_use_map_api = true;
+
 	vp_dev->config_vector = vp_config_vector;
 	vp_dev->setup_vq = setup_vq;
 	vp_dev->del_vq = del_vq;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5c169fbb418a..c8f62180c9d3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -384,6 +384,13 @@ static bool vring_use_map_api(const struct virtio_device *vdev)
 	if (!virtio_has_dma_quirk(vdev))
 		return true;
 
+	/*
+	 * A quirk set by certain legacy devices to force us to
+	 * pretend the VIRTIO_F_ACCESS_PLATFORM feature is enabled.
+	 */
+	if (vdev->force_use_map_api)
+		return true;
+
 	/* Otherwise, we are left to guess. */
 	/*
 	 * In theory, it's possible to have a buggy QEMU-supposed
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index f923e42cfd01..305c331f33f1 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -151,6 +151,10 @@ struct virtio_admin_cmd {
  * @config_driver_disabled: configuration change reporting disabled by
  *                          a driver
  * @config_change_pending: configuration change reported while disabled
+ * @force_use_map_api: A quirk set by certain legacy devices to force us
+ *                     to pretend the VIRTIO_F_ACCESS_PLATFORM feature is
+ *                     enabled. Set by transports that have no way to
+ *                     negotiate ACCESS_PLATFORM but sit behind a real IOMMU.
  * @config_lock: protects configuration change reporting
  * @vqs_list_lock: protects @vqs.
  * @dev: underlying device.
@@ -173,6 +177,7 @@ struct virtio_device {
 	bool config_core_enabled;
 	bool config_driver_disabled;
 	bool config_change_pending;
+	bool force_use_map_api;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
 	struct device dev;
-- 
2.55.0

