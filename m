From: Joe Perches <joe@perches.com>
Subject: [PATCH 13/35] drivers/char: Convert remaining use of pr_warning to
	pr_warn
Date: Thu, 16 Feb 2017 23:11:26 -0800
Message-ID: <12cea829f0c93182e8775e453e411a236d529b58.1487314667.git.joe__21333.1899991774$1487370727$gmane$org@perches.com>
References: <cover.1487314666.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

To enable eventual removal of pr_warning

This makes pr_warn use consistent for drivers/char

Prior to this patch, there were 1 use of pr_warning and
40 uses of pr_warn in drivers/char

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 17857beb4892..96002610b845 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2294,7 +2294,7 @@ static int __init init(void)
 
 	pdrvdata.debugfs_dir = debugfs_create_dir("virtio-ports", NULL);
 	if (!pdrvdata.debugfs_dir)
-		pr_warning("Error creating debugfs dir for virtio-ports\n");
+		pr_warn("Error creating debugfs dir for virtio-ports\n");
 	INIT_LIST_HEAD(&pdrvdata.consoles);
 	INIT_LIST_HEAD(&pdrvdata.portdevs);
 
-- 
2.10.0.rc2.1.g053435c
