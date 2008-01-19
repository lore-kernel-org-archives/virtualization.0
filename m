From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 2/6] explicitly use hrtimer.h include
Date: Fri, 18 Jan 2008 23:59:06 -0200
Message-ID: <12007079613080-git-send-email-gcosta__11259.5228864395$1200708310$gmane$org@redhat.com>
References: <1200707950911-git-send-email-gcosta@redhat.com>
	<12007079562927-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12007079562927-git-send-email-gcosta@redhat.com>
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

This patch adds the hrtimer.h header explicitly to lg.h file,
and avoid depending on it being included somewhere else.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/lguest/lg.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
index f9707cf..eb51fc2 100644
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -8,6 +8,7 @@
 #include <linux/lguest.h>
 #include <linux/lguest_launcher.h>
 #include <linux/wait.h>
+#include <linux/hrtimer.h>
 #include <linux/err.h>
 #include <asm/semaphore.h>
 
-- 
1.5.0.6
