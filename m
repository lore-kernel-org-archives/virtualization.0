From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v7 02/14] fixup! vhost: option to fetch descriptors
 through an independent struct
Date: Wed, 10 Jun 2020 07:35:59 -0400
Message-ID: <20200610113515.1497099-3-mst@redhat.com>
References: <20200610113515.1497099-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200610113515.1497099-1-mst@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, eperezma@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 180b7b58c76b..11433d709651 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2614,7 +2614,7 @@ int vhost_get_vq_desc_batch(struct vhost_virtqueue *vq,
 err_fetch:
 	vq->ndescs = 0;
 
-	return ret;
+	return ret ? ret : vq->num;
 }
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc_batch);
 
-- 
MST
