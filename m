From: KY Srinivasan via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v2 0/3] x86/vdso: Add Hyper-V TSC page clocksource support
Date: Tue, 14 Feb 2017 14:46:01 +0000
Message-ID: <DM5PR03MB249046518FE6169E7B826FF7A0580@DM5PR03MB2490.namprd03.prod.outlook.com>
References: <20170214124408.25931-1-vkuznets@redhat.com>
Reply-To: KY Srinivasan <kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170214124408.25931-1-vkuznets@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>, "x86@kernel.org" <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Vitaly Kuznetsov [mailto:vkuznets@redhat.com]
> Sent: Tuesday, February 14, 2017 4:44 AM
> To: x86@kernel.org; Andy Lutomirski <luto@amacapital.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> H. Peter Anvin <hpa@zytor.com>; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Dexuan Cui <decui@microsoft.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.linux-foundation.org
> Subject: [PATCH v2 0/3] x86/vdso: Add Hyper-V TSC page clocksource support
> 
> Hi,
> 
> while we're still waiting for a definitive ACK from Microsoft that the algorithm
> is good for SMP case (as we can't prevent the code in vdso from migrating
> between CPUs) I'd like to send v2 with some modifications to keep the
> discussion going.

I checked with the folks on the Hyper-V side and they have confirmed that we need to
add memory barriers in the guest code to ensure the various reads from the TSC page are
correctly ordered - especially, the initial read of the sequence counter must have acquire
semantics. We should ensure that other reads from the TSC page are completed before the
second read of the sequence counter. I am working with the Windows team to correctly
reflect this algorithm in the Hyper-V specification.

Regards,

K. Y
> 
> Changes since v1:
> - Document the TSC page reading protocol [Thomas Gleixner].
> 
> - Separate the TSC page reading code from read_hv_clock_tsc() and put it to
>   asm/mshyperv.h to use from both hv_init.c and vdso.
> 
> - Add explicit barriers [Thomas Gleixner]
> 
> Original description:
> 
> Hyper-V TSC page clocksource is suitable for vDSO, however, the protocol
> defined by the hypervisor is different from VCLOCK_PVCLOCK. Implemented
> the required support. Simple sysbench test shows the following results:
> 
> Before:
> # time sysbench --test=memory --max-requests=500000 run ...
> real    1m22.618s
> user    0m50.193s
> sys     0m32.268s
> 
> After:
> # time sysbench --test=memory --max-requests=500000 run ...
> real	0m47.241s
> user	0m47.117s
> sys	0m0.008s
> 
> Patches 1 and 2 are made on top of K. Y.'s code refactoring which moved tsc
> page clocksource to arch/x86/hyperv/hv_init.c, this is currently present in
> Greg's char-misc-next tree.
> 
> Vitaly Kuznetsov (3):
>   x86/hyperv: implement hv_get_tsc_page()
>   x86/hyperv: move TSC reading method to asm/mshyperv.h
>   x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read method
> 
>  arch/x86/entry/vdso/vclock_gettime.c  | 24 +++++++++++++++
> arch/x86/entry/vdso/vdso-layout.lds.S |  3 +-
>  arch/x86/entry/vdso/vdso2c.c          |  3 ++
>  arch/x86/entry/vdso/vma.c             |  7 +++++
>  arch/x86/hyperv/hv_init.c             | 48 +++++++++--------------------
>  arch/x86/include/asm/clocksource.h    |  3 +-
>  arch/x86/include/asm/mshyperv.h       | 58
> +++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/vdso.h           |  1 +
>  drivers/hv/Kconfig                    |  3 ++
>  9 files changed, 114 insertions(+), 36 deletions(-)
> 
> --
> 2.9.3
