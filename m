From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 1/8] vringh: fix copy direction of vringh_iov_push_kern()
Date: Tue, 24 Sep 2019 21:53:25 +0800
Message-ID: <20190924135332.14160-2-jasowang__12376.8745268293$1569333341$gmane$org@redhat.com>
References: <20190924135332.14160-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190924135332.14160-1-jasowang@redhat.com>
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

We want to copy from iov to buf, so the direction was wrong.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vringh.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 08ad0d1f0476..a0a2d74967ef 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -852,6 +852,12 @@ static inline int xfer_kern(void *src, void *dst, size_t len)
 	return 0;
 }
 
+static inline int kern_xfer(void *dst, void *src, size_t len)
+{
+	memcpy(dst, src, len);
+	return 0;
+}
+
 /**
  * vringh_init_kern - initialize a vringh for a kernelspace vring.
  * @vrh: the vringh to initialize.
@@ -958,7 +964,7 @@ EXPORT_SYMBOL(vringh_iov_pull_kern);
 ssize_t vringh_iov_push_kern(struct vringh_kiov *wiov,
 			     const void *src, size_t len)
 {
-	return vringh_iov_xfer(wiov, (void *)src, len, xfer_kern);
+	return vringh_iov_xfer(wiov, (void *)src, len, kern_xfer);
 }
 EXPORT_SYMBOL(vringh_iov_push_kern);
 
-- 
2.19.1
