Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE5BA2F;
	Mon, 12 Aug 2024 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723425058; cv=none; b=ASdSwbMab9ChTTbJDc8IG8kqLk7Us4Z/EdCGbQ65brbvVN9ax2/I1fcZafreBcaAn8OYzFwNYUQYEgiBsMcjc4wbNgP9rg+tocvQyPThEOZjHWgwnkjDMhgDcUEp2Fp9cxWJCdTlKxi9rL20gs6TT2s6orSF1XUtOS9A3DRXbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723425058; c=relaxed/simple;
	bh=rJrFm7yEqlB7PpqcS2AkAo08q2R8lUg3ybyZjtiWt9k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f6JiNSRIE2IaGlqOwBt7d7MjYAP9pYB+0YOyV0UR1uw09aicUKI5niaqB4nUMr6TMPE6vGoTdG7SW/Rjn9PALS7OwIfPxEIpdJcuSudurww2g77mtiYPI+KROEsBIPl2IfWBOWUjuAYxI8L0JUSCZGUeg1Jo3+yAHmi25NbWgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxvOobYblmfjgQAA--.42116S3;
	Mon, 12 Aug 2024 09:10:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDxkeEZYblmzYkPAA--.8190S3;
	Mon, 12 Aug 2024 09:10:49 +0800 (CST)
Subject: Re: [PATCH v5 3/3] irqchip/loongson-eiointc: Add extioi virt
 extension support
To: Thomas Gleixner <tglx@linutronix.de>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, x86@kernel.org,
 Song Gao <gaosong@loongson.cn>
References: <20240805073546.668475-1-maobibo@loongson.cn>
 <20240805073546.668475-4-maobibo@loongson.cn> <87wmkortqo.ffs@tglx>
From: maobibo <maobibo@loongson.cn>
Message-ID: <09d4ad7a-0548-28e6-f60e-c1b68c8c20b5@loongson.cn>
Date: Mon, 12 Aug 2024 09:10:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87wmkortqo.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxkeEZYblmzYkPAA--.8190S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw4DCFWxurykJrWfWF47Jrc_yoW8Aw4kpF
	W8tFsI9w4DtryavwsYqrn7JF1FvrsxJFWUK3W8KayrJa9rZryrtFnYvFy3A3WDC348AasI
	qFW5JF4j9a4SyrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOxhLUUUUU=



On 2024/8/11 上午4:46, Thomas Gleixner wrote:
> On Mon, Aug 05 2024 at 15:35, Bibo Mao wrote:
> 
>> Interrupts can be routed to maximal four virtual CPUs with one external
>> hardware interrupt. Add the extioi virt extension support so that
>> Interrupts can be routed to 256 vcpus on hypervisor mode.
> 
> interrupts .... 256 vCPUs in hypervisor mode.
will modify in next version.

> 
>>   static int cpu_to_eio_node(int cpu)
>>   {
>> -	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
>> +	int cores;
>> +
>> +	if (kvm_para_available() && kvm_para_has_feature(KVM_FEATURE_VIRT_EXTIOI))
> 
> Why isn't that kvm_para_available() check inside of
> kvm_para_has_feature() instead of inflicting it on every usage site?
> That's just error prone.
I had the same idea but not sure about it, it is to follow the 
implemantion of x86.

Yeap, it is better to put kvm_para_available() in function 
kvm_para_has_feature(), one api for caller is simple and enough.

Will do in next version.
> 
>> +		cores = CORES_PER_VEIO_NODE;
>> +	else
>> +		cores = CORES_PER_EIO_NODE;
>> +	return cpu_logical_map(cpu) / cores;
>>   }
> 
>> @@ -105,18 +144,24 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
>> @@ -140,17 +185,23 @@ static int eiointc_index(int node)
>>   
>>   static int eiointc_router_init(unsigned int cpu)
>>   {
>> -	int i, bit;
>> -	uint32_t data;
>> -	uint32_t node = cpu_to_eio_node(cpu);
>> -	int index = eiointc_index(node);
>> +	uint32_t data, node;
>> +	int i, bit, cores, index;
> 
> Is it so hard to follow:
> 
>    https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations
> 
> ?
Sorry to have the same coding style issue for the second time. I am not 
familiar with it.

Will do in next version.

Regards
Bibo Mao
> 
> Thanks,
> 
>          tglx
> 

