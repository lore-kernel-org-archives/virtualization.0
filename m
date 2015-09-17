From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] virtio: fix memory leak of virtio ida cache layers
Date: Wed, 16 Sep 2015 19:29:17 -0500
Message-ID: <1442449758-14594-2-git-send-email-s-anna__34385.8701213778$1442449800$gmane$org@ti.com>
References: <1442449758-14594-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1442449758-14594-1-git-send-email-s-anna@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Suman Anna <s-anna@ti.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The virtio core uses a static ida named virtio_index_ida for
assigning index numbers to virtio devices during registration.
The ida core may allocate some internal idr cache layers and
an ida bitmap upon any ida allocation, and all these layers are
truely freed only upon the ida destruction. The virtio_index_ida
is not destroyed at present, leading to a memory leak when using
the virtio core as a module and atleast one virtio device is
registered and unregistered.

Fix this by invoking ida_destroy() in the virtio core module
exit.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b1877d73fa56..7062bb0975a5 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -412,6 +412,7 @@ static int virtio_init(void)
 static void __exit virtio_exit(void)
 {
 	bus_unregister(&virtio_bus);
+	ida_destroy(&virtio_index_ida);
 }
 core_initcall(virtio_init);
 module_exit(virtio_exit);
-- 
2.5.0
