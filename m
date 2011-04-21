From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 7/8] staging: hv: clean up unused forward declarations
Date: Thu, 21 Apr 2011 12:30:46 -0700
Message-ID: <1303414247-22118-8-git-send-email-haiyangz__8370.29684703357$1303415549$gmane$org@microsoft.com>
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
 drivers/staging/hv/netvsc.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 1c3bdda..5838ed4 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -45,18 +45,6 @@ static const struct hv_guid netvsc_device_type = {
 	}
 };
 
-static int netvsc_init_send_buf(struct hv_device *device);
-
-static int netvsc_init_recv_buf(struct hv_device *device);
-
-static int netvsc_connect_vsp(struct hv_device *device);
-
-static void netvsc_send_completion(struct hv_device *device,
-				   struct vmpacket_descriptor *packet);
-
-static void netvsc_receive(struct hv_device *device,
-			    struct vmpacket_descriptor *packet);
-
 
 static struct netvsc_device *alloc_net_device(struct hv_device *device)
 {
-- 
1.6.3.2
