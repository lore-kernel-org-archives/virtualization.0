From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2] virtio: console: cleanup an error message
Date: Mon, 22 Jul 2013 23:41:00 +0300
Message-ID: <20130722204100.GB22020@elgon.mountain>
References: <201307191228.41794.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201307191228.41794.arnd@arndb.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The PTR_ERR(NULL) here is not useful.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: completely different

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1b456fe..4cf46d8 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2215,10 +2215,8 @@ static int __init init(void)
 	}
 
 	pdrvdata.debugfs_dir = debugfs_create_dir("virtio-ports", NULL);
-	if (!pdrvdata.debugfs_dir) {
-		pr_warning("Error %ld creating debugfs dir for virtio-ports\n",
-			   PTR_ERR(pdrvdata.debugfs_dir));
-	}
+	if (!pdrvdata.debugfs_dir)
+		pr_warning("Error creating debugfs dir for virtio-ports\n");
 	INIT_LIST_HEAD(&pdrvdata.consoles);
 	INIT_LIST_HEAD(&pdrvdata.portdevs);
