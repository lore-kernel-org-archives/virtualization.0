From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] x86: use fixed read-only IDT
Date: Tue, 9 Apr 2013 17:29:22 -0700
Message-ID: <CAGXu5jKweun6jzioXBNjs8rguGSs+SvLqoVKjucNmytiJH_WDA@mail.gmail.com>
References: <20130409163932.GA19130@www.outflux.net>
	<5164AEF5.9020202@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5164AEF5.9020202@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Alex Shi <alex.shi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 9, 2013 at 5:14 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 04/09/2013 09:39 AM, Kees Cook wrote:
>> -
>>  static void __cpuinit intel_smp_check(struct cpuinfo_x86 *c)
>>  {
>>       /* calling is from identify_secondary_cpu() ? */
>> @@ -206,8 +192,7 @@ static void __cpuinit intel_workarounds(struct cpuinfo_x86 *c)
>>       /*
>>        * All current models of Pentium and Pentium with MMX technology CPUs
>>        * have the F0 0F bug, which lets nonprivileged users lock up the
>> -      * system.
>> -      * Note that the workaround only should be initialized once...
>> +      * system. Announce that the fault handler will be checking for it.
>>        */
>>       c->f00f_bug = 0;
>>       if (!paravirt_enabled() && c->x86 == 5) {
>> @@ -215,7 +200,6 @@ static void __cpuinit intel_workarounds(struct cpuinfo_x86 *c)
>>
>>               c->f00f_bug = 1;
>>               if (!f00f_workaround_enabled) {
>> -                     trap_init_f00f_bug();
>>                       printk(KERN_NOTICE "Intel Pentium with F0 0F bug - workaround enabled.\n");
>>                       f00f_workaround_enabled = 1;
>>               }
>
> Why do we care about this message anymore?  It provides no relevant user
> information, the flag itself is already in /proc/cpuinfo, and the
> message is likely to be wrong since all it does is look for an Intel CPU
> with family == 5.

I have no objection to removing it, but with CONFIG_F00F_BUG, the trap
handler does still do some checking, and I figured this message was
there to notify people about it.

-Kees

--
Kees Cook
Chrome OS Security
