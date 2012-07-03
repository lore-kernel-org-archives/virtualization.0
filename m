From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] virtio-blk spec: writeback cache enable improvements
Date: Tue,  3 Jul 2012 15:16:52 +0200
Message-ID: <1341321412-24214-3-git-send-email-pbonzini@redhat.com>
References: <1341321412-24214-1-git-send-email-pbonzini@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1341321412-24214-1-git-send-email-pbonzini@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: virtualization@lists.osdl.org, kvm@vger.kernel.org, rusty@rustcorp.com.au
List-Id: virtualization@lists.linuxfoundation.org

This patch introduces two improvements to writeback cache handling
in the virtio-blk spec.

1) The VIRTIO_BLK_F_FLUSH feature is renamed to VIRTIO_BLK_F_WCE, and
QEMU's behavior is documented explicitly as part of the spec: the host
negotiates the feature only if its cache is writeback.  The obvious dual
requirement is imposed on the guest: it should negotiate the feature
only if it is able to send flushes.  And in order to protect against
data loss, the spec now mandates that the host operates in writethrough
mode if the guest does not negotiate VIRTIO_BLK_F_WCE (this behavior
was already _allowed_ by the spec so far).  This can change with every
reset of course; typically the BIOS will run as writethrough, while the
"main" OS will run in writeback mode.  This is a backwards-compatible
refinement geared towards old or limited guests, so there is no need
for a new feature bit.

2) a second feature is added, VIRTIO_BLK_F_CONFIG_WCE, that provides
the same information in the configuration.  This will enable the driver
to modify the write-cache setting at runtime (via sysfs for Linux, via
MODE SELECT for Windows).

Patches for QEMU and Linux will come soonish.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virtio-spec.lyx |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 859dbe7..fccbd28 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -5021,9 +5021,19 @@ VIRTIO_BLK_F_SCSI (7) Device supports scsi packet commands.
 \end_layout
 
 \begin_layout Description
-VIRTIO_BLK_F_FLUSH (9) Cache flush command support.
+VIRTIO_BLK_F_
+\change_deleted 1531152142 1341302299
+FLUSH
+\change_inserted 1531152142 1341302304
+WCE
+\change_unchanged
+ (9) 
+\change_deleted 1531152142 1341302317
+Cache flush command support.
 \change_inserted 1531152142 1341305427
-
+Device cache starts in writeback mode after reset.
+ Guests should not negotiate this feature unless they are capable of sending
+ VIRTIO_BLK_T_FLUSH commands.
 \end_layout
 
 \begin_layout Description
@@ -5032,6 +5042,13 @@ VIRTIO_BLK_F_FLUSH (9) Cache flush command support.
 VIRTIO_BLK_F_TOPOLOGY (10) Device exports information on optimal I/O alignment.
 \end_layout
 
+\begin_layout Description
+
+\change_inserted 1531152142 1341302349
+VIRTIO_BLK_F_CONFIG_WCE (11) Device can toggle its cache between writeback
+ and writethrough modes.
+\end_layout
+
 \end_deeper
 \begin_layout Description
 Device
@@ -5145,6 +5162,15 @@ struct virtio_blk_config {
 
 \begin_layout Plain Layout
 
+\change_inserted 1531152142 1341301918
+
+    u8 writeback;
+\change_unchanged
+
+\end_layout
+
+\begin_layout Plain Layout
+
 };
 \end_layout
 
@@ -5205,6 +5231,33 @@ If the VIRTIO_BLK_F_TOPOLOGY feature is negotiated, the fields in the topology
  This also does not affect the units in the protocol, only performance.
 \end_layout
 
+\begin_layout Enumerate
+
+\change_inserted 1531152142 1341305949
+The cache mode should be read from the writeback field of the configuration
+ if the VIRTIO_BLK_F_CONFIG_WCE feature if available; the driver can also
+ write to the field in order to toggle the cache between writethrough (0)
+ and writeback (1) mode.
+ If the feature is not available, the driver can instead look at the result
+ of negotiating VIRTIO_BLK_F_WCE: the cache will be in writeback mode after
+ reset if and only if VIRTIO_BLK_F_WCE is negotiated
+\begin_inset Foot
+status open
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1341306004
+Until version 1.1, QEMU remained in writeback mode even after a guest announced
+ lack of support for VIRTIO_BLK_F_FLUSH.
+\change_unchanged
+
+\end_layout
+
+\end_inset
+
+.
+\end_layout
+
 \begin_layout Section*
 Device Operation
 \end_layout
-- 
1.7.10.2

