From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] remoteproc: fix memory leak of remoteproc ida cache layers
Date: Wed, 16 Sep 2015 19:29:18 -0500
Message-ID: <1442449758-14594-3-git-send-email-s-anna@ti.com>
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

The remoteproc core uses a static ida named rproc_dev_index for
assigning an automatic index number to a registered remoteproc.
The ida core may allocate some internal idr cache layers and ida
bitmap upon any ida allocation, and all these layers are truely
freed only upon the ida destruction. The rproc_dev_index ida is
not destroyed at present, leading to a memory leak when using the
remoteproc core as a module and atleast one rproc device is
registered and unregistered.

Fix this by invoking ida_destroy() in the remoteproc core module
exit.

Cc: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/remoteproc_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8b3130f22b42..9e03d158f411 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1478,6 +1478,8 @@ module_init(remoteproc_init);
 
 static void __exit remoteproc_exit(void)
 {
+	ida_destroy(&rproc_dev_index);
+
 	rproc_exit_debugfs();
 }
 module_exit(remoteproc_exit);
-- 
2.5.0
