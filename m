From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 07/17] paravirt_ops - descriptor changes.
Date: Thu, 08 Mar 2007 01:02:14 -0500
Message-ID: <1173333734.25848.8.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-desc-header.patch)
Update the descriptors for an interface with paravirt ops

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>



Index: clean-start/include/asm-x86_64/desc.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/desc.h
+++ clean-start/include/asm-x86_64/desc.h
@@ -16,9 +16,8 @@
 =

 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 =

-#define load_TR_desc() asm volatile("ltr %w0"::"r" (GDT_ENTRY_TSS*8))
-#define load_LDT_desc() asm volatile("lldt %w0"::"r" (GDT_ENTRY_LDT*8))
-#define clear_LDT()  asm volatile("lldt %w0"::"r" (0))
+/* the cpu gdt accessor */
+#define cpu_gdt(_cpu) ((struct desc_struct *)cpu_gdt_descr[_cpu].address)
 =

 /*
  * This is the ldt that every process will get unless we need
@@ -28,8 +27,6 @@ extern struct desc_struct default_ldt[];
 extern struct gate_struct idt_table[]; =

 extern struct desc_ptr cpu_gdt_descr[];
 =

-/* the cpu gdt accessor */
-#define cpu_gdt(_cpu) ((struct desc_struct *)cpu_gdt_descr[_cpu].address)
 =

 static inline void _set_gate(void *adr, unsigned type, unsigned long func,=
 unsigned dpl, unsigned ist)  =

 {
@@ -115,7 +112,35 @@ static inline void set_seg_base(unsigned
 	d->base0 =3D addr & 0xffff;
 	d->base1 =3D (addr >> 16) & 0xff;
 	d->base2 =3D (addr >> 24) & 0xff;
-} =

+}
+
+static inline void native_load_tr_desc(void)
+{
+	asm volatile("ltr %w0"::"r" (GDT_ENTRY_TSS*8));
+}
+
+static inline void native_load_gdt(const struct desc_ptr *dtr)
+{
+	asm volatile("lgdt %w0"::"m" (*dtr));
+}
+
+static inline void native_load_idt(const struct desc_ptr *dtr)
+{
+	asm volatile("lidt %w0"::"m" (*dtr));
+}
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define load_idt native_load_idt
+#define load_gdt native_load_gdt
+#define load_TR_desc native_load_tr_desc
+#define set_ldt native_set_ldt
+#define load_TLS native_load_TLS
+#endif /* CONFIG_PARAVIRT */
+
+#define clear_LDT() set_ldt(NULL,0)
+
 =

 #define LDT_entry_a(info) \
 	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
@@ -149,7 +174,7 @@ static inline void set_seg_base(unsigned
 # error update this code.
 #endif
 =

-static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
+static inline void native_load_TLS(struct thread_struct *t, unsigned int c=
pu)
 {
 	u64 *gdt =3D (u64 *)(cpu_gdt(cpu) + GDT_ENTRY_TLS_MIN);
 	gdt[0] =3D t->tls_array[0];
@@ -157,27 +182,33 @@ static inline void load_TLS(struct threa
 	gdt[2] =3D t->tls_array[2];
 } =

 =

+static inline void native_set_ldt(const void *addr,
+					unsigned int entries)
+{
+	if (likely(entries =3D=3D 0))
+		__asm__ __volatile__ ("lldt %w0" :: "r" (0));
+	else {
+		unsigned cpu =3D smp_processor_id();
+
+		set_tssldt_descriptor(&cpu_gdt(cpu)[GDT_ENTRY_LDT], (unsigned long)addr,
+			      DESC_LDT, entries * 8 - 1);
+		__asm__ __volatile__ ("lldt %w0"::"r" (GDT_ENTRY_LDT*8));
+	}
+}
+
 /*
  * load one particular LDT into the current CPU
  */
-static inline void load_LDT_nolock (mm_context_t *pc, int cpu)
+static inline void load_LDT_nolock (mm_context_t *pc)
 {
-	int count =3D pc->size;
-
-	if (likely(!count)) {
-		clear_LDT();
-		return;
-	}
-		=

-	set_ldt_desc(cpu, pc->ldt, count);
-	load_LDT_desc();
+	set_ldt(pc->ldt, pc->size);
 }
 =

 static inline void load_LDT(mm_context_t *pc)
 {
-	int cpu =3D get_cpu();
-	load_LDT_nolock(pc, cpu);
-	put_cpu();
+	preempt_disable();
+	load_LDT_nolock(pc);
+	preempt_enable();
 }
 =

 extern struct desc_ptr idt_descr;
Index: clean-start/include/asm-x86_64/desc_defs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/desc_defs.h
+++ clean-start/include/asm-x86_64/desc_defs.h
@@ -43,6 +43,11 @@ struct gate_struct {
 #define PTR_MIDDLE(x) (((unsigned long)(x) >> 16) & 0xFFFF)
 #define PTR_HIGH(x) ((unsigned long)(x) >> 32)
 =

+#define DESC_ADDRESS(d) ((unsigned long)((unsigned long)d.base2 << 32) 	\
+				| (d.base1 << 16) | d.base0)
+
+#define GATE_ADDRESS(g) ((unsigned long)((unsigned long)g.offset_high << 3=
2) \
+				| (g.offset_middle << 16) | g.offset_low)
 enum {
 	DESC_TSS =3D 0x9,
 	DESC_LDT =3D 0x2,

--
