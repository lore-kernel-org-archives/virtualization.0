Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885D1DA3A;
	Mon,  6 May 2024 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714977135; cv=none; b=rbbUXEK4NOFGUYoMFWQZYlIWzXtTQbVjwc4oSp2SAnDvLRhmW15Ue39FbXT03WDcTO1aVAZlMUnCupQteXbhHW2D4DUFTXEW5NEzpRVErL7uo5XanDYLYGnwxSbQhet0OYnvK+9tauz5rkU2UyLjxvUMTdTEtPgjt5xylm6h3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714977135; c=relaxed/simple;
	bh=ps3bfPlOGnscXXGNpZRI1HTSPZ1kzyMnphRxw5lw+jI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HIC7XtLI0i526KsV9u/90eE4nAUYlAwLcuMCEn3H3u/ej6KEDuYCD5g0iXfnNFvjWPMiTjEX7bPU8zZNzrz/R7ooHWhZQma0we70T8IswzpNwQ1GSRd57NDJsIC4+na5HjUVUVaUvBOzVsRBfzzXeDfQ9+l2TvB7D2Mo5iJBCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8AxiPBmeThm6vsHAA--.22375S3;
	Mon, 06 May 2024 14:32:07 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxyt1ieThmqzUSAA--.36589S3;
	Mon, 06 May 2024 14:32:04 +0800 (CST)
Subject: Re: [PATCH v8 0/6] LoongArch: Add pv ipi support on LoongArch VM
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org
References: <20240428100518.1642324-1-maobibo@loongson.cn>
 <CAAhV-H6c2Wym4w5WchP=K1fHv8uVFDp59CATYKcH3mGYDxnKmA@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <0640effb-5c65-5f52-a58f-4a12104b189b@loongson.cn>
Date: Mon, 6 May 2024 14:32:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6c2Wym4w5WchP=K1fHv8uVFDp59CATYKcH3mGYDxnKmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxyt1ieThmqzUSAA--.36589S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF47Ar17WFWkKr4fKFWUKFX_yoWxtFWUpF
	W5AFn5Crs5Gr1fCwnFv3sxWr1DJw4xGr1aq3WayrW0krsFqFy7Zr48trZ5ua48Jws5JFW0
	qFyrGw1Y93WUAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vA
	pUUUUUU==



On 2024/5/6 上午9:45, Huacai Chen wrote:
> Hi, Bibo,
> 
> I have done an off-list discussion with some KVM experts, and they
> think user-space have its right to know PV features, so cpucfg
> solution is acceptable.
> 
> And I applied this series with some modifications at
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-kvm
> You can test it now. But it seems the upstream qemu cannot enable PV IPI now.
VM with 128/256 vcpus boots with this series in loongarch-kvm branch. 
And pv ipi works by information "cat /proc/interrupts". There need small 
modification with qemu like this, and we
will submit the patch to qemu after it is merged.

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 441d764843..9f7556cd93 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -15,6 +15,8 @@
  #include "sysemu/runstate.h"
  #include "sysemu/reset.h"
  #include "sysemu/rtc.h"
+#include "sysemu/tcg.h"
+#include "sysemu/kvm.h"
  #include "hw/loongarch/virt.h"
  #include "exec/address-spaces.h"
  #include "hw/irq.h"
