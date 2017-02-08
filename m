From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 0/2] x86/vdso: Add Hyper-V TSC page clocksource support
Date: Wed,  8 Feb 2017 18:07:42 +0100
Message-ID: <20170208170744.7632-1-vkuznets@redhat.com>
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
defined by the hypervisor is different from VCLOCK_PVCLOCK. I implemented
the required support re-using pvclock_page VVAR. Simple sysbench test shows
the following results:

Before:
# time sysbench --test=memory --max-requests=500000 run
...
real    1m22.618s
user    0m50.193s
sys     0m32.268s


After:
# time sysbench --test=memory --max-requests=500000 run
...
real    0m50.218s
user    0m50.171s
sys     0m0.016s

So it seems it is worth it. What do you think?

Vitaly Kuznetsov (2):
  hyperv: implement hv_get_tsc_page()
  x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method

 arch/x86/entry/vdso/vclock_gettime.c | 48 ++++++++++++++++++++++++++++++++++++
 arch/x86/entry/vdso/vma.c            | 26 +++++++++++++------
 arch/x86/hyperv/hv_init.c            |  8 ++++++
 arch/x86/include/asm/clocksource.h   |  3 ++-
 arch/x86/include/asm/mshyperv.h      |  8 ++++++
 drivers/hv/Kconfig                   |  5 ++++
 6 files changed, 90 insertions(+), 8 deletions(-)

-- 
2.9.3
