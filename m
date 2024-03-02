Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D58110A;
	Sat,  2 Mar 2024 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709348283; cv=none; b=mMuky3klCtaNNU1BmToB3MuYbuXBB4YYh9ZAoNE91ESOSDgYpS3gR61fAAnjf2g4gnKQOZnrPOg9r0u2IEEtcmRUS0lsmUHA8hM6tgmqxDZmJYXKRzeCf1VRnX8aiLKyt26zbr4F3DA98sOOtP3Lj+yhKOonodPGmrThhqkYyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709348283; c=relaxed/simple;
	bh=i9MXZrjdN4IaL/tM9+NfwWXuEZp3zXMWZ583WxUt7+0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dBZPSqpyZpe4pO48IgPHNRFIW3OY8oLavR29mp29XCSIwmltbzB02yustC3XCAzARtIL4CroTI9aUROd0xKZh4Q8Sgxp8Zo/vV4TaX8QfnRfyjFUi8QsPrHgdMmNQIBmuOCzxiWQeE2em6ehSVmphwbZhntDc4/6qzmwznlRoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8CxXOmqleJl3XYTAA--.39491S3;
	Sat, 02 Mar 2024 10:57:47 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbROgleJlHyVMAA--.6327S3;
	Sat, 02 Mar 2024 10:57:39 +0800 (CST)
Subject: Re: [PATCH v5 3/6] LoongArch: KVM: Add cpucfg area for kvm hypervisor
To: WANG Xuerui <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org
References: <20240222032803.2177856-1-maobibo@loongson.cn>
 <20240222032803.2177856-4-maobibo@loongson.cn>
 <CAAhV-H5eqXMqTYVb6cAVqOsDNcEDeP9HzaMKw69KFQeVaAYEdA@mail.gmail.com>
 <d1a6c424-b710-74d6-29f6-e0d8e597e1fb@loongson.cn>
 <CAAhV-H7p114hWUVrYRfKiBX3teG8sG7xmEW-Q-QT3i+xdLqDEA@mail.gmail.com>
 <06647e4a-0027-9c9f-f3bd-cd525d37b6d8@loongson.cn>
 <85781278-f3e9-4755-8715-3b9ff714fb20@app.fastmail.com>
 <0d428e30-07a8-5a91-a20c-c2469adbf613@loongson.cn>
 <327808dd-ac34-4c61-9992-38642acc9419@xen0n.name>
 <62cc24fd-025a-53c6-1c8e-2d20de54d297@loongson.cn>
 <431111f3-d84a-4311-986d-eebd91559cd3@xen0n.name>
From: maobibo <maobibo@loongson.cn>
Message-ID: <9881fa84-74c4-b7e8-63fb-607a22b1eee2@loongson.cn>
Date: Sat, 2 Mar 2024 10:57:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <431111f3-d84a-4311-986d-eebd91559cd3@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxbROgleJlHyVMAA--.6327S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xry5Xry7uFWfuF18GFy7CFX_yoW7AryDpF
	W8AF47Kr48JF4Iyws7tw1UZr1YyrW8JF48XF98AryDAryqyr1ftr40yr4Y9FyDGr1xCF1Y
	vrW7tFy7Zw1DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
	UUU==



