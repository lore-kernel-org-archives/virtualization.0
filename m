Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543C35201F
	for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510109; cv=none; b=W77eedVFJOkXh/I7vx+Wy0Pso3bXVbVXWzu27rZb9C/LOAdOF6CEB2WyFgYyfAffU5ozixBLpTagNlLpU5Ig4ZVua4o9Z+TzYebnGKdYTqlHdRBDjDCa3wsITG6YZHYQFAdxsPpS06Inu50wd9aSfqnvwXXyJZrPbqsaINpFzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510109; c=relaxed/simple;
	bh=plmNyVtYvBKCozMJTl5vmd3LXNlbTJ4OiKUbwMbkftw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E18klwj517mL7CC7IQvUMZe4nO6Tif80e0/H3+BQfq6ZXLKbPVAwjBlPtILwVgElwIwhnNuGtiUfHRrt/r8lXR7XZj2FIu0Ai3ew6zylBG67/d13sntqGVrHtM6mYpWYC4rYK9qzbLFGhNqMux3NkCDIwqGiFGEcldhHhhZlwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDKpQj3n; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDKpQj3n"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so5083830a12.0
        for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787510106; x=1788114906; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7VY7u501Z69wWM0BQwWCLe80wnzGYbVz/YdZ1cRrWkI=;
        b=ZDKpQj3nW8JJ1+9bHKYN7RKiTASs8LTnrEnuAnEdoX5MI66Uyfkxi5r4ekbAn4BFLj
         57wK9An36+2MEDUUR6Q/CT8O9oVRh+5qqUz7BsK7nu++C9e4Iu0BPvSXVkqT6aJERRis
         arqaBEg9UeHchHk6/AEu45HOZVuo6K9QlKZrrKfVVdLRYoazZ2TSlFPJLBnTUG7PCnLp
         5JviAJUigY+64njA0MCxUpX5X+KkHhZoS8ksion98V1rRLhSefaX54cvzr80mwLgicjI
         nSGzkBUoCGTeiDxXlMnXCiufKeAqGTmSA2rGk75wLiM0tK5V1MBqk40Y+Ur3q9kk4UKA
         XGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787510106; x=1788114906;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7VY7u501Z69wWM0BQwWCLe80wnzGYbVz/YdZ1cRrWkI=;
        b=gcH1/1YL9ZWfNNsjjRaO8Jt6zdtrOdFXy8MhhASxDlrOG/SHBoabiU1YdCqHriiaXI
         VrmMwUEUSV0xuOfCSI0uW6miPCnjOVM2FP2MQX/ul0Jb9ZZPgX+DcwU1STgKKmmPj901
         92wGS5v7i+cqrMbfPL+GipEFcvWSB4D433Xg2HZhxQ3flTJKToJmVi3S8l1kYs5jC/Io
         LL0KMSqbHJ5+9ILWfzoZXEThIu2Wb5/2llR0+x8BI9+TOajmtANNzrDsyyPGFgwIbs0J
         hz2RzWAfZxQiB3hP43avX4nvPt2I7rYUQS/5YggPcTM6MJ4XTvtQlppUEd8cSFJqZ079
         QIiw==
X-Gm-Message-State: AFuF++lBf75lTr6j72PxpSvCfWRXXovaQI2n41Lkriwoi9lbon7YojSL
	73Ph8PDSiQjoRgztOFHjBswal4yebVc1qceGzp/KOkjh6QDtCwl125Oy
X-Gm-Gg: AR+sD11dlt+dkD6N7ts/4/AvGqX3hph36v2mNETNZ916waZ/Teawx4GYBewrTl9Au6o
	liUEwVBb2Jlf8NMztx//TMju3XDNDmPXvc/5NAVPQhLnw/vark9/sByP5hqTa84ka6SIX40qDqQ
	hDXR3YhFHvZy4O0lz2Zf+6c2GuTuoCZcgZovnej+r82sMWbQN9EYfEaOJz1Ychl/iY7ReOoZule
	ZtGrci/A9RZO2jTWWAbfVpVE6zvhBwsBK+BC/o7mce4FPnfFAcPPXSFvf/WjbdfAfmRvwrQggyS
	dQLpuqCuv12X0M92AxkQ1auQnmgPtCBcLf48YID7aZEOcld6SnCtTwLioSBmHyGFQueOa7GI7/j
	mhR5axoXfFmXjev+wDc5ZCyJdV/0+W98QFZ49Yh9nccfHCL+ix4381TiXubfYecsv9SZ97DFciu
	LNKAXTFcQ3ZJL8jKDK0jEBnpQRQV1NOu4p7O6tV9akm1rQQV29bQ75DOP8mVPgIeGlBQE7f3OyY
	jyXNIBHkZrTvx+28poMhwO1/6k5hrfyvsCkTvs07Ti9zz9QUW279sbFvXId
