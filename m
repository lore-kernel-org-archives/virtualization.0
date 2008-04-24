From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/6] virtio: export more headers to userspace
Date: Wed, 23 Apr 2008 23:56:29 -0500
Message-ID: <200804241456.29940.rusty__26569.1243381754$1209013499$gmane$org@rustcorp.com.au>
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
To: linux-kernel@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

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
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
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
