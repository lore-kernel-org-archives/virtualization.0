From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH 3/8] vhost: Replace vq->private_data access by backend accesors
Date: Fri,  3 Apr 2020 18:51:14 +0200
Message-ID: <20200403165119.5030-4-eperezma@redhat.com>
References: <20200403165119.5030-1-eperezma@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403165119.5030-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

---
 drivers/vhost/test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 251ca723ac3f..789c096e454b 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -265,7 +265,7 @@ static int vhost_test_set_features(struct vhost_test *n, u64 features)
 
 static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
 {
-	static void *private_data;
+	static void *backend;
 
 	const bool enable = fd != -1;
 	struct vhost_virtqueue *vq;
@@ -290,11 +290,11 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
 	}
 	if (!enable) {
 		vhost_poll_stop(&vq->poll);
-		private_data = vq->private_data;
-		vq->private_data = NULL;
+		backend = vhost_vq_get_backend(vq);
+		vhost_vq_set_backend(vq, NULL);
 	} else {
 		r = vhost_vq_init_access(vq);
-		vq->private_data = private_data;
+		vhost_vq_set_backend(vq, backend);
 		if (r == 0)
 			r = vhost_poll_start(&vq->poll, vq->kick);
 	}
-- 
2.18.1
