Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BC856466;
	Tue, 27 Feb 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027535; cv=none; b=b+D9Rh6yVoMuweKenvFuULByrZ5mjhsB1qUWq91lGjSp0evC91vlMTtOUJMXiny++6syQqeVb3B+b3fJV8MdkzDEBHxpaNdYMct7FJizumEfK9J0Gm8VD10wKZLSJ5TtDRS+/sQ73q96KMKVHEVSbW9LfP6B1yVr/oNwDv00y1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027535; c=relaxed/simple;
	bh=Cqn5IP45YhhILCijJAtbO8jWBeRWihbMdcIirdKca3Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mq0bKWtEGutt3mxh566diGaVL9hq0f85KMVNTImoJJ9uaAG5+urcHTBrYdsX0WA8a+Ho2BSmHN+xje6gm2KnbvZIw0yIvik1GuQoF7VfCao7ACjbBMSQ8Y2VIsHCqYmpXmtbvB8qITLsKBl+23qJs5z8XrB0WL7SixyPZkaz3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8AxqvDKsN1lfeYRAA--.45777S3;
	Tue, 27 Feb 2024 17:52:10 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfRPJsN1l2LZHAA--.26685S3;
	Tue, 27 Feb 2024 17:52:10 +0800 (CST)
Subject: Re: [PATCH v5 3/6] LoongArch: KVM: Add cpucfg area for kvm hypervisor
To: Xi Ruoyao <xry111@xry111.site>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
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
 <09c5af9b-cc79-4cf2-84f7-276bb188754a@app.fastmail.com>
 <fc05cf09-bf53-158a-3cc9-eff6f06a220a@loongson.cn>
 <f1ba53fd2a99949187ca392c6d4488d3d5aeaf88.camel@xry111.site>
From: maobibo <maobibo@loongson.cn>
Message-ID: <e04a527b-2d9d-cfcd-e6ed-e8bd390649dd@loongson.cn>
Date: Tue, 27 Feb 2024 17:52:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f1ba53fd2a99949187ca392c6d4488d3d5aeaf88.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxfRPJsN1l2LZHAA--.26685S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XrW7tryxtw4kAF48uF4kGrX_yoWfAwbE9r
	47tr9xAw1qyr4xG3y2y3y7CFW3Ga1DCFyqv3yxGas3W345JFyUWF1xuF1fA3WIqa4UZrn3
	CF1qq3yaqa4avosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbaAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
	14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU82-e7UUUUU==



On 2024/2/27 下午5:05, Xi Ruoyao wrote:
> On Tue, 2024-02-27 at 15:09 +0800, maobibo wrote:
> 
>> It is difficult to find an area unused by HW for CSR method since the
>> small CSR ID range.
> 
> We may use IOCSR instead.  In kernel/cpu-probe.c there are already some
> IOCSR reads.

yes, IOCSR can be used and one IOCSR area will be reserved for software. 
In general CSR/CPUCFG is to describe CPU features and IOCSR is to 
describe board/device features.

CSR area is limited to 16K, it is difficult for HW guys to reserve 
special area for software usage. IOCSR/CPUCFG is possible however.

Regards
Bibo Mao
> 
>> It is difficult to find an area unused by HW for CSR method since the
>> small CSR ID range. However it is easy for cpucfg. Here I doubt whether
>> you really know about LoongArch LVZ.
> 
> It's unfair to accuse the others for not knowing about LVZ considering
> the lack of public documentation.
> 

