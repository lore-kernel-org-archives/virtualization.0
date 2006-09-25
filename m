From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Date: Mon, 25 Sep 2006 16:03:52 +1000
Message-ID: <1159164232.26986.59.camel@localhost.localdomain>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45176865.7020300@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2006-09-24 at 22:25 -0700, Jeremy Fitzhardinge wrote:
> The %gs:per_cpu__foo addressing mode still calculates =

> 0xbcef00+0xc0433800, which is still a subtraction.  My essential point =

> is that *all* kernel addresses (=3Dkernel symbols) are negative, so using =

> them as an offset from a segment base (any segment base) is a =

> subtraction, which requires a 4G limit.

I don't think so.  There's *never* address subtraction, there's
sometimes 32 bit wrap (glibc uses this to effect subtraction, sure).
But there's no wrap here.

To test, I changed the following:

--- smpboot.c.~8~	2006-09-25 15:51:50.000000000 +1000
+++ smpboot.c	2006-09-25 16:00:36.000000000 +1000
@@ -926,8 +926,9 @@
 					      unsigned long per_cpu_off)
 {
 	unsigned limit, flags;
+	extern char __per_cpu_end[];
 =

-	limit =3D (1 << 20);
+	limit =3D PAGE_ALIGN((long)__per_cpu_end) >> PAGE_SHIFT;
 	flags =3D 0x8;		/* 4k granularity */
 =

 	/* present read-write data segment */


Works fine...

Hope that clarifies!
Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
