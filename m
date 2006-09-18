From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Mon, 18 Sep 2006 10:08:17 +0200
Message-ID: <1158566897.5728.2.camel@localhost>
References: <200609151352_MC3-1-CB54-526A@compuserve.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965539AbWIRIIW@vger.kernel.org>
In-Reply-To: <200609151352_MC3-1-CB54-526A@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-15 at 13:50 -0400, Chuck Ebbert wrote:
> > I wonder which trick you use, since there is only one page table one
> > i386 I can only imagine that you are tracking all page tables of the
> > guest.
> 
> AMD K8 with the SVM feature has host and guest page tables and
> address-space identifiers for the guests so their global TLB flushes
> can be limited to their own address space...

Yeah, I know about the nested page tables on K8. But VMware will not
restrict themselves to K8 only, so they need a clever way to implement
shadow page tables on i386 chips without this feature.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
