From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH] staging: hv: fix a memory leak in adj_guesttime()
Date: Tue, 26 Jul 2011 12:15:00 -0700
Message-ID: <1311707700-6640-1-git-send-email-haiyangz__45843.2785388597$1311706741$gmane$org@microsoft.com>
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
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, vir
List-Id: virtualization@lists.linuxfoundation.org

The allocated struct adj_time_work needs to be freed if we
are not using it.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

---
 drivers/staging/hv/hv_util.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
index d3fb017..4fc1c98 100644
--- a/drivers/staging/hv/hv_util.c
+++ b/drivers/staging/hv/hv_util.c
@@ -157,7 +157,10 @@ static inline void adj_guesttime(u64 hosttime, u8 flags)
 		scnt--;
 		INIT_WORK(&wrk->work, hv_set_host_time);
 		schedule_work(&wrk->work);
+		return;
 	}
+
+	kfree(wrk);
 }
 
 /*
-- 
1.6.3.2