X-Received: by 2002:a17:907:d28:b0:c21:72b:dec0 with SMTP id a640c23a62f3a-c249238cd9cmr1502223166b.5.1787510106110;
        Sun, 23 Aug 2026 11:35:06 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box (dynamic-002-214-002-133.2.214.pool.telefonica.de. [2.214.2.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm805385066b.27.2026.08.23.11.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:35:05 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: lukas@wunner.de,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	stefanha@redhat.com,
	parav@nvidia.com,
	axboe@kernel.dk,
	kees@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	xueshuai@linux.alibaba.com,
	Abhin Parekadan Jose <abhin@poc.local>,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC 1/3] misc: add edu_srpoc surprise removal POC driver
Date: Sun, 23 Aug 2026 18:34:53 +0000
Message-ID: <20260823183458.982699-2-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260823183458.982699-1-abhinjoses@gmail.com>
References: <cover.1752094439.git.mst@redhat.com>
 <20260823183458.982699-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Abhin Parekadan Jose <abhin@poc.local>

A test driver for the QEMU edu device that reproduces the surprise
removal hang described in MST's RFC v5 thread.

- hacked in a reg to the edu device on qemu to raise a delayed irq
- This driver writes to that reg in remove and waits for the irq to be
  handled. This simulate simulating del_gendisk() blocked in blk_mq_freeze_queue_wait()

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/misc/Makefile    |   1 +
 drivers/misc/edu_srpoc.c | 180 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 drivers/misc/edu_srpoc.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index fed47c7672b9..36da0539c215 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_AD525X_DPOT_I2C)	+= ad525x_dpot-i2c.o
 obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
+obj-y				+= edu_srpoc.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
 obj-$(CONFIG_LKDTM)		+= lkdtm/
 obj-$(CONFIG_TI_FPC202)		+= ti_fpc202.o
