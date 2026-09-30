Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401C4F472F
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783974; cv=none; b=opTnDNA22Ro72NngutCTPjk7Wb8GrI40CSF7K8WX7ora+tGMyvnOs6lboqkqfb5wcwLgGBJNDYjPtetogi/HWPcXoa+FM4ndaZ29ieDFgDYeGAn1183ieBrxdapoOqOGnVdV49ICcDw7x23pMmrZm5D4L8AT4gocTkKIWiDERXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783974; c=relaxed/simple;
	bh=50nZY6PQAtGtgZSOnvkvfuQNWS2RvqbnnzACfieinj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dApgcRiMraHvoqGUCZcpG5ww7Z0hH3jYMFW6+7/XtDPeyrhh9PB53/t4jmPtV0rgvBdP1iFAnRZpI3cnZbCngwDHbGtGb92DZK1WEWjR/JEseE6d5ZAJRgNPD35bBVqatVw7JE5YY75xLGgwz4LDvyZ27ibW2TT/S5IlwDfRitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKRekJ7K; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKRekJ7K"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532c7643bc4so65386091cf.3
        for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783967; x=1791388767; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzkcCjYLhlXtlTgNVSY8HEZ8Fih4l8n9pVSwPxokMKk=;
        b=EKRekJ7KegGN9qN0XKMTG4kavTV7nP4vwo907bgdVZ1zVL2D5aKvF71RuznDiAd59i
         olnqNzg8lDs/UrzdN+KQL2vIImd+hAEqTTgakCE/du+fKtzKRzULy9FtIOYWaHpa985y
         P+utJ7L7hDJvm10FeEd7Wr1KGn/9C/kOYg4TTKKixw8DQLBo2YWRZ8ndM11g4UoLsZF3
         CFM/CMbQEYbKHNQtCpKzX/bkifNLK8iqD1QRHGSftpHO+l5yovpSJbYAuVClm5r/ZHiB
         Aa1QyyXEoh9jhbWYyzzqkDDkp1KHLnxqeOZPEBC68KJ0RUqrYLZixDwF/za8btrOGeGf
         /jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783967; x=1791388767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzkcCjYLhlXtlTgNVSY8HEZ8Fih4l8n9pVSwPxokMKk=;
        b=lwLOVHIjXAZnpJRjJ83xTzf0eenLiSH2yXA4y7jnZxnQd3hmsET9B9VAnOxJ6M8tHN
         GVmEdzlpFX3+lW+oa2ciXvraiamVeaP2I+/mVb1BdrawECcsmynPUi2ke5kRvNtkkfGL
         E4dqGUObcjji89tKXBfj3MELbfShmvpRqP4O7zGztuBshlSdu+BvuiS/6T0SOBJh7BAj
         A9CfDWDWvngPbWagFSlLx0FiN3u18s5YIxvjrB4qJfuF9/wRaB0CO7xqOt9UobemlUg6
         WYa66EWCdK8S1b1amIdW68hueSqRXIczSWlI9xQZs1VAmXWQ/uGQfcVCeibYxCm+KXf8
         /j4w==
X-Forwarded-Encrypted: i=1; AKwUvBzd9ha0kSiJGVCFNfHOVskiLAzWTBdMraYOZIOY6NUpYsKcbuSP8puBNimt/ohfpxS7jZRyz1NgLEodHe1gNQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kdeq/4oC1TXKgXJHESyufBPrPuw+50tBs/wFQx7JinwydB/Imv
	ASoY3tStQt+5Dy5LJq4GvDFvkRQJxKqoLS5ibiwSujzGBXwQk+hXYp0Q
X-Gm-Gg: AYBFou18eRGHnsmfOovRgfafoOSsD2eajwCpJgPBFHVU0Cmhbpw8iAig7Pt60DjzVNF
	YcCV6RT9GeGZ2lxFyWvcdsZJByqIitAIiyRJp9STidGSfTHKyPKn2Y3MZDqsOzPLeKh0FcsBq9j
	xK08JLL7aMNDiTBkXqJPfJWlQnGYzkKaqjGkwqaohl/oS2rnkFWbHJBVPyLBtWcM5qnWgPxYPYn
	/toozxOSiEYPmz7xnFHJUbffC0ZfxBied4JiC+Mr1x1fJMmXYA0m3aD4iU26Hr1ewRCTJ5J0mpt
	cLNq0ILqEg3a8a9IcP0w9DBysi32GhPZpCsD3+x/Ig0zmqv7DfufGVzcU62B4aMeWP5sWmNDEBQ
	/FVDOOEQ6LBPQHGTgH20H+2I5EyOyBVJdg+cUMf3+cgepWk984XhisYxFsmrPAlrdrcxfeXlZ28
	A4GjXX2jRwqdG2hFGsXh/355v4e6K5wYdDuRUz/mfsoSKmoJtbqXZy+GNNvHEyMAD7t50lKJyLT
	gKAMd6MGaD/zRmEzrpW3g==
