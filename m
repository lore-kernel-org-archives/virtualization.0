From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/7] lguest: documentation pt I: Preparation
Date: Tue, 24 Jul 2007 11:01:48 +1000
Message-ID: <1185238908.1803.63.camel__45433.4408780143$1185239040$gmane$org@localhost.localdomain>
References: <1184980678.6344.1.camel@localhost.localdomain>
	<20070723171238.1a832b31.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070723171238.1a832b31.akpm@linux-foundation.org>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-07-23 at 17:12 -0700, Andrew Morton wrote:
> On Sat, 21 Jul 2007 11:17:58 +1000
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > The netfilter code had very good documentation: the Netfilter Hacking
> > HOWTO.  Noone ever read it.
> > 
> > So this time I'm trying something different, using a bit of
> > Knuthiness.  Start with drivers/lguest/README.
> 
> um.
> 
> I'm OK with merging patches and given lguest's newness, the timestamp on
> these patches, the fact that they don't change code generation (right?) and
> my reluctance to carry large do-nothing patches for two months, I'd be OK
> with squeaking them into 2.6.23.

Indeed, no code changes, and I feel strongly that it should go into
2.6.23 because it's *fun*.   And (as often complained) there's not
enough poetry in the kernel.

> But I worry that you're proposing adding what appears to be new
> Documentation-related machinery and infrastructure when there's already
> increased activity in that area from other people and we might all be
> headed in different directions and stuff.

It does add an lguest-specific script: I aimed for the minimal
documentation script required to weave the code and documentation
(basically extracts and orders by comment prefix, because code order
isn't the same as optimal documentation order).

This is great for lguest, where the entire codebase is small and
self-contained enough to be woven into a narrative, and the maintainer
is prepared to put in the cycles to keep it uptodate.

But writing this documentation took *weeks*, to document 5000 lines of
code.  Perhaps this effort, if merged, will inspire others, but I've
seen little indication so far: we have enough trouble getting them
documenting a single public function.

> IOW, I'd be interested in hearing Rob and Randy's opinions on it all,
> please.

So they can see what we're talking about, here's an example of the
output:

	http://lguest.ozlabs.org/lguest-journey.c.bz2

Cheers,
Rusty.
