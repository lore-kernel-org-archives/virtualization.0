From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 01/15] virtio: synchronize virtio-iommu headers
	with Linux
Date: Fri,  7 Apr 2017 20:24:41 +0100
Message-ID: <20170407192455.26814-2-jean-philippe.brucker__931.530915159051$1491593056$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

Pull virtio-iommu header (initial proposal) from Linux. Also add
virtio_config.h because it defines VIRTIO_F_IOMMU_PLATFORM, which I'm
going to need soon, and it's not provided by my toolchain.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/linux/virtio_config.h |  74 ++++++++++++++++++++++
 include/linux/virtio_ids.h    |   4 ++
 include/linux/virtio_iommu.h  | 142 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 include/linux/virtio_config.h
 create mode 100644 include/linux/virtio_iommu.h

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
new file mode 100644
index 00000000..648b688f
--- /dev/null
+++ b/include/linux/virtio_config.h
@@ -0,0 +1,74 @@
+#ifndef _LINUX_VIRTIO_CONFIG_H
+#define _LINUX_VIRTIO_CONFIG_H
+/* This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
+ * anyone can use the definitions to implement compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE. */
+
+/* Virtio devices use a standardized configuration space to define their
+ * features and pass configuration information, but each implementation can
+ * store and access that space differently. */
+#include <linux/types.h>
+
+/* Status byte for guest to report progress, and synchronize features. */
+/* We have seen device and processed generic fields (VIRTIO_CONFIG_F_VIRTIO) */
+#define VIRTIO_CONFIG_S_ACKNOWLEDGE	1
+/* We have found a driver for the device. */
+#define VIRTIO_CONFIG_S_DRIVER		2
+/* Driver has used its parts of the config, and is happy */
+#define VIRTIO_CONFIG_S_DRIVER_OK	4
+/* Driver has finished configuring features */
+#define VIRTIO_CONFIG_S_FEATURES_OK	8
+/* Device entered invalid state, driver must reset it */
+#define VIRTIO_CONFIG_S_NEEDS_RESET	0x40
+/* We've given up on this device. */
+#define VIRTIO_CONFIG_S_FAILED		0x80
+
+/* Some virtio feature bits (currently bits 28 through 32) are reserved for the
+ * transport being used (eg. virtio_ring), the rest are per-device feature
+ * bits. */
+#define VIRTIO_TRANSPORT_F_START	28
+#define VIRTIO_TRANSPORT_F_END		34
+
+#ifndef VIRTIO_CONFIG_NO_LEGACY
+/* Do we get callbacks when the ring is completely used, even if we've
+ * suppressed them? */
+#define VIRTIO_F_NOTIFY_ON_EMPTY	24
+
+/* Can the device handle any descriptor layout? */
+#define VIRTIO_F_ANY_LAYOUT		27
+#endif /* VIRTIO_CONFIG_NO_LEGACY */
+
+/* v1.0 compliant. */
+#define VIRTIO_F_VERSION_1		32
+
+/*
+ * If clear - device has the IOMMU bypass quirk feature.
+ * If set - use platform tools to detect the IOMMU.
+ *
+ * Note the reverse polarity (compared to most other features),
+ * this is for compatibility with legacy systems.
+ */
+#define VIRTIO_F_IOMMU_PLATFORM		33
+#endif /* _LINUX_VIRTIO_CONFIG_H */
diff --git a/include/linux/virtio_ids.h b/include/linux/virtio_ids.h
index 5f60aa4b..934ed3d3 100644
--- a/include/linux/virtio_ids.h
+++ b/include/linux/virtio_ids.h
@@ -39,6 +39,10 @@
 #define VIRTIO_ID_9P		9 /* 9p virtio console */
 #define VIRTIO_ID_RPROC_SERIAL 11 /* virtio remoteproc serial link */
 #define VIRTIO_ID_CAIF	       12 /* Virtio caif */
+#define VIRTIO_ID_GPU          16 /* virtio GPU */
 #define VIRTIO_ID_INPUT        18 /* virtio input */
