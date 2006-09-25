From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Date: Sun, 24 Sep 2006 23:25:40 -0700
Message-ID: <45177664.3060103@goop.org>
References: <1158925861.26261.3.camel@localhost.localdomain>	
	<1158925997.26261.6.camel@localhost.localdomain>	
	<1158926106.26261.8.camel@localhost.localdomain>	
	<1158926215.26261.11.camel@localhost.localdomain>	
	<1158926308.26261.14.camel@localhost.localdomain>	
	<1158926386.26261.17.camel@localhost.localdomain>	
	<4514663E.5050707@goop.org>	
	<1158985882.26261.60.camel@localhost.localdomain>	
	<45172AC8.2070701@goop.org>	
	<1159146974.26986.30.camel@localhost.localdomain>	
	<45173287.8070204@goop.org>	
	<1159152678.26986.38.camel@localhost.localdomain>	
	<45176865.7020300@goop.org>
	<1159164232.26986.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1159164232.26986.59.camel@localhost.localdomain>
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
Cc: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> I don't think so.  There's *never* address subtraction, there's
> sometimes 32 bit wrap (glibc uses this to effect subtraction, sure).
> But there's no wrap here.
>   =

Hm, I guess, so long as you assume the kernel data segment is always =

below the kernel heap.

> To test, I changed the following:
>
> --- smpboot.c.~8~	2006-09-25 15:51:50.000000000 +1000
> +++ smpboot.c	2006-09-25 16:00:36.000000000 +1000
> @@ -926,8 +926,9 @@
>  					      unsigned long per_cpu_off)
>  {
>  	unsigned limit, flags;
> +	extern char __per_cpu_end[];
>  =

> -	limit =3D (1 << 20);
> +	limit =3D PAGE_ALIGN((long)__per_cpu_end) >> PAGE_SHIFT;
>   =

limit is a size, rather than the end address, so this isn't quite right.

    J
