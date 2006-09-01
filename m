From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 4/9] Guest page hinting: volatile swap cache.
Date: Fri, 01 Sep 2006 17:33:22 +0200
Message-ID: <1157124802.21733.16.camel@localhost>
References: <20060901111006.GE15684@skybase>
	 <1157122713.28577.71.camel@localhost.localdomain>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751603AbWIAPd0@vger.kernel.org>
In-Reply-To: <1157122713.28577.71.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 07:58 -0700, Dave Hansen wrote:
> > +#if defined(CONFIG_PAGE_STATES)
> 
> This is a bit odd.  Why not use an #ifdef like the rest of the kernel?

Personal preference I guess. If you have multiple macros you want to
test for you need to use "#if defined(a) && defined(b)", there is no
equivalent #ifndef notation.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
