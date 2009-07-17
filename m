From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 48/54] Staging: hv: osd: remove spinlock wrapper functions
Date: Fri, 17 Jul 2009 11:09:38 -0700
Message-ID: <20090717180923.696192160@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-osd-remove-spinlock-wrapper-functions.patch
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

Now that there are no users of the wrapper functions for spinlocks,
remove them.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/hv/include/osd.h |    5 -----
 drivers/staging/hv/osd.c         |   37 -------------------------------------
 2 files changed, 42 deletions(-)

--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -137,11 +137,6 @@ extern int	WaitEventWait(HANDLE hWait);
 // If >0, hWait got signaled. If ==0, timeout. If < 0, error
 extern int	WaitEventWaitEx(HANDLE hWait, u32 TimeoutInMs);
 
-extern HANDLE SpinlockCreate(void);
-extern void SpinlockClose(HANDLE hSpin);
-extern void SpinlockAcquire(HANDLE hSpin);
-extern void	SpinlockRelease(HANDLE hSpin);
-
 
 #define GetVirtualAddress Physical2LogicalAddr
 void* Physical2LogicalAddr(unsigned long PhysAddr);
--- a/drivers/staging/hv/osd.c
+++ b/drivers/staging/hv/osd.c
@@ -61,11 +61,6 @@ typedef struct _WAITEVENT {
 	wait_queue_head_t event;
 } WAITEVENT;
 
-typedef struct _SPINLOCK {
-	spinlock_t		lock;
-	unsigned long	flags;
-} SPINLOCK;
-
 typedef struct _WORKQUEUE {
 	struct workqueue_struct *queue;
 } WORKQUEUE;
@@ -323,38 +318,6 @@ int WaitEventWaitEx(HANDLE hWait, u32 Ti
 	return ret;
 }
 
-HANDLE SpinlockCreate(void)
-{
-	SPINLOCK* spin = kmalloc(sizeof(SPINLOCK), GFP_KERNEL);
-	if (!spin)
-	{
-		return NULL;
-	}
-	spin_lock_init(&spin->lock);
-
-	return spin;
-}
-
-void SpinlockAcquire(HANDLE hSpin)
-{
-	SPINLOCK* spin = (SPINLOCK* )hSpin;
-
-	spin_lock_irqsave(&spin->lock, spin->flags);
-}
-
-void SpinlockRelease(HANDLE hSpin)
-{
-	SPINLOCK* spin = (SPINLOCK* )hSpin;
-
-	spin_unlock_irqrestore(&spin->lock, spin->flags);
-}
-
-void SpinlockClose(HANDLE hSpin)
-{
-	SPINLOCK* spin = (SPINLOCK* )hSpin;
-	kfree(spin);
-}
-
 void* Physical2LogicalAddr(unsigned long PhysAddr)
 {
 	void* logicalAddr = phys_to_virt(PhysAddr);
