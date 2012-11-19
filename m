From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] vhost: Remove duplicate inclusion of linux/vhost.h
Date: Mon, 19 Nov 2012 16:58:28 +0530
Message-ID: <1353324508-22083-1-git-send-email-sachin.kamat__49973.384946543$1353350229$gmane$org@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: sachin.kamat@linaro.org, patches@linaro.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

linux/vhost.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/vhost/tcm_vhost.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 73bbc46..798792b 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -34,7 +34,6 @@
 #include <linux/ctype.h>
 #include <linux/compat.h>
 #include <linux/eventfd.h>
-#include <linux/vhost.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <asm/unaligned.h>
-- 
1.7.4.1
