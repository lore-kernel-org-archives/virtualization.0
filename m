Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5C2580E1
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931380; cv=none; b=cNfSKxKpJSxutmesgIskaYxUi2dtvrBwWI/lylau2Uxk9Y0w45Hy2foV5AM3zthaS9gFyfnXpBSRekM0qHRqEuChhbBDZP0/kTvOjBPEVb4sa3da4hMhjzWupZAICEMG2vpv65CQj17cGYJ5QqnME1d8qdLM0ajw3cTIZsolMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931380; c=relaxed/simple;
	bh=FSqjcqciAdEJMHmURv6Wj+XypwEuC0lRa+6WDMtVmn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4/DYYMA5sLpd2KoWfzFnuc/lg/Vj6JZW1WUFMS6eMrlyQLC+i9/nYMWs8kbUAlCljCLG0EPMeZwg5EuC1LR2aX4yuXqpjePEPICmO03qs0GCJkYG9E1ECaLbh3kme0FcH31Dgmeyk3Uki+EsWuB3ctewEAO8JG/qWHEy6YOGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J240lPwH; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J240lPwH"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso510399eec.1
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 13:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931379; x=1771536179; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jt/ta2e9LCcgP20HRiThdqdZNOrA6s81xaFb0uWeWU=;
        b=J240lPwHbiEBZfvq940s2PByQQHbFV2MWSpolrIEzPKAyVUzgGZ100P5DhEQNCIbkw
         rxkrWzwDhh0XLGncQ/gx8Ns6YScGo9GjBmln6a+FELDEJ6OtxH2TDehLZE8TyHGBTKxZ
         jwGKy+TzKd18HiF6pE5sXkrpHv15WtfolSH00jOE8D8GRCMt3eDSsdD6D0Xpu6iXIDH3
         gU6ppJywBQ1+WxOTDyOw7YDDGfi1cbrhbEelet7Uz3TcPBocvM5+gdCUB3Msxrj62Y4N
         JYDSSlWtiEwqm0tqUhyLttEk+SQo/fhnWCR9RRHicBVu6aEOiOhXzo+hVxRwQ1Q2smkd
         84Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931379; x=1771536179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jt/ta2e9LCcgP20HRiThdqdZNOrA6s81xaFb0uWeWU=;
        b=R3zZ6PxQkOsPcS3VGorVx/oB/+988HZTFmdq4neMQBEMqxtw/2YBprY6Hireus5PPS
         b9eqDn0+AtIix9yGhgKLyLrEoyS+E4OUR1Dvk0wUS6drDpMQEUyTNo1derE1K6FsITD6
         8tCMhq9wS/CSXGMylA1/GvvV3rFkTqlZy9IFbeFVuGuLO/pTWs/OkyGo+FRUv/jmI11U
         Z5j/osr+l5A8kPIbV06KVwtfY0X7EQ0w5DHlg7b6/zgtW8n4Q9RS3MwU4vqHHcTl8maL
         fpIZyoq7y16Sz2OfC1kzMFtoJexFr/c1lc1EQgnh7vrjFVjd3Lzwocgv8DVtqJSlTP+R
         HHYw==
X-Forwarded-Encrypted: i=1; AJvYcCWXY+cEsvHsgCSPh+61O1eNqoGI1YM8+RiHbSDldDeFXXxbeo44wMTimGW43ckjPwlaTNL5zQ53kKzm9k43zA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiYEo9wXgJz5jr/T/ftgoHIVkkTbKv7eUxjv1gzsn13RY/BTUQ
	PRMu06pyGzkM2v/su3CTtU/FMbNz9jQVT7bbRkXX511BgIt9niBZSdER
X-Gm-Gg: AZuq6aK702LVIupMPnPdoE4Tp+Q43Py+pzkLN3uJBd+v+gMvBtX88ECEXojHucggOO6
	0Tc3UgTcqJAsazQ7thq2tnBJsjbNiSEp0nk0O70lN8OVVBX67yNp0iO7ZLzUvKs0RTtR03TsCtC
	78ij+MY5gOEBnf2YoRWbRbn/YaxoN7x45OhGulqN0GxKzHHXB9/P/KxXKs/G2qsqJ5eX7ntm+a8
	asIfEZgLQKg+MGAdpRKvmgSbhmPNacyoWHJziZG9KgGdjQSpSv7E3F1EUCVmeD2Ov5zy36OubW7
	cayPhQ54Vwx5o2EQ7RFqfWhcFNEA91wFMP4M4Nhxk8PHpq5yXn3s7MJFGbfkz9+KiHV+ynzl/YX
	x6lP8rgjbXz8jglep2SERVW5cw8hqMrOThCn7GGgesRu6UbWs5OGuNS3oV3xxwfYmoB1ARdCjlv
	YDuTUwhmGzFVKPwa6b7a1nn+7de6V50WrW5h+/9b+Jb+c=
X-Received: by 2002:a05:7301:2f99:b0:2b7:2f29:648c with SMTP id 5a478bee46e88-2baba00663fmr143646eec.8.1770931378888;
        Thu, 12 Feb 2026 13:22:58 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2d44sm4184966eec.6.2026.02.12.13.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:22:58 -0800 (PST)
Message-ID: <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>
Date: Thu, 12 Feb 2026 13:22:56 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
To: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com> <aY2BcIHIARSwwQpo@tiehlicka>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aY2BcIHIARSwwQpo@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/26 11:29 PM, Michal Hocko wrote:
> On Wed 11-02-26 20:51:08, JP Kobryn wrote:
>> It would be useful to see a breakdown of allocations to understand which
>> NUMA policies are driving them. For example, when investigating memory
>> pressure, having policy-specific counts could show that allocations were
>> bound to the affected node (via MPOL_BIND).
>>
>> Add per-policy page allocation counters as new node stat items. These
>> counters can provide correlation between a mempolicy and pressure on a
>> given node.
> 
> Could you be more specific how exactly do you plan to use those
> counters?

Yes. Patch 2 allows us to find which nodes are undergoing reclaim. Once
we identify the affected node(s), the new mpol counters (this patch)
allow us correlate the pressure to the mempolicy driving it.
