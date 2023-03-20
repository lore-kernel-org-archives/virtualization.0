Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91726C7618A
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 10:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2649B80FAE;
	Mon, 20 Mar 2023 10:18:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2649B80FAE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=UTNQwmQ/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2G02nmReSFdd; Mon, 20 Mar 2023 10:18:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1A0A580ED8;
	Mon, 20 Mar 2023 10:18:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A0A580ED8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAE74C0071;
	Mon, 20 Mar 2023 10:18:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E95DFC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7DEB40453
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:18:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B7DEB40453
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=UTNQwmQ/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qP8-kRWq01F2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:18:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06656400EA
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06656400EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:18:39 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 az3-20020a05600c600300b003ed2920d585so8800465wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112; t=1679307517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCWhuAu5m9J8wm3m+mXTfcEkMydZaYTkCE7DE7EgP/Q=;
 b=UTNQwmQ/SJTTVkMW6LWDVOd1btjpZKy45jBp8JQwveZI5YGRrJTWf1in7o4LJbjma8
 Qc4XUVCniG1BPJB9gTQzo0F3SIaHatREEyUFsZ2v/q9elcDBSLfYBh0HYRRLbaTSku3B
 RwCOIG00e04N9GrXdKnfAThWKvi/eQPHDSACAhNeGURmcz9AcEnn+a6ahFmTtshnMH4R
 U8HCRcJfgW8zU951I2R45QeLcdwukayCUxNi1mfLU2bq8iYI5g5xJ9pn/YktpfCVXZ+o
 k2zXLPB/29wUX+B8zzida1WkVCiXks5tmKPyKmoeNJhLk+y1+t1m5F9hoZsbRon8TlX2
 2rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679307517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCWhuAu5m9J8wm3m+mXTfcEkMydZaYTkCE7DE7EgP/Q=;
 b=YvJUpV68+IKXSubow0zAgVYfiDbyiS/bpYIS3lMmyUdCwFixvWaock+baHdjwgV3ym
 2HOdGHwWrpiHo91/vQcmQMUHDWu2vYWFxppgWJdA8bjAm/WtYQ71T7Ec19pEPXEDsT6b
 k7WG7fh21P6KQ+d/N/1wCDRQRe6TDFGKn8DP7IbQIlggbmMXDldDrKKRaE7NvA8JpBRF
 zxL5x3c4a1KpJc2sKDmmpyyOFUD/4Sf7tmyVUwLQHDqkJUH9YvN3gxjpBPX3WZAyhcS5
 TgogwuCFXCcTeOlXHlCAMLPGnr11BEdQoroqKcu6QQHK7vGULMSxWUzhNRmlqaBd/xko
 cswA==
X-Gm-Message-State: AO0yUKVbOtmfn2+ZVC0RD3SNZ/g093Gjuc4XcBIJR7mB6S+3UXocz58C
 phGKLsYdoadTdLhJ+cE2J0J2zMZFGXMyv45kz2E=
X-Google-Smtp-Source: AK7set+WVhO18yrPrt2zR31KNA+fOdHmCpD9ipU2Evd9aSzo49U8Hd97vhB0UjZ6am/jihWEdn+KHw==
X-Received: by 2002:a1c:750e:0:b0:3ed:f957:10c7 with SMTP id
 o14-20020a1c750e000000b003edf95710c7mr2021181wmc.14.1679307517532; 
 Mon, 20 Mar 2023 03:18:37 -0700 (PDT)
Received: from alvaro-dell.. (bzq-84-110-153-254.static-ip.bezeqint.net.
 [84.110.153.254]) by smtp.gmail.com with ESMTPSA id
 q2-20020a1ce902000000b003ed1fa34bd3sm10031509wmc.13.2023.03.20.03.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Mar 2023 03:18:36 -0700 (PDT)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] vdpa/snet: support getting and setting VQ state
Date: Mon, 20 Mar 2023 12:18:16 +0200
Message-Id: <20230320101817.680402-2-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320101817.680402-1-alvaro.karsz@solid-run.com>
References: <20230320101817.680402-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

