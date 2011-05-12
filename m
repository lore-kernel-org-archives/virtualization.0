From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH] x86, paravirt: Avoid unused by set variables in rdmsr
Date: Thu, 12 May 2011 14:08:03 -0300
Message-ID: <1305220083-22620-1-git-send-email-lucas.demarchi__3187.0624320165$1305238071$gmane$org@profusion.mobi>
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
To: Andi Kleen <andi@firstfloor.org>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Just like 5f755293 (x86, gcc-4.6: Avoid unused by set variables in
rdmsr) this patch silences GCC warnings about "set but not used
variables" in paravirt.h.

Signed-off-by: Lucas De Marchi <lucas.demarchi@profusion.mobi>
---
 arch/x86/include/asm/paravirt.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index ebbc4d8..1e02d57 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -147,8 +147,8 @@ static inline int paravirt_wrmsr_regs(u32 *regs)
 do {						\
 	int _err;				\
 	u64 _l = paravirt_read_msr(msr, &_err);	\
-	val1 = (u32)_l;				\
-	val2 = _l >> 32;			\
+	(void)((val1) = (u32)_l);		\
+	(void)((val2) = (u32)(_l >> 32));	\
 } while (0)
 
 #define wrmsr(msr, val1, val2)			\
-- 
1.7.5.1
