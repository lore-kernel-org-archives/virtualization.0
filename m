From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] iommu: spapr_tce: Disable compile testing to fix build on
 book3s_32 config
Date: Mon, 20 Apr 2020 13:04:47 +1000
Message-ID: <874ktej1rk.fsf@mpe.ellerman.id.au>
References: <20200414142630.21153-1-krzk@kernel.org>
 <a99ee461-664c-51ae-cb3a-cf5d87048d86@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a99ee461-664c-51ae-cb3a-cf5d87048d86@c-s.fr>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Krzysztof Kozlowski <krzk@kernel.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> On 04/14/2020 02:26 PM, Krzysztof Kozlowski wrote:
>> Although SPAPR_TCE_IOMMU itself can be compile tested on certain PowerPC
>> configurations, its presence makes arch/powerpc/kvm/Makefile to select
>> modules which do not build in such configuration.
>> 
>> The arch/powerpc/kvm/ modules use kvm_arch.spapr_tce_tables which exists
>> only with CONFIG_PPC_BOOK3S_64.  However these modules are selected when
>> COMPILE_TEST and SPAPR_TCE_IOMMU are chosen leading to build failures:
>> 
>>      In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:0,
>>                       from arch/powerpc/kvm/book3s_64_vio_hv.c:22:
>>      arch/powerpc/include/asm/book3s/64/pgtable.h:17:0: error: "_PAGE_EXEC" redefined [-Werror]
>>       #define _PAGE_EXEC  0x00001 /* execute permission */
>> 
>>      In file included from arch/powerpc/include/asm/book3s/32/pgtable.h:8:0,
>>                       from arch/powerpc/include/asm/book3s/pgtable.h:8,
>>                       from arch/powerpc/include/asm/pgtable.h:18,
>>                       from include/linux/mm.h:95,
>>                       from arch/powerpc/include/asm/io.h:29,
>>                       from include/linux/io.h:13,
>>                       from include/linux/irq.h:20,
>>                       from arch/powerpc/include/asm/hardirq.h:6,
>>                       from include/linux/hardirq.h:9,
>>                       from include/linux/kvm_host.h:7,
>>                       from arch/powerpc/kvm/book3s_64_vio_hv.c:12:
>>      arch/powerpc/include/asm/book3s/32/hash.h:29:0: note: this is the location of the previous definition
>>       #define _PAGE_EXEC 0x200 /* software: exec allowed */
>> 
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Fixes: e93a1695d7fb ("iommu: Enable compile testing for some of drivers")
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>   drivers/iommu/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index 58b4a4dbfc78..3532b1ead19d 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -362,7 +362,7 @@ config IPMMU_VMSA
>>   
>>   config SPAPR_TCE_IOMMU
>>   	bool "sPAPR TCE IOMMU Support"
>> -	depends on PPC_POWERNV || PPC_PSERIES || (PPC && COMPILE_TEST)
>> +	depends on PPC_POWERNV || PPC_PSERIES
>>   	select IOMMU_API
>>   	help
>>   	  Enables bits of IOMMU API required by VFIO. The iommu_ops
>> 
>
> Should it be fixed the other way round, something like:

That doesn't actually fix this specific issue, the code will build but
then not link:

  ld: arch/powerpc/../../virt/kvm/vfio.o: in function `.kvm_spapr_tce_release_vfio_group':
  vfio.c:(.text.kvm_spapr_tce_release_vfio_group+0xb0): undefined reference to `.kvm_spapr_tce_release_iommu_group'
  ld: arch/powerpc/../../virt/kvm/vfio.o: in function `.kvm_vfio_set_group':
  vfio.c:(.text.kvm_vfio_set_group+0x7f4): undefined reference to `.kvm_spapr_tce_attach_iommu_group'
  ld: arch/powerpc/kvm/powerpc.o: in function `.kvm_arch_vm_ioctl':
  (.text.kvm_arch_vm_ioctl+0x1a4): undefined reference to `.kvm_vm_ioctl_create_spapr_tce'
  ld: (.text.kvm_arch_vm_ioctl+0x230): undefined reference to `.kvm_vm_ioctl_create_spapr_tce'
  make[1]: *** [/home/michael/linux/Makefile:1106: vmlinux] Error 1

> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index 2bfeaa13befb..906707d15810 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -135,4 +135,4 @@ obj-$(CONFIG_KVM_BOOK3S_32) += kvm.o
>   obj-$(CONFIG_KVM_BOOK3S_64_PR) += kvm-pr.o
>   obj-$(CONFIG_KVM_BOOK3S_64_HV) += kvm-hv.o
>
> -obj-y += $(kvm-book3s_64-builtin-objs-y)
> +obj-$(CONFIG_KVM_BOOK3S_64) += $(kvm-book3s_64-builtin-objs-y)

But this is probably still a good thing to do, as it would have made the
error messages clearer in this case I think.

cheers
