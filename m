Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9135CB7B
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299647; cv=none; b=dg/0tT8v/Vpg64zVLu/AA9ehHMjJPucj4Y2/Z2dBImLGjHDFg0Vp2mmh+o/i/7q6sthMNLVYLu9O7XXoP4dzYkmqfIt3jmEtk5yhquGsLnqcmD6RnArAm23CSgHkRcX/o9xRTdN5FTSEI4kmBlpR2mfJUNoJqWQK44AdC2KqrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299647; c=relaxed/simple;
	bh=js1xNr3lPht0sT8p2tMOogwLbJAFyOPBU4L3h/xMZsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCMd7lCa946QtgVC7B6AicjevSAECV17M+7CF9frY/7DigZ+TQ5zVOqMjooy90BdE8ZyfY8nE3wEJh1qLXTOzbkhp1YJvLw98kvj5Tp9F0aImBB7s0eb3aK6ylcbtidiv/d7xF448IzIwKLkdtzHkxUTobUILWR5n9pa0La3zpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=suZbrFJg; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="suZbrFJg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786299645; x=1817835645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iybfP7f6LBxlJmNoFYXHpDFTtr6xuR9T27xQFliCRME=;
  b=suZbrFJg0l7J4gQyxQau/JYXCmWQz8eLdzv5auB54/BAmo3i/ZSEW3IY
   GnlOsR4iAr90tWTqAreSmAsQbnj53RYJZpEHxnXwcZ5ACurs35uTmCp2C
   s0KFLrtZeg0gcejEuq/pyHopYoH61UntAex7TdNgsWdSf0ttyH0dew65y
   CyxzleM8smbYkW6Zr/VKRFwwp+RHGdwgp+946SuwjIF4yTDjLjCSDw/MO
   tN0/WT6kJ23qBqqZTCCC4S3xTmH19pMUGKGYnd8VB4ZpcjTk2dwqZeP0Z
   RHAhb88iciGZpGELd1bKLzurm2JgHTFHiaqHxQGj9kks5/2Bm44fiUOBG
   w==;
X-CSE-ConnectionGUID: twIFBTtiR/SM3xbFn8maPA==
X-CSE-MsgGUID: hqi5oq8vSgyPPpZD2NEHfw==
X-IronPort-AV: E=Sophos;i="6.25,214,1779148800"; 
   d="scan'208";a="25518625"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:20:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:26162]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.57:2525] with esmtp (Farcaster)
 id 9bf96873-3dbd-42a7-96b8-9d58065dc8bd; Sun, 9 Aug 2026 18:20:43 +0000 (UTC)
X-Farcaster-Flow-ID: 9bf96873-3dbd-42a7-96b8-9d58065dc8bd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:42 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:41 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 03/12] virtio: add the VIRTIO_F_DMB feature bit
Date: Sun, 9 Aug 2026 18:20:01 +0000
Message-ID: <20260809182010.32931-4-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260809182010.32931-1-graf@amazon.com>
References: <20260809182010.32931-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In preparation to support VIRTIO_F_DMB, define the feature bit. A
device that negotiates it holds its virtqueues and the buffers they
reference in a Device Memory Buffer, a shared memory region the device
owns. Every address the driver publishes to such a device is an offset
into that region, so the device can only reach memory the driver placed
there.

Define VIRTIO_F_DMB as 44 and raise VIRTIO_TRANSPORT_F_END to 45, so
virtio_dev_probe() preserves the bit into finalize_features() where a
transport can act on it. VIRTIO_DEVICE_F_MASK derives from the same
bound, and the expansion drivers/vdpa/vdpa.c writes out by hand moves
with it. The feature is a proposal before the virtio Technical
Committee and has no allocated number, so 44 is provisional.

Link: https://lore.kernel.org/virtio-comment/20260804161202.38619-1-graf@amazon.com/
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/vdpa/vdpa.c                |  2 +-
 include/uapi/linux/virtio_config.h | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1757a33f298f..ae9326394c2e 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -548,7 +548,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
 
 /*
  * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
- * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffff8000fffffff for
+ * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xffffc0000fffffff for
  * all 64bit features. If the features are extended beyond 64 bits, or new
  * "holes" are reserved for other type of features than per-device, this
  * macro would have to be updated.
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 2445f365bce7..986e2b5fb3c8 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -52,7 +52,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		42
+#define VIRTIO_TRANSPORT_F_END		45
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -120,4 +120,19 @@
  */
 #define VIRTIO_F_ADMIN_VQ		41
 
+/*
+ * This feature indicates that the device offers a Device Memory Buffer: a
+ * shared memory region, owned by the device, that holds the virtqueues and
+ * the buffers they reference.  When this feature is negotiated, every address
+ * that the driver places in a virtqueue is an offset into the Device Memory
+ * Buffer region rather than a physical address or a bus address.  The device
+ * is thereby confined to memory the driver has published in that region.
+ *
+ * The feature is a specification proposal before the virtio Technical
+ * Committee, not a ratified feature.  The number below is provisional: the
+ * committee has allocated none for it, and it will change if the committee
+ * allocates a different one.  Do not treat it as a stable interface yet.
+ */
+#define VIRTIO_F_DMB			44
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
