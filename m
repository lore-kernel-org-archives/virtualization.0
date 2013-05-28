From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/2] virtio-balloon spec: reintroduce "silent deflation"
	feature
Date: Tue, 28 May 2013 19:40:18 +0200
Message-ID: <1369762818-8787-3-git-send-email-pbonzini@redhat.com>
References: <1369762818-8787-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1369762818-8787-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

The original idea of the VIRTIO_BALLOON_F_MUST_TELL_HOST feature was to
let drivers skip usage of the deflate queue when leaking the balloon
("silent deflation").  Guests may benefit from silent deflate by
aggressively inflating the balloon; they know that they will be able to
use ballooned pages without issuing a (blocking) request to the device.

The previous patch redefined the feature to ensure correctness of the
operation when drivers do not correctly report deflation.  This patch
adds back the optimization.

The new feature bit is for the host to tell the drivers if silent
deflation is actually supported.  The meaning of the feature bit is
reversed compared to the original, because the original meaning was
not safe against migration.

For features to be safe against migration, they have to be defined as
"this is true if the guest _can_ do X".  For such a "positive" feature,
migration is possible if the destination supports it, or the source
didn't set it:

    dest support      source set          ok?
          T                T              T
          T                F              T
          F                T              F
          F                F              T

Instead, the old feature was defined as "this is true if the guest
_cannot_ do X".  For such a "negative" feature, migration is possible
if the destination supports it, or the source sets it:

    dest support      source set          ok?
          T                T              T
          T                F              F
          F                T              T
          F                F              T

However, the negotiated features are supposed to be the AND of the
device- and driver-supported features.  In the F/T case, the feature
would be negotiated by the source as T, and become F when negotiated on
the destination.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virtio-spec.lyx | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 5c76a87..5da4fde 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -7267,6 +7267,20 @@ VIRTIO_BALLOON_F_STATS_VQ
 \end_inset
 
 (1) A virtqueue for reporting guest memory statistics is present.
+\change_inserted 1531152142 1347020627
+
+\end_layout
+
+\begin_layout Description
+
+\change_inserted 1531152142 1347020648
+VIRTIO_BALLOON_F_SILENT_DEFLATE
+\begin_inset space ~
+\end_inset
+
+(2) Guest need not tell host before pages from the balloon are used.
+\change_unchanged
+
 \end_layout
 
 \end_deeper
@@ -7627,6 +7641,168 @@ VIRTIO_BALLOON_S_MEMFREE The amount of memory not being used for any purpose
 VIRTIO_BALLOON_S_MEMTOT The total amount of memory available (in bytes).
 \end_layout
 
+\begin_layout Description
+
+\change_inserted 1531152142 1368005515
+Silent
+\begin_inset space ~
+\end_inset
+
+deflation
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 1531152142 1368005515
+
+\series medium
+Some implementation of the balloon device may not require the guest to deflate
+ the balloon explicitly; instead, the guest may just take a page from its
+ reserve and start using it.
+ This is called 
+\begin_inset Quotes eld
+\end_inset
+
+silent deflate
+\begin_inset Quotes erd
+\end_inset
+
+
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 1531152142 1368005515
+In order to use this feature effectively, both the guest and the host need
+ to know how the other part intends to use the balloon.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 1531152142 1368005515
+
+\series medium
+Guests may benefit from silent deflate by aggressively inflating the balloon;
+ they know that they will be able to use ballooned pages without issuing
+ a (blocking) request to the device.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 1531152142 1368005515
+Knowing that the guest will 
+\emph on
+not
+\emph default
+ deflate silently also benefits the host.
+ For example, if the host is pinning the guest's memory, it may unpin ballooned
+ pages and pin them again upon deflation.
+ This allows cooperative memory overcommit even if the guest's memory is
+ pinned.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 1531152142 1368005515
+Thus, there are two possibilities for the host (either it does not support
+ silent deflate, or it does), and three for the guest (it doesn't need silent
+ deflate, it may choose to use it if available, it requires it).
+ Because there are three possibilities for the guest, support for silent
+ deflate is represented by two different feature bits.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 1531152142 1368005515
+The feature bits are used as follows:
+\end_layout
+
+\begin_layout Itemize
+
+\change_inserted 1531152142 1368005671
+if the host does not support silent deflate, it must propose the
+VIRTIO_\SpecialChar \-
+BALLOON_F_\SpecialChar \-
+CAN_\SpecialChar \-
+TELL_\SpecialChar \-
+HOST feature.
+ If the guest does 
+\emph on
+not
+\emph default
+ negotiate it, the host should assume that the guest will use silent deflate.
+ A host that does not support silent deflate then must do nothing on attempts
+ of the guest to deflate/inflate the balloon, except put the descriptors on
+ the used ring.
+\end_layout
+
+\begin_layout Itemize
+
+\change_inserted 1531152142 1368005515
+a guest that 
+\emph on
+must
+\emph default
+ use silent deflation does not need to negotiate any feature.
+\end_layout
+
+\begin_layout Itemize
+
+\change_inserted 1531152142 1368005676
+a guest that 
+\emph on
+will never
+\emph default
+ use silent deflation only has to propose VIRTIO_\SpecialChar \-
+BALLOON_F_\SpecialChar \-
+CAN_\SpecialChar \-
+TELL_\SpecialChar \-
+HOST.
+ It need not do anything if the host does not negotiate the feature.
+\end_layout
+
+\begin_layout Itemize
+
+\change_inserted 1531152142 1368005686
+a guest that 
+\emph on
+can optionally
+\emph default
+ use silent deflation should propose both VIRTIO_\SpecialChar \-
+BALLOON_F_\SpecialChar \-
+CAN_\SpecialChar \-
+TELL_\SpecialChar \-
+HOST
+ and VIRTIO_\SpecialChar \-
+BALLOON_F_\SpecialChar \-
+SILENT_\SpecialChar \-
+DEFLATE.
+ The guest driver can then use silent deflation if and only if the host
+ has negotiated VIRTIO_\SpecialChar \-
+BALLOON_F_\SpecialChar \-
+SILENT_\SpecialChar \-
+DEFLATE too.
+\end_layout
+
+\begin_layout Standard
+
+\change_inserted 1531152142 1368005690
+Hosts are free to propose the VIRTIO_\SpecialChar \-
+BALLOON_F_\SpecialChar \-
+CAN_\SpecialChar \-
+TELL_\SpecialChar \-
+HOST feature even if they support silent deflation.
+ It will
+ not affect operation of a well-behaving guest; such a guest
+ should never check if the host proposed the feature, and
+ should not assume that lack of this feature implies support
+ for silent deflation. The only bit to check for this purpose is
+ VIRTIO_\SpecialChar \-
+BALLOON_F_\SpecialChar \-
+SILENT_\SpecialChar \-
+DEFLATE.
+\end_layout
+
 \begin_layout Chapter*
 Appendix H: Rpmsg: Remote Processor Messaging
 \end_layout
-- 
1.8.2.1
