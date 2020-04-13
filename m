From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH] vdpa: fix comment of vdpa_register_device()
Date: Mon, 13 Apr 2020 17:37:38 +0800
Message-ID: <20200413093738.28467-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

The function should be called only after a success calling for
vdpa_alloc_device().

Reported-by: Eli Cohen <eli@mellanox.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index e9ed6a2b635b..ff6562f602e0 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL_GPL(__vdpa_alloc_device);
=20
 /**
  * vdpa_register_device - register a vDPA device
- * Callers must have a succeed call of vdpa_init_device() before.
+ * Callers must have a succeed call of vdpa_alloc_device() before.
  * @vdev: the vdpa device to be registered to vDPA bus
  *
  * Returns an error when fail to add to vDPA bus
--=20
2.20.1
