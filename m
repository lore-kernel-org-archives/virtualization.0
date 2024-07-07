Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C83CF51
	for <virtualization@lists.linux-foundation.org>; Sun,  7 Jul 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720368401; cv=none; b=JoMTfoMWGqjUwAO2RBLQsUrfSAyuZUi+Flc75hO1MrnuSbxqnFwoeL0HAbBBvW0WqE256S162MI2U9OW4slMDPmT7vdN0oICXlMhtGFtpXAM9gNoJlsNqUl8AF3Pfd3g9cYegUrLemjp8Xu9xtr9QN0ntb+uANV2Wfbl1taUu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720368401; c=relaxed/simple;
	bh=qmGFeqIVRtl5jDHfaj0Y735c93t8wRQZkdRzBL0WRt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OtC4YBffRIY2U33bPwuGv7dP4ulT4lfIQL28odKHDd5icJHUKe8Og/74y5nGdyGLfuwRYctjLhw9AOkcyXAtTJxYrgSv/j+/BqPHDC2FRA5OosHR40xFXfp7L5yVorwWsoAkkjiQt0PpkvmQvz82AtZwiBRwGxjJDcasvvfV0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzpMXfo4; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzpMXfo4"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4019F40252
	for <virtualization@lists.linux-foundation.org>; Sun,  7 Jul 2024 16:06:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oVziCMXnKUMd for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Jul 2024 16:06:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com; envelope-from=krashmisha@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D5E624024F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5E624024F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IzpMXfo4
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5E624024F
	for <virtualization@lists.linux-foundation.org>; Sun,  7 Jul 2024 16:06:36 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso38727281fa.0
        for <virtualization@lists.linux-foundation.org>; Sun, 07 Jul 2024 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720368394; x=1720973194; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/HhqMkLGKu3CQaSHjV4RBU6xYguRPqmHbickJ7CSiE=;
        b=IzpMXfo4PotDaNBqyOYetk5ZkxjZU8IYXI8CB22rJ8VQhn++vQeugv234h9+GlAZPl
         2h3CASbmiRCpdH8LLHQ3sMTg1L36QU3aupb2iBoU6xpDgzJny1En4T0dIFPh05doLTYw
         2PTTgm+8D8ExXKYV031Ab1FQZXZDBiBA40WNlPBrbFl1edvtEvjuwPHp57YB6WIcFazZ
         vbr47DHDjNNxdTm4qDVJNyKiAtNgD7np8NRhr4jjOoRkbgSry3wkNeDQ9exbWtEukzO8
         /aCk1YrZsu2jPXmo0uVcUXThQSMOsFMGoJpN5nIdJahn/HT7DKzyruHG4PqZq96kXxSi
         1ZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720368394; x=1720973194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/HhqMkLGKu3CQaSHjV4RBU6xYguRPqmHbickJ7CSiE=;
        b=QPDDOSq0jLvF0EOGlAf2Uro3Qw0IH4JYrkFk7T0annh4UeYzm9RNpElOtvd/NIJUZ3
         mbKMDA3V67h0OYK+8bQNEdtjy1dnnZxVUmghl3BIfuUiqqxza85QRKVLRzleivcPIJdI
         iZPO7voVoeMXfz4TOJx4TtEuPE5THPgYdqr1kIl2tsqMDzpfjHzvpcvCJwQ/s9F+yGUX
         52Wcm2L7QQE6j0IZgCNBHEZ9k66UTLdc8WZ/IKxYaI4l4wq/bcMbat0R+nSgafcZeLVv
         gQ5jAicUHayscTqwTiEPmKck50xQkkfnF1XNCK0sQRsos5Q1npv+OT32CFBaJJIL/j5c
         xY1g==
X-Forwarded-Encrypted: i=1; AJvYcCWG2i6ETbb3d/KgK52uUZ9VWvnwWu8ZgMqGlX4YJk1xdz0lBj+wmeDf/u/LDPTfSn8ESEj/V/l08eRPjwY+A5hGeWgNCIhkwAyWgKdFJ4JLuAtuVsriiKM5CA==
X-Gm-Message-State: AOJu0Yzzvc+worvlxHG8ThmfYlMlDzvtmjMYicO605ND1XP5xZ5HJWAa
	eKfeS+3WRLZvpcSJLC+S1PMWN12gqFJO1C6H7CIwNSqVMWvl0A4k
