From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Wed, 15 Nov 2006 19:37:03 -0800
Message-ID: <20061116033703.GV1397@sequoia.sous-sol.org>
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
Content-Disposition: inline
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

* Andi Kleen (ak@suse.de) wrote:
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
peration

That should be fixed (it is over here).  Is ff quilt stuff uptodate?
I can sync up with it and diff to see what you might be missing.

> ICECREAM[14067]: Compiled on 10.23.204.76

mmm, ice cream ;-)

thanks,
-chris
