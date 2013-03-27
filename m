From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH 3/3] vhost: Only call vhost_verify_ring_mappings when adding
	vhost memory
Date: Wed, 27 Mar 2013 21:59:46 +0000
Message-ID: <1364421586-29857-4-git-send-email-nab__38631.072783801$1364422311$gmane$org@linux-iscsi.org>
References: <1364421586-29857-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364421586-29857-1-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: target-devel <target-devel@vger.kernel.org>
Cc: kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

This patch fixes a bug where vhost_verify_ring_mappings() could be
called after vhost_dev_unassign_memory() has been called during
vhost_set_memory(..., add=false).

This appears to be fallout from when dev->started = true assignment
occurs before vhost_set_memory(..., add=false) is called in:

commit 24f4fe345c1b80bab1ee18573914123d8028a9e6
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Tue Dec 25 17:41:07 2012 +0200

    vhost: set started flag while start is in progress

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Asias He <asias@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/vhost.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/hw/vhost.c b/hw/vhost.c
index 4d6aee3..687a689 100644
--- a/hw/vhost.c
+++ b/hw/vhost.c
@@ -421,7 +421,7 @@ static void vhost_set_memory(MemoryListener *listener,
         return;
     }
 
-    if (dev->started) {
+    if (dev->started && add) {
         r = vhost_verify_ring_mappings(dev, start_addr, size);
         assert(r >= 0);
     }
-- 
1.7.2.5