This patch adds the get_vq_state and set_vq_state vDPA callbacks.

In order to get the VQ state, the state needs to be read from the DPU.
In order to allow that, the old messaging mechanism is replaced with a new,
flexible control mechanism.
This mechanism allows to read data from the DPU.

The mechanism can be used if the negotiated config version is 2 or
higher.

If the new mechanism is used when the config version is 1, it will call
snet_send_ctrl_msg_old, which is config 1 compatible.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vdpa/solidrun/Makefile     |   1 +
 drivers/vdpa/solidrun/snet_ctrl.c  | 318 +++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_hwmon.c |   2 +-
 drivers/vdpa/solidrun/snet_main.c  | 111 ++++------
 drivers/vdpa/solidrun/snet_vdpa.h  |  17 +-
 5 files changed, 378 insertions(+), 71 deletions(-)
 create mode 100644 drivers/vdpa/solidrun/snet_ctrl.c

diff --git a/drivers/vdpa/solidrun/Makefile b/drivers/vdpa/solidrun/Makefile
index c0aa3415bf7..9116252cd5f 100644
--- a/drivers/vdpa/solidrun/Makefile
+++ b/drivers/vdpa/solidrun/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
 snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o
+snet_vdpa-$(CONFIG_SNET_VDPA) += snet_ctrl.o
 ifdef CONFIG_HWMON
 snet_vdpa-$(CONFIG_SNET_VDPA) += snet_hwmon.o
 endif
