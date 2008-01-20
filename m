From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: [kvm-devel] [PATCH] KVM simplified virtio balloon driver
Date: Sat, 19 Jan 2008 22:24:33 -0200
Message-ID: <20080120002433.GA6880__1813.56069301746$1200788671$gmane$org@dmt>
References: <20080114200357.GA18354@dmt> <20080115190102.GA27645@dmt>
	<1200525166.26281.103.camel@localhost.localdomain>
	<200801171245.59510.rusty@rustcorp.com.au>
	<4791A085.8060502__30665.5007684187$1200726687$gmane$org@qumranet.com>
	<47927BB7.7060805@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47927BB7.7060805@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jan 19, 2008 at 04:37:43PM -0600, Anthony Liguori wrote:
> Avi Kivity wrote:
> >Rusty Russell wrote:
> >>After discussions with Anthony Liguori, it seems that the virtio
> >>balloon can be made even simpler.  Here's my attempt.
> >>
> >>Since the balloon requires Guest cooperation anyway, there seems
> >>little reason to force it to tell the Host when it wants to reuse a
> >>page.  It can simply fault it in.
> >>
> >>  
> >
> >Faulting is synchronous, while deflating is (or can be made) 
> >asynchronous. If the host needs to do some work to get the memory, the 
> >guest will be slowed down considerably.
> 
> Good point.  Basically, we have two page hinting operations which 
> roughly correspond to madvise(MADV_DONTNEED) and madvise(MADV_WILLNEED).

Also, the simplified driver does not handle errors at all.

I don't think that assuming madvise() can't fail is a good thing.
