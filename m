Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808537490;
	Tue,  2 Apr 2024 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712020561; cv=none; b=GhblaXKWhzLeT5F4jceQ0T2K9xDLc3Ig5UMJC9rRr1N3EppVhUPwbQRFc6WhILB5xZ71z4AfvCq0+ogGVcD2IvWXw29AYmltRzuJV4dPrdEY4aHpUnRlS/JRaC+jNGG2mU2SegMYw9QaS8YkPcPqd4p/hXexP3mBSC7gaOAoJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712020561; c=relaxed/simple;
	bh=8xe9EHnD1Z7Ql0v2jfMirkIGsHMGEqtuaUuaCXmxea4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r3VF/Ky781p16lecqQSdwVAl0YBasq4Y06p5RuIdtk1Jd+0xFYjRThjUyYqMyRwLw7gAZAYZ9kEB8ooZDZndFZguijdKgNLkWnTdhqMU3Tpu7Y7KtJxxWiyQWRYCZjDylAOHIoKW8b92YIZOxG5H3clrGF/7C80BQ3koOGzIJC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8AxqvBLXAtmPSgiAA--.13202S3;
	Tue, 02 Apr 2024 09:15:55 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxxxFHXAtmbT5xAA--.12076S3;
	Tue, 02 Apr 2024 09:15:53 +0800 (CST)
Subject: Re: [PATCH v7 7/7] Documentation: KVM: Add hypercall for LoongArch
To: WANG Xuerui <kernel@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org
References: <20240315080710.2812974-1-maobibo@loongson.cn>
 <20240315081104.2813031-1-maobibo@loongson.cn>
 <68473508-dbf1-4875-a392-88ca09f7ea63@xen0n.name>
From: maobibo <maobibo@loongson.cn>
Message-ID: <0bdcaf41-c54d-9f39-0dd2-3b3d2a954649@loongson.cn>
Date: Tue, 2 Apr 2024 09:15:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <68473508-dbf1-4875-a392-88ca09f7ea63@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxxxFHXAtmbT5xAA--.12076S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtr4xCw17tFy7CF18Zr4fZwc_yoWDKFgEv3
	y0qF4UGws0gr4293W8Cr43XrW2vFWDGryIqw4qqasrZryftayDGFWDur93CF4xJFW3Jr1Y
	93Z0gw4S9wnruosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
	U



On 2024/3/24 上午2:40, WANG Xuerui wrote:
> On 3/15/24 16:11, Bibo Mao wrote:
>> [snip]
>> +KVM hypercall ABI
>> +=================
>> +
>> +Hypercall ABI on KVM is simple, only one scratch register a0 and at most
>> +five generic registers used as input parameter. FP register and 
>> vector register
>> +is not used for input register and should not be modified during 
>> hypercall.
>> +Hypercall function can be inlined since there is only one scratch 
>> register.
> 
> Maybe it's better to describe the list of preserved registers with an 
> expression such as "all non-GPR registers shall remain unmodified after 
> returning from the hypercall", to guard ourselves against future ISA 
> state additions.
Sorry, I do not understand. What is the meaning of "all non-GPR 
registers"?  Can you give an example?

Regards
Bibo Mao
> 
> But I still maintain that it's better to promise less here, and only 
> hint on the extensive preservation of context as an implementation 
> detail. It is for not losing our ability to save/restore less in the 
> future, should we decide to do so.
> 

