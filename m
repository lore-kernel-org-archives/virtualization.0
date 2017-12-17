From: weiping zhang <zwp10758@gmail.com>
Subject: [PATCH v3 4/5] virtio_remoteproc: don't kfree device on register
	failure
Date: Sun, 17 Dec 2017 21:47:32 +0800
Message-ID: <ae7a136b31f0c38024311ad9aaf285b8b4ca8b34.1513517240.git.zhangweiping@didichuxing.com>
References: <cover.1513517240.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1513517240.git.zhangweiping@didichuxing.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: cohuck@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

rproc_virtio_dev_release will be called iff virtio_device.dev's
refer count became to 0. Here we should check if we call device_register
or not, if called, put vdev.dev, and then rproc->dev's cleanup will be
done in rproc_virtio_dev_release, otherwise we do cleanup directly.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/remoteproc/remoteproc_virtio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 2946348..ad5d6d1 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -327,14 +327,22 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 
 	ret = register_virtio_device(vdev);
 	if (ret) {
-		put_device(&rproc->dev);
 		dev_err(dev, "failed to register vdev: %d\n", ret);
 		goto out;
 	}
 
 	dev_info(dev, "registered %s (type %d)\n", dev_name(&vdev->dev), id);
 
+	return 0;
+
 out:
+	if (VIRTIO_CONFIG_S_ACKNOWLEDGE & virtio_get_status(vdev))
+		put_device(&vdev->dev);
+	else {
+		kref_put(&rvdev->refcount, rproc_vdev_release);
+		put_device(&rproc->dev);
+	}
+
 	return ret;
 }
 
-- 
2.9.4
