Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA243644CB
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135519; cv=none; b=e9bXZEINFGSCVvw1Xbf7vu8Vx9e9OhrJQeFkWB1DBJinhdhR1qfh6FaeCKUyZtgFza5k1Jf8v/AqM23VcsF9hQwjRVmuaNZr3V80h5ZgWdrSaq5P8WpSih5HsAcvIz7Bb5AnLU9GamdyiQUJFRQnDBRZFUM9pmgMBFvseI2hTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135519; c=relaxed/simple;
	bh=V+gqkneyMbnTJWfQKrVZzngzKiTmgzZaUwEDLk2IM7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EbnvOArZuDy8T4LcEoqZ2xxiYtPxu7c5kIsWVKzP941f0dJJFQpJtHdhZhVv/onv+D6E34D0KxPt/WTq/H+QwvFlyEa1azzgAJ26iTyT56mVUMpEO7B6vYWlfnJXMZKVuhFjOl3H4bBsQ2oBYsMezwnSrRd3hVbzt62xsIXiQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4GRRIQr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4GRRIQr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e985106c0cso3131375ad.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792135517; x=1792740317; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZeTOkyvsFAq6IDsBYCsxTY31J5PpJnBjyNYspX0Us+A=;
        b=T4GRRIQr8a/yWu787HSeQNJfZhtYbFT0wo6eCm8KsbowXOtO1Ir6mvDlw/K+G4HAnJ
         EQ2T+OvIebZJdpCeran6nSgvrdPelpCe/Jy1+Uh+TWWtsIBoMDjT3RLGWmUv8UiztpFd
         hRJR5tGK4/pMVenwozblvBVPveKjwnNlErXqPHXiBW1RmNwIzxCyIoocPI3eA3uoYDHa
         bb22x/mofqwcA45pO2gx9IgVHY0X26itRMxS33ENShj+eU/EMEbZSm+bbp/BO9BpbUZ4
         ki9LnldK7VSovIe856vdoXjmEJK6N9m9OI2XfVWxyHKlsyMNzv20cEIUg0Tf1myfsF2Y
         7ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792135517; x=1792740317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZeTOkyvsFAq6IDsBYCsxTY31J5PpJnBjyNYspX0Us+A=;
        b=kuskryYDvhjErpyxf3QEWNhxxOfUSWqsO0Yo06JnIu0wFwJFR2xHEsW+GKwN/zKL7o
         kv1mp+IJ4hn9EkS5n0GKz7ZNVy8ilZjLbIRrWr5L2Gtj+4FMtG1DhBKwt2PnUpPP4jOC
         B5oIhaHUvmrofYOowm7ikVKRQpiu6ywtviU/at3UMywsJrPRcexleaBNuyHqUBr75sXk
         cL5mx6eG/OFtjdINwibSNNZEWEsbh56eKbi1tkTBdiL8/+ZoLWYmWYjWP4Y3lWD2U4XY
         Su8UtDk6ZadhFbuFb3r0lBH5VAIqfZ0mfYwdenXu0pqwGfTZuvDET650LHlor6cl+pYN
         7e+w==
X-Forwarded-Encrypted: i=1; AKwUvBzBDrH9I5t50VI9xrSndbDYPmQcTjzD9lK284iFEyMk7ou+22PKw6Z5WANUOW2ZLwfkPkyzg2WfVxt3snHx/w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIsN0kOdgQXJd33sQFhuA2AqTsiaqs29W/+W5EAamPiqQzCbB1I
	16mEmCkxa0qNddpISyGsmxpGG3EjLovV3028f3uo0PffJR/2OqMg3ryU
X-Gm-Gg: AYBFou2lQA35KgS99GLzw8OJySfLX7kVB9SAP7KbRcWLuCD7X7MD7pygUOSg/wRZjjI
	CeMqXbp4/xK3FWfW5yobcU7U3ycjuBkLzTM/UE3h/1akgMxh0eOjB6MWMOmK9SmB59nVEEbW9Kj
	zqzwRuDZfm51xgH3nY9AxE+Vvdtb0YfsBGtdH+4z6aayoL8cu7evbQCBJdIZY1U+FwirVnegJ4Q
	Gha7gArMWh7HuYb4fDXAoLnggIMXkfgWfOlDLol0uNdWxItAK5uJbhBKIhYlpbM8mpDvAIIX+qa
	EcHD5UnkN59BseVXljP/IZM2ucDBNB6qbHEPDw+0+CGlt5aQ/sE4UqWhEjoHC8POPNF4y4xV02a
	O/9oWuqk4+nNrvuyGcuvsq5g3wJJMfDvbKg1GBsg1gG7h/i/PesQq6JAy7M4rSiKjY1hi9BKeVR
	RmFGM89JovNsasoAaG+/cU0jprYw9hxgxh4vTHmUIfRBNO0IfQ+Wvbj+fobcHSTlDJ
X-Received: by 2002:a17:903:2a85:b0:2e8:b5b2:a9f9 with SMTP id d9443c01a7336-2e8b5b2ad3amr145465665ad.37.1792135517104;
        Fri, 16 Oct 2026 00:25:17 -0700 (PDT)
Received: from oslab.. ([140.120.15.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e878bf6sm5941625ad.57.2026.10.16.00.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:25:16 -0700 (PDT)
From: Wei-Shuo Chen <tavhadia@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wei-Shuo Chen <tavhadia@gmail.com>
Subject: [PATCH] virtio: use consistent virtqueue terminology
Date: Fri, 16 Oct 2026 15:23:18 +0800
Message-ID: <20261016072318.24015-1-tavhadia@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use virtqueue consistently in the notify function comments
across the MMIO and PCI transports.

Assisted-by: LLM

Signed-off-by: Wei-Shuo Chen <tavhadia@gmail.com>
---
 drivers/virtio/virtio_mmio.c       | 2 +-
 drivers/virtio/virtio_pci_common.c | 2 +-
 drivers/virtio/virtio_pci_common.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index faae58e3401a..e2ec0ec01d67 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -270,7 +270,7 @@ static void vm_reset(struct virtio_device *vdev)
 
 /* Transport interface */
 
-/* the notify function used when creating a virt queue */
+/* the notify function used when creating a virtqueue */
 static bool vm_notify(struct virtqueue *vq)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b90c174450b2..60d9b73d74b9 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -47,7 +47,7 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
 		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
 }
 
-/* the notify function used when creating a virt queue */
+/* the notify function used when creating a virtqueue */
 bool vp_notify(struct virtqueue *vq)
 {
 	/* we write the queue's selector into the notification register to
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..18b6dbdfd1e5 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -127,7 +127,7 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
 
 /* wait for pending irq handlers */
 void vp_synchronize_vectors(struct virtio_device *vdev);
-/* the notify function used when creating a virt queue */
+/* the notify function used when creating a virtqueue */
 bool vp_notify(struct virtqueue *vq);
 /* the config->del_vqs() implementation */
 void vp_del_vqs(struct virtio_device *vdev);
-- 
2.43.0

