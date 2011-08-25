From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 55/59] Staging: hv: netvsc: Cleanup error code in rndis_filter_device_add()
Date: Thu, 25 Aug 2011 09:49:21 -0700
Message-ID: <1314290965-2698-55-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
 <1314290965-2698-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use standard Linux error codes.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/rndis_filter.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index a71f29d..f0d1362 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -673,7 +673,7 @@ int rndis_filter_device_add(struct hv_device *dev,
 
 	rndisDevice = get_rndis_device();
 	if (!rndisDevice)
-		return -1;
+		return -ENODEV;
 
 	/*
 	 * Let the inner driver handle this first to create the netvsc channel
-- 
1.7.4.1
