Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D4DC43219
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 15:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 998CB40222;
	Tue, 23 Nov 2021 15:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pswwcBclmX7N; Tue, 23 Nov 2021 15:56:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD40F400E1;
	Tue, 23 Nov 2021 15:56:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B08FCC0038;
	Tue, 23 Nov 2021 15:56:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81D69C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CA9280D3E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7hO3aQ3jIMsV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33A3480D2A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:40 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id u1so39745402wru.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rh/v7U68tKyXyQ6b3jj07z0WH7Y+IG2IvCQMWCW7whk=;
 b=OWJhcdUegx2avyXwMP3MIkRdjcVNtiP8PgBrguw2/NCr+VtjzKfv7g8GAav9ZgRhE6
 hKKpKPhMfuaY4lk61j/OGm5E5n6zlvFjdoGnSjr1CC14jxukFm3U71ud9uVSM9cdYljo
 5mtxVVa0KxYQp4NMVLG9dq6AeM8FaNUVc/bOiPa2IXSsGLXyE7dtXdK13gUl75Y+Ojqf
 Yv21GwUjp36Ed7ZzaQySv2nBH1vBvKFJeW5+87GB4eiAneJTk4t3H9EayQ0d/ymqtC3B
 wramIJtFvEBI92p2bdZP+xXzJwh0qLSgjuWs4oJJKOu/LSGFkpyzl1eKygpkuyVY2bbw
 2kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rh/v7U68tKyXyQ6b3jj07z0WH7Y+IG2IvCQMWCW7whk=;
 b=40YXuwhFnOlniK7NfdWShzNkbE0vpQ46MAEDi/T5Hz0ll+f5+DbH6jM5F3ooJhHR7B
 qZTH7bHHjP+meHgmr4Hatz4uJLO+H7+S8cEXHsamKIBnIbxuDk7sdu+dw7p5q07M4J8n
 RWgVwl/deOaf7LH/eaC4pc0MXb8xP8ypYvjd+6wBib1JsrUYqMgLyJWN8ncNUleiqnnY
 sG9x5me3t96+0fjCicU8B7D8zJrUgG2FJ0qWNnmJR6FiA+JrQ3j/pCcdA6dExmDKZlOX
 rrbalpFfsByGY5S/JtvlG8UoEXEsHiJDgC61YQcRpYXPmzjaX6hEJUtH5MAQXD1OuIXN
 1RbQ==
X-Gm-Message-State: AOAM532+W/Uaxn5vE89qWvFhh1bBhL+xEHYwYFxZLDm/I2YKtqsXIGbn
 MWShi0VurXE/vUOmaZECeUCcgw==
X-Google-Smtp-Source: ABdhPJyt669Qyl5fKNeC+DkjJd6fHbpPgxmbo2SgviMWvuorCu2JK0a7+FItJ+LvEAVdNOREgKXjZQ==
X-Received: by 2002:adf:f990:: with SMTP id f16mr8473053wrr.128.1637682998253; 
 Tue, 23 Nov 2021 07:56:38 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 07:56:37 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 1/5] iommu/virtio: Add definitions for
 VIRTIO_IOMMU_F_BYPASS_CONFIG
Date: Tue, 23 Nov 2021 15:52:58 +0000
Message-Id: <20211123155301.1047943-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123155301.1047943-1-jean-philippe@linaro.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, eric.auger@redhat.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com
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

Add definitions for the VIRTIO_IOMMU_F_BYPASS_CONFIG, which supersedes
VIRTIO_IOMMU_F_BYPASS.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..cafd8cf7febf 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_BYPASS_CONFIG		6
 
 struct virtio_iommu_range_64 {
 	__le64					start;
@@ -36,6 +37,8 @@ struct virtio_iommu_config {
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
 	__le32					probe_size;
+	__u8					bypass;
+	__u8					reserved[7];
 };
 
 /* Request types */
@@ -66,11 +69,14 @@ struct virtio_iommu_req_tail {
 	__u8					reserved[3];
 };
 
+#define VIRTIO_IOMMU_ATTACH_F_BYPASS		(1 << 0)
+
 struct virtio_iommu_req_attach {
 	struct virtio_iommu_req_head		head;
 	__le32					domain;
 	__le32					endpoint;
-	__u8					reserved[8];
+	__le32					flags;
+	__u8					reserved[4];
 	struct virtio_iommu_req_tail		tail;
 };
 
-- 
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
