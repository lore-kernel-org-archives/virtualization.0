From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2 0/3] x86/vdso: Add Hyper-V TSC page clocksource support
Date: Wed, 15 Feb 2017 15:01:42 +0100
Message-ID: <87y3x7zh6h.fsf@vitty.brq.redhat.com>
References: <20170214124408.25931-1-vkuznets@redhat.com>
	<alpine.DEB.2.20.1702141552360.3635@nanos>
	<87a89o22ml.fsf@vitty.brq.redhat.com>
	<CALCETrUNdemXG7GnehNus-EW2FDuTzB8HKW_3HUjhPt9ZNf45w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrUNdemXG7GnehNus-EW2FDuTzB8HKW_3HUjhPt9ZNf45w@mail.gmail.com>
	(Andy Lutomirski's message of "Tue, 14 Feb 2017 09:34:46 -0800")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Andy Lutomirski <luto@amacapital.net> writes:

> On Tue, Feb 14, 2017 at 7:50 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>
>>> On Tue, 14 Feb 2017, Vitaly Kuznetsov wrote:
>>>
>>>> Hi,
>>>>
>>>> while we're still waiting for a definitive ACK from Microsoft that the
>>>> algorithm is good for SMP case (as we can't prevent the code in vdso from
>>>> migrating between CPUs) I'd like to send v2 with some modifications to keep
>>>> the discussion going.
>>>
>>> Migration is irrelevant. The TSC page is guest global so updates will
>>> happen on some (random) host CPU and therefor you need the usual barriers
>>> like we have them in our seqcounts unless an access to the sequence will
>>> trap into the host, which would defeat the whole purpose of the TSC page.
>>>
>>
>> KY Srinivasan <kys@microsoft.com> writes:
>>
>>> I checked with the folks on the Hyper-V side and they have confirmed that we need to
>>> add memory barriers in the guest code to ensure the various reads from the TSC page are
>>> correctly ordered - especially, the initial read of the sequence counter must have acquire
>>> semantics. We should ensure that other reads from the TSC page are completed before the
>>> second read of the sequence counter. I am working with the Windows team to correctly
>>> reflect this algorithm in the Hyper-V specification.
>>
>>
>> Thank you,
>>
>> do I get it right that combining the above I only need to replace
>> virt_rmb() barriers with plain rmb() to get 'lfence' in hv_read_tsc_page
>> (PATCH 2)? As members of struct ms_hyperv_tsc_page are volatile we don't
>> need READ_ONCE(), compilers are not allowed to merge accesses. The
>> resulting code looks good to me:
>
> No, on multiple counts, unfortunately.
>
> 1. LFENCE is basically useless except for IO and for (Intel only)
> rdtsc_ordered().  AFAIK there is literally no scenario under which
> LFENCE is useful for access to normal memory.
>

Interesting,

(For some reason I was under the impression that when I do

READ var1 -> reg1
READ var2 -> reg2

from normal memory reads can actually happen in any order and LFENCE
in between gives us strict ordering.) But I completely agree it wouldn't
help in situations you descibe below:

> 2. The problem here has little to do with barriers.  You're doing:
>
> read seq;
> read var1;
> read var2;
> read tsc;
> read seq again;
>
> If the hypervisor updates things between reading var1 and var2 or
> between reading var2 and tsc, you aren't guaranteed to notice unless
> something fancy is going on regardless of barriers.  Similarly, if the
> hypervisor starts updating, then you start and finish the whole
> function, and then the hypervisor finishes, what guarantees you
> notice?
>
> This really needs a spec from the hypervisor folks as to what's going
> on.  KVM does this horrible thing in which it sometimes freezes all
> vCPUs when updating, for better or for worse.  Mostly for worse.  If
> MS does the same thing, they should document it.

... so I'll have to summon K. Y. again and ask him to use his magic
powers to extract some info from the Hyper-V team. As we have TSC page
clocksource for quite a while now and no bugs were reported there should
be something.

Actually, we already have an implementation of TSC page update in KVM
(see arch/x86/kvm/hyperv.c, kvm_hv_setup_tsc_page()) and the update does
the following:

0) stash seq into seq_prev
1) seq = 0 making all reads from the page invalid
2) smp_wmb()
3) update tsc_scale, tsc_offset
4) smp_wmb()
5) set seq = seq_prev + 1

As far as I understand this helps with situations you described above as
guest will notice either invalid value of 0 or seq change. In case the
implementation in real Hyper-V is the same we're safe with compile
barriers only.

>
> 3. You need rdtsc_ordered().  Plain RDTSC is not ordered wrt other
> memory access, and it can observably screw up as a result.

Another interesting thing is if we look at how this is implemented in
Windows (see linux.git commit c35b82ef0294) there are no barriers there
even for rdtsc...

>
> Also, Linux tries to avoid volatile variables, so please use READ_ONCE().
>

Will do both of the above in my next submission, thanks for the feedback!

[snip]

-- 
  Vitaly