diff --git a/drivers/vdpa/solidrun/snet_ctrl.c b/drivers/vdpa/solidrun/snet_ctrl.c
new file mode 100644
index 00000000000..54909549a00
--- /dev/null
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SolidRun DPU driver for control plane
+ *
+ * Copyright (C) 2022-2023 SolidRun
+ *
+ * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
+ *
+ */
+
+#include <linux/iopoll.h>
+
+#include "snet_vdpa.h"
+
+enum snet_ctrl_opcodes {
+	SNET_CTRL_OP_DESTROY = 1,
+	SNET_CTRL_OP_READ_VQ_STATE,
+};
+
+#define SNET_CTRL_TIMEOUT	        2000000
+
+#define SNET_CTRL_DATA_SIZE_MASK	0x0000FFFF
+#define SNET_CTRL_IN_PROCESS_MASK	0x00010000
+#define SNET_CTRL_CHUNK_RDY_MASK	0x00020000
+#define SNET_CTRL_ERROR_MASK		0x0FFC0000
+
+#define SNET_VAL_TO_ERR(val)		(-(((val) & SNET_CTRL_ERROR_MASK) >> 18))
+#define SNET_EMPTY_CTRL(val)		(((val) & SNET_CTRL_ERROR_MASK) || \
+						!((val) & SNET_CTRL_IN_PROCESS_MASK))
+#define SNET_DATA_READY(val)		((val) & (SNET_CTRL_ERROR_MASK | SNET_CTRL_CHUNK_RDY_MASK))
+
+/* Control register used to read data from the DPU */
+struct snet_ctrl_reg_ctrl {
+	/* Chunk size in 4B words */
+	u16 data_size;
+	/* We are in the middle of a command */
+	u16 in_process:1;
+	/* A data chunk is ready and can be consumed */
+	u16 chunk_ready:1;
+	/* Error code */
+	u16 error:10;
+	/* Saved for future usage */
+	u16 rsvd:4;
+};
+
+/* Opcode register */
+struct snet_ctrl_reg_op {
+	u16 opcode;
+	/* Only if VQ index is relevant for the command */
+	u16 vq_idx;
+};
+
+struct snet_ctrl_regs {
+	struct snet_ctrl_reg_op op;
+	struct snet_ctrl_reg_ctrl ctrl;
+	u32 rsvd;
+	u32 data[];
+};
+
+static struct snet_ctrl_regs __iomem *snet_get_ctrl(struct snet *snet)
+{
+	return snet->bar + snet->psnet->cfg.ctrl_off;
+}
+
+static int snet_wait_for_empty_ctrl(struct snet_ctrl_regs __iomem *regs)
+{
+	u32 val;
+
+	return readx_poll_timeout(ioread32, &regs->ctrl, val, SNET_EMPTY_CTRL(val), 10,
+				  SNET_CTRL_TIMEOUT);
+}
+
+static int snet_wait_for_empty_op(struct snet_ctrl_regs __iomem *regs)
+{
+	u32 val;
+
+	return readx_poll_timeout(ioread32, &regs->op, val, !val, 10, SNET_CTRL_TIMEOUT);
+}
+
+static int snet_wait_for_data(struct snet_ctrl_regs __iomem *regs)
+{
+	u32 val;
+
+	return readx_poll_timeout(ioread32, &regs->ctrl, val, SNET_DATA_READY(val), 10,
+				  SNET_CTRL_TIMEOUT);
+}
+
+static u32 snet_read32_word(struct snet_ctrl_regs __iomem *ctrl_regs, u16 word_idx)
+{
+	return ioread32(&ctrl_regs->data[word_idx]);
+}
+
+static u32 snet_read_ctrl(struct snet_ctrl_regs __iomem *ctrl_regs)
+{
+	return ioread32(&ctrl_regs->ctrl);
+}
+
+static void snet_write_ctrl(struct snet_ctrl_regs __iomem *ctrl_regs, u32 val)
+{
+	iowrite32(val, &ctrl_regs->ctrl);
+}
+
+static void snet_write_op(struct snet_ctrl_regs __iomem *ctrl_regs, u32 val)
+{
+	iowrite32(val, &ctrl_regs->op);
+}
+
+static int snet_wait_for_dpu_completion(struct snet_ctrl_regs __iomem *ctrl_regs)
+{
+	/* Wait until the DPU finishes completely.
+	 * It will clear the opcode register.
+	 */
+	return snet_wait_for_empty_op(ctrl_regs);
+}
+
+/* Reading ctrl from the DPU:
+ * buf_size must be 4B aligned
+ *
+ * Steps:
+ *
+ * (1) Verify that the DPU is not in the middle of another operation by
+ *     reading the in_process and error bits in the control register.
+ * (2) Write the request opcode and the VQ idx in the opcode register
+ *     and write the buffer size in the control register.
+ * (3) Start readind chunks of data, chunk_ready bit indicates that a
+ *     data chunk is available, we signal that we read the data by clearing the bit.
+ * (4) Detect that the transfer is completed when the in_process bit
+ *     in the control register is cleared or when the an error appears.
+ */
+static int snet_ctrl_read_from_dpu(struct snet *snet, u16 opcode, u16 vq_idx, void *buffer,
+				   u32 buf_size)
+{
+	struct pci_dev *pdev = snet->pdev;
+	struct snet_ctrl_regs __iomem *regs = snet_get_ctrl(snet);
+	u32 *bfr_ptr = (u32 *)buffer;
+	u32 val;
+	u16 buf_words;
+	int ret;
+	u16 words, i, tot_words = 0;
+
+	/* Supported for config 2+ */
+	if (!SNET_CFG_VER(snet, 2))
+		return -EOPNOTSUPP;
+
+	if (!IS_ALIGNED(buf_size, 4))
+		return -EINVAL;
+
+	mutex_lock(&snet->ctrl_lock);
+
+	buf_words = buf_size / 4;
+
+	/* Make sure control register is empty */
+	ret = snet_wait_for_empty_ctrl(regs);
+	if (ret) {
+		SNET_WARN(pdev, "Timeout waiting for previous control data to be consumed\n");
+		goto exit;
+	}
+
+	/* Overwrite the control register with the new buffer size (in 4B words) */
+	snet_write_ctrl(regs, buf_words);
+	/* Use a memory barrier, this must be written before the opcode register. */
+	wmb();
+
+	/* Write opcode and VQ idx */
+	val = opcode | (vq_idx << 16);
+	snet_write_op(regs, val);
+
+	while (buf_words != tot_words) {
+		ret = snet_wait_for_data(regs);
+		if (ret) {
+			SNET_WARN(pdev, "Timeout waiting for control data\n");
+			goto exit;
+		}
+
+		val = snet_read_ctrl(regs);
+
+		/* Error? */
+		if (val & SNET_CTRL_ERROR_MASK) {
+			ret = SNET_VAL_TO_ERR(val);
+			SNET_WARN(pdev, "Error while reading control data from DPU, err %d\n", ret);
+			goto exit;
+		}
+
+		words = min_t(u16, val & SNET_CTRL_DATA_SIZE_MASK, buf_words - tot_words);
+
+		for (i = 0; i < words; i++) {
+			*bfr_ptr = snet_read32_word(regs, i);
+			bfr_ptr++;
+		}
+
+		tot_words += words;
+
+		/* Is the job completed? */
+		if (!(val & SNET_CTRL_IN_PROCESS_MASK))
+			break;
+
+		/* Clear the chunk ready bit and continue */
+		val &= ~SNET_CTRL_CHUNK_RDY_MASK;
+		snet_write_ctrl(regs, val);
+	}
+
+	ret = snet_wait_for_dpu_completion(regs);
+	if (ret)
+		SNET_WARN(pdev, "Timeout waiting for the DPU to complete a control command\n");
+
+exit:
+	mutex_unlock(&snet->ctrl_lock);
+	return ret;
+}
+
+/* Send a control message to the DPU using the old mechanism
+ * used with config version 1.
+ */
+static int snet_send_ctrl_msg_old(struct snet *snet, u32 opcode)
+{
+	struct pci_dev *pdev = snet->pdev;
+	struct snet_ctrl_regs __iomem *regs = snet_get_ctrl(snet);
+	int ret;
+
+	mutex_lock(&snet->ctrl_lock);
+
+	/* Old mechanism uses just 1 register, the opcode register.
+	 * Make sure that the opcode register is empty, and that the DPU isn't
+	 * processing an old message.
+	 */
+	ret = snet_wait_for_empty_op(regs);
+	if (ret) {
+		SNET_WARN(pdev, "Timeout waiting for previous control message to be ACKed\n");
+		goto exit;
+	}
+
+	/* Write the message */
+	snet_write_op(regs, opcode);
+
+	/* DPU ACKs the message by clearing the opcode register */
+	ret = snet_wait_for_empty_op(regs);
+	if (ret)
+		SNET_WARN(pdev, "Timeout waiting for a control message to be ACKed\n");
+
+exit:
+	mutex_unlock(&snet->ctrl_lock);
+	return ret;
+}
+
+/* Send a control message to the DPU.
+ * A control message is a message without payload.
+ */
+static int snet_send_ctrl_msg(struct snet *snet, u16 opcode, u16 vq_idx)
+{
+	struct pci_dev *pdev = snet->pdev;
+	struct snet_ctrl_regs __iomem *regs = snet_get_ctrl(snet);
+	u32 val;
+	int ret;
+
+	/* If config version is not 2+, use the old mechanism */
+	if (!SNET_CFG_VER(snet, 2))
+		return snet_send_ctrl_msg_old(snet, opcode);
+
+	mutex_lock(&snet->ctrl_lock);
+
+	/* Make sure control register is empty */
+	ret = snet_wait_for_empty_ctrl(regs);
+	if (ret) {
+		SNET_WARN(pdev, "Timeout waiting for previous control data to be consumed\n");
+		goto exit;
+	}
+
+	/* Clear the control register - clear the error code if previous control operation failed */
+	snet_write_ctrl(regs, 0);
+
+	/* Write opcode and VQ idx */
+	val = opcode | (vq_idx << 16);
+	snet_write_op(regs, val);
+
+	/* The DPU ACKs control messages by setting the chunk ready bit
+	 * without data.
+	 */
+	ret = snet_wait_for_data(regs);
+	if (ret) {
+		SNET_WARN(pdev, "Timeout waiting for control message to be ACKed\n");
+		goto exit;
+	}
+
+	/* Check for errors */
+	val = snet_read_ctrl(regs);
+	ret = SNET_VAL_TO_ERR(val);
+
+	/* Clear the chunk ready bit */
+	val &= ~SNET_CTRL_CHUNK_RDY_MASK;
+	snet_write_ctrl(regs, val);
+
+	ret = snet_wait_for_dpu_completion(regs);
+	if (ret)
+		SNET_WARN(pdev, "Timeout waiting for DPU to complete a control command, err %d\n",
+			  ret);
+
+exit:
+	mutex_unlock(&snet->ctrl_lock);
+	return ret;
+}
+
+void snet_ctrl_clear(struct snet *snet)
+{
+	struct snet_ctrl_regs __iomem *regs = snet_get_ctrl(snet);
+
+	snet_write_op(regs, 0);
+}
+
+int snet_destroy_dev(struct snet *snet)
+{
+	return snet_send_ctrl_msg(snet, SNET_CTRL_OP_DESTROY, 0);
+}
+
+int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state)
+{
+	return snet_ctrl_read_from_dpu(snet, SNET_CTRL_OP_READ_VQ_STATE, idx, state,
+				       sizeof(*state));
+}
diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
index e695e36ff75..42c87387a0f 100644
--- a/drivers/vdpa/solidrun/snet_hwmon.c
+++ b/drivers/vdpa/solidrun/snet_hwmon.c
@@ -2,7 +2,7 @@
 /*
  * SolidRun DPU driver for control plane
  *
- * Copyright (C) 2022 SolidRun
+ * Copyright (C) 2022-2023 SolidRun
  *
  * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
  *
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 68de727398e..daeb69d00ed 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -2,7 +2,7 @@
 /*
  * SolidRun DPU driver for control plane
  *
- * Copyright (C) 2022 SolidRun
+ * Copyright (C) 2022-2023 SolidRun
  *
  * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
  *
@@ -16,14 +16,12 @@
 /* SNET signature */
 #define SNET_SIGNATURE          0xD0D06363
 /* Max. config version that we can work with */
