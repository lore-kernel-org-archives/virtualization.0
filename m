From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/10] lguest: Initialize esp0 properly all the time
Date: Fri, 09 Feb 2007 20:18:13 +1100
Message-ID: <1171012693.2718.37.camel@localhost.localdomain>
References: <1171012296.2718.26.camel@localhost.localdomain>
	<1171012458.2718.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1171012458.2718.30.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Whenever we schedule, __switch_to calls load_esp0 which does:

	tss->esp0 =3D thread->esp0;

This is never initialized for the initial thread (ie "swapper"), so
when we're scheduling that, we end up setting esp0 to 0.  This is
fine: the swapper never leaves ring 0, so this field is never used.

lguest, however, gets upset that we're trying to used an unmapped page
as our kernel stack.  Rather than work around it there, let's
initialize it.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -421,6 +421,7 @@ struct thread_struct {
 };
 =

 #define INIT_THREAD  {							\
+	.esp0 =3D sizeof(init_stack) + (long)&init_stack,			\
 	.vm86_info =3D NULL,						\
 	.sysenter_cs =3D __KERNEL_CS,					\
 	.io_bitmap_ptr =3D NULL,						\
