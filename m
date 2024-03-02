Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA9134AB;
	Sat,  2 Mar 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709369545; cv=none; b=T8vZp82PeWrVfxhK3DZDZtWxkRk9LS8p80YOg5yzP21MYw9qc1/8XCKNBJ/Zw+GE6gwnFT+iLsScI+WtDVUUv3dou5CobJXeUcDw8D1l45V+FCsAILPs5j2HMV8C/JWKFpjNACw2A5mJY8kZYvvwfnkNTaapLS+dfHjS7A2PcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709369545; c=relaxed/simple;
	bh=uWd20OmnGGkC/WUqVx0PlYE+cxIPNqyxSaBrmZQb9V0=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cS0fH+54eUTwsKMNGerpYl7bWNKT9vwcgyAWM6Do5oS8F+Or0JIKWdXMevPjraX1V+Q2wXx8Jp5WRItTccuJFdnsXkZAL5yt8h2KJ8Wjl1mYCciwvZ401Tg8N0Yovrx108Rw9I1Mv3RjFsZ/VcCvX9P8FEt8MMChO1e7R6HfgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8CxXOnE6OJlYYsTAA--.39643S3;
	Sat, 02 Mar 2024 16:52:21 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxbs296OJlGVxMAA--.4105S3;
	Sat, 02 Mar 2024 16:52:15 +0800 (CST)
Subject: Re: [PATCH v6 0/7] LoongArch: Add pv ipi support on LoongArch VM
From: maobibo <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240302075120.1414999-1-maobibo@loongson.cn>
Message-ID: <b2084dbd-3ea6-736a-293e-2309e828a960@loongson.cn>
Date: Sat, 2 Mar 2024 16:52:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240302075120.1414999-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxbs296OJlGVxMAA--.4105S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw45Wr47Aw43Cr4rWw13Jrc_yoW7WFy7pa
	yUurn3WFs5Gr93Zwnxtas5ur98Aw1xG3yaq3WayrW8CFZFqFyUZr48Kryqyas5Jw4rJFW0
	qF1rGw1Yg3WUAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07je4E
	iUUUUU=

Sorry for the noise. It seems that there is some problem with my mail
client when batch method.

Please ignore this series, will send one by one manually.

Regards
Bibo Mao

