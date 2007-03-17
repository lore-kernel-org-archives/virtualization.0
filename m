From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH/RFC] replace get_scheduled_cycles with sched_clock paravirt_op
Date: Fri, 16 Mar 2007 17:43:16 -0700
Message-ID: <45FB39A4.5020706@goop.org>
References: <45F847E2.7040102@goop.org> <20070316163026.7a474142.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966006AbXCQAnW@vger.kernel.org>
In-Reply-To: <20070316163026.7a474142.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Hecht <dhecht@vmware.com>, Zachary Amsden <zach@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Wed, 14 Mar 2007 12:07:14 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> Subject: Add a sched_clock paravirt_op
>>
>> The tsc-based get_scheduled_cycles interface is not a good match for
>> Xen's runstate accounting, which reports everything in nanoseconds.
>>
>> This patch replaces this interface with a sched_clock interface, which
>> matches both Xen and VMI's requirements.
>>
>> In order to do this, we:
>>    1. replace get_scheduled_cycles with sched_clock
>>    2. hoist cycles_2_ns into a common header
>>    3. update vmi accordingly
>>
>> One thing to note: because sched_clock is implemented as a weak function in
>> kernel/sched.c, we must define a real function in order to override this weak
>> binding.  This means the usual paravirt_ops technique of using an inline
>> function won't work in this case.
>>     
>
> include/asm/paravirt.h: In function 'paravirt_sched_clock':
> include/asm/paravirt.h:281: warning: implicit declaration of function 'PVOP_CALL0'
> include/asm/paravirt.h:281: error: expected expression before 'unsigned'
>   

Sorry, I didn't intend for it to be picked up; it depends on stuff
earlier in the patch series.  I just wanted to check with the VMI folks
that it works for them in principle.

    J
