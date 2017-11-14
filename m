From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH RFC v3 1/6] x86/paravirt: Add pv_idle_ops to paravirt ops
Date: Tue, 14 Nov 2017 15:12:56 +0800
Message-ID: <CANRm+CxirO0aSAQnOfPG0+KPCOnXf3SEASwBiprLmtncZE53pA__40899.925484746$1510643588$gmane$org@mail.gmail.com>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
	<1510567565-5118-2-git-send-email-quan.xu0@gmail.com>
	<07fac696-e3d4-8f35-8f3d-764d7ab41204@suse.com>
	<902da704-1e4f-583b-91c3-1a62ccd6e73d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <902da704-1e4f-583b-91c3-1a62ccd6e73d@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Quan Xu <quan.xu0@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, Yang Zhang <yang.zhang.wz@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, kvm <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Quan Xu <quan.xu03@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

2017-11-14 15:02 GMT+08:00 Quan Xu <quan.xu0@gmail.com>:
>
>
> On 2017/11/13 18:53, Juergen Gross wrote:
>>
>> On 13/11/17 11:06, Quan Xu wrote:
>>>
>>> From: Quan Xu <quan.xu0@gmail.com>
>>>
>>> So far, pv_idle_ops.poll is the only ops for pv_idle. .poll is called
>>> in idle path which will poll for a while before we enter the real idle
>>> state.
>>>
>>> In virtualization, idle path includes several heavy operations
>>> includes timer access(LAPIC timer or TSC deadline timer) which will
>>> hurt performance especially for latency intensive workload like message
>>> passing task. The cost is mainly from the vmexit which is a hardware
>>> context switch between virtual machine and hypervisor. Our solution is
>>> to poll for a while and do not enter real idle path if we can get the
>>> schedule event during polling.
>>>
>>> Poll may cause the CPU waste so we adopt a smart polling mechanism to
>>> reduce the useless poll.
>>>
>>> Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
>>> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: Alok Kataria <akataria@vmware.com>
>>> Cc: Rusty Russell <rusty@rustcorp.com.au>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: x86@kernel.org
>>> Cc: virtualization@lists.linux-foundation.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: xen-devel@lists.xenproject.org
>>
>> Hmm, is the idle entry path really so critical to performance that a new
>> pvops function is necessary?
>
> Juergen, Here is the data we get when running benchmark netperf:
>  1. w/o patch and disable kvm dynamic poll (halt_poll_ns=0):
>     29031.6 bit/s -- 76.1 %CPU
>
>  2. w/ patch and disable kvm dynamic poll (halt_poll_ns=0):
>     35787.7 bit/s -- 129.4 %CPU
>
>  3. w/ kvm dynamic poll:
>     35735.6 bit/s -- 200.0 %CPU

Actually we can reduce the CPU utilization by sleeping a period of
time as what has already been done in the poll logic of IO subsystem,
then we can improve the algorithm in kvm instead of introduing another
duplicate one in the kvm guest.

Regards,
Wanpeng Li

>
>  4. w/patch and w/ kvm dynamic poll:
>     42225.3 bit/s -- 198.7 %CPU
>
>  5. idle=poll
>     37081.7 bit/s -- 998.1 %CPU
>
>
>
>  w/ this patch, we will improve performance by 23%.. even we could improve
>  performance by 45.4%, if we use w/patch and w/ kvm dynamic poll. also the
>  cost of CPU is much lower than 'idle=poll' case..
>
>> Wouldn't a function pointer, maybe guarded
>> by a static key, be enough? A further advantage would be that this would
>> work on other architectures, too.
>
>
> I assume this feature will be ported to other archs.. a new pvops makes code
> clean and easy to maintain. also I tried to add it into existed pvops, but
> it
> doesn't match.
>
>
>
> Quan
> Alibaba Cloud
>>
>>
>> Juergen
>>
>
