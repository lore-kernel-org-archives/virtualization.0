From: weiping zhang <zwp10758@gmail.com>
Subject: [PATCH v4 4/4] virtio_remoteproc: don't kfree device on register
	failure
Date: Wed, 20 Dec 2017 12:27:33 +0800
Message-ID: <443858dfab89720b846aa9c656679ff6ad20d0af.1513700444.git.zhangweiping@didichuxing.com>
References: <cover.1513700444.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1513700444.git.zhangweiping@didichuxing.com>
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
 drivers/remoteproc/remoteproc_virtio.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 2946348..1073ea3 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -304,7 +304,7 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 {
 	struct rproc *rproc = rvdev->rproc;
 	struct device *dev = &rproc->dev;
-	struct virtio_device *vdev = &rvdev->vdev;
+	struct virtio_device *vdev = &rvdev->vdev, *reg_dev = NULL;
 	int ret;
 
 	vdev->id.device	= id,
@@ -326,15 +326,24 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 	kref_get(&rvdev->refcount);
 
 	ret = register_virtio_device(vdev);
+	reg_dev = vdev;
 	if (ret) {
-		put_device(&rproc->dev);
 		dev_err(dev, "failed to register vdev: %d\n", ret);
 		goto out;
 	}
 
 	dev_info(dev, "registered %s (type %d)\n", dev_name(&vdev->dev), id);
 
+	return 0;
+
 out:
+	if (reg_dev)
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
