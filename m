From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/7] lguest: documentation pt I: Preparation
Date: Thu, 26 Jul 2007 13:35:22 +1000
Message-ID: <1185420922.27447.19.camel__41233.4989909597$1185421028$gmane$org@localhost.localdomain>
References: <1184980678.6344.1.camel@localhost.localdomain>
	<20070723171238.1a832b31.akpm@linux-foundation.org>
	<1185238908.1803.63.camel@localhost.localdomain>
	<200707251822.54745.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707251822.54745.rob@landley.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-07-25 at 18:22 -0400, Rob Landley wrote:
> On Monday 23 July 2007 9:01:48 pm Rusty Russell wrote:
> > > IOW, I'd be interested in hearing Rob and Randy's opinions on it all,
> > > please.
> >
> > So they can see what we're talking about, here's an example of the
> > output:
> >
> > 	http://lguest.ozlabs.org/lguest-journey.c.bz2
> 
> Er, so you read the readme, and then you type "make Preparation!" (which I 
> wouldn't have guessed from the comment at the end of the readme), and it 
> spits this to stdout.

Hi Rob!

	I'm going to ask an odd thing.  I *don't* think this should be part of
the generally-available kernel documentation.  I'm sure you can see
several reasons for this, but I'll spell them out for posterity.

	People reading the lguest *code* documentation should feel a sense of
achievement.  It starts with a slight puzzle, works its way through deep
details of code, and emerges with the reader feeling confident enough to
start hacking on it.

Thanks for your understanding!
Rusty.
