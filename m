From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] xen/xenbus: Remove duplicate inclusion of
	asm/xen/hypervisor.h
Date: Mon, 19 Nov 2012 16:52:30 +0530
Message-ID: <1353324150-21785-1-git-send-email-sachin.kamat__7064.67089844427$1353350218$gmane$org@linaro.org>
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
To: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
Cc: sachin.kamat@linaro.org, patches@linaro.org, konrad.wilk@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

asm/xen/hypervisor.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/xen/xenbus/xenbus_xs.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index acedeab..88e677b 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -48,7 +48,6 @@
 #include <xen/xenbus.h>
 #include <xen/xen.h>
 #include "xenbus_comms.h"
-#include <asm/xen/hypervisor.h>
 
 struct xs_stored_msg {
 	struct list_head list;
-- 
1.7.4.1
