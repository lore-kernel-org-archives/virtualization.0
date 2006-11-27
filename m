From: James Morris <jmorris@redhat.com>
Subject: [PATCH] lhype: Add TLS support
Date: Mon, 27 Nov 2006 18:37:02 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0611271823380.14443-100000@redline.boston.redhat.com>
References: <Pine.LNX.4.44.0611161941580.1501-100000@redline.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0611161941580.1501-100000@redline.boston.redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization <virtualization@lists.osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: virtualization@lists.linuxfoundation.org

This is queued for when Rusty returns, but may be generally useful now to =

people playing with lhype.

TLS support is required for some binaries (notably, Fedora & co), and also =

any binary which explicitly uses __thread variables (which all segfault =

without this patch).

It works well enough to bring FC6 up as far as it goes without an initrd, =

although there may be some further work required.  e.g.

o Need to ensure fixup_gdt() doesn't stomp on TLS segement descriptors.
o In some cases, a binary may fall back to calling modify_ldt(2) instead =

  of get_thread_area(2), and this needs to be handled.

---

Virtualize thread local storage for guests.  A new hypercall,
LHCALL_LOAD_TLS, is implemented, mapping to the load_tls()
paravirt op.  The virtualized GDT is now updated correctly
from the guest's per-thread TLS array.

Signed-off-by: James Morris <jmorris@namei.org>
---
 arch/i386/kernel/lhype.c   |    6 ++++++
 drivers/lhype/hypercalls.c |   22 +++++++++++++++++++++-
 include/asm-i386/lhype.h   |    1 +
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/lhype.c b/arch/i386/kernel/lhype.c
index d4376c5..35c4616 100644
--- a/arch/i386/kernel/lhype.c
+++ b/arch/i386/kernel/lhype.c
@@ -221,6 +221,11 @@ static fastcall void lhype_set_ldt(const
 	BUG_ON(entries);
 }
 =

+static fastcall void lhype_load_tls(struct thread_struct *t, unsigned int =
cpu)
+{
+	hcall(LHCALL_LOAD_TLS, __pa(t), cpu, 0);
+}
+
 static fastcall void lhype_set_debugreg(int regno, unsigned long value)
 {
 	/* FIXME: Implement */
@@ -385,6 +390,7 @@ #endif
 	paravirt_ops.load_esp0 =3D lhype_load_esp0;
 	paravirt_ops.load_tr_desc =3D lhype_load_tr_desc;
 	paravirt_ops.set_ldt =3D lhype_set_ldt;
+	paravirt_ops.load_tls =3D lhype_load_tls;
 	paravirt_ops.set_debugreg =3D lhype_set_debugreg;
 	paravirt_ops.clts =3D lhype_clts;
 	paravirt_ops.read_cr0 =3D lhype_read_cr0;
diff --git a/drivers/lhype/hypercalls.c b/drivers/lhype/hypercalls.c
index bc8639c..f3ff693 100644
--- a/drivers/lhype/hypercalls.c
+++ b/drivers/lhype/hypercalls.c
@@ -178,13 +178,29 @@ static int guest_set_stack(struct lhype_
 	return 1;
 }
 =

+static void guest_load_tls(struct lhype_dom_info *info,
+			   const struct thread_struct __user *t)
+{
+	int i;
+	struct desc_struct *gdt =3D info->domain->gdt_table;
+	=

+	for (i =3D GDT_ENTRY_TLS_MIN; i <=3D GDT_ENTRY_TLS_MAX; i++) {
+		struct desc_struct d;
+
+		lhread(info, &d, (u32)&t->tls_array[i - GDT_ENTRY_TLS_MIN],
+		       sizeof(d));
+		gdt[i] =3D d;
+	}
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
@@ -208,6 +224,7 @@ void hypercall(struct lhype_dom_info *li
 		       regs->eax =3D=3D LHCALL_SET_PTE ? "SET_PTE" :
 		       regs->eax =3D=3D LHCALL_SET_SOME_PTE ? "SET_SOME_PTE" :
 		       regs->eax =3D=3D LHCALL_SET_PUD ? "SET_PUD" :
+		       regs->eax =3D=3D LHCALL_LOAD_TLS ? "LOAD_TLS" :
 		       "UNKNOWN");
 	}
 =

@@ -325,6 +342,9 @@ void hypercall(struct lhype_dom_info *li
 	case LHCALL_SET_PUD:
 		guest_set_pud(linfo, regs->edx);
 		break;
+	case LHCALL_LOAD_TLS:
+		guest_load_tls(linfo, (struct thread_struct __user*)regs->edx);
+		break;
 	}
 	return;
 }
diff --git a/include/asm-i386/lhype.h b/include/asm-i386/lhype.h
index df86d97..af0c03b 100644
--- a/include/asm-i386/lhype.h
+++ b/include/asm-i386/lhype.h
@@ -26,6 +26,7 @@ #define LHCALL_SEND_DMA		18
 #define LHCALL_SET_PTE		19
 #define LHCALL_SET_SOME_PTE	20
 #define LHCALL_SET_PUD		21
+#define LHCALL_LOAD_TLS		22
 =

 #define LHYPE_TRAP_ENTRY 0x81
 =

-- =

1.4.2.1