-#define SNET_CFG_VERSION        0x1
+#define SNET_CFG_VERSION        0x2
 /* Queue align */
 #define SNET_QUEUE_ALIGNMENT    PAGE_SIZE
 /* Kick value to notify that new data is available */
 #define SNET_KICK_VAL           0x1
 #define SNET_CONFIG_OFF         0x0
-/* ACK timeout for a message */
-#define SNET_ACK_TIMEOUT	2000000
 /* How long we are willing to wait for a SNET device */
 #define SNET_DETECT_TIMEOUT	5000000
 /* How long should we wait for the DPU to read our config */
@@ -32,56 +30,11 @@
 #define SNET_GENERAL_CFG_LEN	36
 #define SNET_GENERAL_CFG_VQ_LEN	40
 
-enum snet_msg {
-	SNET_MSG_DESTROY = 1,
-};
-
 static struct snet *vdpa_to_snet(struct vdpa_device *vdpa)
 {
 	return container_of(vdpa, struct snet, vdpa);
 }
 
-static int snet_wait_for_msg_ack(struct snet *snet)
-{
-	struct pci_dev *pdev = snet->pdev;
-	int ret;
-	u32 val;
-
-	/* The DPU will clear the messages offset once messages
-	 * are processed.
-	 */
-	ret = readx_poll_timeout(ioread32, snet->bar + snet->psnet->cfg.msg_off,
-				 val, !val, 10, SNET_ACK_TIMEOUT);
-	if (ret)
-		SNET_WARN(pdev, "Timeout waiting for message ACK\n");
-
-	return ret;
-}
-
-/* Sends a message to the DPU.
- * If blocking is set, the function will return once the
- * message was processed by the DPU (or timeout).
- */
-static int snet_send_msg(struct snet *snet, u32 msg, bool blocking)
-{
-	int ret = 0;
-
-	/* Make sure the DPU acked last message before issuing a new one */
-	ret = snet_wait_for_msg_ack(snet);
-	if (ret)
-		return ret;
-
-	/* Write the message */
-	snet_write32(snet, snet->psnet->cfg.msg_off, msg);
-
-	if (blocking)
-		ret = snet_wait_for_msg_ack(snet);
-	else /* If non-blocking, flush the write by issuing a read */
-		snet_read32(snet, snet->psnet->cfg.msg_off);
-
-	return ret;
-}
-
 static irqreturn_t snet_cfg_irq_hndlr(int irq, void *data)
 {
 	struct snet *snet = data;
@@ -181,33 +134,48 @@ static bool snet_get_vq_ready(struct vdpa_device *vdev, u16 idx)
 	return snet->vqs[idx]->ready;
 }
 
