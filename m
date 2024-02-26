Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989A1C36;
	Mon, 26 Feb 2024 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914653; cv=none; b=CV3ZyL2OVgOhgJYmVTOFkABQDbHD2iguVd/nKkPYMp/COwj5xMAok0sv+5QKq+QrfUAzLWqK+i9LIpiUSEg1WlQk+7C/YFyUIWgawCmPBul5upVCzLvOiTr+Xjfcym4RVlGtaZM5fkk9qj1SX50z39vj5wrxVu5r967khXoOwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914653; c=relaxed/simple;
	bh=0RQ6xRfpOZkukZ1+BWpe8m17OSd+ukvYixnO0WlD5VU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NUetGm5fz6UlOJorjjcVaTRzN6gP6ZgxkJldINGnoNsUdKZ0SqNBybm5QaGMtlGAIETuqPco0wxAxG9cQcDbheuIG5rs8C0PGRoEQ+LVCKzOT9xSo9SpM+L85IGwc9OJLOnzEQ9Px7dTVKC/OgYVErccaTkDdZK4FgAOjyX02Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8CxLOvY99tlzWgRAA--.34067S3;
	Mon, 26 Feb 2024 10:30:48 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc_Y99tlhydEAA--.48627S3;
	Mon, 26 Feb 2024 10:30:48 +0800 (CST)
Subject: Re: [PATCH v5 6/6] LoongArch: Add pv ipi support on LoongArch system
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org
References: <20240222032803.2177856-1-maobibo@loongson.cn>
 <20240222032803.2177856-7-maobibo@loongson.cn>
 <CAAhV-H5oZvqbZOOTgkRXqS_TAq0QWbxGtz_YBzHhTGyuhMG2iQ@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <27f44c9a-ce2d-3666-6d8e-110370b3fbe0@loongson.cn>
Date: Mon, 26 Feb 2024 10:30:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5oZvqbZOOTgkRXqS_TAq0QWbxGtz_YBzHhTGyuhMG2iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxDc_Y99tlhydEAA--.48627S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3ZF47urW7XF47KFW7Kr1xWFX_yoW8WF1DZo
	W3JF4Iqw4xW345uFs8A3s0qrWUX3yYkr4UAa97AwnxWF17ta47Wr18Kw43tF43GFs5KFy7
	Ca43Xryvyayxtwn8l-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY47kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8w0
	eJUUUUU==