X-Google-Smtp-Source: AGHT+IFJSW37MHNz7AelfnqDiXzYq5LprGNfj8wWYP+ZRjdVn9Y3BBHMdVaW4fab9GjZ4VU1VDOlUw==
X-Received: by 2002:a2e:a316:0:b0:2ee:7c37:a5d5 with SMTP id 38308e7fff4ca-2ee8ed879fbmr64520731fa.25.1720368393993;
        Sun, 07 Jul 2024 09:06:33 -0700 (PDT)
Received: from localhost.localdomain ([176.194.243.4])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee962b0f11sm6429581fa.34.2024.07.07.09.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 09:06:33 -0700 (PDT)
From: Mikhail Krasheninnikov <krashmisha@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Mikhail Krasheninnikov <krashmisha@gmail.com>,
	Matwey Kornilov <matwey.kornilov@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2] mmc/virtio: Add virtio MMC driver for QEMU emulation
Date: Sun,  7 Jul 2024 16:05:55 +0000
Message-Id: <20240707160555.78062-1-krashmisha@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new virtio MMC driver to enable virtio SD/MMC card
emulation with QEMU. This driver allows emulating MMC cards in
virtual environments, enhancing functionality and testing
capabilities within QEMU.

Link to the QEMU patch:
https://lists.nongnu.org/archive/html/qemu-block/2024-07/msg00221.html

No changes to existing dependencies or documentation.

Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
CC: Matwey Kornilov <matwey.kornilov@gmail.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: virtualization@lists.linux-foundation.org

---
Changes from v1:
 - Add MAINTAINERS entry
 - Refactor includes
 - Change CPU endian format to little endian for device communication
 - Move structs that belonged to uapi
 - Validate multiple fields
 - Introduce mutexes for safe request handling
 - Call virtio_device_ready before adding host
 - Fix removal of the device

 MAINTAINERS                       |  15 ++
 drivers/mmc/host/Kconfig          |  14 ++
 drivers/mmc/host/Makefile         |   2 +
 drivers/mmc/host/virtio-sdhci.c   | 258 ++++++++++++++++++++++++++++++
 drivers/mmc/host/virtio-sdhci.h   |  40 +++++
 include/uapi/linux/virtio-sdhci.h |  39 +++++
 include/uapi/linux/virtio_ids.h   |   1 +
 7 files changed, 369 insertions(+)
 create mode 100644 drivers/mmc/host/virtio-sdhci.c
 create mode 100644 drivers/mmc/host/virtio-sdhci.h
 create mode 100644 include/uapi/linux/virtio-sdhci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..be86156cd66c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22907,6 +22907,21 @@ S:	Maintained
 F:	drivers/nvdimm/nd_virtio.c
 F:	drivers/nvdimm/virtio_pmem.c
 
+VIRTIO SDHCI DRIVER
+M:	Mikhail Krasheninnikov <krashmisha@gmail.com>
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	Jason Wang <jasowang@redhat.com>
+M:	Paolo Bonzini <pbonzini@redhat.com>
+M:	Stefan Hajnoczi <stefanha@redhat.com>
+M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+L:	virtualization@lists.linux-foundation.org
+L:	linux-mmc@vger.kernel.org
+L:	OASIS-virtio@ConnectedCommunity.org
+S:	Maintained
+F:	drivers/mmc/host/virtio-sdhci.c
+F:	drivers/mmc/host/virtio-sdhci.h
+F:	include/uapi/linux/virtio-sdhci.h
+
 VIRTIO SOUND DRIVER
 M:	Anton Yakovlev <anton.yakovlev@opensynergy.com>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 554e67103c1a..d62d669ee117 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1069,3 +1069,17 @@ config MMC_LITEX
 	  module will be called litex_mmc.
 
 	  If unsure, say N.
