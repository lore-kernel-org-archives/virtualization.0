From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-spec: fix thinko in multiport documentation
Date: Sun, 9 Sep 2012 14:08:37 +0300
Message-ID: <20120909110837.GA2395@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

spec numbers ports port0, port 1 etc, then goes on to say
"ports 2 onwards only if MULTIPORT is set".
An obvious thinko, should be port 1 onwards.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 virtio-spec.lyx | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index a713807..d801aa6 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -6298,7 +6298,13 @@ Virtqueues 0:receiveq(port0).
 status open
 
 \begin_layout Plain Layout
-Ports 2 onwards only if VIRTIO_CONSOLE_F_MULTIPORT is set
+Ports 
+\change_inserted 1986246365 1347188327
+1
+\change_deleted 1986246365 1347188327
+2
+\change_unchanged
+ onwards only if VIRTIO_CONSOLE_F_MULTIPORT is set
 \end_layout
 
 \end_inset
-- 
MST
