From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Date: Mon, 25 Sep 2006 11:20:53 +1000
Message-ID: <1159147253.26986.34.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
	<1158925997.26261.6.camel@localhost.localdomain>
	<1158926106.26261.8.camel@localhost.localdomain>
	<1158926215.26261.11.camel@localhost.localdomain>
	<1158926308.26261.14.camel@localhost.localdomain>
	<1158926386.26261.17.camel@localhost.localdomain>
	<4514663E.5050707@goop.org> <20060923081337.GA10534@muc.de>
	<45172BCE.4010708@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45172BCE.4010708@goop.org>
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

On Sun, 2006-09-24 at 18:07 -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >> I managed to get all this done in head.S before going into C code; is =

> >> that not still possible?  Or is there a later patch to do this.
> >>     =

> >
> > Why write in assembler what you can write in C?
> >   =

> This stuff is very basic, and you could consider it as being part of the =

> kernel's C runtime model, and therefore can be expected to be available =

> everywhere.  In particular, the use of current is so prevalent that you =

> really can't call anything without having the PDA set up.

Yeah, I agree with Jeremy.  It's nice if we can just use it everywhere,
and he kindly explained to me that secondary CPUs we can do most of it
before the CPU bringup (ie. in C): we just have to load the gs register
in asm AFAICT.

I'll produce a patch, so we can see what we're talking about...

Thanks!
Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
