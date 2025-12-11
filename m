Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3E723ABBF
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765417704; cv=none; b=PB/zgn6Dq6D8970EI9dwQZE3mJJtbXJJg2ou0NcJ9zGXrHT0LioBPytngEWo/vvvy3Ccn8I5MqUJ16swquCvhKdMFpmroJnxQvmHW5QetK8/IBwQVXf64ue3r/3h3qFRj2HcnWySUth/ZauoDjpck4cuvfXv5da1igWrI5VA8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765417704; c=relaxed/simple;
	bh=sF6INWHFzNkWbCQm2SGVm6yPsqJZqXCI3yusgM+2H4I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XIcS8KH7kZSocpSkGfPN2R5ryAnZS7XYfz0Bto3IMWuV9R1gmOO7BogLzrXZ1bPA9JM9teGN+ZfZ79ThUcJittJRuh7Z80aT+v8GiWwOI7goGOegmPZ0Kbxh6OCqM8pUR8SoBSixN9v148Afl5lLADBqbhnsDncKH0hs8XO3NRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Axjr_eIjppojQtAA--.29873S3;
	Thu, 11 Dec 2025 09:48:14 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxT+bXIjpp+QBIAQ--.54846S3;
	Thu, 11 Dec 2025 09:48:10 +0800 (CST)
Subject: Re: [PATCH v3 10/10] crypto: virtio: Add ecb aes algo support
To: Eric Biggers <ebiggers@kernel.org>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
 linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251209022258.4183415-1-maobibo@loongson.cn>
 <20251209022258.4183415-11-maobibo@loongson.cn>
 <20251209232524.GE54030@quark>
 <4ac7b5b9-d819-62b5-1425-0e0b07762120@loongson.cn>
 <20251210014524.GA4128@sol>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <bea9f1fe-f99e-b5c2-f69b-823e81adc28f@loongson.cn>
Date: Thu, 11 Dec 2025 09:45:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251210014524.GA4128@sol>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxT+bXIjpp+QBIAQ--.54846S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF15uFy8KF47KrWDGrW3Jwc_yoW8WF15pF
	WfC3WruFWDAry3K3saqwn2gF1Y93s7GrWUWwn8J34qy3Z8Xr12vw40vFWrCay7Zwn3AF47
	ta1jgFW29ayUCagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=



On 2025/12/10 上午9:45, Eric Biggers wrote:
> On Wed, Dec 10, 2025 at 09:36:06AM +0800, Bibo Mao wrote:
>>
>>
>> On 2025/12/10 上午7:25, Eric Biggers wrote:
>>> On Tue, Dec 09, 2025 at 10:22:58AM +0800, Bibo Mao wrote:
>>>> ECB AES also is added here, its ivsize is zero and name is different
>>>> compared with CBC AES algo.
>>>
>>> What is the use case for this feature?Currently qemu builtin backend and
>>> openssl afalg only support CBC AES,
>> it depends on modified qemu and openssl to test this.
>>
>> Maybe this patch adding ECB AES algo can be skipped now, it is just an
>> example, the final target is to add SM4 cipher.
> 
> There's no need to add useless features.  The title of your patchset is
> "crypto: virtio: Add ecb aes algo support".  So it sounds like the main
> point of your patchset is to add a useless feature?  If there are
> actually unrelated fixes you want, you should send those separately.
yes, will change title of cover letter and remove this patch in next time.
> 
> As for SM4 support (which mode?), if you really want that (you
> shouldn't), why not use the existing CPU accelerated implementation?
The hardware supports SM4 ECB/CBC/CTL three modes, it depends on the 
detail application scenery.

I just notice that openssl removes engines support in recent. The 
purpose of use HW accel is that it is faster and can save CPU resource.

However it actually brings some troubles with applications on different 
HW platforms, I think HW crypto accel can be used for kernel and some 
key user applications, it is not suitable for all general applications 
for the present.

Regards
Bibo Mao
> 
> - Eric
> 