+
+config SDHCI_VIRTIO
+	tristate "VirtIO SDHCI Host Controller support"
+	depends on VIRTIO
+	help
+	  This enables support for the Virtio SDHCI driver, which allows the
+	  kernel to interact with SD/MMC devices over Virtio. Virtio is a
+	  virtualization standard for network and disk device drivers,
+	  providing a common API for virtualized environments.
+
+	  Enable this option if you are running the kernel in a virtualized
+	  environment and need SD/MMC support via Virtio.
+
+	  If unsure, say N.
\ No newline at end of file
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index a693fa3d3f1c..f9b05a07c6db 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -108,3 +108,5 @@ endif
 
 obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
 sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
+
+obj-$(CONFIG_SDHCI_VIRTIO)	+= virtio-sdhci.o
\ No newline at end of file
diff --git a/drivers/mmc/host/virtio-sdhci.c b/drivers/mmc/host/virtio-sdhci.c
new file mode 100644
index 000000000000..1a637ab5e010
--- /dev/null
+++ b/drivers/mmc/host/virtio-sdhci.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  VirtIO SD/MMC driver
+ *
+ *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
+ */
+
+#include "virtio-sdhci.h"
+#include "linux/mmc/host.h"
+#include "linux/virtio.h"
+#include "linux/virtio_config.h"
+#include "linux/completion.h"
+#include "uapi/linux/virtio-sdhci.h"
+
+struct virtio_sdhci_host {
+	struct virtio_device *vdev;
+	struct mmc_host *mmc;
+	struct virtqueue *vq;
+	struct mmc_request *current_request;
+
+	struct virtio_mmc_request virtio_request;
+	struct virtio_mmc_response virtio_response;
+
+	struct completion request_handled;
+	spinlock_t handling_request;
+};
+
+static void virtio_sdhci_vq_callback(struct virtqueue *vq)
+{
+	unsigned int len;
+	struct mmc_host *mmc;
+	struct virtio_sdhci_host *host;
+	struct virtio_mmc_request *virtio_request;
+	struct virtio_mmc_response *virtio_response;
+	struct mmc_request *mrq;
+
+	mmc = vq->vdev->priv;
+	host = mmc_priv(mmc);
+	mrq = host->current_request;
+	virtio_request = &host->virtio_request;
+
+	virtio_response = virtqueue_get_buf(vq, &len);
+
+	if (!virtio_response)
+		return;
+
+	memcpy(mrq->cmd->resp, virtio_response->cmd_resp,
+	       min(4 * (int)sizeof(u32), virtio_response->cmd_resp_len));
+
+	if (virtio_request->flags & VIRTIO_MMC_REQUEST_DATA) {
+		mrq->data->bytes_xfered =
+			min((unsigned int)virtio_request->buf_len,
+			    mmc->max_blk_size);
+
+		if (!(virtio_request->flags & VIRTIO_MMC_REQUEST_WRITE)) {
+			sg_copy_from_buffer(mrq->data->sg, mrq->data->sg_len,
+					    virtio_response->buf,
+					    mrq->data->bytes_xfered);
+		}
+	}
+
+	complete(&host->request_handled);
+}
+
+static void virtio_sdhci_send_and_recv_request_from_qemu(struct virtio_sdhci_host *data)
+{
+	struct scatterlist sg_out_linux, sg_in_linux;
+
+	sg_init_one(&sg_out_linux, &data->virtio_request,
+		    sizeof(struct virtio_mmc_request));
+	sg_init_one(&sg_in_linux, &data->virtio_response,
+		    sizeof(struct virtio_mmc_response));
+
+	struct scatterlist *request[] = { &sg_out_linux, &sg_in_linux };
+
+	if (virtqueue_add_sgs(data->vq, request, 1, 1, &data->virtio_response,
+			      GFP_KERNEL) < 0) {
+		dev_crit(&data->vdev->dev, "Failed to add sg\n");
+		return;
+	}
+
+	virtqueue_kick(data->vq);
+	wait_for_completion(&data->request_handled);
+}
+
+static inline size_t __calculate_len(struct mmc_data *data)
+{
+	size_t len = 0;
+
+	for (int i = 0; i < data->sg_len; i++)
+		len += data->sg[i].length;
+	return len;
+}
+
+/* MMC layer callbacks */
+
+static void virtio_sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct virtio_sdhci_host *host;
+	struct virtio_mmc_request *virtio_req;
+	struct mmc_data *mrq_data;
+
+	host = mmc_priv(mmc);
+
+	spin_lock(&host->handling_request);
+
+	WARN_ON(host->current_request != NULL);
+
+	host->current_request = mrq; // Saving the request for the callback
+
+	virtio_req = &host->virtio_request;
+	memset(virtio_req, 0, sizeof(struct virtio_mmc_request));
+
+	virtio_req->request.opcode = mrq->cmd->opcode;
+	virtio_req->request.arg = mrq->cmd->arg;
+
+	mrq_data = mrq->data;
+	if (mrq_data) {
+		virtio_req->flags |= VIRTIO_MMC_REQUEST_DATA;
+
+		virtio_req->buf_len = __calculate_len(mrq->data);
+
+		virtio_req->flags |= ((mrq_data->flags & MMC_DATA_WRITE) ?
+					      VIRTIO_MMC_REQUEST_WRITE :
+					      0);
+		if (virtio_req->flags & VIRTIO_MMC_REQUEST_WRITE) {
+			sg_copy_to_buffer(mrq_data->sg, mrq_data->sg_len,
+					  virtio_req->buf, virtio_req->buf_len);
+		}
+	}
+
+	if (mrq->stop) {
+		virtio_req->flags |= VIRTIO_MMC_REQUEST_STOP;
+
+		virtio_req->stop_req.opcode = mrq->stop->opcode;
+		virtio_req->stop_req.arg = mrq->stop->arg;
+	}
+
+	if (mrq->sbc) {
+		virtio_req->flags |= VIRTIO_MMC_REQUEST_SBC;
+
+		virtio_req->sbc_req.opcode = mrq->sbc->opcode;
+		virtio_req->sbc_req.arg = mrq->sbc->arg;
+	}
+
+	virtio_sdhci_send_and_recv_request_from_qemu(host);
+
+	host->current_request = NULL;
+	spin_unlock(&host->handling_request);
+	mmc_request_done(mmc, mrq);
+}
+
+static void virtio_sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+}
+
+static int virtio_sdhci_get_ro(struct mmc_host *mmc)
+{
+	return 0;
+}
+
+static int virtio_sdhci_get_cd(struct mmc_host *mmc)
+{
+	return 1;
+}
+
+static const struct mmc_host_ops virtio_sdhci_host_ops = {
+	.request = virtio_sdhci_request,
+	.set_ios = virtio_sdhci_set_ios,
+	.get_ro = virtio_sdhci_get_ro,
+	.get_cd = virtio_sdhci_get_cd,
+};
+
+static inline void __fill_host_attr(struct mmc_host *host)
+{
+	host->ops = &virtio_sdhci_host_ops;
+	host->f_min = 300000;
+	host->f_max = 500000;
+	host->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	host->caps = MMC_CAP_SD_HIGHSPEED;
+	host->caps2 = MMC_CAP2_NO_SDIO | MMC_CAP2_NO_MMC | MMC_CAP2_HS400;
+	host->max_blk_size = 4096;
+}
+
+static int create_host(struct virtio_device *vdev)
+{
+	int err;
+	struct mmc_host *mmc;
+	struct virtio_sdhci_host *host;
+
+	mmc = mmc_alloc_host(sizeof(struct virtio_sdhci_host), &vdev->dev);
+	if (!mmc) {
+		pr_err("virtio_mmc: Failed to allocate host\n");
+		return -ENOMEM;
+	}
+
+	__fill_host_attr(mmc);
+
+	vdev->priv = mmc;
+
+	host = mmc_priv(mmc);
+	host->vdev = vdev;
+
+	spin_lock_init(&host->handling_request);
+	init_completion(&host->request_handled);
+
+	host->vq =
+		virtio_find_single_vq(vdev, virtio_sdhci_vq_callback, "vq_name");
+	if (!host->vq) {
+		pr_err("virtio_mmc: Failed to find virtqueue\n");
+		mmc_free_host(mmc);
+		return -ENODEV;
+	}
+
+	virtio_device_ready(vdev);
+
+	err = mmc_add_host(mmc);
+	if (err) {
+		pr_err("virtio_mmc: Failed to add host\n");
+		mmc_free_host(mmc);
+		return err;
+	}
+
+	return 0;
+}
+
+static int virtio_sdhci_probe(struct virtio_device *vdev)
+{
+	int err;
+
+	err = create_host(vdev);
+	if (err)
+		pr_err("virtio_mmc: Failed to make host\n");
+
+	return 0;
+}
+
+static void remove_mmc_host(struct mmc_host *host)
+{
+	/*
+	 * Host is claimed while removing, so all ongoing
+	 * requests would be handled before removal and no
+	 * additional control is required
+	 */
+	mmc_remove_host(host);
+	mmc_free_host(host);
+}
+
+static void virtio_sdhci_remove(struct virtio_device *vdev)
+{
+	struct mmc_host *mmc = vdev->priv;
+	struct virtio_sdhci_host *host = mmc_priv(mmc);
+
+	complete(&host->request_handled);
+	remove_mmc_host(mmc);
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+}
diff --git a/drivers/mmc/host/virtio-sdhci.h b/drivers/mmc/host/virtio-sdhci.h
new file mode 100644
index 000000000000..db35268e7b64
--- /dev/null
+++ b/drivers/mmc/host/virtio-sdhci.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *  VirtIO SD/MMC driver
+ *
+ *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
+ */
+
+#ifndef _VIRTIO_MMC_H
+#define _VIRTIO_MMC_H
+
+#include <linux/virtio.h>
+#include <linux/virtio_ids.h>
+
+static int virtio_sdhci_probe(struct virtio_device *vdev);
+
+static void virtio_sdhci_remove(struct virtio_device *vdev);
+
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_SDHCI, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_sdhci_driver = {
+	.driver = {
+		.name	= KBUILD_MODNAME,
+		.owner	= THIS_MODULE,
+	},
+	.id_table	= id_table,
+	.probe		= virtio_sdhci_probe,
+	.remove		= virtio_sdhci_remove,
+};
+
+module_virtio_driver(virtio_sdhci_driver);
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+MODULE_AUTHOR("Mikhail Krasheninnikov");
+MODULE_DESCRIPTION("VirtIO SD/MMC driver");
+MODULE_LICENSE("GPL");
+
+#endif
diff --git a/include/uapi/linux/virtio-sdhci.h b/include/uapi/linux/virtio-sdhci.h
new file mode 100644
index 000000000000..751ed215bc61
--- /dev/null
+++ b/include/uapi/linux/virtio-sdhci.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *  VirtIO SD/MMC driver
+ *
+ *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
+ */
+#ifndef _LINUX_VIRTIO_MMC_H
+#define _LINUX_VIRTIO_MMC_H
+#include <linux/types.h>
+
+struct mmc_req {
+	__le32 opcode;
+	__le32 arg;
+};
+
+struct virtio_mmc_request {
+	u8 flags;
+
+#define VIRTIO_MMC_REQUEST_DATA BIT(1)
+#define VIRTIO_MMC_REQUEST_WRITE BIT(2)
+#define VIRTIO_MMC_REQUEST_STOP BIT(3)
+#define VIRTIO_MMC_REQUEST_SBC BIT(4)
+
+	struct mmc_req request;
+
+	u8 buf[4096];
+	__le32 buf_len;
+
+	struct mmc_req stop_req;
+	struct mmc_req sbc_req;
+};
+
+struct virtio_mmc_response {
+	__le32 cmd_resp[4];
+	int cmd_resp_len;
+	u8 buf[4096];
+};
+
+#endif /* _LINUX_VIRTIO_MMC_H */
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 7aa2eb766205..6de8d432db7f 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_SDHCI         42 /* virtio mmc */
 
 /*
  * Virtio Transitional IDs
-- 
2.34.1

