Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93987339375
	for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510118; cv=none; b=iotuC0Scbh8t0rDCQSSL0nVzTikVUkbv1VlOoYtQToazZsvCePZM+dfYfeahyrcwFcZYqSnsdBxL6FnvEAL9S0AvfBKSZmjC8OkvQW/lok40vxNwTgRdHz9QlER5ahXZoZEDerOG7x3qKqxgrsfz7ZM62urWH/NwLteaUKX4G/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510118; c=relaxed/simple;
	bh=NvYRVXgFjcjQEUe8XA3TmxPUCrloiIqrGqm28dvgLK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrxApLVSNVeKfMNDIKbDe/24JDXFz02WOEGd32rMIsaojeft7zheamXEcKA8GX3npTfNd/amvQ5hGejCBT35Z4b83Yzi63mBQ27rZGz9ajkMH7dSu59hAk2e0wu8NxsrKz3PLBCS2niQw2YsSocCjnvjdwqFrGW3HggBt1RWwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgfUvW/I; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgfUvW/I"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1f758014b8so285822866b.3
        for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787510111; x=1788114911; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BIXCeWqSrCQg2g+vGMEBn3omtTu0U5s8PS5zUr5JWZM=;
        b=YgfUvW/IuOjoHSzfJelV4Cn6aED6FH2dZGDiwRM/od9LnqjZYZe6Sv31NIqu1pHNoG
         00dS6gDgqqY/aGt7SJXHTOqKoap8EhSuRylnHH045OCDyOYIcPhewiuRNmIP2mWcihT+
         kSXlB588+qERsO8HfLADrpms24Z1cFuv9vQ9wBaoBgTQ/E1nzKAfX2lgGEHCL4CUcHHg
         rjgDdxbTdUWbEJ0d65LundEQLcsOggQ5Br/mvAj0ZSmb6mEVJrYMbtCv0T5kmwBLUAoX
         1tnoOPR9qmtd8IzWSHCO4pUHMOlqEyqHgSh+UJ4MhgAS7GL9nZYgYrsg3/64vFGzEcQ1
         AKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787510111; x=1788114911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BIXCeWqSrCQg2g+vGMEBn3omtTu0U5s8PS5zUr5JWZM=;
        b=IeIe7feU5XnzdNuqmO6nikoH6ysyQ+F11hkVtN5m2NR7Qzr/ImZybqydXvgeKUDCGG
         mYWNa4llt2+cnnB6lMKP77sIUnNBKi0T1GENZ1tnIpfkZkLpIZ7hZxIHvxzvoW8n5ar9
         IxoxZaParM/pT7FzM9AvAVMygzjg+kQCsiidx9oR971fDJyCQA92aKitcs7G6JGunkMW
         aZVNQk8tmHLICoMuokSxaGKRUB0hbN/xZE29Maz0P6K2lx5db/7kvweIBCyxh/QT+gB4
         CHVv0QEh82ZNDi6FBFPO8roUwxlE6LKrbsBRpyeZKpXss9LYRq+ndi9nOOa0xy9nXnPv
         i0tQ==
X-Gm-Message-State: AFuF++m1jyOOkPASdjWOCDNUhhB0yGrAKXxGdoPAyUKz/v486wL5WXxd
	Oqn3zPjqm/glsZ9G2C0RLZP2x3W9zOvnCLsJnOfQjOuj9VMtt4fsD0jC
