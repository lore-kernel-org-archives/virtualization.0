From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 17/24] Xen-paravirt_ops: avoid having a bad selector in %gs
	during context switch
Date: Wed, 21 Feb 2007 12:53:11 -0800
Message-ID: <20070221205323.770169136@goop.org>
References: <20070221205254.169835700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=xen-avoid-gs-reload.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

During a context switch from a usermode process (which has a TLS
segment set up, and %gs pointing to it) to a kernel process (which has
no TLS and a null %gs selector), there's a period when %gs contains a
stale selector value after updating the GDT.  This causes Xen to
hiccup because on returning from the GDT update hypercall as it tries
to reload %gs and suffers another fault.

This patch words around this by zeroing %gs during the context switch
so that it doesn't cause problems, but the real fix is to change Xen
to avoid touching %gs when it doesn't need to.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -719,6 +719,14 @@ struct task_struct fastcall * __switch_t
 	savesegment(gs, prev->gs);
 =

 	/*
+	 * Temporary hack: zero gs now that we've saved it so that Xen
+	 * doesn't try to reload the old value after changing the GDT
+	 * during the context switch.  This can go away once Xen has
+	 * been taught to only reload %gs when it absolutely must.
+	 */
+	loadsegment(gs, 0);
+
+	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
 	 */
 	load_TLS(next, cpu);

-- =
