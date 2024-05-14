Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601C181D04
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710634; cv=none; b=Lzo9KfnOuijMcqnHZN8yIC3bLGwuWYie876pc411qiGkXJM6oJOWQqbIZXZFhf36HHuKi5qNLugrx0nxY23HButumOFkaNdeqGhT1TNm5QzrKD2ayQEsM6Isothd+lNv6MIOKAe2l1/3UO7TZ4vteZANY1ZctSxQCLFz47Eyd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710634; c=relaxed/simple;
	bh=uzmplbv5D7iNpVC5UJ5KWf/1DYXGoJz78n4vD8h3RCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eDuOMVzJ6LVEObxGecc9MN/7Hm7kmpnc1W/Lkh8HC85FGlAEEInlXON1b9xkKLi2tuWMgfT05oU4ZldUyAoSL1rsGSA7YlqFb07xbtqCdRv472q0l9rfxCr0KgnMAcbbvRqHv7eC4a2UMwyGNO0iCuOAosSxyeLN7NfboMceYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u38RF5v7; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u38RF5v7"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D18A5606D9
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 18:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k2Af2lhBPFVA for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 18:17:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 812C0606CF
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 812C0606CF
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=u38RF5v7
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 812C0606CF
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 18:17:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 46ACF6130A;
	Tue, 14 May 2024 18:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144BBC32782;
	Tue, 14 May 2024 18:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715710630;
	bh=uzmplbv5D7iNpVC5UJ5KWf/1DYXGoJz78n4vD8h3RCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u38RF5v7U/Hj9CZLp1QiPYeERCnEJgoh07ZTr+NKJv4kYr6gTe+D0EMu11P6CY8WM
	 /VfOglY7oR6cehdaIV8d5RfRqP3YkvRPS6ZuFytkN9ntM2JD3fnW9WVcVZX+YPfn1s
	 V1JJgAkfMSmbtlqYqWLmuCpUHKlabxHwkmygy68bRl7MFYxLgZpGDfOSgKNIgHLLS6
	 mJphqO0rTj088VEgKiFLU+djfgj7UyrKYsvnbKp7uj9Pp5HYfONWTVRtwLk6i+/rs7
	 AKsfNR1dGyB4iibT2WBW09lq69oEBj3rFdo/HNilveyC2k1vfSie5VIQtaj4urzRoD
	 5YC3msP+vLJjQ==
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
Subject: Re: [PATCH v2 6/8] riscv: Enable memory hotplugging for RISC-V
In-Reply-To: <CAHVXubi6Hv_FCTi=a5FFoxqiUBucrX_NhVGBAWE6qXRXdzOYsA@mail.gmail.com>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-7-bjorn@kernel.org>
 <CAHVXubi6Hv_FCTi=a5FFoxqiUBucrX_NhVGBAWE6qXRXdzOYsA@mail.gmail.com>
Date: Tue, 14 May 2024 20:17:05 +0200
Message-ID: <87r0e4l0m6.fsf@all.your.base.are.belong.to.us>
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
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
>> RISC-V.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 6bec1bce6586..b9398b64bb69 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -16,6 +16,8 @@ config RISCV
>>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>>         select ARCH_DMA_DEFAULT_COHERENT
>>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATI=
ON
>> +       select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU
>
> I think this should be SPARSEMEM_VMEMMAP here.

Hmm, care to elaborate? I thought that was optional.
