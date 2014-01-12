From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] MAINTAINERS: add virtio-dev ML for virtio
Date: Sun, 12 Jan 2014 13:37:56 +0200
Message-ID: <20140112113756.GA9127__39312.9867421978$1389526709$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: virtio-dev@lists.oasis-open.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux-foundation.org, amit.shah@redhat.com, netdev@vger.kernel.org, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: virtualization@lists.linuxfoundation.org

Since virtio is an OASIS standard draft now, virtio implementation
discussions are taking place on the virtio-dev OASIS mailing list.
Update MAINTAINERS.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS              |   3 +
 drivers/net/virtio_net.c | 355 +++++++++++++++++++++++++----------------------
 2 files changed, 191 insertions(+), 167 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffcaf97..75202af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9088,6 +9088,7 @@ F:	include/media/videobuf2-*
 
 VIRTIO CONSOLE DRIVER
 M:	Amit Shah <amit.shah@redhat.com>
+L:	virtio-dev@lists.oasis-open.org
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/char/virtio_console.c
@@ -9097,6 +9098,7 @@ F:	include/uapi/linux/virtio_console.h
 VIRTIO CORE, NET AND BLOCK DRIVERS
 M:	Rusty Russell <rusty@rustcorp.com.au>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
+L:	virtio-dev@lists.oasis-open.org
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/virtio/
@@ -9109,6 +9111,7 @@ F:	include/uapi/linux/virtio_*.h
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	kvm@vger.kernel.org
+L:	virtio-dev@lists.oasis-open.org
 L:	virtualization@lists.linux-foundation.org
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
MST
