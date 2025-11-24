Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674CE23E358;
	Mon, 24 Nov 2025 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763968366; cv=none; b=N5VZY+U/WaqXG384oUIcVDWn1K5OXeRDtXbcF4zrXS0VaJhAEE99y7WW/J4dBDZ6iVdHwPUh1jqDQlFDFwIGkTTEs1kucGYM9Zkna2yLsvWozzhqcRQtszjp+oxAyuWFD4oYEALLgtCWozF4DmlGNtjA6ThEqaofqKdowoOyDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763968366; c=relaxed/simple;
	bh=juKN0XshDUgOwCgjd883BKYK8bpksKuyneFk+bQxMRk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X2KSNinJvKuPTvj0wveHERn6VmXSQweEdpFzgUupC/i3X9YbQ6HddEOzyOP/81j30z0buoYnszRQuzYjua/6imX3F5TN8bhPc55lggeTmXDFVRhwLrLQrm6NfByEczSbOF2hry9t4xlOs2N2TZL9PMD9EhdHebJU5qpB6GagJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bx2tFnBSRptWgnAA--.20139S3;
	Mon, 24 Nov 2025 15:12:39 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxVORkBSRpdHg9AQ--.43654S3;
	Mon, 24 Nov 2025 15:12:38 +0800 (CST)
Subject: Re: [PATCH v2 3/3] LoongArch: Add paravirt preempt print prompt
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, WANG Xuerui <kernel@xen0n.name>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
References: <20251124035402.3817179-1-maobibo@loongson.cn>
 <20251124035402.3817179-4-maobibo@loongson.cn>
 <CAAhV-H5xA_QcRXJsiW929pQ3zPw-5BqgbGW6K5Qy9sa3ofH+9g@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <fa25523c-4913-186b-caea-d7a46d52a71e@loongson.cn>
Date: Mon, 24 Nov 2025 15:10:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5xA_QcRXJsiW929pQ3zPw-5BqgbGW6K5Qy9sa3ofH+9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxVORkBSRpdHg9AQ--.43654S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrWxCr13tF1ftFWrGFWUKFX_yoW8CFW7p3
	yfAFZa9a1xGay8Ca9xtrs5Wrn8JrWkK3Z7uF9rWa45AasrZrn7Jr18CrWYvF1q9rWxWF10
	grn5Wrs09FsrG3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
	67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
	JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07jY38nUUUUU=



On 2025/11/24 下午2:33, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Mon, Nov 24, 2025 at 11:54 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Add paravirt preempt print prompt together with steal timer information,
>> so that it is easy to check whether paravirt preempt feature is enabled
>> or not.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/kernel/paravirt.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
>> index d4163679adc4..ffe1cf284c41 100644
>> --- a/arch/loongarch/kernel/paravirt.c
>> +++ b/arch/loongarch/kernel/paravirt.c
>> @@ -300,6 +300,7 @@ static struct notifier_block pv_reboot_nb = {
>>   int __init pv_time_init(void)
>>   {
>>          int r;
>> +       bool pv_preempted = false;
>>
>>          if (!kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
>>                  return 0;
>> @@ -322,8 +323,10 @@ int __init pv_time_init(void)
>>                  return r;
>>          }
>>
>> -       if (kvm_para_has_feature(KVM_FEATURE_PREEMPT))
>> +       if (kvm_para_has_feature(KVM_FEATURE_PREEMPT)) {
>>                  static_branch_enable(&virt_preempt_key);
>> +               pv_preempted = true;
>> +       }
>>   #endif
>>
>>          static_call_update(pv_steal_clock, paravt_steal_clock);
>> @@ -334,7 +337,10 @@ int __init pv_time_init(void)
>>                  static_key_slow_inc(&paravirt_steal_rq_enabled);
>>   #endif
>>
>> -       pr_info("Using paravirt steal-time\n");
>> +       if (pv_preempted)
> No pv_preempted needed, you can just use
> static_key_enabled(&virt_preempt_key) and merge this patch to Patch-2.
yes, good idea.
Will do in next version with these two points.

Regards
Bibo Mao
> 
> 
> Huacai
> 
>> +               pr_info("Using paravirt steal-time with preempt hint enabled\n");
>> +       else
>> +               pr_info("Using paravirt steal-time with preempt hint disabled\n");
>>
>>          return 0;
>>   }
>> --
>> 2.39.3
>>

