From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 39/41] xen/events: use virt_xxx barriers
Date: Sun, 10 Jan 2016 16:21:56 +0200
Message-ID: <1452426622-4471-40-git-send-email-mst__31707.4965722442$1452435852$gmane$org@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wei Liu <wei.liu2@citrix.com>, Konrad Rzeszutek Wilk <konrad.wil>
List-Id: virtualization@lists.linuxfoundation.org

drivers/xen/events/events_fifo.c uses rmb() to communicate with the
other side.

For guests compiled with CONFIG_SMP, smp_rmb would be sufficient, so
rmb() here is only needed if a non-SMP guest runs on an SMP host.

Switch to the virt_rmb barrier which serves this exact purpose.

Pull in asm/barrier.h here to make sure the file is self-contained.

Suggested-by: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/xen/events/events_fifo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index 96a1b8d..eff2b88 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -41,6 +41,7 @@
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 
+#include <asm/barrier.h>
 #include <asm/sync_bitops.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/hypervisor.h>
@@ -296,7 +297,7 @@ static void consume_one_event(unsigned cpu,
 	 * control block.
 	 */
 	if (head == 0) {
-		rmb(); /* Ensure word is up-to-date before reading head. */
+		virt_rmb(); /* Ensure word is up-to-date before reading head. */
 		head = control_block->head[priority];
 	}
 
-- 
MST
