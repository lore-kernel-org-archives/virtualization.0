From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH RESEND 2/5] ifcvf: ignore continuous setting same staus value
Date: Fri,  5 Jun 2020 18:27:12 +0800
Message-ID: <1591352835-22441-3-git-send-email-lingshan.zhu@intel.com>
References: <1591352835-22441-1-git-send-email-lingshan.zhu@intel.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1591352835-22441-1-git-send-email-lingshan.zhu@intel.com>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

User space may try to set status of same value for multiple times,
this patch can handle this case more efficiently by ignoring the
same value of status settings.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index d529ed6..63a6366 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -179,6 +179,9 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 	adapter = dev_get_drvdata(vdpa_dev->dev.parent);
 	status_old = ifcvf_get_status(vf);
 
+	if (status_old == status)
+		return;
+
 	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) &&
 	    !(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
 		ifcvf_stop_datapath(adapter);
-- 
1.8.3.1