-static int snet_set_vq_state(struct vdpa_device *vdev, u16 idx, const struct vdpa_vq_state *state)
+static bool snet_vq_state_is_initial(struct snet *snet, const struct vdpa_vq_state *state)
 {
-	struct snet *snet = vdpa_to_snet(vdev);
-	/* Setting the VQ state is not supported.
-	 * If the asked state is the same as the initial one
-	 * we can ignore it.
-	 */
 	if (SNET_HAS_FEATURE(snet, VIRTIO_F_RING_PACKED)) {
 		const struct vdpa_vq_state_packed *p = &state->packed;
 
 		if (p->last_avail_counter == 1 && p->last_used_counter == 1 &&
 		    p->last_avail_idx == 0 && p->last_used_idx == 0)
-			return 0;
+			return true;
 	} else {
 		const struct vdpa_vq_state_split *s = &state->split;
 
 		if (s->avail_index == 0)
-			return 0;
+			return true;
+	}
+
+	return false;
+}
+
+static int snet_set_vq_state(struct vdpa_device *vdev, u16 idx, const struct vdpa_vq_state *state)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	/* We can set any state for config version 2+ */
+	if (SNET_CFG_VER(snet, 2)) {
+		memcpy(&snet->vqs[idx]->inital_state, state, sizeof(*state));
+		return 0;
 	}
 
