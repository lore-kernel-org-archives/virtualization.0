Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0898436AF6;
	Tue, 30 Jan 2024 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583219; cv=none; b=Zqk3mcjBcUqimand8C2BIfUldx8fNL/xJ33p+HR1iSiIb2M5b44LAs4Pgn/Y9JblyGjmdu6KUFDftxFv3Yq0bF5dTy7K/iVUGzJzD+6ScyHzDxHCXRHUm5wp2+bFIXttFtIyP7Jv1Rh+ClChf8V87n9xpLra49dBlTdkcbN6AaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583219; c=relaxed/simple;
	bh=YrbQdD+eo9d7Jj5fQMIFOCeXuMJDBSdXMrjxAhVvvNg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OywdAYLMAFcnmi//QujaQtHg8OMXRA3J9TmxX27xnYrjehzyOE0FdV6E3ipg0FZNfzrL1nat9QrzaRhggDsQ372LTaFFmYwU2q0HIov+/WKAK7GaRvtvsPQyGDXg13VpxdL5xlKyDk8QXBmd0ymIESyWr9JSIRFZnb/roFgAab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8AxjuuuZLhlrycIAA--.24934S3;
	Tue, 30 Jan 2024 10:53:34 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxfs2rZLhllzEnAA--.20893S3;
	Tue, 30 Jan 2024 10:53:33 +0800 (CST)
Subject: Re: [PATCH v3 5/6] LoongArch: KVM: Add physical cpuid map support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org
References: <20240122100313.1589372-1-maobibo@loongson.cn>
 <20240122100313.1589372-6-maobibo@loongson.cn>
 <CAAhV-H78HiRRsdsVHxYBYOEWew9FKDSF++bK_=g=UbBKc46d2Q@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <c1b96019-43b6-1d1e-127d-0e52f18d36ff@loongson.cn>
Date: Tue, 30 Jan 2024 10:53:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H78HiRRsdsVHxYBYOEWew9FKDSF++bK_=g=UbBKc46d2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Dxfs2rZLhllzEnAA--.20893S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XryDWFyfWw43KrW8Ar43Jwc_yoW3tFyUpF
	yq9an8WrWrJr17Kw10qw1Dur9IvrWvgr1a9asrtay5Ar1qvryrZrZYkrW5uF98Jw1rWFs2
	vF1UJ3W5uF4FyacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
	db8UUUUU=



On 2024/1/29 下午9:11, Huacai Chen wrote:
> Hi, Bibo,
> 
> Without this patch I can also create a SMP VM, so what problem does
> this patch want to solve?
With ipi irqchip, physical cpuid is used for dest cpu rather than 
logical cpuid. And if ipi device is emulated in qemu side, there is 
find_cpu_by_archid to get dest vcpu in file hw/intc/loongarch_ipi.c

Here with hypercall method, ipi is emulated in kvm kernel side, there
should be the same physical cpuid searching logic. And function 
kvm_get_vcpu_by_cpuid is used with pv_ipi backend.

Regards
Bibo Mao

