From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/2] virtio: console: Don't call device_destroy() on port
	device
Date: Wed,  2 Mar 2011 13:53:08 +0530
Message-ID: <5e342b496e09358d09b2101e5f68067af918da68.1299054025.git.amit.shah__45156.8279685036$1299054278$gmane$org@redhat.com>
References: <cover.1299054025.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1299054025.git.amit.shah@redhat.com>
In-Reply-To: <cover.1299054025.git.amit.shah@redhat.com>
References: <cover.1299054025.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, stable@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This results in a warning mentioning the region being removed is already
gone.

CC: stable@kernel.org
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 84b164d..5ac9fd9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1244,7 +1244,7 @@ static void remove_port(struct kref *kref)
 	port = container_of(kref, struct port, kref);
 
 	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
-	device_destroy(pdrvdata.class, port->dev->devt);
+
 	cdev_del(port->cdev);
 
 	kfree(port->name);
-- 
1.7.4