+	/* Older config - we can't set the VQ state.
+	 * Return 0 only if this is the initial state we use in the DPU.
+	 */
+	if (snet_vq_state_is_initial(snet, state))
+		return 0;
+
 	return -EOPNOTSUPP;
 }
 
 static int snet_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa_vq_state *state)
 {
-	/* Not supported */
-	return -EOPNOTSUPP;
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return snet_read_vq_state(snet, idx, state);
 }
 
 static int snet_get_vq_irq(struct vdpa_device *vdev, u16 idx)
@@ -232,9 +200,9 @@ static int snet_reset_dev(struct snet *snet)
 	if (!snet->status)
 		return 0;
 
-	/* If DPU started, send a destroy message */
+	/* If DPU started, destroy it */
 	if (snet->status & VIRTIO_CONFIG_S_DRIVER_OK)
-		ret = snet_send_msg(snet, SNET_MSG_DESTROY, true);
+		ret = snet_destroy_dev(snet);
 
 	/* Clear VQs */
 	for (i = 0; i < snet->cfg->vq_num; i++) {
@@ -258,7 +226,7 @@ static int snet_reset_dev(struct snet *snet)
 	snet->dpu_ready = false;
 
 	if (ret)
-		SNET_WARN(pdev, "Incomplete reset to SNET[%u] device\n", snet->sid);
+		SNET_WARN(pdev, "Incomplete reset to SNET[%u] device, err: %d\n", snet->sid, ret);
 	else
 		SNET_DBG(pdev, "Reset SNET[%u] device\n", snet->sid);
 
@@ -356,7 +324,7 @@ static int snet_write_conf(struct snet *snet)
 	 * |             DESC AREA                |
 	 * |            DEVICE AREA               |
 	 * |            DRIVER AREA               |
-	 * |             RESERVED                 |
+	 * |    VQ STATE (CFG 2+)     |   RSVD    |
 	 *
 	 * Magic number should be written last, this is the DPU indication that the data is ready
 	 */
@@ -391,12 +359,15 @@ static int snet_write_conf(struct snet *snet)
 		off += 8;
 		snet_write64(snet, off, snet->vqs[i]->driver_area);
 		off += 8;
+		/* Write VQ state if config version is 2+ */
+		if (SNET_CFG_VER(snet, 2))
+			snet_write32(snet, off, *(u32 *)&snet->vqs[i]->inital_state);
+		off += 4;
+
 		/* Ignore reserved */
-		off += 8;
+		off += 4;
 	}
 
