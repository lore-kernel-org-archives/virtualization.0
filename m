From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 54/54] Staging: hv: osd: remove GetTickCount and GetTimestamp
	wrappers
Date: Fri, 17 Jul 2009 11:09:44 -0700
Message-ID: <20090717180924.650201749@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-osd-remove-gettickcount-and-gettimestamp-wrappers.patch
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

No one was even using them.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/hv/include/osd.h |    1 -
 drivers/staging/hv/osd.c         |   14 --------------
 2 files changed, 15 deletions(-)

--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -121,7 +121,6 @@ extern HANDLE TimerCreate(PFN_TIMER_CALL
 extern void TimerClose(HANDLE hTimer);
 extern int TimerStop(HANDLE hTimer);
 extern void TimerStart(HANDLE hTimer, u32 expirationInUs);
-extern size_t GetTickCount(void);
 
 extern HANDLE WaitEventCreate(void);
 extern void WaitEventClose(HANDLE hWait);
--- a/drivers/staging/hv/osd.c
+++ b/drivers/staging/hv/osd.c
@@ -232,20 +232,6 @@ void TimerClose(HANDLE hTimer)
 	kfree(t);
 }
 
-size_t GetTickCount(void)
-{
-	return jiffies;
-}
-
-signed long long GetTimestamp(void)
-{
-	struct timeval t;
-
-	do_gettimeofday(&t);
-
-	return  timeval_to_ns(&t);
-}
-
 HANDLE WaitEventCreate(void)
 {
 	WAITEVENT* wait = kmalloc(sizeof(WAITEVENT), GFP_KERNEL);
