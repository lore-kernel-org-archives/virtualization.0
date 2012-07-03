From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] virtio-blk spec: document topology info
Date: Tue,  3 Jul 2012 15:16:51 +0200
Message-ID: <1341321412-24214-2-git-send-email-pbonzini@redhat.com>
References: <1341321412-24214-1-git-send-email-pbonzini@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1341321412-24214-1-git-send-email-pbonzini@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: virtualization@lists.osdl.org, kvm@vger.kernel.org, rusty@rustcorp.com.au
List-Id: virtualization@lists.linuxfoundation.org

Current QEMU and Linux drivers can export queue parameters via the
virtio-blk configuration space.  Document this, since the next patch
will have to add another configuration field after these.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virtio-spec.lyx |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index dd2d53b..859dbe7 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -5021,7 +5021,20 @@ VIRTIO_BLK_F_SCSI (7) Device supports scsi packet commands.
 \end_layout
 
 \begin_layout Description
-VIRTIO_BLK_F_FLUSH (9) Cache flush command support.Device
+VIRTIO_BLK_F_FLUSH (9) Cache flush command support.
+\change_inserted 1531152142 1341305427
+
+\end_layout
+
+\begin_layout Description
+
+\change_inserted 1531152142 1341301882
+VIRTIO_BLK_F_TOPOLOGY (10) Device exports information on optimal I/O alignment.
+\end_layout
+
+\end_deeper
+\begin_layout Description
+Device
 \begin_inset space ~
 \end_inset
 
@@ -5090,6 +5103,48 @@ struct virtio_blk_config {
 
 \begin_layout Plain Layout
 
+\change_inserted 1531152142 1341301807
+
+    struct virtio_blk_topology {
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341301810
+
+        u8 physical_block_exp;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341301817
+
+        u8 alignment_offset;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341301822
+
+        u16 min_io_size;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341301827
+
+        u32 opt_io_size;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341301911
+
+    } topology;
+\end_layout
+
+\begin_layout Plain Layout
+
 };
 \end_layout
 
@@ -5098,7 +5153,6 @@ struct virtio_blk_config {
 
 \end_layout
 
-\end_deeper
 \begin_layout Section*
 Device Initialization
 \end_layout
@@ -5119,15 +5173,36 @@ capacity
 \begin_layout Enumerate
 If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated, the blk_size field can
  be read to determine the optimal sector size for the driver to use.
- This does not effect the units used in the protocol (always 512 bytes),
- but awareness of the correct value can effect performance.
+ This does not 
+\change_deleted 1531152142 1341301967
+e
+\change_inserted 1531152142 1341301967
+a
+\change_unchanged
+ffect the units used in the protocol (always 512 bytes), but awareness of
+ the correct value can 
+\change_deleted 1531152142 1341301978
+e
+\change_inserted 1531152142 1341301978
+a
+\change_unchanged
+ffect performance.
 \end_layout
 
 \begin_layout Enumerate
 If the VIRTIO_BLK_F_RO feature is set by the device, any write requests
  will fail.
-\change_inserted 1531152142 1341301982
+\change_inserted 1531152142 1341301920
+
+\end_layout
 
+\begin_layout Enumerate
+
+\change_inserted 1531152142 1341301982
+If the VIRTIO_BLK_F_TOPOLOGY feature is negotiated, the fields in the topology
+ struct can be read to determine the physical block size and optimal I/O
+ lengths for the driver to use.
+ This also does not affect the units in the protocol, only performance.
 \end_layout
 
 \begin_layout Section*
-- 
1.7.10.2


