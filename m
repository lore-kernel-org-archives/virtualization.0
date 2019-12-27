From: yezengruan <yezengruan@huawei.com>
Subject: Re: [PATCH v2 5/6] KVM: arm64: Add interface to support VCPU
 preempted check
Date: Fri, 27 Dec 2019 14:52:13 +0800
Message-ID: <47879233-4437-4166-b61a-2d1cc8e7e44b__47588.6774061777$1577429556$gmane$org@huawei.com>
References: <20191226135833.1052-6-yezengruan@huawei.com>
 <201912270236.nkxsDrid%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201912270236.nkxsDrid%lkp@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: kbuild test robot <lkp@intel.com>
Cc: mark.rutland@arm.com, daniel.lezcano@linaro.org, kbuild-all@lists.01.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, maz@kernel.org, suzuki.poulose@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, catalin.marinas@arm.com, linux@armlinux.org.uk, steven.price@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 2019/12/27 2:51, kbuild test robot wrote:
> Hi Zengruan,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on kvmarm/next]
> [also build test ERROR on kvm/linux-next linus/master v5.5-rc3 next-20191220]
> [cannot apply to arm64/for-next/core]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Zengruan-Ye/KVM-arm64-VCPU-preempted-check-support/20191227-000637
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
> config: arm64-alldefconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/spinlock.h:89:0,
>                     from include/linux/radix-tree.h:16,
>                     from include/linux/idr.h:15,
>                     from include/linux/kernfs.h:13,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/of.h:17,
>                     from include/linux/irqdomain.h:35,
>                     from include/linux/acpi.h:13,
>                     from include/acpi/apei.h:9,
>                     from include/acpi/ghes.h:5,
>                     from include/linux/arm_sdei.h:8,
>                     from arch/arm64/kernel/asm-offsets.c:10:
>    arch/arm64/include/asm/spinlock.h: In function 'vcpu_is_preempted':
>>> arch/arm64/include/asm/spinlock.h:18:9: error: implicit declaration of function 'pv_vcpu_is_preempted'; did you mean 'vcpu_is_preempted'? [-Werror=implicit-function-declaration]
>      return pv_vcpu_is_preempted(cpu);
>             ^~~~~~~~~~~~~~~~~~~~
>             vcpu_is_preempted
>    cc1: some warnings being treated as errors
>    make[2]: *** [arch/arm64/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2
>    27 real  5 user  7 sys  48.63% cpu 	make prepare
> 
> vim +18 arch/arm64/include/asm/spinlock.h
> 
>     14	
>     15	#define vcpu_is_preempted vcpu_is_preempted
>     16	static inline bool vcpu_is_preempted(long cpu)
>     17	{
>   > 18		return pv_vcpu_is_preempted(cpu);
>     19	}
>     20	
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 

Thanks for posting this, I'll update the code to fix this issue.

Thanks,

Zengruan


---
 arch/arm64/include/asm/spinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 45ff1b2949a6..b5d1982414c5 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -12,10 +12,12 @@
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()

+#ifdef CONFIG_PARAVIRT
 #define vcpu_is_preempted vcpu_is_preempted
 static inline bool vcpu_is_preempted(long cpu)
 {
 	return pv_vcpu_is_preempted(cpu);
 }
+#endif // CONFIG_PARAVIRT

 #endif /* __ASM_SPINLOCK_H */
-- 
2.19.1
