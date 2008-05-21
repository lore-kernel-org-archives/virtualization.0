From: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 3/5] xen pvfb: Module aliases to support module autoloading
Date: Wed, 21 May 2008 10:40:18 +0200
Message-ID: <873aocm4nh.fsf__15055.3475636572$1211359457$gmane$org@pike.pond.sub.org>
References: <87d4ngm4s4.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, dmitry.torokhov@gmail.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, Pat Campbell <plc@novell.com>, linux-input@vger.kernel.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

These are mostly for completeness and consistency with the other
frontends, as PVFB is typically compiled in rather than a module.

Derived from
http://xenbits.xensource.com/linux-2.6.18-xen.hg?rev/5e294e29a43e

While there, add module descriptions.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 drivers/input/xen-kbdfront.c |    2 ++
 drivers/video/xen-fbfront.c  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/xen-kbdfront.c b/drivers/input/xen-kbdfront.c
index 9da4452..eaf69cf 100644
--- a/drivers/input/xen-kbdfront.c
+++ b/drivers/input/xen-kbdfront.c
@@ -343,4 +343,6 @@ static void __exit xenkbd_cleanup(void)
 module_init(xenkbd_init);
 module_exit(xenkbd_cleanup);
 
+MODULE_DESCRIPTION("Xen virtual keyboard/pointer device frontend");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("xen:vkbd");
diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index 4e10876..5553e51 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -572,4 +572,6 @@ static void __exit xenfb_cleanup(void)
 module_init(xenfb_init);
 module_exit(xenfb_cleanup);
 
+MODULE_DESCRIPTION("Xen virtual framebuffer device frontend");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("xen:vfb");
-- 
1.5.3.3