X-Received: by 2002:a05:622a:985:b0:530:b2e4:4e30 with SMTP id d75a77b69052e-53374d801bcmr35448021cf.61.1790783966849;
        Wed, 30 Sep 2026 08:59:26 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5338253300fsm2866831cf.27.2026.09.30.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:59:26 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Zhu Lingshan <lingshan.zhu@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH RFC v1] vdpa/ifcvf: Time out and report device reset failure
Date: Wed, 30 Sep 2026 11:59:01 -0400
Message-ID: <20260930155920.1684465-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ifcvf_reset() writes 0 to device_status and polls it without a bound,
and ifcvf_vdpa_reset() always returns 0. A device that does not finish
the reset, or one that was surprise-removed and reads back 0xff, keeps
the caller in the reset path forever.

Bound the poll with readx_poll_timeout() and return -ETIMEDOUT from
.reset, so that callers such as VHOST_VDPA_SET_STATUS(0) see the failure
instead of hanging. Stop right away with -ENODEV once the device reads
back all ones and is no longer present, as there is nothing left to
wait for.

Fixes: 386a26208524 ("vDPA/ifcvf: synchronize irqs in the reset routine")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
RFC for two reasons:
- The spec gives no bound for a reset; 10 seconds follows octeon_ep's
  OCTEP_HW_TIMEOUT.
- vhost_vdpa_release() ignores a reset failure and still tears the
  mappings down, so on close a timeout turns a hang into teardown while
  the device may still be active. That needs a separate fix in
  vhost-vdpa.

Compile-tested only (x86_64 defconfig + IFCVF, W=1).

 drivers/vdpa/ifcvf/ifcvf_base.c | 24 +++++++++++++++++++++---
 drivers/vdpa/ifcvf/ifcvf_base.h |  3 ++-
 drivers/vdpa/ifcvf/ifcvf_main.c |  4 +---
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index d5507b63b6cdb..8a6c8f8314d53 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -8,6 +8,8 @@
  *
  */
 
+#include <linux/iopoll.h>
+
 #include "ifcvf_base.h"
 
 u16 ifcvf_set_vq_vector(struct ifcvf_hw *hw, u16 qid, int vector)
@@ -201,11 +203,27 @@ void ifcvf_set_status(struct ifcvf_hw *hw, u8 status)
 	vp_iowrite8(status, &hw->common_cfg->device_status);
 }
 
-void ifcvf_reset(struct ifcvf_hw *hw)
+static bool ifcvf_reset_done(struct ifcvf_hw *hw, u8 status)
 {
+	/* A surprise-removed device reads back all ones and never resets */
+	return !status || (status == 0xff && !pci_device_is_present(hw->pdev));
+}
+
+int ifcvf_reset(struct ifcvf_hw *hw)
+{
+	u8 status;
+	int ret;
+
 	ifcvf_set_status(hw, 0);
-	while (ifcvf_get_status(hw))
-		msleep(1);
+	ret = readx_poll_timeout(ifcvf_get_status, hw, status,
+				 ifcvf_reset_done(hw, status),
+				 1000, IFCVF_RESET_TIMEOUT_US);
+	if (ret) {
+		IFCVF_ERR(hw->pdev, "timed out waiting for device reset\n");
+		return ret;
+	}
+
+	return status ? -ENODEV : 0;
 }
 
 u64 ifcvf_get_hw_features(struct ifcvf_hw *hw)
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index aa36de361c10e..57d00b881582b 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -29,6 +29,7 @@
 
 #define IFCVF_LM_BAR			4
 #define IFCVF_MIN_VQ_SIZE		64
+#define IFCVF_RESET_TIMEOUT_US		(10 * USEC_PER_SEC)
 
 #define IFCVF_ERR(pdev, fmt, ...)	dev_err(&pdev->dev, fmt, ##__VA_ARGS__)
 #define IFCVF_DBG(pdev, fmt, ...)	dev_dbg(&pdev->dev, fmt, ##__VA_ARGS__)
@@ -112,7 +113,7 @@ void ifcvf_write_dev_config(struct ifcvf_hw *hw, u64 offset,
 			    const void *src, int length);
 u8 ifcvf_get_status(struct ifcvf_hw *hw);
 void ifcvf_set_status(struct ifcvf_hw *hw, u8 status);
-void ifcvf_reset(struct ifcvf_hw *hw);
+int ifcvf_reset(struct ifcvf_hw *hw);
 u64 ifcvf_get_dev_features(struct ifcvf_hw *hw);
 u64 ifcvf_get_hw_features(struct ifcvf_hw *hw);
 int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features);
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 2af1cec958848..6c569f01bec91 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -444,9 +444,7 @@ static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
 	if (status & VIRTIO_CONFIG_S_DRIVER_OK)
 		ifcvf_free_irq(vf);
 
-	ifcvf_reset(vf);
-
-	return 0;
+	return ifcvf_reset(vf);
 }
 
 static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.43.0

