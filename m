From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 2/2] staging: hv: Fix the WARN_ON condition in
	free_net_device()
Date: Fri, 18 Feb 2011 15:05:53 -0800
Message-ID: <1298070353-23534-2-git-send-email-haiyangz__40583.2581957386$1298069887$gmane$org@microsoft.com>
References: <1298070353-23534-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1298070353-23534-1-git-send-email-haiyangz@microsoft.com>
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

In a previous commit, 7a09876d, ASSERT was changed to WARN_ON, but
the condition wasn't updated. This patch fixed this error.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/netvsc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index f21a59d..20b1597 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -95,7 +95,7 @@ static struct netvsc_device *alloc_net_device(struct hv_device *device)
 
 static void free_net_device(struct netvsc_device *device)
 {
-	WARN_ON(atomic_read(&device->refcnt) == 0);
+	WARN_ON(atomic_read(&device->refcnt) != 0);
 	device->dev->ext = NULL;
 	kfree(device);
 }
-- 
1.6.3.2
