From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5/6] tools/virtio: add virtio 1.0 in virtio_test
Date: Mon, 15 Dec 2014 00:04:38 +0200
Message-ID: <1418594542-22623-6-git-send-email-mst@redhat.com>
References: <1418594542-22623-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418594542-22623-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/virtio_test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 67873c3..e044589 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -228,6 +228,14 @@ const struct option longopts[] = {
 		.val = 'i',
 	},
 	{
+		.name = "virtio-1",
+		.val = '1',
+	},
+	{
+		.name = "no-virtio-1",
+		.val = '0',
+	},
+	{
 		.name = "delayed-interrupt",
 		.val = 'D',
 	},
@@ -244,6 +252,7 @@ static void help(void)
 	fprintf(stderr, "Usage: virtio_test [--help]"
 		" [--no-indirect]"
 		" [--no-event-idx]"
+		" [--no-virtio-1]"
 		" [--delayed-interrupt]"
 		"\n");
 }
@@ -252,7 +261,7 @@ int main(int argc, char **argv)
 {
 	struct vdev_info dev;
 	unsigned long long features = (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
-		(1ULL << VIRTIO_RING_F_EVENT_IDX);
+		(1ULL << VIRTIO_RING_F_EVENT_IDX) | (1ULL << VIRTIO_F_VERSION_1);
 	int o;
 	bool delayed = false;
 
@@ -273,6 +282,9 @@ int main(int argc, char **argv)
 		case 'i':
 			features &= ~(1ULL << VIRTIO_RING_F_INDIRECT_DESC);
 			break;
+		case '0':
+			features &= ~(1ULL << VIRTIO_F_VERSION_1);
+			break;
 		case 'D':
 			delayed = true;
 			break;
-- 
MST
