From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio: console: Move file back to drivers/char/
Date: Tue,  1 Feb 2011 09:31:25 +0530
Message-ID: <bd7e7969221007e205ef0d2bf144d2f3109036da.1296532834.git.amit.shah__22493.2779711255$1296533023$gmane$org@redhat.com>
References: <20110131221454.GA14884@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110131221454.GA14884@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: virtualization@lists.linuxfoundation.org

Commit 728674a7e466628df2aeec6d11a2ae1ef968fb67 moved virtio_console.c
to drivers/tty/hvc/ under the perception of this being an hvc driver.
It was such once, but these days it has generic communication
capabilities as well, so move it to drivers/char/.

In the future, the hvc part from this file can be split off and moved
under drivers/tty/hvc/.

CC: Rusty Russell <rusty@rustcorp.com.au>
CC: Greg KH <greg@kroah.com>
CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/Makefile                      |    1 +
 drivers/{tty/hvc => char}/virtio_console.c |    2 +-
 drivers/tty/hvc/Makefile                   |    1 -
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/{tty/hvc => char}/virtio_console.c (99%)

diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 5bc765d..8238f89 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_SX)		+= sx.o generic_serial.o
 obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
+obj-$(CONFIG_VIRTIO_CONSOLE)	+= virtio_console.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MSPEC)		+= mspec.o
diff --git a/drivers/tty/hvc/virtio_console.c b/drivers/char/virtio_console.c
similarity index 99%
rename from drivers/tty/hvc/virtio_console.c
rename to drivers/char/virtio_console.c
index 896a2ce..5feadee 100644
--- a/drivers/tty/hvc/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -31,7 +31,7 @@
 #include <linux/virtio_console.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
-#include "hvc_console.h"
+#include "../tty/hvc/hvc_console.h"
 
 /*
  * This is a global struct for storing common data for all the devices
diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index e6bed5f..d79e7e9 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -10,4 +10,3 @@ obj-$(CONFIG_HVC_XEN)		+= hvc_xen.o
 obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
 obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
-obj-$(CONFIG_VIRTIO_CONSOLE)	+= virtio_console.o
-- 
1.7.3.5
