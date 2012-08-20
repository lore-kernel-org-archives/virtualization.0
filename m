From: Cong Meng <mc@linux.vnet.ibm.com>
Subject: [PATCH] virtio-scsi spec: add per-LUN parameter query
Date: Mon, 20 Aug 2012 17:03:24 +0800
Message-ID: <1345453404-15244-1-git-send-email-mc__13533.112491905$1345453549$gmane$org@linux.vnet.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Each virtio scsi HBA has global request queue limits. But the passthrough
LUNs (scsi-generic) come from different host HBAs may have different request
queue limits. If the guest sends commands that exceed the host limits, the
commands will be rejected by host HAB. 

To address this issue, this patch adds a per-LUN parameter query via the control
queue, and defines some parameter query types. The driver can query and set the
needed per-LUN parameters if the device enables this feature.

Signed-off-by: Cong Meng <mc@linux.vnet.ibm.com>
--
 virtio-spec.lyx |  218 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 218 insertions(+), 0 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 7a073f4..6d23ab9 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -58,6 +58,7 @@
 \html_be_strict false
 \author -608949062 "Rusty Russell,,," 
 \author 1531152142 "Paolo Bonzini,,," 
+\author 2090695081 "Cong Meng,,," 
 \end_header
 
 \begin_body
@@ -7028,6 +7029,19 @@ VIRTIO_SCSI_F_CHANGE
 
 (2) The host will report changes to LUN parameters via a VIRTIO_SCSI_T_PARAM_CHA
 NGE event.
+\change_inserted 2090695081 1345439613
+
+\end_layout
+
+\begin_layout Description
+
+\change_inserted 2090695081 1345442620
+VIRTIO_SCSI_F_PER_LUN_QUERY
+\begin_inset space ~
+\end_inset
+
+(3) The host will support the per-LUN parameter query.
+ 
 \change_unchanged
 
 \end_layout
@@ -8178,6 +8192,210 @@ response
 
 \begin_layout Standard
 No command-specific values are defined for the response byte.
+\change_inserted 2090695081 1345439679
+
+\end_layout
+
+\end_deeper
+\begin_layout Description
+
+\change_inserted 2090695081 1345441715
+Per
+\begin_inset space \space{}
+\end_inset
+
+LUN
+\begin_inset space \space{}
+\end_inset
+
+query
+\begin_inset space ~
+\end_inset
+
+
+\end_layout
+
+\begin_deeper
+\begin_layout Standard
+
+\change_inserted 2090695081 1345440230
+\begin_inset listings
+inline false
+status open
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345441722
+
+#define VIRTIO_SCSI_T_PER_LUN_QUERY             3
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345440248
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345441801
+
+/* query type */
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345441725
+
+#define VIRTIO_SCSI_T_PLQ_MAX_SECTORS           0 
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345441726
+
+#define VIRTIO_SCSI_T_PLQ_MAX_SEGMENTS          1 
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345441727
+
+#define VIRTIO_SCSI_T_PLQ_MAX_SEGMENT_SIZE      2 
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345440248
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345441729
+
+struct virtio_scsi_ctrl_plq {
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345440248
+
+    // Read-only part
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345440248
+
+    u32 type;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345441767
+
+    u8  lun[8];
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345441807
+
+    u32 query_type;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345440248
+
+    // Write-only part
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345440248
+
+    u8  response;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345445844
+
+    u32 parameter;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 2090695081 1345440248
+
+}
+\end_layout
+
+\end_inset
+
+
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 2090695081 1345443439
+The type field should be VIRTIO_SCSI_T_PER_LUN_QUERY.
+ 
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 2090695081 1345445951
+The query_type field is defined as below:
+\end_layout
+
+\begin_layout Itemize
+
+\change_inserted 2090695081 1345445082
+VIRTIO_SCSI_T_PLQ_MAX_SECTORS: Maximum request size of the LUN's request
+ queue.
+ The unit is KB (1024 bytes).
+\end_layout
+
+\begin_layout Itemize
+
+\change_inserted 2090695081 1345446052
+VIRTIO_SCSI_T_PLQ_MAX_SEGMENTS: Maximum sg list segments of the LUN's request
+ queue.
+\end_layout
+
+\begin_layout Itemize
+
+\change_inserted 2090695081 1345445058
+VIRTIO_SCSI_T_PLQ_MAX_SEGMENT_SIZE: Maximum segment size of the LUN's request
+ queue.
+ The unit is byte.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 2090695081 1345445877
+By sending this command, the driver asks the specified LUN to report the
+ parameter specified by the query_type field.
+ The device responds by writing the parameter that it supports into the
+ parameter field, and VIRTIO_SCSI_S_OK into the response field.
+ Otherwise the device should write the corresponding failure response value
+ into the response field.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 2090695081 1345443070
+All fields of the read-only part are written by the driver.
+ All fields of the write-only part are written by the device.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 2090695081 1345440259
+No command-specific values are defined for the response byte.
 \end_layout
 
 \end_deeper
-- 
1.7.7.6
