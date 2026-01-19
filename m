Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B938944A
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840249; cv=none; b=XMfce/B7DRVu092UWzCeB6sDVCIqdM84vjPRFseNsGrSnAPMlRTffL6o6uxfACRf4APQtmOl60224QrF49lZOxoMNhyTcJmYJkZ6d8l2gtV2UrXnsNEo0RCq3hN/4/aISfFHTRnt14Gvgcx2o8/9u/1TjvoKXjKnFZ9pAgF6+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840249; c=relaxed/simple;
	bh=74nuZh3CRHnlUvBAbWZ6tYHKEa5PfTvtDxqJmYiZgE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mx3xk8U6GgP88E0ZrQvHqnWCRkDWhPL6yVfNs/a5txWGaLPTTJnexCKpT/Wfav4iejizqTuSUq4Hxb4K7BMCjcOGMI5J/WJuleghfj0uCIpuav/C6IeOWwXZ5KqoQPRHPRFLhMjOTGZ4HaZKdhv/AahsyMgAxoIH7broMBgA4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj7t84WD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj7t84WD"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b87cc82fd85so220540666b.2
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 08:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840246; x=1769445046; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAx9ToKLl7t8y9PiSc/w47xhuek7x5/AEgqS5Sqqu4g=;
        b=Sj7t84WDmTIbJEkAwtrA+XjybVjUQW/Pc2tSZh4fqhPAxiNOvtceji6uguNWNT+pHG
         Jh8zaJW7BrZANqmLFS4bBnrbmbkkp+UZfGemr3qf9pX8gy2PP1opt0vLE+suUJS7s8Ak
         azERN++7bpww4XCNtxBXQ7CkxjOCQGZx/44DEtOs4HbNGkt4gX2p1/K3+bYfUt7Y9B+d
         42e1Aqz+e8AMNIbe1TKWGIj9pO09lKPaIObNP1TmzD5W6SJgP3kDiTXrmbf8wpHoIdop
         bEHyrdh+Hg5HwhkmobLy/JOi7tvSc44Xx3gVr/mzSGDpzvLDJMztmmc6sAQHS1dML+wm
         CpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840246; x=1769445046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAx9ToKLl7t8y9PiSc/w47xhuek7x5/AEgqS5Sqqu4g=;
        b=MB/ejXtd9vuhgoYmm9dZRPJMBD7pHVxu8mCeQHw4ojkO9H6rDTYHBw1h4B2PYtqnM7
         5p0GouBIUsSW0zGZ+UEJojmIp/1qdPb99OOvlxGaVwvb5ugMUYQkjSMyXL+HjSq1drs7
         kPz+T05UJP8o0S8BMtSbbnywFycIUM6rpzox/W2aUnjCBAcSNS0V0jMJN/6PJeaUBrC6
         bOR1g247aZc0QbKbpz4jSGWL6VfwBp5LQS5Ylz78rS91G3BntSsaRBQ+7GuudRSfqd7U
         eX/rSV5Fr/o5+bfhoBwc4VR6tawcUNmAaPVUCZ2UP+Wod+roCuYcZN7Yffmy8b4CTLdu
         A19A==
X-Forwarded-Encrypted: i=1; AJvYcCVkFiKLAobToUTEdAwtP7F4oXn/alXPBC0ST9VowmCoUWfA+vPp6Kry7jCK5MCOFsfwb7tPCTPXEaJkRW9SUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2GOokM9Pd/1qUPbOZqiHsFfxyrxOhWb6iaBku3NdrUjM3r/bj
	FSwjHs7jd2ZGzbrWalccZlmA7ERShF6Wv9N9tiDygvy4Oa8UG6edjGllCxww2Q==
X-Gm-Gg: AY/fxX6DAF0ZZ8qvyiGqBdFjuuU73eu3SkJkm2Sokm/WPULVuQtBciwPyPadqF3eY1h
	CiSj61CciVhIxO5sz6CqLgDsJQoT8Jfie+U0RzeE3IZhPPQMF7/MaUL5FFzRmoATtXT3XIMGRKt
	ULm0WwUTyg5I+GS+d8vuyPC2Di1bgPbZjWoTrNwSX839mHD4NN+Z+7c4eGGU5G9G9V/PH8N4s60
	KdWIVuNn8Kf6heeUhgsttCj34UqUltux2/lwODO8q6UwwewxDuAE3pu/PyZxssuNUh3ror/mZZl
	h6nu8kWWoSyTdkeprby4E8+MllIXeugv1PBHdL0zucOgVVZ4ttdTLkdmnNEI6W1WtDb7jNrSBCc
	BUY788OqPWndGq2Ob5gnZOFvgJ9ucrwyOOF721Mi6ePrPN7dUbUpVw2iPNwgG6RJFTQ6OBlDk+Z
	a6rycEMzYHYkfejuT/0BkGfQuC4zJrF55zy+epwO5icA==
X-Received: by 2002:a17:906:4fd0:b0:b7c:e320:5250 with SMTP id a640c23a62f3a-b87968d1745mr879203466b.7.1768840245683;
        Mon, 19 Jan 2026 08:30:45 -0800 (PST)
Received: from [10.24.66.11] ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795169d30sm1167827566b.25.2026.01.19.08.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 08:30:45 -0800 (PST)
Message-ID: <dae84252-1d61-499b-8297-54ad41d9a518@gmail.com>
Date: Mon, 19 Jan 2026 16:30:44 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] virtio_balloon: Support wait on ACK for hinting
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, mst@redhat.com,
 jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kalyazin@amazon.co.uk, xmarcalx@amazon.co.uk, jackabt@amazon.com
References: <20260119154236.39412-1-jackabt.amazon@gmail.com>
 <6c3f8061-302e-40c1-829b-2f8555bee70c@kernel.org>
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <6c3f8061-302e-40c1-829b-2f8555bee70c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/01/2026 3:50 pm, David Hildenbrand (Red Hat) wrote:
> On 1/19/26 16:42, Jack Thomson wrote:
>> From: Jack Thomson <jackabt@amazon.com>
>>
>> This RFC patch adds a new virtio feature for the virtio-balloon driver
>> during free page hinting, which will wait on device ack before
>> committing the range to the free_page_list. The reason for the change is
>> it allows the device to modify this range without it being reclaimed
>> from the free_page_list before the ack is sent. As expected, testing
>> shows this adds overhead to the hinting run duration, increasing it by
>> ~30% with our Firecracker setup. Currently free page hinting is used
>> mainly for live migration, but this would open it up for a new use-case.
>>
>> We would like to leverage this with MADV_DONTNEED to reduce RSS of a
>> guest. We'd like to use hinting because of the flexibility of control it
>> brings compared to reporting, allowing memory to be reclaimed in
>> deterministic periods. 
> 
> Can you elaborate in more detail why you don't simply use reporting, 
> like QEMU?

Ideally we'd like to use hinting as the API allows us to control when
this reclamation takes place so as not to impact active VMs. For example
if we know a VM is idle we can reclaim memory but also cancel the
reclamation quickly if the VM receives new work (something we can't do
quickly with the traditional balloon.)

> Could you instead see optimizations being done to reporting that could 
> make it fly for your use case?

One thing that I considered was having reporting running but skip
reported ranges during active times. But this may lead to missing
reclamation opportunities.

> 
> Hinting is a rather special case thing only used for reducing VM 
> migration time in QEMU AFAIR.
> 

Yeah, its API allowing direct control was what interested us. With this
extension it made a great pairing just needed the synchronisation to
make it safe.

-- 
Thanks,
Jack
