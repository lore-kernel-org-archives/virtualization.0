From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/7] lguest: documentation pt I: Preparation
Date: Tue, 24 Jul 2007 13:27:39 +1000
Message-ID: <1185247659.1803.130.camel__23183.5922379561$1185247797$gmane$org@localhost.localdomain>
References: <1184980678.6344.1.camel@localhost.localdomain>
	<20070723171238.1a832b31.akpm@linux-foundation.org>
	<20070723192113.0eaa0ad8.rdunlap@xenotime.net>
	<20070723200617.87507f16.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070723200617.87507f16.rdunlap@xenotime.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-07-23 at 20:06 -0700, Randy Dunlap wrote:
> On Mon, 23 Jul 2007 19:21:13 -0700 Randy Dunlap wrote:
> > It's great that Rusty took the time to produce all of this documentation.
> > Few people do that today.

Thanks Randy, it was something of an experiment.  We'll see if it has
the desired effect (ie. encouraging new hackers).

> Neat as that is, I'm concerned that it will be difficult to maintain
> (the order numbers at least -- or are they just difficult to set up
> the first time?).

Setup was a pain, but maintenance hasn't been too bad.  Most changes
don't deeply alter the code structure.  After major surgery I diff the
documentation output to check I haven't broke anything major (eg.
removed a title or a section terminator).

> Advantage:  it does keep the source code + doc text together.
> Martin (former kernel-doc maintainer) was going to come up with
> some way to do this, but he abandoned it.

Yeah, code documentation like this belongs in comments IMHO, and even
there it can rot.

Thanks,
Rusty.
