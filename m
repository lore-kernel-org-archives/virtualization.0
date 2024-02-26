Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF273233;
	Mon, 26 Feb 2024 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913074; cv=none; b=Tbdp9R+NdzkWUne6GmDX/Bsp4IXB1xmEbODA8uU4j+301WDfYoUW+7JH2uUh53ZSi9N1AXNMFfH5luV1O+bEtD6696/EVMiKLIzT25tsUoJYQLW7JzR5qqhocYAQs6nSmCcp2o33jArmqa9wasvYeNSAjEbRe5Knb9Ptdzz2LxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913074; c=relaxed/simple;
	bh=y318UcE4MAk0MLYiDOQ/dMvM4XNo78p/1t5blVIvXXs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pjS5aQsK+lONe8ZN5kbJqun5TzyD3CXk0JdIF7Ftu6YlkIlG814Pn9RD5nv4oEBBLDbvKMfRmIAj5vIYC6Xcj1oNIAp9rcg7pZ8yAER2wAE9V8jiCCvg+BnJ7KPcLL2efL2xxj1ADO2p27IgqTwWDqXwTa/KxKW6i810d+OWeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8Axeein8dtlDmcRAA--.25060S3;
	Mon, 26 Feb 2024 10:04:23 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX8+k8dtlPRlEAA--.47464S3;
	Mon, 26 Feb 2024 10:04:22 +0800 (CST)
Subject: Re: [PATCH v5 3/6] LoongArch: KVM: Add cpucfg area for kvm hypervisor
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org
References: <20240222032803.2177856-1-maobibo@loongson.cn>
 <20240222032803.2177856-4-maobibo@loongson.cn>
 <CAAhV-H5eqXMqTYVb6cAVqOsDNcEDeP9HzaMKw69KFQeVaAYEdA@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <d1a6c424-b710-74d6-29f6-e0d8e597e1fb@loongson.cn>
Date: Mon, 26 Feb 2024 10:04:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5eqXMqTYVb6cAVqOsDNcEDeP9HzaMKw69KFQeVaAYEdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxX8+k8dtlPRlEAA--.47464S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw47urW5uw4kGw4kJryDXFc_yoWrKF4xpF
	WxZFnYgr48GryIy3y2qw45WrsIqr4kKr129FyfJa4rCFWaqryfAr40krWqkFyDtws5CF1I
	qF15tr13uF1qyagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
	UUU==



On 2024/2/24 下午5:13, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Feb 22, 2024 at 11:28 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Instruction cpucfg can be used to get processor features. And there
>> is trap exception when it is executed in VM mode, and also it is
>> to provide cpu features to VM. On real hardware cpucfg area 0 - 20
>> is used.  Here one specified area 0x40000000 -- 0x400000ff is used
>> for KVM hypervisor to privide PV features, and the area can be extended
>> for other hypervisors in future. This area will never be used for
>> real HW, it is only used by software.
> After reading and thinking, I find that the hypercall method which is
> used in our productive kernel is better than this cpucfg method.
> Because hypercall is more simple and straightforward, plus we don't
> worry about conflicting with the real hardware.
No, I do not think so. cpucfg is simper than hypercall, hypercall can
be in effect when system runs in guest mode. In some scenario like TCG 
mode, hypercall is illegal intruction, however cpucfg can work.

Extioi virtualization extension will be added later, cpucfg can be used 
to get extioi features. It is unlikely that extioi driver depends on 
PARA_VIRT macro if hypercall is used to get features.

Regards
Bibo Mao

