From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 11/11] x86/paravirt: remove unneeded mmu related paravirt
	ops bits
Date: Mon, 13 Aug 2018 09:37:39 +0200
Message-ID: <20180813073739.26108-12-jgross__15110.8146681965$1534147036$gmane$org@suse.com>
References: <20180813073739.26108-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180813073739.26108-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, peterz@infradead.org, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

There is no need to have 32-bit code for CONFIG_PGTABLE_LEVELS >= 4.
Remove it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4ceb3708fe06..0499f17ca480 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -501,25 +501,14 @@ static inline pud_t __pud(pudval_t val)
 {
 	pudval_t ret;
 
-	if (sizeof(pudval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pudval_t, mmu.make_pud, val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pudval_t, mmu.make_pud, val);
+	ret = PVOP_CALLEE1(pudval_t, mmu.make_pud, val);
 
 	return (pud_t) { ret };
 }
 
 static inline pudval_t pud_val(pud_t pud)
 {
-	pudval_t ret;
-
-	if (sizeof(pudval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pudval_t, mmu.pud_val,
-				    pud.pud, (u64)pud.pud >> 32);
-	else
-		ret =  PVOP_CALLEE1(pudval_t, mmu.pud_val, pud.pud);
-
-	return ret;
+	return PVOP_CALLEE1(pudval_t, mmu.pud_val, pud.pud);
 }
 
 static inline void pud_clear(pud_t *pudp)
@@ -531,10 +520,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	p4dval_t val = native_p4d_val(p4d);
 
-	if (sizeof(p4dval_t) > sizeof(long))
-		PVOP_VCALL3(mmu.set_p4d, p4dp, val, (u64)val >> 32);
-	else
-		PVOP_VCALL2(mmu.set_p4d, p4dp, val);
+	PVOP_VCALL2(mmu.set_p4d, p4dp, val);
 }
 
 #if CONFIG_PGTABLE_LEVELS >= 5
-- 
2.13.7
