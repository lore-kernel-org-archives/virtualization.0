Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AB3BBE2
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 05:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751605; cv=none; b=JTYRbxY63jvVFfxLJg8MYZz/G61+5VRRNK/CSuACXa/vW/SPQtVfrlljM3+o2VB0JnNSyF4UCXd/GZPmxiHIizpf06FjHgzSpuiST+wWwwTaTJ5VsiSm7QcGZzwTZObSlF5VwNWaAmvgrq4IMTsoYl/NTlz4LAoQeF01kwQNz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751605; c=relaxed/simple;
	bh=qFeWv8GsFEP94NiH8hpu0MILQkrgqqI5f7XEUQ/bekw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EBwL37VpK6NpwjpmFfI9o0osU/BiE0ca+0edThAyIuAf8jdi4PkkEQx/GympLPWi9f+TFQNMNXsugYpb9gUsAuLQ5p+SuRjCHLSFSqS2hfsWSldSuALfsMXhbVo7x1bECp5w0nZWDHm2DGUdViWScA+3sPnEhzTFk+pJTwYXkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca5UtmZX; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca5UtmZX"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 783B58209F
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 05:40:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 33yT5CeAP6Za for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 05:40:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AF7EB8209A
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF7EB8209A
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ca5UtmZX
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AF7EB8209A
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 05:40:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 46E0461297;
	Wed, 15 May 2024 05:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1DDC116B1;
	Wed, 15 May 2024 05:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715751600;
	bh=qFeWv8GsFEP94NiH8hpu0MILQkrgqqI5f7XEUQ/bekw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ca5UtmZXO0PHjPXUUdc+VZYnkPVpb5jib4ktCpzzV3ZhA546YhW9UHk5pBrTsB8fs
	 5OCudtSHCOl3d3tTP3zo7RdBrJ8iHRR/KdAfFY0cca7m/EF0pacW8X7Wpz3cWwdto7
	 QOq82dcN4g4o9WbzMkFB9Q12wjhuxcMlhN5k61iDy/Hdzzp2lWztAOY+rqK8b1NDji
	 7PoAKLqCS0xjrsOBxo4Pjl81GboukdaMGq7BdQUF1nz0FsP8sokZnjlqgS/O9SKSKy
	 ASyYdWBijdb1z+6/2VB4SVQs5vdkkYQlveAVRDdcnzToprQ2NzuYIZYWyPJQVwjBm2
	 +I5sghOxb1v1A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Albert Ou
 <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andrew
 Bresticker <abrestic@rivosinc.com>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L
 <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/8] riscv: mm: Change attribute from __init to
 __meminit for page functions
In-Reply-To: <ZkPKazeHI4CENSP3@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-3-bjorn@kernel.org>
 <ZkPKazeHI4CENSP3@localhost.localdomain>
Date: Wed, 15 May 2024 07:39:57 +0200
Message-ID: <87r0e3k502.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Oscar Salvador <osalvador@suse.de> writes:

> On Tue, May 14, 2024 at 04:04:40PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> Prepare for memory hotplugging support by changing from __init to
>> __meminit for the page table functions that are used by the upcoming
>> architecture specific callbacks.
>>=20
>> Changing the __init attribute to __meminit, avoids that the functions
>> are removed after init. The __meminit attribute makes sure the
>> functions are kept in the kernel text post init, but only if memory
>> hotplugging is enabled for the build.
>>=20
>> Also, make sure that the altmap parameter is properly passed on to
>> vmemmap_populate_hugepages().
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
>> +static void __meminit create_linear_mapping_range(phys_addr_t start, ph=
ys_addr_t end,
>> +						  uintptr_t fixed_map_size)
>>  {
>>  	phys_addr_t pa;
>>  	uintptr_t va, map_size;
>> @@ -1435,7 +1429,7 @@ int __meminit vmemmap_populate(unsigned long start=
, unsigned long end, int node,
>>  	 * memory hotplug, we are not able to update all the page tables with
>>  	 * the new PMDs.
>>  	 */
>> -	return vmemmap_populate_hugepages(start, end, node, NULL);
>> +	return vmemmap_populate_hugepages(start, end, node, altmap);
>
> I would have put this into a separate patch.

Thanks for the review, Oscar!

I'll split this up (also suggested by Alex!).


Cheers,
Bj=C3=B6rn
