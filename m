From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio: update MAINTAINERS
Date: Mon, 31 Jan 2011 16:46:20 +1030
Message-ID: <201101311646.20873.rusty__1097.74215748093$1296454734$gmane$org@rustcorp.com.au>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Patches should keep coming through Rusty but it
helps if I'm Cc'd as well.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 MAINTAINERS |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23d0436..7de75ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6439,6 +6439,16 @@ S:	Maintained
 F:	drivers/char/virtio_console.c
 F:	include/linux/virtio_console.h
 
+VIRTIO CORE, NET AND BLOCK DRIVERS
+M:	Rusty Russell <rusty@rustcorp.com.au>
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/virtio/
+F:	drivers/net/virtio_net.c
+F:	drivers/block/virtio_blk.c
+F:	include/linux/virtio_*.h
+
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	kvm@vger.kernel.org
