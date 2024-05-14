Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D51365
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719238; cv=none; b=TGaXeGYxGtaIX77y0bkgQvQJVws2Xvc2I6IEX8TUAZi4dIUZsor3x8wG+AzDvSS/F4T0/L1VCqFftg2Rhf+jFaXkgHuq3feeVVNqAaWD/YMMmbBRSGZkLWgeOT1EuniV3ii7m0q6j67Mepnxh19iRKFoQ+mq6W4vrjp2E/s4DAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719238; c=relaxed/simple;
	bh=NQ44bzHV1kkewM1edEMYWaIIvfbxgXRW6y+UbGh/9Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrhZnpBDssdzJABdT2S5FU58UoE9ioydXjZvJTxui0e2EunHHB2eeGIGFgt05YdviOrmiNZuU54i3FZc4sgXqGHmLSyNZPXOzkNCN/Ux4MIzQ25TYniQWHgqg0N61+NKBlBhcsNcQAlP9mEh4NqijzVRRuCRkpv3bnUTB/11CNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpiKqPLX; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpiKqPLX"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5549860B5F
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zakQIf6DQvmf for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 20:40:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8AF0760AD3
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AF0760AD3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WpiKqPLX
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8AF0760AD3
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715719234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ERFfx8GtL0+KBqPg/EG0Vzt3dGykVLSh9fvS/DwTqDg=;
	b=WpiKqPLXq0ZlaEIpX3MHb1DS2ZMWoqQItBhHRENA1o5It9Z/+AwuQT1KpxYiXiXfTYBRS4
	ldJDtSBPuAjwr12JrWCwr0m65kdbm4+RYKrg8wXJGpXcgnj7g18n3N9FCIRywSLeSphUW7
	QRH+D9/p2Zy/JNneavuJm39A39v87UI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-RJL_TCWlPPeaWPqlfLN6jA-1; Tue, 14 May 2024 16:40:30 -0400
X-MC-Unique: RJL_TCWlPPeaWPqlfLN6jA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ec401f87d3so68267975ad.1
        for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 13:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715719229; x=1716324029;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ERFfx8GtL0+KBqPg/EG0Vzt3dGykVLSh9fvS/DwTqDg=;
        b=B2wBhdUgkYWVz2Pcfizpd9wbgVmFsHSQT3S42oRulzVz7/37NS4W/vRtgkHoiJ6tzr
         LWXZcOr6THBLzD3cIahYzZ+HdxkIPgNWnYOZs6H4OsgDZLGWxQxfgcWcPVlyyTMRSrth
         Qql6FclI2bd/hPvQtVaJW6jB2VVTdTMp4pJyIrCFlBBnDJ80OtxbJ0BIZKXSwBHAigDx
         s1BjghEmgxSxJNHK+C0/ckC00rY1oq6khBrEjesKV151+68RjA7qvrOMK6NtZwLu2v7e
         88lYYmGigYcs/kjiUAtgRKoHgfVdbDGD+CliGldC2+9iM789UbuqK6V5eR5zo9YTU290
         Iojg==
X-Forwarded-Encrypted: i=1; AJvYcCXiVu7v47Vk1HGvZjcQkFNkbFRn2czXQu2kTfFrX4apsCykRu2hv5i9tG9Ipi9yw/77SP+KjO555n0iGAyHe4fCoSZyqzAsFPm5GOmPqOooPJpt3dUSub6Lhg==
X-Gm-Message-State: AOJu0Yxh36+6cc1x/gApjhO7141YCAoAGNuioHq5we7VfF28+xNrfAgT
	+BQFiVHue8dVKCDMxy5/MGUk+NoUpP0upvmxPR9Bg/qdCnKjUefwmeuS5ZwnjVYHgsXNJXGWQnO
	lcNtRyFHL7k/XuG6CrOafp6cTUFF16p9RcWKlDaoB66eKR1invdZ3talNkUVSYeqqg/Ozmm8QX7
	6NMX4=
X-Received: by 2002:a17:902:e84e:b0:1ec:b6e2:da89 with SMTP id d9443c01a7336-1ef440505b8mr190128585ad.61.1715719229630;
        Tue, 14 May 2024 13:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6bA/pLrH5fULGMGrMKQoSFgbTk9N93hyM2xdgCcaLr0iqz/N5xBJQZ4SbpuoqpUbPjsyoFg==
X-Received: by 2002:a17:902:e84e:b0:1ec:b6e2:da89 with SMTP id d9443c01a7336-1ef440505b8mr190128335ad.61.1715719229168;
        Tue, 14 May 2024 13:40:29 -0700 (PDT)
Received: from [172.21.1.2] ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d40besm104795205ad.42.2024.05.14.13.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 13:40:28 -0700 (PDT)
Message-ID: <6f6b0577-51af-4fdf-a46a-d50787346150@redhat.com>
Date: Tue, 14 May 2024 22:40:27 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] riscv: Enable memory hotplugging for RISC-V
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Andrew Bresticker <abrestic@rivosinc.com>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
 Sunil V L <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-7-bjorn@kernel.org>
 <CAHVXubi6Hv_FCTi=a5FFoxqiUBucrX_NhVGBAWE6qXRXdzOYsA@mail.gmail.com>
 <87r0e4l0m6.fsf@all.your.base.are.belong.to.us>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87r0e4l0m6.fsf@all.your.base.are.belong.to.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.05.24 20:17, Björn Töpel wrote:
> Alexandre Ghiti <alexghiti@rivosinc.com> writes:
> 
>> On Tue, May 14, 2024 at 4:05 PM Björn Töpel <bjorn@kernel.org> wrote:
>>>
>>> From: Björn Töpel <bjorn@rivosinc.com>
>>>
>>> Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
>>> RISC-V.
>>>
>>> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
>>> ---
>>>   arch/riscv/Kconfig | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 6bec1bce6586..b9398b64bb69 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -16,6 +16,8 @@ config RISCV
>>>          select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>>>          select ARCH_DMA_DEFAULT_COHERENT
>>>          select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>>> +       select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU
>>
>> I think this should be SPARSEMEM_VMEMMAP here.
> 
> Hmm, care to elaborate? I thought that was optional.

There was a discussion at LSF/MM today to maybe require 
SPARSEMEM_VMEMMAP for hotplug. Would that work here as well?

-- 
Cheers,

David / dhildenb

