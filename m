From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 079/117] Staging: hv: storvsc: Cleanup alloc_stor_device()
Date: Fri, 15 Jul 2011 10:47:07 -0700
Message-ID: <1310752065-27895-79-git-send-email-kys@microsoft.com>
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

Cleanup alloc_stor_device(), we can set the ref_count directly.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 313a3f8..48bd8da 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -42,7 +42,7 @@ static inline struct storvsc_device *alloc_stor_device(struct hv_device *device)
 
 	/* Set to 2 to allow both inbound and outbound traffics */
 	/* (ie get_out_stor_device() and get_in_stor_device()) to proceed. */
-	atomic_cmpxchg(&stor_device->ref_count, 0, 2);
+	atomic_set(&stor_device->ref_count, 2);
 
 	init_waitqueue_head(&stor_device->waiting_to_drain);
 	stor_device->device = device;
-- 
1.7.4.1
