From: Colin King <colin.king@canonical.com>
Subject: [PATCH] tools/virtio: fix spelling mistake: "wakeus" -> "wakeups"
Date: Sat, 29 Apr 2017 23:14:21 +0100
Message-ID: <20170429221421.12238-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in an error message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/virtio/virtio_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 76d6f583c249..0fecaec90d0d 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -202,7 +202,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 	test = 0;
 	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
 	assert(r >= 0);
-	fprintf(stderr, "spurious wakeus: 0x%llx\n", spurious);
+	fprintf(stderr, "spurious wakeups: 0x%llx\n", spurious);
 }
 
 const char optstring[] = "h";
-- 
2.11.0
