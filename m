From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 1/7] lguest: documentation pt I: Preparation
Date: Fri, 27 Jul 2007 14:32:07 -0400
Message-ID: <200707271432.07748.rob__28423.5992156484$1185561438$gmane$org@landley.net>
References: <1184980678.6344.1.camel@localhost.localdomain>
	<200707251822.54745.rob@landley.net>
	<1185420922.27447.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1185420922.27447.19.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 25 July 2007 11:35:22 pm Rusty Russell wrote:
> On Wed, 2007-07-25 at 18:22 -0400, Rob Landley wrote:
> > On Monday 23 July 2007 9:01:48 pm Rusty Russell wrote:
> > > > IOW, I'd be interested in hearing Rob and Randy's opinions on it all,
> > > > please.
> > >
> > > So they can see what we're talking about, here's an example of the
> > > output:
> > >
> > > 	http://lguest.ozlabs.org/lguest-journey.c.bz2
> >
> > Er, so you read the readme, and then you type "make Preparation!" (which
> > I wouldn't have guessed from the comment at the end of the readme), and
> > it spits this to stdout.
>
> Hi Rob!
>
> 	I'm going to ask an odd thing.  I *don't* think this should be part of
> the generally-available kernel documentation.  I'm sure you can see
> several reasons for this, but I'll spell them out for posterity.

Actually I don't see, but I'll respect the author's wishes when they don't 
want something indexed.

> 	People reading the lguest *code* documentation should feel a sense of
> achievement.

There are a number of areas of the kernel that give a deep sense of 
achievement upon figuring out what the heck is going on.  This includes 
theoretically documented ones, like the SCSI layer, which I'm working on but 
it makes my little brain hurt.

(Of course my brain hurts _more_ after reading yesterday's email from James 
Bottomley politely and thoroughly answering my first round of questions, but 
I now have a whole new mailing list to bother.  The fact I'm moving back to 
Austin this weekend and have to go pack a truck kind of screws up the 
scheduling of this, but I'll get back to making my brain hurt next week.)

> It starts with a slight puzzle, works its way through deep 
> details of code, and emerges with the reader feeling confident enough to
> start hacking on it.
>
> Thanks for your understanding!

Er, you're welcome?

> Rusty.

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.
