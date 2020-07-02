From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 22/22] NTB: Describe ntb_virtio and ntb_vhost client in the documentation
Date: Thu, 2 Jul 2020 13:51:43 +0530
Message-ID: <20200702082143.25259-23-kishon@ti.com>
References: <20200702082143.25259-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200702082143.25259-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add a blurb in Documentation/ntb.txt to describe the ntb_virtio and
ntb_vhost client

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/driver-api/ntb.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/driver-api/ntb.rst b/Documentation/driver-api/ntb.rst
index 87d1372da879..f84b81625397 100644
--- a/Documentation/driver-api/ntb.rst
+++ b/Documentation/driver-api/ntb.rst
@@ -227,6 +227,17 @@ test client is interacted with through the debugfs filesystem:
 	specified peer. That peer's interrupt's occurrence file
 	should be incremented.
 
+NTB Vhost Client (ntb\_vhost) and NTB Virtio Client (ntb\_virtio)
+------------------------------------------------------------------
+
+When two hosts are connected via NTB, one of the hosts should use NTB Vhost
+Client and the other host should use NTB Virtio Client. The NTB Vhost client
+interfaces with the Linux Vhost Framework and lets it to be used with any
+vhost client driver. The NTB Virtio client interfaces with the Linux Virtio
+Framework and lets it to be used with any virtio client driver. The Vhost
+client driver and Virtio client driver creates a logic cink to exchange data
+with each other.
+
 NTB Hardware Drivers
 ====================
 
-- 
2.17.1
