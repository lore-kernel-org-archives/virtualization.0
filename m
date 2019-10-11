From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 2/7] mdev: bus uevent support
Date: Fri, 11 Oct 2019 16:15:52 +0800
Message-ID: <20191011081557.28302-3-jasowang__30896.6629950859$1570782313$gmane$org@redhat.com>
References: <20191011081557.28302-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191011081557.28302-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com
Cc: christophe.de.dinechin@gmail.com, sebott@linux.ibm.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, virtualization@lists.linux-foundation.org, rob.miller@broadcom.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, zhenyuw@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, jani.nikula@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, akrowiak@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, oberpar@linux.ibm.com, maxime.coquelin@redhat.com, daniel@ffwll.ch, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This patch adds bus uevent support for mdev bus in order to allow
cooperation with userspace.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vfio/mdev/mdev_driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mdev_driver.c
index b7c40ce86ee3..319d886ffaf7 100644
--- a/drivers/vfio/mdev/mdev_driver.c
+++ b/drivers/vfio/mdev/mdev_driver.c
@@ -82,9 +82,17 @@ static int mdev_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
+static int mdev_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	return add_uevent_var(env, "MODALIAS=mdev:c%02X", mdev->class_id);
+}
+
 struct bus_type mdev_bus_type = {
 	.name		= "mdev",
 	.match		= mdev_match,
+	.uevent		= mdev_uevent,
 	.probe		= mdev_probe,
 	.remove		= mdev_remove,
 };
-- 
2.19.1