-	/* Clear snet messages address for this device */
-	snet_write32(snet, snet->psnet->cfg.msg_off, 0);
 	/* Write magic number - data is ready */
 	snet_write32(snet, snet->psnet->cfg.host_cfg_off, SNET_SIGNATURE);
 
@@ -697,7 +668,7 @@ static int psnet_read_cfg(struct pci_dev *pdev, struct psnet *psnet)
 	off += 4;
 	cfg->hwmon_off = psnet_read32(psnet, off);
 	off += 4;
-	cfg->msg_off = psnet_read32(psnet, off);
+	cfg->ctrl_off = psnet_read32(psnet, off);
 	off += 4;
 	cfg->flags = psnet_read32(psnet, off);
 	off += 4;
@@ -997,6 +968,9 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
 		goto free_irqs;
 	}
 
+	/* Init control mutex */
+	mutex_init(&snet->ctrl_lock);
+
 	/* Save pci device pointer */
 	snet->pdev = pdev;
 	snet->psnet = psnet;
@@ -1013,6 +987,9 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
 	/* Create a VirtIO config pointer */
 	snet->cfg->virtio_cfg = snet->bar + snet->psnet->cfg.virtio_cfg_off;
 
+	/* Clear control registers */
+	snet_ctrl_clear(snet);
+
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, snet);
 
diff --git a/drivers/vdpa/solidrun/snet_vdpa.h b/drivers/vdpa/solidrun/snet_vdpa.h
index b7f34169053..a4213e97cfc 100644
--- a/drivers/vdpa/solidrun/snet_vdpa.h
+++ b/drivers/vdpa/solidrun/snet_vdpa.h
@@ -2,7 +2,7 @@
 /*
  * SolidRun DPU driver for control plane
  *
- * Copyright (C) 2022 SolidRun
+ * Copyright (C) 2022-2023 SolidRun
  *
  * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
  *
@@ -20,10 +20,15 @@
 #define SNET_INFO(pdev, fmt, ...) dev_info(&(pdev)->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
 #define SNET_DBG(pdev, fmt, ...) dev_dbg(&(pdev)->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
 #define SNET_HAS_FEATURE(s, f) ((s)->negotiated_features & BIT_ULL(f))
+/* Check if negotiated config version is at least @ver */
+#define SNET_CFG_VER(snet, ver) ((snet)->psnet->negotiated_cfg_ver >= (ver))
+
 /* VQ struct */
 struct snet_vq {
 	/* VQ callback */
 	struct vdpa_callback cb;
+	/* VQ initial state */
+	struct vdpa_vq_state inital_state;
 	/* desc base address */
 	u64 desc_area;
 	/* device base address */
@@ -51,6 +56,8 @@ struct snet {
 	struct vdpa_device vdpa;
 	/* Config callback */
 	struct vdpa_callback cb;
+	/* To lock the control mechanism */
+	struct mutex ctrl_lock;
 	/* array of virqueues */
 	struct snet_vq **vqs;
 	/* Used features */
@@ -117,8 +124,8 @@ struct snet_cfg {
 	u32 kick_off;
 	/* Offset in PCI BAR for HW monitoring */
 	u32 hwmon_off;
-	/* Offset in PCI BAR for SNET messages */
-	u32 msg_off;
+	/* Offset in PCI BAR for Control mechanism */
+	u32 ctrl_off;
 	/* Config general flags - enum snet_cfg_flags */
 	u32 flags;
 	/* Reserved for future usage */
@@ -191,4 +198,8 @@ static inline void snet_write64(struct snet *snet, u32 off, u64 val)
 void psnet_create_hwmon(struct pci_dev *pdev);
 #endif
 
+void snet_ctrl_clear(struct snet *snet);
+int snet_destroy_dev(struct snet *snet);
+int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state);
+
 #endif //_SNET_VDPA_H_
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
