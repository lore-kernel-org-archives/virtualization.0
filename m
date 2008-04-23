From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC] virtio: export more headers to userspace
Date: Wed, 23 Apr 2008 12:57:00 +0200
Message-ID: <200804231257.00427.borntraeger__10553.5335293554$1208948456$gmane$org@de.ibm.com>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty,

is there a reason why we dont export the virtio headers for
9p, balloon, console, pci, and virtio_ring? kvm uses make sync,
but I think it is still useful to heave these headers exported 
as they might be useful for other userspace tools.

I dont export virtio.h, because it does not seem to have useful 
information for userspace and it requires scatterlist.h which is 
also not exported. See also my other mail about your "virtio:
change config to guest endian." patch.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/Kbuild |    5 +++++
 1 file changed, 5 insertions(+)

Index: kvm/include/linux/Kbuild
===================================================================
--- kvm.orig/include/linux/Kbuild
+++ kvm/include/linux/Kbuild
@@ -346,6 +346,11 @@ unifdef-y += videodev.h
 unifdef-y += virtio_config.h
 unifdef-y += virtio_blk.h
 unifdef-y += virtio_net.h
+unifdef-y += virtio_9p.h
+unifdef-y += virtio_balloon.h
+unifdef-y += virtio_console.h
+unifdef-y += virtio_pci.h
+unifdef-y += virtio_ring.h
 unifdef-y += vt.h
 unifdef-y += wait.h
 unifdef-y += wanrouter.h
