From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6/6] tools/virtio: add virtio 1.0 in vringh_test
Date: Mon, 15 Dec 2014 00:04:43 +0200
Message-ID: <1418594542-22623-7-git-send-email-mst@redhat.com>
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
 tools/virtio/vringh_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 51d922f..5f94f51 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -457,6 +457,8 @@ int main(int argc, char *argv[])
 			__virtio_set_bit(&vdev, VIRTIO_RING_F_INDIRECT_DESC);
 		else if (strcmp(argv[1], "--eventidx") == 0)
 			__virtio_set_bit(&vdev, VIRTIO_RING_F_EVENT_IDX);
+		else if (strcmp(argv[1], "--virtio-1") == 0)
+			__virtio_set_bit(&vdev, VIRTIO_F_VERSION_1);
 		else if (strcmp(argv[1], "--slow-range") == 0)
 			getrange = getrange_slow;
 		else if (strcmp(argv[1], "--fast-vringh") == 0)
-- 
MST
