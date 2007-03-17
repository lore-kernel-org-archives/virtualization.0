From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH/RFC] replace get_scheduled_cycles with sched_clock
 paravirt_op
Date: Fri, 16 Mar 2007 16:30:26 -0800
Message-ID: <20070316163026.7a474142.akpm@linux-foundation.org>
References: <45F847E2.7040102@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932812AbXCQAac@vger.kernel.org>
In-Reply-To: <45F847E2.7040102@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Dan Hecht <dhecht@vmware.com>, Zachary Amsden <zach@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 14 Mar 2007 12:07:14 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Subject: Add a sched_clock paravirt_op
> 
> The tsc-based get_scheduled_cycles interface is not a good match for
> Xen's runstate accounting, which reports everything in nanoseconds.
> 
> This patch replaces this interface with a sched_clock interface, which
> matches both Xen and VMI's requirements.
> 
> In order to do this, we:
>    1. replace get_scheduled_cycles with sched_clock
>    2. hoist cycles_2_ns into a common header
>    3. update vmi accordingly
> 
> One thing to note: because sched_clock is implemented as a weak function in
> kernel/sched.c, we must define a real function in order to override this weak
> binding.  This means the usual paravirt_ops technique of using an inline
> function won't work in this case.

include/asm/paravirt.h: In function 'paravirt_sched_clock':
include/asm/paravirt.h:281: warning: implicit declaration of function 'PVOP_CALL0'
include/asm/paravirt.h:281: error: expected expression before 'unsigned'
