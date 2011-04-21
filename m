From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 8/8] staging: hv: convert function name
	NetVscDisconnectFromVsp to lower case
Date: Thu, 21 Apr 2011 12:30:47 -0700
Message-ID: <1303414247-22118-9-git-send-email-haiyangz__43607.3581492112$1303415667$gmane$org@microsoft.com>
References: <1303414247-22118-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1303414247-22118-1-git-send-email-haiyangz@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, vir
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 5838ed4..b3e6497 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -571,7 +571,7 @@ cleanup:
 	return ret;
 }
 
-static void NetVscDisconnectFromVsp(struct netvsc_device *net_device)
+static void netvsc_disconnect_vsp(struct netvsc_device *net_device)
 {
 	netvsc_destroy_recv_buf(net_device);
 	netvsc_destroy_send_buf(net_device);
@@ -600,7 +600,7 @@ static int netvsc_device_remove(struct hv_device *device)
 		udelay(100);
 	}
 
-	NetVscDisconnectFromVsp(net_device);
+	netvsc_disconnect_vsp(net_device);
 
 	/* Stop inbound traffic ie receives and sends completions */
 	net_device = release_inbound_net_device(device);
-- 
1.6.3.2
