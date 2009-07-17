From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 31/54] Staging: hv: remove #defines from osd.c
Date: Fri, 17 Jul 2009 11:09:21 -0700
Message-ID: <20090717180920.969888881@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-remove-defines-from-osd.c.patch
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

Remove the unneeded #defines from osd.c

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/hv/osd.c |   42 ------------------------------------------
 1 file changed, 42 deletions(-)

--- a/drivers/staging/hv/osd.c
+++ b/drivers/staging/hv/osd.c
@@ -21,15 +21,12 @@
  *
  */
 
-#define KERNEL_2_6_27
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
-//#include <linux/config.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -86,20 +83,11 @@ typedef struct _WORKITEM {
 
 void LogMsg(const char *fmt, ...)
 {
-#ifdef KERNEL_2_6_5
-	char buf[1024];
-#endif
 	va_list args;
 
 	va_start(args, fmt);
-#ifdef KERNEL_2_6_5
-	vsnprintf(buf, 1024, fmt, args);
-	va_end(args);
-	printk(buf);
-#else
 	vprintk(fmt, args);
 	va_end(args);
-#endif
 }
 
 void BitSet(unsigned int* addr, int bit)
@@ -130,30 +118,12 @@ int BitTestAndSet(unsigned int* addr, in
 
 int InterlockedIncrement(int *val)
 {
-#ifdef KERNEL_2_6_5
-	int i;
-	local_irq_disable();
-	i = atomic_read((atomic_t*)val);
-	atomic_set((atomic_t*)val, i+1);
-	local_irq_enable();
-	return i+1;
-#else
 	return atomic_inc_return((atomic_t*)val);
-#endif
 }
 
 int InterlockedDecrement(int *val)
 {
-#ifdef KERNEL_2_6_5
-	int i;
-	local_irq_disable();
-	i = atomic_read((atomic_t*)val);
-	atomic_set((atomic_t*)val, i-1);
-	local_irq_enable();
-	return i-1;
-#else
 	return atomic_dec_return((atomic_t*)val);
-#endif
 }
 
 #ifndef atomic_cmpxchg
@@ -428,11 +398,7 @@ unsigned long Virtual2Physical(void * Vi
 	return pfn << PAGE_SHIFT;
 }
 
-#ifdef KERNEL_2_6_27
 void WorkItemCallback(struct work_struct *work)
-#else
-void WorkItemCallback(void* work)
-#endif
 {
 	WORKITEM* w = (WORKITEM*)work;
 
@@ -474,11 +440,7 @@ int WorkQueueQueueWorkItem(HANDLE hWorkQ
 
 	w->callback = workItem,
 	w->context = context;
-#ifdef KERNEL_2_6_27
 	INIT_WORK(&w->work, WorkItemCallback);
-#else
-	INIT_WORK(&w->work, WorkItemCallback, w);
-#endif
 	return queue_work(wq->queue, &w->work);
 }
 
@@ -492,10 +454,6 @@ void QueueWorkItem(PFN_WORKITEM_CALLBACK
 
 	w->callback = workItem,
 	w->context = context;
-#ifdef KERNEL_2_6_27
 	INIT_WORK(&w->work, WorkItemCallback);
-#else
-	INIT_WORK(&w->work, WorkItemCallback, w);
-#endif
 	schedule_work(&w->work);
 }
