From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/7] Moved the io struct up to the generic lg.h
Date: Wed, 8 Aug 2007 22:19:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708082217470.19189__34103.2682605602$1186626090$gmane$org@gandalf.stny.rr.com>
References: <20070809003211.373543702@goodmis.org>
	<20070809003343.664528532@goodmis.org>
	<20070809115156.ef5fdc6c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809115156.ef5fdc6c.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, Jes Sorensen <jes@sgi.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


--
On Thu, 9 Aug 2007, Stephen Rothwell wrote:

> On Wed, 08 Aug 2007 20:32:15 -0400 Steven Rostedt <rostedt@goodmis.org>
> wrote:
> >
> > diff --git a/drivers/lguest/i386/lg.h b/drivers/lguest/i386/lg.h
> > index 64f0abe..c5ea14c 100644
> > --- a/drivers/lguest/i386/lg.h
> > +++ b/drivers/lguest/i386/lg.h
> > @@ -20,6 +20,8 @@
> >  #include <linux/err.h>
> >  #include <asm/semaphore.h>
> >  #include "irq_vectors.h"
> > +/* some files include this, some include the parent */
> > +#include "../lg.h"
>
> Surely everything should just include the parent which allows for easier
> consolidation over time. (as you are doing here)

Yeah, that sounds better. This was my attempt at not modifing the
i386/ stuff too much.  But I can have those files change to do a "../lg.h"
include.  Again, doing the move plus change to keep things building. Hmm,
I guess git can handle that.

>
> > --- a/drivers/lguest/lg.h
> > +++ b/drivers/lguest/lg.h
> > @@ -1,3 +1,19 @@
> > +#ifndef _LGUEST_LG_GENERIC
> > +#define _LGUEST_LG_GENERIC
>
> Maybe _LGUEST_LG_H?  and the arch ones could use _LGUEST_I386_LG_H etc.

Noted. Will do in the next release.

Thanks,

-- Steve
