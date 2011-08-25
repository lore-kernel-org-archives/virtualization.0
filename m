From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 46/59] Staging: hv: netvsc: Cleanup error return codes in
	netvsc_destroy_recv_buf()
Date: Thu, 25 Aug 2011 09:49:12 -0700
Message-ID: <1314290965-2698-46-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
	<1314290965-2698-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup error return codes in netvsc_destroy_recv_buf().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index b89ac7e..baa0c8d 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -160,7 +160,7 @@ static int netvsc_destroy_recv_buf(struct netvsc_device *net_device)
 		if (ret != 0) {
 			dev_err(&net_device->dev->device, "unable to send "
 				"revoke receive buffer to netvsp");
-			return -1;
+			return ret;
 		}
 	}
 
@@ -175,7 +175,7 @@ static int netvsc_destroy_recv_buf(struct netvsc_device *net_device)
 		if (ret != 0) {
 			dev_err(&net_device->dev->device,
 				   "unable to teardown receive buffer's gpadl");
-			return -1;
+			return -ret;
 		}
 		net_device->recv_buf_gpadl_handle = 0;
 	}
-- 
1.7.4.1