> 
> Huacai
> 
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/inst.h      |  1 +
>>   arch/loongarch/include/asm/loongarch.h | 10 ++++++
>>   arch/loongarch/kvm/exit.c              | 46 +++++++++++++++++---------
>>   3 files changed, 41 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
>> index d8f637f9e400..ad120f924905 100644
>> --- a/arch/loongarch/include/asm/inst.h
>> +++ b/arch/loongarch/include/asm/inst.h
>> @@ -67,6 +67,7 @@ enum reg2_op {
>>          revhd_op        = 0x11,
>>          extwh_op        = 0x16,
>>          extwb_op        = 0x17,
>> +       cpucfg_op       = 0x1b,
>>          iocsrrdb_op     = 0x19200,
>>          iocsrrdh_op     = 0x19201,
>>          iocsrrdw_op     = 0x19202,
>> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
>> index 46366e783c84..a1d22e8b6f94 100644
>> --- a/arch/loongarch/include/asm/loongarch.h
>> +++ b/arch/loongarch/include/asm/loongarch.h
>> @@ -158,6 +158,16 @@
>>   #define  CPUCFG48_VFPU_CG              BIT(2)
>>   #define  CPUCFG48_RAM_CG               BIT(3)
>>
>> +/*
>> + * cpucfg index area: 0x40000000 -- 0x400000ff
>> + * SW emulation for KVM hypervirsor
>> + */
>> +#define CPUCFG_KVM_BASE                        0x40000000UL
>> +#define CPUCFG_KVM_SIZE                        0x100
>> +#define CPUCFG_KVM_SIG                 CPUCFG_KVM_BASE
>> +#define  KVM_SIGNATURE                 "KVM\0"
>> +#define CPUCFG_KVM_FEATURE             (CPUCFG_KVM_BASE + 4)
>> +
>>   #ifndef __ASSEMBLY__
>>
>>   /* CSR */
>> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
>> index 923bbca9bd22..6a38fd59d86d 100644
>> --- a/arch/loongarch/kvm/exit.c
>> +++ b/arch/loongarch/kvm/exit.c
>> @@ -206,10 +206,37 @@ int kvm_emu_idle(struct kvm_vcpu *vcpu)
>>          return EMULATE_DONE;
>>   }
>>
>> -static int kvm_trap_handle_gspr(struct kvm_vcpu *vcpu)
>> +static int kvm_emu_cpucfg(struct kvm_vcpu *vcpu, larch_inst inst)
>>   {
>>          int rd, rj;
>>          unsigned int index;
>> +
>> +       rd = inst.reg2_format.rd;
>> +       rj = inst.reg2_format.rj;
>> +       ++vcpu->stat.cpucfg_exits;
>> +       index = vcpu->arch.gprs[rj];
>> +
>> +       /*
>> +        * By LoongArch Reference Manual 2.2.10.5
>> +        * Return value is 0 for undefined cpucfg index
>> +        */
>> +       switch (index) {
>> +       case 0 ... (KVM_MAX_CPUCFG_REGS - 1):
>> +               vcpu->arch.gprs[rd] = vcpu->arch.cpucfg[index];
>> +               break;
>> +       case CPUCFG_KVM_SIG:
>> +               vcpu->arch.gprs[rd] = *(unsigned int *)KVM_SIGNATURE;
>> +               break;
>> +       default:
>> +               vcpu->arch.gprs[rd] = 0;
>> +               break;
>> +       }
>> +
>> +       return EMULATE_DONE;
>> +}
>> +
>> +static int kvm_trap_handle_gspr(struct kvm_vcpu *vcpu)
>> +{
>>          unsigned long curr_pc;
>>          larch_inst inst;
>>          enum emulation_result er = EMULATE_DONE;
>> @@ -224,21 +251,8 @@ static int kvm_trap_handle_gspr(struct kvm_vcpu *vcpu)
>>          er = EMULATE_FAIL;
>>          switch (((inst.word >> 24) & 0xff)) {
>>          case 0x0: /* CPUCFG GSPR */
>> -               if (inst.reg2_format.opcode == 0x1B) {
>> -                       rd = inst.reg2_format.rd;
>> -                       rj = inst.reg2_format.rj;
>> -                       ++vcpu->stat.cpucfg_exits;
>> -                       index = vcpu->arch.gprs[rj];
>> -                       er = EMULATE_DONE;
>> -                       /*
>> -                        * By LoongArch Reference Manual 2.2.10.5
>> -                        * return value is 0 for undefined cpucfg index
>> -                        */
>> -                       if (index < KVM_MAX_CPUCFG_REGS)
>> -                               vcpu->arch.gprs[rd] = vcpu->arch.cpucfg[index];
>> -                       else
>> -                               vcpu->arch.gprs[rd] = 0;
>> -               }
>> +               if (inst.reg2_format.opcode == cpucfg_op)
>> +                       er = kvm_emu_cpucfg(vcpu, inst);
>>                  break;
>>          case 0x4: /* CSR{RD,WR,XCHG} GSPR */
>>                  er = kvm_handle_csr(vcpu, inst);
>> --
>> 2.39.3
>>

