From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 0/3] x86/vdso: Add Hyper-V TSC page clocksource support
Date: Fri,  3 Mar 2017 14:21:39 +0100
Message-ID: <20170303132142.25595-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org, Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

merge window is about to close so I hope it's OK to make another try here.

Changes since v2:
- Add explicit READ_ONCE() to not rely on 'volatile' [Andy Lutomirski]
- rdtsc() -> rdtsc_ordered() [Andy Lutomirski]
- virt_rmb() -> smp_rmb() [Thomas Gleixner, Andy Lutomirski]

Thomas, Andy, it seems the only blocker for the series was the ambiguity with
TSC page read algorithm. I contacted Microsoft (through K. Y.) and asked what
we should do when we see 'seq=0'. The answer is:

"I have confirmed that the only invalid value is 0 (notwithstanding what the
spec says). I have asked the Spec to be updated and the current code we have
is correct - it treats 0 as the only invalid value. The invalid value indicates
that the TSC page cannot be used as a time source and a different source is to
be used and this state is going to persist and so looping is not an option."

I agree it would be wiser to have two invalid values - one for 'try again' and
another for permanent failure in case it is needed. But this is not the case.

So I keep my algorithm untouched.

I can see two more reasons for us to keep it:
1) It is what we already have in kernel.
2) It is what Windows does (see the disassembly in c35b82ef0294.

Original description:

Hyper-V TSC page clocksource is suitable for vDSO, however, the protocol
defined by the hypervisor is different from VCLOCK_PVCLOCK. Implemented the
required support. Simple sysbench test shows the following results:

Before:
# time sysbench --test=memory --max-requests=500000 run
...
real    1m22.618s
user    0m50.193s
sys     0m32.268s

After:
# time sysbench --test=memory --max-requests=500000 run
...
real	0m47.241s
user	0m47.117s
sys	0m0.008s

Vitaly Kuznetsov (3):
  x86/hyperv: implement hv_get_tsc_page()
  x86/hyperv: move TSC reading method to asm/mshyperv.h
  x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method

 arch/x86/entry/vdso/vclock_gettime.c  | 24 +++++++++++++++
 arch/x86/entry/vdso/vdso-layout.lds.S |  3 +-
 arch/x86/entry/vdso/vdso2c.c          |  3 ++
 arch/x86/entry/vdso/vma.c             |  7 +++++
 arch/x86/hyperv/hv_init.c             | 48 +++++++++--------------------
 arch/x86/include/asm/clocksource.h    |  3 +-
 arch/x86/include/asm/mshyperv.h       | 58 +++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/vdso.h           |  1 +
 drivers/hv/Kconfig                    |  3 ++
 9 files changed, 114 insertions(+), 36 deletions(-)

-- 
2.9.3
