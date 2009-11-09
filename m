From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-spec: correct wording
Date: Mon, 9 Nov 2009 16:47:53 +0200
Message-ID: <20091109144751.GA3339@redhat.com>
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
List-Id: virtualization@lists.linuxfoundation.org

virtio header resizes in the first I/O region,
not in PCI configuration space as the spec v0.8.1 implied.
Correct this.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I started looking at virtio spec with the view to updating it with new
features and possibly documenting more devices. I have used latex in the
past but not lyx.  As a start, here's a patch to correct a nit in
wording.  This is just what lyx generated for me, I'd like to get an
idea how best to prepare such documentation patches. E.g. do we want
change tracking in the document at this stage?  Rusty?

The patches are agaist initial version from here:
http://ozlabs.org/~rusty/virtio-spec/virtio-spec-0.8.1.lyx This is just
what google found for me.  Is there a repository I should work against
instead?


 virtio-spec.lyx |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 7e39d77..33e8e0a 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -1,4 +1,4 @@
-#LyX 1.6.2 created this file. For more info see http://www.lyx.org/
+#LyX 1.6.4 created this file. For more info see http://www.lyx.org/
 \lyxformat 345
 \begin_document
 \begin_header
@@ -36,7 +36,7 @@
 \paperpagestyle default
 \tracking_changes true
 \output_changes true
-\author "" 
+\author "Michael S. Tsirkin" 
 \author "" 
 \end_header
 
@@ -1971,8 +1971,13 @@ Notifying The Device
 
 \begin_layout Standard
 Device notification occurs by writing the 16-bit virtqueue index of this
- virtqueue to the Queue Notify field of the virtio header in the PCI configurati
-on space.
+ virtqueue to the Queue Notify field of the virtio header in the 
+\change_inserted 0 1257776268
+first I/O region of the PCI device
+\change_deleted 0 1257776222
+PCI configuration space
+\change_unchanged
+.
  This can be expensive, however, so the device can suppress such notifications
  if it doesn't need them.
  We have to be careful to expose the new idx value 
-- 
1.6.5.2.143.g8cc62
