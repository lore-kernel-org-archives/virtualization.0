From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] xen/x86: remove duplicated include from enlighten.c
Date: Thu, 1 Nov 2012 16:17:59 +0800
Message-ID: <CAPgLHd_4Ehr62ifhr0wSTqp=xa9EmtO1RW4AVtfUtRR4Cui-+A@mail.gmail.com>
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
To: konrad.wilk@oracle.com, jeremy@goop.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, mukesh.rathor@oracle.com
Cc: linux-kernel@vger.kernel.org, yongjun_wei@trendmicro.com.cn, x86@kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/x86/xen/enlighten.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index eb9a567..4c694a7 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -45,7 +45,6 @@
 #include <xen/hvm.h>
 #include <xen/hvc-console.h>
 #include <xen/acpi.h>
-#include <xen/features.h>
 
 #include <asm/paravirt.h>
 #include <asm/apic.h>
