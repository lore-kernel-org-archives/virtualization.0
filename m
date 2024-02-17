Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885A65381;
	Sat, 17 Feb 2024 03:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708139708; cv=none; b=Fh1Z9kqFb2DyZnWPyp8uGvkSuFWsAzUtVjF0IKy5wDaimB0l2g1m0T8Fm5OHsQKJqyFHBMmi8T/z8fHhfFf4gwXf9EtVdZX4YM+lBSZXjl0QRGe45wudGoBZDoUleL0PQK7vAr6TS9LFWHEtNXvB3o00ph++XpZ+xQMbBZw0KyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708139708; c=relaxed/simple;
	bh=B4/7/MrEpWq6X2d3hcZTW3hwhCv2dGfQTMCg58XpiZs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mhQ/c7zLJbAhqu+1yxQT9WNH7TEGekWXdrfrADXckhKCHRkwu53HRznxxYvEUuZB06Qgi+TJhxRaGycbSt5C/aidvsrlIEmvBjweCQCUo5wfmN2t2CdpSSCIYdPV9JO6ILhmAHXcOU/w/lFmXobFxIlWUE91m+GjgS6vAbuGr6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8DxmfC3JNBlaPENAA--.37911S3;
	Sat, 17 Feb 2024 11:15:04 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrhO1JNBlxt04AA--.23729S3;
	Sat, 17 Feb 2024 11:15:03 +0800 (CST)
Subject: Re: [PATCH v4 0/6] LoongArch: Add pv ipi support on LoongArch VM
To: WANG Xuerui <kernel@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org
References: <20240201031950.3225626-1-maobibo@loongson.cn>
 <0f4d83e2-bff9-49d9-8066-9f194ce96306@xen0n.name>
 <447f4279-aea9-4f35-b87e-a3fc8c6c20ac@xen0n.name>
From: maobibo <maobibo@loongson.cn>
Message-ID: <4a6e25ec-cdb6-887a-2c64-3df12d30c89a@loongson.cn>
Date: Sat, 17 Feb 2024 11:15:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <447f4279-aea9-4f35-b87e-a3fc8c6c20ac@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxrhO1JNBlxt04AA--.23729S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrXw4kKw4fKryUKF4kGryxCrX_yoWxXrg_WF
	y0qr4DAwsrJrsrKw4fKrsYq3srGFWUtr90q3Z7Xw4FgryUXFZ8Ja4DJ393ZanIqF4xtF98
	Kw1kCay5uF1ayosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5BMNUUUUU=



On 2024/2/15 下午6:25, WANG Xuerui wrote:
> On 2/15/24 18:11, WANG Xuerui wrote:
>> Sorry for the late reply (and Happy Chinese New Year), and thanks for 
>> providing microbenchmark numbers! But it seems the more comprehensive 
>> CoreMark results were omitted (that's also absent in v3)? While the 
> 
> Of course the benchmark suite should be UnixBench instead of CoreMark. 
> Lesson: don't multi-task code reviews, especially not after consuming 
> beer -- a cup of coffee won't fully cancel the influence. ;-)
> 
Where is rule about benchmark choices like UnixBench/Coremark for ipi 
improvement?

Regards
Bibo Mao

