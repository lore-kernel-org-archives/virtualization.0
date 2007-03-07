From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 11:05:25 -0800
Message-ID: <45EF0CF5.5090305@goop.org>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>  <45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>  <20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>  <1173178774.24738.311.camel@localhost.localdomain>  <45EDD82F.90204@vmware.com>  <1173225182.24738.507.camel@localhost.localdomain>  <45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>  <1173228544.24738.514.camel@localhost.localdomain>  <45EE0D10.7070807@vmware.com>  <1173230305.24738.529.camel@localhost.localdomain>  <45EE1EA3.90803@vmware.com> <1173256666.24738.576.camel@localhost.localdomain> <45EEF966.6060902@goop.org> <Line.LNX.4.64.0703071304080.1851@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992482AbXCGTFq@vger.kernel.org>
In-Reply-To: <Line.LNX.4.64.0703071304080.1851@d.namei>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: tglx@linutronix.de, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

James Morris wrote:
> It seems to me that it could be useful to have a library of common virtual 
> time code (entirely separate from pv_ops), to avoid re-implementing some 
> apparently common requirements, such as: handling TSC frequency changes, 
> stolen time accounting, synthetic programmable clockevent etc.
>   

Well, lets put our clock* implementations next to each other and see how
much common code there is to be factored out.

The Xen time code is pretty lean.  There's not much difference in
abstraction between the clocksource/event interface and the hypervisor
interface, so there's just not very much code there.

One immediate candidate is the scale_delta() function which does the
necessary cycles->tsc conversion.  I think that will be generally useful
and should be put somewhere common rather than copied.

I think stolen time is a bit more core, and in principle applies to
non-virtualized systems as well (such as time stolen by SMM and
discontinuities caused by suspend/resume).  The key piece is a monotonic
clock which advances while a vcpu is actually running on a real cpu,
since that should be used to determine how much time each process has
been running for.

Maybe it will just fall out if we start moving to a state-transition
process time accounting rather than the current sample-based one.  Is
there an actual plan to do that, or is it at the handwaving stage?

    J
