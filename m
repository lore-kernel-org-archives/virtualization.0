From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 08/22] rpmsg: virtio_rpmsg_bus: Disable receive virtqueue callback when reading messages
Date: Thu, 2 Jul 2020 13:51:29 +0530
Message-ID: <20200702082143.25259-9-kishon@ti.com>
References: <20200702082143.25259-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200702082143.25259-1-kishon@ti.com>
Sender: kvm-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Since rpmsg_recv_done() reads messages in a while loop, disable
callbacks until the while loop exits. This helps to get rid of the
annoying "uhm, incoming signal, but no used buffer ?" message.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 376ebbf880d6..2d0d42084ac0 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -777,6 +777,7 @@ static void rpmsg_recv_done(struct virtqueue *rvq)
 		return;
 	}
 
+	virtqueue_disable_cb(rvq);
 	while (msg) {
 		err = rpmsg_recv_single(vrp, dev, msg, len);
 		if (err)
@@ -786,6 +787,19 @@ static void rpmsg_recv_done(struct virtqueue *rvq)
 
 		msg = virtqueue_get_buf(rvq, &len);
 	}
+	virtqueue_enable_cb(rvq);
+
+	/*
+	 * Try to read message one more time in case a new message is submitted
+	 * after virtqueue_get_buf() inside the while loop but before enabling
+	 * callbacks
+	 */
+	msg = virtqueue_get_buf(rvq, &len);
+	if (msg) {
+		err = rpmsg_recv_single(vrp, dev, msg, len);
+		if (!err)
+			msgs_received++;
+	}
 
 	dev_dbg(dev, "Received %u messages\n", msgs_received);
 
-- 
2.17.1
