From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 0/6] Guest page hinting version 6.
Date: Thu, 13 Mar 2008 10:47:07 +0100
Message-ID: <1205401627.26537.40.camel@localhost>
References: <20080312132132.520833247@de.ibm.com>
	 <200803130941.48480.rusty@rustcorp.com.au>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754863AbYCMJrZ@vger.kernel.org>
In-Reply-To: <200803130941.48480.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, hugh@veritas.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-03-13 at 09:41 +1100, Rusty Russell wrote:
> On Thursday 13 March 2008 00:21:32 Martin Schwidefsky wrote:
> > My question now is how to proceed with the code. I sure
> > would love to see the code going upstream some day but that depends on
> > the mm developers as the code adds complexity that needs to be supported.
> 
> Well, I want this feature, but I agree about complexity.
> 
> AFAICT, the trivial subset of this is the hinting of Unused pages.  It seems 
> that would buy us something, and perhaps be a stepping stone to full page 
> hinting?

I've been there but the unused page thing is so small that it doesn't
make sense to separate it from the patches. If I don't see any progress
then I will come up with a patch that adds the Unused state transitions
to the arch files of s390.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
