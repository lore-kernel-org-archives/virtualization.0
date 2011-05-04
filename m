From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 13/18] virtio_test: avail_event index support
Date: Wed, 4 May 2011 23:52:22 +0300
Message-ID: <bd3d5246228411adcf5ae3c7da0463a82cddde6e.1304541919.git.mst__16893.7239599929$1304542404$gmane$org@redhat.com>
References: <cover.1304541918.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1304541918.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Add ability to test the new avail_event feature,
enable by default.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/virtio_test.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 157ec68..8adf55d 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -202,6 +202,14 @@ const struct option longopts[] = {
 		.val = 'h',
 	},
 	{
+		.name = "avail-event-idx",
+		.val = 'A',
+	},
+	{
+		.name = "no-avail-event-idx",
+		.val = 'a',
+	},
+	{
 		.name = "indirect",
 		.val = 'I',
 	},
@@ -224,7 +232,8 @@ const struct option longopts[] = {
 static void help()
 {
 	fprintf(stderr, "Usage: virtio_test [--help]"
-		" [--no-indirect] "
+		" [--no-indirect]"
+		" [--no-avail-event-idx]"
 		" [--no-used-event-idx]\n");
 }
 
@@ -232,7 +241,8 @@ int main(int argc, char **argv)
 {
 	struct vdev_info dev;
 	unsigned long long features = (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
-		(1ULL << VIRTIO_RING_F_USED_EVENT_IDX);
+		(1ULL << VIRTIO_RING_F_USED_EVENT_IDX) |
+		(1ULL << VIRTIO_RING_F_AVAIL_EVENT_IDX);
 	int o;
 
 	for (;;) {
@@ -243,6 +253,9 @@ int main(int argc, char **argv)
 		case '?':
 			help();
 			exit(2);
+		case 'a':
+			features &= ~(1ULL << VIRTIO_RING_F_AVAIL_EVENT_IDX);
+			break;
 		case 'h':
 			help();
 			goto done;
-- 
1.7.5.53.gc233e
