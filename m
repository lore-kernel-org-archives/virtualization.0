Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F49187558
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083376; cv=none; b=iQy9bVdKDSHrV8f49luqOv2vjsT2I4rmPVuhKftUdVLkZ7Zltq+L6sNAkRtFl9UkBZHfvU2l/fYiVgnfqisYy3EhSzD2Oi+u5g+n2zvntVD9i/aSoTeBwGh0ecvD0GeNucnc8BM0vUApT8HNLf44kHKYLgO0xtifoV4RZn04hUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083376; c=relaxed/simple;
	bh=KbLdL/seA21LV9zN+LpX02fN0fOL7QT1V1+L/wG42Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmHA1U0EC1uvVmjhu6NY9OTrjWRnpF1YA13INu7mvGP6RD+kpfTNtewI92CMJOJJxXQSEYx7By9pNlV5dhE8lomc6iyurCxbjmxUlU4nNeJQdi/JHzijJDOs5IDL2MC1vplCqxKtQpCfUAQXJfsXVBG3wX2WfsAIqjxERTCggIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UtBYzAAu; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UtBYzAAu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717083365; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w1t0izbHYuiodnmYQS/W/QtzQhF1IvrQmY/kNuEtIxk=;
	b=UtBYzAAuqsXfcabSxAKAbLcrM63f4WXNEKdoxx5O7HVdiNBZWgegXI98aKSJh4dafQLvC1/kw2b28rz112LQNQwrKMCLWWD6d0zwTnuGVQShGrxo9473D95INbwTZyafnUgnt+3denapL9BRrI3L23/FeD8mag81Eon4oRUbjLA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W7XEnis_1717083364;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7XEnis_1717083364)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 23:36:05 +0800
Message-ID: <2b97f4bd-818f-4d8b-b55e-8410c0fb2768@linux.alibaba.com>
Date: Thu, 30 May 2024 23:36:00 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 Peter-Jan Gootzen <pgootzen@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yoray Zack <yorayz@nvidia.com>,
 Vivek Goyal <vgoyal@redhat.com>, virtualization@lists.linux.dev
References: <20240529155210.2543295-1-mszeredi@redhat.com>
 <af09b5d3-940f-491d-97ba-bd3bf19b750a@linux.alibaba.com>
 <CAJfpeguV0dNiyR5jzQH7H4x0vOzFTcBgnnLDHBPU9fH23A0kng@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpeguV0dNiyR5jzQH7H4x0vOzFTcBgnnLDHBPU9fH23A0kng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 5:00 PM, Miklos Szeredi wrote:
> On Thu, 30 May 2024 at 05:20, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>>> +             if (test_bit(FR_FINISHED, &req->flags)) {
>>> +                     list_del_init(&req->intr_entry);
>>> +                     spin_unlock(&fiq->lock                  ^
>>                 missing "return" here?
> 
> Well spotted.  Thanks.
> 
>>> -             err = -ENODEV;
>>> -             spin_unlock(&fiq->lock);
>>> -             fuse_put_request(req);
>>> -     }
>>> +     fuse_send_one(fiq, req);
>>>
>>> -     return err;
>>> +     return 0;
>>>  }
>>
>> There's a minor changed behavior visible to users.  Prior to the patch,
>> the FUSE_NOTIFY_RETRIEVE will returns -ENODEV when the connection is
>> aborted, but now it returns 0.
>>
>> It seems only example/notify_store_retrieve.c has used
>> FUSE_NOTIFY_RETRIEVE in libfuse.  I'm not sure if this change really
>> matters.
> 
> It will return -ENOTCONN from  fuse_simple_notify_reply() ->
> fuse_get_req().  The -ENODEV would be a very short transient error
> during the abort, so it doesn't matter.

Okay, fair enough.  Feel free to add:

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


-- 
Thanks,
Jingbo