> 
> Huacai
> 
> On Mon, Jan 22, 2024 at 6:03 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Physical cpuid is used to irq routing for irqchips such as ipi/msi/
>> extioi interrupt controller. And physical cpuid is stored at CSR
>> register LOONGARCH_CSR_CPUID, it can not be changed once vcpu is
>> created. Since different irqchips have different size definition
>> about physical cpuid, KVM uses the smallest cpuid from extioi, and
>> the max cpuid size is defines as 256.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/kvm_host.h | 26 ++++++++
>>   arch/loongarch/include/asm/kvm_vcpu.h |  1 +
>>   arch/loongarch/kvm/vcpu.c             | 93 ++++++++++++++++++++++++++-
>>   arch/loongarch/kvm/vm.c               | 11 ++++
>>   4 files changed, 130 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
>> index 2d62f7b0d377..57399d7cf8b7 100644
>> --- a/arch/loongarch/include/asm/kvm_host.h
>> +++ b/arch/loongarch/include/asm/kvm_host.h
>> @@ -64,6 +64,30 @@ struct kvm_world_switch {
>>
>>   #define MAX_PGTABLE_LEVELS     4
>>
>> +/*
>> + * Physical cpu id is used for interrupt routing, there are different
>> + * definitions about physical cpuid on different hardwares.
>> + *  For LOONGARCH_CSR_CPUID register, max cpuid size if 512
>> + *  For IPI HW, max dest CPUID size 1024
>> + *  For extioi interrupt controller, max dest CPUID size is 256
>> + *  For MSI interrupt controller, max supported CPUID size is 65536
>> + *
>> + * Currently max CPUID is defined as 256 for KVM hypervisor, in future
>> + * it will be expanded to 4096, including 16 packages at most. And every
>> + * package supports at most 256 vcpus
>> + */
>> +#define KVM_MAX_PHYID          256
>> +
>> +struct kvm_phyid_info {
>> +       struct kvm_vcpu *vcpu;
>> +       bool            enabled;
>> +};
>> +
>> +struct kvm_phyid_map {
>> +       int max_phyid;
>> +       struct kvm_phyid_info phys_map[KVM_MAX_PHYID];
>> +};
>> +
>>   struct kvm_arch {
>>          /* Guest physical mm */
>>          kvm_pte_t *pgd;
>> @@ -71,6 +95,8 @@ struct kvm_arch {
>>          unsigned long invalid_ptes[MAX_PGTABLE_LEVELS];
>>          unsigned int  pte_shifts[MAX_PGTABLE_LEVELS];
>>          unsigned int  root_level;
>> +       struct mutex  phyid_map_lock;
>> +       struct kvm_phyid_map  *phyid_map;
>>
>>          s64 time_offset;
>>          struct kvm_context __percpu *vmcs;
>> diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
>> index e71ceb88f29e..2402129ee955 100644
>> --- a/arch/loongarch/include/asm/kvm_vcpu.h
>> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
>> @@ -81,6 +81,7 @@ void kvm_save_timer(struct kvm_vcpu *vcpu);
>>   void kvm_restore_timer(struct kvm_vcpu *vcpu);
>>
>>   int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq);
>> +struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm *kvm, int cpuid);
>>
>>   /*
>>    * Loongarch KVM guest interrupt handling
>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
>> index 27701991886d..97ca9c7160e6 100644
>> --- a/arch/loongarch/kvm/vcpu.c
>> +++ b/arch/loongarch/kvm/vcpu.c
>> @@ -274,6 +274,95 @@ static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *val)
>>          return 0;
>>   }
>>
>> +static inline int kvm_set_cpuid(struct kvm_vcpu *vcpu, u64 val)
>> +{
>> +       int cpuid;
>> +       struct loongarch_csrs *csr = vcpu->arch.csr;
>> +       struct kvm_phyid_map  *map;
>> +
>> +       if (val >= KVM_MAX_PHYID)
>> +               return -EINVAL;
>> +
>> +       cpuid = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT);
>> +       map = vcpu->kvm->arch.phyid_map;
>> +       mutex_lock(&vcpu->kvm->arch.phyid_map_lock);
>> +       if (map->phys_map[cpuid].enabled) {
>> +               /*
>> +                * Cpuid is already set before
>> +                * Forbid changing different cpuid at runtime
>> +                */
>> +               if (cpuid != val) {
>> +                       /*
>> +                        * Cpuid 0 is initial value for vcpu, maybe invalid
>> +                        * unset value for vcpu
>> +                        */
>> +                       if (cpuid) {
>> +                               mutex_unlock(&vcpu->kvm->arch.phyid_map_lock);
>> +                               return -EINVAL;
>> +                       }
>> +               } else {
>> +                        /* Discard duplicated cpuid set */
>> +                       mutex_unlock(&vcpu->kvm->arch.phyid_map_lock);
>> +                       return 0;
>> +               }
>> +       }
>> +
>> +       if (map->phys_map[val].enabled) {
>> +               /*
>> +                * New cpuid is already set with other vcpu
>> +                * Forbid sharing the same cpuid between different vcpus
>> +                */
>> +               if (map->phys_map[val].vcpu != vcpu) {
>> +                       mutex_unlock(&vcpu->kvm->arch.phyid_map_lock);
>> +                       return -EINVAL;
>> +               }
>> +
>> +               /* Discard duplicated cpuid set operation*/
>> +               mutex_unlock(&vcpu->kvm->arch.phyid_map_lock);
>> +               return 0;
>> +       }
>> +
>> +       kvm_write_sw_gcsr(csr, LOONGARCH_CSR_CPUID, val);
>> +       map->phys_map[val].enabled      = true;
>> +       map->phys_map[val].vcpu         = vcpu;
>> +       if (map->max_phyid < val)
>> +               map->max_phyid = val;
>> +       mutex_unlock(&vcpu->kvm->arch.phyid_map_lock);
>> +       return 0;
>> +}
>> +
>> +struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm *kvm, int cpuid)
>> +{
>> +       struct kvm_phyid_map  *map;
>> +
>> +       if (cpuid >= KVM_MAX_PHYID)
>> +               return NULL;
>> +
>> +       map = kvm->arch.phyid_map;
>> +       if (map->phys_map[cpuid].enabled)
>> +               return map->phys_map[cpuid].vcpu;
>> +
>> +       return NULL;
>> +}
>> +
>> +static inline void kvm_drop_cpuid(struct kvm_vcpu *vcpu)
>> +{
>> +       int cpuid;
>> +       struct loongarch_csrs *csr = vcpu->arch.csr;
>> +       struct kvm_phyid_map  *map;
>> +
>> +       map = vcpu->kvm->arch.phyid_map;
>> +       cpuid = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT);
>> +       if (cpuid >= KVM_MAX_PHYID)
>> +               return;
>> +
>> +       if (map->phys_map[cpuid].enabled) {
>> +               map->phys_map[cpuid].vcpu = NULL;
>> +               map->phys_map[cpuid].enabled = false;
>> +               kvm_write_sw_gcsr(csr, LOONGARCH_CSR_CPUID, 0);
>> +       }
>> +}
>> +
>>   static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 val)
>>   {
>>          int ret = 0, gintc;
>> @@ -291,7 +380,8 @@ static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 val)
>>                  kvm_set_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, gintc);
>>
>>                  return ret;
>> -       }
>> +       } else if (id == LOONGARCH_CSR_CPUID)
>> +               return kvm_set_cpuid(vcpu, val);
>>
>>          kvm_write_sw_gcsr(csr, id, val);
>>
>> @@ -925,6 +1015,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>>          hrtimer_cancel(&vcpu->arch.swtimer);
>>          kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
>>          kfree(vcpu->arch.csr);
>> +       kvm_drop_cpuid(vcpu);
>>
>>          /*
>>           * If the vCPU is freed and reused as another vCPU, we don't want the
>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
>> index 0a37f6fa8f2d..6fd5916ebef3 100644
>> --- a/arch/loongarch/kvm/vm.c
>> +++ b/arch/loongarch/kvm/vm.c
>> @@ -30,6 +30,14 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>          if (!kvm->arch.pgd)
>>                  return -ENOMEM;
>>
>> +       kvm->arch.phyid_map = kvzalloc(sizeof(struct kvm_phyid_map),
>> +                               GFP_KERNEL_ACCOUNT);
>> +       if (!kvm->arch.phyid_map) {
>> +               free_page((unsigned long)kvm->arch.pgd);
>> +               kvm->arch.pgd = NULL;
>> +               return -ENOMEM;
>> +       }
>> +
>>          kvm_init_vmcs(kvm);
>>          kvm->arch.gpa_size = BIT(cpu_vabits - 1);
>>          kvm->arch.root_level = CONFIG_PGTABLE_LEVELS - 1;
>> @@ -44,6 +52,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>          for (i = 0; i <= kvm->arch.root_level; i++)
>>                  kvm->arch.pte_shifts[i] = PAGE_SHIFT + i * (PAGE_SHIFT - 3);
>>
>> +       mutex_init(&kvm->arch.phyid_map_lock);
>>          return 0;
>>   }
>>
>> @@ -51,7 +60,9 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>>   {
>>          kvm_destroy_vcpus(kvm);
>>          free_page((unsigned long)kvm->arch.pgd);
>> +       kvfree(kvm->arch.phyid_map);
>>          kvm->arch.pgd = NULL;
>> +       kvm->arch.phyid_map = NULL;
>>   }
>>
>>   int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>> --
>> 2.39.3
>>

