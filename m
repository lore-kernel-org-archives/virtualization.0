From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Wed, 15 Nov 2006 21:06:30 -0800
Message-ID: <20061115210630.94bf8824.akpm@osdl.org>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
	<20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com>
	<200610271416.12548.ak@suse.de> <4546669F.8020706@vmware.com>
	<20061030225016.GA95732@muc.de>
	<20061115080323.GK1397@sequoia.sous-sol.org>
	<455ACDEC.7010808@vmware.com>
	<20061115224053.GO1397@sequoia.sous-sol.org>
	<20061116032702.GH9579@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061116032702.GH9579@bingen.suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 16 Nov 2006 04:27:02 +0100
Andi Kleen <ak@suse.de> wrote:

> On Wed, Nov 15, 2006 at 02:40:53PM -0800, Chris Wright wrote:
> > * Zachary Amsden (zach@vmware.com) wrote:
> > > I'm a little worried after seeing failures to apply and missed patche=
s =

> > > that we could have other things missing from the upstream path.  Is =

> > > there an easy way for us to look at diffs between the trees?  Just a =

> > > diff on arch/i386 and include/asm-i386 would tell me wonders, no matt=
er =

> > > how much extra activity has gone on there.
> > =

> > Last night I rebased against 2.6.15-mm2.  I'm adding four patches that
> > Andrew sent Andi last night.  I'll rediff and see what (if anything) is
> > outstanding.
> =

> I got Andrew's patches now but the result doesn't compile as earlier
> (on SUSE 10.0, gcc 4.0)
> =

> I'll adapt my old make-it-compile patch that fixed the inline assembly. =

> Hopefully it'll work then.
> =

> -Andi
> =

> /home/lsrc/quilt/linux/kernel/spinlock.c: In function '_spin_lock_irqsave=
':
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing =
after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing =
after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing =
after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing =
after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing =
after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing =
after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing =
after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing =
after %
> -letter
> {standard input}: Assembler messages:
> {standard input}:593: Error: undefined symbol `paravirt_ops' in operation
> {standard input}:593: Error: undefined symbol `PARAVIRT_irq_enable' in op=
eration
> {standard input}:605: Error: undefined symbol `paravirt_ops' in operation
> {standard input}:605: Error: undefined symbol `PARAVIRT_irq_disable' in o=
peratio
> n
> ICECREAM[14067]: Compiled on 10.23.204.76
> =


wtf?  How come patches leave here in working order and keep arriving broken?
