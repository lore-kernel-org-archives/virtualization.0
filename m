From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: export virtio_rng.h
Date: Fri, 8 Aug 2008 11:15:07 +0200
Message-ID: <200808081115.07411.borntraeger__5767.69976546547$1218187202$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

The entropy device was added after we exported all virtio headers. This
patch adds virtio_rng.h to the exportable userspace headers.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
 include/linux/Kbuild |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/include/linux/Kbuild
===================================================================
--- linux-2.6.orig/include/linux/Kbuild
+++ linux-2.6/include/linux/Kbuild
@@ -356,6 +356,7 @@ unifdef-y += virtio_balloon.h
 unifdef-y += virtio_console.h
 unifdef-y += virtio_pci.h
 unifdef-y += virtio_ring.h
+unifdef-y += virtio_rng.h
 unifdef-y += vt.h
 unifdef-y += wait.h
 unifdef-y += wanrouter.h
