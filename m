Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73D1898FB
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699739; cv=none; b=ZqJ5fDsYn9/0IM8evh3y/hxyfcr91aofaE5xJyz5EmlmKOYcvmQqksjcrBz2rq3A0y3exX6yCKqrCjTcu1GK8M24Z9Kk4YhKkCoNZA0o1h7TsUFNS8fusn37k9EVPjgkjFHZ2fiPLW/M108Cl7bmcXXi8TnYblEOXSAbbwOADRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699739; c=relaxed/simple;
	bh=HltxefiL6k+U5YK4QfCZDL/2FNEh6g7eQQ6RQWVBpB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2OpfZTamLAlwK1yQEP5bO3B1zkxt45QOVovc3Ju+BMrhlhfPibA0J1MPTqktDc1Bb3dwODEi3A3XrL+HyNHw1hW5xxwKOut0OKfZEuZ9ktr2TEagRYjhL6fckM3/Q6mQrVeBBSB3oXjtimUAAX+Vpof/9s6CvR5mBvshBrkxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WirkJdko; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WirkJdko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782699716;
	bh=Yz5AE38NhFeVYvoMwpCJmqJM6dGFyON92ilIWGAZwUE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WirkJdkoqZsCXwfbNCsK6XotbXShaV17oDsY0LhOd84qRe12RzeV9aBkf2qCxScJE
	 gxvIl3rE76PwwGAfZ9/UYYH93M10mOC4Z5jz0/id0Bfmw42k4waMUMFmHSnorOQBAS
	 zzj61lt7UQqXhMu4TY5YjKNaiUEiCe+Yhoq4oPuk=
X-QQ-mid: esmtpsz17t1782699694td2e9c7b6
X-QQ-Originating-IP: jEpqRrbJOYYw+/NSbVKSAiQ0KVR4AuvRLQaTnaCaoT0=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 10:21:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15598299483017084048
EX-QQ-RecipientCnt: 11
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: akpm@linux-foundation.org,
	rppt@kernel.org,
	ljs@kernel.org,
	pabeni@redhat.com,
	chenyichong@uniontech.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 1/2] tools/virtio: Add missing compat definitions for vhost_net_test
Date: Mon, 29 Jun 2026 10:21:23 +0800
Message-Id: <20260629022124.131894-2-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260629022124.131894-1-chenyichong@uniontech.com>
References: <20260629022124.131894-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MprLxAqa8sV2Jf+7vLNnca3+sXj1Q1HWA8rNBAH1Vnf3+izcjqCLNCcQ
	eHP3Zwij6p6uy/kWpmaCyw4vHFIV1l5jovhOGl/VJh1PWmFVQwIs2vG+/gPdrsgLWuYV6Ip
	Iy10W6CWejNbyeVCgyyHUn3IZ2eAyIQp/NLb+JSL22Y8nRxESWHtYWZr2C+x90Wt6XqWLas
	LosjhTHSMvuRLo2QRgSMS4Gz2cB8Ogg2/Hpsn+r1CBwAD6ab1PE5iKaACYeeO98NQ46nOkt
	N/vnafmrYCpThdYDJ1H10nsLdd/CxAzQIUgvefxvFoaKwL5wH/VMC/kEBGcCLJ46sy982G+
	HYt35zLmW/1g5vhV1aSwLi6BpkvoOTppxs13yyYXDDgRz0hcquo28YyeJoWKkDBrOm1qSAu
	qdjrNcmEG9/1tYVfjEr5GGKcYSd0yP+qv+L4gpFRpPUS4mzyu/0WUkqR3LV66h+J7A8Kfc1
	6afujC2OAxPfhJa5ZmWp428J6Z8eNBUg3r0I58eJi70LP6gF0+5iC+BltFVDbNxe/ZOg5PS
	3adduTzHaUujQN+QkETeS1GANFsRAbSeo4/Dut1U8X4rfNlxQKrIXQButzs7K4SwJ+oFpVp
	smDyZWf+aqewuWFiSDKJ4Ip4Pf0PQLusFBX7Vy1IMX6/XFpEp+qNVvrLjWS5baIXWJUi9Qd
	gLH3E10ZEVXg2Py6TadLzdxXpFF26jS4Iv+beh0Vqb48hnJWhFu0RtTHa97ZQ9ROdbtX/1u
	jAv/hnDdhq23fxn6j57oUpVh1NqjIidQ28dT2ao/RurnDmP1nkWS0TAa4ofhcr3D6u4N17u
	SUPxaVTGKDV3yKW2I0Je+l1m/hV52KhMj+pGSc5pXmtCI5m2OrkZ+E8BP378ZJCA2ox//tP
	cfL7IAe4Y53avsC8zu/yyNN6paD/yuotCEMYaIThKCei+1VEHLAs1av8XsMIvmskpNN59jM
	8AzaLP7+gbOsV1mR2jIIVkHChddwsmlHDGYwsitZwnuXcZtmnbGRGMiNF45wQYdcgyk1MPb
	B2G9vc3R+Xw2xwbLveROBztGfhJeWq51i+W2L7GGxn+0GEF3pV3JF3VFhswagSECnuqQiMZ
	3qU6tl0Ecjg
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

