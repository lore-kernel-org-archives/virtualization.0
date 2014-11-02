From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v4 05/10] x86: cpu: Add helper function unifying 32-bit and
	64-bit IO init in cpu_init
Date: Sun, 2 Nov 2014 09:32:28 -0800
Message-ID: <225193735620e87b14c5b34fda264c81b9f49a3f.1414870871.git.josh@joshtriplett.org>
References: <cover.1414870871.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1414870871.git.josh@joshtriplett.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

Previously, the 64-bit code initialized both the io_bitmap_base and
io_bitmap, while the 32-bit code only initialized io_bitmap_base.

Factor the initialization out into a helper function init_tss_io, and
call it from both versions of cpu_init.

This will also make it easier to make these IO-related fields optional
later.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 arch/x86/include/asm/processor.h | 14 ++++++++++++++
 arch/x86/kernel/cpu/common.c     | 12 ++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0a12534..1fa78f7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -286,6 +286,20 @@ struct tss_struct {
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct tss_struct, init_tss);
 
+static inline void init_tss_io(struct tss_struct *t)
+{
+	int i;
+
+	t->x86_tss.io_bitmap_base = offsetof(struct tss_struct, io_bitmap);
+
+	/*
+	 * <= is required because the CPU will access up to
+	 * 8 bits beyond the end of the IO permission bitmap.
+	 */
+	for (i = 0; i <= IO_BITMAP_LONGS; i++)
+		t->io_bitmap[i] = ~0UL;
+}
+
 /*
  * Save the original ist values for checking stack pointers during debugging
  */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4b4f78c..ae2e8d7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1297,7 +1297,6 @@ void cpu_init(void)
 	struct tss_struct *t;
 	unsigned long v;
 	int cpu = stack_smp_processor_id();
-	int i;
 
 	wait_for_master_cpu(cpu);
 
@@ -1357,14 +1356,7 @@ void cpu_init(void)
 		}
 	}
 
-	t->x86_tss.io_bitmap_base = offsetof(struct tss_struct, io_bitmap);
-
-	/*
-	 * <= is required because the CPU will access up to
-	 * 8 bits beyond the end of the IO permission bitmap.
-	 */
-	for (i = 0; i <= IO_BITMAP_LONGS; i++)
-		t->io_bitmap[i] = ~0UL;
+	init_tss_io(t);
 
 	atomic_inc(&init_mm.mm_count);
 	me->active_mm = &init_mm;
@@ -1419,7 +1411,7 @@ void cpu_init(void)
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
-	t->x86_tss.io_bitmap_base = offsetof(struct tss_struct, io_bitmap);
+	init_tss_io(t);
 
 #ifdef CONFIG_DOUBLEFAULT
 	/* Set up doublefault TSS pointer in the GDT */
-- 
2.1.1
