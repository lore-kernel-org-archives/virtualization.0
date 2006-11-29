From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] lhype: Add TLS support
Date: Wed, 29 Nov 2006 16:37:22 +1100
Message-ID: <1164778643.5694.29.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0611271823380.14443-100000@redline.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0611271823380.14443-100000@redline.boston.redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: James Morris <jmorris@redhat.com>
Cc: virtualization <virtualization@lists.osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2006-11-27 at 18:37 -0500, James Morris wrote:
> This is queued for when Rusty returns, but may be generally useful now to =

> people playing with lhype.
> =

> TLS support is required for some binaries (notably, Fedora & co), and als=
o =

> any binary which explicitly uses __thread variables (which all segfault =

> without this patch).

Right...

	This unfortunately brings a security issue; GLIBC uses huge positive
offsets (4G minus a smidge) against these segments to access some
variables.  This means that the segments must cover the entire address
space, which would give them access to the hypervisor.

	There are two simple solutions to this.  The first is to trim the
segments, and use a modified libc (a-la Xen).  The second is to only
allow those TLS mappings in usermode: the U/S bit on the pagetables will
prevent usermode from accessing the hypervisor anyway.  This becomes a
little harder later, when we allow syscall traps directly into guest,
but I have another trick for that...

	Untested, but based on your patch.  Does it work?

Thanks!
Rusty.
diff -r d4fb2c676c1c arch/i386/kernel/lhype.c
--- a/arch/i386/kernel/lhype.c	Thu Nov 16 08:34:46 2006 +1100
+++ b/arch/i386/kernel/lhype.c	Wed Nov 29 16:23:43 2006 +1100
@@ -221,6 +221,11 @@ static fastcall void lhype_set_ldt(const
 	BUG_ON(entries);
 }
 =

+static fastcall void lhype_load_tls(struct thread_struct *t, unsigned int =
cpu)
+{
+	hcall(LHCALL_LOAD_TLS, __pa(&t->tls_array), cpu, 0);
+}
+
 static fastcall void lhype_set_debugreg(int regno, unsigned long value)
 {
 	/* FIXME: Implement */
@@ -385,6 +390,7 @@ static __attribute_used__ __init void lh
 	paravirt_ops.load_esp0 =3D lhype_load_esp0;
 	paravirt_ops.load_tr_desc =3D lhype_load_tr_desc;
 	paravirt_ops.set_ldt =3D lhype_set_ldt;
+	paravirt_ops.load_tls =3D lhype_load_tls;
 	paravirt_ops.set_debugreg =3D lhype_set_debugreg;
 	paravirt_ops.clts =3D lhype_clts;
 	paravirt_ops.read_cr0 =3D lhype_read_cr0;
diff -r d4fb2c676c1c drivers/lhype/hypercalls.c
--- a/drivers/lhype/hypercalls.c	Thu Nov 16 08:34:46 2006 +1100
+++ b/drivers/lhype/hypercalls.c	Wed Nov 29 16:32:56 2006 +1100
@@ -178,13 +178,20 @@ static int guest_set_stack(struct lhype_
 	return 1;
 }
 =

+static void guest_load_tls(struct lhype_dom_info *linfo,
+			   const struct desc_struct __user *tls_array)
+{
+	lhread(linfo, &linfo->tls, (u32)tls_array, sizeof(linfo->tls));
+}
+
 void hypercall(struct lhype_dom_info *linfo, struct lhype_regs *regs)
 {
 	static unsigned long last_jifs;
 	/* These three happen regularly, so we limit them... */
 	if ((regs->eax !=3D LHCALL_IRET
 	     && regs->eax !=3D LHCALL_HALT
-	     && regs->eax !=3D LHCALL_TIMER_READ)
+	     && regs->eax !=3D LHCALL_TIMER_READ
+	     && regs->eax !=3D LHCALL_LOAD_TLS)
 	    || printk_timed_ratelimit(&last_jifs, 10000)) {
 		printk(KERN_DEBUG "%i: %s\n", linfo->domid,
 		       regs->eax =3D=3D LHCALL_LHYPE_PAGE ? "LHYPE_PAGE" :
@@ -208,6 +215,7 @@ void hypercall(struct lhype_dom_info *li
 		       regs->eax =3D=3D LHCALL_SET_PTE ? "SET_PTE" :
 		       regs->eax =3D=3D LHCALL_SET_SOME_PTE ? "SET_SOME_PTE" :
 		       regs->eax =3D=3D LHCALL_SET_PUD ? "SET_PUD" :
+		       regs->eax =3D=3D LHCALL_LOAD_TLS ? "LOAD_TLS" :
 		       "UNKNOWN");
 	}
 =

@@ -325,6 +333,9 @@ void hypercall(struct lhype_dom_info *li
 	case LHCALL_SET_PUD:
 		guest_set_pud(linfo, regs->edx);
 		break;
+	case LHCALL_LOAD_TLS:
+		guest_load_tls(linfo, (struct desc_struct __user*)regs->edx);
+		break;
 	}
 	return;
 }
diff -r d4fb2c676c1c drivers/lhype/init.c
--- a/drivers/lhype/init.c	Thu Nov 16 08:34:46 2006 +1100
+++ b/drivers/lhype/init.c	Wed Nov 29 16:32:14 2006 +1100
@@ -340,6 +340,17 @@ static int run_thread(struct lhype_dom_i
 		} else
 			cond_resched();
 =

+		/* We can let them used the TLS 4G segments iff in
+		 * userspace: the U/S bit on the pagetables protects
+		 * hypervisor */
+		if ((linfo->domain->regs.cs & 3) =3D=3D 3) {
+			memcpy(linfo->domain->gdt_table + GDT_ENTRY_TLS_MIN,
+			       linfo->tls, sizeof(linfo->tls));
+		} else {
+			memset(linfo->domain->gdt_table + GDT_ENTRY_TLS_MIN,
+			       0, sizeof(linfo->tls));
+		}
+
 		local_irq_disable();
 		/* FIXME: We should be able to be smart here. */
 		math_state_restore();
diff -r d4fb2c676c1c drivers/lhype/lhype.h
--- a/drivers/lhype/lhype.h	Thu Nov 16 08:34:46 2006 +1100
+++ b/drivers/lhype/lhype.h	Wed Nov 29 16:32:00 2006 +1100
@@ -108,6 +108,7 @@ struct lhype_dom_info
 	int halted;
 	u32 last_timer;
 	struct file *input;
+	struct desc_struct tls[GDT_ENTRY_TLS_ENTRIES];
 =

 	u32 *pgdir;
 =

diff -r d4fb2c676c1c include/asm-i386/lhype.h
--- a/include/asm-i386/lhype.h	Thu Nov 16 08:34:46 2006 +1100
+++ b/include/asm-i386/lhype.h	Wed Nov 29 16:18:38 2006 +1100
@@ -26,6 +26,7 @@
 #define LHCALL_SET_PTE		19
 #define LHCALL_SET_SOME_PTE	20
 #define LHCALL_SET_PUD		21
+#define LHCALL_LOAD_TLS		22
 =

 #define LHYPE_TRAP_ENTRY 0x81
 =
