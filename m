From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [locking/paravirt] static_key_disable_cpuslocked(): static key
	'virt_spin_lock_key+0x0/0x20' used before call to jump_label_init()
Date: Mon, 30 Oct 2017 16:43:33 +0800
Message-ID: <e2fc62e3-934c-5c24-da99-8efa706051d7__41576.7762613997$1511414645$gmane$org@cn.fujitsu.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
	<20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
	<20171030073509.23xtazsqrjuduqq5@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171030073509.23xtazsqrjuduqq5@wfg-t540p.sh.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fengguang Wu <fengguang.wu@intel.com>, Juergen Gross <jgross@suse.com>
Cc: boris.ostrovsky@oracle.com, jeremy@goop.org, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, rusty@rustcorp.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, hpa@zytor.com, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Fengguang,

There are two different warning.

At 10/30/2017 03:35 PM, Fengguang Wu wrote:
> On Sun, Oct 29, 2017 at 11:51:55PM +0100, Fengguang Wu wrote:
>> Hi Linus,
>>
>> Up to now we see the below boot error/warnings when testing v4.14-rc6.
>>

The original warning:

WARNING:at_arch/x86/events/intel/core.c:#intel_pmu_handle_irq: 1

in v4.14-rc6, which happens rarely.

>> They hit the RC release mainly due to various imperfections in 0day's
>> auto bisection. So I manually list them here and CC the likely easy to
>> debug ones to the corresponding maintainers in the followup emails.
>>
>> boot_successes: 4700
>> boot_failures: 247
>
> [...]
>
>> WARNING:at_kernel/jump_label.c:#static_key_disable_cpuslocked: 7
>

This is a new warning in tip tree, and the patch has sent[1].

[1]https://lkml.org/lkml/2017/10/28/4

we may need do it in v4.14-rc6, not in tip tree directly.

Thanks,
	dou.
