Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC32AF0D
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719184; cv=none; b=CMGV/hPRZj5gIdJQ0+Hq2qsWcecMn5nHSbPHnD9ROCDLTrFfcIOd0Rt32B8SBao0NI889SQ5aWIlsYjye8X+Ub10V9U7jugw92DB3EbSqaN0FEdwJxTScy1CE29DA5q+YnqumM86ab2aaEtRbdJFPqO6xntpmya5hywEBZUfdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719184; c=relaxed/simple;
	bh=dcfRyOLBWot0N4wtJVvYk4o+gibi42/0MoCaLwXR1rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGiLnHDjX2azi3lirl3pOBd1mre3LCeMeVZgK/QqBp8Vz5BU2DJ9Cw2d1dx6dtcbHewcuaylfT7Gy0z6YKGMnXxj1W8fLOFtbhcPrjgZ1+tpMtxORAH3n8SWzREzOm1BRjm/2sIQ0j3qCSNIpdS32XtAUOCmaAHJx1KfVgQzlEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eij+r6+/; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eij+r6+/"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8C25410A9
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:39:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xdd_2KfsdTmC for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 20:39:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BFAB3402B0
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFAB3402B0
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eij+r6+/
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BFAB3402B0
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715719180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ITMhM4TN9IG8BffABJDJLkO9uSK3vlKikLrGNKRSMoc=;
	b=eij+r6+/QcD7CJ7/h18zzRTvjQjgwucGOCki1NuTeEIuuEutGPw4NeElFC4lJ1zvmEJze/
	gs0u6fSur3QrlZldk5WpZNzIGSyOyqiCWjuxO/uyCxoYGW8dtefH9+4LZlgIkAQiKIfPGo
	m0RTmud8TiI/yAItjOE16+/NfH3D/q0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-h3HK7DmANI6zHLmd4vonYw-1; Tue, 14 May 2024 16:39:34 -0400
X-MC-Unique: h3HK7DmANI6zHLmd4vonYw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ee4e9a73a8so64502975ad.2
        for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 13:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715719173; x=1716323973;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ITMhM4TN9IG8BffABJDJLkO9uSK3vlKikLrGNKRSMoc=;
        b=CZZ9pB5XfCDrOx7LPX/HJC9d2R3NLpJrEuHkUdGLpddyhtTH+plxCeHTOqURcu2NTq
         LFSNhnQ9pAJicFn0RH9kmskYHjoS+CsV06u5pzTTSpdTX7IkpAqx+nGUCW7lw0e6JA6f
         opWXM1kqHt1IA0U7B+AOvrGD+ek9OrHUHWLiGrLnR783gDSGbZovLteboZ1Qj5LVQ2zw
         uEnU+zQYajWx5PetE6gm7N0davOqIg0OXqzeyIkaYevWc181zT+XRt6aYlVgsAUNg7w1
         xOESpyub6RRs9QGaH7UbIhdyE4e6aEANGTGc9u6o7h4JSgCTZCIgtJmU8Nrf8+3qqABf
         x+DA==
X-Forwarded-Encrypted: i=1; AJvYcCWXhFhCOZrsN3kEfoB2jZeVZjZtxs8rvkJFgdPYn0foDYLJzfhorPNPVqMpi5O7hWVHBjkdAzeSBXBe+POvmrmfTPWDbZq4yIlHtZ603NznfIFwVPiyBePsYA==
X-Gm-Message-State: AOJu0YzP81YlzXirluIIl4VpduC4Jwk9gr63i7oS8Kd5hqflzVc4du8a
	ycBI9J4QulL+Mj9CpBjpWaR/DoXGW71UXULpzHEQP7KMpSKpBQJawt51VFlX4aQY36/e7ISTrjv
	yfJ5Kz4FMfDX+8nbIjMuWHPA7qkNvsg9pwYnq0nRbspuA/KefIar7YctUK9h086p3ot3VmZrnFy
	n428A=
X-Received: by 2002:a17:902:f54d:b0:1e2:aa62:2fbf with SMTP id d9443c01a7336-1ef4404a379mr183346875ad.45.1715719172842;
        Tue, 14 May 2024 13:39:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZIK2cFpjPQfSL+bLZI1/OS2KM8wi7MbrbKIssFODspkwohw7SVfmm+SN9dNhpzxuT3OOpIA==
X-Received: by 2002:a17:902:f54d:b0:1e2:aa62:2fbf with SMTP id d9443c01a7336-1ef4404a379mr183346485ad.45.1715719172282;
        Tue, 14 May 2024 13:39:32 -0700 (PDT)
Received: from [172.21.1.2] ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d176fsm101887075ad.58.2024.05.14.13.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 13:39:31 -0700 (PDT)
Message-ID: <eb750e53-4b22-47a4-9306-d931628d12c3@redhat.com>
Date: Tue, 14 May 2024 22:39:30 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] riscv: mm: Take memory hotplug read-lock during
 kernel page table dump
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Andrew Bresticker <abrestic@rivosinc.com>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
 Sunil V L <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-6-bjorn@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240514140446.538622-6-bjorn@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.05.24 16:04, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> During memory hot remove, the ptdump functionality can end up touching
> stale data. Avoid any potential crashes (or worse), by holding the
> memory hotplug read-lock while traversing the page table.
> 
> This change is analogous to arm64's commit bf2b59f60ee1 ("arm64/mm:
> Hold memory hotplug lock while walking for kernel page table dump").
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   arch/riscv/mm/ptdump.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 1289cc6d3700..9d5f657a251b 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -6,6 +6,7 @@
>   #include <linux/efi.h>
>   #include <linux/init.h>
>   #include <linux/debugfs.h>
> +#include <linux/memory_hotplug.h>
>   #include <linux/seq_file.h>
>   #include <linux/ptdump.h>
>   
> @@ -370,7 +371,9 @@ bool ptdump_check_wx(void)
>   
>   static int ptdump_show(struct seq_file *m, void *v)
>   {
> +	get_online_mems();
>   	ptdump_walk(m, m->private);
> +	put_online_mems();
>   
>   	return 0;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

