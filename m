From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH 4/8] vhost: Fix bad order in vhost_test_set_backend at enable
Date: Fri,  3 Apr 2020 18:51:15 +0200
Message-ID: <20200403165119.5030-5-eperezma@redhat.com>
References: <20200403165119.5030-1-eperezma@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403165119.5030-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Fixes: ("7c48601a3d4d tools/virtio: Add --reset=random")
---
 drivers/vhost/test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 789c096e454b..6aed0cab8b17 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -293,8 +293,8 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
 		backend = vhost_vq_get_backend(vq);
 		vhost_vq_set_backend(vq, NULL);
 	} else {
-		r = vhost_vq_init_access(vq);
 		vhost_vq_set_backend(vq, backend);
+		r = vhost_vq_init_access(vq);
 		if (r == 0)
 			r = vhost_poll_start(&vq->poll, vq->kick);
 	}
-- 
2.18.1
