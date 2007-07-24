From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] lguest: documentation pt I: Preparation
Date: Mon, 23 Jul 2007 17:12:38 -0700
Message-ID: <20070723171238.1a832b31.akpm__31175.5042327151$1185236202$gmane$org@linux-foundation.org>
References: <1184980678.6344.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184980678.6344.1.camel@localhost.localdomain>
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
Cc: lkml@smtp2.linux-foundation.org, List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Rob Landley <rob@landley.net>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 21 Jul 2007 11:17:58 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> The netfilter code had very good documentation: the Netfilter Hacking
> HOWTO.  Noone ever read it.
> 
> So this time I'm trying something different, using a bit of
> Knuthiness.  Start with drivers/lguest/README.

um.

I'm OK with merging patches and given lguest's newness, the timestamp on
these patches, the fact that they don't change code generation (right?) and
my reluctance to carry large do-nothing patches for two months, I'd be OK
with squeaking them into 2.6.23.

But I worry that you're proposing adding what appears to be new
Documentation-related machinery and infrastructure when there's already
increased activity in that area from other people and we might all be
headed in different directions and stuff.

So first I think we'd best form a kernel kommittee and mull this for a
while (preferably months) to screw you around as much as poss, OK?  ;)

Items for consideration would be:

- if this stuff is good, shouldn't other code be using it?  If so, is
  this new infrastructure in the correct place?

- if, otoh, this infrastructure is _not_ suitable for other code, well,
  what was wrong with it?

- if the requirement is good, perhaps alternative implementations should
  be explored (dunno what).


IOW, I'd be interested in hearing Rob and Randy's opinions on it all,
please.
