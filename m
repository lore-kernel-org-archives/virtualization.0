Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0372BEC4E
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961490; cv=none; b=p3/Breb8jiWj6mA20i++oJ8Fb0gKK6XEhpEV5IdLWvAsk7ssAHPD8kVC6DBlOPkDGbQ65VDxjYZ/FW10ZIEd3Y0Y6ZRJrwGmILaxwhZ3m4LVyS28X0dezYH/t7z/xJOYkC/HuOO7fqpqD4/fm/48r7QAxTW4QNoAgIjnNdPc+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961490; c=relaxed/simple;
	bh=TEPRqTYbMTe/BUqltdsIC35f7WnouKJWyYVmxon8PSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8mU141i8wcPqi8KSzu1wDtnNULJkgozhePgyz7BjIWaMWLWCHls/12UoM6pNLanzI0OxTu7PUa3/KsqkGVDV+XOYyFdJoMBil0++uRitOKKnhqHVXCp3rmHmm7il19QWmK/4kP0RK36bdcXavY561bn7bNxlAvwahEvyF4+Ud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BRKTSq2c; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BRKTSq2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782961466;
	bh=/8dZy5foASdLgCT2t4XH4YFVkJ+c1YLZPElgqEIeEnw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BRKTSq2cp53UbMzio7EGEuHJUScWYnh/iPXZYBdYS37XZsLAUJiNOD1VZ860NdLBc
	 HlZXrox+rERCSMk8ELTqaEaD7yo8Qa9QZb/D1MNAEf3U0Dl6TKxvP/6NB7esYSRXun
	 IWwTaBpnX0zAZ/6NRmQi5OPwxOrnmvbInbNzKFHo=
X-QQ-mid: esmtpgz15t1782961448t4ba970d3
X-QQ-Originating-IP: Y6qJD1ojZm95O781LwkvXw/EwEQCsB5RbP0JgBDy+iA=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Jul 2026 11:04:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9065969092702021597
EX-QQ-RecipientCnt: 12
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	akpm@linux-foundation.org
Cc: sj@kernel.org,
	rppt@kernel.org,
	ljs@kernel.org,
	pabeni@redhat.com,
	chenyichong@uniontech.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] tools/virtio: Add missing compat definitions for vhost_net_test
Date: Thu,  2 Jul 2026 11:03:57 +0800
Message-Id: <20260702030358.308155-2-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260702030358.308155-1-chenyichong@uniontech.com>
References: <20260702030358.308155-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MrfJYRspGRl/w59Ftt3d+EsXVNW2qQ1SqIORpITpzWqdv0vgaFHqR9Y1
	lJf7HleWsfkjLdCf6YEh+sKVoxE7w1HOYbTCyBcDWm6L2w5Ul4RJmOfRMAt4/bY1dC72hHK
	Ek705+33RUdO+W+nV7JxFN7VcH/WmlI9Ws5715yEyvcNJjX0Eltqc5HwsAhvaS7vea9OQ7z
	RarrAN8zoN3QqT+kQ9VQyfKw1fBFGI/FFV5sB4xwSESZ2+8Bu4zZ6dM3ChSObcdPWIu8HTw
	WcXIxS9AGQdNwq/PVfmDFYa6eTzEjx7Dnz9K75neb/iXSS3BZSoGxDZE4RqQ3lpC67mBpLj
	HmVq4+o+daEYolAVaF75fidE+Z8D98AfcZzIynOXfjN0RYl2nm08+tanRxswLhThIPEoX6r
	IaZbRyZYJkzke6Pgv4oSritH+8SmX5No1wZ67CvNGGeq/XCUzIlO4+mur1hxAHskRVX3Sxw
	YUDTVOjr5iClu3TFQf59+WyhkYXdYX9uMIXIQt70MaaFlyySNoZZzQFehl/l2lTxjggkBzC
	mz7JdOiCrEl7UC5BVWLFaVRmg+AglDsYzjqQUukWamdz8EpXMe1z0m3q4HkgnE5Jl5++yFc
	uruHei+yDzoHNmkOE1NNO+tDWfseo3Y5t1hhPyH0axtI3MmO7YvwrWsaO7HzEbk4UNO3Wgt
	NTEAru9sK3b1Vo/6mk+z9qEIECuz0FAiGDZc6zVjatAvLcsFiyEnGNZlp4WqWKQXBMsAGlu
	x+V8aLBpeaVuXm4riKTmyAFCTKLGlp5sEO5KZNNNHiPs5J09rsXcHNbR/akaSIb1OO+uVMF
	RblXAAqLtBfdRz2gujQEFCPjnoMI1KCM2sHsqe3xouTkmO3bVnP/CIgVqavm2mAliQrSMn3
	Eo6hw1PWo4HJ1HXiRlh78GNW+sCYglz7yremDcbpI+BzdC02sW2I0oradLVk9F69Tvzfwoz
	8rMUgciaLWiHqyrnl0byq5qQRPKXe5NiurNUR13eRxVlDF18hdHE8GW01Jfc6mmD0pib1y/
	q0pNfbREjVeX29cZHk8Pe2XH3Y7Ote+IIFH0bO7+CfdX5Y62BQ
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

vhost_net_test builds virtio_ring.c in userspace.

Recent virtio headers pull in helper headers that are not provided by
the tools/virtio compatibility layer, including asm/percpu_types.h,
linux/completion.h, linux/mod_devicetable.h and linux/virtio_features.h.

Add the missing compat definitions and the DMA attribute used by the
current virtio ring code.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Tested-by: SJ Park <sj@kernel.org>
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

