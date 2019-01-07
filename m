From: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v15 23/26] sched: early boot clock
Date: Tue, 8 Jan 2019 00:48:39 +0100
Message-ID: <20190107234839.GA15269__31773.8287304111$1546904818$gmane$org@nautica>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
	<20180719205545.16512-24-pasha.tatashin@oracle.com>
	<20181106054212.GA31768@nautica>
	<95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
	<20190102202032.GA1034@eldamar.local>
	<CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
	<20190103234339.GA17457@nautica>
	<CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: gnomes@lxorguk.ukuu.org.uk, feng.tang@intel.com, kvm@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Steven Sistare <steven.sistare@oracle.com>, hpa@zytor.com, boris.ostrovsky@oracle.com, prarit@redhat.com, linux-s390@vger.kernel.org, x86@kernel.org, linux@armlinux.org.uk, Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@redhat.com, Pavel Tatashin <pavel.tatashin@microsoft.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Salvatore Bonaccorso <carnil@debian.org>, jgross@suse.com, douly.fnst@cn.fujitsu.com, sboyd@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Pavel Tatashin wrote on Mon, Jan 07, 2019:
> I could not reproduce the problem. Did you suspend to memory between
> wake ups? Does this time jump happen every time, even if your laptop
> sleeps for a minute?

I'm not sure I understand "suspend to memory between the wake ups".
The full sequence is:
 - start a VM (just in case, I let it boot till the end)
 - suspend to memory (aka systemctl suspend) the host
 - after resuming the host, soft reboot the VM (login through
serial/ssh/whatever and reboot or in the qemu console 'system_reset')

I've just slept exactly one minute and reproduced again with the fedora
stock kernel now (4.19.13-300.fc29.x86_64) in the VM.

Interestingly I'm not getting the same offset between multiple reboots
now despite not suspending again; but if I don't suspend I cannot seem
to get it to give an offset at all (only tried for a few minutes; this
might not be true) ; OTOH I pushed my luck further and even with a five
seconds sleep I'm getting a noticeable offset on first VM reboot after
resume:

[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[  179.362163] kvm-clock: cpu 0, msr 13c01001, primary cpu clock
[  179.362163] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns

Honestly not sure what more information I could give, I'll try on some
other hardware than my laptop (if I can get a server to resume after
suspend through ipmi or wake on lan); but I don't have anything I could
install ubuntu on to try their qemu's version... although I really don't
want to believe that's the difference...

Thanks,
-- 
Dominique