@@ -786,12 +788,18 @@ static void loongarch_qemu_write(void *opaque, 
hwaddr addr,

  static uint64_t loongarch_qemu_read(void *opaque, hwaddr addr, 
unsigned size)
  {
+    uint64_t ret = 0;
+
      switch (addr) {
      case VERSION_REG:
          return 0x11ULL;
      case FEATURE_REG:
-        return 1ULL << IOCSRF_MSI | 1ULL << IOCSRF_EXTIOI |
+        ret =1ULL << IOCSRF_MSI | 1ULL << IOCSRF_EXTIOI |
                 1ULL << IOCSRF_CSRIPI;
+        if (kvm_enabled()) {
+            ret |= 1ULL << IOCSRF_VM;
+        }
+       return ret;
      case VENDOR_REG:
          return 0x6e6f73676e6f6f4cULL; /* "Loongson" */
      case CPUNAME_REG:


Regards
Bibo Mao
> 
> I will reply to other patches about my modifications.
> 
> Huacai
> 
> On Sun, Apr 28, 2024 at 6:05 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> On physical machine, ipi HW uses IOCSR registers, however there is trap
>> into hypervisor when vcpu accesses IOCSR registers if system is in VM
>> mode. SWI is a interrupt mechanism like SGI on ARM, software can send
>> interrupt to CPU, only that on LoongArch SWI can only be sent to local CPU
>> now. So SWI can not used for IPI on real HW system, however it can be used
>> on VM when combined with hypercall method. IPI can be sent with hypercall
>> method and SWI interrupt is injected to vcpu, vcpu can treat SWI
>> interrupt as IPI.
>>
>> With PV IPI supported, there is one trap with IPI sending, however with IPI
>> receiving there is no trap. with IOCSR HW ipi method, there will be one
>> trap with IPI sending and two trap with ipi receiving.
>>
>> Also IPI multicast support is added for VM, the idea comes from x86 PV ipi.
>> IPI can be sent to 128 vcpus in one time. With IPI multicast support, trap
>> will be reduced greatly.
>>
>> Here is the microbenchmarck data with "perf bench futex wake" testcase on
>> 3C5000 single-way machine, there are 16 cpus on 3C5000 single-way machine,
>> VM has 16 vcpus also. The benchmark data is ms time unit to wakeup 16
>> threads, the performance is better if data is smaller.
>>
>> physical machine                     0.0176 ms
>> VM original                          0.1140 ms
>> VM with pv ipi patch                 0.0481 ms
>>
>> It passes to boot with 128/256 vcpus, and passes to run runltp command
>> with package ltp-20230516.
>>
>> ---
>> v7 --- v8:
>>   1. Remove kernel PLV mode checking with cpucfg emulation for hypervisor
>> feature inquiry.
>>   2. Remove document about loongarch hypercall ABI per request of huacai,
>> will add English/Chinese doc at the same time in later.
>>
>> v6 --- v7:
>>    1. Refine LoongArch virt document by review comments.
>>    2. Add function kvm_read_reg()/kvm_write_reg() in hypercall emulation,
>> and later it can be used for other trap emulations.
>>
>> v5 --- v6:
>>    1. Add privilege checking when emulating cpucfg at index 0x4000000 --
>> 0x400000FF, return 0 if not executed at kernel mode.
>>    2. Add document about LoongArch pv ipi with new creatly directory
>> Documentation/virt/kvm/loongarch/
>>    3. Fix pv ipi handling in kvm backend function kvm_pv_send_ipi(),
>> where min should plus BITS_PER_LONG with second bitmap, otherwise
>> VM with more than 64 vpus fails to boot.
>>    4. Adjust patch order and code refine with review comments.
>>
>> v4 --- v5:
>>    1. Refresh function/macro name from review comments.
>>
>> v3 --- v4:
>>    1. Modfiy pv ipi hook function name call_func_ipi() and
>> call_func_single_ipi() with send_ipi_mask()/send_ipi_single(), since pv
>> ipi is used for both remote function call and reschedule notification.
>>    2. Refresh changelog.
>>
>> v2 --- v3:
>>    1. Add 128 vcpu ipi multicast support like x86
>>    2. Change cpucfg base address from 0x10000000 to 0x40000000, in order
>> to avoid confliction with future hw usage
>>    3. Adjust patch order in this patchset, move patch
>> Refine-ipi-ops-on-LoongArch-platform to the first one.
>>
>> v1 --- v2:
>>    1. Add hw cpuid map support since ipi routing uses hw cpuid
>>    2. Refine changelog description
>>    3. Add hypercall statistic support for vcpu
>>    4. Set percpu pv ipi message buffer aligned with cacheline
>>    5. Refine pv ipi send logic, do not send ipi message with if there is
>> pending ipi message.
>> ---
>> Bibo Mao (6):
>>    LoongArch/smp: Refine some ipi functions on LoongArch platform
>>    LoongArch: KVM: Add hypercall instruction emulation support
>>    LoongArch: KVM: Add cpucfg area for kvm hypervisor
>>    LoongArch: KVM: Add vcpu search support from physical cpuid
>>    LoongArch: KVM: Add pv ipi support on kvm side
>>    LoongArch: Add pv ipi support on guest kernel side
>>
>>   arch/loongarch/Kconfig                        |   9 +
>>   arch/loongarch/include/asm/Kbuild             |   1 -
>>   arch/loongarch/include/asm/hardirq.h          |   5 +
>>   arch/loongarch/include/asm/inst.h             |   1 +
>>   arch/loongarch/include/asm/irq.h              |  10 +-
>>   arch/loongarch/include/asm/kvm_host.h         |  27 +++
>>   arch/loongarch/include/asm/kvm_para.h         | 155 ++++++++++++++++++
>>   arch/loongarch/include/asm/kvm_vcpu.h         |  11 ++
>>   arch/loongarch/include/asm/loongarch.h        |  11 ++
>>   arch/loongarch/include/asm/paravirt.h         |  27 +++
>>   .../include/asm/paravirt_api_clock.h          |   1 +
>>   arch/loongarch/include/asm/smp.h              |  31 ++--
>>   arch/loongarch/include/uapi/asm/Kbuild        |   2 -
>>   arch/loongarch/kernel/Makefile                |   1 +
>>   arch/loongarch/kernel/irq.c                   |  24 +--
>>   arch/loongarch/kernel/paravirt.c              | 151 +++++++++++++++++
>>   arch/loongarch/kernel/perf_event.c            |  14 +-
>>   arch/loongarch/kernel/smp.c                   |  62 ++++---
>>   arch/loongarch/kernel/time.c                  |  12 +-
>>   arch/loongarch/kvm/exit.c                     | 132 +++++++++++++--
>>   arch/loongarch/kvm/vcpu.c                     |  94 ++++++++++-
>>   arch/loongarch/kvm/vm.c                       |  11 ++
>>   22 files changed, 690 insertions(+), 102 deletions(-)
>>   create mode 100644 arch/loongarch/include/asm/kvm_para.h
>>   create mode 100644 arch/loongarch/include/asm/paravirt.h
>>   create mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
>>   delete mode 100644 arch/loongarch/include/uapi/asm/Kbuild
>>   create mode 100644 arch/loongarch/kernel/paravirt.c
>>
>>
>> base-commit: 5eb4573ea63d0c83bf58fb7c243fc2c2b6966c02
>> --
>> 2.39.3
>>
>>

