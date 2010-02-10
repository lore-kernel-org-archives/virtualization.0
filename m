From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-spec: document indirect descriptors
Date: Wed, 10 Feb 2010 15:00:39 +0200
Message-ID: <20100210130026.GA19271__19938.5827094831$1265807092$gmane$org@redhat.com>
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
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
Cc: markmc@redhat.com, qemu-devel@nongnu.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add documentation for indirect descriptors

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 virtio-spec.lyx |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 8062e11..b5a8fbd 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -1,4 +1,4 @@
-#LyX 1.6.4 created this file. For more info see http://www.lyx.org/
+#LyX 1.6.5 created this file. For more info see http://www.lyx.org/
 \lyxformat 345
 \begin_document
 \begin_header
@@ -36,8 +36,7 @@
 \paperpagestyle default
 \tracking_changes true
 \output_changes true
-\author "" 
-\author "" 
+\author "Michael S. Tsirkin" 
 \author "" 
 \end_header
 
@@ -1441,7 +1440,28 @@ struct vring_desc {
 
 \begin_layout Plain Layout
 
-#define VRING_DESC_F_WRITE     2 
+#define VRING_DESC_F_WRITE     2
+\change_deleted 0 1265802057
+ 
+\change_inserted 0 1265802048
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265802054
+
+/* This means the buffer contains a list of buffer descriptors.
+ */
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265802049
+
+#define VRING_DESC_F_INDIRECT   4 
+\change_unchanged
+
 \end_layout
 
 \begin_layout Plain Layout
@@ -1478,6 +1498,96 @@ struct vring_desc {
 \begin_layout Standard
 The number of descriptors in the table is specified by the Queue Size field
  for this virtqueue.
+\change_deleted 0 1265801065
+
+\end_layout
+
+\begin_layout Subsubsection
+
+\change_inserted 0 1265801341
+Indirect Descriptors
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1265805736
+Some devices benefit by concurrently dispatching a large number of large
+ requests.
+ To increase ring capacity it is possible to store a table of 
+\emph on
+indirect descriptors
+\emph default
+ anywhere in memory, and insert a descriptor in main virtqueue (with flags&INDIRECT on) that refers to memory buffer containing this 
+\emph on
+indirect descriptor table
+\emph default
+; fields 
+\emph on
+addr
+\emph default
+ and 
+\emph on
+len
+\emph default
+ refer to the indirect table address and length in bytes, respectively.
+ The indirect table layout structure looks like this (len is the length
+ of the descriptor that refers to this table, which is a variable, so this
+ code won't compile):
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1265804397
+\begin_inset listings
+inline false
+status open
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265804526
+
+struct indirect_descriptor_table {
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265804397
+
+    /* The actual descriptors (16 bytes each) */
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265804473
+
+    struct vring_desc desc[len / 16];
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1265804397
+
+};
+\end_layout
+
+\end_inset
+
+
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1265805219
+The first indirect descriptor is located at start of the indirect descriptor
+ table (index 0), additional indirect descriptors are chained by next field.
+ An indirect descriptor without next field (with flags&NEXT off) signals
+ the end of the indirect descriptor table, and transfers control back to
+ the main virtqueue.
+ An indirect descriptor can not refer to another indirect descriptor table
+ (flags&INDIRECT must be off).
+ A single indirect descriptor table can include both read-only and write-only
+ descriptors; write-only flag (flags&WRITE) in the descriptor that refers
+ to it is ignored.
 \end_layout
 
 \begin_layout Subsection
-- 
1.6.6.144.g5c3af
