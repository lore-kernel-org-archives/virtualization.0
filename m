From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 1/1] Staging: hv: Fix a bug affecting IPv6
Date: Mon, 19 Apr 2010 15:32:11 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF7266281C0D@TK5EX14MBXC121.redmond.corp.microsoft.com>
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
To: Greg KH <gregkh@suse.de>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, virtualiz
Cc: Toshikazu Sakai <Toshikazu.Sakai@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Fix a bug affecting IPv6
 Added the multicast flag for proper IPv6 function.
 Credits go to Toshikazu Sakai <toshikas@microsoft.com>

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Toshikazu Sakai <toshikas@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

---
 drivers/staging/hv/RndisFilter.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/RndisFilter.c b/drivers/staging/hv/RndisFilter.c
index cd2930d..6704f64 100644
--- a/drivers/staging/hv/RndisFilter.c
+++ b/drivers/staging/hv/RndisFilter.c
@@ -751,6 +751,7 @@ static int RndisFilterOpenDevice(struct rndis_device *Device)
 
 	ret = RndisFilterSetPacketFilter(Device,
 					 NDIS_PACKET_TYPE_BROADCAST |
+					 NDIS_PACKET_TYPE_ALL_MULTICAST |
 					 NDIS_PACKET_TYPE_DIRECTED);
 	if (ret == 0)
 		Device->State = RNDIS_DEV_DATAINITIALIZED;
-- 
1.6.3.2
