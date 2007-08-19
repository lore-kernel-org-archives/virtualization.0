From: Joe Perches <joe@perches.com>
Subject: [PATCH 1/5] um/... convert #include "linux/..." to #include
	<linux/...>
Date: Sun, 19 Aug 2007 15:18:23 -0700
Message-ID: <1187561903.4200.138.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>, user-mode-linux-user@lists.sourceforge.net, Jason Lunz <lunz@falooley.org>, Jan Beulich <jbeulich@novell.com>, vtun@office.satix.net, Jens Axboe <jens.axboe@oracle.com>, Stephen Hemminger <shemminger@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, Davide Brini <davide.brini@unibo.it>, Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Jeff Dike <jdike@karaya.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, Chris Wright <chrisw@sous-sol.org>, Maxim Krasnyansky <maxk@qualcomm.com>Jeff
List-Id: virtualization@lists.linuxfoundation.org

(untested)

There are several files that 
#include "linux/file" not #include <linux/file>
#include "asm/file" not #include <asm/file>

Here's a little script that converts them:

egrep -i -r -l --include=*.[ch] \
"^[[:space:]]*\#[[:space:]]*include[[:space:]]*\"(linux|asm)/(.*)\"" * \
| xargs sed -i -e 's/^[[:space:]]*#[[:space:]]*include[[:space:]]*"\(linux\|asm\)\/\(.*\)"/#include <\1\/\2>/g'

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/arch/um/drivers/daemon_kern.c b/arch/um/drivers/daemon_kern.c
index adeece1..e8e3903 100644
--- a/arch/um/drivers/daemon_kern.c
+++ b/arch/um/drivers/daemon_kern.c
@@ -5,10 +5,10 @@
  * Licensed under the GPL.
  */
 
-#include "linux/kernel.h"
-#include "linux/init.h"
-#include "linux/netdevice.h"
-#include "linux/etherdevice.h"
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include "net_kern.h"
 #include "net_user.h"
 #include "daemon.h"
diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 10e08a8..5efbd0f 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -3,13 +3,13 @@
  * Licensed under the GPL
  */
 
-#include "linux/module.h"
-#include "linux/init.h"
-#include "linux/slab.h"
-#include "linux/fs.h"
-#include "linux/sound.h"
-#include "linux/soundcard.h"
-#include "asm/uaccess.h"
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/sound.h>
+#include <linux/soundcard.h>
+#include <asm/uaccess.h>
 #include "kern_util.h"
 #include "init.h"
 #include "os.h"
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 3e0b68e..43cdad8 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -3,13 +3,13 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/sched.h"
-#include "linux/slab.h"
-#include "linux/list.h"
-#include "linux/kd.h"
-#include "linux/interrupt.h"
-#include "asm/uaccess.h"
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/kd.h>
+#include <linux/interrupt.h>
+#include <asm/uaccess.h>
 #include "chan_kern.h"
 #include "irq_user.h"
 #include "line.h"
diff --git a/arch/um/drivers/mcast_kern.c b/arch/um/drivers/mcast_kern.c
index e6b8e0d..c354f43 100644
--- a/arch/um/drivers/mcast_kern.c
+++ b/arch/um/drivers/mcast_kern.c
@@ -10,12 +10,12 @@
  * Licensed under the GPL.
  */
 
-#include "linux/kernel.h"
-#include "linux/init.h"
-#include "linux/netdevice.h"
-#include "linux/etherdevice.h"
-#include "linux/in.h"
-#include "linux/inet.h"
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/in.h>
+#include <linux/inet.h>
 #include "net_kern.h"
 #include "net_user.h"
 #include "mcast.h"
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index d870905..fa924aa 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -4,27 +4,27 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/slab.h"
-#include "linux/init.h"
-#include "linux/notifier.h"
-#include "linux/reboot.h"
-#include "linux/utsname.h"
-#include "linux/ctype.h"
-#include "linux/interrupt.h"
-#include "linux/sysrq.h"
-#include "linux/workqueue.h"
-#include "linux/module.h"
-#include "linux/file.h"
-#include "linux/fs.h"
-#include "linux/namei.h"
-#include "linux/proc_fs.h"
-#include "linux/syscalls.h"
-#include "linux/list.h"
-#include "linux/mm.h"
-#include "linux/console.h"
-#include "asm/irq.h"
-#include "asm/uaccess.h"
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/utsname.h>
+#include <linux/ctype.h>
+#include <linux/interrupt.h>
+#include <linux/sysrq.h>
+#include <linux/workqueue.h>
+#include <linux/module.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/proc_fs.h>
+#include <linux/syscalls.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/console.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
 #include "kern_util.h"
 #include "kern.h"
 #include "mconsole.h"
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index d35d0c1..198fd82 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -5,22 +5,22 @@
  * Licensed under the GPL.
  */
 
-#include "linux/kernel.h"
-#include "linux/netdevice.h"
-#include "linux/rtnetlink.h"
-#include "linux/skbuff.h"
-#include "linux/socket.h"
-#include "linux/spinlock.h"
-#include "linux/module.h"
-#include "linux/init.h"
-#include "linux/etherdevice.h"
-#include "linux/list.h"
-#include "linux/inetdevice.h"
-#include "linux/ctype.h"
-#include "linux/bootmem.h"
-#include "linux/ethtool.h"
-#include "linux/platform_device.h"
-#include "asm/uaccess.h"
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/etherdevice.h>
+#include <linux/list.h>
+#include <linux/inetdevice.h>
+#include <linux/ctype.h>
+#include <linux/bootmem.h>
+#include <linux/ethtool.h>
+#include <linux/platform_device.h>
+#include <asm/uaccess.h>
 #include "kern_util.h"
 #include "net_kern.h"
 #include "net_user.h"
diff --git a/arch/um/drivers/pcap_kern.c b/arch/um/drivers/pcap_kern.c
index c329931..ad65eb2 100644
--- a/arch/um/drivers/pcap_kern.c
+++ b/arch/um/drivers/pcap_kern.c
@@ -3,9 +3,9 @@
  * Licensed under the GPL.
  */
 
-#include "linux/init.h"
-#include "linux/netdevice.h"
-#include "linux/etherdevice.h"
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include "net_kern.h"
 #include "net_user.h"
 #include "pcap_user.h"
diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index 1c8efd9..4cb6f59 100644
--- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -3,15 +3,15 @@
  * Licensed under the GPL
  */
 
-#include "linux/list.h"
-#include "linux/sched.h"
-#include "linux/slab.h"
-#include "linux/interrupt.h"
-#include "linux/spinlock.h"
-#include "linux/errno.h"
-#include "asm/atomic.h"
-#include "asm/semaphore.h"
-#include "asm/errno.h"
+#include <linux/list.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
+#include <asm/errno.h>
 #include "kern_util.h"
 #include "kern.h"
 #include "irq_user.h"
diff --git a/arch/um/drivers/slip_kern.c b/arch/um/drivers/slip_kern.c
index 125c44f..153e785 100644
--- a/arch/um/drivers/slip_kern.c
+++ b/arch/um/drivers/slip_kern.c
@@ -1,8 +1,8 @@
-#include "linux/kernel.h"
-#include "linux/stddef.h"
-#include "linux/init.h"
-#include "linux/netdevice.h"
-#include "linux/if_arp.h"
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/if_arp.h>
 #include "net_kern.h"
 #include "net_user.h"
 #include "kern.h"
diff --git a/arch/um/drivers/slirp_kern.c b/arch/um/drivers/slirp_kern.c
index 0a0324a..9a0f9f2 100644
--- a/arch/um/drivers/slirp_kern.c
+++ b/arch/um/drivers/slirp_kern.c
@@ -1,8 +1,8 @@
-#include "linux/kernel.h"
-#include "linux/stddef.h"
-#include "linux/init.h"
-#include "linux/netdevice.h"
-#include "linux/if_arp.h"
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/if_arp.h>
 #include "net_kern.h"
 #include "net_user.h"
 #include "kern.h"
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index 875d60d..4fb1216 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -3,15 +3,15 @@
  * Licensed under the GPL
  */
 
-#include "linux/fs.h"
-#include "linux/tty.h"
-#include "linux/tty_driver.h"
-#include "linux/major.h"
-#include "linux/mm.h"
-#include "linux/init.h"
-#include "linux/console.h"
-#include "asm/termbits.h"
-#include "asm/irq.h"
+#include <linux/fs.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/major.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <asm/termbits.h>
+#include <asm/irq.h>
 #include "line.h"
 #include "ssl.h"
 #include "chan_kern.h"
diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index 656036e..b007861 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -3,22 +3,22 @@
  * Licensed under the GPL
  */
 
-#include "linux/posix_types.h"
-#include "linux/tty.h"
-#include "linux/tty_flip.h"
-#include "linux/types.h"
-#include "linux/major.h"
-#include "linux/kdev_t.h"
-#include "linux/console.h"
-#include "linux/string.h"
-#include "linux/sched.h"
-#include "linux/list.h"
-#include "linux/init.h"
-#include "linux/interrupt.h"
-#include "linux/slab.h"
-#include "linux/hardirq.h"
-#include "asm/current.h"
-#include "asm/irq.h"
+#include <linux/posix_types.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/types.h>
+#include <linux/major.h>
+#include <linux/kdev_t.h>
+#include <linux/console.h>
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/hardirq.h>
+#include <asm/current.h>
+#include <asm/irq.h>
 #include "stdio_console.h"
 #include "line.h"
 #include "chan_kern.h"
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index aff661f..55a556c 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -20,26 +20,26 @@
 #define MAJOR_NR UBD_MAJOR
 #define UBD_SHIFT 4
 
-#include "linux/kernel.h"
-#include "linux/module.h"
-#include "linux/blkdev.h"
-#include "linux/hdreg.h"
-#include "linux/init.h"
-#include "linux/cdrom.h"
-#include "linux/proc_fs.h"
-#include "linux/ctype.h"
-#include "linux/capability.h"
-#include "linux/mm.h"
-#include "linux/vmalloc.h"
-#include "linux/blkpg.h"
-#include "linux/genhd.h"
-#include "linux/spinlock.h"
-#include "linux/platform_device.h"
-#include "asm/segment.h"
-#include "asm/uaccess.h"
-#include "asm/irq.h"
-#include "asm/types.h"
-#include "asm/tlbflush.h"
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/init.h>
+#include <linux/cdrom.h>
+#include <linux/proc_fs.h>
+#include <linux/ctype.h>
+#include <linux/capability.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/blkpg.h>
+#include <linux/genhd.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <asm/segment.h>
+#include <asm/uaccess.h>
+#include <asm/irq.h>
+#include <asm/types.h>
+#include <asm/tlbflush.h>
 #include "mem_user.h"
 #include "kern_util.h"
 #include "kern.h"
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index 41d254b..7e77fd5 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -15,7 +15,7 @@
 #include <sys/socket.h>
 #include <sys/mman.h>
 #include <sys/param.h>
-#include "asm/types.h"
+#include <asm/types.h>
 #include "kern_util.h"
 #include "user.h"
 #include "ubd_user.h"
diff --git a/arch/um/include/chan_kern.h b/arch/um/include/chan_kern.h
index 624b510..64e99b5 100644
--- a/arch/um/include/chan_kern.h
+++ b/arch/um/include/chan_kern.h
@@ -6,9 +6,9 @@
 #ifndef __CHAN_KERN_H__
 #define __CHAN_KERN_H__
 
-#include "linux/tty.h"
-#include "linux/list.h"
-#include "linux/console.h"
+#include <linux/tty.h>
+#include <linux/list.h>
+#include <linux/console.h>
 #include "chan_user.h"
 #include "line.h"
 
diff --git a/arch/um/include/irq_kern.h b/arch/um/include/irq_kern.h
index 4f77559..de23a86 100644
--- a/arch/um/include/irq_kern.h
+++ b/arch/um/include/irq_kern.h
@@ -6,8 +6,8 @@
 #ifndef __IRQ_KERN_H__
 #define __IRQ_KERN_H__
 
