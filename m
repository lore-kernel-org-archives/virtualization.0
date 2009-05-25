From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 11/11] qemu: request 3 vectors in virtio-net
Date: Mon, 25 May 2009 15:26:35 +0300
Message-ID: <20090525122635.GL5046__22304.4925406159$1243255468$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1243253205.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>, qemu-devel@nongnu.org, Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Rusty Russell <rusty@rustcor>
List-Id: virtualization@lists.linuxfoundation.org

Request up to 3 vectors in virtio-net. Actual bindings might supply
less.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio-net.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index 60aa6da..6118fe3 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -621,6 +621,7 @@ VirtIODevice *virtio_net_init(DeviceState *dev)
     n->mac_table.macs = qemu_mallocz(MAC_TABLE_ENTRIES * ETH_ALEN);
 
     n->vlans = qemu_mallocz(MAX_VLAN >> 3);
+    n->vdev.nvectors = 3;
 
     register_savevm("virtio-net", virtio_net_id++, VIRTIO_NET_VM_VERSION,
                     virtio_net_save, virtio_net_load, n);
-- 
1.6.3.1.56.g79e1.dirty
