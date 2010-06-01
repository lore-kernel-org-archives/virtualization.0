From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 0/2] virtio: put last seen used index into ring itself
Date: Tue, 1 Jun 2010 18:12:57 +0300
Message-ID: <20100601151257.GA11704__35978.2025604092$1275405465$gmane$org@redhat.com>
References: <cover.1275403477.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1275403477.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 01, 2010 at 05:47:08PM +0300, Michael S. Tsirkin wrote:
> Changes from v2: added padding between avail idx and flags,
> and changed virtio to only publish used index when callbacks
> are enabled.

Here's the updated spec patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

--

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index ed35893..a2dcd76 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -1803,6 +1803,36 @@ next
 \emph default
  descriptor entry (modulo the ring size).
  This starts at 0, and increases.
+\change_inserted 0 1274966643
+
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1274968378
+When PUBLISH_USED feature flag has 
+\emph on
+not
+\emph default
+ been negotiated, the ring follows the 
+\begin_inset Quotes eld
+\end_inset
+
+flags
+\begin_inset Quotes erd
+\end_inset
+
+ and the 
+\begin_inset Quotes eld
+\end_inset
+
+idx
+\begin_inset Quotes erd
+\end_inset
+
+ fields:
+\change_unchanged
+
 \end_layout
 
 \begin_layout Standard
@@ -1845,7 +1875,143 @@ struct vring_avail {
 
 \end_layout
 
+\begin_layout Standard
+
+\change_inserted 0 1274968432
+\begin_inset CommandInset label
+LatexCommand label
+name "PUBLISH_USED-feature"
+
+\end_inset
+
+When PUBLISH_USED feature flag has been negotiated, the control structure
+ including the 
+\begin_inset Quotes eld
+\end_inset
+
+flags and the 
+\begin_inset Quotes eld
+\end_inset
+
+idx
+\begin_inset Quotes erd
+\end_inset
+
+ fields follows the ring.
+ This leaves the room for the 
+\begin_inset Quotes eld
+\end_inset
+
+last_seen_used_idx
+\begin_inset Quotes erd
+\end_inset
+
+ field, which indicates the most recent 
+\begin_inset Quotes eld
+\end_inset
+
+idx
+\begin_inset Quotes erd
+\end_inset
+
+ value observed by guest in the used ring (see 
+\begin_inset CommandInset ref
+LatexCommand ref
+reference "sub:Used-Ring"
+
+\end_inset
+
+ below):
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 0 1274967396
+\begin_inset listings
+inline false
+status open
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1274967404
+
+struct vring_avail {
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1275404889
+
+   u16 ring[qsz]; /* qsz is the Queue Size field read from device */
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1275404891
+
+   u16 idx;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1275404921
+
+   u8 pad[254] /* Padding to avoid sharing cache line between flags and
+ idx fields.
+ */
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1274967533
+
+#define VRING_AVAIL_F_NO_INTERRUPT      1
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1274967533
+
+   u16 flags;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1274968345
+
+   u16 last_seen_used_idx;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1274967396
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
+\change_inserted 0 1274967715
+If the ring is large enough, the second layout maintains the control and
+ ring structures on separate cache lines.
+\end_layout
+
 \begin_layout Subsection
+
+\change_inserted 0 1274968415
+\begin_inset CommandInset label
+LatexCommand label
+name "sub:Used-Ring"
+
+\end_inset
+
+
+\change_unchanged
 Used Ring
 \end_layout
 
@@ -2391,12 +2557,20 @@ status open
 
 \begin_layout Plain Layout
 
-while (vq->last_seen_used != vring->used.idx) {
+while (vq->last_seen_used
+\change_inserted 0 1274968316
+_idx
+\change_unchanged
+ != vring->used.idx) {
 \end_layout
 
 \begin_layout Plain Layout
 
-    struct vring_used_elem *e = vring.used->ring[vq->last_seen_used%vsz];
+    struct vring_used_elem *e = vring.used->ring[vq->last_seen_used
+\change_inserted 0 1274968326
+_idx
+\change_unchanged
+%vsz];
 \end_layout
 
 \begin_layout Plain Layout
@@ -2406,7 +2580,11 @@ while (vq->last_seen_used != vring->used.idx) {
 
 \begin_layout Plain Layout
 
-    vq->last_seen_used++;
+    vq->last_seen_used
+\change_inserted 0 1274968321
+_idx
+\change_unchanged
+++;
 \end_layout
 
 \begin_layout Plain Layout
@@ -2419,6 +2597,15 @@ while (vq->last_seen_used != vring->used.idx) {
 
 \end_layout
 
+\begin_layout Standard
+
+\change_inserted 0 1275405042
+If PUBLISH_USED feature is negotiated, last_seen_used value should be published
+ to the device in the avail ring.
+ This value is used by the host for interrupt mitigation, so it only need
+ to be updated when interrupts are enabled.
+\end_layout
+
 \begin_layout Subsection
 Dealing With Configuration Changes
 \end_layout
@@ -2986,6 +3173,47 @@ struct vring_avail {
 \begin_layout Plain Layout
 
 };
+\change_inserted 0 1274966477
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1274966484
+
+struct vring_avail_ctrl {
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1274966489
+
+        __u16 flags;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1274966494
+
+        __u16 idx;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1274966499
+
+        __u16 last_used_idx;
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 0 1274966474
+
+};
 \end_layout
 
 \begin_layout Plain Layout
@@ -3349,6 +3577,28 @@ reference "sub:Indirect-Descriptors"
 \end_inset
 
 .
+\change_inserted 0 1274967762
+
+\end_layout
+
+\begin_layout Description
+
+\change_inserted 0 1274967926
+VIRTIO_F_RING_PUBLISH_USED
+\begin_inset space ~
+\end_inset
+
+(29) Negotiating this feature indicates that the avail ring layout includes
+ the used index observed by driver, see
+\begin_inset CommandInset ref
+LatexCommand ref
+reference "PUBLISH_USED-feature"
+
+\end_inset
+
+.
+\change_unchanged
+
 \end_layout
 
 \begin_layout Description
