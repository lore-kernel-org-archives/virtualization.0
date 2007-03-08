From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 17/17] paravirt_ops - pda entry
Date: Thu, 08 Mar 2007 01:02:40 -0500
Message-ID: <1173333760.25848.18.camel@localhost.localdomain>
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

plain text document attachment (xx-paravirt-pda.patch)
We don't actually use this. But we started to. This patch adds a =

vcpu entry into the PDA.  This can come in handy, but we are not
sure if we want it.  This is why it's in its own little patch.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>


Index: work-nopv/arch/x86_64/kernel/asm-offsets.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-nopv.orig/arch/x86_64/kernel/asm-offsets.c
+++ work-nopv/arch/x86_64/kernel/asm-offsets.c
@@ -48,6 +48,9 @@ int main(void)
 	ENTRY(cpunumber);
 	ENTRY(irqstackptr);
 	ENTRY(data_offset);
+	/* XXX: this should probably be a paravirt_ops stub, to be filled in
+	 * with the hypervisor code */
+	ENTRY(vcpu);
 	BLANK();
 #undef ENTRY
 #ifdef CONFIG_IA32_EMULATION
Index: clean-start/include/asm-x86_64/pda.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/pda.h
+++ clean-start/include/asm-x86_64/pda.h
@@ -29,6 +29,7 @@ struct x8664_pda {
 	short isidle;
 	struct mm_struct *active_mm;
 	unsigned apic_timer_irqs;
+	void *vcpu;
 } ____cacheline_aligned_in_smp;
 =

 extern struct x8664_pda *_cpu_pda[];

--
