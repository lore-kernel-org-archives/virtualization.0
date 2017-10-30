From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [locking/paravirt] static_key_disable_cpuslocked(): static key
	'virt_spin_lock_key+0x0/0x20' used before call to jump_label_init()
Date: Mon, 30 Oct 2017 10:56:54 +0100
Message-ID: <20171030095654.nmj5tjhrske4zoeq@wfg-t540p.sh.intel.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
	<20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
	<20171030073509.23xtazsqrjuduqq5@wfg-t540p.sh.intel.com>
	<f542f9af-70e1-b3e9-fdda-4a83af71fc99@suse.com>
	<20171030083835.kirbygtl3qneg6ab@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171030083835.kirbygtl3qneg6ab@wfg-t540p.sh.intel.com>
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
Cc: boris.ostrovsky@oracle.com, jeremy@goop.org, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, rusty@rustcorp.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, hpa@zytor.com, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 30, 2017 at 09:38:35AM +0100, Fengguang Wu wrote:
>On Mon, Oct 30, 2017 at 08:47:08AM +0100, Juergen Gross wrote:
>>On 30/10/17 08:35, Fengguang Wu wrote:
>>> On Sun, Oct 29, 2017 at 11:51:55PM +0100, Fengguang Wu wrote:
>>>> Hi Linus,
>>>>
>>>> Up to now we see the below boot error/warnings when testing v4.14-rc6.
>>>>
>>>> They hit the RC release mainly due to various imperfections in 0day's
>>>> auto bisection. So I manually list them here and CC the likely easy to
>>>> debug ones to the corresponding maintainers in the followup emails.
>>>>
>>>> boot_successes: 4700
>>>> boot_failures: 247
>>>
>>> [...]
>>>
>>>> WARNING:at_kernel/jump_label.c:#static_key_disable_cpuslocked: 7
>>
>>This patch is in the tip tree only, it will be merged in 4.15. So I
>>don't understand why you are reporting this for 4.14-rc6.
>
>Ah sorry, I simply checked recent bisects for that warning.
>Then I'll need to carry out some new bisect on 4.14-rc6.

As Peter found, it turns out to be a bug in 0day robot -- it stored
some dmesg files to a wrong place.

So RC6 is actually free from that bug. Sorry for the noise!

Fengguang
