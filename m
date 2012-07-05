From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] MAINTAINERS: add kvm list for virtio components
Date: Thu,  5 Jul 2012 12:07:07 +0200
Message-ID: <1341482827-13195-1-git-send-email-pbonzini@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: amit.shah@redhat.com, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The KVM list is followed by more people than the generic
virtualization@lists.linux-foundation.org mailing list, and is
already "de facto" the place where virtio patches are posted.

pv-ops still has no other lists than virtualization@lists.linux-foundation.org.
However, pv-ops patches will likely touch Xen or KVM files as well and
the respective mailing list will usually be reached as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14bc707..e265f2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7340,6 +7340,7 @@ F:	include/media/videobuf2-*
 VIRTIO CONSOLE DRIVER
 M:	Amit Shah <amit.shah@redhat.com>
 L:	virtualization@lists.linux-foundation.org
+L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/char/virtio_console.c
 F:	include/linux/virtio_console.h
@@ -7348,6 +7349,7 @@ VIRTIO CORE, NET AND BLOCK DRIVERS
 M:	Rusty Russell <rusty@rustcorp.com.au>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	virtualization@lists.linux-foundation.org
+L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/virtio/
 F:	drivers/net/virtio_net.c
-- 
1.7.1
