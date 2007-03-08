From: Daniel Arai <arai@vmware.com>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 08 Mar 2007 10:44:41 -0800
Message-ID: <45F05999.20803@vmware.com>
References: <45EEF966.6060902@goop.org> <Line.LNX.4.64.0703071304080.1851@d.namei> <45EF0CF5.5090305@goop.org> <45EF175D.6030609@vmware.com> <1173302503.24738.795.camel@localhost.localdomain> <45EF372E.7030600@goop.org> <1173308717.24738.898.camel@localhost.localdomain> <45EF49E9.7040509@vmware.com> <1173313373.24738.937.camel@localhost.localdomain> <45EF6077.9090302@vmware.com> <20070308182456.GH19575@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933030AbXCHSoq@vger.kernel.org>
In-Reply-To: <20070308182456.GH19575@sequoia.sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: tglx@linutronix.de, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Daniel Arai (arai@vmware.com) wrote:
> 
>>There's no good way to override __send_IPI_shortcut.  I suppose we could add 
>>paravirt ops for __send_IPI_shortcut and every other op that touches the APIC. 
> 
> 
> While that's basically what we did in Xen, it would make more sense to
> build it into genapic which would give us one common abstraction to base
> from.  We should avoid adding pv_ops when existing infrastructure exists.

I agree with this.

Chris, would you like to work together on this?  I don't know what Xen's 
requirements are for the APIC interface.  Do you think we could come up with 
something that would fit both of our needs, and maybe also be usable for some of 
the subarch-specific code?

Dan.
