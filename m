Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9491A9B2B
	for <virtualization@lists.linux.dev>; Fri,  7 Mar 2025 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334103; cv=none; b=IWtwQYIKQm0Kyr4fYR7eBNUxPq3+2Nd2VzIPehtNoSxiqBx4URCYeG/1bdrkl7F2RNPyWf9/KuNRcnY5AyHF5s0mUo/FJj+dOkpuYDL/PvAsTo82SbwnXTvCq6jRQBVUkhstxWKk/KGBzKzKlIhA45B+lg85VoNrdAem1Wz7Hkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334103; c=relaxed/simple;
	bh=Th5hIPziHcOiMnhSQ1ehwx4jc2j35d04Ew87lt0uSKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LBVhgcUerdwgcXYyk3mOytuG4fLxNiI/S/jUCvIlb50ysSSDelpAQzyE4nlesBt873znJethF7UxTyL+acBbg1un48DLgIzz3TcEPHZ0EBX7/NdWSjEcRsrMpVIcin1AC5cpslxUoY5ssebVmtOSwv1maV0RQAAEFAWuH8b6/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Un6Ekr9B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un6Ekr9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741334098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XjSBrzgKarSUxwTUTP4kt/kMcpFKwcJA5tHsYp7Puk=;
	b=Un6Ekr9BMGXPANM9zsNlS21elU8I4KwIjhmn287AgCiJoR7XJdOozPfSGQl4et6AYXFrV+
	5f59LZx85qoDdeQOUwy8Wo8hCZCdB3YXqqHb47DMQGNjyAW71VeFS2THl+7IvoVSPekdw1
	0Vvc18kYzFXdvKOeL7WuBGKgBRUD57I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-TtFcpT2FMg6oshDwota1JA-1; Fri, 07 Mar 2025 02:54:56 -0500
X-MC-Unique: TtFcpT2FMg6oshDwota1JA-1
X-Mimecast-MFC-AGG-ID: TtFcpT2FMg6oshDwota1JA_1741334095
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43942e82719so10792805e9.2
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 23:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741334095; x=1741938895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XjSBrzgKarSUxwTUTP4kt/kMcpFKwcJA5tHsYp7Puk=;
        b=tmwcNuIrKTRlMPYkM8+yLvhE0WAaqh7Cq+6bYxuVbBdpe5srpqgHS50VwFOMlG5j06
         BduJIJEIKZBCXJDJEZBEw4A1lDWF1Mo1a8Zm3fd35L5jmo7C6chAuuEA01cEcVqxUBez
         m2+Pl31/TxfFM2TTWOavmWCXBw8KnNKveBgaSdJaeojuih1SCDI1hIQ0dL4NJdIrjUjI
         cfRNLlthaat25EgBnSRmvj+wOimAPmWYdMaEUuGwwtZZwoWzBg14VQMWHdVW5ts/95Bd
         ZHlSOdVrLZgn3kw+TDkPrcehLDp9ZQ+e33IW+JcckAC+Jf42nJyhNTpovwD9txgEXsnF
         8Jlw==
X-Forwarded-Encrypted: i=1; AJvYcCW2eY3V9cv3u6PwDeVKArpRwGG3Hvk75zy6RYA/wbG/CYJ449jDcGz/H43yYI3Mvq8mxAkfRwqi5zQpX4vBkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxrftc/s82qZyDfpgPPa35aqi+Kz03ne2oO7NAP5Xw6VJL5wDP5
	JRMBtC1AcEjAI4N+xzss9winQsg2gBjUp1N87KPihjl2sv/nT73NrV9UWEMvfCaNciSjcqH1uWT
	04TorsyXSW5tfvl3+z2tn8ibAO1oZplvW2apWd53pxqTyQwiOO3orpRCZ5pRPkAPE
X-Gm-Gg: ASbGncuO6cZ3cwRH4UA8m8URw5xs0Z3vmGnfPyEIdPBE2BlV0tokabOva9+58VfI8fO
	Rbl4jeFyPrLuwK+DAWkkJ8V+bhs4I3fkAPI/auCyIqbesU0yfHh9uJMmg9O/5HB7R+di3B0f2+N
	jd3rtJgl4PBXWM7h8cu9DBXAymqPTs6hNFEMZpZLdO6+mx05ocYp8jYuFddLDNI32Lb0Gfhl7cb
	v2DmnYOgiEJskb5i+xgFf44ksqvq3k7rWlv6OS82POaXVvxsn0dXbMaTYwyafm0VT4T6SeKY2Bq
	BZltyp5fbsnHQxA5AAezO5/5ZmxeYwtmTxKNQcnZPh4Ao9dOtjA8Iow=
