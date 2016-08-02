From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0992/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:06:07 +0800
Message-ID: <20160802120607.16209-1-baolex.ni__12876.1031352498$1470143438$gmane$org@intel.com>
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
To: mst@redhat.com, gregkh@linuxfoundation.org, m.chehab@samsung.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: mathias.nyman@linux.intel.com, kvm@vger.kernel.org, netdev@vger.kernel.org, oneukum@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, baolex.ni@intel.com, stern@rowland.harvard.edu, chuansheng.liu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 669fef1..bf338d1 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -31,7 +31,7 @@
 #include "vhost.h"
 
 static ushort max_mem_regions = 64;
-module_param(max_mem_regions, ushort, 0444);
+module_param(max_mem_regions, ushort, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(max_mem_regions,
 	"Maximum number of memory regions in memory map. (default: 64)");
 
-- 
2.9.2
