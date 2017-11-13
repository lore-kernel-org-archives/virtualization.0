From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH RFC v3 1/6] x86/paravirt: Add pv_idle_ops to paravirt ops
Date: Mon, 13 Nov 2017 19:09:09 +0800
Message-ID: <CANRm+CwWu-h96wxePS6kHMFquQR1_jxt1hyHcgu-Cs0rcNCBZw__25746.0655215711$1510571361$gmane$org@mail.gmail.com>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
	<1510567565-5118-2-git-send-email-quan.xu0@gmail.com>
	<07fac696-e3d4-8f35-8f3d-764d7ab41204@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <07fac696-e3d4-8f35-8f3d-764d7ab41204@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, Quan Xu <quan.xu0@gmail.com>, kvm <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Quan Xu <quan.xu03@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

2017-11-13 18:53 GMT+08:00 Juergen Gross <jgross@suse.com>:
> On 13/11/17 11:06, Quan Xu wrote:
>> From: Quan Xu <quan.xu0@gmail.com>
>>
>> So far, pv_idle_ops.poll is the only ops for pv_idle. .poll is called
>> in idle path which will poll for a while before we enter the real idle
>> state.
>>
>> In virtualization, idle path includes several heavy operations
>> includes timer access(LAPIC timer or TSC deadline timer) which will
>> hurt performance especially for latency intensive workload like message
>> passing task. The cost is mainly from the vmexit which is a hardware
>> context switch between virtual machine and hypervisor. Our solution is
>> to poll for a while and do not enter real idle path if we can get the
>> schedule event during polling.
>>
>> Poll may cause the CPU waste so we adopt a smart polling mechanism to
>> reduce the useless poll.
>>
>> Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
>> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Alok Kataria <akataria@vmware.com>
>> Cc: Rusty Russell <rusty@rustcorp.com.au>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: virtualization@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: xen-devel@lists.xenproject.org
>
> Hmm, is the idle entry path really so critical to performance that a new
> pvops function is necessary? Wouldn't a function pointer, maybe guarded
> by a static key, be enough? A further advantage would be that this would
> work on other architectures, too.

There is a "Adaptive halt-polling" which are merged to upstream more
than two years ago avoids to thread the critical path and has already
been ported to other architectures. https://lkml.org/lkml/2015/9/3/615

Regards,
Wanpeng Li
