From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 1/2] virtio-balloon spec: rewrite description of
	VIRTIO_BALLOON_F_MUST_TELL_HOST
Date: Tue, 28 May 2013 19:40:17 +0200
Message-ID: <1369762818-8787-2-git-send-email-pbonzini@redhat.com>
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

The idea of the VIRTIO_BALLOON_F_MUST_TELL_HOST feature was to let drivers
skip usage of the deflate queue when leaking the balloon ("silent
deflation").  Guests may benefit from silent deflate by aggressively
inflating the balloon; they know that they will be able to use ballooned
pages without issuing a (blocking) request to the device.

The original spec assumed that every driver supports
VIRTIO_BALLOON_F_MUST_TELL_HOST, but this was not explicitly documented
and in practice it turns out not to be the case; the Windows balloon
driver does not tell the host correctly.

Since all known device implementations support silent deflation, they
do not negotiate the feature and we are thus free to redefine what
the host should do about this feature.

The Windows driver is also the only known driver that does not
negotiate VIRTIO_BALLOON_F_MUST_TELL_HOST.  Thus, even though the
used to be meant for communication from the host, known drivers are
really using it to communicate was in the other direction.

Adjust the spec to conform.  The original intent is reintroduced with
a new feature bit in the next patch, while also fixing a problem with
its definition.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virtio-spec.lyx | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index adec0a5..5c76a87 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -7219,11 +7219,46 @@ bits
 
 \begin_deeper
 \begin_layout Description
-VIRTIO_BALLOON_F_MUST_TELL_HOST
+VIRTIO_BALLOON_F_
+\change_deleted 1531152142 1347020601
+MUST
+\change_inserted 1531152142 1347020602
+CAN
+\change_unchanged
+_TELL_HOST
 \begin_inset space ~
 \end_inset
 
-(0) Host must be told before pages from the balloon are used.
+(0) 
+\change_deleted 1531152142 1347020625
+Host must be told
+\change_inserted 1531152142 1347020617
+Guest is able to tell host
+\change_unchanged
+ before pages from the balloon are used.
+
+\change_inserted 1531152142 1368005603
+ The host must propose this feature if it has to be told
+ before pages from the balloon are used.
+\begin_inset Foot
+status open
+
+\begin_layout Plain Layout
+
+\change_inserted 1531152142 1347022389
+This feature used to be named VIRTIO_BALLOON_F_\SpecialChar \-
+MUST_TELL_HOST.
+ However, after a few years it was observed that drivers were not using
+ it as specified.
+ The virtio-balloon spec was then adjusted to what the drivers had been
+ doing.
+\end_layout
+
+\end_inset
+
+
+\change_unchanged
+
 \end_layout
 
 \begin_layout Description
@@ -7382,9 +7417,15 @@ The driver constructs an array of addresses of memory pages it has previously
 \end_layout
 
 \begin_layout Enumerate
-If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is set, the guest may not
- use these requested pages until that descriptor in the deflateq has been
- used by the device.
+If the VIRTIO_BALLOON_F_
+\change_deleted 1531152142 1369761770
+MUST
+\change_inserted 1531152142 1369761770
+CAN
+\change_unchanged
+_TELL_HOST feature is set, the guest may not use these requested pages until
+ that descriptor in the deflateq has been used by the device.
+
 \end_layout
 
 \begin_layout Enumerate
@@ -7396,10 +7437,21 @@ status open
 
 \begin_layout Plain Layout
 In this case, deflation advice is merely a courtesy
+\change_inserted 1531152142 1369761798
+.
+ The guest need not use the deflateq at all.
+\change_unchanged
+
 \end_layout
 
 \end_inset
 
+
+\change_inserted 1531152142 1369761801
+ If the host does not support this, it should not do anything when the balloon
+ is inflated or deflated, except put the descriptors on the used ring.
+
+\change_unchanged
  
 \end_layout
 
-- 
1.8.2.1
