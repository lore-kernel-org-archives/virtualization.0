From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 7/8] Staging: hv: Get rid of the vmbus merge item
Date: Tue, 19 Jul 2011 11:44:24 -0700
Message-ID: <1311101065-23417-7-git-send-email-kys@microsoft.com>
References: <1311101018-23370-1-git-send-email-kys@microsoft.com>
	<1311101065-23417-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1311101065-23417-1-git-send-email-kys@microsoft.com>
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

The host/guest transport is very host centric. Given this, it is unlikely
that we will be able to merge vmbus with other host/guest buses in the kernel.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/TODO |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/TODO b/drivers/staging/hv/TODO
index b6335ff..8b4c97a 100644
--- a/drivers/staging/hv/TODO
+++ b/drivers/staging/hv/TODO
@@ -1,8 +1,6 @@
 TODO:
 	- audit the vmbus to verify it is working properly with the
 	  driver model
-	- see if the vmbus can be merged with the other virtual busses
-	  in the kernel
 	- audit the network driver
 	  - checking for carrier inside open is wrong, network device API
             confusion??
-- 
1.7.4.1
