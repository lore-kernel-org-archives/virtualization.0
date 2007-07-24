From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] lguest: documentation pt I: Preparation
Date: Mon, 23 Jul 2007 18:20:27 -0700
Message-ID: <20070723182027.ebe04818.akpm__26139.3251982101$1185240177$gmane$org@linux-foundation.org>
References: <1184980678.6344.1.camel@localhost.localdomain>
	<20070723171238.1a832b31.akpm@linux-foundation.org>
	<1185238908.1803.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1185238908.1803.63.camel@localhost.localdomain>
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

On Tue, 24 Jul 2007 11:01:48 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> > But I worry that you're proposing adding what appears to be new
> > Documentation-related machinery and infrastructure when there's already
> > increased activity in that area from other people and we might all be
> > headed in different directions and stuff.
> 
> It does add an lguest-specific script: I aimed for the minimal
> documentation script required to weave the code and documentation
> (basically extracts and orders by comment prefix, because code order
> isn't the same as optimal documentation order).
> 
> This is great for lguest, where the entire codebase is small and
> self-contained enough to be woven into a narrative, and the maintainer
> is prepared to put in the cycles to keep it uptodate.
> 
> But writing this documentation took *weeks*, to document 5000 lines of
> code.  Perhaps this effort, if merged, will inspire others, but I've
> seen little indication so far: we have enough trouble getting them
> documenting a single public function.

Yeah, I suspect there will be insufficient interest and energy for anyone
else to take this anywhere.

Could you please redo the changes after "link lguest example launcher
non-static", which made a fairly big mess?
