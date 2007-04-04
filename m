From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 04/17] Add pagetable accessors to pack and unpack
	pagetable entries
Date: Thu, 05 Apr 2007 08:59:09 +1000
Message-ID: <1175727549.12230.583.camel@localhost.localdomain>
References: <20070402055652.610711908@goop.org>
	<200704041347.42822.ak@suse.de> <4613C828.2030604@goop.org>
	<200704041756.35016.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704041756.35016.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-04-04 at 17:56 +0200, Andi Kleen wrote:
> On Wednesday 04 April 2007 17:45:44 Jeremy Fitzhardinge wrote:
> > Andi Kleen wrote:
> > > Why is there a difference for null syscall? I had assumed we patched =
all the =

> > > fast path cases relevant there. Do you have an idea where it comes fr=
om?
> > =

> > Sure.  There's indirect calls for things like sti/cli/iret.  It goes
> > back to native speed when you patch the real instructions inline.
> =

> I was talking about the patched case. It seemed to be a little slower
> too, but in theory it shouldn't have been, no? =


You'll still have the damage inflicted on gcc's optimizer, though.

Rusty.