On 2024/2/24 下午5:19, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Feb 22, 2024 at 11:28 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> On LoongArch system, ipi hw uses iocsr registers, there is one iocsr
>> register access on ipi sending, and two iocsr access on ipi receiving
>> which is ipi interrupt handler. On VM mode all iocsr accessing will
>> cause VM to trap into hypervisor. So with one ipi hw notification
>> there will be three times of trap.
>>
>> PV ipi is added for VM, hypercall instruction is used for ipi sender,
>> and hypervisor will inject SWI to destination vcpu. During SWI interrupt
>> handler, only estat CSR register is written to clear irq. Estat CSR
>> register access will not trap into hypervisor. So with pv ipi supported,
>> there is one trap with pv ipi sender, and no trap with ipi receiver,
>> there is only one trap with ipi notification.
>>
>> Also this patch adds ipi multicast support, the method is similar with
>> x86. With ipi multicast support, ipi notification can be sent to at most
>> 128 vcpus at one time. It reduces trap times into hypervisor greatly.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/hardirq.h   |   1 +
>>   arch/loongarch/include/asm/kvm_host.h  |   1 +
>>   arch/loongarch/include/asm/kvm_para.h  | 123 +++++++++++++++++++++++++
>>   arch/loongarch/include/asm/loongarch.h |   1 +
>>   arch/loongarch/kernel/irq.c            |   2 +-
>>   arch/loongarch/kernel/paravirt.c       | 112 ++++++++++++++++++++++
>>   arch/loongarch/kernel/setup.c          |   1 +
>>   arch/loongarch/kernel/smp.c            |   2 +-
>>   arch/loongarch/kvm/exit.c              |  73 ++++++++++++++-
>>   arch/loongarch/kvm/vcpu.c              |   1 +
>>   10 files changed, 313 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/include/asm/hardirq.h
>> index 9f0038e19c7f..b26d596a73aa 100644
>> --- a/arch/loongarch/include/asm/hardirq.h
>> +++ b/arch/loongarch/include/asm/hardirq.h
>> @@ -21,6 +21,7 @@ enum ipi_msg_type {
>>   typedef struct {
>>          unsigned int ipi_irqs[NR_IPI];
>>          unsigned int __softirq_pending;
>> +       atomic_t message ____cacheline_aligned_in_smp;
>>   } ____cacheline_aligned irq_cpustat_t;
>>
>>   DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
>> index 3ba16ef1fe69..0b96c6303cf7 100644
>> --- a/arch/loongarch/include/asm/kvm_host.h
>> +++ b/arch/loongarch/include/asm/kvm_host.h
>> @@ -43,6 +43,7 @@ struct kvm_vcpu_stat {
>>          u64 idle_exits;
>>          u64 cpucfg_exits;
>>          u64 signal_exits;
>> +       u64 hypercall_exits;
>>   };
>>
>>   #define KVM_MEM_HUGEPAGE_CAPABLE       (1UL << 0)
>> diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
>> index af5d677a9052..a82bffbbf8a1 100644
>> --- a/arch/loongarch/include/asm/kvm_para.h
>> +++ b/arch/loongarch/include/asm/kvm_para.h
>> @@ -8,6 +8,9 @@
>>   #define HYPERVISOR_KVM                 1
>>   #define HYPERVISOR_VENDOR_SHIFT                8
>>   #define HYPERCALL_CODE(vendor, code)   ((vendor << HYPERVISOR_VENDOR_SHIFT) + code)
>> +#define KVM_HCALL_CODE_PV_SERVICE      0
>> +#define KVM_HCALL_PV_SERVICE           HYPERCALL_CODE(HYPERVISOR_KVM, KVM_HCALL_CODE_PV_SERVICE)
>> +#define  KVM_HCALL_FUNC_PV_IPI         1
>>
>>   /*
>>    * LoongArch hypercall return code
>> @@ -16,6 +19,126 @@
>>   #define KVM_HCALL_INVALID_CODE         -1UL
>>   #define KVM_HCALL_INVALID_PARAMETER    -2UL
>>
>> +/*
>> + * Hypercall interface for KVM hypervisor
>> + *
>> + * a0: function identifier
>> + * a1-a6: args
>> + * Return value will be placed in v0.
>> + * Up to 6 arguments are passed in a1, a2, a3, a4, a5, a6.
>> + */
>> +static __always_inline long kvm_hypercall(u64 fid)
>> +{
>> +       register long ret asm("v0");
>> +       register unsigned long fun asm("a0") = fid;
>> +
>> +       __asm__ __volatile__(
>> +               "hvcl "__stringify(KVM_HCALL_PV_SERVICE)
>> +               : "=r" (ret)
>> +               : "r" (fun)
>> +               : "memory"
>> +               );
>> +
>> +       return ret;
>> +}
>> +
>> +static __always_inline long kvm_hypercall1(u64 fid, unsigned long arg0)
>> +{
>> +       register long ret asm("v0");
>> +       register unsigned long fun asm("a0") = fid;
>> +       register unsigned long a1  asm("a1") = arg0;
>> +
>> +       __asm__ __volatile__(
>> +               "hvcl "__stringify(KVM_HCALL_PV_SERVICE)
>> +               : "=r" (ret)
>> +               : "r" (fun), "r" (a1)
>> +               : "memory"
>> +               );
>> +
>> +       return ret;
>> +}
>> +
>> +static __always_inline long kvm_hypercall2(u64 fid,
>> +               unsigned long arg0, unsigned long arg1)
>> +{
>> +       register long ret asm("v0");
>> +       register unsigned long fun asm("a0") = fid;
>> +       register unsigned long a1  asm("a1") = arg0;
>> +       register unsigned long a2  asm("a2") = arg1;
>> +
>> +       __asm__ __volatile__(
>> +                       "hvcl "__stringify(KVM_HCALL_PV_SERVICE)
>> +                       : "=r" (ret)
>> +                       : "r" (fun), "r" (a1), "r" (a2)
>> +                       : "memory"
>> +                       );
>> +
>> +       return ret;
>> +}
>> +
>> +static __always_inline long kvm_hypercall3(u64 fid,
>> +       unsigned long arg0, unsigned long arg1, unsigned long arg2)
>> +{
>> +       register long ret asm("v0");
>> +       register unsigned long fun asm("a0") = fid;
>> +       register unsigned long a1  asm("a1") = arg0;
>> +       register unsigned long a2  asm("a2") = arg1;
>> +       register unsigned long a3  asm("a3") = arg2;
>> +
>> +       __asm__ __volatile__(
>> +               "hvcl "__stringify(KVM_HCALL_PV_SERVICE)
>> +               : "=r" (ret)
>> +               : "r" (fun), "r" (a1), "r" (a2), "r" (a3)
>> +               : "memory"
>> +               );
>> +
>> +       return ret;
>> +}
>> +
>> +static __always_inline long kvm_hypercall4(u64 fid,
>> +               unsigned long arg0, unsigned long arg1, unsigned long arg2,
>> +               unsigned long arg3)
>> +{
>> +       register long ret asm("v0");
>> +       register unsigned long fun asm("a0") = fid;
>> +       register unsigned long a1  asm("a1") = arg0;
>> +       register unsigned long a2  asm("a2") = arg1;
>> +       register unsigned long a3  asm("a3") = arg2;
>> +       register unsigned long a4  asm("a4") = arg3;
>> +
>> +       __asm__ __volatile__(
>> +               "hvcl "__stringify(KVM_HCALL_PV_SERVICE)
>> +               : "=r" (ret)
>> +               : "r"(fun), "r" (a1), "r" (a2), "r" (a3), "r" (a4)
>> +               : "memory"
>> +               );
>> +
>> +       return ret;
>> +}
>> +
>> +static __always_inline long kvm_hypercall5(u64 fid,
>> +               unsigned long arg0, unsigned long arg1, unsigned long arg2,
>> +               unsigned long arg3, unsigned long arg4)
>> +{
>> +       register long ret asm("v0");
>> +       register unsigned long fun asm("a0") = fid;
>> +       register unsigned long a1  asm("a1") = arg0;
>> +       register unsigned long a2  asm("a2") = arg1;
>> +       register unsigned long a3  asm("a3") = arg2;
>> +       register unsigned long a4  asm("a4") = arg3;
>> +       register unsigned long a5  asm("a5") = arg4;
>> +
>> +       __asm__ __volatile__(
>> +               "hvcl "__stringify(KVM_HCALL_PV_SERVICE)
>> +               : "=r" (ret)
>> +               : "r"(fun), "r" (a1), "r" (a2), "r" (a3), "r" (a4), "r" (a5)
>> +               : "memory"
>> +               );
>> +
>> +       return ret;
>> +}
>> +
>> +
>>   static inline unsigned int kvm_arch_para_features(void)
>>   {
>>          return 0;
>> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
>> index a1d22e8b6f94..0ad36704cb4b 100644
>> --- a/arch/loongarch/include/asm/loongarch.h
>> +++ b/arch/loongarch/include/asm/loongarch.h
>> @@ -167,6 +167,7 @@
>>   #define CPUCFG_KVM_SIG                 CPUCFG_KVM_BASE
>>   #define  KVM_SIGNATURE                 "KVM\0"
>>   #define CPUCFG_KVM_FEATURE             (CPUCFG_KVM_BASE + 4)
>> +#define  KVM_FEATURE_PV_IPI            BIT(1)
>>
>>   #ifndef __ASSEMBLY__
>>
>> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
>> index ce36897d1e5a..4863e6c1b739 100644
>> --- a/arch/loongarch/kernel/irq.c
>> +++ b/arch/loongarch/kernel/irq.c
>> @@ -113,5 +113,5 @@ void __init init_IRQ(void)
>>                          per_cpu(irq_stack, i), per_cpu(irq_stack, i) + IRQ_STACK_SIZE);
>>          }
>>
>> -       set_csr_ecfg(ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 | ECFGF_IPI | ECFGF_PMC);
>> +       set_csr_ecfg(ECFGF_SIP0 | ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 | ECFGF_IPI | ECFGF_PMC);
>>   }
>> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
>> index 5cf794e8490f..4c30e1c73c72 100644
>> --- a/arch/loongarch/kernel/paravirt.c
>> +++ b/arch/loongarch/kernel/paravirt.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #include <linux/export.h>
>>   #include <linux/types.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/jump_label.h>
>>   #include <linux/kvm_para.h>
>>   #include <asm/paravirt.h>
>> @@ -16,6 +17,103 @@ static u64 native_steal_clock(int cpu)
>>
>>   DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
>>
>> +#ifdef CONFIG_SMP
>> +static void pv_send_ipi_single(int cpu, unsigned int action)
>> +{
>> +       unsigned int min, old;
>> +       unsigned long bitmap = 0;
>> +       irq_cpustat_t *info = &per_cpu(irq_stat, cpu);
>> +
>> +       action = BIT(action);
>> +       old = atomic_fetch_or(action, &info->message);
>> +       if (old == 0) {
>> +               min = cpu_logical_map(cpu);
>> +               bitmap = 1;
>> +               kvm_hypercall3(KVM_HCALL_FUNC_PV_IPI, bitmap, 0, min);
>> +       }
> Early return style can make it a little easy, which means:
> 
> if (old)
>     return;
> 
> min = ......
> 
will do in next patch.

>> +}
>> +
>> +#define KVM_IPI_CLUSTER_SIZE           (2 * BITS_PER_LONG)
>> +static void pv_send_ipi_mask(const struct cpumask *mask, unsigned int action)
>> +{
>> +       unsigned int cpu, i, min = 0, max = 0, old;
>> +       __uint128_t bitmap = 0;
>> +       irq_cpustat_t *info;
>> +
>> +       if (cpumask_empty(mask))
>> +               return;
>> +
>> +       action = BIT(action);
>> +       for_each_cpu(i, mask) {
>> +               info = &per_cpu(irq_stat, i);
>> +               old = atomic_fetch_or(action, &info->message);
>> +               if (old)
>> +                       continue;
>> +
>> +               cpu = cpu_logical_map(i);
>> +               if (!bitmap) {
>> +                       min = max = cpu;
>> +               } else if (cpu > min && cpu < min + KVM_IPI_CLUSTER_SIZE) {
>> +                       max = cpu > max ? cpu : max;
>> +               } else if (cpu < min && (max - cpu) < KVM_IPI_CLUSTER_SIZE) {
>> +                       bitmap <<= min - cpu;
>> +                       min = cpu;
>> +               } else {
>> +                       /*
>> +                        * Physical cpuid is sorted in ascending order ascend
>> +                        * for the next mask calculation, send IPI here
>> +                        * directly and skip the remainding cpus
>> +                        */
>> +                       kvm_hypercall3(KVM_HCALL_FUNC_PV_IPI,
>> +                               (unsigned long)bitmap,
>> +                               (unsigned long)(bitmap >> BITS_PER_LONG), min);
>> +                       min = max = cpu;
>> +                       bitmap = 0;
>> +               }
>> +               __set_bit(cpu - min, (unsigned long *)&bitmap);
>> +       }
>> +
>> +       if (bitmap)
>> +               kvm_hypercall3(KVM_HCALL_FUNC_PV_IPI, (unsigned long)bitmap,
>> +                               (unsigned long)(bitmap >> BITS_PER_LONG), min);
>> +}
>> +
>> +static irqreturn_t loongson_do_swi(int irq, void *dev)
>> +{
>> +       irq_cpustat_t *info;
>> +       long action;
>> +
>> +       /* Clear swi interrupt */
>> +       clear_csr_estat(1 << INT_SWI0);
>> +       info = this_cpu_ptr(&irq_stat);
>> +       action = atomic_xchg(&info->message, 0);
>> +       if (action & SMP_CALL_FUNCTION) {
>> +               generic_smp_call_function_interrupt();
>> +               info->ipi_irqs[IPI_CALL_FUNCTION]++;
>> +       }
>> +
>> +       if (action & SMP_RESCHEDULE) {
>> +               scheduler_ipi();
>> +               info->ipi_irqs[IPI_RESCHEDULE]++;
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static void pv_init_ipi(void)
>> +{
>> +       int r, swi0;
>> +
>> +       swi0 = get_percpu_irq(INT_SWI0);
>> +       if (swi0 < 0)
>> +               panic("SWI0 IRQ mapping failed\n");
>> +       irq_set_percpu_devid(swi0);
>> +       r = request_percpu_irq(swi0, loongson_do_swi, "SWI0", &irq_stat);
>> +       if (r < 0)
>> +               panic("SWI0 IRQ request failed\n");
>> +}
>> +#endif
>> +
>>   static bool kvm_para_available(void)
>>   {
>>          static int hypervisor_type;
>> @@ -32,10 +130,24 @@ static bool kvm_para_available(void)
>>
>>   int __init pv_ipi_init(void)
>>   {
>> +       int feature;
>> +
>>          if (!cpu_has_hypervisor)
>>                  return 0;
>>          if (!kvm_para_available())
>>                  return 0;
>>
>> +       /*
>> +        * check whether KVM hypervisor supports pv_ipi or not
>> +        */
>> +       feature = read_cpucfg(CPUCFG_KVM_FEATURE);
>> +#ifdef CONFIG_SMP
>> +       if (feature & KVM_FEATURE_PV_IPI) {
>> +               smp_ops.init_ipi                = pv_init_ipi;
>> +               smp_ops.send_ipi_single         = pv_send_ipi_single;
>> +               smp_ops.send_ipi_mask           = pv_send_ipi_mask;
>> +       }
>> +#endif
>> +
>>          return 1;
>>   }
>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
>> index b79a1244b56f..c95ed3224b7d 100644
>> --- a/arch/loongarch/kernel/setup.c
>> +++ b/arch/loongarch/kernel/setup.c
>> @@ -368,6 +368,7 @@ void __init platform_init(void)
>>          pr_info("The BIOS Version: %s\n", b_info.bios_version);
>>
>>          efi_runtime_init();
>> +       pv_ipi_init();
> Move the callsite to loongson_smp_setup() is better.
Will do in next patch.

Regards
Bibo Mao
> 
> Huacai
> 
>>   }
>>
>>   static void __init check_kernel_sections_mem(void)
>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
>> index 2182e7cc2ed6..9e9fda1fe18a 100644
>> --- a/arch/loongarch/kernel/smp.c
>> +++ b/arch/loongarch/kernel/smp.c
>> @@ -285,7 +285,7 @@ void loongson_boot_secondary(int cpu, struct task_struct *idle)
>>   void loongson_init_secondary(void)
>>   {
>>          unsigned int cpu = smp_processor_id();
>> -       unsigned int imask = ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 |
>> +       unsigned int imask = ECFGF_SIP0 | ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 |
>>                               ECFGF_IPI | ECFGF_PMC | ECFGF_TIMER;
>>
>>          change_csr_ecfg(ECFG0_IM, imask);
>> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
>> index 6a38fd59d86d..46940e97975b 100644
>> --- a/arch/loongarch/kvm/exit.c
>> +++ b/arch/loongarch/kvm/exit.c
>> @@ -227,6 +227,9 @@ static int kvm_emu_cpucfg(struct kvm_vcpu *vcpu, larch_inst inst)
>>          case CPUCFG_KVM_SIG:
>>                  vcpu->arch.gprs[rd] = *(unsigned int *)KVM_SIGNATURE;
>>                  break;
>> +       case CPUCFG_KVM_FEATURE:
>> +               vcpu->arch.gprs[rd] = KVM_FEATURE_PV_IPI;
>> +               break;
>>          default:
>>                  vcpu->arch.gprs[rd] = 0;
>>                  break;
>> @@ -699,12 +702,78 @@ static int kvm_handle_lasx_disabled(struct kvm_vcpu *vcpu)
>>          return RESUME_GUEST;
>>   }
>>
>> +static int kvm_pv_send_ipi(struct kvm_vcpu *vcpu)
>> +{
>> +       unsigned long ipi_bitmap;
>> +       unsigned int min, cpu, i;
>> +       struct kvm_vcpu *dest;
>> +
>> +       min = vcpu->arch.gprs[LOONGARCH_GPR_A3];
>> +       for (i = 0; i < 2; i++) {
>> +               ipi_bitmap = vcpu->arch.gprs[LOONGARCH_GPR_A1 + i];
>> +               if (!ipi_bitmap)
>> +                       continue;
>> +
>> +               cpu = find_first_bit((void *)&ipi_bitmap, BITS_PER_LONG);
>> +               while (cpu < BITS_PER_LONG) {
>> +                       dest = kvm_get_vcpu_by_cpuid(vcpu->kvm, cpu + min);
>> +                       cpu = find_next_bit((void *)&ipi_bitmap, BITS_PER_LONG,
>> +                                       cpu + 1);
>> +                       if (!dest)
>> +                               continue;
>> +
>> +                       /*
>> +                        * Send SWI0 to dest vcpu to emulate IPI interrupt
>> +                        */
>> +                       kvm_queue_irq(dest, INT_SWI0);
>> +                       kvm_vcpu_kick(dest);
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * hypercall emulation always return to guest, Caller should check retval.
>> + */
>> +static void kvm_handle_pv_service(struct kvm_vcpu *vcpu)
>> +{
>> +       unsigned long func = vcpu->arch.gprs[LOONGARCH_GPR_A0];
>> +       long ret;
>> +
>> +       switch (func) {
>> +       case KVM_HCALL_FUNC_PV_IPI:
>> +               kvm_pv_send_ipi(vcpu);
>> +               ret = KVM_HCALL_STATUS_SUCCESS;
>> +               break;
>> +       default:
>> +               ret = KVM_HCALL_INVALID_CODE;
>> +               break;
>> +       };
>> +
>> +       vcpu->arch.gprs[LOONGARCH_GPR_A0] = ret;
>> +}
>> +
>>   static int kvm_handle_hypercall(struct kvm_vcpu *vcpu)
>>   {
>> +       larch_inst inst;
>> +       unsigned int code;
>> +
>> +       inst.word = vcpu->arch.badi;
>> +       code = inst.reg0i15_format.immediate;
>>          update_pc(&vcpu->arch);
>>
>> -       /* Treat it as noop intruction, only set return value */
>> -       vcpu->arch.gprs[LOONGARCH_GPR_A0] = KVM_HCALL_INVALID_CODE;
>> +       switch (code) {
>> +       case KVM_HCALL_PV_SERVICE:
>> +               vcpu->stat.hypercall_exits++;
>> +               kvm_handle_pv_service(vcpu);
>> +               break;
>> +       default:
>> +               /* Treat it as noop intruction, only set return value */
>> +               vcpu->arch.gprs[LOONGARCH_GPR_A0] = KVM_HCALL_INVALID_CODE;
>> +               break;
>> +       }
>> +
>>          return RESUME_GUEST;
>>   }
>>
>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>> index 40296d8ef297..24fd5e4647f3 100644
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -19,6 +19,7 @@ const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
>>          STATS_DESC_COUNTER(VCPU, idle_exits),
>>          STATS_DESC_COUNTER(VCPU, cpucfg_exits),
>>          STATS_DESC_COUNTER(VCPU, signal_exits),
>> +       STATS_DESC_COUNTER(VCPU, hypercall_exits)
>>   };
>>
>>   const struct kvm_stats_header kvm_vcpu_stats_header = {
>> --
>> 2.39.3
>>
>>

