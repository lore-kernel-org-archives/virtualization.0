Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425DE81ACB
	for <virtualization@lists.linux.dev>; Wed, 22 May 2024 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373498; cv=none; b=Dg5rbEsMpa+dMTbLY/lMmaWH3x7Gnhxfkm64t2qisJEfCAhjdVXjDek/5kepWrIrCQA3hf5fLUyfeYNZhTFdZJWpoE+XC1Cb0IRfWu47AslyidirFrlkucszn3KSMYN9XfeP8HCm14yOqLVoFB2l5DWqdDt2Nxrk32QjFuczFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373498; c=relaxed/simple;
	bh=Bks/nVQag4vSaeZ7JLFuJARZ9/BK3eKI+r4Sivp5lzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YB+FpCEsNX09Ks0TU3vCrS/yuzm6d+AQOyk++JaZSwIyKCfd8cQ31ujkk8wauLUkAh5reMwpGY3i22KoULkWXt9ni1MnOnJ9kl+Y7PWYxeji3X/aul8fQDh1H9UpZDWOHn+4x73UHI07lytxdTQOnT9mmyUROwlMt2NDARY1z00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAB7C2BD11;
	Wed, 22 May 2024 10:24:56 +0000 (UTC)
Message-ID: <d3869be3-44f0-47cb-9a0f-6d9d404b458a@gmail.com>
Date: Wed, 22 May 2024 18:24:54 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] MAINTAINERS: Change lingshan's email to kernel.org
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, jasowang@redhat.com,
 mst@redhat.com
Cc: lingshan.zhu@kernel.org, virtualization@lists.linux.dev
References: <20240514165125.74802-1-lingshan.zhu@intel.com>
 <9542fe5a-893f-4e93-91fb-6e2007c50d7b@intel.com>
Content-Language: en-US
From: Zhu Lingshan <lszhu.dev@gmail.com>
In-Reply-To: <9542fe5a-893f-4e93-91fb-6e2007c50d7b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael,

Gentle ping as new merge window coming.

Thanks
Zhu Lingshan

On 2024/5/17 12:22, Zhu, Lingshan wrote:
> Hi Michael,
>
> My transition period ends today, before I get a new email account,
> I will use this lingshan.zhu@kernel.org email address(cc-ed) for patch 
> works and communication,
> this email address represents me.
>
> Thanks
> Zhu Lingshan
>
> On 5/15/2024 12:51 AM, Zhu Lingshan wrote:
>> This commit changes lingshan's email from intel.com
>> to kernel.org.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d75527f7bb0d..501b81b61b6d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10466,7 +10466,7 @@ F:    net/ieee802154/
>>   F:    net/mac802154/
>>     Intel VIRTIO DATA PATH ACCELERATOR
>> -M:    Zhu Lingshan <lingshan.zhu@intel.com>
>> +M:    Zhu Lingshan <lingshan.zhu@kernel.org>
>>   L:    virtualization@lists.linux.dev
>>   S:    Supported
>>   F:    drivers/vdpa/ifcvf/
>

