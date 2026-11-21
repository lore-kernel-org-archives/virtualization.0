Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224234;
	b=AGvY98xY3TVkM5WYV2k1GZ1XqRoaqk3OW6DWbJkzipDho+86A/ottrgPYqH0HsXpP9Z2
	 NL7LU333uqO6P2Lmk4W8K8jMx/ar6z+JDTAxyeM+vsjY0+eaVc126C6vrXpM7tVZBn0yp
	 s3tc3+e535u7THinNTKpFAc3g3Wt/Hfbxfb92Fvci4BEH72Q4GLBfXnfMHvPUiSKHdP0L
	 JqTJxGS9GmTBb0ThB7wvKR+4NgQjoVMuqI+a6tK3rZzVsnxlWuwDFRbOy5J+fcNGaM4sE
	 4zUgichGZzAgCdXAoYK4iYul8PSp1jt64Vi+LXYaDa+xPXJ1haJqf2Kk+sPIve6Vhsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224234;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Xz5cC2O8b4PhD3G6RP3szPC99+TsfFt+jwewiS/quyI=;
	b=bw0+pYuBpZ8ti5xo6tmHhWNPnsDOJpUy1dnnKIJ7eRr3RKHxcdSAyQTQssC1y3ffNPqi
	 va+41RpWpeoLAp0nAR997J20ljbUDLCT9i789V4IV0hGbou2TPMRsI1+jCOcMrmJUVRQG
	 3H/Fezb9vITtIe7p67cPuaroeTA5BA5BJxt3gLphUf4qw99OIte7zDr8Fk1n+sN6cZdBG
	 ZRM6sEFx645Y445u8y+9y8FIYrupMi25axPWrnNBem3LGaCGbNRDgnvmxusawShK4iUWU
	 qudhsyCypF5qIDaH81sTb5Ld1zXAfRLTSw4ukimCrE1ujMxoAH3S3fc8BRFNQeDweQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bKCr41IE;
	arc=none smtp.remote-ip=91.218.175.191
Received: from mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF060606A6A8
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 01:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF060606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bKCr41IE
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=dx6Spe2vDjy+a5xjpfUPvPXuaxBXphqlSthJWpmUnwg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795224222; v=1; x=1795829022;
 b=bKCr41IELwfn3Z45mSvylQXfnL3015HXb9GK96avk2/HTfTmNTzbhJRUkzaOvA7Xv1y7c/Sb
 HkSXeueAMFlXgKJRADmPAcsKqnfvyeP9SzmeuV9SrejlSdaYDi2E1UIs/4KWKfL0fMiYbMDYEDq
 6yub7YMlszO24BUozCca6MVU=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id ecbfa4d686ec920a;
	Sat, 21 Nov 2026 01:23:42 +0000
X-Mizu-Trace-ID: ecbfa4d686ec920a
X-Migadu-Flow: FLOW_OUT
Message-ID: <e9ec7734-6cbe-4bc8-8ee1-d7347640fb8e@linux.dev>
Date: Fri, 20 Nov 2026 18:23:34 -0700
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/balloon: fix NR_BALLOON_PAGES accounting during
 page migration
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Shao Mingyin <shao.mingyin@zte.com.cn>
References: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org>
 <20261120-b4-balloon_nr_pages-v1-1-d8944b587819@kernel.org>
Content-Language: en-US
From: Nico Pache <nico.pache@linux.dev>
In-Reply-To: <20261120-b4-balloon_nr_pages-v1-1-d8944b587819@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/20/26 3:34 AM, David Hildenbrand (Arm) wrote:
> balloon_page_migrate() doesn't update NR_BALLOON_PAGES in two scenarios:
> 
>   (1) If the new page is on a different node than the old page.
> 
>   (2) If the old page was deflated but the new page could not be
>       inflated, effectively deflating the balloon.
> 
> Consequently the "Balloon" values in /proc/meminfo, the per-node meminfo
> etc. will be wrong.
> 
> Fix it by adjusting the "Balloon" counters accordingly just after
> conditionally adjusting the manage page counts.
> 
> This has low urgency.
> 
> Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES state")
> Cc: stable@vger.kernel.org
> Reported-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> Closes: https://lore.kernel.org/r/20261115004708909xx05JgB9nXnOCG0zL7h_K@zte.com.cn
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Nico Pache <nico.pache@linux.dev>

> ---
>   mm/balloon.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/balloon.c b/mm/balloon.c
> index 96a8f1e20bc66..b31543dd4d4d2 100644
> --- a/mm/balloon.c
> +++ b/mm/balloon.c
> @@ -310,12 +310,17 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
>   			adjust_managed_page_count(page, 1);
>   			adjust_managed_page_count(newpage, -1);
>   		}
> +		if (page_pgdat(page) != page_pgdat(newpage)) {
> +			dec_node_page_state(page, NR_BALLOON_PAGES);
> +			inc_node_page_state(newpage, NR_BALLOON_PAGES);
> +		}
>   	} else {
>   		/* Old page was deflated but new page not inflated. */
>   		__count_vm_event(BALLOON_DEFLATE);
>   
>   		if (b_dev_info->adjust_managed_page_count)
>   			adjust_managed_page_count(page, 1);
> +		dec_node_page_state(page, NR_BALLOON_PAGES);
>   	}
>   
>   	b_dev_info->isolated_pages--;
> 

