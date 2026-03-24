Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3547D37C917
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331371; cv=none; b=QX4Xkgj+bKhvRZY8K7d6GnI9+9GcwQMfPFxe3d8miqw3la1OnVSRBa3wo+6Utgidr3vuFXfsDl9TEfnQUJ43JsHfD8Wn8MIvdk95J5DarD+TQ86Wva5pQ3HwIaII6EBBC/O5cw8i/3MTa28jqMPud2cn5mykRoHQOAN5Mu3nHvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331371; c=relaxed/simple;
	bh=Mbf/41IuPNKn4w3Z67nWIXgobLP9d8EpxQewXMnYWbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4TIsgk+gkTW9cPg+hakfbAlXaZ/b6HOZa8hZRROPtOADT9tMWlyD1Oq2x7s3hy9sFIVxsmJZLlqvevAbWLjxvVa7GkiQAY7k1Acmm18cz3uhDAJ8z0cJuvmDj3UBtBTheRnjR9TKpbXCsc4LXsFgvRxkTSCu2uwI8gQYd/aocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J5uev0Zi; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J5uev0Zi"
Message-ID: <0c1e4a30-6ed7-4ad8-abdf-852bac34f9a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774331366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/efI+AO/WU7EbNLcxU8hWUCzq+Ms95WwqJRGKroQR4=;
	b=J5uev0ZiPkW3hdajbfr8ApMEN55l2NjWceK0ch0Qzj0xwLXkIHKJzDg4RTGWneoNkb1T9S
	yc7ET2XFKymZjY0/JLv59oMIHeSy5OR5Hs6L65rugvPF766nqsHzxA68fRPwbutkPSqAt4
	NnQx1Qsl120T+zJlWh2XZ/vw2yUdoYM=
Date: Tue, 24 Mar 2026 13:48:58 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/2] x86/tlb: skip redundant sync IPIs for native TLB
 flush
To: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org
Cc: peterz@infradead.org, dave.hansen@intel.com, dave.hansen@linux.intel.com,
 ypodemsk@redhat.com, hughd@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com,
 seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260309020711.20831-1-lance.yang@linux.dev>
 <20260309020711.20831-3-lance.yang@linux.dev>
 <bc8a7721-2bb9-4044-b5ec-422633690971@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <bc8a7721-2bb9-4044-b5ec-422633690971@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/3/23 19:10, David Hildenbrand (Arm) wrote:
> On 3/9/26 03:07, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Enable the optimization introduced in the previous patch for x86.
> 
> Best to make the patch description standalone, not referring to
> "previous patch".

Good point. Will make the changelog standalone ;)

>>
>> native_pv_tlb_init() checks whether native_flush_tlb_multi() is in use.
>> On CONFIG_PARAVIRT systems, it checks pv_ops; on non-PARAVIRT, native
>> flush is always in use.
>>
>> It decides once at boot whether to enable the optimization: if using
>> native TLB flush and INVLPGB is not supported, we know IPIs were sent
>> and can skip the redundant sync. The decision is fixed via a static
>> key as Peter suggested[1].
>>
>> PV backends (KVM, Xen, Hyper-V) typically have their own implementations
>> and don't call native_flush_tlb_multi() directly, so they cannot be trusted
>> to provide the IPI guarantees we need.
>>
>> Two-step plan as David suggested[2]:
>>
>> Step 1 (this patch): Skip redundant sync when we're 100% certain the TLB
>> flush sent IPIs. INVLPGB is excluded because when supported, we cannot
>> guarantee IPIs were sent, keeping it clean and simple.
>>
>> Step 2 (future work): Send targeted IPIs only to CPUs actually doing
>> software/lockless page table walks, benefiting all architectures.
>>
>> Regarding Step 2, it obviously only applies to setups where Step 1 does
>> not apply: like x86 with INVLPGB or arm64.
>>
>> [1] https://lore.kernel.org/linux-mm/20260302145652.GH1395266@noisy.programming.kicks-ass.net/
>> [2] https://lore.kernel.org/linux-mm/bbfdf226-4660-4949-b17b-0d209ee4ef8c@kernel.org/
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
> 
> [...]
> 
>>   static inline void tlb_flush(struct mmu_gather *tlb)
>>   {
>>   	unsigned long start = 0UL, end = TLB_FLUSH_ALL;
>> @@ -20,7 +30,12 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>>   		end = tlb->end;
>>   	}
>>   
>> -	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
>> +	/*
>> +	 * Pass both freed_tables and unshared_tables so that lazy-TLB CPUs
>> +	 * also receive IPIs during unsharing page tables.
> 
> "unsharing of page tables" ?

Yes, that reads better.

> 
> I would maybe have it written ass
> 
> "Treat unshared_tables just like freed_tables, such that lazy-TLB CPUs
>   also receive IPIs during unsharing of page tables, allowing us to
>   safely implement tlb_table_flush_implies_ipi_broadcast()."
> 
>> +	 */
>> +	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
>> +			   tlb->freed_tables || tlb->unshared_tables);
>>   }

Cool, this wording is much clearer :)

> In general, LGTM.
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks for taking time to review!
