From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 2/4] x86 paravirt_ops: paravirt_desc.h for native
	descriptor ops.
Date: Mon, 7 Aug 2006 13:19:58 -0400
Message-ID: <20060807171958.GT13393@redhat.com>
References: <1154925835.21647.29.camel@localhost.localdomain>
	<200608070740.23840.ak@muc.de>
	<1154937040.7642.31.camel@localhost.localdomain>
	<200608071053.28293.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608071053.28293.ak@muc.de>
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
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 07, 2006 at 10:53:28AM +0200, Andi Kleen wrote:
 > On Monday 07 August 2006 09:50, Rusty Russell wrote:
 > > On Mon, 2006-08-07 at 07:40 +0200, Andi Kleen wrote:
 > > > On Monday 07 August 2006 06:45, Rusty Russell wrote:
 > > > > Unfortunately, due to include cycles, we can't put these in
 > > > > paravirt.h: we use a separate header for these.
 > > > > =

 > > > > The implementation comes from Zach's [RFC, PATCH 10/24] i386 Vmi d=
escriptor changes:
 > > > > =

 > > > >   Descriptor and trap table cleanups.  Add cleanly written accesso=
rs for
 > > > >   IDT and GDT gates so the subarch may override them.  Note that t=
his
 > > > >   allows the hypervisor to transparently tweak the DPL of the desc=
riptors
 > > > >   as well as the RPL of segments in those descriptors, with no unn=
ecessary
 > > > >   kernel code modification.  It also allows the hypervisor impleme=
ntation
 > > > >   of the VMI to tweak the gates, allowing for custom exception fra=
mes or
 > > > >   extra layers of indirection above the guest fault / IRQ handlers.
 > > > =

 > > > Nice cleanup. The old assembly mess was ripe to be killed for a long=
 time.
 > > =

 > > OK, here's that patch extracted out.
 > =

 > Is there something wrong with your mailer? This one doesn't apply either:

Looks like it's against Linus' tree, not whatever you were trying against...
(13:19:10:davej@nwo:linux-2.6)$ cat ~/rusty | patch -p1 --dry-run
patching file arch/i386/kernel/traps.c
Hunk #1 succeeded at 1116 (offset 4 lines).
Hunk #3 succeeded at 1132 (offset 4 lines).
patching file include/asm-i386/desc.h
(13:19:15:davej@nwo:linux-2.6)$ =


		Dave

-- =

http://www.codemonkey.org.uk