diff --git a/drivers/misc/edu_srpoc.c b/drivers/misc/edu_srpoc.c
new file mode 100644
index 000000000000..ce2c254e3362
--- /dev/null
+++ b/drivers/misc/edu_srpoc.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * edu_srpoc.c — Surprise Removal POC driver for the QEMU edu device
+ *
+ * In remove(), schedules a delayed interrupt on the edu device and
+ * blocks waiting for it to complete. This simulates del_gendisk()
+ * blocked in blk_mq_freeze_queue_wait() on slow in-flight I/O.
+ *
+ * Surprise-remove the device during this window to reproduce the hang.
+ *
+ * edu BAR 0 registers used:
+ *   0x08  Factorial: write N to compute N! asynchronously
+ *   0x20  Status: write EDU_STATUS_IRQFACT to enable IRQ on completion
+ *   0x24  IRQ status: bit 0 = FACT_IRQ, bit 9 = DELAY_IRQ
+ *   0x30  Delayed IRQ: write N (ms). Hacked in this functionality(not upstream).
+ *   0x64  IRQ lower: write bitmask to ack
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+
+#define PCI_VENDOR_ID_EDU	0x1234
+#define PCI_DEVICE_ID_EDU	0x11e8
+
+#define EDU_REG_FACT		0x08
+#define EDU_REG_STATUS		0x20
+#define EDU_REG_DELAYED_IRQ	0x30
+#define EDU_REG_IRQ_STATUS	0x24
+#define EDU_REG_IRQ_LOWER	0x64
+
+#define EDU_STATUS_IRQFACT	0x80
+#define EDU_FACT_IRQ		BIT(0)
+#define EDU_DELAY_IRQ		BIT(9)
+
+/* Large enough to take several seconds in the QEMU thread */
+#define EDU_SLOW_FACTORIAL	0xffffffff
+
+struct edu_dev {
+	struct pci_dev		*pdev;
+	void __iomem		*regs;
+	struct completion	irq_done;
+};
+
+static irqreturn_t edu_irq_handler(int irq, void *data)
+{
+	struct edu_dev *edu = data;
+	u32 status;
+
+	status = ioread32(edu->regs + EDU_REG_IRQ_STATUS);
+	if (!status)
+		return IRQ_NONE;
+
+	iowrite32(status, edu->regs + EDU_REG_IRQ_LOWER);
+
+	if (status & (EDU_FACT_IRQ | EDU_DELAY_IRQ))
+	{
+		pr_info("complete(&edu->irq_done)\n");
+		complete(&edu->irq_done);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void edu_disconnect(struct work_struct *work)
+{
+	struct pci_dev *pdev = container_of(work, struct pci_dev,
+					    disconnect_work);
+	struct edu_dev *edu = pci_get_drvdata(pdev);
+
+	dev_info(&pdev->dev, "edu_disconnect()\n");
+	if (!pci_test_and_clear_disconnect_enable(pdev))
+		return;
+
+	if (!edu)
+		return;
+
+	dev_info(&pdev->dev, "disconnect_work fired — unblocking remove()\n");
+	complete(&edu->irq_done);
+}
+
+static int edu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct edu_dev *edu;
+	int err;
+
+	dev_info(&pdev->dev, "edu_probe(): starting\n");
+
+	edu = devm_kzalloc(&pdev->dev, sizeof(*edu), GFP_KERNEL);
+	if (!edu)
+		return -ENOMEM;
+
+	edu->pdev = pdev;
+	init_completion(&edu->irq_done);
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+
+	err = pci_request_regions(pdev, "edu_srpoc");
+	if (err)
+		goto err_disable;
+
+	edu->regs = pci_iomap(pdev, 0, 0);
+	if (!edu->regs) {
+		err = -ENOMEM;
+		goto err_release;
+	}
+
+	pci_set_master(pdev);
+
+	err = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_INTX);
+	if (err < 0)
+		goto err_iounmap;
+
+	err = request_irq(pci_irq_vector(pdev, 0), edu_irq_handler,
+			  IRQF_SHARED, "edu_srpoc", edu);
+	if (err)
+		goto err_free_vectors;
+
+	pci_set_drvdata(pdev, edu);
+
+	INIT_WORK(&pdev->disconnect_work, edu_disconnect);
+	pci_set_disconnect_work(pdev);
+
+	dev_info(&pdev->dev, "edu_srpoc probed\n");
+	return 0;
+
+err_free_vectors:
+	pci_free_irq_vectors(pdev);
+err_iounmap:
+	pci_iounmap(pdev, edu->regs);
+err_release:
+	pci_release_regions(pdev);
+err_disable:
+	pci_disable_device(pdev);
+	return err;
+}
+
+static void edu_remove(struct pci_dev *pdev)
+{
+	struct edu_dev *edu = pci_get_drvdata(pdev);
+
+	dev_info(&pdev->dev, "remove(): starting factorial — blocking for IRQ\n");
+
+	iowrite32(EDU_STATUS_IRQFACT, edu->regs + EDU_REG_STATUS);
+
+	iowrite32(600000, edu->regs + EDU_REG_DELAYED_IRQ);
+
+	wait_for_completion(&edu->irq_done);
+
+	dev_info(&pdev->dev, "remove(): unblocked, cleaning up\n");
+
+	pci_clear_disconnect_work(pdev);
+	free_irq(pci_irq_vector(pdev, 0), edu);
+	pci_free_irq_vectors(pdev);
+	pci_iounmap(pdev, edu->regs);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id edu_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_EDU, PCI_DEVICE_ID_EDU) },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, edu_ids);
+
+static struct pci_driver edu_driver = {
+	.name		= "edu_srpoc",
+	.id_table	= edu_ids,
+	.probe		= edu_probe,
+	.remove		= edu_remove,
+};
+
+module_pci_driver(edu_driver);
+MODULE_AUTHOR("Abhin Parekadan Jose");
+MODULE_DESCRIPTION("edu surprise removal POC driver");
+MODULE_LICENSE("GPL");
-- 
2.51.1

