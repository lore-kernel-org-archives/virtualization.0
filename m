From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH 1/8] tools/virtio: fix virtio_test.c indentation
Date: Fri,  3 Apr 2020 18:51:12 +0200
Message-ID: <20200403165119.5030-2-eperezma@redhat.com>
References: <20200403165119.5030-1-eperezma@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403165119.5030-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

---
 tools/virtio/virtio_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 93d81cd64ba0..38aa5316b266 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -222,7 +222,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 					  &backend);
 				assert(!r);
 
-                                while (completed > next_reset)
+				while (completed > next_reset)
 					next_reset += completed;
 			}
 		} while (r == 0);
-- 
2.18.1