+#define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
+#define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_IOMMU	    61216 /* virtio IOMMU (temporary) */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/linux/virtio_iommu.h b/include/linux/virtio_iommu.h
new file mode 100644
index 00000000..beb21d44
--- /dev/null
+++ b/include/linux/virtio_iommu.h
@@ -0,0 +1,142 @@
+/*
+ * Copyright (C) 2017 ARM Ltd.
+ *
+ * This header is BSD licensed so anyone can use the definitions
+ * to implement compatible drivers/servers:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of ARM Ltd. nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+#ifndef _LINUX_VIRTIO_IOMMU_H
+#define _LINUX_VIRTIO_IOMMU_H
+
+/* Feature bits */
+#define VIRTIO_IOMMU_F_INPUT_RANGE		0
+#define VIRTIO_IOMMU_F_IOASID_BITS		1
+#define VIRTIO_IOMMU_F_MAP_UNMAP		2
+#define VIRTIO_IOMMU_F_BYPASS			3
+
+__attribute__((packed))
+struct virtio_iommu_config {
+	/* Supported page sizes */
+	__u64					page_sizes;
+	struct virtio_iommu_range {
+		__u64				start;
+		__u64				end;
+	} input_range;
+	__u8 					ioasid_bits;
+};
+
+/* Request types */
+#define VIRTIO_IOMMU_T_ATTACH			0x01
+#define VIRTIO_IOMMU_T_DETACH			0x02
+#define VIRTIO_IOMMU_T_MAP			0x03
+#define VIRTIO_IOMMU_T_UNMAP			0x04
+
+/* Status types */
+#define VIRTIO_IOMMU_S_OK			0x00
+#define VIRTIO_IOMMU_S_IOERR			0x01
+#define VIRTIO_IOMMU_S_UNSUPP			0x02
+#define VIRTIO_IOMMU_S_DEVERR			0x03
+#define VIRTIO_IOMMU_S_INVAL			0x04
+#define VIRTIO_IOMMU_S_RANGE			0x05
+#define VIRTIO_IOMMU_S_NOENT			0x06
+#define VIRTIO_IOMMU_S_FAULT			0x07
+
+__attribute__((packed))
+struct virtio_iommu_req_head {
+	__u8					type;
+	__u8					reserved[3];
+};
+
+__attribute__((packed))
+struct virtio_iommu_req_tail {
+	__u8					status;
+	__u8					reserved[3];
+};
+
+__attribute__((packed))
+struct virtio_iommu_req_attach {
+	struct virtio_iommu_req_head		head;
+
+	__le32					address_space;
+	__le32					device;
+	__le32					reserved;
+
+	struct virtio_iommu_req_tail		tail;
+};
+
+__attribute__((packed))
+struct virtio_iommu_req_detach {
+	struct virtio_iommu_req_head		head;
+
+	__le32					device;
+	__le32					reserved;
+
+	struct virtio_iommu_req_tail		tail;
+};
+
+#define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
+#define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
+#define VIRTIO_IOMMU_MAP_F_EXEC			(1 << 2)
+
+#define VIRTIO_IOMMU_MAP_F_MASK			(VIRTIO_IOMMU_MAP_F_READ |	\
+						 VIRTIO_IOMMU_MAP_F_WRITE |	\
+						 VIRTIO_IOMMU_MAP_F_EXEC)
+
+__attribute__((packed))
+struct virtio_iommu_req_map {
+	struct virtio_iommu_req_head		head;
+
+	__le32					address_space;
+	__le32					flags;
+	__le64					virt_addr;
+	__le64					phys_addr;
+	__le64					size;
+
+	struct virtio_iommu_req_tail		tail;
+};
+
+__attribute__((packed))
+struct virtio_iommu_req_unmap {
+	struct virtio_iommu_req_head		head;
+
+	__le32					address_space;
+	__le32					flags;
+	__le64					virt_addr;
+	__le64					size;
+
+	struct virtio_iommu_req_tail		tail;
+};
+
+union virtio_iommu_req {
+	struct virtio_iommu_req_head		head;
+
+	struct virtio_iommu_req_attach		attach;
+	struct virtio_iommu_req_detach		detach;
+	struct virtio_iommu_req_map		map;
+	struct virtio_iommu_req_unmap		unmap;
+};
+
+#endif
-- 
2.12.1