X-Received: by 2002:a05:600c:3553:b0:439:8bc3:a698 with SMTP id 5b1f17b1804b1-43c601cdc45mr16230385e9.6.1741334094993;
        Thu, 06 Mar 2025 23:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5GpnS4MDn/K1MDh6DvplMjCwTGNqRWUJiQpcKLuEIKeIoa5hrBZx50YeG7edtD/K149h+Ww==
X-Received: by 2002:a05:600c:3553:b0:439:8bc3:a698 with SMTP id 5b1f17b1804b1-43c601cdc45mr16230285e9.6.1741334094550;
        Thu, 06 Mar 2025 23:54:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352fa3sm72985885e9.30.2025.03.06.23.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 23:54:54 -0800 (PST)
Message-ID: <51c11147-4927-4ebc-9737-fd1eebe4e0bd@redhat.com>
Date: Fri, 7 Mar 2025 08:54:52 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
To: Matthew Wilcox <willy@infradead.org>,
 Ryosuke Yasuoka <ryasuoka@redhat.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
 dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-mm@kvack.org
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
 <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
 <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
 <Z8nEqDQhjU-Ly8Js@phenom.ffwll.local>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <Z8nEqDQhjU-Ly8Js@phenom.ffwll.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s5G-Q64VO7oDkIUzuFCoY72YAzdNQWk9G_cVI9Jr9ZI_1741334095
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2025 16:52, Simona Vetter wrote:
> On Thu, Mar 06, 2025 at 02:24:51PM +0100, Jocelyn Falempe wrote:
>> On 06/03/2025 05:52, Matthew Wilcox wrote:
>>> On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
>>>> Some drivers can use vmap in drm_panic, however, vmap is sleepable and
>>>> takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
>>>> requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
>>>
>>> In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
>>> is this supposed to work?
>>>
>>>> +	vn = addr_to_node(va->va_start);
>>>> +
>>>> +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
>>>
>>> If someone else is holding the vn->busy.lock because they're modifying the
>>> busy tree, you'll corrupt the tree.  You can't just say "I can't take a
>>> lock here, so I won't bother".  You need to figure out how to do something
>>> safe without taking the lock.  For example, you could preallocate the
>>> page tables and reserve a vmap area when the driver loads that would
>>> then be usable for the panic situation.  I don't know that we have APIs
>>> to let you do that today, but it's something that could be added.
>>>
>> Regarding the lock, it should be possible to use the trylock() variant, and
>> fail if the lock is already taken. (In the panic handler, only 1 CPU remain
>> active, so it's unlikely the lock would be released anyway).
>>
>> If we need to pre-allocate the page table and reserve the vmap area, maybe
>> it would be easier to just always vmap() the primary framebuffer, so it can
>> be used in the panic handler?
> 
> Yeah I really don't like the idea of creating some really brittle one-off
> core mm code just so we don't have to vmap a buffer unconditionally. I
> think even better would be if drm_panic can cope with non-linear buffers,
> it's entirely fine if the drawing function absolutely crawls and sets each
> individual byte ...

It already supports some non-linear buffer, like Nvidia block-linear:
https://elixir.bootlin.com/linux/v6.13.5/source/drivers/gpu/drm/nouveau/dispnv50/wndw.c#L606

And I've also sent some patches to support Intel's 4-tile and Y-tile format:
https://patchwork.freedesktop.org/patch/637200/?series=141936&rev=5
https://patchwork.freedesktop.org/patch/637202/?series=141936&rev=5

Hopefully Color Compression can be disabled on intel's GPU, otherwise 
that would be a bit harder to implement than tiling.

> 
> The only thing you're allowed to do in panic is try_lock on a raw spinlock
> (plus some really scare lockless tricks), imposing that on core mm sounds
> like a non-starter to me.
> 
> Cheers, Sima

