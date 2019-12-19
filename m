From: yezengruan <yezengruan@huawei.com>
Subject: Re: [PATCH 2/5] KVM: arm64: Implement PV_LOCK_FEATURES call
Date: Thu, 19 Dec 2019 19:59:04 +0800
Message-ID: <21910175-c89a-7a14-66a9-7b53d72a4543__9301.3850085967$1576756765$gmane$org@huawei.com>
References: <20191217135549.3240-1-yezengruan@huawei.com>
 <20191217135549.3240-3-yezengruan@huawei.com>
 <20191217142848.GB38811@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191217142848.GB38811@arm.com>
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
To: Steven Price <steven.price@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "maz@kernel.org" <maz@kernel.org>, Suzuki Poulose <Suzuki.Poulose@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, James Morse <James.Morse@arm.com>, "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "will@kernel.org" <will@kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Steve,

On 2019/12/17 22:28, Steven Price wrote:
> On Tue, Dec 17, 2019 at 01:55:46PM +0000, yezengruan@huawei.com wrote:
>> From: Zengruan Ye <yezengruan@huawei.com>
>>
>> This provides a mechanism for querying which paravirtualized lock
>> features are available in this hypervisor.
>>
>> Also add the header file which defines the ABI for the paravirtualized
>> lock features we're about to add.
>>
>> Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
>> ---
>>  arch/arm64/include/asm/pvlock-abi.h | 16 ++++++++++++++++
>>  include/linux/arm-smccc.h           | 13 +++++++++++++
>>  virt/kvm/arm/hypercalls.c           |  3 +++
>>  3 files changed, 32 insertions(+)
>>  create mode 100644 arch/arm64/include/asm/pvlock-abi.h
>>
>> diff --git a/arch/arm64/include/asm/pvlock-abi.h b/arch/arm64/include/asm/pvlock-abi.h
>> new file mode 100644
>> index 000000000000..06e0c3d7710a
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/pvlock-abi.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright(c) 2019 Huawei Technologies Co., Ltd
>> + * Author: Zengruan Ye <yezengruan@huawei.com>
>> + */
>> +
>> +#ifndef __ASM_PVLOCK_ABI_H
>> +#define __ASM_PVLOCK_ABI_H
>> +
>> +struct pvlock_vcpu_state {
>> +	__le64 preempted;
> 
> Somewhere we need to document when 'preempted' is. It looks like it's a
> 1-bit field from the later patches.

Good point, I'll document this in the pvlock doc.

> 
>> +	/* Structure must be 64 byte aligned, pad to that size */
>> +	u8 padding[56];
>> +} __packed;
>> +
>> +#endif
>> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
>> index 59494df0f55b..59e65a951959 100644
>> --- a/include/linux/arm-smccc.h
>> +++ b/include/linux/arm-smccc.h
>> @@ -377,5 +377,18 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>>  			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
>>  			   0x21)
>>  
>> +/* Paravirtualised lock calls */
>> +#define ARM_SMCCC_HV_PV_LOCK_FEATURES				\
>> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
>> +			   ARM_SMCCC_SMC_64,			\
>> +			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
>> +			   0x40)
>> +
>> +#define ARM_SMCCC_HV_PV_LOCK_PREEMPTED				\
>> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
>> +			   ARM_SMCCC_SMC_64,			\
>> +			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
>> +			   0x41)
>> +
>>  #endif /*__ASSEMBLY__*/
>>  #endif /*__LINUX_ARM_SMCCC_H*/
>> diff --git a/virt/kvm/arm/hypercalls.c b/virt/kvm/arm/hypercalls.c
>> index 550dfa3e53cd..ff13871fd85a 100644
>> --- a/virt/kvm/arm/hypercalls.c
>> +++ b/virt/kvm/arm/hypercalls.c
>> @@ -52,6 +52,9 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>>  		case ARM_SMCCC_HV_PV_TIME_FEATURES:
>>  			val = SMCCC_RET_SUCCESS;
>>  			break;
>> +		case ARM_SMCCC_HV_PV_LOCK_FEATURES:
>> +			val = SMCCC_RET_SUCCESS;
>> +			break;
> 
> Ideally you wouldn't report that PV_LOCK_FEATURES exists until the
> actual hypercalls are wired up to avoid breaking a bisect.

Thanks for pointing it out to me! I'll update the code.

> 
> Steve
> 
>>  		}
>>  		break;
>>  	case ARM_SMCCC_HV_PV_TIME_FEATURES:
>> -- 
>> 2.19.1
>>
>>
> 
> .
> 

Thanks,

Zengruan
