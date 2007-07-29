From: Gabriel C <nix.or.die@googlemail.com>
Subject: [PATCH] BLOCK=n , LGUEST=m/y compile error
Date: Sun, 29 Jul 2007 17:18:23 +0200
Message-ID: <46ACAFBF.6060609@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

Lguest should depend on BLOCK too , without BLOCK set I get this error:

...

drivers/block/lguest_blk.c: In function 'end_entire_request':
drivers/block/lguest_blk.c:80: error: implicit declaration of function 'end_that_request_first'
drivers/block/lguest_blk.c:80: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:82: error: implicit declaration of function 'add_disk_randomness'
drivers/block/lguest_blk.c:82: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:83: error: implicit declaration of function 'blkdev_dequeue_request'
drivers/block/lguest_blk.c:84: error: implicit declaration of function 'end_that_request_last'
drivers/block/lguest_blk.c: In function 'lgb_irq':
drivers/block/lguest_blk.c:128: error: implicit declaration of function 'blk_start_queue'
drivers/block/lguest_blk.c:128: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c: In function 'req_to_dma':
drivers/block/lguest_blk.c:148: error: implicit declaration of function 'rq_for_each_bio'
drivers/block/lguest_blk.c:148: error: expected ';' before '{' token
drivers/block/lguest_blk.c:145: warning: unused variable 'idx'
drivers/block/lguest_blk.c:145: warning: unused variable 'i'
drivers/block/lguest_blk.c: In function 'setup_req':
drivers/block/lguest_blk.c:185: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c: In function 'do_write':
drivers/block/lguest_blk.c:202: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c: In function 'do_read':
drivers/block/lguest_blk.c:215: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c: In function 'do_lgb_request':
drivers/block/lguest_blk.c:234: error: implicit declaration of function 'elv_next_request'
drivers/block/lguest_blk.c:234: warning: assignment makes pointer from integer without a cast
drivers/block/lguest_blk.c:239: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:246: error: implicit declaration of function 'blk_fs_request'
drivers/block/lguest_blk.c:247: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:248: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:253: error: implicit declaration of function 'rq_data_dir'
drivers/block/lguest_blk.c:260: error: implicit declaration of function 'blk_stop_queue'
drivers/block/lguest_blk.c: In function 'lguestblk_probe':
drivers/block/lguest_blk.c:304: error: implicit declaration of function 'register_blkdev'
drivers/block/lguest_blk.c:313: error: implicit declaration of function 'alloc_disk'
drivers/block/lguest_blk.c:313: warning: assignment makes pointer from integer without a cast
drivers/block/lguest_blk.c:322: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:322: error: implicit declaration of function 'blk_init_queue'
drivers/block/lguest_blk.c:323: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:335: error: implicit declaration of function 'blk_queue_max_hw_segments'
drivers/block/lguest_blk.c:335: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:341: error: implicit declaration of function 'blk_queue_segment_boundary'
drivers/block/lguest_blk.c:341: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:349: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:360: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:373: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:374: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:375: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:376: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:378: error: implicit declaration of function 'set_capacity'
drivers/block/lguest_blk.c:379: error: implicit declaration of function 'add_disk'
drivers/block/lguest_blk.c:382: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:392: error: implicit declaration of function 'blk_cleanup_queue'
drivers/block/lguest_blk.c:392: error: dereferencing pointer to incomplete type
drivers/block/lguest_blk.c:394: error: implicit declaration of function 'put_disk'
drivers/block/lguest_blk.c:396: error: implicit declaration of function 'unregister_blkdev'
make[2]: *** [drivers/block/lguest_blk.o] Error 1
make[1]: *** [drivers/block] Error 2

....

Signed-off-by: Gabriel Craciunescu <nix.or.die@googlemail.com>

---

 Documentation/lguest/lguest.txt |    1 +
 drivers/lguest/Kconfig          |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/lguest/lguest.txt b/Documentation/lguest/lguest.txt
index 821617b..4e7408c 100644
--- a/Documentation/lguest/lguest.txt
+++ b/Documentation/lguest/lguest.txt
@@ -33,6 +33,7 @@ Running Lguest:
   CONFIG_EXPERIMENTAL=y ("Prompt for development and/or incomplete code/drivers")
   CONFIG_PARAVIRT=y ("Paravirtualization support (EXPERIMENTAL)")
   CONFIG_LGUEST=y/m ("Linux hypervisor example code")
+  CONFIG_BLOCK=y  ("Enable the block layer")
 
   and I recommend:
   CONFIG_HZ=100 ("Timer frequency")[2]
diff --git a/drivers/lguest/Kconfig b/drivers/lguest/Kconfig
index 43d901f..4bc0577 100644
--- a/drivers/lguest/Kconfig
+++ b/drivers/lguest/Kconfig
@@ -1,6 +1,6 @@
 config LGUEST
 	tristate "Linux hypervisor example code"
-	depends on X86 && PARAVIRT && NET && EXPERIMENTAL && !X86_PAE
+	depends on X86 && PARAVIRT && NET && EXPERIMENTAL && BLOCK && !X86_PAE
 	select LGUEST_GUEST
 	select HVC_DRIVER
 	---help---
