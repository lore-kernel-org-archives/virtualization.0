From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Thu, 16 Nov 2006 04:37:35 +0100
Message-ID: <20061116033735.GJ9579@bingen.suse.de>
References: <20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com>
	<200610271416.12548.ak@suse.de> <4546669F.8020706@vmware.com>
	<20061030225016.GA95732@muc.de>
	<20061115080323.GK1397@sequoia.sous-sol.org>
	<455ACDEC.7010808@vmware.com>
	<20061115224053.GO1397@sequoia.sous-sol.org>
	<20061116032702.GH9579@bingen.suse.de>
	<20061116033703.GV1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061116033703.GV1397@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 15, 2006 at 07:37:03PM -0800, Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
> > I got Andrew's patches now but the result doesn't compile as earlier
> > (on SUSE 10.0, gcc 4.0)
> > =

> > I'll adapt my old make-it-compile patch that fixed the inline assembly. =

> > Hopefully it'll work then.
> > =

> > -Andi
> > =

> > /home/lsrc/quilt/linux/kernel/spinlock.c: In function '_spin_lock_irqsa=
ve':
> > include2/asm/spinlock.h:59: error: invalid 'asm': operand number missin=
g after %
> > -letter
> > include2/asm/spinlock.h:59: error: invalid 'asm': operand number missin=
g after %
> > -letter
> > include2/asm/spinlock.h:59: error: invalid 'asm': operand number missin=
g after %
> > -letter
> > include2/asm/spinlock.h:59: error: invalid 'asm': operand number missin=
g after %
> > -letter
> > include2/asm/spinlock.h:59: error: invalid 'asm': operand number missin=
g after %
> > -letter
> > include2/asm/spinlock.h:59: error: invalid 'asm': operand number missin=
g after %
> > -letter
> > include2/asm/spinlock.h:59: error: invalid 'asm': operand number missin=
g after %
> > -letter
> > include2/asm/spinlock.h:59: error: invalid 'asm': operand number missin=
g after %
> > -letter
> > {standard input}: Assembler messages:
> > {standard input}:593: Error: undefined symbol `paravirt_ops' in operati=
on
> > {standard input}:593: Error: undefined symbol `PARAVIRT_irq_enable' in =
operation
> > {standard input}:605: Error: undefined symbol `paravirt_ops' in operati=
on
> > {standard input}:605: Error: undefined symbol `PARAVIRT_irq_disable' in=
 operation
> =

> That should be fixed (it is over here). =


Ok.

I think my old paravirt-broken diff fixed it too (among other things), but =
it =

would be better to use your version.


> Is ff quilt stuff uptodate?

Not yet.  I was just merging the latest -git. Will push it out soon.

> I can sync up with it and diff to see what you might be missing.

Please.

> =

> > ICECREAM[14067]: Compiled on 10.23.204.76
> =

> mmm, ice cream ;-)

It sometimes causes interesting effect with funky assembly -- e.g. .include=
 doesn't
work because the assembler runs on a different host. But that shouldn't be =
the
case here.

-Andi
