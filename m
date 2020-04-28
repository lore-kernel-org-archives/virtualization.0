From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 30/75] x86/idt: Move two function from k/idt.c to i/a/desc.h
Date: Tue, 28 Apr 2020 17:16:40 +0200
Message-ID: <20200428151725.31091-31-joro@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200428151725.31091-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Move these two functions from kernel/idt.c to include/asm/desc.h:

	* init_idt_data()
	* idt_init_desc()

These functions are needed to setup IDT entries very early and need to
be called from head64.c. To be usable this early these functions need to
be compiled without instrumentation and the stack-protector feature.
These features need to be kept enabled for kernel/idt.c, so head64.c
must use its own versions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/desc.h      | 27 +++++++++++++++++++++++++
 arch/x86/include/asm/desc_defs.h |  7 +++++++
 arch/x86/kernel/idt.c            | 34 --------------------------------
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 68a99d2a5f33..80bf63c08007 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -389,6 +389,33 @@ static inline void set_desc_limit(struct desc_struct *desc, unsigned long limit)
 void update_intr_gate(unsigned int n, const void *addr);
 void alloc_intr_gate(unsigned int n, const void *addr);
 
+static inline void init_idt_data(struct idt_data *data, unsigned int n,
+				 const void *addr)
+{
+	BUG_ON(n > 0xFF);
+
+	memset(data, 0, sizeof(*data));
+	data->vector	= n;
+	data->addr	= addr;
+	data->segment	= __KERNEL_CS;
+	data->bits.type	= GATE_INTERRUPT;
+	data->bits.p	= 1;
+}
+
+static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
+{
+	unsigned long addr = (unsigned long) d->addr;
+
+	gate->offset_low	= (u16) addr;
+	gate->segment		= (u16) d->segment;
+	gate->bits		= d->bits;
+	gate->offset_middle	= (u16) (addr >> 16);
+#ifdef CONFIG_X86_64
+	gate->offset_high	= (u32) (addr >> 32);
+	gate->reserved		= 0;
+#endif
+}
+
 extern unsigned long system_vectors[];
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index 5621fb3f2d1a..f7e7099af595 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -74,6 +74,13 @@ struct idt_bits {
 			p	: 1;
 } __attribute__((packed));
 
+struct idt_data {
+	unsigned int	vector;
+	unsigned int	segment;
+	struct idt_bits	bits;
+	const void	*addr;
+};
+
 struct gate_struct {
 	u16		offset_low;
 	u16		segment;
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index c752027abc9e..4a2c7791c697 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -9,13 +9,6 @@
 #include <asm/desc.h>
 #include <asm/hw_irq.h>
 
-struct idt_data {
-	unsigned int	vector;
-	unsigned int	segment;
-	struct idt_bits	bits;
-	const void	*addr;
-};
-
 #define DPL0		0x0
 #define DPL3		0x3
 
@@ -204,20 +197,6 @@ const struct desc_ptr debug_idt_descr = {
 };
 #endif
 
-static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
-{
-	unsigned long addr = (unsigned long) d->addr;
-
-	gate->offset_low	= (u16) addr;
-	gate->segment		= (u16) d->segment;
-	gate->bits		= d->bits;
-	gate->offset_middle	= (u16) (addr >> 16);
-#ifdef CONFIG_X86_64
-	gate->offset_high	= (u32) (addr >> 32);
-	gate->reserved		= 0;
-#endif
-}
-
 static void
 idt_setup_from_table(gate_desc *idt, const struct idt_data *t, int size, bool sys)
 {
@@ -231,19 +210,6 @@ idt_setup_from_table(gate_desc *idt, const struct idt_data *t, int size, bool sy
 	}
 }
 
-static void init_idt_data(struct idt_data *data, unsigned int n,
-			  const void *addr)
-{
-	BUG_ON(n > 0xFF);
-
-	memset(data, 0, sizeof(*data));
-	data->vector	= n;
-	data->addr	= addr;
-	data->segment	= __KERNEL_CS;
-	data->bits.type	= GATE_INTERRUPT;
-	data->bits.p	= 1;
-}
-
 static void set_intr_gate(unsigned int n, const void *addr)
 {
 	struct idt_data data;
-- 
2.17.1
