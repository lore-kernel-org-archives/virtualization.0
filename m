From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] vhost: fix missing unlock on error in
	vhost_net_set_features()
Date: Tue,  2 Aug 2016 13:50:10 +0000
Message-ID: <1470145810-17513-1-git-send-email-weiyj.lk@gmail.com>
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
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Add the missing unlock before return from function
vhost_net_set_features() in the error handling case.

Fixes: eefe82d9b81f ('vhost: new device IOTLB API')
Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/vhost/net.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6bdd90..5dc128a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1104,13 +1104,12 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 	}
 	mutex_lock(&n->dev.mutex);
 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
-	    !vhost_log_access_ok(&n->dev)) {
-		mutex_unlock(&n->dev.mutex);
-		return -EFAULT;
-	}
+	    !vhost_log_access_ok(&n->dev))
+		goto out_unlock;
+
 	if ((features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))) {
 		if (vhost_init_device_iotlb(&n->dev, true))
-			return -EFAULT;
+			goto out_unlock;
 	}
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
@@ -1122,6 +1121,10 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 	}
 	mutex_unlock(&n->dev.mutex);
 	return 0;
+
+out_unlock:
+	mutex_unlock(&n->dev.mutex);
+	return -EFAULT;
 }
 
 static long vhost_net_set_owner(struct vhost_net *n)
