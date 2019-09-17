From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [RFC v4 1/3] vfio: support getting vfio device from device fd
Date: Tue, 17 Sep 2019 09:02:02 +0800
Message-ID: <20190917010204.30376-2-tiwei.bie__39320.9975374461$1568682317$gmane$org@intel.com>
References: <20190917010204.30376-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190917010204.30376-1-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, maxime.coquelin@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhihong.wang@intel.com, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This patch introduces the support for getting VFIO device
from VFIO device fd. With this support, it's possible for
vhost to get VFIO device from the group fd and device fd
set by the userspace.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/vfio/vfio.c  | 25 +++++++++++++++++++++++++
 include/linux/vfio.h |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 388597930b64..697fd079bb3f 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -890,6 +890,31 @@ static struct vfio_device *vfio_device_get_from_name(struct vfio_group *group,
 	return device;
 }
 
+struct vfio_device *vfio_device_get_from_fd(struct vfio_group *group,
+					    int device_fd)
+{
+	struct fd f;
+	struct vfio_device *it, *device = ERR_PTR(-ENODEV);
+
+	f = fdget(device_fd);
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+
+	mutex_lock(&group->device_lock);
+	list_for_each_entry(it, &group->device_list, group_next) {
+		if (it == f.file->private_data) {
+			device = it;
+			vfio_device_get(device);
+			break;
+		}
+	}
+	mutex_unlock(&group->device_lock);
+
+	fdput(f);
+	return device;
+}
+EXPORT_SYMBOL_GPL(vfio_device_get_from_fd);
+
 /*
  * Caller must hold a reference to the vfio_device
  */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e42a711a2800..e75b24fd7c5c 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -15,6 +15,8 @@
 #include <linux/poll.h>
 #include <uapi/linux/vfio.h>
 
+struct vfio_group;
+
 /**
  * struct vfio_device_ops - VFIO bus driver device callbacks
  *
@@ -50,6 +52,8 @@ extern int vfio_add_group_dev(struct device *dev,
 
 extern void *vfio_del_group_dev(struct device *dev);
 extern struct vfio_device *vfio_device_get_from_dev(struct device *dev);
+extern struct vfio_device *vfio_device_get_from_fd(struct vfio_group *group,
+						   int device_fd);
 extern void vfio_device_put(struct vfio_device *device);
 extern void *vfio_device_data(struct vfio_device *device);
 
-- 
2.17.1
