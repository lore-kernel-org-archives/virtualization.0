From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 15/22] samples/rpmsg: Setup delayed work to send message
Date: Thu, 2 Jul 2020 13:51:36 +0530
Message-ID: <20200702082143.25259-16-kishon@ti.com>
References: <20200702082143.25259-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200702082143.25259-1-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Let us not send any message to the remote processor before
announce_create() callback has been invoked. Since announce_create() is
only invoked after ->probe() is completed, setup delayed work to start
sending message to the remote processor.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 samples/rpmsg/rpmsg_client_sample.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
index ae5081662283..514a51945d69 100644
--- a/samples/rpmsg/rpmsg_client_sample.c
+++ b/samples/rpmsg/rpmsg_client_sample.c
@@ -20,6 +20,8 @@ module_param(count, int, 0644);
 
 struct instance_data {
 	int rx_count;
+	struct delayed_work send_msg_work;
+	struct rpmsg_device *rpdev;
 };
 
 static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
@@ -48,9 +50,21 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
 	return 0;
 }
 
-static int rpmsg_sample_probe(struct rpmsg_device *rpdev)
+static void rpmsg_sample_send_msg_work(struct work_struct *work)
 {
+	struct instance_data *idata = container_of(work, struct instance_data,
+						   send_msg_work.work);
+	struct rpmsg_device *rpdev = idata->rpdev;
 	int ret;
+
+	/* send a message to our remote processor */
+	ret = rpmsg_send(rpdev->ept, MSG, strlen(MSG));
+	if (ret)
+		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+}
+
+static int rpmsg_sample_probe(struct rpmsg_device *rpdev)
+{
 	struct instance_data *idata;
 
 	dev_info(&rpdev->dev, "new channel: 0x%x -> 0x%x!\n",
@@ -62,18 +76,18 @@ static int rpmsg_sample_probe(struct rpmsg_device *rpdev)
 
 	dev_set_drvdata(&rpdev->dev, idata);
 
-	/* send a message to our remote processor */
-	ret = rpmsg_send(rpdev->ept, MSG, strlen(MSG));
-	if (ret) {
-		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
-		return ret;
-	}
+	idata->rpdev = rpdev;
+	INIT_DELAYED_WORK(&idata->send_msg_work, rpmsg_sample_send_msg_work);
+	schedule_delayed_work(&idata->send_msg_work, msecs_to_jiffies(500));
 
 	return 0;
 }
 
 static void rpmsg_sample_remove(struct rpmsg_device *rpdev)
 {
+	struct instance_data *idata = dev_get_drvdata(&rpdev->dev);
+
+	cancel_delayed_work_sync(&idata->send_msg_work);
 	dev_info(&rpdev->dev, "rpmsg sample client driver is removed\n");
 }
 
-- 
2.17.1
