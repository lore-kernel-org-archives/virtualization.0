From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/5 -v2] Added generic lg.h in the include/linux
	directory
Date: Thu, 9 Aug 2007 08:19:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708090817360.29847__3462.51534433595$1186662112$gmane$org@gandalf.stny.rr.com>
References: <20070809043626.830486783@goodmis.org>
	<20070809044125.459178259@goodmis.org>
	<20070809153133.d5dff7b6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809153133.d5dff7b6.sfr@canb.auug.org.au>
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

> Hi Steven,
>
> I am just being pedantic here (and I should have beaten up on Rusty
> before now ...  :-)
>
> On Thu, 09 Aug 2007 00:36:30 -0400 Steven Rostedt <rostedt@goodmis.org>
> wrote:
> >
> > --- a/include/asm-i386/lg.h
> > +++ b/include/asm-i386/lg.h
> > @@ -1,5 +1,5 @@
> > -#ifndef _LGUEST_H
> > -#define _LGUEST_H
> > +#ifndef _I386_LGUEST_H
> > +#define _I386_LGUEST_H
>
> Maybe _ASM_LG_H or _I386_LG_H ? And there is a comment on the #endif at
> the end of the file that should match.
>
> > +++ b/include/linux/lg.h
> > @@ -0,0 +1,30 @@
> > +#ifndef _LINUX_LGUEST_H
> > +#define _LINUX_LGUEST_H
>
> Maybe _LINUX_LG_H ?
>
> Also (this is for Rusty) include/linux/lguest.h is protected by
> _ASM_LGUEST_H ...

Hah! in my lguest64 tree, I fixed all these. But I forgot to do the
changes when making the patches for upstream.  I'll make note and fix them
in my next patch series (unless Rusty can pull my stuff in now and then I
can apply on top of them ;-)

Thanks,

-- Steve
