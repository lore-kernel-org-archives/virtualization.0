From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 02/13] hvvm export page utils
Date: Thu, 08 Mar 2007 12:38:40 -0500
Message-ID: <1173375520.32170.4.camel@localhost.localdomain>
References: <20070308162348.299676000@redhat.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (hvvm-mm-export.patch)
I would like to have the HV VM code in the kernel proper,
but until then, it needs to get at some of the memory page
table utils (pud_alloc and friends). So as a module, we export
this.

I probably can change HV VM to just be compiled in the kernel
like some of the other lguest stuff too.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Cc: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>

Index: work-pv/mm/memory.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-pv.orig/mm/memory.c
+++ work-pv/mm/memory.c
@@ -2798,3 +2798,10 @@ int access_process_vm(struct task_struct
 	return buf - old_buf;
 }
 EXPORT_SYMBOL_GPL(access_process_vm);
+
+/* temp until we put the hv vm stuff into the kernel */
+EXPORT_SYMBOL_GPL(__pud_alloc);
+EXPORT_SYMBOL_GPL(__pmd_alloc);
+EXPORT_SYMBOL_GPL(__pte_alloc_kernel);
+EXPORT_SYMBOL_GPL(pmd_clear_bad);
+EXPORT_SYMBOL_GPL(pud_clear_bad);

--
