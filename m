Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB05B32BF5C
	for <virtualization@lists.linux.dev>; Thu, 18 Jun 2026 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776686; cv=none; b=qiH68rbVH34Lfdv3lecAaoy1nogKxA3JHJj5SWcCWh3I9uaQhwIE8Sb+x40dM0lBM2a1d0HaR8nUhFsz2XzQuaYoynJrSHA1Nt1CXDv5nHWgY0gDoQJbIMiWhwuKUYza7gTbcu/kTmY5tpQ9zkyD/lCza9w5PesghOsRULdon+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776686; c=relaxed/simple;
	bh=dT5fIZoa2yxxcHroYRwQfNM50BjwhP13EQNNTvvVoFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQ+jR/dmRDEWMPyyfGtTUa27DXzmvrDaWgfQyNslWmAQGe2/E9XG68Y3+LYyrgSU0Htl4DLD+N3+CtdDR2XVmZTMJvOZ5lKUPcMRBvvmBtjoN9ALCEmk5Vu6GfmYzwIjPuvyOOTRrJ7lqmwLNcPQQMtczApYim6QVRcVPdxQ+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HNraUwYr; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HNraUwYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781776657;
	bh=k1kNpTsNhCPkr6Gb14ccnaaSyw7MrKYlmImQOADHY4U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HNraUwYrLJynOziifOcVujBNb159KDxciqkRJMQy0Drhr5lzfdrmQownffsANkBPf
	 XVj67OLgP9FSR743tA6VJd8NSmYOd5CPUwBwrhiYyB1M0l1OvM4by7T1RQuLsyPCzN
	 bxHiMFVNGsLzhijpMtU4WowIQ9zbFu5UffX0/P+c=
X-QQ-mid: zesmtpgz1t1781776637tbf7cec6a
X-QQ-Originating-IP: eqL5pFG1SlemEQzlKwyJvm3LrS8TuZJ8ZyWc+jhwCbk=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 17:57:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3785270894744152553
EX-QQ-RecipientCnt: 10
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	rppt@kernel.org,
	ljs@kernel.org,
	akpm@linux-foundation.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH 1/2] tools/virtio: Add missing compat definitions for vhost_net_test
Date: Thu, 18 Jun 2026 17:56:41 +0800
Message-ID: <84157955DFE4842D+20260618095642.510565-2-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260618095642.510565-1-chenyichong@uniontech.com>
References: <20260618095642.510565-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: ND42uzdxTIzruGe96DcIg+qWPcsVU9HChVEg5ftk0IUdL53YO6ttUxY6
	qMqwHeJrHCfPbPYU3ISo0NW2UOkgLwl7kMqLRv63s2nl0e6F6sRVGlC5pDb3evCqO11vAg8
	aFvNUUAHrKdpU3ufHUj86IoP2BpwBmlw49tepFbb9I5ynITYTS96nth3PAxQ0DZerDaMsxx
	Hz0DfNY30FiJHXuYFW8U77afjwnpEdZ/4X6rnarYAgVBAAYQez2I18u5TY0kBqsiVSqzCAN
	FVmod+SCLHcWMxpqIaqaa5Fe14Qte+bzMK22Lir6cArTOAI3iemuUrAk5ucnhQrhrSGjfKo
	Tlo/nJT6xdO03jjExgGK2ieAYGOlNtajz+xrLutOiLh5rvhOB+V/NTMvMNZqjjOFyOPnSyU
	o1q8+JbU5KPcWx6eMHe8/TAS8SpHPJ7N8wK1n08iSw9u6s4kv+jDMJMrhQNXRto+pEMtLZd
	Vn53C2IhsM2DvBUfYS+pq1m7Nsvq/amrQ1uOSVSRR4ifioxnP8veM1W4UDfne5Kg1SdD4OH
	csQ7WFU7N6vFH73IMzE4WtakSXMrRF16MQ71a9oMnhFHHA9Jvp7gCxHUPcZ8XLvUzTrdVr5
	4ae1b3FNok7RSxQcQm+f7NCEOAMuaLUGWZ5se3JB28MqTrYwz5/+lPL1jeRbMsJzSp9PS5e
	zIsRD33+7nMWdyxf599zrOc+i9dhoJedU6WaycZ8+9b+CknXsfrr6qNACh2VaMkjQIog/X3
	UG6Rn4cwwkoznfUNIYHUCDI/7do9AgUGNnkA4hKZdGsRvHGR6jysRpc2XT478EBTIduRuR2
	QPGRbWnZPTD26LVLulXx9FUrBSKR8D+hmVEmJkJN6eD3hX1FiDMDz3XmFJdgWRHU5Q5+Y45
	aAi7tpfVzkUG7R3D/ahcOVbaus5h/acpwxvWW8MTxK4fHnNoZnT8pmwAul5t5zhNiW+X5Hh
	sKRmGqgV1uibKbIzyGu9tQjLpxZbGaZRUN/svgjOxHRECbF3EwNntrk6JPIMQ3DzE/9nsGR
	l6sL1Ngh3rC38kgCrmVjCYjTujfMfSmsrTsja/AWsMBag/CA71
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

vhost_net_test builds virtio_ring.c in userspace.

Recent virtio headers pull in new helper headers.

They also use new allocation helpers and a DMA attribute.

