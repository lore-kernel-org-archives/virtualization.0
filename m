Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90431984E
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931427; cv=none; b=MvPEY4miE7n4QsPvI9hkml6lyY0XWTYg2UDhttUazmFnhylcTy3v9oRmUzJspTnt36S/5n+xibfgSQycloQeDSmDv2nxjhUstqhg2vkh9MBnX+ghrorTvnhTJAWNe3jTKy4QHugmLjT7g4xtFbkSHA6hiswnX2GrJutFR2PhhQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931427; c=relaxed/simple;
	bh=rMNumwSZt3E/SAqI1m3Arbs/q+SzJAFwiaJFsh0Uccw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruzcjsYk0aHP0jUkI1txj0i+MUkWYGT3pdOD/J/tFb/lr8b4Qt9VI9PCbP0czZii+5Au0dewQJ7Zwda1DqFSkcVifGLjAyAQNO5YU6scZGXMYbazdWuYfJr87LhrAhcSoAR5FP5zhOJm1FlhJYrFQePV50hKYGAkSNIAxHCX0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMpaauMP; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMpaauMP"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4e9694so731529c88.1
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931425; x=1771536225; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=urRGhY6imA3+iq+NIxaKfTA3oOAFaO2s3SPb2rxYQCM=;
        b=KMpaauMP3S7Hb806YymHEfxZLMvzuL74mtJgJlDFJDy8f1ORJZ/oLLgVO79PhOOJ5k
         EaWkuwnQX4HD/341xG6r2hklYywEzzwHGUkQQHzq5veZuT7V5+l9UX0h7dLqtKa63j/e
         AoliMzpyin0oN8PGTZR6ZClfilHkb9VkSgvPVh30hIMe+hjuLf67llvxw0eCa59kLLpz
         RXKU8jV9S1ynocI+qFHrPuScEkRwiJ8dvadU2ySIdleUO6tBjq91Ks2vs59GBW01hHep
         N44KJRMAzzdbohn6AyZQF8r/ldlSODDJfV6lBBdAbhM5TQ9grDD5JMl+hqxJ3Ip46oOy
         Hx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931425; x=1771536225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urRGhY6imA3+iq+NIxaKfTA3oOAFaO2s3SPb2rxYQCM=;
        b=mc3Ookbmck/sKZ+D24qYJJwUzLbhxNR1adGhYcTMw2UmhwySXtim6uIx5s1/aH1pSJ
         U/kY7sVoOxBGRWqbkztkEsRRoKjOTTtBYpVK0a85yXaKJKRyePtIUCFhFAXtYmxx/HfX
         qiXj69k0zmZ9T36o7llnKM+7VvndsKesr7Mmd8jW7of+2dK4YVs60xYQCl60rZS5SjJ/
         H2JOus9cXdDE8iPChADAZz4vbui3DgWrPIhLT0l2UVXQp9gaU8Auej+5tzP3y6sfOyQ4
         Ywq6Vw71kVqSLxS0sZUa1WYOC0eyD87eUwRb/qdf0ASS/LPz/BwAGaJiDDTgjZNzfqFW
         NorQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw+N8hW6Xh3GpYZaO+gG0IeRBO2lyTR/tm80N73SuE6eLRzTFs637nf6tdU0RC1O+77qxEC+0Y6hLw/JKPlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSnNpMBhE6gGvO9wCeSo8CuiWdI9+Yr1Lp8IwZqG05n76G/Ybb
	6YDPIaUdYcekwRBlSxre4dPVySNuoPuUBlqhFWjFZ1C6gRAHSbIeRk2O
X-Gm-Gg: AZuq6aKh07rh57qCzpalhY1X2BBLklrrS/dd09D7GRIXgYmqndFooGce5r4hDZf3idM
	DHQ3Do7WLztRNekDOF+n1FdJrtpd5Y6g6UR+C+3wtsueYYxXKmn0VZWbhX2HVw8zYpFQqVvs++0
	k8oVWjdR/hCV6dH9hz0iieYnfu/hKp6fBMnfX21NiTBkxJ0ezu4smPU7Kb+pJ7B+F1WSN50CXut
	oNjQgwdjZRwPf8slkfHci0meMFgL5LuAUvZ9rrzFuzDZMxhsc5lhk079D8cP9z9boDLYXutRSDS
	y9yqhGxzZmGZWPGdr/6QMPovtGa1165xQWFyon7f/mxcrnmAf2O6Yvk4UtvaYGg+m7EWjFnQSjF
	uRSSlGkmVE3xQI+gMOoUxApYI5sBdVrsQ/pIzhUSOXz/8fHi9iJVtF9uTNIivKhO67ePl9fnmnU
	+DIB8M2PJCI07jOiPFzl9FkvVnJT9jOc9t
X-Received: by 2002:a05:7300:fd15:b0:2ba:a2fa:84a6 with SMTP id 5a478bee46e88-2baba0e3898mr151831eec.24.1770931424978;
        Thu, 12 Feb 2026 13:23:44 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcea9b7sm4192869eec.25.2026.02.12.13.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:23:44 -0800 (PST)
Message-ID: <fc29d4fe-2d85-440c-a8db-c26520dd4fc8@gmail.com>
Date: Thu, 12 Feb 2026 13:23:42 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: move pgscan and pgsteal to node stats
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mhocko@suse.com,
 rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-3-inwardvessel@gmail.com>
 <20260212020724-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20260212020724-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/26 11:08 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 11, 2026 at 08:51:09PM -0800, JP Kobryn wrote:
>> It would be useful to narrow down reclaim to specific nodes.
>>
>> Provide per-node reclaim visibility by changing the pgscan and pgsteal
>> stats from global vm_event_item's to node_stat_item's. Note this change has
>> the side effect of now tracking these stats on a per-memcg basis.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> virtio_balloon changes

Thanks. I'll make sure to spell this out in the v2 changelog.
