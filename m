From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] lguest: host code tidyups
Date: Wed, 16 May 2007 09:32:16 +1000
Message-ID: <1179271936.23574.2.camel__8067.89673301882$1179272042$gmane$org@localhost.localdomain>
References: <1179191827.10836.24.camel@localhost.localdomain>
	<20070515214235.b0625699.sfr@canb.auug.org.au>
	<20070515214756.b8020d4e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070515214756.b8020d4e.sfr@canb.auug.org.au>
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
Cc: hch <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-05-15 at 21:47 +1000, Stephen Rothwell wrote:
> On Tue, 15 May 2007 21:42:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Tue, 15 May 2007 11:17:07 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > -		on_each_cpu(adjust_pge, 0, 0, 1);
> > > +		on_each_cpu(adjust_pge, (void *)0, 0, 1);
> >
> > Sorry?  What ever happened to a simple NULL?
> 
> Oh, I guess that is an explicit (numeric) 0 (of some type) caste to
> "void *" because of the prototype - rather than not passing anything?

Indeed.  We really want to pass a bool, but on_each_cpu uses a void *.
Hence the clearest solution seemed "(void *)0" and "(void *)1" in the
callers.

Thanks,
Rusty.
