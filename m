From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 8/8] Staging: hv: Update the TODO file
Date: Tue, 19 Jul 2011 11:44:25 -0700
Message-ID: <1311101065-23417-8-git-send-email-kys@microsoft.com>
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

The TODO file has not been updated in a long time. Update this file
to reflect the current status.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/TODO |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/TODO b/drivers/staging/hv/TODO
index 8b4c97a..23c74ed 100644
--- a/drivers/staging/hv/TODO
+++ b/drivers/staging/hv/TODO
@@ -1,11 +1,30 @@
 TODO:
 	- audit the vmbus to verify it is working properly with the
 	  driver model
+
+		STATUS (July 19, 2011):
+		All outstanding issues (known to us)  with regards
+		to conforming to Linux Driver Model have been addressed.
+
 	- audit the network driver
 	  - checking for carrier inside open is wrong, network device API
             confusion??
+
+		STATUS (July 19, 2011):
+		The network driver has been reviewed by the community.
+		We have addressed the various issues that were raised in this
+		review.
+
 	- audit the block driver
 	- audit the scsi driver
 
+		STATUS (July 19, 2011):
+		One of the longstanding comment on this body of code
+		has been to merge the block and scsi driver. This has been done
+		and patches have been submitted. We have also addressed all the
+		review comments on this body of code.
+
+
 Please send patches for this code to Greg Kroah-Hartman <gregkh@suse.de>,
-Hank Janssen <hjanssen@microsoft.com>, and Haiyang Zhang <haiyangz@microsoft.com>.
+Hank Janssen <hjanssen@microsoft.com>, and Haiyang Zhang <haiyangz@microsoft.com>,
+K. Y. Srinivasan <kys@microsoft.com>.
-- 
1.7.4.1
