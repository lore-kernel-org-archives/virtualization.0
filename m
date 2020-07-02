From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 10/22] rpmsg: virtio_rpmsg_bus: Add Address Service Notification support
Date: Thu, 2 Jul 2020 13:51:31 +0530
Message-ID: <20200702082143.25259-11-kishon@ti.com>
References: <20200702082143.25259-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200702082143.25259-1-kishon@ti.com>
Sender: kvm-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add support to send address service notification message to the backend
rpmsg device. This informs the backend rpmsg device about the address
allocated to the channel that is created in response to the name service
announce message from backend rpmsg device. This is in preparation to
add backend rpmsg device using VHOST framework in Linux.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 92 +++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 7 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 2d0d42084ac0..19d930c9fc2c 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -71,6 +71,7 @@ struct virtproc_info {
 
 /* The feature bitmap for virtio rpmsg */
 #define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
+#define VIRTIO_RPMSG_F_AS	1 /* RP supports address service notifications */
 
 /**
  * struct rpmsg_hdr - common header for all rpmsg messages
@@ -110,6 +111,26 @@ struct rpmsg_ns_msg {
 	u32 flags;
 } __packed;
 
+/**
+ * struct rpmsg_as_msg - dynamic address service announcement message
+ * @name: name of the created channel
+ * @dst: destination address to be used by the backend rpdev
+ * @src: source address of the backend rpdev (the one that sent name service
+ * announcement message)
+ * @flags: indicates whether service is created or destroyed
+ *
+ * This message is sent (by virtio_rpmsg_bus) when a new channel is created
+ * in response to name service announcement message by backend rpdev to create
+ * a new channel. This sends the allocated source address for the channel
+ * (destination address for the backend rpdev) to the backend rpdev.
+ */
+struct rpmsg_as_msg {
+	char name[RPMSG_NAME_SIZE];
+	u32 dst;
+	u32 src;
+	u32 flags;
+} __packed;
+
 /**
  * enum rpmsg_ns_flags - dynamic name service announcement flags
  *
@@ -119,6 +140,19 @@ struct rpmsg_ns_msg {
 enum rpmsg_ns_flags {
 	RPMSG_NS_CREATE		= 0,
 	RPMSG_NS_DESTROY	= 1,
+	RPMSG_AS_ANNOUNCE	= 2,
+};
+
+/**
+ * enum rpmsg_as_flags - dynamic address service announcement flags
+ *
+ * @RPMSG_AS_ASSIGN: address has been assigned to the newly created channel
+ * @RPMSG_AS_FREE: assigned address is freed from the channel and no longer can
+ * be used
+ */
+enum rpmsg_as_flags {
+	RPMSG_AS_ASSIGN		= 1,
+	RPMSG_AS_FREE		= 2,
 };
 
 /**
@@ -164,6 +198,9 @@ struct virtio_rpmsg_channel {
 /* Address 53 is reserved for advertising remote services */
 #define RPMSG_NS_ADDR			(53)
 
+/* Address 54 is reserved for advertising address services */
+#define RPMSG_AS_ADDR			(54)
+
 static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept);
 static int virtio_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len);
 static int virtio_rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len,
@@ -329,9 +366,11 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
 	struct device *dev = &rpdev->dev;
 	int err = 0;
 
+	if (!rpdev->ept || !rpdev->announce)
+		return err;
+
 	/* need to tell remote processor's name service about this channel ? */
-	if (rpdev->announce && rpdev->ept &&
-	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
+	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
 		struct rpmsg_ns_msg nsm;
 
 		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
@@ -343,6 +382,23 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
 			dev_err(dev, "failed to announce service %d\n", err);
 	}
 
+	/*
+	 * need to tell remote processor's address service about the address allocated
+	 * to this channel
+	 */
+	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_AS)) {
+		struct rpmsg_as_msg asmsg;
+
+		strncpy(asmsg.name, rpdev->id.name, RPMSG_NAME_SIZE);
+		asmsg.dst = rpdev->src;
+		asmsg.src = rpdev->dst;
+		asmsg.flags = RPMSG_AS_ASSIGN;
+
+		err = rpmsg_sendto(rpdev->ept, &asmsg, sizeof(asmsg), RPMSG_AS_ADDR);
+		if (err)
+			dev_err(dev, "failed to announce service %d\n", err);
+	}
+
 	return err;
 }
 
@@ -353,9 +409,28 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 	struct device *dev = &rpdev->dev;
 	int err = 0;
 
+	if (!rpdev->ept || !rpdev->announce)
+		return err;
+
+	/*
+	 * need to tell remote processor's address service that we're freeing
+	 * the address allocated to this channel
+	 */
+	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_AS)) {
+		struct rpmsg_as_msg asmsg;
+
+		strncpy(asmsg.name, rpdev->id.name, RPMSG_NAME_SIZE);
+		asmsg.dst = rpdev->src;
+		asmsg.src = rpdev->dst;
+		asmsg.flags = RPMSG_AS_FREE;
+
+		err = rpmsg_sendto(rpdev->ept, &asmsg, sizeof(asmsg), RPMSG_AS_ADDR);
+		if (err)
+			dev_err(dev, "failed to announce service %d\n", err);
+	}
+
 	/* tell remote processor's name service we're removing this channel */
-	if (rpdev->announce && rpdev->ept &&
-	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
+	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
 		struct rpmsg_ns_msg nsm;
 
 		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
@@ -390,7 +465,8 @@ static void virtio_rpmsg_release_device(struct device *dev)
  * channels.
  */
 static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
-						 struct rpmsg_channel_info *chinfo)
+						 struct rpmsg_channel_info *chinfo,
+						 bool announce)
 {
 	struct virtio_rpmsg_channel *vch;
 	struct rpmsg_device *rpdev;
@@ -424,7 +500,8 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 	 * rpmsg server channels has predefined local address (for now),
 	 * and their existence needs to be announced remotely
 	 */
-	rpdev->announce = rpdev->src != RPMSG_ADDR_ANY;
+	if (rpdev->src != RPMSG_ADDR_ANY || announce)
+		rpdev->announce = true;
 
 	strncpy(rpdev->id.name, chinfo->name, RPMSG_NAME_SIZE);
 
@@ -873,7 +950,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 		if (ret)
 			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
 	} else {
-		newch = rpmsg_create_channel(vrp, &chinfo);
+		newch = rpmsg_create_channel(vrp, &chinfo, msg->flags & RPMSG_AS_ANNOUNCE);
 		if (!newch)
 			dev_err(dev, "rpmsg_create_channel failed\n");
 	}
@@ -1042,6 +1119,7 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_RPMSG_F_NS,
+	VIRTIO_RPMSG_F_AS,
 };
 
 static struct virtio_driver virtio_ipc_driver = {
-- 
2.17.1
