Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2459A2E040D
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394279; cv=none; b=KsHt41wc3oIXnJ0qJxGWU0q2pfMF0WcPb0PgCdOwqzaxzqWj3UdbCliOa3iOGRrriIU/hxWWscfWsTW6ylapSG/wrXi5W3+bAUZjIxY6BAl6cJOOBeIsWZ9mQ9jtP2l0D0AHHolqyzZu1zKpUhjxFwENPunmzaHi8jrpYjlV1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394279; c=relaxed/simple;
	bh=jqiZ4BSLbT2CtDgjkQN2RIybRDoQVI2E7XMd5BKafW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lgbCEXT5ybZmZiEigzEZv5rQtRvDVM+2g2prxVHrN0SvzX43bv2a25H7BfCxF1T46fOV9AISW6SD5WJ4Md1RtiYprDIgG+BazqVYVLmqp5793mBcWiwCrLDPmw35c31RCivC7oixQunbO0UKNnYUZSBsZgGfc0fZvVVL+quWvtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qLYEfQgB; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qLYEfQgB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773394275; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=yRDofVhihDUqLLlkY2UqqccMvr5aO/FD17akQhcyFyg=;
	b=qLYEfQgBpT+DKx6LEnfM8y01fICm2eYWhbDmieCau/XwFVHReBj7UV3p0/xp12xr9/kus8JreeuFhKTiQuwAVSsIE40McIGBH92r+lT7YCDX432vEv2LxaElFtYg8imMbNpRCwP+V8GLSz9yo7Ei7KlipX4GELStje70RWSyxOU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0X-rqO9W_1773394271;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0X-rqO9W_1773394271 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Mar 2026 17:31:13 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>,  "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
Cc: linux-mm@kvack.org,  akpm@linux-foundation.org,  mhocko@suse.com,
  apopple@nvidia.com,  axelrasmussen@google.com,  byungchul@sk.com,
  cgroups@vger.kernel.org,  david@kernel.org,  eperezma@redhat.com,
  gourry@gourry.net,  jasowang@redhat.com,  hannes@cmpxchg.org,
  joshua.hahnjy@gmail.com,  Liam.Howlett@oracle.com,
  linux-kernel@vger.kernel.org,  lorenzo.stoakes@oracle.com,
  matthew.brost@intel.com,  mst@redhat.com,  rppt@kernel.org,
  muchun.song@linux.dev,  zhengqi.arch@bytedance.com,  rakie.kim@sk.com,
  roman.gushchin@linux.dev,  shakeel.butt@linux.dev,  surenb@google.com,
  virtualization@lists.linux.dev,  weixugc@google.com,
  xuanzhuo@linux.alibaba.com,  yuanchu@google.com,  ziy@nvidia.com,
  kernel-team@meta.com
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
In-Reply-To: <60f71f4c-71d9-4751-8c6b-10179b98bef0@kernel.org> (Vlastimil
	Babka's message of "Fri, 13 Mar 2026 08:34:58 +0100")
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
	<3a42463b-9ddd-4d64-b64c-6c2e6e4fc75d@kernel.org>
	<343bbd5b-67a0-46c4-8ec4-69158bf26b3f@linux.dev>
	<874imkpba1.fsf@DESKTOP-5N7EMDA>
	<cd3d7e2c-79fa-4c00-89ad-83beddf98bae@linux.dev>
	<60f71f4c-71d9-4751-8c6b-10179b98bef0@kernel.org>
Date: Fri, 13 Mar 2026 17:31:10 +0800
Message-ID: <87zf4cnkip.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Vlastimil Babka (SUSE)" <vbabka@kernel.org> writes:

> On 3/13/26 07:14, JP Kobryn (Meta) wrote:
>> On 3/12/26 10:07 PM, Huang, Ying wrote:
>>> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
>>> 
>>>> On 3/12/26 6:40 AM, Vlastimil Babka (SUSE) wrote:
>>>>
>>>> How about I change from per-policy hit/miss/foreign triplets to a single
>>>> aggregated policy triplet (i.e. just 3 new counters which account for
>>>> all policies)? They would follow the same hit/miss/foreign semantics
>>>> already proposed (visible in quoted text above). This would still
>>>> provide the otherwise missing signal of whether policy-driven
>>>> allocations to a node are intentional or fallback.
>>>>
>>>> Note that I am also planning on moving the stats off of the memcg so the
>>>> 3 new counters will be global per-node in response to similar feedback.
>>> 
>>> Emm, what's the difference between these newly added counters and the
>>> existing numa_hit/miss/foreign counters?
>> 
>> The existing counters don't account for node masks in the policies that
>> make use of them. An allocation can land on a node in the mask and still
>> be considered a miss because it wasn't the preferred node.
>
> That sounds like we could just a new counter e.g. numa_hit_preferred and
> adjust definitions accordingly? Or some other variant that fills the gap?

Or can we adjust the semantics of numa_hit/miss/foreign to consider the
preferred nodemask instead of the preferred node?  Is there some
programs to depends on the current behavior?

---
Best Regards,
Huang, Ying