Add the missing compat definitions.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/virtio/linux/completion.h      |  9 +++++
 tools/virtio/linux/device.h          |  1 +
 tools/virtio/linux/dma-mapping.h     |  1 +
 tools/virtio/linux/mod_devicetable.h | 14 +++++++
 tools/virtio/linux/slab.h            |  4 ++
 tools/virtio/linux/virtio_features.h | 56 ++++++++++++++++++++++++++++
 6 files changed, 85 insertions(+)
 create mode 100644 tools/virtio/linux/completion.h
 create mode 100644 tools/virtio/linux/mod_devicetable.h
 create mode 100644 tools/virtio/linux/virtio_features.h

diff --git a/tools/virtio/linux/completion.h b/tools/virtio/linux/completion.h
new file mode 100644
index 000000000000..5e54b679721b
--- /dev/null
+++ b/tools/virtio/linux/completion.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_COMPLETION_H
+#define _LINUX_COMPLETION_H
+
+struct completion {
+	unsigned int done;
+};
+
+#endif /* _LINUX_COMPLETION_H */
diff --git a/tools/virtio/linux/device.h b/tools/virtio/linux/device.h
index 075c2140d975..abf100cb0023 100644
--- a/tools/virtio/linux/device.h
+++ b/tools/virtio/linux/device.h
@@ -1,4 +1,5 @@
 #ifndef LINUX_DEVICE_H
+#define LINUX_DEVICE_H
 
 struct device {
 	void *parent;
diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
index fddfa2fbb276..65e2974b3908 100644
--- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -59,5 +59,6 @@ enum dma_data_direction {
  * instead.
  */
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
+#define DMA_ATTR_DEBUGGING_IGNORE_CACHELINES	0
 
 #endif
diff --git a/tools/virtio/linux/mod_devicetable.h b/tools/virtio/linux/mod_devicetable.h
new file mode 100644
index 000000000000..3ba594b8229d
--- /dev/null
+++ b/tools/virtio/linux/mod_devicetable.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MOD_DEVICETABLE_H
+#define _LINUX_MOD_DEVICETABLE_H
+
+#include <linux/types.h>
+
+struct virtio_device_id {
+	__u32 device;
+	__u32 vendor;
+};
+
+#define VIRTIO_DEV_ANY_ID	0xffffffff
+
+#endif /* _LINUX_MOD_DEVICETABLE_H */
diff --git a/tools/virtio/linux/slab.h b/tools/virtio/linux/slab.h
index 319dcaa07755..13d94c6f663c 100644
--- a/tools/virtio/linux/slab.h
+++ b/tools/virtio/linux/slab.h
@@ -4,4 +4,8 @@
 #define GFP_ATOMIC 0
 #define __GFP_NOWARN 0
 #define __GFP_ZERO 0
+#define kmalloc_obj(VAR_OR_TYPE, ...) \
+	kmalloc(sizeof(VAR_OR_TYPE), GFP_KERNEL)
+#define kmalloc_objs(VAR_OR_TYPE, COUNT, ...) \
+	kmalloc_array((COUNT), sizeof(VAR_OR_TYPE), GFP_KERNEL)
 #endif
diff --git a/tools/virtio/linux/virtio_features.h b/tools/virtio/linux/virtio_features.h
new file mode 100644
index 000000000000..18c56610e209
--- /dev/null
+++ b/tools/virtio/linux/virtio_features.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VIRTIO_FEATURES_H
+#define _LINUX_VIRTIO_FEATURES_H
+
+#include <linux/bug.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#define VIRTIO_FEATURES_U64S	2
+#define VIRTIO_FEATURES_BITS	(VIRTIO_FEATURES_U64S * 64)
+
+#define VIRTIO_BIT(b)		(1ULL << ((b) & 0x3f))
+#define VIRTIO_U64(b)		((b) >> 6)
+
+#define VIRTIO_DECLARE_FEATURES(name)			\
+	union {						\
+		u64 name;					\
+		u64 name##_array[VIRTIO_FEATURES_U64S];	\
+	}
+
+static inline bool virtio_features_chk_bit(unsigned int bit)
+{
+	return bit < VIRTIO_FEATURES_BITS;
+}
+
+static inline bool virtio_features_test_bit(const u64 *features,
+					    unsigned int bit)
+{
+	return virtio_features_chk_bit(bit) &&
+	       !!(features[VIRTIO_U64(bit)] & VIRTIO_BIT(bit));
+}
+
+static inline void virtio_features_set_bit(u64 *features, unsigned int bit)
+{
+	if (virtio_features_chk_bit(bit))
+		features[VIRTIO_U64(bit)] |= VIRTIO_BIT(bit);
+}
+
+static inline void virtio_features_clear_bit(u64 *features, unsigned int bit)
+{
+	if (virtio_features_chk_bit(bit))
+		features[VIRTIO_U64(bit)] &= ~VIRTIO_BIT(bit);
+}
+
+static inline void virtio_features_zero(u64 *features)
+{
+	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_U64S);
+}
+
+static inline void virtio_features_from_u64(u64 *features, u64 from)
+{
+	virtio_features_zero(features);
+	features[0] = from;
+}
+
+#endif /* _LINUX_VIRTIO_FEATURES_H */
-- 
2.51.0

