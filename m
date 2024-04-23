Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9E56451
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864115; cv=none; b=gOvcVzbyckkx9l1MEp4of8KTJVT/gv04T+EO69f5kTqGAH5lU/v5oy5hsaMwAFAGAjMD3v7CZnt1RPg1Ie3nwc7cbzMuAnbL01baAYOOE63ie9JY51VHuO1Sj4RHtMl2C4L5hb+M7w6uRPv4kxNlY/ODkBcMWzyR8tcN5GhUQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864115; c=relaxed/simple;
	bh=DdkrLe1RT9id5XgPQKF0YRBkxxjwVH7gEzkXmC6vFnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpGPkrV1sc2hNcW3KTYTzKsyb6lBpmlVJIWnDQ1T6F5mbANA+PHt+hBYiw7W/oyzCa06kOgKEWHSMP8Lw0nkgAoLlLA9KJJV8jYbFfwFgAyutQHKscxmalfbDXB2W7OuEsdH2WF3jYK2duiu1CcDPjLBtAsNkHTnSOTEMeZUKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jz1C3/AZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jz1C3/AZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so36345575ad.0
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 02:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713864113; x=1714468913; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HQB5x5/Geh4QesSHMQ6J5Oee4AS8dKYNPWzhQc0IWE=;
        b=jz1C3/AZtLBsNfBnHwJ8L97CgnDwAr09CI0G7kEeo/HYiH5K1sWrg7v1QybRB5aOQk
         5RQC45xnIdj/c6Ls6mwpZ4cKXe66+npC5ZgniBgXHTZhhCYsUXchV0OFRDAb4NbMDLDF
         4E7gWyCsZBo3taB+MJu+RQ8eOberaRTQXwSzgvQIWShk5v+1wFpHxXrptiy2+DbVkMmg
         vKV6Z/MhFLp3eMdlHdjd0GoeI8YmXq8R0Z1luADHkQqgZplDb+uaPn5XGiOUCVvTh//s
         WP9hn/zuYhTp+PHuGySNoVaUOEPDDkgQO9kb6hQDWg9vArORlE2GiSwQSxJ38Iwnpg2A
         t9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864113; x=1714468913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HQB5x5/Geh4QesSHMQ6J5Oee4AS8dKYNPWzhQc0IWE=;
        b=DHfDmdsdQmL3pB6KVvAazGg/Qvpj9Jdw0z8eQPT4kILC2f9RqN/GCo3kv1d1V3CXj8
         g6XfwX3hiXClUYIDnPPiJLKWgI0CrPS7iOs8j0bjx32RUngstrUcMuQX4aAPh2s+5u2S
         H3qV6YOXmolGPSQ4DCy6hbqfdR5Oyf5XiLO9zy26x4s86iD1W0qh6Sdt1USyogCKFzq6
         qtONjoZDZI0BAnOr6feFU5xv/DnpjsTAyJCBWPi671cHFwVi8oHlQG4eFm+PRSftMcpI
         wU7laAfpTNreLz+YalwebLPhZ+vge+w+FGiNHIvAri95OxFlNlLqyuJ+9lmhQcS8puCR
         XlOA==
X-Forwarded-Encrypted: i=1; AJvYcCXk8vQzegK/YZ0eEhQNYW7+bRRM5hKuUxyvKLINKtS2RJI7df3NxdpvRnZhInsvSMMFCiti2XBDktwSoJbp0irK/pAZvUNuocsuCjxQj0o=
X-Gm-Message-State: AOJu0YzgIDWpiCkt2+keVbTbt40MEv/0Yyg96bpuE/L94vXkCEB/J0vt
	Nl64D1+Y7sqXFrPGjz1pfCcQzyX7hllU39ASW7zZXSjcynNJBxTLTl+IrHFS/50=
X-Google-Smtp-Source: AGHT+IGNbPUgoPFYpHt28v7DULAEOmvD5VLEYjWmHxgKiyi3KxYYlHK+lL1oHrJ3+ZdleSTJCgMaQA==
X-Received: by 2002:a17:903:1206:b0:1e4:53b6:6be with SMTP id l6-20020a170903120600b001e453b606bemr2926772plh.1.1713864113257;
        Tue, 23 Apr 2024 02:21:53 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b001e89e7b2b74sm8884164plk.235.2024.04.23.02.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 02:21:52 -0700 (PDT)
Message-ID: <6e9d6af5-74bc-4e97-84c0-2ba8a6499da9@bytedance.com>
Date: Tue, 23 Apr 2024 17:21:48 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v3 2/4] virtio_balloon: introduce oom-kill invocations
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev, david@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, akpm@linux-foundation.org
References: <20240423034109.1552866-1-pizhenwei@bytedance.com>
 <20240423034109.1552866-3-pizhenwei@bytedance.com>
 <20240423051151-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20240423051151-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/24 17:13, Michael S. Tsirkin wrote:
> On Tue, Apr 23, 2024 at 11:41:07AM +0800, zhenwei pi wrote:

[snip]
>>   #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>>   	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
> 
> Looks like a useful extension. But
> any UAPI extension has to go to virtio spec first.
> 

Sure, I'll send related virtio spec changes once virtio comment mail 
list gets ready.

>> @@ -83,7 +84,8 @@ struct virtio_balloon_config {
>>   	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
>>   	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
>>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
>> -	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \
>> +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
>> +	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
>>   }
>>   
>>   #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
>> -- 
>> 2.34.1
> 

-- 
zhenwei pi
