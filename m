Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F118FC64
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332354; cv=none; b=WdIY2qJUck17gxiw+zelDRAQvmq3dqrkay/hQK7cHMAD2OfeJvBzo+cEOYiA0PDTqlTTBRAFLUm9KlKnrDR6clZ2xOMIrwKPu2b/3zrCeindPMf7uGGJ69FDtA94UXPzg4n2+eTX1klCskb+aKwkyYkTLmXBnR1VjlZqmAufeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332354; c=relaxed/simple;
	bh=ZpZUCOXm2bxyXLbnktr7N+JowT37ciaOdv8Y9vqxlZo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P7YvgV6MKT6/Z7nI7yquYrtKkegbbbiZNWRi4wvWpJ/rX6PVbw6FRMylCNWn4x6CEeUqc2r1Yp+E3QeLHxXBJDn/nfpZrwqJ2p6oFYxb0UYYjd8di9wJLtHCEGARTdcJhPQH1E0h4RJaQG8B/QRHIPLFt0IhWtsKx6p5Q++WBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxGuq+tKhml2IEAA--.15185S3;
	Tue, 30 Jul 2024 17:39:10 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMBxmcW7tKhmcVoGAA--.31521S3;
	Tue, 30 Jul 2024 17:39:09 +0800 (CST)
Subject: Re: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Nikolay Borisov <nik.borisov@suse.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
 <08d75c12-215e-3781-ed89-b1ed5c1e39c8@loongson.cn>
 <ZqiofczTqmn4bvhy@chenyu5-mobl2>
From: maobibo <maobibo@loongson.cn>
Message-ID: <76216f5d-ade4-bd5b-980e-d616e77370a5@loongson.cn>
Date: Tue, 30 Jul 2024 17:39:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZqiofczTqmn4bvhy@chenyu5-mobl2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxmcW7tKhmcVoGAA--.31521S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrWxur1UZrW3tFyrGFy8WFX_yoW8CrWkpF
	WUtana9Fs7Jr48Zw47AFWvkry8C397Gr1qqr1xWFy8A39xWr9xtryktr1Yv3W7tF97Zr92
	ya1FqrWDAayDZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDU
	UUU



On 2024/7/30 下午4:46, Chen Yu wrote:
> Hi Bibo,
> 
> On 2024-07-30 at 09:21:45 +0800, maobibo wrote:
>> Chenyu,
>>
>> Sorry to bother you, I am porting pv spinlock to LoongArch platform, I do
>> not know the history about function virt_spin_lock().
>>
>> When CONFIG_PARAVIRT_SPINLOCKS is enabled, there is pv_enabled() before
>> virt_spin_lock(), it seems that virt_spin_lock is never called in this
>> condition.
> 
> Right, if CONFIG_PARAVIRT_SPINLOCKS is enabled, virt_spin_lock() will not be
> checked at all and go directly to pv_queue lock section.
> 
>>          if (pv_enabled())
>>                  goto pv_queue;
>>
>>          if (virt_spin_lock(lock))
>>                  return;
>>
>> When CONFIG_PARAVIRT_SPINLOCKS is disabled, there is no pv qspinlock
>> compiled, so what is the usage about function virt_spin_lock()?
>> Is it to switch spinlock method from test-set spinlock to qspinlock?
>> why is there such requirement for spinlock switching method?
> 
> Firstly, according to the commit 2aa79af64263 ("locking/qspinlock: Revert
> to test-and-set on hypervisors"), virt_spin_lock() was originally introduced
> to avoid the over-preemption of native qspinlock(when paravirt-spinlock is
> disabled).
Chenyu,

Thanks for the information. It seems that test-and-set spinlock is 
suggested rather than qspinlock on VM when paravirt-spinlock is disabled.

Regards
Bibo Mao
> 
> Secondly, there is user requirement to use native qspinlock over test-set lock
> in the VM. For example, nopvspin parameter is parsed in xen_init_spinlocks().
> commit 9043442b43b1 ("locking/paravirt: Use new static key for controlling call
> of virt_spin_lock()") was introduced to adjust the key from user boot up commandline.
> so the key switches between test-set and the native qspinlock. I've Cced
> Juergen and Peter in case I misunderstood.
> 
> thanks,
> Chenyu
> 

