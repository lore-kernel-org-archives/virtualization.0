From: Jan Dakinevich <jan.dakinevich@gmail.com>
Subject: [PATCH] tty: hvc: don't allocate a buffer for console print on stack
Date: Fri, 17 Feb 2017 23:42:45 +0300
Message-ID: <1487364165-21882-1-git-send-email-jan.dakinevich__36886.0624534593$1487967492$gmane$org@gmail.com>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jan Dakinevich <jan.dakinevich@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, Dan Carpenter <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The buffer is used by virtio console driver as DMA buffer. Since v4.9
(if VMAP_STACK is enabled) we shouldn't use the stack for DMA.

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 9b5c0fb..1ce6aaf 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -143,10 +143,15 @@ static struct hvc_struct *hvc_get_by_index(int index)
 static void hvc_console_print(struct console *co, const char *b,
 			      unsigned count)
 {
-	char c[N_OUTBUF] __ALIGNED__;
 	unsigned i = 0, n = 0;
 	int r, donecr = 0, index = co->index;
 
+	/*
+	 * Access to the buffer is serialized by console_sem in caller code from
+	 * kernel/printk/printk.c
+	 */
+	static char c[N_OUTBUF] __ALIGNED__;
+
 	/* Console access attempt outside of acceptable console range. */
 	if (index >= MAX_NR_HVC_CONSOLES)
 		return;
-- 
1.9.1
