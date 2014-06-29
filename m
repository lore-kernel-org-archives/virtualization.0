From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] virtio: console: remove unnecessary null test before
	debugfs_remove_recursive
Date: Sun, 29 Jun 2014 10:41:33 +0200
Message-ID: <1404031293-5678-1-git-send-email-fabf__47188.4510167458$1404408048$gmane$org@skynet.be>
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
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Amit Shah <amit.shah@redhat.com>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Fix checkpatch warning:
WARNING: debugfs_remove_recursive(NULL) is safe this check is probably not required

Cc: Amit Shah <amit.shah@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/char/virtio_console.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 60aafb8..b585b47 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2262,8 +2262,7 @@ static int __init init(void)
 unregister:
 	unregister_virtio_driver(&virtio_console);
 free:
-	if (pdrvdata.debugfs_dir)
-		debugfs_remove_recursive(pdrvdata.debugfs_dir);
+	debugfs_remove_recursive(pdrvdata.debugfs_dir);
 	class_destroy(pdrvdata.class);
 	return err;
 }
@@ -2276,8 +2275,7 @@ static void __exit fini(void)
 	unregister_virtio_driver(&virtio_rproc_serial);
 
 	class_destroy(pdrvdata.class);
-	if (pdrvdata.debugfs_dir)
-		debugfs_remove_recursive(pdrvdata.debugfs_dir);
+	debugfs_remove_recursive(pdrvdata.debugfs_dir);
 }
 module_init(init);
 module_exit(fini);
-- 
1.8.4.5
