From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 04/31] hvc_console: Remove __devinit annotation from hvc_alloc
Date: Tue, 22 Dec 2009 20:04:14 +0530
Message-ID: <1261492481-19817-5-git-send-email-amit.shah__22376.2121554048$1261493005$gmane$org@redhat.com>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-2-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-3-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-4-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, linuxppc-dev@ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Virtio consoles can be hotplugged, so hvc_alloc gets called from
multiple sites: from the initial probe() routine as well as later on
from workqueue handlers which aren't __devinit code.

So, drop the __devinit annotation for hvc_alloc.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
Cc: linuxppc-dev@ozlabs.org
---
 drivers/char/hvc_console.c |    6 +++---
 drivers/char/hvc_console.h |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index d8dac58..4c3b59b 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -748,9 +748,9 @@ static const struct tty_operations hvc_ops = {
 	.chars_in_buffer = hvc_chars_in_buffer,
 };
 
-struct hvc_struct __devinit *hvc_alloc(uint32_t vtermno, int data,
-				       const struct hv_ops *ops,
-				       int outbuf_size)
+struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
+			     const struct hv_ops *ops,
+			     int outbuf_size)
 {
 	struct hvc_struct *hp;
 	int i;
diff --git a/drivers/char/hvc_console.h b/drivers/char/hvc_console.h
index 52ddf4d..54381eb 100644
--- a/drivers/char/hvc_console.h
+++ b/drivers/char/hvc_console.h
@@ -80,8 +80,8 @@ extern int hvc_instantiate(uint32_t vtermno, int index,
 			   const struct hv_ops *ops);
 
 /* register a vterm for hvc tty operation (module_init or hotplug add) */
-extern struct hvc_struct * __devinit hvc_alloc(uint32_t vtermno, int data,
-				const struct hv_ops *ops, int outbuf_size);
+extern struct hvc_struct * hvc_alloc(uint32_t vtermno, int data,
+				     const struct hv_ops *ops, int outbuf_size);
 /* remove a vterm from hvc tty operation (module_exit or hotplug remove) */
 extern int hvc_remove(struct hvc_struct *hp);
 
-- 
1.6.2.5
