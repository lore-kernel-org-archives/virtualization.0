Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD138144D0B
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715108; cv=none; b=CVdkwlxSuO04zLmgNJzGqFwHeX6A+ixvYqurJPwh03h7aMBuTRrf2vmDyEbt+Yh7/93cZDB+MWuxTDT/Aru3zOWntA4l4ZWnN4kVtpuRlKTHHBAcOroQj8BGuGLXEAtySIR6GwMVoCo6Jc2udr7Vrsz3DcEKi/+LE9T0riSzrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715108; c=relaxed/simple;
	bh=Se3Ij8G283o4D8/qcripghOev92UNfpmzpuWpKYRLZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BS/bjey84y64yY6zZ/vHqILwGUfYbgrXnm44L4COZR8qvq698ZEBLKThIX8zq3MttTETIWXREMEi910YPHEq8p//zk8A9/pnD6k6Fc/587hJLTvLU+n0hJer6c48DC7kyeETSit4gtceDg/oc35fi1lSoMbb/xD0jK90bk/EBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfV27Ypb; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfV27Ypb"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74B6E821BC
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 19:31:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OXVgnqdE3v8H for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 19:31:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A61AC821B6
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A61AC821B6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DfV27Ypb
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A61AC821B6
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 19:31:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 80D0BCE12FE;
	Tue, 14 May 2024 19:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FDBC2BD10;
	Tue, 14 May 2024 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715715101;
	bh=Se3Ij8G283o4D8/qcripghOev92UNfpmzpuWpKYRLZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DfV27Ypb9DUvKPmZ1am0CxQXDO+ouVeL4LJZgUYe35yJPaFRkBqmI5HGhUiUkGIp2
	 urZIW/6Hx1MHSOG9mF7TIWBpMaCVwfab/uUZZrdidwMqzJTbIopXD9/LNs7bEpS2M6
	 aceqBh5tXX79S+7rMaEQ2EuxSPz1VR+N230Of4BmNUBRMVELVeLgchHn5nsBWKqgqR
	 oVYDu3KUvODgxvR83K9SK/olDocN/FyKkuiFwoXguQvjVPxXE2tOrozgpT/lO2UqKo
	 YDSy0QwJbyejnaH4W02iFtelUOu9vl73PWhmYHqvSuALLfB/xyrHymtDRHKI0fhrEM
	 psIL73cdwNqBw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andrew Bresticker <abrestic@rivosinc.com>, Chethan
 Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Oscar Salvador <osalvador@suse.de>, Santosh Mamila
 <santosh.mamila@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/8] riscv: mm: Add memory hotplugging support
In-Reply-To: <CAHVXubh8VpOmFqXrAN+G_Om-+6VjfeEyTRAFp8EWae3mFgjB=Q@mail.gmail.com>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-5-bjorn@kernel.org>
 <CAHVXubh8VpOmFqXrAN+G_Om-+6VjfeEyTRAFp8EWae3mFgjB=Q@mail.gmail.com>
Date: Tue, 14 May 2024 21:31:38 +0200
Message-ID: <87eda442cl.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:

>> +int __ref arch_add_memory(int nid, u64 start, u64 size, struct mhp_para=
ms *params)
>> +{
>> +       int ret;
>> +
>> +       create_linear_mapping_range(start, start + size, 0, &params->pgp=
rot);
>> +       flush_tlb_all();
>> +       ret =3D __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT=
, params);
>> +       if (ret) {
>> +               remove_linear_mapping(start, size);
>> +               return ret;
>> +       }
>> +
>
> You need to flush the TLB here too since __add_pages() populates the
> page table with the new vmemmap mapping (only because riscv allows to
> cache invalid entries, I'll adapt this in my next version of Svvptc
> support).
>
>> +       max_pfn =3D PFN_UP(start + size);
>> +       max_low_pfn =3D max_pfn;
>> +       return 0;
>> +}
>> +
>> +void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *=
altmap)
>> +{
>> +       __remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
>> +       remove_linear_mapping(start, size);
>
> You need to flush the TLB here too.

I'll address all of the above in the next version. Thanks for reviewing
the series!


Bj=C3=B6rn
