From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 4/9] Guest page hinting: volatile swap cache.
Date: Fri, 01 Sep 2006 08:52:19 -0700
Message-ID: <1157125939.28577.100.camel@localhost.localdomain>
References: <20060901111006.GE15684@skybase>
	 <1157123046.28577.75.camel@localhost.localdomain>
	 <1157125031.21733.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751686AbWIAPwn@vger.kernel.org>
In-Reply-To: <1157125031.21733.21.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 17:37 +0200, Martin Schwidefsky wrote:
> On Fri, 2006-09-01 at 08:04 -0700, Dave Hansen wrote:
> > > +EXPORT_SYMBOL(find_get_page_nodiscard);
> > > +
> > > +#endif
> > 
> > Is it worth having another full copy of find_get_page()?  What about a
> > "nodiscard" argument?
> 
> That is a hard call to make. I really tried hard to avoid adding any
> overhead to a system running without the feature.

The overhead being the extra (potentially unused) argument to the
function?  Plus, that the function isn't inlined and thus will be unable
to have its argument optimized away?

In the worse case, we're talking about the cost of saving and restoring
the contents of a single register to the stack.  In other arches, we're
talking about the push of an immediate on the stack for the call.

Yeah, it is a hard call to make, especially if you're aiming for
zero-impact.

-- Dave
