Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E97D1B395F
	for <virtualization@lists.linux.dev>; Wed, 29 Jan 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151325; cv=none; b=ZTbDkZ47l5JkH/2gCDntvOCrvpF0I9+29dWgvspIA4xxcepCnm5UkDqgjQs4lfnCG82oJnkyv9eKCXvCgZxshAVI1qTvzGdl4OXey49TsFE4bh2cLqDAdhECA2abOuOzkip9Ypt6b2J7LA+KpZ6CKLEiJMUcDCOQycavjrz8xbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151325; c=relaxed/simple;
	bh=EgGu8yvZZu0tDb3duQIbPOHmQVucGRG9fGhnuUYk2h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO/H8ghcq3qLPp/Wv+/j0i57d89C6dWnH4K9LuogldDI0lvCRSUWOzznAIWt4CcwkuFNMH1LctibV3asWFPDKBGVu7HhPp0F0XN1g3vCGir++oJXwB35RjjC1FKiFftwKCebK3w4kGwXS/wROjDKx4onnYxxq6jNvgSc9cKGK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UvQGfUzQ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UvQGfUzQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=phhC6/CvuzsKujA1F3v2tZhD6uytqeJyjFFUGwSgc0s=;
	b=UvQGfUzQjyDfmjd/e1Xwna8tuXtfoyp4v9zNOl/Ebz7mgYHnEGg/0HUU1Qx61m
	za/sN5MTzRgyHBOeFP3TU7UXg4/1puVjAx1J3KFb3bEHd2S46kr5uGrjPglo2TaG
	vfFSdwhIw3AevmyCSIqN3Sa5mLHfJCLecgqFfXYn9oO3U=
Received: from [192.168.0.102] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3dxB6FZpno6HKJA--.24380S2;
	Wed, 29 Jan 2025 19:48:11 +0800 (CST)
Message-ID: <0e5fcde2-140a-4896-8880-5f90f2a134c4@163.com>
Date: Wed, 29 Jan 2025 19:48:10 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_console: Convert to use devm funcs
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
References: <20250128055241.30760-1-oushixiong1025@163.com>
 <9a10b435045556f5625afe83bd41bc4d4f9be80b.camel@kernel.org>
From: oushixiong <oushixiong1025@163.com>
In-Reply-To: <9a10b435045556f5625afe83bd41bc4d4f9be80b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3dxB6FZpno6HKJA--.24380S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKr1kAFyfXFWUtw1fAw1UWrg_yoW8JF48pF
	Z3WasxCr4Dtrs3Kr9Iv3yfZa1rZ3ykJr18WF1agw4SvrW5Ar9Fqr1vyr4rCayav3yxCa10
	vF18ta43W3WUXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4SoAUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXBzjD2eaBHV9CwAAsW


在 2025/1/28 17:39, Amit Shah 写道:
> On Tue, 2025-01-28 at 13:52 +0800, oushixiong1025@163.com wrote:
>> From: Shixiong Ou <oushixiong@kylinos.cn>
>>
>> Convert to devm_* funcs so that no need to manual free in error path.
>>
>> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
>> ---
>>   drivers/char/virtio_console.c | 43 ++++++++++++++-------------------
>> --
>>   1 file changed, 17 insertions(+), 26 deletions(-)
> [...]
>
>> -		goto free;
>> +		return err;
> [...]
>
>> -
>> -free:
>> -	kfree(portdev->out_vqs);
>> -	kfree(portdev->in_vqs);
>> -	kfree(vqs_info);
>> -	kfree(vqs);
>> -
>> -	return err;
>>   }
> Hm, I'm not entirely sure about this - the devm_ interface is better,
> but to me that just says that it's an extra safety net that avoids
> memleaks when we forget to kfree, and not that we deliberately do not
> free and get lax about managing allocated memory.
>
> So I'd prefer a patch that keeps all current frees as they are, but
> with the added advantage of using the devm interfaces.
>
> 		Amit

Hi, I don't think driver need to  call kfree() by manual if driver use 
the devm_ interface

in the probe() phase. This can simplifies the code.

This is similar to the  commit  "55dd7378ba94 (fbdev: imxfb: Convert to 
devm_kmalloc_array())"

Thanks!

Shixiong Ou

