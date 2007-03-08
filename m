From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 08 Mar 2007 12:33:56 -0800
Message-ID: <45F07334.7010207@goop.org>
References: <1173308717.24738.898.camel@localhost.localdomain> <45EF49E9.7040509@vmware.com> <1173313373.24738.937.camel@localhost.localdomain> <45EF6077.9090302@vmware.com> <20070308182456.GH19575@sequoia.sous-sol.org> <45F06720.8080901@goop.org> <20070308194740.GJ10574@sequoia.sous-sol.org> <45F06989.8030207@goop.org> <20070308201033.GK10574@sequoia.sous-sol.org> <45F06FB3.105@goop.org> <20070308202350.GL10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752145AbXCHUeA@vger.kernel.org>
In-Reply-To: <20070308202350.GL10574@sequoia.sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Daniel Arai <arai@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
>   
>> I guess by "rest of the kernel" you mean other stuff in arch/i386.  Yes,
>> that's a concern, but maybe we can tease it apart in a sensible way.
>>     
>
> Yes, that's exactly what I'm saying.  Same with above (the native stuff), since
> we don't want a bunch of apic_read type of pv_ops (oh, wait... ;-)  Of course,
> dom0 will be another can of worms, but one at a time.
>   

Yeah, well we're already talking about a two-level model to accomodate
VMI, since it wants the mostly native SMP stuff except for the actual
apic operations.

Maybe hooking into genapic is the right way to mop up all the uses of
send_IPI and its variants.  But from a quick grep it doesn't look like
they get called from too many places...  Most of the callers seem to be
in arch/i386/kernek/smp.c, so they should be pretty easy to isolate.

    J
