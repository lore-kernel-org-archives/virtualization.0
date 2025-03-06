Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD120E01D
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267504; cv=none; b=UCopLDJ5dtD90xLPVC2WivQcqlhzuWEUK06f/fMOuyu0l/5M2AsQqCA6an4e1TQNO5zFVeXjrYBodPrN+0Zg+kiCvDq2pe9tFNEghg2IUzcIx63JCe3OUWbcO/tVED4GThY6SB+m1A3PPOLq0qUuo5kX6fJ+aB7lnQSP7V2u9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267504; c=relaxed/simple;
	bh=BaUEKFsnt/oGux8kiRaCu0JFUJtBvq84zkV5ZqVRACA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNw2pUe3qcwhoZby+MNDfo/dzzXgalSyNRT9NjQA7p89Ik/dUqOJEHQZqAyrLNhP6Xg6BCdCMBNkty74/FDJzvo44SnEx8UsS4Qzh1HxS+NXTSbQMANQzhLrrmodZB7AWXRfYEPYOtx+rY2ALdr7oXB4BLxEbkA3LPg3+K1GFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fceHLj2J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fceHLj2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741267502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMe2L544kp/d38WLjn3xMcZvhSWCOUekm7mNyssXwXc=;
	b=fceHLj2Jh7haYcdMzwTGcuRZEASSJ/7LvbaIzpgrni5siAvYKS0ixzskkGPN11MvzdadGM
	VHML0m1IkKsfFlWhjZZ2dTYcm22RCqOx/EJquJ2gkSbAu2GtxEqdKEaONEbd9ZuQ9/SPrV
	Xn+jXN8AJu3d0FA1visjcdvaH4u4J84=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-7utsCdriMzWtjwzG9JvCcQ-1; Thu, 06 Mar 2025 08:24:56 -0500
X-MC-Unique: 7utsCdriMzWtjwzG9JvCcQ-1
X-Mimecast-MFC-AGG-ID: 7utsCdriMzWtjwzG9JvCcQ_1741267495
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3910cd78330so351876f8f.1
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 05:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267495; x=1741872295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMe2L544kp/d38WLjn3xMcZvhSWCOUekm7mNyssXwXc=;
        b=Zsum09X7zkxj+uhqWYfzpizbGsxzRbm57mk2WWLktPOVpPq+cflNgsg76JTrnVhGm1
         PaGBPdHSDc+W/UNGzpIt8xPDgKW8yH0/sqizFM1FMTLRehOvPzAJjE70tza5VNqSm8xl
         ER3lKtQgZLVPmi//317SJpkGXHBL4NOiO31f6eRMF0eMHEoRTS+ZbGq+lACpoowR93Pq
         aBGqeSYa1KNZmb4wxk2f5zXHwU7WdX3aT4sr3fJWzO7qv64g7TBxAm63UzbfC7WVcOhk
         sidj67BAAKKEk0cv64D5eMch0MP9pRBMccTkFAAoVEQzEWq4r8a8gT4oAGOG1420VlhD
         C6hw==
X-Forwarded-Encrypted: i=1; AJvYcCV1RsHiI4WsIduHF8tXc5cnAO6+5di7s7DDjZ+OAwnTcxSew7lz4LqskYH2/PHdApqiPikoDMhMByNI9VNkVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAoTocUIQgkKjtLZSmYlaxZ5bmxaxHqoEvJoTCP+mYfMgXOqKc
	UN4xSEhVr/6uzB6edjeAMG2co8vWVu61kngTMB5vyoZfgHzegMAV5D5NebFBP0SLTQdag6KaEvA
	k0t4tQeDJzod4bXiwTAt+IlUJLxiVh9tYVeqvKwGtyjxPB+bTzS2mTECMX1NZswmb
X-Gm-Gg: ASbGncvREvDNUCYjAPm17sj+kij2byCOiVSn7MtgG0nSrLDkFyVQD1+NHEHOuc0dQdZ
	DK6n6HTf2ol06GxixFobFE2zlPyhoMAMjTA7H7RIRyLOtzz3I8qtM8mlEoJfeeP2mZ/WCEFsr78
	WVCV77WGgqEvPqzvwZtR8ub7EgRAldG9TOk0fGzlI6emC1YkAbq7IqKcbIkGsf4MdqVEcwla0hy
	IHZcQX5CqYmVkhou9nVz4es9PdhhMJY+VLuWBY81ruWxUjvNqeMBDhe9UA5kLZvdhSo1Bt07ePC
	jIZnKhSDpe1UyBt0iXon9JeYy1/dQpwQ08J1vm2xHwA+B8C7BHuNvhs=
X-Received: by 2002:a05:6000:42c7:b0:390:f9d0:5e4 with SMTP id ffacd0b85a97d-3911f741261mr5096863f8f.21.1741267494966;
        Thu, 06 Mar 2025 05:24:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIwqvoLsZ7nWE/oVtc7eKMKzGDa6NvX7GYnOgsSJBfK4lxmD7NxGmoi2sk4zoXn8lH+Jx7Gg==
X-Received: by 2002:a05:6000:42c7:b0:390:f9d0:5e4 with SMTP id ffacd0b85a97d-3911f741261mr5096838f8f.21.1741267494530;
        Thu, 06 Mar 2025 05:24:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdfdsm2117782f8f.34.2025.03.06.05.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 05:24:53 -0800 (PST)
Message-ID: <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
Date: Thu, 6 Mar 2025 14:24:51 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
To: Matthew Wilcox <willy@infradead.org>,
 Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, kraxel@redhat.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com, akpm@linux-foundation.org,
 urezki@gmail.com, hch@infradead.org, dmitry.osipenko@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-mm@kvack.org
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
 <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z6ns2ReCeo8CoJZ_Xiux103fym1imYEpxlv5zr2Y4m4_1741267495
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2025 05:52, Matthew Wilcox wrote:
> On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
>> Some drivers can use vmap in drm_panic, however, vmap is sleepable and
>> takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
>> requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
> 
> In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
> is this supposed to work?
> 
>> +	vn = addr_to_node(va->va_start);
>> +
>> +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
> 
> If someone else is holding the vn->busy.lock because they're modifying the
> busy tree, you'll corrupt the tree.  You can't just say "I can't take a
> lock here, so I won't bother".  You need to figure out how to do something
> safe without taking the lock.  For example, you could preallocate the
> page tables and reserve a vmap area when the driver loads that would
> then be usable for the panic situation.  I don't know that we have APIs
> to let you do that today, but it's something that could be added.
> 
Regarding the lock, it should be possible to use the trylock() variant, 
and fail if the lock is already taken. (In the panic handler, only 1 CPU 
remain active, so it's unlikely the lock would be released anyway).

If we need to pre-allocate the page table and reserve the vmap area, 
maybe it would be easier to just always vmap() the primary framebuffer, 
so it can be used in the panic handler?

Best regards,

-- 

Jocelyn

