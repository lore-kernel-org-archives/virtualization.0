From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v2 11/11] virtio: console: prevent use-after-free of port name
	in port unplug
Date: Fri, 19 Jul 2013 16:52:04 +0530
Message-ID: <dbb4d1603f66de692d9af3c2afe1b464294d622d.1374232738.git.amit.shah__31881.4826351174$1374233022$gmane$org@redhat.com>
References: <cover.1374232738.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1374232738.git.amit.shah@redhat.com>
In-Reply-To: <cover.1374232738.git.amit.shah@redhat.com>
References: <cover.1374232738.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Remove the debugfs path before freeing port->name, to prevent a possible
use-after-free.

CC: <stable@vger.kernel.org>
Reported-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 89ef748..f18e960 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1578,9 +1578,8 @@ static void unplug_port(struct port *port)
 	device_destroy(pdrvdata.class, port->dev->devt);
 	cdev_del(port->cdev);
 
-	kfree(port->name);
-
 	debugfs_remove(port->debugfs_file);
+	kfree(port->name);
 
 	/*
 	 * Locks around here are not necessary - a port can't be
-- 
1.8.1.4
