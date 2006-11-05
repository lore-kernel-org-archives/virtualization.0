From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: warnings in rc4-mm2
Date: Sun, 05 Nov 2006 16:56:44 +1100
Message-ID: <1162706204.29777.25.camel@localhost.localdomain>
References: <20061102152507.70ab4dd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061102152507.70ab4dd2.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2006-11-02 at 15:25 -0800, Andrew Morton wrote:
> i386 allmodconfig
> =

> arch/i386/power/cpu.c: In function '__save_processor_state':
> arch/i386/power/cpu.c:29: warning: passing argument 1 of 'paravirt_ops.st=
ore_gdt' from incompatible pointer type
> arch/i386/power/cpu.c:30: warning: passing argument 1 of 'paravirt_ops.st=
ore_idt' from incompatible pointer type
> arch/i386/power/cpu.c: In function '__restore_processor_state':
> arch/i386/power/cpu.c:102: warning: passing argument 1 of 'paravirt_ops.l=
oad_gdt' from incompatible pointer type
> arch/i386/power/cpu.c:103: warning: passing argument 1 of 'paravirt_ops.l=
oad_idt' from incompatible pointer type
> arch/i386/kernel/paravirt.c:481: warning: initialization from incompatibl=
e pointer type

Thanks for the reminder!

The previous store_gdt() was a macro, with CONFIG_PARAVIRT we have
typechecking that the arg is a struct Xgt_desc_struct *.  When I looked
at changing "struct saved_context" to use that struct, I realized that
the padding was in a different place: will changing it be a
compatibility issue?

Rusty.

With CONFIG_PARAVIRT enabled, store_gdt/store_idt etc are actual
functions which expect a struct Xgt_desc_struct *.  Make saved_context
conform rather than using manually-assembled GDT.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.19-rc4-mm2/include/asm-i386/suspend.h working-2.6.19=
-rc4-mm2-warnings/include/asm-i386/suspend.h
--- linux-2.6.19-rc4-mm2/include/asm-i386/suspend.h	2006-11-05 15:35:56.000=
000000 +1100
+++ working-2.6.19-rc4-mm2-warnings/include/asm-i386/suspend.h	2006-11-05 1=
6:40:40.000000000 +1100
@@ -12,12 +12,8 @@ static inline int arch_prepare_suspend(v
 struct saved_context {
   	u16 es, fs, gs, ss;
 	unsigned long cr0, cr2, cr3, cr4;
-	u16 gdt_pad;
-	u16 gdt_limit;
-	unsigned long gdt_base;
-	u16 idt_pad;
-	u16 idt_limit;
-	unsigned long idt_base;
+	struct Xgt_desc_struct gdt;
+	struct Xgt_desc_struct idt;
 	u16 ldt;
 	u16 tss;
 	unsigned long tr;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.19-rc4-mm2/arch/i386/power/cpu.c working-2.6.19-rc4-=
mm2-warnings/arch/i386/power/cpu.c
--- linux-2.6.19-rc4-mm2/arch/i386/power/cpu.c	2006-09-22 15:35:56.00000000=
0 +1000
+++ working-2.6.19-rc4-mm2-warnings/arch/i386/power/cpu.c	2006-11-05 16:42:=
52.000000000 +1100
@@ -26,8 +26,8 @@ void __save_processor_state(struct saved
 	/*
 	 * descriptor tables
 	 */
- 	store_gdt(&ctxt->gdt_limit);
- 	store_idt(&ctxt->idt_limit);
+ 	store_gdt(&ctxt->gdt);
+ 	store_idt(&ctxt->idt);
  	store_tr(ctxt->tr);
 =

 	/*
@@ -99,8 +99,8 @@ void __restore_processor_state(struct sa
 	 * now restore the descriptor tables to their proper values
 	 * ltr is done i fix_processor_context().
 	 */
- 	load_gdt(&ctxt->gdt_limit);
- 	load_idt(&ctxt->idt_limit);
+ 	load_gdt(&ctxt->gdt);
+ 	load_idt(&ctxt->idt);
 =

 	/*
 	 * segment registers
