Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800E198A01;
	Tue, 22 Oct 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588655; cv=none; b=m7TrZZdfGOj8s111dLuGkSUoA/Qi12Cp579AMrAte7/jM5/iIqUusirkogpdBKJyZAstdcBFq3YjbVVfdvHSrfHLXoZVdW0uIuPhsmHT1V+fjdp0kDqt52Hg0iF6AvhPGqpqTeMQnJ2qYHLkVrbmU9/KI9/Xuk9YKWgDA1n8EsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588655; c=relaxed/simple;
	bh=I5x5SOgGenw7y3wO+bIhVmyuJ+cBlx09KBodnZdxbfA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kckC0lGuBpsS2xldtGh9BfXK4WuIznh/ng8T85Vovso8m4vDt5q17fhCAgfr/1B0GOY5ioihjh59LnaWR9+mpozIp6+7rKmAlH2IcgPLJajEX7Jzeytnbb/Sa/aFz1D7gf6ylxpXn8YLGbiZekFAqHu+g9iRJy60m3yi7LXIFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxeeCobRdn6sUEAA--.10875S3;
	Tue, 22 Oct 2024 17:17:28 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMBxveClbRdndjcHAA--.42581S3;
	Tue, 22 Oct 2024 17:17:28 +0800 (CST)
Subject: Re: [PATCH v8 3/3] irqchip/loongson-eiointc: Add extioi virt
 extension support
To: Thomas Gleixner <tglx@linutronix.de>, Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, WANG Xuerui <kernel@xen0n.name>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 x86@kernel.org, Song Gao <gaosong@loongson.cn>
References: <20240830093229.4088354-1-maobibo@loongson.cn>
 <20240830093229.4088354-4-maobibo@loongson.cn>
 <CAAhV-H4W4LwL3U2HT+-r+6nH5ZSBBbPYL2wdZJqQF7WNkhOgMw@mail.gmail.com>
 <878qv6y631.ffs@tglx>
From: maobibo <maobibo@loongson.cn>
Message-ID: <2fb27579-5a4d-8bcc-db08-8942960dc07e@loongson.cn>
Date: Tue, 22 Oct 2024 17:17:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <878qv6y631.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxveClbRdndjcHAA--.42581S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFy5ZrW5Jw47KFykGF4rJFc_yoWkJwcE9F
	Z7A34Uuw4UXry2ka12yrWakr9xGa4UC3Wvv3yUGr4Iqa43ZrZ8CF4Uur1xWay0qrW0gFn3
	JwsYvr1avw1ruosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU83U
	UUUUUUU==

Hi Huacai/Thomas,

Sorry for the ping message :(

Can this patch be applied int next RC version?

Regards
Bibo Mao

On 2024/10/2 下午9:42, Thomas Gleixner wrote:
> On Wed, Sep 11 2024 at 17:11, Huacai Chen wrote:
>> Hi, Thomas,
>>
>> On Fri, Aug 30, 2024 at 5:32 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>
>>> Interrupts can be routed to maximal four virtual CPUs with one HW
>>> EIOINTC interrupt controller model, since interrupt routing is encoded with
>>> CPU bitmap and EIOINTC node combined method. Here add the EIOINTC virt
>>> extension support so that interrupts can be routed to 256 vCPUs on
>>> hypervisor mode. CPU bitmap is replaced with normal encoding and EIOINTC
>>> node type is removed, so there are 8 bits for cpu selection, at most 256
>>> vCPUs are supported for interrupt routing.
>> This patch is OK for me now, but seems it depends on the first two,
>> and the first two will get upstream via loongarch-kvm tree. So is that
>> possible to also apply this one to loongarch-kvm with your Acked-by?
> 
> Go ahead.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 

