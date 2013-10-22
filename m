From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH RFC 2/7] s390/virtio_ccw: set virtqueue as broken if host
	notify failed
Date: Tue, 22 Oct 2013 14:45:06 +0200
Message-ID: <1382445911-55657-3-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1382445911-55657-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382445911-55657-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Set the current virtqueue as broken if the appropriate host kick failed
(e.g. if the device was hot-unplugged via host means).
This error info can be exploited at various other places where a host
kick is triggered.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 6a410d4..ac0ace6 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -384,6 +384,8 @@ static void virtio_ccw_kvm_notify(struct virtqueue *vq)
 	vcdev = to_vc_device(info->vq->vdev);
 	ccw_device_get_schid(vcdev->cdev, &schid);
 	info->cookie = do_kvm_notify(schid, vq->index, info->cookie);
+	if (info->cookie < 0)
+		virtqueue_set_broken(vq);
 }
 
 static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
-- 
1.8.3.1
