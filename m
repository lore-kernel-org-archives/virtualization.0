From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH] virtio/s390: use dev_to_virtio
Date: Wed, 30 Dec 2015 22:05:25 +0800
Message-ID: <912bf59bd3a48f2d4d4994681e898dc084fe29d3.1451484163.git.geliangtang__21516.3640132689$1451707060$gmane$org@163.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Geliang Tang <geliangtang@163.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Use dev_to_virtio() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/s390/virtio/virtio_ccw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 1b83159..97231e1 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -945,8 +945,7 @@ static struct virtio_config_ops virtio_ccw_config_ops = {
 
 static void virtio_ccw_release_dev(struct device *_d)
 {
-	struct virtio_device *dev = container_of(_d, struct virtio_device,
-						 dev);
+	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_ccw_device *vcdev = to_vc_device(dev);
 
 	kfree(vcdev->status);
-- 
2.5.0
