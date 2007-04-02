From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 17/17] Add a sched_clock paravirt_op
Date: Sun, 01 Apr 2007 23:47:38 -0700
Message-ID: <4610A70A.7010105@goop.org>
References: <20070402055652.610711908@goop.org> <20070402055705.606126251@goop.org> <200704020809.42373.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932339AbXDBGrw@vger.kernel.org>
In-Reply-To: <200704020809.42373.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Dan Hecht <dhecht@vmware.com>, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> I think it would be much cleaner if you didn't implement your own sched_clock,
> but you adjust ns_base/last_tsc to account for your lost cycles.
> This could be done cleanly by adding a new function to sched-clock.c
> Possibly such a function could be used by other parts of the kernel
> in the future too.
>   

Cleaner how?  This seems pretty straightforward to me.  Xen can return a
clock measuring unstolen nanoseconds, which maps directly to the
sched_clock interface, doesn't need any of the existing sched_clock
code.  I suppose I could map the Xen interface onto some abstract
"cycles" notion and hook it into the tsc machinery, but it seems like it
would be a forced fit.  In general, my approach has been to choose the
higher-level interface over a lower-level one, all other things being equal.

The only reason I hoisted the cycles_2_ns stuff was for vmi.  It returns
a tsc-like cycles interface, and so it can make use of the existing
cycles_2_ns code (though I don't think a changing timebase is an issue).

    J
