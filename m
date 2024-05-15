Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5B3B791
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751719; cv=none; b=C09HiCRPU1a0iOc4MLNyJhXoRkNSrpPhqhU7ju0Tmc9XyC9a98yGB9fFj7lybx+i1iS85H+IImX/Z0DLxd30eEN+Wpvkv+IC8JjfZGJPqa+I2kC49Vo0HONehRMdxgSVYFYcWylLGYNmWYFKhGag1LrEKGywMBLRKONI7USNw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751719; c=relaxed/simple;
	bh=mmF1KeXBL7U8C83N3jzFBWR9OlDzinn1tPvhQxIcJoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQoobnnwm5ZaQLWJ86/YI/GMBj6tHwkggU/qorZWmDHYdaps9Z3DDlF7C07cnM9prPndp24a1cNdssYMoh5lsmEVZzMuw/2LvMZaAWq/X+kht3h/lTSd7nsM+x6dXr7eGMYpWSmHF04QjFQHfiioRotkCWOiTcTR1oDITJlqOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUVIDYBV; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUVIDYBV"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFCA44057D
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 05:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EnrQ1j3sGxJ3 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 05:41:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DB7FB4055A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB7FB4055A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TUVIDYBV
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB7FB4055A
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 05:41:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 136D7CE02C5;
	Wed, 15 May 2024 05:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C70C116B1;
	Wed, 15 May 2024 05:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715751711;
	bh=mmF1KeXBL7U8C83N3jzFBWR9OlDzinn1tPvhQxIcJoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TUVIDYBV82kiQ+MFfP94+TJanOMTxDKNqpExsyY9WyUZ6gqtJJodG6QmXkZONJXu6
	 1aK0ScbFd5P7+OEvorRw1zak3jD3s7josaNFDIOSM+aAHbyC82x0oBfodS6bxHnsMy
	 FPKE6S+7j/+G3Dq8AJw8dGiJaHb175oVUGu0KEjaFR+ZTgHymuInC4OSeDzGTmIKVE
	 kc5kWNkFxUxTTMla+TmklOYF4jdwnWpSAE4BNWIi1Eg7XQX9dgykMF3lx348dpGUf3
	 91UIiOXPBMy79Wt/kYXkcI+Yx0xixEsVwhv5FjyfPazlBlTv79liNDyERSF+kyo5XH
	 uo2vBxfXbfz/g==
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
Subject: Re: [PATCH v2 4/8] riscv: mm: Add memory hotplugging support
In-Reply-To: <ZkPOaAUZrRWRGke0@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-5-bjorn@kernel.org>
 <ZkPOaAUZrRWRGke0@localhost.localdomain>
Date: Wed, 15 May 2024 07:41:47 +0200
Message-ID: <87msork4x0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Oscar Salvador <osalvador@suse.de> writes:

> On Tue, May 14, 2024 at 04:04:42PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> +static void __meminit free_vmemmap_storage(struct page *page, size_t si=
ze,
>> +					   struct vmem_altmap *altmap)
>> +{
>> +	if (altmap)
>> +		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
>> +	else
>> +		free_pages((unsigned long)page_address(page), get_order(size));
>
> David already pointed this out, but can check
> arch/x86/mm/init_64.c:free_pagetable().
>
> You will see that we have to do some magic for bootmem memory (DIMMs
> which were not hotplugged but already present)

Thank you!

>> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>> +void __ref vmemmap_free(unsigned long start, unsigned long end, struct =
vmem_altmap *altmap)
>> +{
>> +	remove_pgd_mapping(start, end, true, altmap);
>> +}
>> +#endif /* CONFIG_SPARSEMEM_VMEMMAP */
>> +#endif /* CONFIG_MEMORY_HOTPLUG */
>
> I will comment on the patch where you add support for hotplug and the
> dependency, but on a track in LSFMM today, we decided that most likely
> we will drop memory-hotplug support for !CONFIG_SPARSEMEM_VMEMMAP
> environments.
> So, since you are adding this plain fresh, please consider to tight the
> hotplug dependency to CONFIG_SPARSEMEM_VMEMMAP.
> As a bonus, you will only have to maintain one flavour of functions.

Ah, yeah, I saw it mentioned on the LSF/MM/BPF topics. Less is
definitely more -- I'll make the next version depend on
SPARSEMEM_VMEMMAP.


Bj=C3=B6rn