On 2024/3/2 下午3:51, Bibo Mao wrote:
> On physical machine, ipi HW uses IOCSR registers, however there is trap
> into hypervisor when vcpu accesses IOCSR registers if system is in VM
> mode. SWI is a interrupt mechanism like SGI on ARM, software can send
> interrupt to CPU, only that on LoongArch SWI can only be sent to local CPU
> now. So SWI can not used for IPI on real HW system, however it can be used
> on VM when combined with hypercall method. IPI can be sent with hypercall
> method and SWI interrupt is injected to vcpu, vcpu can treat SWI
> interrupt as IPI.
> 
> With PV IPI supported, there is one trap with IPI sending, however with IPI
> receiving there is no trap. with IOCSR HW ipi method, there will be one
> trap with IPI sending and two trap with ipi receiving.
> 
> Also IPI multicast support is added for VM, the idea comes from x86 PV ipi.
> IPI can be sent to 128 vcpus in one time. With IPI multicast support, trap
> will be reduced greatly.
> 
> Here is the microbenchmarck data with "perf bench futex wake" testcase on
> 3C5000 single-way machine, there are 16 cpus on 3C5000 single-way machine,
> VM has 16 vcpus also. The benchmark data is ms time unit to wakeup 16
> threads, the performance is better if data is smaller.
> 
> physical machine                     0.0176 ms
> VM original                          0.1140 ms
> VM with pv ipi patch                 0.0481 ms
> 
> It passes to boot with 128/256 vcpus, runltp command in package ltp-20230516
> passes to run with 16 cores.
> 
> ---
> Change in V6:
>    1. Add privilege checking when emulating cpucfg at index 0x4000000 --
> 0x400000FF, return 0 if not executed at kernel mode.
>    2. Add document about LoongArch pv ipi with new creatly directory
> Documentation/virt/kvm/loongarch/
>    3. Fix pv ipi handling in kvm backend function kvm_pv_send_ipi(),
> where min should plus BITS_PER_LONG with second bitmap, otherwise
> VM with more than 64 vpus fails to boot.
>    4. Adjust patch order and code refine with review comments.
>   
> Change in V5:
>    1. Refresh function/macro name from review comments.
> 
> Change in V4:
>    1. Modfiy pv ipi hook function name call_func_ipi() and
> call_func_single_ipi() with send_ipi_mask()/send_ipi_single(), since pv
> ipi is used for both remote function call and reschedule notification.
>    2. Refresh changelog.
> 
> Change in V3:
>    1. Add 128 vcpu ipi multicast support like x86
>    2. Change cpucfg base address from 0x10000000 to 0x40000000, in order
> to avoid confliction with future hw usage
>    3. Adjust patch order in this patchset, move patch
> Refine-ipi-ops-on-LoongArch-platform to the first one.
> 
> Change in V2:
>    1. Add hw cpuid map support since ipi routing uses hw cpuid
>    2. Refine changelog description
>    3. Add hypercall statistic support for vcpu
>    4. Set percpu pv ipi message buffer aligned with cacheline
>    5. Refine pv ipi send logic, do not send ipi message with if there is
> pending ipi message.
> ---
> Bibo Mao (7):
>    LoongArch/smp: Refine some ipi functions on LoongArch platform
>    LoongArch: KVM: Add hypercall instruction emulation support
>    LoongArch: KVM: Add cpucfg area for kvm hypervisor
>    LoongArch: KVM: Add vcpu search support from physical cpuid
>    LoongArch: KVM: Add pv ipi support on kvm side
>    LoongArch: Add pv ipi support on guest kernel side
>    Documentation: KVM: Add hypercall for LoongArch
> 
>   Documentation/virt/kvm/index.rst              |   1 +
>   .../virt/kvm/loongarch/hypercalls.rst         |  79 +++++++++
>   Documentation/virt/kvm/loongarch/index.rst    |  10 ++
>   arch/loongarch/Kconfig                        |   9 +
>   arch/loongarch/include/asm/Kbuild             |   1 -
>   arch/loongarch/include/asm/hardirq.h          |   5 +
>   arch/loongarch/include/asm/inst.h             |   1 +
>   arch/loongarch/include/asm/irq.h              |  10 +-
>   arch/loongarch/include/asm/kvm_host.h         |  27 +++
>   arch/loongarch/include/asm/kvm_para.h         | 156 ++++++++++++++++++
>   arch/loongarch/include/asm/kvm_vcpu.h         |   1 +
>   arch/loongarch/include/asm/loongarch.h        |  11 ++
>   arch/loongarch/include/asm/paravirt.h         |  27 +++
>   .../include/asm/paravirt_api_clock.h          |   1 +
>   arch/loongarch/include/asm/smp.h              |  31 ++--
>   arch/loongarch/include/uapi/asm/Kbuild        |   2 -
>   arch/loongarch/kernel/Makefile                |   1 +
>   arch/loongarch/kernel/irq.c                   |  24 +--
>   arch/loongarch/kernel/paravirt.c              | 151 +++++++++++++++++
>   arch/loongarch/kernel/perf_event.c            |  14 +-
>   arch/loongarch/kernel/smp.c                   |  62 ++++---
>   arch/loongarch/kernel/time.c                  |  12 +-
>   arch/loongarch/kvm/exit.c                     | 141 ++++++++++++++--
>   arch/loongarch/kvm/vcpu.c                     |  94 ++++++++++-
>   arch/loongarch/kvm/vm.c                       |  11 ++
>   25 files changed, 780 insertions(+), 102 deletions(-)
>   create mode 100644 Documentation/virt/kvm/loongarch/hypercalls.rst
>   create mode 100644 Documentation/virt/kvm/loongarch/index.rst
>   create mode 100644 arch/loongarch/include/asm/kvm_para.h
>   create mode 100644 arch/loongarch/include/asm/paravirt.h
>   create mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
>   delete mode 100644 arch/loongarch/include/uapi/asm/Kbuild
>   create mode 100644 arch/loongarch/kernel/paravirt.c
> 
> 
> base-commit: 87adedeba51a822533649b143232418b9e26d08b
> 

