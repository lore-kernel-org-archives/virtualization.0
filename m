From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 05/14] virtio_test: support event index
Date: Fri, 20 May 2011 02:11:05 +0300
Message-ID: <fbed57582b9e8d97c11f889937ea65f42eb03da2.1305846412.git.mst__1018.80972874842$1305846973$gmane$org@redhat.com>
References: <cover.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1305846412.git.mst@redhat.com>
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

Add ability to test the new event idx feature,
enable by default.
---
 tools/virtio/virtio_test.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index df0c6d2..74d3331 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -198,6 +198,14 @@ const struct option longopts[] = {
 		.val = 'h',
 	},
 	{
+		.name = "event-idx",
+		.val = 'E',
+	},
+	{
+		.name = "no-event-idx",
+		.val = 'e',
+	},
+	{
 		.name = "indirect",
 		.val = 'I',
 	},
@@ -211,13 +219,17 @@ const struct option longopts[] = {
 
 static void help()
 {
-	fprintf(stderr, "Usage: virtio_test [--help] [--no-indirect]\n");
+	fprintf(stderr, "Usage: virtio_test [--help]"
+		" [--no-indirect]"
+		" [--no-event-idx]"
+		"\n");
 }
 
 int main(int argc, char **argv)
 {
 	struct vdev_info dev;
-	unsigned long long features = 1ULL << VIRTIO_RING_F_INDIRECT_DESC;
+	unsigned long long features = (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
+		(1ULL << VIRTIO_RING_F_EVENT_IDX);
 	int o;
 
 	for (;;) {
@@ -228,6 +240,9 @@ int main(int argc, char **argv)
 		case '?':
 			help();
 			exit(2);
+		case 'e':
+			features &= ~(1ULL << VIRTIO_RING_F_EVENT_IDX);
+			break;
 		case 'h':
 			help();
 			goto done;
-- 
1.7.5.53.gc233e
