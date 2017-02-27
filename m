From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [linux-next] x86/vmware: Remove duplicate inclusion of
	asm/timer.h
Date: Mon, 27 Feb 2017 21:29:22 +0900
Message-ID: <20170227122922.26230-1-standby24x7__1409.31945429674$1488675776$gmane$org@gmail.com>
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
To: akataria@vmware.com, tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch remove duplicate asm/timer.h in vmware.c
Confirm successfully compile after remove the line.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/x86/kernel/cpu/vmware.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 891f4dad7b2c..22403a28caf5 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -30,7 +30,6 @@
 #include <asm/hypervisor.h>
 #include <asm/timer.h>
 #include <asm/apic.h>
-#include <asm/timer.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
-- 
2.12.0
