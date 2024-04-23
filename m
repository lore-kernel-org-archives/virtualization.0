Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4815E89
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843400; cv=none; b=Kvr8epX6w7n5R3E7eLTzhDoMKNdeCgqRHL6Nj/JhOOf/CHRjytPNllbxwNv2g8GSqMizED1tJaqQ1a6F8SWLvqtfK8GYiRRF5oZ5LVciVAXpOtt4LLys1+DlessADuyT8vbOfXPuc+OdWlAHCzMyDLt5WdMttUXlygp5Iyb8Cv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843400; c=relaxed/simple;
	bh=5vWsoypMS8KW9AyNG2fX2xop6xfTDebSOf8rMvu+fP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAZIz6YCHCpggbITiZ/FLDvVETGYDYiMQShka38FMT9GjAMj9d/tXfYwdTiushE+9s+Jr2kqIaFFIHZSHNN6FUq6esf6EhBfNu92Ty1UJA8A2wAIhCSCoW9EmIUYUQm/c5mgcu/5eDDND5oFi39NsPPbI66Udgnluvvj8qLoISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBVqJB88; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBVqJB88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713843398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AgcL8WISfu/qXNDjCu04c4243W33DII37P9yj0gbDx8=;
	b=aBVqJB88wTqrzlhJgYwE+XXgJw4wQ0wDUvXWa+97KkCkJMcrHugC9YcfupsFEt8BtYn0wB
	J78Pwzv5lQRkVO/wn86OD7zRCsuyZtsBDpmMsmZtrHo0GcuHCj9N+JDRPsUvelreEW2cqH
	KF98fjy4t2htsT6G+BJimDbTyoJeruQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-5IQEtqzQMN2F6PL64hVXbQ-1; Mon, 22 Apr 2024 23:36:36 -0400
X-MC-Unique: 5IQEtqzQMN2F6PL64hVXbQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e8fc91661fso33590965ad.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843395; x=1714448195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgcL8WISfu/qXNDjCu04c4243W33DII37P9yj0gbDx8=;
        b=f+01nyoREQE3vw2ctW2YkJ1wjzKIMgcNfkMm9frPLRRAsBiTPNSCd7rjsZHToSwXMk
         aQ7ToTl8KCLFMvaSpGrwfF7s0lYRYRcDXQNZjoKoj/2G+/mTInv4xYyuGeNCLpBR+BF4
         32CILUqj6GfB5spOqEZBPVXzLW1e7K0eEEWtWrpuvFOxbp0XfK/9M2ZT/scMvUkdf50T
         Q5lXFd/lz/cehDOaQID4LNFGVv0382uN6hUWNs4SdgJ+uBOm9mIhMmop8IA9cq4Bqvr0
         D4b6Mq83cGnMIyoRKIVKCQcLKLR2eCL7gVrXnrBFCYN0UOjRvT9mw8Xxv/tyFYuH7TRY
         D4xA==
X-Gm-Message-State: AOJu0Yy8HzPnlXYoJfV0CUnVpOebcLqnZ5X5iOkB3VEkTlxLV03x2OBf
	OqZoXnhxg8Wf0E+Dfn0hXUstjx44bomQRjVB2OMnJOR7sz1MEzgCRYe73EUNHZjkuQ73qTvCeeP
	+QmaOypwRC9POgMn3KXytckSkywP9e/VLgZY8/67v9qBSH6Km1Dm0ths0GRpzOhIU
X-Received: by 2002:a17:903:11ce:b0:1e5:8175:4968 with SMTP id q14-20020a17090311ce00b001e581754968mr13010972plh.9.1713843395476;
        Mon, 22 Apr 2024 20:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmA/UxuttY5yGQe1dI0Jcby9qAk2r05g3/+ydlbjNUppckMjkp348qHRTTrErFgimcynXhrA==
X-Received: by 2002:a17:903:11ce:b0:1e5:8175:4968 with SMTP id q14-20020a17090311ce00b001e581754968mr13010950plh.9.1713843395116;
        Mon, 22 Apr 2024 20:36:35 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b001e3e0aa9776sm8877634plh.27.2024.04.22.20.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 20:36:34 -0700 (PDT)
Message-ID: <d5ced670-832a-48b0-8d87-c34273323ccb@redhat.com>
Date: Tue, 23 Apr 2024 13:36:28 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
 stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
 yihyu@redhat.com, shan.gavin@gmail.com
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-4-gshan@redhat.com>
 <20240328052814-mutt-send-email-mst@kernel.org>
 <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
 <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>
 <20240422164613-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240422164613-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 06:46, Michael S. Tsirkin wrote:
> On Mon, Apr 08, 2024 at 02:15:24PM +1000, Gavin Shan wrote:
>> On 3/30/24 19:02, Gavin Shan wrote:
>>> On 3/28/24 19:31, Michael S. Tsirkin wrote:
>>>> On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
>>>>> All the callers of vhost_get_avail_idx() are concerned to the memory
>>>>> barrier, imposed by smp_rmb() to ensure the order of the available
>>>>> ring entry read and avail_idx read.
>>>>>
>>>>> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
>>>>> the avail_idx is advanced. With it, the callers needn't to worry
>>>>> about the memory barrier.
>>>>>
>>>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>
>>>> Previous patches are ok. This one I feel needs more work -
>>>> first more code such as sanity checking should go into
>>>> this function, second there's actually a difference
>>>> between comparing to last_avail_idx and just comparing
>>>> to the previous value of avail_idx.
>>>> I will pick patches 1-2 and post a cleanup on top so you can
>>>> take a look, ok?
>>>>
>>>
>>> Thanks, Michael. It's fine to me.
>>>
>>
>> A kindly ping.
>>
>> If it's ok to you, could you please merge PATCH[1-2]? Our downstream
>> 9.4 need the fixes, especially for NVidia's grace-hopper and grace-grace
>> platforms.
>>
>> For PATCH[3], I also can help with the improvement if you don't have time
>> for it. Please let me know.
>>
> 
> 1-2 are upstream go ahead and post the cleanup.
> 

Michael, a cleanup series has been sent for review.

https://lore.kernel.org/virtualization/20240423032407.262329-1-gshan@redhat.com/T/#t

Thanks,
Gavin

