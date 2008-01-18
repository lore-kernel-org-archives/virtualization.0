From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH] fix drivers/lguest Makefile entry
Date: Fri, 18 Jan 2008 00:16:43 -0200
Message-ID: <12006226032537-git-send-email-gcosta__23087.4864537784$1200622731$gmane$org@redhat.com>
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
To: lguest@ozlabs.org
Cc: linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It should depend on CONFIG_LGUEST, not CONFIG_LGUEST_GUEST

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index ee1b6a5..58a17e9 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -73,7 +73,7 @@ obj-$(CONFIG_ISDN)		+= isdn/
 obj-$(CONFIG_EDAC)		+= edac/
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
-obj-$(CONFIG_LGUEST_GUEST)	+= lguest/
+obj-$(CONFIG_LGUEST)		+= lguest/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
 obj-$(CONFIG_MMC)		+= mmc/
-- 
1.5.0.6
