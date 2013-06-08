From: Laszlo Ersek <lersek@redhat.com>
Subject: [virtio-spec PATCH 1/5] Receiving Used Buffers: fix typo in "ring
	empty" condition in example code
Date: Sat,  8 Jun 2013 19:39:24 +0200
Message-ID: <1370713168-20624-2-git-send-email-lersek@redhat.com>
References: <1370713168-20624-1-git-send-email-lersek@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1370713168-20624-1-git-send-email-lersek@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, Jordan Justen <jordan.l.justen@intel.com>, Laszlo Ersek <lersek@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 virtio-spec.lyx |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 6e188d0..41a763c 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -2942,7 +2942,7 @@ for (;;) {
 
 \begin_layout Plain Layout
 
-    if (vq->last_seen_used != vring->used.idx) {
+    if (vq->last_seen_used == vring->used.idx) {
 \end_layout
 
 \begin_layout Plain Layout
@@ -2957,7 +2957,7 @@ for (;;) {
 
 \begin_layout Plain Layout
 
-		if (vq->last_seen_used != vring->used.idx)
+		if (vq->last_seen_used == vring->used.idx)
 \end_layout
 
 \begin_layout Plain Layout
-- 
1.7.1
