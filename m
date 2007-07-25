From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 1/7] lguest: documentation pt I: Preparation
Date: Wed, 25 Jul 2007 18:22:54 -0400
Message-ID: <200707251822.54745.rob__19757.0095341236$1185402285$gmane$org@landley.net>
References: <1184980678.6344.1.camel@localhost.localdomain>
	<20070723171238.1a832b31.akpm@linux-foundation.org>
	<1185238908.1803.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1185238908.1803.63.camel@localhost.localdomain>
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

On Monday 23 July 2007 9:01:48 pm Rusty Russell wrote:
> > IOW, I'd be interested in hearing Rob and Randy's opinions on it all,
> > please.
>
> So they can see what we're talking about, here's an example of the
> output:
>
> 	http://lguest.ozlabs.org/lguest-journey.c.bz2

Er, so you read the readme, and then you type "make Preparation!" (which I 
wouldn't have guessed from the comment at the end of the readme), and it 
spits this to stdout.  Ok, I can add "make 'Preparation!' > lguest.txt" to my 
update script so I can mirror a copy of the output on the web.

Are there any other build targets that produce documentation which I should 
know about?

> Cheers,
> Rusty.

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.
