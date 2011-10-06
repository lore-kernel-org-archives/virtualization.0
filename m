From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] Staging: hv: netvsc: Fix a dereferencing issue
Date: Thu,  6 Oct 2011 10:10:56 -0700
Message-ID: <1317921056-17141-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, dan.carpenter@oracle.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

net_dev is being de-referenced without proper checking; fix it.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/hv/rndis_filter.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index ef43f2e..bafccb3 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -368,11 +368,11 @@ int rndis_filter_receive(struct hv_device *dev,
 	struct rndis_message *rndis_hdr;
 	struct net_device *ndev;
 
-	ndev = net_dev->ndev;
-
 	if (!net_dev)
 		return -EINVAL;
 
+	ndev = net_dev->ndev;
+
 	/* Make sure the rndis device state is initialized */
 	if (!net_dev->extension) {
 		netdev_err(ndev, "got rndis message but no rndis device - "
-- 
1.7.4.1
