From: Andi Kleen <ak@suse.de>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 19:22:43 +0200
Message-ID: <20070428172243.GC29316@bingen.suse.de>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<1177775271.3688.30.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177775271.3688.30.camel@mulgrave.il.steeleye.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

> I got a bit tired of trying to be proactive.  The last time was for the
> %gs per cpu thing, which I saw coming.  The basic problem is that
> there's no well organised git tree I can pull from and bisect to trace
> problems.

There is a quilt tree as documented in MAINTAINERS

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/

It is fully bisectable (relative to 
ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/BASEKERNEL)
and everything. 

It is also possible to generate git trees from this using some
simple scripts if you really need git for something (I do this 
for my merges to Linus). 

But the reason -- similar to Andrew -- i don't keep a continuous
git mirror of the quilt tree is that patch ordering etc. might
change anytime and it is hard to express that in a continuous
git tree. Instead I just generate the git branches on demand
from some fixed state for merging.

> My strategy now is to wait for the merge window to close and then go
> around sweeping up the mess and yelling at the offenders ... it's what
> all the non-x86 architectures do, and it's definitely an easier process.

Fine too.  Since you're effectively the only Voyager user anyways
that's a great model.

-Andi
