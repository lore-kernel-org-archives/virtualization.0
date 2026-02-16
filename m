Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB172D73AE
	for <virtualization@lists.linux.dev>; Mon, 16 Feb 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264233; cv=none; b=fKzZQqzX4cAFpT7b8R4OpuGyB/5yQ9qdU7MFAllY2vrzKbj//iBqQCenvo/AQGejfCRwkQWVUSAKGFG3fYjuDe6eJVtcSkgrcb1KZ37e2Cy55uKOflfJvMOhMTHRdlaVRoQ5udrV/UkOxYn48bqua7icxXdY1rJHH6gSGVb8It4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264233; c=relaxed/simple;
	bh=Ec4ypCO7FiJJB+yavcc9YDym7HBY5xKLTV2mp01Hofw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiY7l2pqVCJn52Jxyk6IFwR+hRfWOZ9kh2MJaEPlpkBaNJCIrlADd9rgN/58Or2iXKJQQ+lL3sI/0WD8slBtr+WgQ57E6M0b4pj8L5/lkllklE+lNmZiLOIwp1xjC4f471TTNRDmjasy5/60Eo3YjNzFsooNOT4FbZJRxfRas0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dklPlSZd; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dklPlSZd"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ba9d13f10eso6085552eec.0
        for <virtualization@lists.linux.dev>; Mon, 16 Feb 2026 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771264231; x=1771869031; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zv95Lg9oAGKyC92FTr/4yJbiWOBA02orWovY9nKn8Ws=;
        b=dklPlSZdwPcLcgZYuq1cEhhWr1tzJSTdpWY3LVYD4+9v1Stv++uWNsQxVVssEy+sRr
         U/zNddL8irjmNXDe2iBPjh3qV1ibAoBHB6xnrHxv5EOVlEZxlz0ua2awg3zOHmt/eoSq
         dQ9FkbgRzSUGHsgBD+W02KoF72z9+Rzfci2ZfqflUROFgdQuqPzPTMk3FNfkkMIyYNW7
         eLMJYp8CdbuvadtInRG6bQWc8oqajQRT1xoaRCMvhApRxbjTI4rtOH2mFq175HjxbbKI
         VZvl39WucCCA9Aig8SaZpmlhDTtHHsajXL4mNVZ0QJo3DgrjEHmA+OhlW29G/Yh+ul4n
         jRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771264231; x=1771869031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv95Lg9oAGKyC92FTr/4yJbiWOBA02orWovY9nKn8Ws=;
        b=PObaq9XBZ3NVXqpuxxYLen+IlAJ1dSI8Cth3ohW/g1gus7Gd807+HChbkZHdyXT5yc
         HSG2xY2AwIBs01GuD3+gRwP/p9nICDcpueoVrF5arNbtphkYLTxlfbpJl5sp9pOSJV8T
         O8oGIFbBlvcNoKMicsYRcdkoTG0UeB8GFL3EW/+HDvez9uhtVoiCuhqJpsLCNgV/4++1
         +V8UsLcC89ygnyqUTQ9E4FkiFEyNjC4i7wqDtfu6s6BY+f0ij5Q3ErdxmV5iX9sNHARf
         RDH2ZWhFFbxjsX2MTMPOxxpSN1VwN1aaem6eAvemalLl55AvZ2ksjUBhHjkpPuyVfxG6
         X+LA==
X-Forwarded-Encrypted: i=1; AJvYcCXUF00d+Dswa2WxSRFcm/xH/QXz43a5Jba3V4u2zxwehwhotQ7riyrGiPlqHLZa8hNd814zzzLmxwKdjLUsDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyngajhmuYJVr5ZeB7ufpIITwV0a+8aQASLBY7hfxdyGI+5zpkz
	GQhS1GXXstNemeYwehBTX3uDvVVsTGPvaNytbcimFOGfteUYJfnVTkM0
X-Gm-Gg: AZuq6aKYMM9GRIGixL5Iuu0sAhO3T/NpMr8NOr+ebnywnXAHCU13wJPE79tphG0ASuj
	6OIVr1Ue33adCQIFC2NwCD6Jq345mL7FrrIH0TzQRZbOP5u5d4IZpU7CNI+baYPd0JN0XI1ovmg
	aX8Fu1s7yWHM0Ar/LXw0D9v2V7D0/s2dZLgLLL4pFJ5tfpiG7DZk9UJAFjPWbKQYpagu/wy1ZEl
	ZGwUwtTM4khd/QjgENBOkPR7uZhUyA+kGCx3F5T1ke7wVtyuxqQyuES2ounXQOiOK7kwo9gOeiN
	A/Y6t7CDleGLmX7AH/0JSXbUyigP6/CWLcainPDvj9YAjEQhz6dbOKLkfttjxrOOJT39qDNpghf
	d9y07agSmYflDmUF/9+1poknTZuiRj2IpY5TMsiafFl+8wpLnf62k3L0n2g7ggUvR6eiMjq6wSO
	cudxCMuIB8bcStzirCdlVxCOsbZgN2/8/QXhGEqyGgdM8=
X-Received: by 2002:a05:7300:23d3:b0:2ba:7606:ace0 with SMTP id 5a478bee46e88-2babc5356bdmr5353650eec.25.1771264230825;
        Mon, 16 Feb 2026 09:50:30 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb66c24esm10455308eec.27.2026.02.16.09.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 09:50:30 -0800 (PST)
Message-ID: <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com>
Date: Mon, 16 Feb 2026 09:50:26 -0800
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
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com> <aZLUm95Y-dKkdBWI@tiehlicka>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <aZLUm95Y-dKkdBWI@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/26 12:26 AM, Michal Hocko wrote:
> On Thu 12-02-26 13:22:56, JP Kobryn wrote:
>> On 2/11/26 11:29 PM, Michal Hocko wrote:
>>> On Wed 11-02-26 20:51:08, JP Kobryn wrote:
>>>> It would be useful to see a breakdown of allocations to understand which
>>>> NUMA policies are driving them. For example, when investigating memory
>>>> pressure, having policy-specific counts could show that allocations were
>>>> bound to the affected node (via MPOL_BIND).
>>>>
>>>> Add per-policy page allocation counters as new node stat items. These
>>>> counters can provide correlation between a mempolicy and pressure on a
>>>> given node.
>>>
>>> Could you be more specific how exactly do you plan to use those
>>> counters?
>>
>> Yes. Patch 2 allows us to find which nodes are undergoing reclaim. Once
>> we identify the affected node(s), the new mpol counters (this patch)
>> allow us correlate the pressure to the mempolicy driving it.
> 
> I would appreciate somehow more specificity. You are adding counters
> that are not really easy to drop once they are in. Sure we have
> precedence of dropping some counters in the past so this is not as hard
> as usual userspace APIs but still...
> 
> How exactly do you tolerate mempolicy allocations to specific nodes?
> While MPOL_MBIND is quite straightforward others are less so.

The design does account for this regardless of the policy. In the call
to __mod_node_page_state(), I'm using page_pgdat(page) so the stat is
attributed to the node where the page actually landed.
