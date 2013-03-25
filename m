From: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Subject: [PATCH] drivers: virtio: Use PTR_RET function
Date: Mon, 25 Mar 2013 15:25:35 +0200
Message-ID: <1364217936-6284-1-git-send-email-gheorghiuandru__19284.9745661535$1364238520$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alexandru Gheorghiu <gheorghiuandru@gmail.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Used PTR_RET function instead of IS_ERR and PTR_ERR.
Patch found using coccinelle.

Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
---
 drivers/virtio/virtio_mmio.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 1ba0d68..d1e664f 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -567,10 +567,7 @@ static int vm_cmdline_set(const char *device,
 	pdev = platform_device_register_resndata(&vm_cmdline_parent,
 			"virtio-mmio", vm_cmdline_id++,
 			resources, ARRAY_SIZE(resources), NULL, 0);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	return 0;
+	return PTR_RET(pdev);
 }
 
 static int vm_cmdline_get_device(struct device *dev, void *data)
-- 
1.7.9.5
