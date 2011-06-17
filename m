From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 2/5] staging: hv: remove unnecessary includes in netvsc
Date: Fri, 17 Jun 2011 07:58:05 -0700
Message-ID: <1308322688-9796-2-git-send-email-haiyangz__24351.3143891052$1308321935$gmane$org@microsoft.com>
References: <1308322688-9796-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1308322688-9796-1-git-send-email-haiyangz@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, vir
List-Id: virtualization@lists.linuxfoundation.org

hyperv.h is included by hyperv_net.h already, so no need to include it
again in these C files.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc.c       |    1 -
 drivers/staging/hv/netvsc_drv.c   |    1 -
 drivers/staging/hv/rndis_filter.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index b6e1fb9..ed9b8af 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -28,7 +28,6 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
-#include "hyperv.h"
 #include "hyperv_net.h"
 
 
diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 8380fe9..e5aba38 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -38,7 +38,6 @@
 #include <net/sock.h>
 #include <net/pkt_sched.h>
 
-#include "hyperv.h"
 #include "hyperv_net.h"
 
 static const char *driver_name = "netvsc";
diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index 6db48b9..8416bf2 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -27,7 +27,6 @@
 #include <linux/if_ether.h>
 #include <linux/netdevice.h>
 
-#include "hyperv.h"
 #include "hyperv_net.h"
 
 
-- 
1.6.3.2
