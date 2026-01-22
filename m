Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD64D35029D
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053402; cv=none; b=F1WnYT8/qqqy3wwjohaG1dBg49AVbuOq+sEhh7+omzcc5ebNCZQX4OK2Yx20dFYykghKt53v8YdzsZa/PUD041BKkuvH7KfMMyU9l3gu8jnfOb8sCZCqyYXg6PXUAXpojec5YNg1YDDDqdE+vJfYQZ0qScaC8cd+RUZIh4hoqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053402; c=relaxed/simple;
	bh=vmSlIxhLonT129nAIEJ07kIPjUtYbMA3s2ccdXE+GBw=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=u3AfAprc2QM8G/wE5/Eo1VloGYnU6AbetDevj/8BdpS3cILBH8qlVm3dL98eYmf1HnjIr/MCc+tcl27hblNxOlrq/pvPwlso/eAlhsMZzz734o7ViqCeca6UqiWtomjh5mrWXRIzN86ZxJfUpksZq/qu7w2Vw+Jo6okFhQPlNdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxMvHSnHFpGGgLAA--.37473S3;
	Thu, 22 Jan 2026 11:43:14 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxPMLPnHFpWpkqAA--.18178S3;
	Thu, 22 Jan 2026 11:43:13 +0800 (CST)
Subject: Re: [PATCH v5 0/3] crypto: virtio: Some bugfix and enhancement
From: Bibo Mao <maobibo@loongson.cn>
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, wangyangxin
 <wangyangxin1@huawei.com>, virtualization@lists.linux.dev,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260113030556.3522533-1-maobibo@loongson.cn>
Message-ID: <40a4eddf-6e5f-7853-1afa-dbdca1418890@loongson.cn>
Date: Thu, 22 Jan 2026 11:40:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260113030556.3522533-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPMLPnHFpWpkqAA--.18178S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AryrXrWDXr45Jw15ZrWxXwc_yoW8CrykpF
	Z8tFZYy3y8Gr1Ika4xJa48KryxCa9xGry3Kr4xW348Crn0vF97XrW2ka1UuFW7JFn5Gasr
	JFWkXr10qF1DuagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU

ping ...

On 2026/1/13 上午11:05, Bibo Mao wrote:
> There is problem when multiple processes add encrypt/decrypt requests
> with virtio crypto device and spinlock is missing with command response
> handling. Also there is duplicated virtqueue_kick() without lock hold.
> 
> Here these two issues are fixed, also there is code cleanup, such as use
> logical numa id rather than physical package id when checking matched
> virtio device with current CPU.
> 
> ---
> v4 ... v5:
>    1. Only add bugfix patches and remove code cleanup patches.
> 
> v3 ... v4:
>    1. Remove patch 10 which adds ECB AES algo, since application and qemu
>       backend emulation is not ready for ECB AES algo.
>    2. Add Cc stable tag with patch 2 which removes duplicated
>       virtqueue_kick() without lock hold.
> 
> v2 ... v3:
>    1. Remove NULL checking with req_data where kfree() is called, since
>       NULL pointer is workable with kfree() API.
>    2. In patch 7 and patch 8, req_data and IV buffer which are preallocated
>       are sensitive data, memzero_explicit() is used even on error path
>       handling.
>    3. Remove duplicated virtqueue_kick() in new patch 2, since it is
>       already called in previous __virtio_crypto_skcipher_do_req().
> 
> v1 ... v2:
>    1. Add Fixes tag with patch 1.
>    2. Add new patch 2 - patch 9 to add ecb aes algo support.
> ---
> Bibo Mao (3):
>    crypto: virtio: Add spinlock protection with virtqueue notification
>    crypto: virtio: Remove duplicated virtqueue_kick in
>      virtio_crypto_skcipher_crypt_req
>    crypto: virtio: Replace package id with numa node id
> 
>   drivers/crypto/virtio/virtio_crypto_common.h        | 2 +-
>   drivers/crypto/virtio/virtio_crypto_core.c          | 5 +++++
>   drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 2 --
>   3 files changed, 6 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 9c7ef209cd0f7c1a92ed61eed3e835d6e4abc66c
> 

