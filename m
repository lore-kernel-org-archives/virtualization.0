From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/7] lguest documentation: infrastructure and Chapter I
Date: Fri, 08 Jun 2007 17:05:19 +1000
Message-ID: <1181286319.29842.39.camel__11699.1461989985$1181286415$gmane$org@localhost.localdomain>
References: <1181272257.24958.12.camel@localhost.localdomain>
	<20070607232349.b4673058.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070607232349.b4673058.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-06-07 at 23:23 -0700, Andrew Morton wrote:
> On Fri, 08 Jun 2007 13:10:57 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > The netfilter code had very good documentation: the Netfilter Hacking
> > HOWTO.  Noone ever read it.
> > 
> > So this time I'm trying something different, using a bit of
> > Knuthiness.
> > 
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > ---
> >  Documentation/lguest/extract          |   58 +++++++++++++++++++++++++++++++++
> >  Documentation/lguest/lguest.c         |    9 +++--
> >  drivers/lguest/Makefile               |   12 ++++++
> >  drivers/lguest/README                 |   47 ++++++++++++++++++++++++++
> >  drivers/lguest/core.c                 |    7 ++-
> >  drivers/lguest/hypercalls.c           |    9 +++--
> >  drivers/lguest/interrupts_and_traps.c |   13 +++++++
> >  drivers/lguest/io.c                   |    8 +++-
> >  drivers/lguest/lguest.c               |   31 ++++++++++++++++-
> >  drivers/lguest/lguest_bus.c           |    3 +
> >  drivers/lguest/lguest_user.c          |    7 +++
> >  drivers/lguest/page_tables.c          |   10 ++++-
> >  drivers/lguest/segments.c             |   11 ++++++
> >  drivers/lguest/switcher.S             |   13 +++----
> >  14 files changed, 219 insertions(+), 19 deletions(-)
> 
> This patch series craps all over the existing one:
> 
> lguest-export-symbols-for-lguest-as-a-module.patch
> lguest-the-guest-code.patch
> lguest-the-host-code.patch
> lguest-the-asm-offsets.patch
> lguest-the-makefile-and-kconfig.patch
> lguest-the-console-driver.patch
> lguest-the-net-driver.patch
> lguest-the-block-driver.patch
> lguest-the-documentation-example-launcher.patch
> 
> obviously we could append this new series to the existing one, but that
> limits our ability to make further changes over the next few weeks.  Or we
> just give up trying to present the series nicely and it hits mainline with
> a random stream of uninteresting and irrelevant afterthoughts at the end,
> like we're some lameo git users or something.

Well, I've been painfully maintaining that documentation patch for
months (it touches *everything*).  I *had* intended to send it straight
to Linus one he took lguest, but that may never happen.

Don't take it.  I'll push it to the end of my own series, send it direct
to Linus if and when.

> (I could split all this up, but I'm getting kinda bored of preventing you
> from mucking up your own patch series)

Little sympathy.  Perhaps there's a moral about timely merging here.

Rusty.
