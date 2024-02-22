Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA6D39FC7;
	Thu, 22 Feb 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596372; cv=none; b=aLI02QNeHrgBtcR+Qn2vE5g8jSEj8OXfXqRKIPZTHWn62n4X8DPQUdiBhntO7RBjxN+8WU8XG2MG9J9TCINTQGwHVm8Cg3D2eyw4Z6XtRqVxx1c1Ak/9lP3rrbVbqN9MosSUeOSGPGXEYd3+efR5TiJQ/z4yVs5cYSMb2kJ8R74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596372; c=relaxed/simple;
	bh=72HRlj4wNG+uTgP9OOegzPNQJN5da4Rz0slrIrJJ5N8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LtJ7xIpacDqPI1s6bcz5F16FEfF3bl8Z/B2s4LSgbFGukcGclS5oIW8O+vJaHeRDO16zXY+liG40/M57xBjBtWwj9opqN4MqMHJk3NUSNrdEjN7+yonnVokU7GgG7Jzf+J+LotCFhKcKtNIIyC0C0o6J0buUigElSHlssX7oXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8AxqvCKHNdlMikQAA--.42082S3;
	Thu, 22 Feb 2024 18:06:02 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf8+HHNdlC7I+AA--.31618S3;
	Thu, 22 Feb 2024 18:06:01 +0800 (CST)
Subject: Re: [PATCH v4 0/6] LoongArch: Add pv ipi support on LoongArch VM
To: WANG Xuerui <kernel@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org
References: <20240201031950.3225626-1-maobibo@loongson.cn>
 <0f4d83e2-bff9-49d9-8066-9f194ce96306@xen0n.name>
 <447f4279-aea9-4f35-b87e-a3fc8c6c20ac@xen0n.name>
 <4a6e25ec-cdb6-887a-2c64-3df12d30c89a@loongson.cn>
 <7867d9c8-22fb-4bfc-92dc-c782d29c56f9@xen0n.name>
From: maobibo <maobibo@loongson.cn>
Message-ID: <542a8f4e-cec3-92d0-1cdd-43d112eec605@loongson.cn>
Date: Thu, 22 Feb 2024 18:06:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7867d9c8-22fb-4bfc-92dc-c782d29c56f9@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxf8+HHNdlC7I+AA--.31618S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urW5JFykZw15AFy3GrWUKFX_yoW8WFy3pF
	WS9a4UKF4vyry0y392kw40gryYyr4xJr1SqrnYkryqk3y5XryavrsFqr9YgF9xu34fJw1Y
	q3yUtayxXFWUZacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
	yCJUUUUU=



On 2024/2/22 下午5:34, WANG Xuerui wrote:
> On 2/17/24 11:15, maobibo wrote:
>> On 2024/2/15 下午6:25, WANG Xuerui wrote:
>>> On 2/15/24 18:11, WANG Xuerui wrote:
>>>> Sorry for the late reply (and Happy Chinese New Year), and thanks 
>>>> for providing microbenchmark numbers! But it seems the more 
>>>> comprehensive CoreMark results were omitted (that's also absent in 
>>>> v3)? While the 
>>>
>>> Of course the benchmark suite should be UnixBench instead of 
>>> CoreMark. Lesson: don't multi-task code reviews, especially not after 
>>> consuming beer -- a cup of coffee won't fully cancel the influence. ;-)
>>>
>> Where is rule about benchmark choices like UnixBench/Coremark for ipi 
>> improvement?
> 
> Sorry for the late reply. The rules are mostly unwritten, but in general 
> you can think of the preference of benchmark suites as a matter of 
> "effectiveness" -- the closer it's to some real workload in the wild, 
> the better. Micro-benchmarks is okay for illustrating the points, but 
> without demonstrating the impact on realistic workloads, a change could 
> be "useless" in practice or even decrease various performance metrics 
> (be that throughput or latency or anything that matters in the certain 
> case), but get accepted without notice.
yes, micro-benchmark cannot represent the real world, however it does 
not mean that UnixBench/Coremark should be run. You need to point out 
what is the negative effective from code, or what is the possible real 
scenario which may benefit. And points out the reasonable benchmark 
sensitive for IPIs rather than blindly saying UnixBench/Coremark.

Regards
Bibo Mao

> 

