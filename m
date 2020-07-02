From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 16/22] samples/rpmsg: Wait for address to be bound to rpdev for sending message
Date: Thu, 2 Jul 2020 13:51:37 +0530
Message-ID: <20200702082143.25259-17-kishon@ti.com>
References: <20200702082143.25259-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200702082143.25259-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

rpmsg_client_sample can use either virtio_rpmsg_bus or vhost_rpmsg_bus
to send messages. In the case of vhost_rpmsg_bus, the destination
address of rpdev will be assigned only after receiving address service
notification from the remote virtio_rpmsg_bus. Wait for address to be
bound to rpdev (rpmsg_client_sample running in vhost system) before
sending messages to the remote virtio_rpmsg_bus.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 samples/rpmsg/rpmsg_client_sample.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
index 514a51945d69..07149d7fbd0c 100644
--- a/samples/rpmsg/rpmsg_client_sample.c
+++ b/samples/rpmsg/rpmsg_client_sample.c
@@ -57,10 +57,14 @@ static void rpmsg_sample_send_msg_work(struct work_struct *work)
 	struct rpmsg_device *rpdev = idata->rpdev;
 	int ret;
 
-	/* send a message to our remote processor */
-	ret = rpmsg_send(rpdev->ept, MSG, strlen(MSG));
-	if (ret)
-		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+	if (rpdev->dst != RPMSG_ADDR_ANY) {
+		/* send a message to our remote processor */
+		ret = rpmsg_send(rpdev->ept, MSG, strlen(MSG));
+		if (ret)
+			dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+	} else {
+		schedule_delayed_work(&idata->send_msg_work, msecs_to_jiffies(50));
+	}
 }
 
 static int rpmsg_sample_probe(struct rpmsg_device *rpdev)
-- 
2.17.1