On 2024/2/27 下午6:19, WANG Xuerui wrote:
> On 2/27/24 18:12, maobibo wrote:
>>
>>
>> On 2024/2/27 下午5:10, WANG Xuerui wrote:
>>> On 2/27/24 11:14, maobibo wrote:
>>>>
>>>>
>>>> On 2024/2/27 上午4:02, Jiaxun Yang wrote:
>>>>>
>>>>>
>>>>> 在2024年2月26日二月 上午8:04，maobibo写道：
>>>>>> On 2024/2/26 下午2:12, Huacai Chen wrote:
>>>>>>> On Mon, Feb 26, 2024 at 10:04 AM maobibo <maobibo@loongson.cn> 
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2024/2/24 下午5:13, Huacai Chen wrote:
>>>>>>>>> Hi, Bibo,
>>>>>>>>>
>>>>>>>>> On Thu, Feb 22, 2024 at 11:28 AM Bibo Mao <maobibo@loongson.cn> 
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> Instruction cpucfg can be used to get processor features. And 
>>>>>>>>>> there
>>>>>>>>>> is trap exception when it is executed in VM mode, and also it is
>>>>>>>>>> to provide cpu features to VM. On real hardware cpucfg area 0 
>>>>>>>>>> - 20
>>>>>>>>>> is used.  Here one specified area 0x40000000 -- 0x400000ff is 
>>>>>>>>>> used
>>>>>>>>>> for KVM hypervisor to privide PV features, and the area can be 
>>>>>>>>>> extended
>>>>>>>>>> for other hypervisors in future. This area will never be used for
>>>>>>>>>> real HW, it is only used by software.
>>>>>>>>> After reading and thinking, I find that the hypercall method 
>>>>>>>>> which is
>>>>>>>>> used in our productive kernel is better than this cpucfg method.
>>>>>>>>> Because hypercall is more simple and straightforward, plus we 
>>>>>>>>> don't
>>>>>>>>> worry about conflicting with the real hardware.
>>>>>>>> No, I do not think so. cpucfg is simper than hypercall, 
>>>>>>>> hypercall can
>>>>>>>> be in effect when system runs in guest mode. In some scenario 
>>>>>>>> like TCG
>>>>>>>> mode, hypercall is illegal intruction, however cpucfg can work.
>>>>>>> Nearly all architectures use hypercall except x86 for its historical
>>>>>> Only x86 support multiple hypervisors and there is multiple 
>>>>>> hypervisor
>>>>>> in x86 only. It is an advantage, not historical reason.
>>>>>
>>>>> I do believe that all those stuff should not be exposed to guest 
>>>>> user space
>>>>> for security reasons.
>>>> Can you add PLV checking when cpucfg 0x40000000-0x400000FF is 
>>>> emulated? if it is user mode return value is zero and it is kernel 
>>>> mode emulated value will be returned. It can avoid information leaking.
>>>
>>> I've suggested this approach in another reply [1], but I've rechecked 
>>> the manual, and it turns out this behavior is not permitted by the 
>>> current wording. See LoongArch Reference Manual v1.10, Volume 1, 
>>> Section 2.2.10.5 "CPUCFG":
>>>
>>>  > CPUCFG 访问未定义的配置字将读回全 0 值。
>>>  >
>>>  > Reads of undefined CPUCFG configuration words shall return 
>>> all-zeroes.
>>>
>>> This sentence mentions no distinction based on privilege modes, so it 
>>> can only mean the behavior applies universally regardless of 
>>> privilege modes.
>>>
>>> I think if you want to make CPUCFG behavior PLV-dependent, you may 
>>> have to ask the LoongArch spec editors, internally or in public, for 
>>> a new spec revision.
>> No, CPUCFG behavior between CPUCFG0-CPUCFG21 is unchanged, only that 
>> it can be defined by software since CPUCFG 0x400000000 is used by 
>> software.
> 
> The 0x40000000 range is not mentioned in the manuals. I know you've 
> confirmed privately with HW team but this needs to be properly 
> documented for public projects to properly rely on.
> 
>>> (There are already multiple third-party LoongArch implementers as of 
>>> late 2023, so any ISA-level change like this would best be 
>>> coordinated, to minimize surprises.)
>> With document Vol 4-23
>> https://www.intel.com/content/dam/develop/external/us/en/documents/335592-sdm-vol-4.pdf 
>>
>>
>> There is one line "MSR address range between 40000000H - 400000FFH is 
>> marked as a specially reserved range. All existing and
>> future processors will not implement any features using any MSR in 
>> this range."
> 
> Thanks for providing this info, now at least we know why it's this 
> specific range of 0x400000XX that's chosen.
> 
>>
>> It only says that it is reserved, it does not say detailed software 
>> behavior. Software behavior is defined in hypervisor such as:
>> https://github.com/MicrosoftDocs/Virtualization-Documentation/blob/main/tlfs/Requirements%20for%20Implementing%20the%20Microsoft%20Hypervisor%20Interface.pdf 
>>
>> https://kb.vmware.com/s/article/1009458
>>
>> If hypercall method is used, there should be ABI also like aarch64:
>> https://documentation-service.arm.com/static/6013e5faeee5236980d08619
> 
> Yes proper documentation of public API surface is always necessary 
> *before* doing real work. Because right now the hypercall provider is 
> Linux KVM, maybe we can document the existing and planned hypercall 
> usage and ABI in the kernel docs along with code changes.
> 
yes, I will add hypercall in kernel docs.

SMC calling convention is ABI between OS and secure firmware, LoongArch 
has no secure mode, it not necessary to has such doc.The hypercall 
calling convention is relative with hypervisor SW, not relative with CPU 
HW vendor. Each hypervisor maybe has its separate hypercall calling 
convention just like syscall ABIs.

Regards
Bibo Mao