X-Gm-Gg: AR+sD11kQADvvHQe6GbWGflQ1GpyLcBBAT3eSGf5z7Tk3EjnL5lp+PFuoppaIb8LHEa
	jLg9XF59TmytNZdKFzsf24AltZ5JQ4Pm1EqaigtJpEEuuyagOcoj4tKA6Mthb5rIE0XOFzg1TYJ
	uYzmaBIierLGADVBtpeZxx4TYWtx7ZwYgi5jGcyn7Y8YrWuKmLv6hb01ns9IFBp6i30Ijbnaydq
	qiowKqaaxQaqOEiGx6vhbdyfRc6uasQq1LbgwLNprebLbP2OQHbVbSFNWbByvfVV2x2Wp/lfkUK
	x1Ld9EVt4zEvyuVGkXUkrHK5FDzGXGwssUQzev8NqCug2Ntkscvrrai9630b8N3WrHdPR5XsSGe
	P5pfUdZDTa95gFtCeK3auNAmgG+7z+S9PujiY/Rqx98Ii5vFKjwFqF1UMfsIMQ8AoBlFkO8Vs/z
	r64VU8UYx3OumH3Pd/C5+Et5wdTnhbWkxRK9UBCGt/kLvXOoWAfIWecNrQp6gcCOy1QMaIDYklU
	vcqTi1DzV7wGuzZsoIvFB1MmQs6K5D7ns3gZ42xme8ufzD58HRVlDw=
X-Received: by 2002:a17:906:5183:10b0:c16:84dc:9607 with SMTP id a640c23a62f3a-c246a704562mr1871998066b.19.1787510110478;
        Sun, 23 Aug 2026 11:35:10 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box (dynamic-002-214-002-133.2.214.pool.telefonica.de. [2.214.2.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm805385066b.27.2026.08.23.11.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:35:10 -0700 (PDT)
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
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC 3/3] pciehp_hpc: workaround to not wait in pciehp_isr on surprise removal
Date: Sun, 23 Aug 2026 18:34:55 +0000
Message-ID: <20260823183458.982699-4-abhinjoses@gmail.com>
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
Content-Transfer-Encoding: 8bit

- Add pciehp_disconnect_work() , this function is used using schedule_work from pciehp_isr allowing us to not wait in pciehp_isr()
- pciehp_disconnect_work() is scheduled only if the card is not detected (PDS bit = 0).
       The PDS bit can be used to differentiate between a safe and surprise removal.

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb4..69ed6b060e9d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -620,6 +620,40 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
 	up_read(&ctrl->reset_lock);
 }
 
+/*
+ * Workaround to not wait in the isr.
+ */
+static void pciehp_disconnect_work(struct work_struct *work)
+{
+	struct controller *ctrl = container_of(work, struct controller,
+					       disconnect_work);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	int events;
+
+	events = atomic_read(&ctrl->pending_events);
+
+	/*
+	 * Ignore Link Down/Up events caused by Downstream Port Containment
+	 * if recovery succeeded, or caused by Secondary Bus Reset,
+	 * suspend to D3cold, firmware update, FPGA reconfiguration, etc.
+	 */
+	if ((events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
+	    (pci_dpc_recovered(pdev) || pci_hp_spurious_link_change(pdev)) &&
+	    ctrl->state == ON_STATE) {
+		// Ignore the link change events and return to normal operation.
+		// Could also wait here if needed.
+		return;
+	}
+
+	struct pci_bus *bus = ctrl->pcie->port->subordinate;
+
+	/* the card may have returned. */
+	if (!bus || pciehp_card_present(ctrl) != 0)
+		return;
+
+	pci_walk_bus(bus, pci_dev_set_disconnected, NULL);
+}
+
 static irqreturn_t pciehp_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
@@ -722,6 +756,17 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	/* Save pending events for consumption by IRQ thread. */
 	atomic_or(events, &ctrl->pending_events);
+
+	// presence change events
+	if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) {
+		// Get PDS bit to determine if card is present or not
+		int present = pciehp_card_present(ctrl);
+		if (!present) { // for sure the card is not present
+			schedule_work(&ctrl->disconnect_work);
+			// After this we are no longer in isr and can wait.
+		}
+	}
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -1036,6 +1081,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 	init_waitqueue_head(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
 	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
+	INIT_WORK(&ctrl->disconnect_work, pciehp_disconnect_work);
 	dbg_ctrl(ctrl);
 
 	down_read(&pci_bus_sem);
@@ -1096,6 +1142,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 void pciehp_release_ctrl(struct controller *ctrl)
 {
 	cancel_delayed_work_sync(&ctrl->button_work);
+	cancel_work_sync(&ctrl->disconnect_work);
 	kfree(ctrl);
 }
 
-- 
2.51.1

