From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 49/54] Staging: hv: osd: remove Sleep wrapper
Date: Fri, 17 Jul 2009 11:09:39 -0700
Message-ID: <20090717180923.866394508@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=staging-hv-osd-remove-sleep-wrapper.patch
In-Reply-To: <20090720160025.GA20249@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Use the "real" udelay call instead of a wrapper function.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/NetVsc.c      |    9 +++++----
 drivers/staging/hv/StorVsc.c     |    7 ++++---
 drivers/staging/hv/include/osd.h |    2 --
 drivers/staging/hv/osd.c         |    5 -----
 4 files changed, 9 insertions(+), 14 deletions(-)

--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -110,8 +110,6 @@ extern int InterlockedIncrement(int *val
 extern int InterlockedDecrement(int *val);
 extern int InterlockedCompareExchange(int *val, int new, int curr);
 
-extern void Sleep(unsigned long usecs);
-
 extern void* VirtualAllocExec(unsigned int size);
 extern void VirtualFree(void* VirtAddr);
 
--- a/drivers/staging/hv/NetVsc.c
+++ b/drivers/staging/hv/NetVsc.c
@@ -24,6 +24,7 @@
 
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/delay.h>
 #include "include/logging.h"
 #include "NetVsc.h"
 #include "RndisFilter.h"
@@ -200,7 +201,7 @@ static inline NETVSC_DEVICE* ReleaseOutb
 	// Busy wait until the ref drop to 2, then set it to 1
 	while (InterlockedCompareExchange(&netDevice->RefCount, 1, 2) != 2)
 	{
-		Sleep(100);
+		udelay(100);
 	}
 
 	return netDevice;
@@ -217,7 +218,7 @@ static inline NETVSC_DEVICE* ReleaseInbo
 	// Busy wait until the ref drop to 1, then set it to 0
 	while (InterlockedCompareExchange(&netDevice->RefCount, 0, 1) != 1)
 	{
-		Sleep(100);
+		udelay(100);
 	}
 
 	Device->Extension = NULL;
@@ -923,7 +924,7 @@ NetVscOnDeviceRemove(
 	{
 		DPRINT_INFO(NETVSC, "waiting for %d requests to complete...", netDevice->NumOutstandingSends);
 
-		Sleep(100);
+		udelay(100);
 	}
 
 	DPRINT_INFO(NETVSC, "Disconnecting from netvsp...");
@@ -1318,7 +1319,7 @@ retry_send_cmplt:
 
 		if (retries < 4)
 		{
-			Sleep(100);
+			udelay(100);
 			goto retry_send_cmplt;
 		}
 		else
--- a/drivers/staging/hv/osd.c
+++ b/drivers/staging/hv/osd.c
@@ -131,11 +131,6 @@ int InterlockedCompareExchange(int *val,
 
 }
 
-void Sleep(unsigned long usecs)
-{
-	udelay(usecs);
-}
-
 void* VirtualAllocExec(unsigned int size)
 {
 #ifdef __x86_64__
--- a/drivers/staging/hv/StorVsc.c
+++ b/drivers/staging/hv/StorVsc.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/delay.h>
 #include "include/logging.h"
 
 #include "include/StorVscApi.h"
@@ -225,7 +226,7 @@ static inline STORVSC_DEVICE* ReleaseSto
 	// Busy wait until the ref drop to 2, then set it to 1
 	while (InterlockedCompareExchange(&storDevice->RefCount, 1, 2) != 2)
 	{
-		Sleep(100);
+		udelay(100);
 	}
 
 	return storDevice;
@@ -242,7 +243,7 @@ static inline STORVSC_DEVICE* FinalRelea
 	// Busy wait until the ref drop to 1, then set it to 0
 	while (InterlockedCompareExchange(&storDevice->RefCount, 0, 1) != 1)
 	{
-		Sleep(100);
+		udelay(100);
 	}
 
 	Device->Extension = NULL;
@@ -582,7 +583,7 @@ StorVscOnDeviceRemove(
 	{
 		DPRINT_INFO(STORVSC, "waiting for %d requests to complete...", storDevice->NumOutstandingRequests);
 
-		Sleep(100);
+		udelay(100);
 	}
 
 	DPRINT_INFO(STORVSC, "removing storage device (%p)...", Device->Extension);
