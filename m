From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio: initialize earlier
Date: Fri, 7 May 2010 14:28:34 +0930
Message-ID: <201005071428.35127.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stijn Tintel <stijn@linux-ipv6.be>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Stijn Tintel <stijn@linux-ipv6.be>

Move initialization of the virtio framework before the initialization of
mtd, so that block2mtd can be used on virtio-based block devices.

Addresses https://bugzilla.kernel.org/show_bug.cgi?id=15644

Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: stable@kernel.org
---
 drivers/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 34f1e10..f42a030 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SFI)		+= sfi/
 obj-$(CONFIG_PNP)		+= pnp/
 obj-$(CONFIG_ARM_AMBA)		+= amba/
 
+obj-$(CONFIG_VIRTIO)		+= virtio/
 obj-$(CONFIG_XEN)		+= xen/
 
 # regulators early, since some subsystems rely on them to initialize
@@ -108,7 +109,6 @@ obj-$(CONFIG_PPC_PS3)		+= ps3/
 obj-$(CONFIG_OF)		+= of/
 obj-$(CONFIG_SSB)		+= ssb/
 obj-$(CONFIG_VHOST_NET)		+= vhost/
-obj-$(CONFIG_VIRTIO)		+= virtio/
 obj-$(CONFIG_VLYNQ)		+= vlynq/
 obj-$(CONFIG_STAGING)		+= staging/
 obj-y				+= platform/