-#include "linux/interrupt.h"
-#include "asm/ptrace.h"
+#include <linux/interrupt.h>
+#include <asm/ptrace.h>
 
 extern int um_request_irq(unsigned int irq, int fd, int type,
 			  irq_handler_t handler,
diff --git a/arch/um/include/line.h b/arch/um/include/line.h
index 1223f2c..9d712b6 100644
--- a/arch/um/include/line.h
+++ b/arch/um/include/line.h
@@ -6,12 +6,12 @@
 #ifndef __LINE_H__
 #define __LINE_H__
 
-#include "linux/list.h"
-#include "linux/workqueue.h"
-#include "linux/tty.h"
-#include "linux/interrupt.h"
-#include "linux/spinlock.h"
-#include "linux/mutex.h"
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/tty.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include "chan_user.h"
 #include "mconsole_kern.h"
 
diff --git a/arch/um/include/mconsole_kern.h b/arch/um/include/mconsole_kern.h
index d2fe07e..7a0c6a1 100644
--- a/arch/um/include/mconsole_kern.h
+++ b/arch/um/include/mconsole_kern.h
@@ -6,7 +6,7 @@
 #ifndef __MCONSOLE_KERN_H__
 #define __MCONSOLE_KERN_H__
 
-#include "linux/list.h"
+#include <linux/list.h>
 #include "mconsole.h"
 
 struct mconsole_entry {
diff --git a/arch/um/include/mem.h b/arch/um/include/mem.h
index e8ff0d8..e4d4131 100644
--- a/arch/um/include/mem.h
+++ b/arch/um/include/mem.h
@@ -6,7 +6,7 @@
 #ifndef __MEM_H__
 #define __MEM_H__
 
-#include "linux/types.h"
+#include <linux/types.h>
 
 extern int phys_mapping(unsigned long phys, __u64 *offset_out);
 extern int physmem_subst_mapping(void *virt, int fd, __u64 offset, int w);
diff --git a/arch/um/include/mem_kern.h b/arch/um/include/mem_kern.h
index cb7e196..97f9341 100644
--- a/arch/um/include/mem_kern.h
+++ b/arch/um/include/mem_kern.h
@@ -6,8 +6,8 @@
 #ifndef __MEM_KERN_H__
 #define __MEM_KERN_H__
 
-#include "linux/list.h"
-#include "linux/types.h"
+#include <linux/list.h>
+#include <linux/types.h>
 
 struct remapper {
 	struct list_head list;
diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index 930b261..a12fc11 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -7,7 +7,7 @@
 #define __OS_H__
 
 #include "uml-config.h"
-#include "asm/types.h"
+#include <asm/types.h>
 #include "../os/include/file.h"
 #include "sysdep/ptrace.h"
 #include "kern_util.h"
diff --git a/arch/um/include/skas/mmu-skas.h b/arch/um/include/skas/mmu-skas.h
index b26986c..a891943 100644
--- a/arch/um/include/skas/mmu-skas.h
+++ b/arch/um/include/skas/mmu-skas.h
@@ -7,7 +7,7 @@
 #define __SKAS_MMU_H
 
 #include "mm_id.h"
-#include "asm/ldt.h"
+#include <asm/ldt.h>
 
 struct mmu_context_skas {
 	struct mm_id id;
diff --git a/arch/um/include/skas/mode_kern_skas.h b/arch/um/include/skas/mode_kern_skas.h
index 8ee6285..f79de1a 100644
--- a/arch/um/include/skas/mode_kern_skas.h
+++ b/arch/um/include/skas/mode_kern_skas.h
@@ -6,9 +6,9 @@
 #ifndef __SKAS_MODE_KERN_H__
 #define __SKAS_MODE_KERN_H__
 
-#include "linux/sched.h"
-#include "asm/page.h"
-#include "asm/ptrace.h"
+#include <linux/sched.h>
+#include <asm/page.h>
+#include <asm/ptrace.h>
 
 extern void flush_thread_skas(void);
 extern void switch_to_skas(void *prev, void *next);
diff --git a/arch/um/include/skas/uaccess-skas.h b/arch/um/include/skas/uaccess-skas.h
index 224a75f..3aad057 100644
--- a/arch/um/include/skas/uaccess-skas.h
+++ b/arch/um/include/skas/uaccess-skas.h
@@ -6,7 +6,7 @@
 #ifndef __SKAS_UACCESS_H
 #define __SKAS_UACCESS_H
 
-#include "asm/errno.h"
+#include <asm/errno.h>
 
 /* No SKAS-specific checking. */
 #define access_ok_skas(type, addr, size) 0
diff --git a/arch/um/include/sysdep-i386/checksum.h b/arch/um/include/sysdep-i386/checksum.h
index 0cb4645..6c36303 100644
--- a/arch/um/include/sysdep-i386/checksum.h
+++ b/arch/um/include/sysdep-i386/checksum.h
@@ -5,8 +5,8 @@
 #ifndef __UM_SYSDEP_CHECKSUM_H
 #define __UM_SYSDEP_CHECKSUM_H
 
-#include "linux/in6.h"
-#include "linux/string.h"
+#include <linux/in6.h>
+#include <linux/string.h>
 
 /*
  * computes the checksum of a memory block at buff, length len,
diff --git a/arch/um/include/sysdep-i386/syscalls.h b/arch/um/include/sysdep-i386/syscalls.h
index 57bd79e..da8d33a 100644
--- a/arch/um/include/sysdep-i386/syscalls.h
+++ b/arch/um/include/sysdep-i386/syscalls.h
@@ -3,7 +3,7 @@
  * Licensed under the GPL
  */
 
-#include "asm/unistd.h"
+#include <asm/unistd.h>
 #include "sysdep/ptrace.h"
 
 typedef long syscall_handler_t(struct pt_regs);
diff --git a/arch/um/include/sysdep-ppc/ptrace.h b/arch/um/include/sysdep-ppc/ptrace.h
index df2397d..7f1fe24 100644
--- a/arch/um/include/sysdep-ppc/ptrace.h
+++ b/arch/um/include/sysdep-ppc/ptrace.h
@@ -5,7 +5,7 @@
 #ifndef __SYS_PTRACE_PPC_H
 #define __SYS_PTRACE_PPC_H
 
-#include "linux/types.h"
+#include <linux/types.h>
 
 /* the following taken from <asm-ppc/ptrace.h> */
 
diff --git a/arch/um/include/sysdep-x86_64/checksum.h b/arch/um/include/sysdep-x86_64/checksum.h
index a5be903..1fc1316 100644
--- a/arch/um/include/sysdep-x86_64/checksum.h
+++ b/arch/um/include/sysdep-x86_64/checksum.h
@@ -5,9 +5,9 @@
 #ifndef __UM_SYSDEP_CHECKSUM_H
 #define __UM_SYSDEP_CHECKSUM_H
 
-#include "linux/string.h"
-#include "linux/in6.h"
-#include "asm/uaccess.h"
+#include <linux/string.h>
+#include <linux/in6.h>
+#include <asm/uaccess.h>
 
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
diff --git a/arch/um/include/tt/mode_kern_tt.h b/arch/um/include/tt/mode_kern_tt.h
index a4fc630..926764e 100644
--- a/arch/um/include/tt/mode_kern_tt.h
+++ b/arch/um/include/tt/mode_kern_tt.h
@@ -6,10 +6,10 @@
 #ifndef __TT_MODE_KERN_H__
 #define __TT_MODE_KERN_H__
 
-#include "linux/sched.h"
-#include "asm/page.h"
-#include "asm/ptrace.h"
-#include "asm/uaccess.h"
+#include <linux/sched.h>
+#include <asm/page.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
 
 extern void switch_to_tt(void *prev, void *next);
 extern void flush_thread_tt(void);
diff --git a/arch/um/include/tt/uaccess-tt.h b/arch/um/include/tt/uaccess-tt.h
index 13a64f6..32ff26f 100644
--- a/arch/um/include/tt/uaccess-tt.h
+++ b/arch/um/include/tt/uaccess-tt.h
@@ -6,12 +6,12 @@
 #ifndef __TT_UACCESS_H
 #define __TT_UACCESS_H
 
-#include "linux/string.h"
-#include "linux/sched.h"
-#include "asm/processor.h"
-#include "asm/errno.h"
-#include "asm/current.h"
-#include "asm/a.out.h"
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <asm/processor.h>
+#include <asm/errno.h>
+#include <asm/current.h>
+#include <asm/a.out.h>
 #include "uml_uaccess.h"
 
 #define ABOVE_KMEM (16 * 1024 * 1024)
diff --git a/arch/um/include/um_uaccess.h b/arch/um/include/um_uaccess.h
index 5126a99..daa6e73 100644
--- a/arch/um/include/um_uaccess.h
+++ b/arch/um/include/um_uaccess.h
@@ -16,7 +16,7 @@
 #include "uaccess-skas.h"
 #endif
 
-#include "asm/fixmap.h"
+#include <asm/fixmap.h>
 
 #define __under_task_size(addr, size) \
 	(((unsigned long) (addr) < TASK_SIZE) && \
diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index ce6828f..0512c34 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -3,14 +3,14 @@
  * Licensed under the GPL
  */
 
-#include "linux/slab.h"
-#include "linux/smp_lock.h"
-#include "linux/ptrace.h"
-#include "linux/fs.h"
-#include "asm/ptrace.h"
-#include "asm/pgtable.h"
-#include "asm/tlbflush.h"
-#include "asm/uaccess.h"
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/ptrace.h>
+#include <linux/fs.h>
+#include <asm/ptrace.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+#include <asm/uaccess.h>
 #include "kern_util.h"
 #include "as-layout.h"
 #include "mem_user.h"
diff --git a/arch/um/kernel/exitcode.c b/arch/um/kernel/exitcode.c
index c716b5a..bb910c1 100644
--- a/arch/um/kernel/exitcode.c
+++ b/arch/um/kernel/exitcode.c
@@ -3,11 +3,11 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/init.h"
-#include "linux/ctype.h"
-#include "linux/proc_fs.h"
-#include "asm/uaccess.h"
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/ctype.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
 
 /* If read and write race, the read will still atomically read a valid
  * value.
diff --git a/arch/um/kernel/gmon_syms.c b/arch/um/kernel/gmon_syms.c
index 13aa115..2f61f6a 100644
--- a/arch/um/kernel/gmon_syms.c
+++ b/arch/um/kernel/gmon_syms.c
@@ -3,7 +3,7 @@
  * Licensed under the GPL
  */
 
-#include "linux/module.h"
+#include <linux/module.h>
 
 extern void __bb_init_func(void *)  __attribute__((weak));
 EXPORT_SYMBOL(__bb_init_func);
diff --git a/arch/um/kernel/gprof_syms.c b/arch/um/kernel/gprof_syms.c
index 9244f01..3a3a5bf 100644
--- a/arch/um/kernel/gprof_syms.c
+++ b/arch/um/kernel/gprof_syms.c
@@ -3,7 +3,7 @@
  * Licensed under the GPL
  */
 
-#include "linux/module.h"
+#include <linux/module.h>
 
 extern void mcount(void);
 EXPORT_SYMBOL(mcount);
diff --git a/arch/um/kernel/init_task.c b/arch/um/kernel/init_task.c
index cba516e..c36e981 100644
--- a/arch/um/kernel/init_task.c
+++ b/arch/um/kernel/init_task.c
@@ -3,14 +3,14 @@
  * Licensed under the GPL
  */
 
-#include "linux/mm.h"
-#include "linux/fs.h"
-#include "linux/module.h"
-#include "linux/sched.h"
-#include "linux/init_task.h"
-#include "linux/mqueue.h"
-#include "asm/uaccess.h"
-#include "asm/pgtable.h"
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/init_task.h>
+#include <linux/mqueue.h>
+#include <asm/uaccess.h>
+#include <asm/pgtable.h>
 #include "mem_user.h"
 #include "os.h"
 
diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index 16dc43e..1b2e585 100644
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -3,10 +3,10 @@
  * Licensed under the GPL
  */
 
-#include "linux/init.h"
-#include "linux/bootmem.h"
-#include "linux/initrd.h"
-#include "asm/types.h"
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/initrd.h>
+#include <asm/types.h>
 #include "kern_util.h"
 #include "initrd.h"
 #include "init.h"
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 9870feb..7f5a729 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -5,26 +5,26 @@
  *	Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
  */
 
-#include "linux/kernel.h"
-#include "linux/module.h"
-#include "linux/smp.h"
-#include "linux/kernel_stat.h"
-#include "linux/interrupt.h"
-#include "linux/random.h"
-#include "linux/slab.h"
-#include "linux/file.h"
-#include "linux/proc_fs.h"
-#include "linux/init.h"
-#include "linux/seq_file.h"
-#include "linux/profile.h"
-#include "linux/hardirq.h"
-#include "asm/irq.h"
-#include "asm/hw_irq.h"
-#include "asm/atomic.h"
-#include "asm/signal.h"
-#include "asm/system.h"
-#include "asm/errno.h"
-#include "asm/uaccess.h"
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/smp.h>
+#include <linux/kernel_stat.h>
+#include <linux/interrupt.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <linux/profile.h>
+#include <linux/hardirq.h>
+#include <asm/irq.h>
+#include <asm/hw_irq.h>
+#include <asm/atomic.h>
+#include <asm/signal.h>
+#include <asm/system.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
 #include "kern_util.h"
 #include "irq_user.h"
 #include "irq_kern.h"
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index 7b3e53f..db9f403 100644
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -3,18 +3,18 @@
  * Licensed under the GPL
  */
 
-#include "linux/module.h"
-#include "linux/string.h"
-#include "linux/smp_lock.h"
-#include "linux/spinlock.h"
-#include "linux/highmem.h"
-#include "asm/current.h"
-#include "asm/processor.h"
-#include "asm/unistd.h"
-#include "asm/pgalloc.h"
-#include "asm/pgtable.h"
-#include "asm/page.h"
-#include "asm/tlbflush.h"
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/highmem.h>
+#include <asm/current.h>
+#include <asm/processor.h>
+#include <asm/unistd.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/tlbflush.h>
 #include "kern_util.h"
 #include "as-layout.h"
 #include "mem_user.h"
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index d2b11f2..0305bfc 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -3,24 +3,24 @@
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
-#include "linux/kernel.h"
-#include "linux/mm.h"
-#include "linux/bootmem.h"
-#include "linux/swap.h"
-#include "linux/highmem.h"
-#include "linux/gfp.h"
-#include "asm/page.h"
-#include "asm/fixmap.h"
-#include "asm/pgalloc.h"
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/swap.h>
+#include <linux/highmem.h>
+#include <linux/gfp.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/pgalloc.h>
 #include "kern_util.h"
 #include "as-layout.h"
 #include "kern.h"
 #include "mem_user.h"
 #include "uml_uaccess.h"
 #include "os.h"
-#include "linux/types.h"
-#include "linux/string.h"
+#include <linux/types.h>
+#include <linux/string.h>
 #include "init.h"
 #include "kern_constants.h"
 
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 5ee7e85..86ec814 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -3,15 +3,15 @@
  * Licensed under the GPL
  */
 
-#include "linux/mm.h"
-#include "linux/rbtree.h"
-#include "linux/slab.h"
-#include "linux/vmalloc.h"
-#include "linux/bootmem.h"
-#include "linux/module.h"
-#include "linux/pfn.h"
-#include "asm/types.h"
-#include "asm/pgtable.h"
+#include <linux/mm.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/bootmem.h>
+#include <linux/module.h>
+#include <linux/pfn.h>
+#include <asm/types.h>
+#include <asm/pgtable.h>
 #include "kern_util.h"
 #include "as-layout.h"
 #include "mode_kern.h"
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index bfa52f2..b6e0001 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -4,34 +4,34 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/sched.h"
-#include "linux/interrupt.h"
-#include "linux/string.h"
-#include "linux/mm.h"
-#include "linux/slab.h"
-#include "linux/utsname.h"
-#include "linux/fs.h"
-#include "linux/utime.h"
-#include "linux/smp_lock.h"
-#include "linux/module.h"
-#include "linux/init.h"
-#include "linux/capability.h"
-#include "linux/vmalloc.h"
-#include "linux/spinlock.h"
-#include "linux/proc_fs.h"
-#include "linux/ptrace.h"
-#include "linux/random.h"
-#include "linux/personality.h"
-#include "asm/unistd.h"
-#include "asm/mman.h"
-#include "asm/segment.h"
-#include "asm/stat.h"
-#include "asm/pgtable.h"
-#include "asm/processor.h"
-#include "asm/tlbflush.h"
-#include "asm/uaccess.h"
-#include "asm/user.h"
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/utsname.h>
+#include <linux/fs.h>
+#include <linux/utime.h>
+#include <linux/smp_lock.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/capability.h>
+#include <linux/vmalloc.h>
+#include <linux/spinlock.h>
+#include <linux/proc_fs.h>
+#include <linux/ptrace.h>
+#include <linux/random.h>
+#include <linux/personality.h>
+#include <asm/unistd.h>
+#include <asm/mman.h>
+#include <asm/segment.h>
+#include <asm/stat.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/tlbflush.h>
+#include <asm/uaccess.h>
+#include <asm/user.h>
 #include "kern_util.h"
 #include "as-layout.h"
 #include "kern.h"
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 6916c88..ad3e4e7 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -3,18 +3,18 @@
  * Licensed under the GPL
  */
 
-#include "linux/sched.h"
-#include "linux/mm.h"
-#include "linux/errno.h"
-#include "linux/smp_lock.h"
-#include "linux/security.h"
-#include "linux/ptrace.h"
-#include "linux/audit.h"
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/smp_lock.h>
+#include <linux/security.h>
+#include <linux/ptrace.h>
+#include <linux/audit.h>
 #ifdef CONFIG_PROC_MM
-#include "linux/proc_mm.h"
+#include <linux/proc_mm.h>
 #endif
-#include "asm/ptrace.h"
-#include "asm/uaccess.h"
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
 #include "kern_util.h"
 #include "skas_ptrace.h"
 #include "sysdep/ptrace.h"
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 7e4305a..b3b6ee0 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -3,9 +3,9 @@
  * Licensed under the GPL
  */
 
-#include "linux/module.h"
-#include "linux/sched.h"
-#include "asm/smp.h"
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <asm/smp.h>
 #include "kern_util.h"
 #include "kern.h"
 #include "os.h"
diff --git a/arch/um/kernel/sigio.c b/arch/um/kernel/sigio.c
index 89f9866..676ba70 100644
--- a/arch/um/kernel/sigio.c
+++ b/arch/um/kernel/sigio.c
@@ -3,11 +3,11 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/list.h"
-#include "linux/slab.h"
-#include "linux/signal.h"
-#include "linux/interrupt.h"
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/signal.h>
+#include <linux/interrupt.h>
 #include "init.h"
 #include "sigio.h"
 #include "irq_user.h"
diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index c4020c3..2b63f4e 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -3,21 +3,21 @@
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
-#include "linux/sys.h"
-#include "linux/sched.h"
-#include "linux/wait.h"
-#include "linux/kernel.h"
-#include "linux/smp_lock.h"
-#include "linux/module.h"
-#include "linux/slab.h"
-#include "linux/tty.h"
-#include "linux/binfmts.h"
-#include "linux/ptrace.h"
-#include "asm/signal.h"
-#include "asm/uaccess.h"
-#include "asm/unistd.h"
-#include "asm/ucontext.h"
+#include <linux/stddef.h>
+#include <linux/sys.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/kernel.h>
+#include <linux/smp_lock.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/binfmts.h>
+#include <linux/ptrace.h>
+#include <asm/signal.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
+#include <asm/ucontext.h>
 #include "kern_util.h"
 #include "signal_kern.h"
 #include "kern.h"
diff --git a/arch/um/kernel/skas/exec.c b/arch/um/kernel/skas/exec.c
index 580eb64..0122f70 100644
--- a/arch/um/kernel/skas/exec.c
+++ b/arch/um/kernel/skas/exec.c
@@ -3,13 +3,13 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "asm/current.h"
-#include "asm/page.h"
-#include "asm/signal.h"
-#include "asm/ptrace.h"
-#include "asm/uaccess.h"
-#include "asm/mmu_context.h"
+#include <linux/kernel.h>
+#include <asm/current.h>
+#include <asm/page.h>
+#include <asm/signal.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
 #include "tlb.h"
 #include "skas.h"
 #include "um_mmu.h"
diff --git a/arch/um/kernel/skas/mem.c b/arch/um/kernel/skas/mem.c
index 7c18dfc..9047fad 100644
--- a/arch/um/kernel/skas/mem.c
+++ b/arch/um/kernel/skas/mem.c
@@ -3,8 +3,8 @@
  * Licensed under the GPL
  */
 
-#include "linux/mm.h"
-#include "asm/pgtable.h"
+#include <linux/mm.h>
+#include <asm/pgtable.h>
 #include "mem_user.h"
 #include "skas.h"
 
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 2c6d090..6e93875 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -3,18 +3,18 @@
  * Licensed under the GPL
  */
 
-#include "linux/sched.h"
-#include "linux/list.h"
-#include "linux/spinlock.h"
-#include "linux/slab.h"
-#include "linux/errno.h"
-#include "linux/mm.h"
-#include "asm/current.h"
-#include "asm/segment.h"
-#include "asm/mmu.h"
-#include "asm/pgalloc.h"
-#include "asm/pgtable.h"
-#include "asm/ldt.h"
+#include <linux/sched.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <asm/current.h>
+#include <asm/segment.h>
+#include <asm/mmu.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/ldt.h>
 #include "os.h"
 #include "skas.h"
 
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 48051a9..b504995 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -3,15 +3,15 @@
  * Licensed under the GPL
  */
 
-#include "linux/sched.h"
-#include "linux/slab.h"
-#include "linux/ptrace.h"
-#include "linux/proc_fs.h"
-#include "linux/file.h"
-#include "linux/errno.h"
-#include "linux/init.h"
-#include "asm/uaccess.h"
-#include "asm/atomic.h"
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/ptrace.h>
+#include <linux/proc_fs.h>
+#include <linux/file.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <asm/atomic.h>
 #include "kern_util.h"
 #include "as-layout.h"
 #include "skas.h"
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 0ae4eea..303bac3 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -3,12 +3,12 @@
  * Licensed under the GPL
  */
 
-#include "linux/sys.h"
-#include "linux/ptrace.h"
-#include "asm/errno.h"
-#include "asm/unistd.h"
-#include "asm/ptrace.h"
-#include "asm/current.h"
+#include <linux/sys.h>
+#include <linux/ptrace.h>
+#include <asm/errno.h>
+#include <asm/unistd.h>
+#include <asm/ptrace.h>
+#include <asm/current.h>
 #include "sysdep/syscalls.h"
 #include "kern_util.h"
 #include "syscall.h"
diff --git a/arch/um/kernel/skas/tlb.c b/arch/um/kernel/skas/tlb.c
index c0f0693..72f79dc 100644
--- a/arch/um/kernel/skas/tlb.c
+++ b/arch/um/kernel/skas/tlb.c
@@ -4,12 +4,12 @@
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
-#include "linux/sched.h"
-#include "linux/mm.h"
-#include "asm/page.h"
-#include "asm/pgtable.h"
-#include "asm/mmu.h"
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/mmu.h>
 #include "mem_user.h"
 #include "mem.h"
 #include "skas.h"
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 8912cec..8684151 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -3,16 +3,16 @@
  * Licensed under the GPL
  */
 
-#include "linux/compiler.h"
-#include "linux/stddef.h"
-#include "linux/kernel.h"
-#include "linux/string.h"
-#include "linux/fs.h"
-#include "linux/hardirq.h"
-#include "linux/highmem.h"
-#include "asm/page.h"
-#include "asm/pgtable.h"
-#include "asm/uaccess.h"
+#include <linux/compiler.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+#include <linux/hardirq.h>
+#include <linux/highmem.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
 #include "kern_util.h"
 #include "os.h"
 
diff --git a/arch/um/kernel/smp.c b/arch/um/kernel/smp.c
index e6a7778..3100bb6 100644
--- a/arch/um/kernel/smp.c
+++ b/arch/um/kernel/smp.c
@@ -3,24 +3,24 @@
  * Licensed under the GPL
  */
 
-#include "linux/percpu.h"
-#include "asm/pgalloc.h"
-#include "asm/tlb.h"
+#include <linux/percpu.h>
+#include <asm/pgalloc.h>
+#include <asm/tlb.h>
 
 /* For some reason, mmu_gathers are referenced when CONFIG_SMP is off. */
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 #ifdef CONFIG_SMP
 
-#include "linux/sched.h"
-#include "linux/module.h"
-#include "linux/threads.h"
-#include "linux/interrupt.h"
-#include "linux/err.h"
-#include "linux/hardirq.h"
-#include "asm/smp.h"
-#include "asm/processor.h"
-#include "asm/spinlock.h"
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/threads.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/hardirq.h>
+#include <asm/smp.h>
+#include <asm/processor.h>
+#include <asm/spinlock.h>
 #include "kern_util.h"
 #include "kern.h"
 #include "irq_user.h"
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
index 7b3b673..846e6fe 100644
--- a/arch/um/kernel/syscall.c
+++ b/arch/um/kernel/syscall.c
@@ -3,21 +3,21 @@
  * Licensed under the GPL
  */
 
-#include "linux/sched.h"
-#include "linux/file.h"
-#include "linux/smp_lock.h"
-#include "linux/mm.h"
-#include "linux/fs.h"
-#include "linux/utsname.h"
-#include "linux/msg.h"
-#include "linux/shm.h"
-#include "linux/sys.h"
-#include "linux/syscalls.h"
-#include "linux/unistd.h"
-#include "linux/slab.h"
-#include "linux/utime.h"
-#include "asm/mman.h"
-#include "asm/uaccess.h"
+#include <linux/sched.h>
+#include <linux/file.h>
+#include <linux/smp_lock.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/utsname.h>
+#include <linux/msg.h>
+#include <linux/shm.h>
+#include <linux/sys.h>
+#include <linux/syscalls.h>
+#include <linux/unistd.h>
+#include <linux/slab.h>
+#include <linux/utime.h>
+#include <asm/mman.h>
+#include <asm/uaccess.h>
 #include "kern_util.h"
 #include "sysdep/syscalls.h"
 #include "mode_kern.h"
diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 9326357..f736d21 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -3,12 +3,12 @@
  * Licensed under the GPL
  */
 
-#include "linux/sched.h"
-#include "linux/kernel.h"
-#include "linux/module.h"
-#include "linux/kallsyms.h"
-#include "asm/page.h"
-#include "asm/processor.h"
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+#include <asm/page.h>
+#include <asm/processor.h>
 #include "sysrq.h"
 
 /* Catch non-i386 SUBARCH's. */
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 259c49d..5f895a2 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -3,20 +3,20 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/module.h"
-#include "linux/unistd.h"
-#include "linux/stddef.h"
-#include "linux/spinlock.h"
-#include "linux/time.h"
-#include "linux/sched.h"
-#include "linux/interrupt.h"
-#include "linux/init.h"
-#include "linux/delay.h"
-#include "linux/hrtimer.h"
-#include "asm/irq.h"
-#include "asm/param.h"
-#include "asm/current.h"
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/unistd.h>
+#include <linux/stddef.h>
+#include <linux/spinlock.h>
+#include <linux/time.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/hrtimer.h>
+#include <asm/irq.h>
+#include <asm/param.h>
+#include <asm/current.h>
 #include "kern_util.h"
 #include "mode.h"
 #include "os.h"
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 8a8d528..04a9778 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -3,11 +3,11 @@
  * Licensed under the GPL
  */
 
-#include "linux/mm.h"
-#include "asm/page.h"
-#include "asm/pgalloc.h"
-#include "asm/pgtable.h"
-#include "asm/tlbflush.h"
+#include <linux/mm.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
 #include "choose-mode.h"
 #include "mode_kern.h"
 #include "as-layout.h"
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 3850d53..d660479 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -3,20 +3,20 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "asm/errno.h"
-#include "linux/sched.h"
-#include "linux/mm.h"
-#include "linux/spinlock.h"
-#include "linux/init.h"
-#include "linux/ptrace.h"
-#include "asm/semaphore.h"
-#include "asm/pgtable.h"
-#include "asm/pgalloc.h"
-#include "asm/tlbflush.h"
-#include "asm/a.out.h"
-#include "asm/current.h"
-#include "asm/irq.h"
+#include <linux/kernel.h>
+#include <asm/errno.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <linux/ptrace.h>
+#include <asm/semaphore.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/a.out.h>
+#include <asm/current.h>
+#include <asm/irq.h>
 #include "sysdep/sigcontext.h"
 #include "kern_util.h"
 #include "as-layout.h"
diff --git a/arch/um/kernel/tt/exec_kern.c b/arch/um/kernel/tt/exec_kern.c
index 40126cb..0e5a0c1 100644
--- a/arch/um/kernel/tt/exec_kern.c
+++ b/arch/um/kernel/tt/exec_kern.c
@@ -3,13 +3,13 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/mm.h"
-#include "asm/signal.h"
-#include "asm/ptrace.h"
-#include "asm/uaccess.h"
-#include "asm/pgalloc.h"
-#include "asm/tlbflush.h"
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <asm/signal.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 #include "kern_util.h"
 #include "irq_user.h"
 #include "mem_user.h"
diff --git a/arch/um/kernel/tt/gdb_kern.c b/arch/um/kernel/tt/gdb_kern.c
index 03b06bc..03c3096 100644
--- a/arch/um/kernel/tt/gdb_kern.c
+++ b/arch/um/kernel/tt/gdb_kern.c
@@ -3,7 +3,7 @@
  * Licensed under the GPL
  */
 
-#include "linux/init.h"
+#include <linux/init.h>
 #include "mconsole_kern.h"
 
 #ifdef CONFIG_MCONSOLE
diff --git a/arch/um/kernel/tt/ksyms.c b/arch/um/kernel/tt/ksyms.c
index 84a9385..9f9e304 100644
--- a/arch/um/kernel/tt/ksyms.c
+++ b/arch/um/kernel/tt/ksyms.c
@@ -3,8 +3,8 @@
  * Licensed under the GPL
  */
 
-#include "linux/module.h"
-#include "asm/uaccess.h"
+#include <linux/module.h>
+#include <asm/uaccess.h>
 #include "mode.h"
 
 EXPORT_SYMBOL(__do_copy_from_user);
diff --git a/arch/um/kernel/tt/mem.c b/arch/um/kernel/tt/mem.c
index d0c3c49..6b46812 100644
--- a/arch/um/kernel/tt/mem.c
+++ b/arch/um/kernel/tt/mem.c
@@ -3,9 +3,9 @@
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
-#include "linux/mm.h"
-#include "asm/uaccess.h"
+#include <linux/stddef.h>
+#include <linux/mm.h>
+#include <asm/uaccess.h>
 #include "mem_user.h"
 #include "kern_util.h"
 #include "kern.h"
diff --git a/arch/um/kernel/tt/process_kern.c b/arch/um/kernel/tt/process_kern.c
index 74347ad..069cb66 100644
--- a/arch/um/kernel/tt/process_kern.c
+++ b/arch/um/kernel/tt/process_kern.c
@@ -3,15 +3,15 @@
  * Licensed under the GPL
  */
 
-#include "linux/sched.h"
-#include "linux/signal.h"
-#include "linux/kernel.h"
-#include "linux/interrupt.h"
-#include "linux/ptrace.h"
-#include "asm/system.h"
-#include "asm/pgalloc.h"
-#include "asm/ptrace.h"
-#include "asm/tlbflush.h"
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+#include <asm/system.h>
+#include <asm/pgalloc.h>
+#include <asm/ptrace.h>
+#include <asm/tlbflush.h>
 #include "irq_user.h"
 #include "kern_util.h"
 #include "os.h"
diff --git a/arch/um/kernel/tt/syscall_kern.c b/arch/um/kernel/tt/syscall_kern.c
index 293caa6..feb3df5 100644
--- a/arch/um/kernel/tt/syscall_kern.c
+++ b/arch/um/kernel/tt/syscall_kern.c
@@ -3,14 +3,14 @@
  * Licensed under the GPL
  */
 
-#include "linux/types.h"
-#include "linux/utime.h"
-#include "linux/sys.h"
-#include "linux/ptrace.h"
-#include "asm/unistd.h"
-#include "asm/ptrace.h"
-#include "asm/uaccess.h"
-#include "asm/stat.h"
+#include <linux/types.h>
+#include <linux/utime.h>
+#include <linux/sys.h>
+#include <linux/ptrace.h>
+#include <asm/unistd.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <asm/stat.h>
 #include "sysdep/syscalls.h"
 #include "sysdep/sigcontext.h"
 #include "kern_util.h"
diff --git a/arch/um/kernel/tt/tlb.c b/arch/um/kernel/tt/tlb.c
index 7caa24f..a44a033 100644
--- a/arch/um/kernel/tt/tlb.c
+++ b/arch/um/kernel/tt/tlb.c
@@ -4,14 +4,14 @@
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
-#include "linux/kernel.h"
-#include "linux/sched.h"
-#include "linux/mm.h"
-#include "asm/page.h"
-#include "asm/pgtable.h"
-#include "asm/uaccess.h"
-#include "asm/tlbflush.h"
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include <asm/tlbflush.h>
 #include "mem_user.h"
 #include "os.h"
 #include "tlb.h"
diff --git a/arch/um/kernel/tt/uaccess.c b/arch/um/kernel/tt/uaccess.c
index 1cb6072..5ba92b3 100644
--- a/arch/um/kernel/tt/uaccess.c
+++ b/arch/um/kernel/tt/uaccess.c
@@ -3,8 +3,8 @@
  * Licensed under the GPL
  */
 
-#include "linux/sched.h"
-#include "asm/uaccess.h"
+#include <linux/sched.h>
+#include <asm/uaccess.h>
 
 int copy_from_user_tt(void *to, const void __user *from, int n)
 {
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index ecc458f..196fde1 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -3,29 +3,29 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/sched.h"
-#include "linux/notifier.h"
-#include "linux/mm.h"
-#include "linux/types.h"
-#include "linux/tty.h"
-#include "linux/init.h"
-#include "linux/bootmem.h"
-#include "linux/spinlock.h"
-#include "linux/utsname.h"
-#include "linux/sysrq.h"
-#include "linux/seq_file.h"
-#include "linux/delay.h"
-#include "linux/module.h"
-#include "linux/utsname.h"
-#include "asm/page.h"
-#include "asm/pgtable.h"
-#include "asm/ptrace.h"
-#include "asm/elf.h"
-#include "asm/user.h"
-#include "asm/setup.h"
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/mm.h>
+#include <linux/types.h>
+#include <linux/tty.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/spinlock.h>
+#include <linux/utsname.h>
+#include <linux/sysrq.h>
+#include <linux/seq_file.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/utsname.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/ptrace.h>
+#include <asm/elf.h>
+#include <asm/user.h>
+#include <asm/setup.h>
 #include "ubd_user.h"
-#include "asm/current.h"
+#include <asm/current.h>
 #include "kern_util.h"
 #include "as-layout.h"
 #include "arch.h"
diff --git a/arch/um/kernel/umid.c b/arch/um/kernel/umid.c
index 039e16e..57a0811 100644
--- a/arch/um/kernel/umid.c
+++ b/arch/um/kernel/umid.c
@@ -3,11 +3,11 @@
  * Licensed under the GPL
  */
 
-#include "asm/errno.h"
+#include <asm/errno.h>
 #include "init.h"
 #include "os.h"
 #include "kern.h"
-#include "linux/kernel.h"
+#include <linux/kernel.h>
 
 /* Changed by set_umid_arg */
 static int umid_inited = 0;
diff --git a/arch/um/os-Linux/drivers/ethertap_kern.c b/arch/um/os-Linux/drivers/ethertap_kern.c
index 1268914..932068e 100644
--- a/arch/um/os-Linux/drivers/ethertap_kern.c
+++ b/arch/um/os-Linux/drivers/ethertap_kern.c
@@ -5,9 +5,9 @@
  * Licensed under the GPL.
  */
 
-#include "linux/init.h"
-#include "linux/netdevice.h"
-#include "linux/etherdevice.h"
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include "net_kern.h"
 #include "net_user.h"
 #include "etap.h"
diff --git a/arch/um/os-Linux/drivers/tuntap_kern.c b/arch/um/os-Linux/drivers/tuntap_kern.c
index f1714e7..f1a934c 100644
--- a/arch/um/os-Linux/drivers/tuntap_kern.c
+++ b/arch/um/os-Linux/drivers/tuntap_kern.c
@@ -3,12 +3,12 @@
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
-#include "linux/netdevice.h"
-#include "linux/etherdevice.h"
-#include "linux/skbuff.h"
-#include "linux/init.h"
-#include "asm/errno.h"
+#include <linux/stddef.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+#include <asm/errno.h>
 #include "net_kern.h"
 #include "net_user.h"
 #include "tuntap.h"
diff --git a/arch/um/os-Linux/tls.c b/arch/um/os-Linux/tls.c
index 16215b9..fd921b2 100644
--- a/arch/um/os-Linux/tls.c
+++ b/arch/um/os-Linux/tls.c
@@ -48,7 +48,7 @@ int os_get_thread_area(user_desc_t *info, int pid)
 #endif
 
 #ifdef UML_CONFIG_MODE_TT
-#include "linux/unistd.h"
+#include <linux/unistd.h>
 
 int do_set_thread_area_tt(user_desc_t *info)
 {
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 4c37b1b..2f2e713 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -1,5 +1,5 @@
-#include "linux/types.h"
-#include "linux/module.h"
+#include <linux/types.h>
+#include <linux/module.h>
 
 /* Some of this are builtin function (some are not but could in the future),
  * so I *must* declare good prototypes for them and then EXPORT them.
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 7cbcf48..8047a20 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -12,7 +12,7 @@
 #include <sys/utsname.h>
 #include <sys/param.h>
 #include <sys/time.h>
-#include "asm/types.h"
+#include <asm/types.h>
 #include <ctype.h>
 #include <signal.h>
 #include <wait.h>
diff --git a/arch/um/sys-i386/ksyms.c b/arch/um/sys-i386/ksyms.c
index 2a1eac1..3864a56 100644
--- a/arch/um/sys-i386/ksyms.c
+++ b/arch/um/sys-i386/ksyms.c
@@ -1,12 +1,12 @@
-#include "linux/module.h"
-#include "linux/in6.h"
-#include "linux/rwsem.h"
-#include "asm/byteorder.h"
-#include "asm/delay.h"
-#include "asm/semaphore.h"
-#include "asm/uaccess.h"
-#include "asm/checksum.h"
-#include "asm/errno.h"
+#include <linux/module.h>
+#include <linux/in6.h>
+#include <linux/rwsem.h>
+#include <asm/byteorder.h>
+#include <asm/delay.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+#include <asm/checksum.h>
+#include <asm/errno.h>
 
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
diff --git a/arch/um/sys-i386/ldt.c b/arch/um/sys-i386/ldt.c
index a939a7e..70f5a66 100644
--- a/arch/um/sys-i386/ldt.c
+++ b/arch/um/sys-i386/ldt.c
@@ -3,15 +3,15 @@
  * Licensed under the GPL
  */
 
-#include "linux/sched.h"
-#include "linux/slab.h"
-#include "linux/types.h"
-#include "linux/errno.h"
-#include "linux/spinlock.h"
-#include "asm/uaccess.h"
-#include "asm/smp.h"
-#include "asm/ldt.h"
-#include "asm/unistd.h"
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <asm/uaccess.h>
+#include <asm/smp.h>
+#include <asm/ldt.h>
+#include <asm/unistd.h>
 #include "choose-mode.h"
 #include "kern.h"
 #include "mode_kern.h"
@@ -87,7 +87,7 @@ out:
 
 #include "skas.h"
 #include "skas_ptrace.h"
-#include "asm/mmu_context.h"
+#include <asm/mmu_context.h>
 #include "proc_mm.h"
 
 long write_ldt_entry(struct mm_id * mm_idp, int func, struct user_desc * desc,
diff --git a/arch/um/sys-i386/ptrace.c b/arch/um/sys-i386/ptrace.c
index 28bf011..6d14072 100644
--- a/arch/um/sys-i386/ptrace.c
+++ b/arch/um/sys-i386/ptrace.c
@@ -4,12 +4,12 @@
  */
 
 #include <linux/compiler.h>
-#include "linux/sched.h"
-#include "linux/mm.h"
-#include "asm/elf.h"
-#include "asm/ptrace.h"
-#include "asm/uaccess.h"
-#include "asm/unistd.h"
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/elf.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
 #include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/sc.h"
diff --git a/arch/um/sys-i386/signal.c b/arch/um/sys-i386/signal.c
index 1cbf95f..c28629e 100644
--- a/arch/um/sys-i386/signal.c
+++ b/arch/um/sys-i386/signal.c
@@ -3,12 +3,12 @@
  * Licensed under the GPL
  */
 
-#include "linux/signal.h"
-#include "linux/ptrace.h"
-#include "asm/current.h"
-#include "asm/ucontext.h"
-#include "asm/uaccess.h"
-#include "asm/unistd.h"
+#include <linux/signal.h>
+#include <linux/ptrace.h>
+#include <asm/current.h>
+#include <asm/ucontext.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
 #include "frame_kern.h"
 #include "sigcontext.h"
 #include "registers.h"
diff --git a/arch/um/sys-i386/syscalls.c b/arch/um/sys-i386/syscalls.c
index 710d5fb..83356a6 100644
--- a/arch/um/sys-i386/syscalls.c
+++ b/arch/um/sys-i386/syscalls.c
@@ -3,12 +3,12 @@
  * Licensed under the GPL
  */
 
-#include "linux/sched.h"
-#include "linux/shm.h"
-#include "asm/ipc.h"
-#include "asm/mman.h"
-#include "asm/uaccess.h"
-#include "asm/unistd.h"
+#include <linux/sched.h>
+#include <linux/shm.h>
+#include <asm/ipc.h>
+#include <asm/mman.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 /*
  * Perform the select(nd, in, out, ex, tv) and mmap() system
diff --git a/arch/um/sys-i386/sysrq.c b/arch/um/sys-i386/sysrq.c
index 171b3e9..b9c83e7 100644
--- a/arch/um/sys-i386/sysrq.c
+++ b/arch/um/sys-i386/sysrq.c
@@ -3,11 +3,11 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/smp.h"
-#include "linux/sched.h"
-#include "linux/kallsyms.h"
-#include "asm/ptrace.h"
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/kallsyms.h>
+#include <asm/ptrace.h>
 #include "sysrq.h"
 
 /* This is declared by <linux/sched.h> */
diff --git a/arch/um/sys-i386/tls.c b/arch/um/sys-i386/tls.c
index fea8e5e..615db17 100644
--- a/arch/um/sys-i386/tls.c
+++ b/arch/um/sys-i386/tls.c
@@ -3,15 +3,15 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/sched.h"
-#include "linux/slab.h"
-#include "linux/types.h"
-#include "asm/uaccess.h"
-#include "asm/ptrace.h"
-#include "asm/segment.h"
-#include "asm/smp.h"
-#include "asm/desc.h"
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <asm/uaccess.h>
+#include <asm/ptrace.h>
+#include <asm/segment.h>
+#include <asm/smp.h>
+#include <asm/desc.h>
 #include "choose-mode.h"
 #include "kern.h"
 #include "kern_util.h"
diff --git a/arch/um/sys-ppc/miscthings.c b/arch/um/sys-ppc/miscthings.c
index 373061c..83ea638 100644
--- a/arch/um/sys-ppc/miscthings.c
+++ b/arch/um/sys-ppc/miscthings.c
@@ -1,6 +1,6 @@
-#include "linux/threads.h"
-#include "linux/stddef.h"  // for NULL
-#include "linux/elf.h"  // for AT_NULL
+#include <linux/threads.h>
+#include <linux/stddef.h>  // for NULL
+#include <linux/elf.h>  // for AT_NULL
 
 /* The following function nicked from arch/ppc/kernel/process.c and
  * adapted slightly */
diff --git a/arch/um/sys-ppc/ptrace.c b/arch/um/sys-ppc/ptrace.c
index 8e71b47..a0765aa 100644
--- a/arch/um/sys-ppc/ptrace.c
+++ b/arch/um/sys-ppc/ptrace.c
@@ -1,5 +1,5 @@
-#include "linux/sched.h"
-#include "asm/ptrace.h"
+#include <linux/sched.h>
+#include <asm/ptrace.h>
 
 int putreg(struct task_struct *child, unsigned long regno, 
 		  unsigned long value)
diff --git a/arch/um/sys-ppc/sigcontext.c b/arch/um/sys-ppc/sigcontext.c
index 4bdc15c..7d46cd3 100644
--- a/arch/um/sys-ppc/sigcontext.c
+++ b/arch/um/sys-ppc/sigcontext.c
@@ -1,5 +1,5 @@
-#include "asm/ptrace.h"
-#include "asm/sigcontext.h"
+#include <asm/ptrace.h>
+#include <asm/sigcontext.h>
 #include "sysdep/ptrace.h"
 
 /*
diff --git a/arch/um/sys-ppc/sysrq.c b/arch/um/sys-ppc/sysrq.c
index 2f816f1..6dd5486 100644
--- a/arch/um/sys-ppc/sysrq.c
+++ b/arch/um/sys-ppc/sysrq.c
@@ -3,9 +3,9 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/smp.h"
-#include "asm/ptrace.h"
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <asm/ptrace.h>
 #include "sysrq.h"
 
 void show_regs(struct pt_regs_subarch *regs)
diff --git a/arch/um/sys-x86_64/ksyms.c b/arch/um/sys-x86_64/ksyms.c
index 12c5936..903a025 100644
--- a/arch/um/sys-x86_64/ksyms.c
+++ b/arch/um/sys-x86_64/ksyms.c
@@ -1,11 +1,11 @@
-#include "linux/module.h"
-#include "linux/in6.h"
-#include "linux/rwsem.h"
-#include "asm/byteorder.h"
-#include "asm/semaphore.h"
-#include "asm/uaccess.h"
-#include "asm/checksum.h"
-#include "asm/errno.h"
+#include <linux/module.h>
+#include <linux/in6.h>
+#include <linux/rwsem.h>
+#include <asm/byteorder.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+#include <asm/checksum.h>
+#include <asm/errno.h>
 
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
diff --git a/arch/um/sys-x86_64/mem.c b/arch/um/sys-x86_64/mem.c
index 3f59a0a..19a7945 100644
--- a/arch/um/sys-x86_64/mem.c
+++ b/arch/um/sys-x86_64/mem.c
@@ -4,9 +4,9 @@
  * Licensed under the GPL
  */
 
-#include "linux/mm.h"
-#include "asm/page.h"
-#include "asm/mman.h"
+#include <linux/mm.h>
+#include <asm/page.h>
+#include <asm/mman.h>
 
 unsigned long vm_stack_flags = __VM_STACK_FLAGS;
 unsigned long vm_stack_flags32 = __VM_STACK_FLAGS;
diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
index fe8ec04..c4c0c99 100644
--- a/arch/um/sys-x86_64/signal.c
+++ b/arch/um/sys-x86_64/signal.c
@@ -3,15 +3,15 @@
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
-#include "linux/errno.h"
-#include "linux/personality.h"
-#include "linux/ptrace.h"
-#include "asm/current.h"
-#include "asm/uaccess.h"
-#include "asm/sigcontext.h"
-#include "asm/ptrace.h"
-#include "asm/arch/ucontext.h"
+#include <linux/stddef.h>
+#include <linux/errno.h>
+#include <linux/personality.h>
+#include <linux/ptrace.h>
+#include <asm/current.h>
+#include <asm/uaccess.h>
+#include <asm/sigcontext.h>
+#include <asm/ptrace.h>
+#include <asm/arch/ucontext.h>
 #include "choose-mode.h"
 #include "sysdep/ptrace.h"
 #include "frame_kern.h"
diff --git a/arch/um/sys-x86_64/syscalls.c b/arch/um/sys-x86_64/syscalls.c
index b3f6350..ebe08dd 100644
--- a/arch/um/sys-x86_64/syscalls.c
+++ b/arch/um/sys-x86_64/syscalls.c
@@ -4,16 +4,16 @@
  * Licensed under the GPL
  */
 
-#include "linux/linkage.h"
-#include "linux/slab.h"
-#include "linux/shm.h"
-#include "linux/utsname.h"
-#include "linux/personality.h"
-#include "asm/uaccess.h"
+#include <linux/linkage.h>
+#include <linux/slab.h>
+#include <linux/shm.h>
+#include <linux/utsname.h>
+#include <linux/personality.h>
+#include <asm/uaccess.h>
 #define __FRAME_OFFSETS
-#include "asm/ptrace.h"
-#include "asm/unistd.h"
-#include "asm/prctl.h" /* XXX This should get the constants from libc */
+#include <asm/ptrace.h>
+#include <asm/unistd.h>
+#include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include "choose-mode.h"
 #include "kern.h"
 #include "os.h"
diff --git a/arch/um/sys-x86_64/sysrq.c b/arch/um/sys-x86_64/sysrq.c
index ce3e07f..84a7dbd 100644
--- a/arch/um/sys-x86_64/sysrq.c
+++ b/arch/um/sys-x86_64/sysrq.c
@@ -4,11 +4,11 @@
  * Licensed under the GPL
  */
 
-#include "linux/kernel.h"
-#include "linux/utsname.h"
-#include "linux/module.h"
-#include "asm/current.h"
-#include "asm/ptrace.h"
+#include <linux/kernel.h>
+#include <linux/utsname.h>
+#include <linux/module.h>
+#include <asm/current.h>
+#include <asm/ptrace.h>
 #include "sysrq.h"
 
 void __show_regs(struct pt_regs * regs)
diff --git a/arch/um/sys-x86_64/tls.c b/arch/um/sys-x86_64/tls.c
index febbc94..dcd1fec 100644
--- a/arch/um/sys-x86_64/tls.c
+++ b/arch/um/sys-x86_64/tls.c
@@ -1,4 +1,4 @@
-#include "linux/sched.h"
+#include <linux/sched.h>
 
 void clear_flushed_tls(struct task_struct *task)
 {
diff --git a/include/asm-um/a.out.h b/include/asm-um/a.out.h
index 78bc9ee..4fba5f4 100644
--- a/include/asm-um/a.out.h
+++ b/include/asm-um/a.out.h
@@ -1,7 +1,7 @@
 #ifndef __UM_A_OUT_H
 #define __UM_A_OUT_H
 
-#include "asm/arch/a.out.h"
+#include <asm/arch/a.out.h>
 #include "choose-mode.h"
 
 #undef STACK_TOP
diff --git a/include/asm-um/alternative.h b/include/asm-um/alternative.h
index b643439..7e6c956 100644
--- a/include/asm-um/alternative.h
+++ b/include/asm-um/alternative.h
@@ -1,6 +1,6 @@
 #ifndef __UM_ALTERNATIVE_H
 #define __UM_ALTERNATIVE_H
 
-#include "asm/arch/alternative.h"
+#include <asm/arch/alternative.h>
 
 #endif
diff --git a/include/asm-um/atomic.h b/include/asm-um/atomic.h
index b683f10..cb49f10 100644
--- a/include/asm-um/atomic.h
+++ b/include/asm-um/atomic.h
@@ -4,8 +4,8 @@
 /* The i386 atomic.h calls printk, but doesn't include kernel.h, so we
  * include it here.
  */
-#include "linux/kernel.h"
+#include <linux/kernel.h>
 
-#include "asm/arch/atomic.h"
+#include <asm/arch/atomic.h>
 
 #endif
diff --git a/include/asm-um/bitops.h b/include/asm-um/bitops.h
index 46d7819..243835d 100644
--- a/include/asm-um/bitops.h
+++ b/include/asm-um/bitops.h
@@ -1,6 +1,6 @@
 #ifndef __UM_BITOPS_H
 #define __UM_BITOPS_H
 
-#include "asm/arch/bitops.h"
+#include <asm/arch/bitops.h>
 
 #endif
diff --git a/include/asm-um/boot.h b/include/asm-um/boot.h
index 09548c3..8a8975c 100644
--- a/include/asm-um/boot.h
+++ b/include/asm-um/boot.h
@@ -1,6 +1,6 @@
 #ifndef __UM_BOOT_H
 #define __UM_BOOT_H
 
-#include "asm/arch/boot.h"
+#include <asm/arch/boot.h>
 
 #endif
diff --git a/include/asm-um/byteorder.h b/include/asm-um/byteorder.h
index eee0a83..407d6e5 100644
--- a/include/asm-um/byteorder.h
+++ b/include/asm-um/byteorder.h
@@ -1,6 +1,6 @@
 #ifndef __UM_BYTEORDER_H
 #define __UM_BYTEORDER_H
 
-#include "asm/arch/byteorder.h"
+#include <asm/arch/byteorder.h>
 
 #endif
diff --git a/include/asm-um/cacheflush.h b/include/asm-um/cacheflush.h
index 12e9d4b..6699043 100644
--- a/include/asm-um/cacheflush.h
+++ b/include/asm-um/cacheflush.h
@@ -1,6 +1,6 @@
 #ifndef __UM_CACHEFLUSH_H
 #define __UM_CACHEFLUSH_H
 
-#include "asm/arch/cacheflush.h"
+#include <asm/arch/cacheflush.h>
 
 #endif
diff --git a/include/asm-um/calling.h b/include/asm-um/calling.h
index 0b2384c..4d31fd3 100644
--- a/include/asm-um/calling.h
+++ b/include/asm-um/calling.h
@@ -4,6 +4,6 @@
 #ifndef __UM_CALLING_H /* XXX x86_64 */
 #define __UM_CALLING_H
 
-#include "asm/arch/calling.h"
+#include <asm/arch/calling.h>
 
 #endif
diff --git a/include/asm-um/cmpxchg.h b/include/asm-um/cmpxchg.h
index 529376a..b3f01d1 100644
--- a/include/asm-um/cmpxchg.h
+++ b/include/asm-um/cmpxchg.h
@@ -1,6 +1,6 @@
 #ifndef __UM_CMPXCHG_H
 #define __UM_CMPXCHG_H
 
-#include "asm/arch/cmpxchg.h"
+#include <asm/arch/cmpxchg.h>
 
 #endif
diff --git a/include/asm-um/cobalt.h b/include/asm-um/cobalt.h
index f813a68..ab95291 100644
--- a/include/asm-um/cobalt.h
+++ b/include/asm-um/cobalt.h
@@ -1,6 +1,6 @@
 #ifndef __UM_COBALT_H
 #define __UM_COBALT_H
 
-#include "asm/arch/cobalt.h"
+#include <asm/arch/cobalt.h>
 
 #endif
diff --git a/include/asm-um/cpufeature.h b/include/asm-um/cpufeature.h
index fb7bd42..598d55d 100644
--- a/include/asm-um/cpufeature.h
+++ b/include/asm-um/cpufeature.h
@@ -1,6 +1,6 @@
 #ifndef __UM_CPUFEATURE_H
 #define __UM_CPUFEATURE_H
 
-#include "asm/arch/cpufeature.h"
+#include <asm/arch/cpufeature.h>
 
 #endif
diff --git a/include/asm-um/current.h b/include/asm-um/current.h
index 8fd72f6..c69837d 100644
--- a/include/asm-um/current.h
+++ b/include/asm-um/current.h
@@ -8,8 +8,8 @@
 
 #ifndef __ASSEMBLY__
 
-#include "asm/page.h"
-#include "linux/thread_info.h"
+#include <asm/page.h>
+#include <linux/thread_info.h>
 
 #define current (current_thread_info()->task)
 
diff --git a/include/asm-um/div64.h b/include/asm-um/div64.h
index 7b73b2c..8ba6709 100644
--- a/include/asm-um/div64.h
+++ b/include/asm-um/div64.h
@@ -1,7 +1,7 @@
 #ifndef _UM_DIV64_H
 #define _UM_DIV64_H
 
-#include "asm/arch/div64.h"
+#include <asm/arch/div64.h>
 
 extern uint64_t div64_64(uint64_t dividend, uint64_t divisor);
 #endif
diff --git a/include/asm-um/dma.h b/include/asm-um/dma.h
index 9f6139a..f88c586 100644
--- a/include/asm-um/dma.h
+++ b/include/asm-um/dma.h
@@ -1,7 +1,7 @@
 #ifndef __UM_DMA_H
 #define __UM_DMA_H
 
-#include "asm/io.h"
+#include <asm/io.h>
 
 extern unsigned long uml_physmem;
 
diff --git a/include/asm-um/dwarf2.h b/include/asm-um/dwarf2.h
index d1a02e7..9c97d8e 100644
--- a/include/asm-um/dwarf2.h
+++ b/include/asm-um/dwarf2.h
@@ -6,6 +6,6 @@
 #ifndef __UM_DWARF2_H
 #define __UM_DWARF2_H
 
-#include "asm/arch/dwarf2.h"
+#include <asm/arch/dwarf2.h>
 
 #endif
diff --git a/include/asm-um/errno.h b/include/asm-um/errno.h
index b7a9e37..9a96481 100644
--- a/include/asm-um/errno.h
+++ b/include/asm-um/errno.h
@@ -1,6 +1,6 @@
 #ifndef __UM_ERRNO_H
 #define __UM_ERRNO_H
 
-#include "asm/arch/errno.h"
+#include <asm/arch/errno.h>
 
 #endif
diff --git a/include/asm-um/fcntl.h b/include/asm-um/fcntl.h
index 812a654..c170eb3 100644
--- a/include/asm-um/fcntl.h
+++ b/include/asm-um/fcntl.h
@@ -1,6 +1,6 @@
 #ifndef __UM_FCNTL_H
 #define __UM_FCNTL_H
 
-#include "asm/arch/fcntl.h"
+#include <asm/arch/fcntl.h>
 
 #endif
diff --git a/include/asm-um/floppy.h b/include/asm-um/floppy.h
index 453e741..49a2919 100644
--- a/include/asm-um/floppy.h
+++ b/include/asm-um/floppy.h
@@ -1,6 +1,6 @@
 #ifndef __UM_FLOPPY_H
 #define __UM_FLOPPY_H
 
-#include "asm/arch/floppy.h"
+#include <asm/arch/floppy.h>
 
 #endif
diff --git a/include/asm-um/highmem.h b/include/asm-um/highmem.h
index 36974cb..89129db 100644
--- a/include/asm-um/highmem.h
+++ b/include/asm-um/highmem.h
@@ -1,9 +1,9 @@
 #ifndef __UM_HIGHMEM_H
 #define __UM_HIGHMEM_H
 
-#include "asm/page.h"
-#include "asm/fixmap.h"
-#include "asm/arch/highmem.h"
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/arch/highmem.h>
 
 #undef PKMAP_BASE
 
diff --git a/include/asm-um/host_ldt-i386.h b/include/asm-um/host_ldt-i386.h
index b27cb0a..9c2f4e6 100644
--- a/include/asm-um/host_ldt-i386.h
+++ b/include/asm-um/host_ldt-i386.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_HOST_LDT_I386_H
 #define __ASM_HOST_LDT_I386_H
 
-#include "asm/arch/ldt.h"
+#include <asm/arch/ldt.h>
 
 /*
  * macros stolen from include/asm-i386/desc.h
diff --git a/include/asm-um/host_ldt-x86_64.h b/include/asm-um/host_ldt-x86_64.h
index 74a63f7..e13dfc2 100644
--- a/include/asm-um/host_ldt-x86_64.h
+++ b/include/asm-um/host_ldt-x86_64.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_HOST_LDT_X86_64_H
 #define __ASM_HOST_LDT_X86_64_H
 
-#include "asm/arch/ldt.h"
+#include <asm/arch/ldt.h>
 
 /*
  * macros stolen from include/asm-x86_64/desc.h
diff --git a/include/asm-um/hw_irq.h b/include/asm-um/hw_irq.h
index 1cf84cf..efdffa4 100644
--- a/include/asm-um/hw_irq.h
+++ b/include/asm-um/hw_irq.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_UM_HW_IRQ_H
 #define _ASM_UM_HW_IRQ_H
 
-#include "asm/irq.h"
-#include "asm/archparam.h"
+#include <asm/irq.h>
+#include <asm/archparam.h>
 
 #endif
diff --git a/include/asm-um/ide.h b/include/asm-um/ide.h
index 3d1cceb..ac4f3cc 100644
--- a/include/asm-um/ide.h
+++ b/include/asm-um/ide.h
@@ -1,6 +1,6 @@
 #ifndef __UM_IDE_H
 #define __UM_IDE_H
 
-#include "asm/arch/ide.h"
+#include <asm/arch/ide.h>
 
 #endif
diff --git a/include/asm-um/io.h b/include/asm-um/io.h
index 44e8b8c..5d98080 100644
--- a/include/asm-um/io.h
+++ b/include/asm-um/io.h
@@ -1,7 +1,7 @@
 #ifndef __UM_IO_H
 #define __UM_IO_H
 
-#include "asm/page.h"
+#include <asm/page.h>
 
 #define IO_SPACE_LIMIT 0xdeadbeef /* Sure hope nothing uses this */
 
diff --git a/include/asm-um/ioctl.h b/include/asm-um/ioctl.h
index cc22157..6773833 100644
--- a/include/asm-um/ioctl.h
+++ b/include/asm-um/ioctl.h
@@ -1,6 +1,6 @@
 #ifndef __UM_IOCTL_H
 #define __UM_IOCTL_H
 
-#include "asm/arch/ioctl.h"
+#include <asm/arch/ioctl.h>
 
 #endif
diff --git a/include/asm-um/ioctls.h b/include/asm-um/ioctls.h
index 9a1a017..2990191 100644
--- a/include/asm-um/ioctls.h
+++ b/include/asm-um/ioctls.h
@@ -1,6 +1,6 @@
 #ifndef __UM_IOCTLS_H
 #define __UM_IOCTLS_H
 
-#include "asm/arch/ioctls.h"
+#include <asm/arch/ioctls.h>
 
 #endif
diff --git a/include/asm-um/ipcbuf.h b/include/asm-um/ipcbuf.h
index bb2ad31..46626bf 100644
--- a/include/asm-um/ipcbuf.h
+++ b/include/asm-um/ipcbuf.h
@@ -1,6 +1,6 @@
 #ifndef __UM_IPCBUF_H
 #define __UM_IPCBUF_H
 
-#include "asm/arch/ipcbuf.h"
+#include <asm/arch/ipcbuf.h>
 
 #endif
diff --git a/include/asm-um/keyboard.h b/include/asm-um/keyboard.h
index ee2e230..bfaa071 100644
--- a/include/asm-um/keyboard.h
+++ b/include/asm-um/keyboard.h
@@ -1,6 +1,6 @@
 #ifndef __UM_KEYBOARD_H
 #define __UM_KEYBOARD_H
 
-#include "asm/arch/keyboard.h"
+#include <asm/arch/keyboard.h>
 
 #endif
diff --git a/include/asm-um/ldt.h b/include/asm-um/ldt.h
index 96f82a4..812d66f 100644
--- a/include/asm-um/ldt.h
+++ b/include/asm-um/ldt.h
@@ -8,8 +8,8 @@
 #ifndef __ASM_LDT_H
 #define __ASM_LDT_H
 
-#include "asm/semaphore.h"
-#include "asm/host_ldt.h"
+#include <asm/semaphore.h>
+#include <asm/host_ldt.h>
 
 struct mmu_context_skas;
 extern void ldt_host_info(void);
diff --git a/include/asm-um/linkage.h b/include/asm-um/linkage.h
index 78b8624..38f0a54 100644
--- a/include/asm-um/linkage.h
+++ b/include/asm-um/linkage.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_UM_LINKAGE_H
 #define __ASM_UM_LINKAGE_H
 
-#include "asm/arch/linkage.h"
+#include <asm/arch/linkage.h>
 

 /* <linux/linkage.h> will pick sane defaults */
diff --git a/include/asm-um/local.h b/include/asm-um/local.h
index 9a280c5..ba1c70e 100644
--- a/include/asm-um/local.h
+++ b/include/asm-um/local.h
@@ -1,6 +1,6 @@
 #ifndef __UM_LOCAL_H
 #define __UM_LOCAL_H
 
-#include "asm/arch/local.h"
+#include <asm/arch/local.h>
 
 #endif
diff --git a/include/asm-um/locks.h b/include/asm-um/locks.h
index f80030a..f8329c0 100644
--- a/include/asm-um/locks.h
+++ b/include/asm-um/locks.h
@@ -1,6 +1,6 @@
 #ifndef __UM_LOCKS_H
 #define __UM_LOCKS_H
 
-#include "asm/arch/locks.h"
+#include <asm/arch/locks.h>
 
 #endif
diff --git a/include/asm-um/mca_dma.h b/include/asm-um/mca_dma.h
index e492e4e..04f622d 100644
--- a/include/asm-um/mca_dma.h
+++ b/include/asm-um/mca_dma.h
@@ -1,6 +1,6 @@
 #ifndef mca___UM_DMA_H
 #define mca___UM_DMA_H
 
-#include "asm/arch/mca_dma.h"
+#include <asm/arch/mca_dma.h>
 
 #endif
diff --git a/include/asm-um/mman.h b/include/asm-um/mman.h
index b09ed52..9973241 100644
--- a/include/asm-um/mman.h
+++ b/include/asm-um/mman.h
@@ -1,6 +1,6 @@
 #ifndef __UM_MMAN_H
 #define __UM_MMAN_H
 
-#include "asm/arch/mman.h"
+#include <asm/arch/mman.h>
 
 #endif
diff --git a/include/asm-um/mmu_context.h b/include/asm-um/mmu_context.h
index 9aa4b44..c546162 100644
--- a/include/asm-um/mmu_context.h
+++ b/include/asm-um/mmu_context.h
@@ -8,7 +8,7 @@
 
 #include <asm-generic/mm_hooks.h>
 
-#include "linux/sched.h"
+#include <linux/sched.h>
 #include "choose-mode.h"
 #include "um_mmu.h"
 
diff --git a/include/asm-um/module-generic.h b/include/asm-um/module-generic.h
index 5a265f5..9f5bcdd 100644
--- a/include/asm-um/module-generic.h
+++ b/include/asm-um/module-generic.h
@@ -1,6 +1,6 @@
 #ifndef __UM_MODULE_GENERIC_H
 #define __UM_MODULE_GENERIC_H
 
-#include "asm/arch/module.h"
+#include <asm/arch/module.h>
 
 #endif
diff --git a/include/asm-um/msgbuf.h b/include/asm-um/msgbuf.h
index 8ce8c30..e764a9e 100644
--- a/include/asm-um/msgbuf.h
+++ b/include/asm-um/msgbuf.h
@@ -1,6 +1,6 @@
 #ifndef __UM_MSGBUF_H
 #define __UM_MSGBUF_H
 
-#include "asm/arch/msgbuf.h"
+#include <asm/arch/msgbuf.h>
 
 #endif
diff --git a/include/asm-um/mtrr.h b/include/asm-um/mtrr.h
index 5e9cd12..4b1abde 100644
--- a/include/asm-um/mtrr.h
+++ b/include/asm-um/mtrr.h
@@ -1,6 +1,6 @@
 #ifndef __UM_MTRR_H
 #define __UM_MTRR_H
 
-#include "asm/arch/mtrr.h"
+#include <asm/arch/mtrr.h>
 
 #endif
diff --git a/include/asm-um/namei.h b/include/asm-um/namei.h
index 002984d..77dd098 100644
--- a/include/asm-um/namei.h
+++ b/include/asm-um/namei.h
@@ -1,6 +1,6 @@
 #ifndef __UM_NAMEI_H
 #define __UM_NAMEI_H
 
-#include "asm/arch/namei.h"
+#include <asm/arch/namei.h>
 
 #endif
diff --git a/include/asm-um/paravirt.h b/include/asm-um/paravirt.h
index 9d6aaad..31638d5 100644
--- a/include/asm-um/paravirt.h
+++ b/include/asm-um/paravirt.h
@@ -1,6 +1,6 @@
 #ifndef __UM_PARAVIRT_H
 #define __UM_PARAVIRT_H
 
-#include "asm/arch/paravirt.h"
+#include <asm/arch/paravirt.h>
 
 #endif
diff --git a/include/asm-um/percpu.h b/include/asm-um/percpu.h
index 5723e2a..49e45bb 100644
--- a/include/asm-um/percpu.h
+++ b/include/asm-um/percpu.h
@@ -1,6 +1,6 @@
 #ifndef __UM_PERCPU_H
 #define __UM_PERCPU_H
 
-#include "asm/arch/percpu.h"
+#include <asm/arch/percpu.h>
 
 #endif
diff --git a/include/asm-um/pgalloc.h b/include/asm-um/pgalloc.h
index 34ab268..2af0d2a 100644
--- a/include/asm-um/pgalloc.h
+++ b/include/asm-um/pgalloc.h
@@ -8,8 +8,8 @@
 #ifndef __UM_PGALLOC_H
 #define __UM_PGALLOC_H
 
-#include "linux/mm.h"
-#include "asm/fixmap.h"
+#include <linux/mm.h>
+#include <asm/fixmap.h>
 
 #define pmd_populate_kernel(mm, pmd, pte) \
 	set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) __pa(pte)))
diff --git a/include/asm-um/pgtable.h b/include/asm-um/pgtable.h
index 830fc6e..40d17df 100644
--- a/include/asm-um/pgtable.h
+++ b/include/asm-um/pgtable.h
@@ -8,11 +8,11 @@
 #ifndef __UM_PGTABLE_H
 #define __UM_PGTABLE_H
 
-#include "linux/sched.h"
-#include "linux/linkage.h"
-#include "asm/processor.h"
-#include "asm/page.h"
-#include "asm/fixmap.h"
+#include <linux/sched.h>
+#include <linux/linkage.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
 
 #define _PAGE_PRESENT	0x001
 #define _PAGE_NEWPAGE	0x002
@@ -27,9 +27,9 @@
 				   pte_present gives true */
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
-#include "asm/pgtable-3level.h"
+#include <asm/pgtable-3level.h>
 #else
-#include "asm/pgtable-2level.h"
+#include <asm/pgtable-2level.h>
 #endif
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
diff --git a/include/asm-um/poll.h b/include/asm-um/poll.h
index 1eb4e1b..73f36b2 100644
--- a/include/asm-um/poll.h
+++ b/include/asm-um/poll.h
@@ -1,6 +1,6 @@
 #ifndef __UM_POLL_H
 #define __UM_POLL_H
 
-#include "asm/arch/poll.h"
+#include <asm/arch/poll.h>
 
 #endif
diff --git a/include/asm-um/posix_types.h b/include/asm-um/posix_types.h
index 32fb419..cfe74ea 100644
--- a/include/asm-um/posix_types.h
+++ b/include/asm-um/posix_types.h
@@ -1,6 +1,6 @@
 #ifndef __UM_POSIX_TYPES_H
 #define __UM_POSIX_TYPES_H
 
-#include "asm/arch/posix_types.h"
+#include <asm/arch/posix_types.h>
 
 #endif
diff --git a/include/asm-um/prctl.h b/include/asm-um/prctl.h
index 64b6d09..a7d0be5 100644
--- a/include/asm-um/prctl.h
+++ b/include/asm-um/prctl.h
@@ -1,6 +1,6 @@
 #ifndef __UM_PRCTL_H
 #define __UM_PRCTL_H
 
-#include "asm/arch/prctl.h"
+#include <asm/arch/prctl.h>
 
 #endif
diff --git a/include/asm-um/processor-generic.h b/include/asm-um/processor-generic.h
index d99bbdd..40992c3 100644
--- a/include/asm-um/processor-generic.h
+++ b/include/asm-um/processor-generic.h
@@ -10,7 +10,7 @@ struct pt_regs;
 
 struct task_struct;
 
-#include "asm/ptrace.h"
+#include <asm/ptrace.h>
 #include "choose-mode.h"
 #include "registers.h"
 #include "sysdep/archsetjmp.h"
diff --git a/include/asm-um/processor-i386.h b/include/asm-um/processor-i386.h
index 595f1c3..4da5fc4 100644
--- a/include/asm-um/processor-i386.h
+++ b/include/asm-um/processor-i386.h
@@ -6,9 +6,9 @@
 #ifndef __UM_PROCESSOR_I386_H
 #define __UM_PROCESSOR_I386_H
 
-#include "linux/string.h"
-#include "asm/host_ldt.h"
-#include "asm/segment.h"
+#include <linux/string.h>
+#include <asm/host_ldt.h>
+#include <asm/segment.h>
 
 extern int host_has_xmm;
 extern int host_has_cmov;
@@ -49,7 +49,7 @@ static inline void arch_copy_thread(struct arch_thread *from,
         memcpy(&to->tls_array, &from->tls_array, sizeof(from->tls_array));
 }
 
-#include "asm/arch/user.h"
+#include <asm/arch/user.h>
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
 static inline void rep_nop(void)
@@ -74,6 +74,6 @@ static inline void rep_nop(void)
 #define KSTK_ESP(tsk) KSTK_REG(tsk, UESP)
 #define KSTK_EBP(tsk) KSTK_REG(tsk, EBP)
 
-#include "asm/processor-generic.h"
+#include <asm/processor-generic.h>
 
 #endif
diff --git a/include/asm-um/processor-ppc.h b/include/asm-um/processor-ppc.h
index 9593231..429e46d 100644
--- a/include/asm-um/processor-ppc.h
+++ b/include/asm-um/processor-ppc.h
@@ -8,7 +8,7 @@
 
 #else
 
-#include "asm/processor-generic.h"
+#include <asm/processor-generic.h>
 
 #endif
 
diff --git a/include/asm-um/processor-x86_64.h b/include/asm-um/processor-x86_64.h
index 31c2d4d..aaefef2 100644
--- a/include/asm-um/processor-x86_64.h
+++ b/include/asm-um/processor-x86_64.h
@@ -39,7 +39,7 @@ static inline void arch_copy_thread(struct arch_thread *from,
 {
 }
 
-#include "asm/arch/user.h"
+#include <asm/arch/user.h>
 
 #define current_text_addr() \
 	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
@@ -50,6 +50,6 @@ static inline void arch_copy_thread(struct arch_thread *from,
 #define KSTK_EIP(tsk) KSTK_REG(tsk, RIP)
 #define KSTK_ESP(tsk) KSTK_REG(tsk, RSP)
 
-#include "asm/processor-generic.h"
+#include <asm/processor-generic.h>
 
 #endif
diff --git a/include/asm-um/ptrace-generic.h b/include/asm-um/ptrace-generic.h
index 99c87c5..e7c4f1c 100644
--- a/include/asm-um/ptrace-generic.h
+++ b/include/asm-um/ptrace-generic.h
@@ -8,7 +8,7 @@
 
 #ifndef __ASSEMBLY__
 
-#include "asm/arch/ptrace-abi.h"
+#include <asm/arch/ptrace-abi.h>
 #include "sysdep/ptrace.h"
 
 struct pt_regs {
diff --git a/include/asm-um/ptrace-i386.h b/include/asm-um/ptrace-i386.h
index 6e2528b..e2516bb 100644
--- a/include/asm-um/ptrace-i386.h
+++ b/include/asm-um/ptrace-i386.h
@@ -8,10 +8,10 @@
 
 #define HOST_AUDIT_ARCH AUDIT_ARCH_I386
 
-#include "linux/compiler.h"
+#include <linux/compiler.h>
 #include "sysdep/ptrace.h"
-#include "asm/ptrace-generic.h"
-#include "asm/host_ldt.h"
+#include <asm/ptrace-generic.h>
+#include <asm/host_ldt.h>
 #include "choose-mode.h"
 
 #define PT_REGS_EAX(r) UPT_EAX(&(r)->regs)
diff --git a/include/asm-um/ptrace-x86_64.h b/include/asm-um/ptrace-x86_64.h
index bf61d17..3a53181 100644
--- a/include/asm-um/ptrace-x86_64.h
+++ b/include/asm-um/ptrace-x86_64.h
@@ -7,12 +7,12 @@
 #ifndef __UM_PTRACE_X86_64_H
 #define __UM_PTRACE_X86_64_H
 
-#include "linux/compiler.h"
-#include "asm/errno.h"
-#include "asm/host_ldt.h"
+#include <linux/compiler.h>
+#include <asm/errno.h>
+#include <asm/host_ldt.h>
 
 #define __FRAME_OFFSETS /* Needed to get the R* macros */
-#include "asm/ptrace-generic.h"
+#include <asm/ptrace-generic.h>
 
 #define HOST_AUDIT_ARCH AUDIT_ARCH_X86_64
 
diff --git a/include/asm-um/resource.h b/include/asm-um/resource.h
index c9b0740..deaed42 100644
--- a/include/asm-um/resource.h
+++ b/include/asm-um/resource.h
@@ -1,6 +1,6 @@
 #ifndef __UM_RESOURCE_H
 #define __UM_RESOURCE_H
 
-#include "asm/arch/resource.h"
+#include <asm/arch/resource.h>
 
 #endif
diff --git a/include/asm-um/rwlock.h b/include/asm-um/rwlock.h
index ff383aa..7d5226f 100644
--- a/include/asm-um/rwlock.h
+++ b/include/asm-um/rwlock.h
@@ -1,6 +1,6 @@
 #ifndef __UM_RWLOCK_H
 #define __UM_RWLOCK_H
 
-#include "asm/arch/rwlock.h"
+#include <asm/arch/rwlock.h>
 
 #endif
diff --git a/include/asm-um/rwsem.h b/include/asm-um/rwsem.h
index b5fc449..b25d8ab 100644
--- a/include/asm-um/rwsem.h
+++ b/include/asm-um/rwsem.h
@@ -1,6 +1,6 @@
 #ifndef __UM_RWSEM_H__
 #define __UM_RWSEM_H__
 
-#include "asm/arch/rwsem.h"
+#include <asm/arch/rwsem.h>
 
 #endif
diff --git a/include/asm-um/scatterlist.h b/include/asm-um/scatterlist.h
index e92016a..59b7096 100644
--- a/include/asm-um/scatterlist.h
+++ b/include/asm-um/scatterlist.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SCATTERLIST_H
 #define __UM_SCATTERLIST_H
 
-#include "asm/arch/scatterlist.h"
+#include <asm/arch/scatterlist.h>
 
 #endif
diff --git a/include/asm-um/semaphore.h b/include/asm-um/semaphore.h
index ff13c34..61c6e8b 100644
--- a/include/asm-um/semaphore.h
+++ b/include/asm-um/semaphore.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SEMAPHORE_H
 #define __UM_SEMAPHORE_H
 
-#include "asm/arch/semaphore.h"
+#include <asm/arch/semaphore.h>
 
 #endif
diff --git a/include/asm-um/sembuf.h b/include/asm-um/sembuf.h
index 1ae82c1..e6a7232 100644
--- a/include/asm-um/sembuf.h
+++ b/include/asm-um/sembuf.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SEMBUF_H
 #define __UM_SEMBUF_H
 
-#include "asm/arch/sembuf.h"
+#include <asm/arch/sembuf.h>
 
 #endif
diff --git a/include/asm-um/serial.h b/include/asm-um/serial.h
index 61ad07c..7c44b62 100644
--- a/include/asm-um/serial.h
+++ b/include/asm-um/serial.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SERIAL_H
 #define __UM_SERIAL_H
 
-#include "asm/arch/serial.h"
+#include <asm/arch/serial.h>
 
 #endif
diff --git a/include/asm-um/shmbuf.h b/include/asm-um/shmbuf.h
index 9684d4a..4e9006f 100644
--- a/include/asm-um/shmbuf.h
+++ b/include/asm-um/shmbuf.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SHMBUF_H
 #define __UM_SHMBUF_H
 
-#include "asm/arch/shmbuf.h"
+#include <asm/arch/shmbuf.h>
 
 #endif
diff --git a/include/asm-um/shmparam.h b/include/asm-um/shmparam.h
index 124c001..f88890e 100644
--- a/include/asm-um/shmparam.h
+++ b/include/asm-um/shmparam.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SHMPARAM_H
 #define __UM_SHMPARAM_H
 
-#include "asm/arch/shmparam.h"
+#include <asm/arch/shmparam.h>
 
 #endif
diff --git a/include/asm-um/sigcontext-generic.h b/include/asm-um/sigcontext-generic.h
index 1645870..cb0003b 100644
--- a/include/asm-um/sigcontext-generic.h
+++ b/include/asm-um/sigcontext-generic.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SIGCONTEXT_GENERIC_H
 #define __UM_SIGCONTEXT_GENERIC_H
 
-#include "asm/arch/sigcontext.h"
+#include <asm/arch/sigcontext.h>
 
 #endif
diff --git a/include/asm-um/sigcontext-i386.h b/include/asm-um/sigcontext-i386.h
index b88333f..58c0290 100644
--- a/include/asm-um/sigcontext-i386.h
+++ b/include/asm-um/sigcontext-i386.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SIGCONTEXT_I386_H
 #define __UM_SIGCONTEXT_I386_H
 
-#include "asm/sigcontext-generic.h"
+#include <asm/sigcontext-generic.h>
 
 #endif
diff --git a/include/asm-um/sigcontext-ppc.h b/include/asm-um/sigcontext-ppc.h
index 2467f20..5857c06 100644
--- a/include/asm-um/sigcontext-ppc.h
+++ b/include/asm-um/sigcontext-ppc.h
@@ -3,7 +3,7 @@
 
 #define pt_regs sys_pt_regs
 
-#include "asm/sigcontext-generic.h"
+#include <asm/sigcontext-generic.h>
 
 #undef pt_regs
 
diff --git a/include/asm-um/sigcontext-x86_64.h b/include/asm-um/sigcontext-x86_64.h
index b600e0b..ad79f88 100644
--- a/include/asm-um/sigcontext-x86_64.h
+++ b/include/asm-um/sigcontext-x86_64.h
@@ -6,7 +6,7 @@
 #ifndef __UM_SIGCONTEXT_X86_64_H
 #define __UM_SIGCONTEXT_X86_64_H
 
-#include "asm/sigcontext-generic.h"
+#include <asm/sigcontext-generic.h>
 
 #endif
 
diff --git a/include/asm-um/siginfo.h b/include/asm-um/siginfo.h
index bec6124..e00e4fa 100644
--- a/include/asm-um/siginfo.h
+++ b/include/asm-um/siginfo.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SIGINFO_H
 #define __UM_SIGINFO_H
 
-#include "asm/arch/siginfo.h"
+#include <asm/arch/siginfo.h>
 
 #endif
diff --git a/include/asm-um/signal.h b/include/asm-um/signal.h
index 52ed92c..eaf160c 100644
--- a/include/asm-um/signal.h
+++ b/include/asm-um/signal.h
@@ -9,7 +9,7 @@
 /* Need to kill the do_signal() declaration in the i386 signal.h */
 
 #define do_signal do_signal_renamed
-#include "asm/arch/signal.h"
+#include <asm/arch/signal.h>
 #undef do_signal
 #undef ptrace_signal_deliver
 
diff --git a/include/asm-um/smp.h b/include/asm-um/smp.h
index 84f8cf2..d97fcd4 100644
--- a/include/asm-um/smp.h
+++ b/include/asm-um/smp.h
@@ -3,9 +3,9 @@
 
 #ifdef CONFIG_SMP
 
-#include "linux/bitops.h"
-#include "asm/current.h"
-#include "linux/cpumask.h"
+#include <linux/bitops.h>
+#include <asm/current.h>
+#include <linux/cpumask.h>
 
 #define raw_smp_processor_id() (current_thread->cpu)
 
diff --git a/include/asm-um/socket.h b/include/asm-um/socket.h
index 67886e4..370eabf 100644
--- a/include/asm-um/socket.h
+++ b/include/asm-um/socket.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SOCKET_H
 #define __UM_SOCKET_H
 
-#include "asm/arch/socket.h"
+#include <asm/arch/socket.h>
 
 #endif
diff --git a/include/asm-um/sockios.h b/include/asm-um/sockios.h
index 93ee1c5..7bb0299 100644
--- a/include/asm-um/sockios.h
+++ b/include/asm-um/sockios.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SOCKIOS_H
 #define __UM_SOCKIOS_H
 
-#include "asm/arch/sockios.h"
+#include <asm/arch/sockios.h>
 
 #endif
diff --git a/include/asm-um/spinlock.h b/include/asm-um/spinlock.h
index f18c828..79d2809 100644
--- a/include/asm-um/spinlock.h
+++ b/include/asm-um/spinlock.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SPINLOCK_H
 #define __UM_SPINLOCK_H
 
-#include "asm/arch/spinlock.h"
+#include <asm/arch/spinlock.h>
 
 #endif
diff --git a/include/asm-um/spinlock_types.h b/include/asm-um/spinlock_types.h
index e5a9429..5ba214c 100644
--- a/include/asm-um/spinlock_types.h
+++ b/include/asm-um/spinlock_types.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SPINLOCK_TYPES_H
 #define __UM_SPINLOCK_TYPES_H
 
-#include "asm/arch/spinlock_types.h"
+#include <asm/arch/spinlock_types.h>
 
 #endif
diff --git a/include/asm-um/stat.h b/include/asm-um/stat.h
index 83ed85a..d26ab71 100644
--- a/include/asm-um/stat.h
+++ b/include/asm-um/stat.h
@@ -1,6 +1,6 @@
 #ifndef __UM_STAT_H
 #define __UM_STAT_H
 
-#include "asm/arch/stat.h"
+#include <asm/arch/stat.h>
 
 #endif
diff --git a/include/asm-um/statfs.h b/include/asm-um/statfs.h
index ba6fb53..4170189 100644
--- a/include/asm-um/statfs.h
+++ b/include/asm-um/statfs.h
@@ -1,6 +1,6 @@
 #ifndef _UM_STATFS_H
 #define _UM_STATFS_H
 
-#include "asm/arch/statfs.h"
+#include <asm/arch/statfs.h>
 
 #endif
diff --git a/include/asm-um/string.h b/include/asm-um/string.h
index 9a0571f..28728fc 100644
--- a/include/asm-um/string.h
+++ b/include/asm-um/string.h
@@ -1,7 +1,7 @@
 #ifndef __UM_STRING_H
 #define __UM_STRING_H
 
-#include "asm/arch/string.h"
-#include "asm/archparam.h"
+#include <asm/arch/string.h>
+#include <asm/archparam.h>
 
 #endif
diff --git a/include/asm-um/system-generic.h b/include/asm-um/system-generic.h
index 5bcfa35..3e6df22 100644
--- a/include/asm-um/system-generic.h
+++ b/include/asm-um/system-generic.h
@@ -1,7 +1,7 @@
 #ifndef __UM_SYSTEM_GENERIC_H
 #define __UM_SYSTEM_GENERIC_H
 
-#include "asm/arch/system.h"
+#include <asm/arch/system.h>
 
 #undef switch_to
 #undef local_irq_save
diff --git a/include/asm-um/system-i386.h b/include/asm-um/system-i386.h
index c436263..dc4f820 100644
--- a/include/asm-um/system-i386.h
+++ b/include/asm-um/system-i386.h
@@ -1,6 +1,6 @@
 #ifndef __UM_SYSTEM_I386_H
 #define __UM_SYSTEM_I386_H
 
-#include "asm/system-generic.h"
+#include <asm/system-generic.h>
     
 #endif
diff --git a/include/asm-um/system-ppc.h b/include/asm-um/system-ppc.h
index 17cde66..1c4e87d 100644
--- a/include/asm-um/system-ppc.h
+++ b/include/asm-um/system-ppc.h
@@ -3,10 +3,10 @@
 
 #define _switch_to _ppc_switch_to
 
-#include "asm/arch/system.h"
+#include <asm/arch/system.h>
 
 #undef _switch_to
  
-#include "asm/system-generic.h"
+#include <asm/system-generic.h>
 
 #endif
diff --git a/include/asm-um/system-x86_64.h b/include/asm-um/system-x86_64.h
index e1b61b5..99b2ceb 100644
--- a/include/asm-um/system-x86_64.h
+++ b/include/asm-um/system-x86_64.h
@@ -7,7 +7,7 @@
 #ifndef __UM_SYSTEM_X86_64_H
 #define __UM_SYSTEM_X86_64_H
 
-#include "asm/system-generic.h"
+#include <asm/system-generic.h>
 
 #endif
 
diff --git a/include/asm-um/termbits.h b/include/asm-um/termbits.h
index 5739c60..0b17ef2 100644
--- a/include/asm-um/termbits.h
+++ b/include/asm-um/termbits.h
@@ -1,6 +1,6 @@
 #ifndef __UM_TERMBITS_H
 #define __UM_TERMBITS_H
 
-#include "asm/arch/termbits.h"
+#include <asm/arch/termbits.h>
 
 #endif
diff --git a/include/asm-um/termios.h b/include/asm-um/termios.h
index d9f97b3..6d8dd01 100644
--- a/include/asm-um/termios.h
+++ b/include/asm-um/termios.h
@@ -1,6 +1,6 @@
 #ifndef __UM_TERMIOS_H
 #define __UM_TERMIOS_H
 
-#include "asm/arch/termios.h"
+#include <asm/arch/termios.h>
 
 #endif
diff --git a/include/asm-um/types.h b/include/asm-um/types.h
index 816e959..5a01134 100644
--- a/include/asm-um/types.h
+++ b/include/asm-um/types.h
@@ -1,6 +1,6 @@
 #ifndef __UM_TYPES_H
 #define __UM_TYPES_H
 
-#include "asm/arch/types.h"
+#include <asm/arch/types.h>
 
 #endif
diff --git a/include/asm-um/uaccess.h b/include/asm-um/uaccess.h
index 16c734a..59726f0 100644
--- a/include/asm-um/uaccess.h
+++ b/include/asm-um/uaccess.h
@@ -6,7 +6,7 @@
 #ifndef __UM_UACCESS_H
 #define __UM_UACCESS_H
 
-#include "linux/sched.h"
+#include <linux/sched.h>
 
 #define VERIFY_READ 0
 #define VERIFY_WRITE 1
diff --git a/include/asm-um/ucontext.h b/include/asm-um/ucontext.h
index 5c96c0e..fac29f6 100644
--- a/include/asm-um/ucontext.h
+++ b/include/asm-um/ucontext.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_UM_UCONTEXT_H
 #define _ASM_UM_UCONTEXT_H
 
-#include "asm/arch/ucontext.h"
+#include <asm/arch/ucontext.h>
 
 #endif
diff --git a/include/asm-um/unaligned.h b/include/asm-um/unaligned.h
index 1d2497c..5b65430 100644
--- a/include/asm-um/unaligned.h
+++ b/include/asm-um/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef __UM_UNALIGNED_H
 #define __UM_UNALIGNED_H
 
-#include "asm/arch/unaligned.h"
+#include <asm/arch/unaligned.h>
 
 #endif
diff --git a/include/asm-um/unistd.h b/include/asm-um/unistd.h
index 732c83f..dfaf0bc 100644
--- a/include/asm-um/unistd.h
+++ b/include/asm-um/unistd.h
@@ -7,8 +7,8 @@
 #define _UM_UNISTD_H_
 
 #include <linux/syscalls.h>
-#include "linux/resource.h"
-#include "asm/uaccess.h"
+#include <linux/resource.h>
+#include <asm/uaccess.h>
 
 extern int um_execve(const char *file, char *const argv[], char *const env[]);
 
@@ -37,6 +37,6 @@ extern int um_execve(const char *file, char *const argv[], char *const env[]);
 #define __ARCH_WANT_SYS_RT_SIGSUSPEND
 #endif
 
-#include "asm/arch/unistd.h"
+#include <asm/arch/unistd.h>
 
 #endif /* _UM_UNISTD_H_*/
diff --git a/include/asm-um/user.h b/include/asm-um/user.h
index aae414e..7e1588b 100644
--- a/include/asm-um/user.h
+++ b/include/asm-um/user.h
@@ -1,6 +1,6 @@
 #ifndef __UM_USER_H
 #define __UM_USER_H
 
-#include "asm/arch/user.h"
+#include <asm/arch/user.h>
 
 #endif
diff --git a/include/asm-um/vga.h b/include/asm-um/vga.h
index 903a592..b0d519b 100644
--- a/include/asm-um/vga.h
+++ b/include/asm-um/vga.h
@@ -1,6 +1,6 @@
 #ifndef __UM_VGA_H
 #define __UM_VGA_H
 
-#include "asm/arch/vga.h"
+#include <asm/arch/vga.h>
 
 #endif
diff --git a/include/asm-um/vm86.h b/include/asm-um/vm86.h
index 7801f82..bd864d5 100644
--- a/include/asm-um/vm86.h
+++ b/include/asm-um/vm86.h
@@ -1,6 +1,6 @@
 #ifndef __UM_VM86_H
 #define __UM_VM86_H
 
-#include "asm/arch/vm86.h"
+#include <asm/arch/vm86.h>
 
 #endif
