Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB9332610
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009097; cv=none; b=mctVkNRe8ds0IjomflpYYix1Ux93IXzqOVHVTUhDM2Mz2bJ8NWupVgT8rUhN6Q7xL9tNuFnQwbpdWjswpF81FkSj+aKw7R8Ipnqe3KM5KTSJfQIgUBsjOIe3QTl5vJ5hAncd/qR/smAiofjJdkD1GKCODxLkw09IoiVal+XDe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009097; c=relaxed/simple;
	bh=pQ4G/DNjqbCGt0i5V57QRDAYeVOz7JXZ8WuyK5q8U4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXXO+gc1wQaTrnc02IAUAnKPgi5sj3rDFK7CFwaHWRdowOKWceKDeJvZ8EaytW/aXUSOJKZUeO6U/d6MCUBykoFuYay6cvIP7jPjriBqZ97qOJjz4wdKkwFuNyguh3xDqcjqlXNwmMGKVHJyFMcmAbehXMTjys35o8HyjoAHOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZvFsPkNB; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZvFsPkNB"
Message-ID: <2f36a2da-0686-485f-b4b9-ae699bef4fd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783009091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLm6wd6MZy34PotO0lu+sqiieTpRzFwK6t+5eDAyG2s=;
	b=ZvFsPkNBnPpT/fXlkSqC4NvmGcAElqV1ItfaWxOxanuNMADXNea0vysO/aaC9fK20Fa/Nl
	/h+xkuVNERTD1ctetn6nlGPrMQ61CJ3XCqhhkVF860M2M509mqat5nuz+pZfFLHprM1shj
	DZ6Bs3Xsc4eQrpsCTRy6e4DCc3heh0Y=
Date: Fri, 3 Jul 2026 00:17:29 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 13/13] mm/mremap: convert mremap code to use vma_flags_t
Content-Language: en-US
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, tsbogend@alpha.franken.de,
 maddy@linux.ibm.com, mpe@ellerman.id.au, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 l.stach@pengutronix.de, inki.dae@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, krzk@kernel.org, peter.griffin@linaro.org,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, lyude@redhat.com, dakr@kernel.org,
 tomi.valkeinen@ideasonboard.com, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com, thierry.reding@kernel.org, mperttunen@nvidia.com,
 jonathanh@nvidia.com, kraxel@redhat.com, dmitry.osipenko@collabora.com,
 zack.rusin@broadcom.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, oleksandr_andrushchenko@epam.com,
 deller@gmx.de, bcrl@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 muchun.song@linux.dev, osalvador@suse.de, david@kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, liam@infradead.org, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, hughd@google.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 jannh@google.com, pfalcato@suse.de, kees@kernel.org, perex@perex.cz,
 tiwai@suse.com, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org,
 linux-fbdev@vger.kernel.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-sound@vger.kernel.org
References: <380f761d35a3faa4370f8b3f92e3d4af3d4c7110.1782760670.git.ljs@kernel.org>
 <20260702134947.25189-1-lance.yang@linux.dev> <akaJx8Zt8kazlrjq@lucifer>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <akaJx8Zt8kazlrjq@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/7/3 00:07, Lorenzo Stoakes wrote:
> On Thu, Jul 02, 2026 at 09:49:47PM +0800, Lance Yang wrote:
>>
>> On Mon, Jun 29, 2026 at 08:25:36PM +0100, Lorenzo Stoakes wrote:
>>> Replace use of the legacy vm_flags_t flags with vma_flags_t values
>>> throughout the mremap logic.
>>>
>>> Additionally update comments to reflect the changes to be consistent.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>>> ---
>>
>> The vm_flags_set() cases below spell out vma_start_write(), but the
>> vm_flags_clear() cases don't?
> 
> Yep as I said elsewhere, implicitly taking the lock is terrible and me doing
> this is completely on purpose to get rid of that :)
> 
> But I haven't been clear enough clearly, so I should put the argument as to why
> that's ok in the commit message.
> 
> Will do so on respin.

Makes sense, thanks for spelling it out! A short changelog note
should clear it up for me :D

[...]
