Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4DC1F12E0
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764207945; cv=none; b=fdrKFTkSyEb+JOk9hpl9M9kcJlKAqBk1LryRSET4Xgtc+ACgKWGOquFoEQ7+iMkHI5NUMoMrTrF4ylWkfPkAKTBUEPydO8tcfdQ5Mz2aIUxBKJkPKwKJp60+oMi/m7Yx51/qK9Tum2uw5L/+YP70ofxanoRuTzliuN3cvZVWaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764207945; c=relaxed/simple;
	bh=7zmgDxz3BNsU8+CzY8b8wvYlKheGihwr1LJC5MJWTNA=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=VQYfXWwULEIZwhnbCIOeDTMvgnJx+kqLe7mGeMBFBuzJKS6Iv5g9CHkyw+dRtQwOTIW/dkP/gDON5uu+CYXl5d9QBc/uSWBhW/Wy7q//C2b7KmdAoHjNzFakRMJWZj8GZ11R4iOe5B2K7ouhV6pPsbRLmFICCEipCvWIpFoARnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxbNJArSdp3JEoAA--.22228S3;
	Thu, 27 Nov 2025 09:45:37 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxVOQ9rSdpJo9AAQ--.50365S3;
	Thu, 27 Nov 2025 09:45:35 +0800 (CST)
To: arei.gonglei@huawei.com
Cc: linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel <linux-kernel@vger.kernel.org>,
 QEMU devel <qemu-devel@nongnu.org>
From: Bibo Mao <maobibo@loongson.cn>
Subject: virtio-crypto: Inquiry about virtio crypto
Message-ID: <d4258604-e678-f975-0733-71190cf4067d@loongson.cn>
Date: Thu, 27 Nov 2025 09:43:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJAxVOQ9rSdpJo9AAQ--.50365S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZUUUUU=

Hi gonglei,

    I am investigating how to use HW crypto accelerator in VM. It seems 
that virtio-crypto is one option, however only aes skcipher algo is 
supported and virtio-crypto device is not suggested by RHEL 10.
 
https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/configuring_and_managing_linux_virtual_machines/feature-support-and-limitations-in-rhel-10-virtualization

   I want to know what is the potential issued with virtio-crypto.

Regards
Bibo Mao

