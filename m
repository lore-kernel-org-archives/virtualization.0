From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] vhost: remove duplicated include from tcm_vhost.c
Date: Sun, 26 Aug 2012 09:42:08 +0800
Message-ID: <CAPgLHd-GRu8Dc3bxLL4ogjsE6gY=OS7n0H-5JFyMi_dy2OXP9g__25387.8312920735$1346779659$gmane$org@mail.gmail.com>
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
To: mst@redhat.com
Cc: netdev@vger.kernel.org, yongjun_wei@trendmicro.com.cn, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/vhost/tcm_vhost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index fb36654..587ca7e 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -45,7 +45,6 @@
 #include <target/target_core_fabric_configfs.h>
 #include <target/target_core_configfs.h>
 #include <target/configfs_macros.h>
-#include <linux/vhost.h>
 #include <linux/virtio_net.h> /* TODO vhost.h currently depends on this */
 #include <linux/virtio_scsi.h>
