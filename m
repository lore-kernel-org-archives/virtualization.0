From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost: synchronize IOTLB message with dev cleanup
Date: Tue, 22 May 2018 19:58:57 +0800
Message-ID: <1526990337-24892-1-git-send-email-jasowang@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

DaeRyong Jeong reports a race between vhost_dev_cleanup() and
vhost_process_iotlb_msg():

Thread interleaving:
CPU0 (vhost_process_iotlb_msg)			CPU1 (vhost_dev_cleanup)
(In the case of both VHOST_IOTLB_UPDATE and
VHOST_IOTLB_INVALIDATE)
=====						=====
						vhost_umem_clean(dev->iotlb);
if (!dev->iotlb) {
	        ret = -EFAULT;
		        break;
}
						dev->iotlb = NULL;

The reason is we don't synchronize between them, fixing by protecting
vhost_process_iotlb_msg() with dev mutex.

Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f3bd8e9..f0be5f3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -981,6 +981,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 {
 	int ret = 0;
 
+	mutex_lock(&dev->mutex);
 	vhost_dev_lock_vqs(dev);
 	switch (msg->type) {
 	case VHOST_IOTLB_UPDATE:
@@ -1016,6 +1017,8 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 	}
 
 	vhost_dev_unlock_vqs(dev);
+	mutex_unlock(&dev->mutex);
+
 	return ret;
 }
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
-- 
2.7.4
