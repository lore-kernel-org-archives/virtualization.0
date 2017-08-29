From: Yang Zhang <yang.zhang.wz@gmail.com>
Subject: [RFC PATCH v2 4/7] x86/paravirt: Add update in x86/paravirt
	pv_idle_ops
Date: Tue, 29 Aug 2017 11:46:38 +0000
Message-ID: <1504007201-12904-5-git-send-email-yang.zhang.wz__4270.2249870219$1504007285$gmane$org@gmail.com>
References: <1504007201-12904-1-git-send-email-yang.zhang.wz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1504007201-12904-1-git-send-email-yang.zhang.wz@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Jeremy Fitzhardinge <jeremy@goop.org>, kvm@vger.kernel.org, rkrcmar@redhat.com, peterz@infradead.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, wanpeng.li@hotmail.com, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Chris Wright <chrisw@sous-sol.org>, Andy Lutomirski <luto@kernel.org>, dmatlack@google.com, tglx@linutronix.de, Quan Xu <quan.xu0@gmail.com>, linux-doc@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

.update is used to adjust the next poll time.

Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
Signed-off-by: Quan Xu <quan.xu0@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/paravirt.h       | 5 +++++
 arch/x86/include/asm/paravirt_types.h | 1 +
 arch/x86/kernel/paravirt.c            | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 6d46760..32e1c06 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -207,6 +207,11 @@ static inline void paravirt_idle_poll(void)
 	PVOP_VCALL0(pv_idle_ops.poll);
 }
 
+static inline void paravirt_idle_update_poll_duration(unsigned long duration)
+{
+	PVOP_VCALL1(pv_idle_ops.update, duration);
+}
+
 static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
 {
 	PVOP_VCALL2(pv_cpu_ops.alloc_ldt, ldt, entries);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index cf45726..3b4f95a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -326,6 +326,7 @@ struct pv_lock_ops {
 
 struct pv_idle_ops {
 	void (*poll)(void);
+	void (*update)(unsigned long);
 } __no_randomize_layout;
 
 /* This contains all the paravirt structures: we get a convenient
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1b5b247..a11b2c2 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -315,6 +315,7 @@ struct pv_time_ops pv_time_ops = {
 
 struct pv_idle_ops pv_idle_ops = {
 	.poll = paravirt_nop,
+	.update = paravirt_nop,
 };
 
 __visible struct pv_irq_ops pv_irq_ops = {
-- 
1.8.3.1
