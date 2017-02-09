From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 0/2] x86/vdso: Add Hyper-V TSC page clocksource support
Date: Thu,  9 Feb 2017 15:10:50 +0100
Message-ID: <20170209141052.18694-1-vkuznets__8793.80368064648$1486649505$gmane$org@redhat.com>
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
To: x86@kernel.org, Andy Lutomirski <luto@amacapital.net>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

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

So it seems it is worth it. As nobody seems to be strongly offended by my RFC
I'm sending first non-RFC version. Patch 1 is made on top of K. Y.'s code
refactoring which moved tsc page clocksource to arch/x86/hyperv/hv_init.c,
this is currently present in Greg's char-misc-next tree.

Changes since RFC:
- Use mul_u64_u64_shr() instead of an open coded implementation
  [Andy Lutomirski, Thomas Gleixner]
- Don't use the same pvclock_page for both VCLOCK_PVCLOCK and
  VCLOCK_HVCLOCK, create another one [Andy Lutomirski]
- Fix issues reported by kbuild test robot.
- Rename HYPERV_CLOCK -> HYPERV_TSCPAGE to avoid the ambiguity.

I'm also going to try to optimize mul_u64_u64_shr() for 32bit but this can
be split from this series I guess.

Vitaly Kuznetsov (2):
  hyperv: implement hv_get_tsc_page()
  x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method

 arch/x86/entry/vdso/vclock_gettime.c  | 36 +++++++++++++++++++++++++++++++++++
 arch/x86/entry/vdso/vdso-layout.lds.S |  3 ++-
 arch/x86/entry/vdso/vdso2c.c          |  3 +++
 arch/x86/entry/vdso/vma.c             |  7 +++++++
 arch/x86/hyperv/hv_init.c             | 12 ++++++++++--
 arch/x86/include/asm/clocksource.h    |  3 ++-
 arch/x86/include/asm/mshyperv.h       |  8 ++++++++
 arch/x86/include/asm/vdso.h           |  1 +
 drivers/hv/Kconfig                    |  3 +++
 9 files changed, 72 insertions(+), 4 deletions(-)

-- 
2.9.3
