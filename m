Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4E17B4E5
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702335; cv=none; b=Rd4AtFj4PwuQ1mwu9OHRNNKyS4RYCSoUYiesEW+94xWfqjLj9W010yXHttffDnDigJEp+XeUDjccKfPOwz30tFhCJwhEBo+equa9U+O57ViOEo6Qe6O0wQWQo8oSlo0WqHXH/NUX+fxNElDr68MMQRhdEB3VrU3kjRXb2lqZwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702335; c=relaxed/simple;
	bh=T/7tNw3OCSBexRio3ZeLhVbYRbHi05hyDMHnz4+jW6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pX1BXJjbCjrC5cCeX7aXIWbrIK8U3vjMgVBBndL+5ZuQMRsaFXJstY1RKeraltVgDedVW7bkJGJhEZJoUtfNAiPJXn+N+GRBALYHkmbpQgXmTTy70TZqWY4rDo5DuqENLme8QTyhlKoDY50GIO1Wkp4gK9T9WUu17snmwYbVoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXE2POuO; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXE2POuO"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D30CF60697
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 15:58:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NlYGX5kPda64 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 15:58:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0550E605FA
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0550E605FA
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QXE2POuO
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0550E605FA
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715702331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kvyD+47vDiVZ1HqZCWc8GW6dp7A4/9KWl6vG9zgnVfU=;
	b=QXE2POuOnHHskgdYzMmBcwemIBVfydDvAHHeSPEqUezxHQdQPvNBOjYkZVLVW1nKnQ3Lwe
	n3Yxl0lA3pXeimmiLuONWgPmPIOrV+WgJj/86YiEURWFKE067zZvrcdb4jlzqVgsRL2rW6
	aIdUNp5V5xNKhuipabhZjSG5C6z9yvs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-6hyDfq1HOj-heu5Fk1QL3Q-1; Tue, 14 May 2024 11:58:50 -0400
X-MC-Unique: 6hyDfq1HOj-heu5Fk1QL3Q-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6f4739ba7dcso2550796b3a.0
        for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 08:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702329; x=1716307129;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kvyD+47vDiVZ1HqZCWc8GW6dp7A4/9KWl6vG9zgnVfU=;
        b=T74qqQ69Vp1VWMo9TOEOUyFoFJjiN/6qOUcOGGHNsXEk0N6escxWoPM5Aqh2HR2SL8
         GlezfN1BcGU/EjfYuScqD7IsRCoLbJ6i1EWTaMDc8WXq4sxAQnJfauHxGRVj7IhCehIj
         kTnCuM6uYn4sqttsn8t8ENGMTfrrbKQmvASuBS/nQqzl8tt2a0JQmm4S0bEd5EIP95Qb
         MiIK6eg+j3TWarZ17pMUQ7njwv/tpla3emF/8q/OsJlUKewConGRmLK99GwgxY5Ypkha
         ZVyov60oC4uRNXuwma8b6sJzcSLTGicHKrDvVF2SQp3kWDZXEBvyeSKiLty74aYwy77h
         hJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0ORlPqHgirL4bgpvOYNUma9mM9kLuLUTCwTgaEMnW0zGDIhgSAySy+BlEM8Qf2apEP/kUmEu7o/V79PWcrZBh/FdJMD4tuAeK4GJYQdyZoaujlO9up5uwqQ==
X-Gm-Message-State: AOJu0YxssXkuksuU6NokGeSthUi92jpxh8liBfPH1rfYUK268pIoltQK
	B9dzvXvL6saNwSY+yCWh5aBOOYBR3c2tROsa34YJovn50bv1SA88MqYioCxUnL8eZCrqtO2Yiid
	Z5mysT//J6lgXFikkt/iF8zIzCzabdmMNAOcgDPgQ7TKoQAYcEHnVVa24jEMUJ/NqxpVL6lWtJY
	DC80w=
X-Received: by 2002:a05:6a00:4f86:b0:6f3:e6ac:1a3f with SMTP id d2e1a72fcca58-6f4e02ad970mr15828922b3a.11.1715702329009;
        Tue, 14 May 2024 08:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQISvA42hinyusbGdUd1dvzSXFpQXpfUwTKAu99wTKU0rBBgYY71Nyic/65cySNe0tBJdx5g==
X-Received: by 2002:a05:6a00:4f86:b0:6f3:e6ac:1a3f with SMTP id d2e1a72fcca58-6f4e02ad970mr15828889b3a.11.1715702328570;
        Tue, 14 May 2024 08:58:48 -0700 (PDT)
Received: from [172.21.1.2] ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66590sm9695600b3a.1.2024.05.14.08.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 08:58:48 -0700 (PDT)
Message-ID: <8b7de899-4150-4da0-8242-507977169bbc@redhat.com>
Date: Tue, 14 May 2024 17:58:46 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] virtio-mem: Enable virtio-mem for RISC-V
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
 <20240514140446.538622-8-bjorn@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240514140446.538622-8-bjorn@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.05.24 16:04, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Now that RISC-V has memory hotplugging support, virtio-mem can be used
> on the platform.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   drivers/virtio/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index c17193544268..4e5cebf1b82a 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -122,7 +122,7 @@ config VIRTIO_BALLOON
>   
>   config VIRTIO_MEM
>   	tristate "Virtio mem driver"
> -	depends on X86_64 || ARM64
> +	depends on X86_64 || ARM64 || RISCV
>   	depends on VIRTIO
>   	depends on MEMORY_HOTPLUG
>   	depends on MEMORY_HOTREMOVE


Nice!

Acked-by: David Hildenbrand <david@redhat.com>
-- 
Cheers,

David / dhildenb

