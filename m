From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 1/1] staging: hv: Fix missing functions for net_device_ops
	(submit again)
Date: Tue, 3 Aug 2010 18:25:53 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF728380C30F__35827.866374939$1280862070$gmane$org@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualiz>
List-Id: virtualization@lists.linuxfoundation.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Fix missing functions for net_device_ops.
Unlike in older kernels, ether_setup() no longer sets default
functions. We need to put them into net_device_ops. For example,
eth_change_mtu prevents setting MTU beyond 1500. This is necessary
because we don't support jumbo frame at this time.
It affects kernel 2.6.32 and later, which are all versions
containing Hyper-V drivers.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/netvsc_drv.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 56e1157..64a0114 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -327,6 +327,9 @@ static const struct net_device_ops device_ops = {
 	.ndo_stop =			netvsc_close,
 	.ndo_start_xmit =		netvsc_start_xmit,
 	.ndo_set_multicast_list =	netvsc_set_multicast_list,
+	.ndo_change_mtu =		eth_change_mtu,
+	.ndo_validate_addr =		eth_validate_addr,
+	.ndo_set_mac_address =		eth_mac_addr,
 };
 
 static int netvsc_probe(struct device *device)
-- 
1.6.3.2
