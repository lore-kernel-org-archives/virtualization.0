Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE85248176
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931240; cv=none; b=fUsx2e43e5I5ni7BDzOLDk8BZ+4HzFLs7bwMdJFxOv1a6Ng30jac2hYXa4n/b8cvlCCpbpwSpneTwUHHSftJ5QIjr5hp8BkpdFl8aiHk0k4zu+TFBSTr8ei3f7WQgFizdGnuv1VlWQYeq1mdJW/+hLxYsnEzV+yX5h+mpRdJwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931240; c=relaxed/simple;
	bh=hhvIY42ZejyjgeuhGD0cdgJZcMf17AiRbGuBQYVvt5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IT2ZJ4CjKmxcerf47xMnpv5H/XJ8bay/LRBWKpj6evSdGWjMtnxZGHACawkOJ5ickyH2rNEpeu49tIAppfjwaWBwpffg74HiIPKt3bUQQ9awRNrH2aVx1myqUHvmDIF9Z67jyJr0Q4BXIHWk3IvSolZpjUT9Y3w2Z0hECET2oOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKcrHBKu; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKcrHBKu"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b785801c93so684947eec.0
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931239; x=1771536039; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+vxOwDndj4zObe1CvOSxWnI7S8T1aXhKqAzJ6Mv/p0=;
        b=kKcrHBKuJ3VB44cXhO4jznBMec9ZtZ5n/psGhauAQTd/JjjuxZGFUDpD+faIlaFMwn
         fCu3m0EnFLMOY78Mp8o7Gp50EdCFZXASq2leAN6OAwKg8jBccixCRgKqLL6Ys+6Rrxl7
         yyf0pNQq/iVLzliOIFkVFqLIBxMlX9J+Bf/faQtUdF9mxz2JGZeQbZIWGcefUc8ltrBb
         XaW8yXbmwX85G/rq2TsnK5D4ovXA6uPPweDKStdKtXpB/3+AaulXd4/wcvRzOpRA0k5x
         8gVpcR+zcnPvFmpnpdOqA9965i0Kq0xvHj3aSvrE5iLWYhSTJwV6LlJc1c98eBCTG8+h
         GGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931239; x=1771536039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+vxOwDndj4zObe1CvOSxWnI7S8T1aXhKqAzJ6Mv/p0=;
        b=kgp0+UY3ahkBETtmiMkTsBX4Nrru/ZZ6+5ZeOaeB78okhSWxJl2wV+SeVrbgls4y+2
         3SiA4+z4Qxfrwbll7wTVTMSkKlnHKIqJGLSWlEsga7KEVrtSG+PWjny4dXMqu0NLlim6
         Xpeld1dO/207bHTe+3Ruv8X5/bOXZMOlpgLu9WVUic9nDjOYmQl9DoamjxN54tUhdJu+
         sVWAWTu3pE7XXhvHsixT5/tTi3N6/4d4A7N6GsLog+eNr6r1wvepKUoX0RhMQRFwuTEb
         aEosZowLwEOArWN9ZedzCBckJNZnD5UJlhqiIeFe9H44ysk+fj8xhxB2Nkn7rNrtAi7I
         mjHg==
X-Forwarded-Encrypted: i=1; AJvYcCXOSuNyCc/9F0wAZABB1zlDXX0AlPpHIEPthG6sDEYYRk/hReclM20e30SK9nhtjGTre6ziMp1mRJF1mlaRzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YylOWLvpUrqoht/AANp/X6+6Zv20X2Kk3kqYXMggIGbcFO5ns7e
	kdZf/yzK6j9LE58nH8yi4gZvJyAKBuDWvTXznefJrCWjJm1QEtjvJtJe
X-Gm-Gg: AZuq6aIIUzYwi2wmmhfjyGTbeozmbcOvSSGXqf34cPC42gVMDOpFXUwHD6r/9lvEjKF
	uJ3820nKaOS++Iy1IFB51T1cpbbl/JjsT65EPHdHi/dhdyZS5/8AVhU6NtLIBq+zFyOgwpZtuy/
	iphi+7QPBTLCDg8kJOCcGm4Vvh74sg21HH1eB4LVe4XdT2PMPcaVr/S+Gtpr0l21cvCj+VOfB+7
	sz1IbAm/OvSoXGH4Xk9Lt6iiB3KVflJtcHT621BU6eBhTQWL3Vq6EvI4AocBxx6cPwqVEOe+ZOy
	xY1ynO1cJ0V3gKeMSooCZ/WnlysILLv25Mk2B9l+YCqxz/MXcraEJKYSve/ps0x1h53QjV3PzEC
	4n2cvWYtxm24jgj0VX40dpHMM5l0G/KmIHNnKPesP4OxHuNwzsVWDgAG45c0sRr64Nj1+QQwAA5
	eplVyB6e4G6vzqYlOFbKfyHPF6shfunSpdiISavYIo8Iw=
X-Received: by 2002:a05:7022:250f:b0:11b:9386:a3bf with SMTP id a92af1059eb24-1273985be5cmr198075c88.42.1770931238369;
        Thu, 12 Feb 2026 13:20:38 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6942ccsm6165153c88.3.2026.02.12.13.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:20:38 -0800 (PST)
Message-ID: <ba761a76-78e1-4215-a95c-290f9ca8cb55@gmail.com>
Date: Thu, 12 Feb 2026 13:20:35 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: move pgscan and pgsteal to node stats
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
 <20260212045109.255391-3-inwardvessel@gmail.com> <aY2BVsYlPa4QMbUC@tiehlicka>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aY2BVsYlPa4QMbUC@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/26 11:29 PM, Michal Hocko wrote:
> On Wed 11-02-26 20:51:09, JP Kobryn wrote:
>> It would be useful to narrow down reclaim to specific nodes.
>>
>> Provide per-node reclaim visibility by changing the pgscan and pgsteal
>> stats from global vm_event_item's to node_stat_item's. Note this change has
>> the side effect of now tracking these stats on a per-memcg basis.
> 
> The changelog could have been more clear about the actual changes as
> this is not overly clear for untrained eyes. The most important parts
> are that /proc/vmstat will preserve reclaim stats with slightly
> different counters ordering (shouldn't break userspace much^W), per-node
> stats will be now newly displayed in /proc/zoneinfo - this is presumably
> the primary motivation to have a better insight of per-node reclaim
> activity, and memcg stats will now show their share of the global memory
> reclaim.
> 
> Have I missed anything?

That's accurate. Plus aside from reading /proc/zoneinfo they will also
be in /sys/devices/system/node/nodeN/vmstat. I see I could have been
more explicit about this. Let me make additions to the changelog in v2.
Thanks for taking a look.
