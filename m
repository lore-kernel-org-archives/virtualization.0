From: yezengruan <yezengruan@huawei.com>
Subject: Re: [PATCH 1/5] KVM: arm64: Document PV-lock interface
Date: Thu, 19 Dec 2019 19:45:55 +0800
Message-ID: <49120a3c-405d-d2e3-2a88-ba590feccbcc__4812.08004509739$1576755982$gmane$org@huawei.com>
References: <20191217135549.3240-1-yezengruan@huawei.com>
 <20191217135549.3240-2-yezengruan@huawei.com>
 <20191217142138.GA38811@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191217142138.GA38811@arm.com>
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

On 2019/12/17 22:21, Steven Price wrote:
> On Tue, Dec 17, 2019 at 01:55:45PM +0000, yezengruan@huawei.com wrote:
>> From: Zengruan Ye <yezengruan@huawei.com>
>>
>> Introduce a paravirtualization interface for KVM/arm64 to obtain the vcpu
>> is currently running or not.
>>
>> A hypercall interface is provided for the guest to interrogate the
>> hypervisor's support for this interface and the location of the shared
>> memory structures.
>>
>> Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
>> ---
>>  Documentation/virt/kvm/arm/pvlock.rst | 31 +++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/virt/kvm/arm/pvlock.rst
>>
>> diff --git a/Documentation/virt/kvm/arm/pvlock.rst b/Documentation/virt/kvm/arm/pvlock.rst
>> new file mode 100644
>> index 000000000000..eec0c36edf17
>> --- /dev/null
>> +++ b/Documentation/virt/kvm/arm/pvlock.rst
>> @@ -0,0 +1,31 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Paravirtualized lock support for arm64
>> +======================================
>> +
>> +KVM/arm64 provids some hypervisor service calls to support a paravirtualized
>> +guest obtaining the vcpu is currently running or not.
>> +
>> +Two new SMCCC compatible hypercalls are defined:
>> +
>> +* PV_LOCK_FEATURES:   0xC5000040
>> +* PV_LOCK_PREEMPTED:  0xC5000041
> 
> These values are in the "Standard Hypervisor Service Calls" section of
> SMCCC - so is there a document that describes this features such that
> other OSes or hypervisors can implement it? I'm also not entirely sure
> of the process of ensuring that the IDs picked are non-conflicting.
> 
> Otherwise if this is a KVM specific interface this should probably
> belong within the "Vendor Specific Hypervisor Service Calls" section
> along with some probing that the hypervisor is actually KVM. Although I
> don't see anything KVM specific.

Thanks for pointing it out to me! Actually, I also don't see any documents
or KVM specific that describes this features. The values in the "Vendor
Specific Hypervisor Service Calls" section may be more appropriate, such as
the following

* PV_LOCK_FEATURES:   0xC6000020
* PV_LOCK_PREEMPTED:  0xC6000021

Please let me know if you have any suggestions.

> 
>> +
>> +The existence of the PV_LOCK hypercall should be probed using the SMCCC 1.1
>> +ARCH_FEATURES mechanism before calling it.
>> +
>> +PV_LOCK_FEATURES
>> +    ============= ========    ==========
>> +    Function ID:  (uint32)    0xC5000040
>> +    PV_call_id:   (uint32)    The function to query for support.
>> +    Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the relevant
>> +                              PV-lock feature is supported by the hypervisor.
>> +    ============= ========    ==========
>> +
>> +PV_LOCK_PREEMPTED
>> +    ============= ========    ==========
>> +    Function ID:  (uint32)    0xC5000041
>> +    Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the IPA of
>> +                              this vcpu's pv data structure is configured by
>> +                              the hypervisor.
>> +    ============= ========    ==========
> 
>>From the code it looks like there's another argument for this SMC - the
> physical address (or IPA) of a struct pvlock_vcpu_state. This structure
> also needs to be described as it is part of the ABI.

Will update.

> 
> Steve
> 
> .
> 

Thanks,

Zengruan
