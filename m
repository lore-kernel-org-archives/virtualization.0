From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 066/117] Staging: hv: netvsc: Cleanup error codes in
	rndis_filter_receive()
Date: Fri, 15 Jul 2011 10:46:54 -0700
Message-ID: <1310752065-27895-66-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use standard Linux error codes.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/rndis_filter.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index dbb5201..8e1ef00 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -358,14 +358,14 @@ int rndis_filter_receive(struct hv_device *dev,
 	if (!net_dev->extension) {
 		dev_err(&dev->device, "got rndis message but no rndis device - "
 			  "dropping this message!\n");
-		return -1;
+		return -ENODEV;
 	}
 
 	rndis_dev = (struct rndis_device *)net_dev->extension;
 	if (rndis_dev->state == RNDIS_DEV_UNINITIALIZED) {
 		dev_err(&dev->device, "got rndis message but rndis device "
 			   "uninitialized...dropping this message!\n");
-		return -1;
+		return -ENODEV;
 	}
 
 	rndis_hdr = (struct rndis_message *)kmap_atomic(
-- 
1.7.4.1
