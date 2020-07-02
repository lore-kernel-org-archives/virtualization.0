From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 17/22] rpmsg.txt: Add Documentation to configure rpmsg using configfs
Date: Thu, 2 Jul 2020 13:51:38 +0530
Message-ID: <20200702082143.25259-18-kishon@ti.com>
References: <20200702082143.25259-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200702082143.25259-1-kishon@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add Documentation on how rpmsg device can be created using
configfs required for vhost_rpmsg_bus.c

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/rpmsg.txt | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/rpmsg.txt b/Documentation/rpmsg.txt
index 24b7a9e1a5f9..0e0a32b2cb66 100644
--- a/Documentation/rpmsg.txt
+++ b/Documentation/rpmsg.txt
@@ -339,3 +339,59 @@ by the bus, and can then start sending messages to the remote service.
 
 The plan is also to add static creation of rpmsg channels via the virtio
 config space, but it's not implemented yet.
+
+Configuring rpmsg using configfs
+================================
+
+Usually a rpmsg_device is created when the virtproc driver (virtio_rpmsg_bus.c)
+receives a name service notification from the remote core. However there could
+also be cases where the user should be given the ability to create rpmsg_device
+(like in the case of vhost_rpmsg_bus.c) where vhost_rpmsg_bus should be
+responsible for sending name service notification. For such cases, configfs
+provides an ability to the user for binding a rpmsg_client_driver with virtproc
+device in order to create rpmsg_device.
+
+Two configfs directories are added for configuring rpmsg
+::
+
+  # ls /sys/kernel/config/rpmsg/
+    channel   virtproc
+
+channel: Whenever a new rpmsg_driver is registered with rpmsg core, a new
+sub-directory will be created for each entry provided in rpmsg_device_id
+table of rpmsg_driver.
+
+For instance when rpmsg_sample_client is installed, it'll create the following
+entry in the mounted configfs directory
+::
+
+  # ls /sys/kernel/config/rpmsg/channel/
+    rpmsg-client-sample
+
+virtproc: A virtproc device can choose to add an entry in this directory.
+Virtproc device adds an entry if it has to allow user to control creation of
+rpmsg device. (e.g vhost_rpmsg_bus.c)
+::
+
+  # ls /sys/kernel/config/rpmsg/virtproc/
+    vhost0
+
+
+The first step in allowing the user to create rpmsg device is to create a
+sub-directory rpmsg-client-sample. For each rpmsg_device, the user would like
+to create, a separate subdirectory has to be created.
+::
+
+  # mkdir /sys/kernel/config/rpmsg/channel/rpmsg-client-sample/c1
+
+The next step is to link the created sub-directory with virtproc device to
+create rpmsg device.
+::
+
+  # ln -s /sys/kernel/config/rpmsg/channel/rpmsg-client-sample/c1 \
+        /sys/kernel/config/rpmsg/virtproc/vhost0
+
+This will create rpmsg_device. However the driver will not register the
+rpmsg device until it receives the VIRTIO_CONFIG_S_DRIVER_OK (in the case
+of vhost_rpmsg_bus.c) as it can access virtio buffers only after
+VIRTIO_CONFIG_S_DRIVER_OK is set.
-- 
2.17.1
