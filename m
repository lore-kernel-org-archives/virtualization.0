From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 3/8] Staging: hv: tools: Fix a checkpatch warning in
	hv_kvp_daemon.c
Date: Tue, 19 Jul 2011 11:44:20 -0700
Message-ID: <1311101065-23417-3-git-send-email-kys@microsoft.com>
References: <1311101018-23370-1-git-send-email-kys@microsoft.com>
	<1311101065-23417-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1311101065-23417-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix a checkpatch warning in hv_kvp_daemon.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/tools/hv_kvp_daemon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/tools/hv_kvp_daemon.c b/drivers/staging/hv/tools/hv_kvp_daemon.c
index 33f0f1c..c230bae 100644
--- a/drivers/staging/hv/tools/hv_kvp_daemon.c
+++ b/drivers/staging/hv/tools/hv_kvp_daemon.c
@@ -117,7 +117,7 @@ void kvp_get_os_info(void)
 
 	uname(&uts_buf);
 	os_build = uts_buf.release;
-	processor_arch= uts_buf.machine;
+	processor_arch = uts_buf.machine;
 
 	file = fopen("/etc/SuSE-release", "r");
 	if (file != NULL)
-- 
1.7.4.1
