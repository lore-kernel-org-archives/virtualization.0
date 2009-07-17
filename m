From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 36/54] Staging: hv: remove FIELD_OFFSET usage
Date: Fri, 17 Jul 2009 11:09:26 -0700
Message-ID: <20090717180921.758169794@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-remove-field_offset-usage.patch
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

This isn't needed, or even used, at all.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/hv/include/VmbusChannelInterface.h |    9 ---------
 drivers/staging/hv/include/osd.h                   |    2 --
 2 files changed, 11 deletions(-)

--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -37,8 +37,6 @@
 #define LOWORD(dw)		((unsigned short) (dw))
 #define HIWORD(dw)		((unsigned short) (((unsigned int) (dw) >> 16) & 0xFFFF))
 
-#define FIELD_OFFSET(t, f)    ((unsigned int)(unsigned long)&(((t *)0)->f))
-
 #ifdef FALSE
 #undef FALSE
 #endif
--- a/drivers/staging/hv/include/VmbusChannelInterface.h
+++ b/drivers/staging/hv/include/VmbusChannelInterface.h
@@ -98,15 +98,6 @@ typedef struct
 #pragma pack(pop)
 
 
-//
-// Verify the MAX_PIPE_USER_DEFINED_BYTES value.
-//
-//C_ASSERT(MAX_PIPE_USER_DEFINED_BYTES ==
-//         MAX_USER_DEFINED_BYTES -
-//         (FIELD_OFFSET(VMBUS_CHANNEL_OFFER, u.Pipe.UserDefined) -
-//          FIELD_OFFSET(VMBUS_CHANNEL_OFFER, u.Standard.UserDefined)));
-//
-
 typedef u32 GPADL_HANDLE;
 
 //
