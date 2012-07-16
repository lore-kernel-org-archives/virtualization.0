From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] virtio-scsi spec: unify event structs
Date: Mon, 16 Jul 2012 16:24:36 +0200
Message-ID: <1342448677-7453-2-git-send-email-pbonzini__36856.152493465$1342448698$gmane$org@redhat.com>
References: <1342448677-7453-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1342448677-7453-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, rusty@rustcorp.com.au
Cc: qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

All currently defined event structs have the same fields.  Simplify the
driver by enforcing this also for future structs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virtio-spec.lyx |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 905e619..f8b214b 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -8207,7 +8207,20 @@ struct virtio_scsi_event {
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440791
+
     ...
+\change_inserted 1531152142 1342440791
+u8  lun[8];
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1342440791
+
+    u32 reason;
+\change_unchanged
+
 \end_layout
 
 \begin_layout Plain Layout
@@ -8221,16 +8234,32 @@ struct virtio_scsi_event {
 \end_layout
 
 \begin_layout Standard
-If bit 31 is set in the event field, the device failed to report an event
- due to missing buffers.
+If bit 31 is set in the 
+\series bold
+event
+\series default
+ field, the device failed to report an event due to missing buffers.
  In this case, the driver should poll the logical units for unit attention
  conditions, and/or do whatever form of bus scan is appropriate for the
  guest operating system.
 \end_layout
 
 \begin_layout Standard
-Other data that the device writes to the buffer depends on the contents
- of the event field.
+
+\change_deleted 1531152142 1342440830
+Other data that the device writes to the buffer
+\change_inserted 1531152142 1342440839
+The meaning of the 
+\series bold
+reason
+\series default
+ field
+\change_unchanged
+ depends on the contents of the 
+\series bold
+event
+\series default
+ field.
  The following events are defined:
 \end_layout
 
@@ -8312,36 +8341,50 @@ status open
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440799
+
 struct virtio_scsi_event_reset {
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440799
+
     // Write-only part
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440799
+
     u32 event;
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440799
+
     u8  lun[8];
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440799
+
     u32 reason;
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440799
+
 }
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440799
+
 \end_layout
 
 \begin_layout Plain Layout
@@ -8542,40 +8585,58 @@ status open
 \begin_layout Plain Layout
 
 #define VIRTIO_SCSI_T_ASYNC_NOTIFY     2
+\change_deleted 1531152142 1342440854
+
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440854
+
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440854
+
 struct virtio_scsi_event_an {
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440854
+
     // Write-only part
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440854
+
     u32 event;
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440854
+
     u8  lun[8];
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440854
+
     u32 reason;
 \end_layout
 
 \begin_layout Plain Layout
 
+\change_deleted 1531152142 1342440854
+
 }
+\change_unchanged
+
 \end_layout
 
 \end_inset
-- 
1.7.10.4
