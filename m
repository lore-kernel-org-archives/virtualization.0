From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 17/17] Add a sched_clock paravirt_op
Date: Mon, 2 Apr 2007 08:50:32 +0200
Message-ID: <200704020850.32274.ak@suse.de>
References: <20070402055652.610711908@goop.org>
	<200704020809.42373.ak@suse.de> <4610A70A.7010105@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4610A70A.7010105@goop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization@lists.osdl.org, john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 02 April 2007 08:47, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > I think it would be much cleaner if you didn't implement your own sched=
_clock,
> > but you adjust ns_base/last_tsc to account for your lost cycles.
> > This could be done cleanly by adding a new function to sched-clock.c
> > Possibly such a function could be used by other parts of the kernel
> > in the future too.
> >   =

> =

> Cleaner how?  This seems pretty to me.  Xen can return a
> clock measuring unstolen nanoseconds, =


Do you also get a clock for stolen nanoseconds? =


> which maps directly to the =

> sched_clock interface, doesn't need any of the existing sched_clock
> code.  I suppose I could map the Xen interface onto some abstract
> "cycles" notion and hook it into the tsc machinery, but it seems like it
> would be a forced fit.  In general, my approach has been to choose the
> higher-level interface over a lower-level one, all other things being equ=
al.

No need for cycles, you could just subtract the stolen ns if you
can get those.

-Andi
