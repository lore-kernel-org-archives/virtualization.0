From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Use correct macros in raid code, not raw asm
Date: Thu, 28 Dec 2006 15:56:59 -0800
Message-ID: <20061228155659.462eaa9c.akpm@osdl.org>
References: <1167348861.30506.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1167348861.30506.46.camel@localhost.localdomain>
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
Cc: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, virtualization <virtualization@lists.osdl.org>, Neil Brown <neilb@suse.de>, Ingo Molnar <mingo@elte.hu>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 29 Dec 2006 10:34:21 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> This make sure it's paravirtualized correctly when CONFIG_PARAVIRT=3Dy.
> =

> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> =

> diff -r 4ff048622391 drivers/md/raid6x86.h
> --- a/drivers/md/raid6x86.h	Thu Dec 28 16:52:54 2006 +1100
> +++ b/drivers/md/raid6x86.h	Fri Dec 29 10:09:38 2006 +1100
> @@ -75,13 +75,14 @@ static inline unsigned long raid6_get_fp
>  	unsigned long cr0;
>  =

>  	preempt_disable();
> -	asm volatile("mov %%cr0,%0 ; clts" : "=3Dr" (cr0));
> +	cr0 =3D read_cr0();
> +	clts();
>  	return cr0;
>  }
>  =

>  static inline void raid6_put_fpu(unsigned long cr0)
>  {
> -	asm volatile("mov %0,%%cr0" : : "r" (cr0));
> +	write_cr0(cr0);
>  	preempt_enable();
>  }
>  =


Perhaps we also need:

--- a/drivers/md/raid6x86.h~use-correct-macros-in-raid-code-not-raw-asm-inc=
lude
+++ a/drivers/md/raid6x86.h
@@ -21,6 +21,8 @@
 =

 #if defined(__i386__) || defined(__x86_64__)
 =

+#include <asm/system.h>
+
 #ifdef __x86_64__
 =

 typedef struct {
_

?