vhost_net_test builds virtio_ring.c in userspace.

Recent virtio headers pull in helper headers that are not provided by
the tools/virtio compatibility layer, including asm/percpu_types.h,
linux/completion.h, linux/mod_devicetable.h and
linux/virtio_features.h.

Add the missing compat definitions and the DMA attribute used by the
current virtio ring code.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/virtio/asm/percpu_types.h      |  7 +++
 tools/virtio/linux/completion.h      |  9 ++++
 tools/virtio/linux/device.h          |  1 +
 tools/virtio/linux/dma-mapping.h     |  1 +
 tools/virtio/linux/mod_devicetable.h | 14 +++++
 tools/virtio/linux/virtio_features.h | 79 ++++++++++++++++++++++++++++
 6 files changed, 111 insertions(+)
 create mode 100644 tools/virtio/asm/percpu_types.h
 create mode 100644 tools/virtio/linux/completion.h
 create mode 100644 tools/virtio/linux/mod_devicetable.h
 create mode 100644 tools/virtio/linux/virtio_features.h

diff --git a/tools/virtio/asm/percpu_types.h b/tools/virtio/asm/percpu_types.h
new file mode 100644
index 000000000000..4eb53d93c099
--- /dev/null
+++ b/tools/virtio/asm/percpu_types.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_PERCPU_TYPES_H
+#define _ASM_PERCPU_TYPES_H
+
+#define __percpu_qual
+
+#endif /* _ASM_PERCPU_TYPES_H */
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
index 8d1a16cb20db..b9fc5e8338e3 100644
--- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -61,5 +61,6 @@ enum dma_data_direction {
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
 #define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
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
diff --git a/tools/virtio/linux/virtio_features.h b/tools/virtio/linux/virtio_features.h
new file mode 100644
index 000000000000..04cbb9622ec7
--- /dev/null
+++ b/tools/virtio/linux/virtio_features.h
@@ -0,0 +1,79 @@
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
+		u64 name##_array[VIRTIO_FEATURES_U64S];\
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
+static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
+{
+	int i;
+
+	for (i = 0; i < VIRTIO_FEATURES_U64S; ++i)
+		if (f1[i] != f2[i])
+			return false;
+	return true;
+}
+
+static inline void virtio_features_copy(u64 *to, const u64 *from)
+{
+	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_U64S);
+}
+
+static inline void virtio_features_andnot(u64 *to, const u64 *f1, const u64 *f2)
+{
+	int i;
+
+	for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
+		to[i] = f1[i] & ~f2[i];
+}
+
+#endif /* _LINUX_VIRTIO_FEATURES_H */
-- 
2.51.0

