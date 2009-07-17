From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 28/54] Staging: hv: remove SIZE_T typedef
Date: Fri, 17 Jul 2009 11:09:18 -0700
Message-ID: <20090717180920.447725309@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=staging-hv-remove-size_t-typedef.patch
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
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Greg KH <greg@kroah.com>
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

The SIZE_T typedef is now removed from the Hyper-V driver code.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/Connection.c   |    2 +-
 drivers/staging/hv/Hv.c           |    2 +-
 drivers/staging/hv/Hv.h           |    2 +-
 drivers/staging/hv/VmbusPrivate.h |    2 +-
 drivers/staging/hv/include/osd.h  |    3 +--
 drivers/staging/hv/osd.c          |    2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/staging/hv/Connection.c
+++ b/drivers/staging/hv/Connection.c
@@ -386,7 +386,7 @@ Description:
 int
 VmbusPostMessage(
 	void *			buffer,
-	SIZE_T			bufferLen
+	size_t			bufferLen
 	)
 {
 	int ret=0;
--- a/drivers/staging/hv/Hv.c
+++ b/drivers/staging/hv/Hv.c
@@ -397,7 +397,7 @@ HvPostMessage(
 	HV_CONNECTION_ID connectionId,
 	HV_MESSAGE_TYPE  messageType,
 	void *            payload,
-	SIZE_T           payloadSize
+	size_t           payloadSize
 	)
 {
 	struct alignedInput {
--- a/drivers/staging/hv/Hv.h
+++ b/drivers/staging/hv/Hv.h
@@ -163,7 +163,7 @@ HvPostMessage(
 	HV_CONNECTION_ID connectionId,
 	HV_MESSAGE_TYPE  messageType,
 	void *            payload,
-	SIZE_T           payloadSize
+	size_t           payloadSize
 	);
 
 static HV_STATUS
--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -97,7 +97,6 @@ typedef struct _DLIST_ENTRY {
 //
 // Other types
 //
-typedef unsigned long		SIZE_T;
 //typedef unsigned char		GUID[16];
 typedef unsigned char		BOOL;
 typedef unsigned char		BOOLEAN;
@@ -188,7 +187,7 @@ extern HANDLE TimerCreate(PFN_TIMER_CALL
 extern void TimerClose(HANDLE hTimer);
 extern int TimerStop(HANDLE hTimer);
 extern void TimerStart(HANDLE hTimer, u32 expirationInUs);
-extern SIZE_T GetTickCount(void);
+extern size_t GetTickCount(void);
 
 extern HANDLE WaitEventCreate(void);
 extern void WaitEventClose(HANDLE hWait);
--- a/drivers/staging/hv/osd.c
+++ b/drivers/staging/hv/osd.c
@@ -312,7 +312,7 @@ void TimerClose(HANDLE hTimer)
 	kfree(t);
 }
 
-SIZE_T GetTickCount(void)
+size_t GetTickCount(void)
 {
 	return jiffies;
 }
--- a/drivers/staging/hv/VmbusPrivate.h
+++ b/drivers/staging/hv/VmbusPrivate.h
@@ -149,7 +149,7 @@ VmbusDisconnect(
 static int
 VmbusPostMessage(
 	void *			buffer,
-	SIZE_T			bufSize
+	size_t			bufSize
 	);
 
 static int
