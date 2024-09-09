Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B05189F5F
	for <virtualization@lists.linux.dev>; Mon,  9 Sep 2024 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910704; cv=none; b=YTrg9P2cC1L42juwzhd9owPvWf6NgXhXhB3C3ZM7NLNjwL4WZy0XpH0wKwqEuYUH8zJxTiaX71uyWET4rJB9A4NRoaOHzKD1sn3yTefe/UUm8rMHKvJcDy1td096BFK55vZdmrR8jUVIZQqQ96cSjVS5iIN7iSclqeN6oaV5ftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910704; c=relaxed/simple;
	bh=oqpwAjUwZudqDFsnJpCB62K4YG/tVUObT5DJQf3YbLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjZCEx34bNKUNCYjp3ZoxcSYXwqWbD5dkuMi9eJP0aq+Qkd4j1aZGl7b5RHL6q6z+WveLt2qQHZ5TLLJ1hHxEeNJDTJuJk+wXvmjiEecwWHYF/eUHaNxjSNPLOGuD/W4UbEXiKBUrUGO2zDD3/8EpggpeTG10ehT8dZ5nskc2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Dqla8ih3; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Dqla8ih3"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nkDBsbmZ2Z40ankDCslDGW; Mon, 09 Sep 2024 21:38:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725910696;
	bh=snDT6fdR+dce492GpmRveGiYtkuWD7UIg+y2AlQOpAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Dqla8ih3/L24wSd7ICP3kDatH5nTEj2ogStOh8eh0T7uk2iMy2slKKnVw2lCJx604
	 daDWqLj8vwFGtT6wpOco7oU6GoPBr6ZDXrvEdSC/L+sk3Uuk0xIYuUpXX+Cm4bHOnf
	 PfGX3R0dRNT5K73ZAEUH+Qvb0dzmB3gL+C6m7atzAdAzLQc8IKiF1IQAQxTEr0sl9z
	 4izwMzKGvqOeyuGsAFLvuv7jZLHU90Cazr/Bt6NKXM0t3sxbfisjz5dUD/2oXi8tKB
	 kTO/gKf9ZrKk+3W+eYSXp11/85rpkQVPsC2eCBlke37IGam+ho7S36p6OqqUaqz3Xn
	 p+pstblWaN2+w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 09 Sep 2024 21:38:16 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c83a517b-2a48-4bbb-9946-e267238bd234@wanadoo.fr>
Date: Mon, 9 Sep 2024 21:38:09 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: virtio: Constify struct i2c_algorithm and struct
 virtio_device_id
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 "Chen, Jian Jun" <jian.jun.chen@intel.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org,
 virtualization@lists.linux.dev
References: <b98c3fa7072bf519ce8a9bc771e9d18c091b3509.1725778305.git.christophe.jaillet@wanadoo.fr>
 <cnetcfge6r7votsarnvk3dlqec4ufz3uyfkkf4wuhkxhlhw5wu@ckkns42r5psi>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <cnetcfge6r7votsarnvk3dlqec4ufz3uyfkkf4wuhkxhlhw5wu@ckkns42r5psi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/09/2024 à 20:54, Andi Shyti a écrit :
> Hi Christophe,
> 
> On Sun, Sep 08, 2024 at 08:52:07AM GMT, Christophe JAILLET wrote:
>> 'struct i2c_algorithm' and 'struct virtio_device_id' are not modified in
>> this driver.
>>
>> Constifying this structure moves some data to a read-only section, so
>> increase overall security, especially when the structure holds some
>> function pointers, which is the case for struct i2c_algorithm.
>>
>> On a x86_64, with allmodconfig:
>> Before:
>> ======
>>     text	   data	    bss	    dec	    hex	filename
>>     6663	    568	     16	   7247	   1c4f	drivers/i2c/busses/i2c-virtio.o
>>
>> After:
>> =====
>>     text	   data	    bss	    dec	    hex	filename
>>     6735	    472	     16	   7223	   1c37	drivers/i2c/busses/i2c-virtio.o
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> --
>> Compile tested only
> 
> Makes sense to me... if this works, you could pioneer a sequence
> of simiar changes :-)

Hi,

I already did some other ones [1]. A few more still need to be checked.

I'll finish it after ending struct regulator_desc that I'm currently 
looking at. [2]


[1]: https://lore.kernel.org/all/?q=%22Constify+struct+i2c_algorithm%22
[2]: https://lore.kernel.org/all/?q=%22Constify+struct+regulator_desc%22

> 
> Merged to i2c/i2c-host.

Thanks.
CJ

> 
> Thanks,
> Andi
> 
> 

