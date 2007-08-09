From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/7] Moved the io struct up to the generic lg.h
Date: Thu, 9 Aug 2007 08:40:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708090839460.29847@gandalf.stny.rr.com>
References: <20070809003211.373543702@goodmis.org>
	<20070809003343.664528532@goodmis.org>
	<20070809115156.ef5fdc6c.sfr@canb.auug.org.au>
	<46BB080F.4040905@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46BB080F.4040905@sgi.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jes Sorensen <jes@sgi.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, lguest <lguest@ozlabs.org>, Carsten Otte <cotte@de.ibm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


--
On Thu, 9 Aug 2007, Jes Sorensen wrote:

> Stephen Rothwell wrote:
> > On Wed, 08 Aug 2007 20:32:15 -0400 Steven Rostedt <rostedt@goodmis.org>
> > wrote:
> >> diff --git a/drivers/lguest/i386/lg.h b/drivers/lguest/i386/lg.h
> >> index 64f0abe..c5ea14c 100644
> >> --- a/drivers/lguest/i386/lg.h
> >> +++ b/drivers/lguest/i386/lg.h
> >> @@ -20,6 +20,8 @@
> >>  #include <linux/err.h>
> >>  #include <asm/semaphore.h>
> >>  #include "irq_vectors.h"
> >> +/* some files include this, some include the parent */
> >> +#include "../lg.h"
> >
> > Surely everything should just include the parent which allows for easier
> > consolidation over time. (as you are doing here)
>
> Whats wrong with introducing an include/asm-<arch>/lg.h and have the
> parent do #include <asm/lg.h> ? Seems much cleaner to me.

Seems cleaner to me to!  I think I'll do that.

Oh, wait! I did.  ;-)

-- Steve

P.S. Sorry, couldn't resist.
