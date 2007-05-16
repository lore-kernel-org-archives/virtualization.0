From: hch <hch@infradead.org>
Subject: Re: [PATCH 1/6] lguest: host code tidyups
Date: Wed, 16 May 2007 08:00:15 +0100
Message-ID: <20070516070015.GA13980__6137.97214250571$1179298949$gmane$org@infradead.org>
References: <1179191827.10836.24.camel@localhost.localdomain>
	<20070515214235.b0625699.sfr@canb.auug.org.au>
	<20070515214756.b8020d4e.sfr@canb.auug.org.au>
	<1179271936.23574.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1179271936.23574.2.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, hch <hch@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 16, 2007 at 09:32:16AM +1000, Rusty Russell wrote:
> On Tue, 2007-05-15 at 21:47 +1000, Stephen Rothwell wrote:
> > On Tue, 15 May 2007 21:42:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > On Tue, 15 May 2007 11:17:07 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > > -		on_each_cpu(adjust_pge, 0, 0, 1);
> > > > +		on_each_cpu(adjust_pge, (void *)0, 0, 1);
> > >
> > > Sorry?  What ever happened to a simple NULL?
> > 
> > Oh, I guess that is an explicit (numeric) 0 (of some type) caste to
> > "void *" because of the prototype - rather than not passing anything?
> 
> Indeed.  We really want to pass a bool, but on_each_cpu uses a void *.
> Hence the clearest solution seemed "(void *)0" and "(void *)1" in the
> callers.

Cleanest way to do that is to pass the value by reference.

	const int some_useful_name = 0;

	 on_each_cpu(adjust_pge, &some_useful_name, 0, 1);
