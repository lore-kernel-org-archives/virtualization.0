From: Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH] x86: Remove unnecessary return from void function
Date: Fri, 23 Jun 2017 19:23:13 +0300
Message-ID: <1498234993-1320-1-git-send-email-vasilyev__22905.6985852823$1509078593$gmane$org@ispras.ru>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: ldv-project@linuxtesting.org, x86@kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Alok Kataria <akataria@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, Anton Vasilyev <vasilyev@ispras.ru>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

The patch removes unnecessary return from void function.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 arch/x86/include/asm/paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 55fa56f..a3dcf89 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -118,7 +118,7 @@ static inline u64 paravirt_read_msr(unsigned msr)
 static inline void paravirt_write_msr(unsigned msr,
 				      unsigned low, unsigned high)
 {
-	return PVOP_VCALL3(pv_cpu_ops.write_msr, msr, low, high);
+	PVOP_VCALL3(pv_cpu_ops.write_msr, msr, low, high);
 }
 
 static inline u64 paravirt_read_msr_safe(unsigned msr, int *err)
-- 
2.7.4
