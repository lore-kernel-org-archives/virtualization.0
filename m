From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 17:31:14 +0200
Message-ID: <1157124674.21733.13.camel@localhost>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751551AbWIAPbW@vger.kernel.org>
In-Reply-To: <1157122667.28577.69.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu, Andy Whitcroft <apw@shadowen.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 07:57 -0700, Dave Hansen wrote:
> > +#define PG_state_change                21      /* HV page state is changing. */
> > +#define PG_discarded           22      /* HV page has been discarded. */ 
> 
> We're already desperately short on page flags on 32-bit architectures.
> It seems a wee bit silly to add two arch-generic flags for what is a
> very specialized arch-specific feature at this point.

There are even three additional page flags if you apply the full set of
patches.

> I know that there are 32-bit s390 kernels, but would this be a
> reasonable feature to restrict to only 64-bit kernels?  That might be a
> decent compromise.

Yes, it is definitly an option to make this a 64-bit only features. In
particular because the ESSA instruction that is used on s390 is only
available in zarch mode (=64 bit).

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
