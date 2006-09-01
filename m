From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 4/9] Guest page hinting: volatile swap cache.
Date: Fri, 01 Sep 2006 17:37:11 +0200
Message-ID: <1157125031.21733.21.camel@localhost>
References: <20060901111006.GE15684@skybase>
	 <1157123046.28577.75.camel@localhost.localdomain>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751639AbWIAPhV@vger.kernel.org>
In-Reply-To: <1157123046.28577.75.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 08:04 -0700, Dave Hansen wrote:
> > +EXPORT_SYMBOL(find_get_page_nodiscard);
> > +
> > +#endif
> 
> Is it worth having another full copy of find_get_page()?  What about a
> "nodiscard" argument?

That is a hard call to make. I really tried hard to avoid adding any
overhead to a system running without the feature.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
