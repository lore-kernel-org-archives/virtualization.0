Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214620897F
	for <virtualization@lists.linux.dev>; Mon,  3 Feb 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595530; cv=none; b=P7CPkXAxwjOyvVe6Oa+PxmXhl/g7FOostfSY5EhfNCER7+6/hNdT47v6ktGQkdOJ6usYoV5K2VfSHyCn8wb9TyVSsLF2rNP95xzvAVWPV0iR+wQ6ep6K9yK2w+SJ5mtVd2vUz5dt68zpD9tqBwcaMpBueSKLVOsWo+wyzVaMvqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595530; c=relaxed/simple;
	bh=J4WPyu2dCpa1wg3kBbT+yTxtUfiD3S5ZdeCx/ev+Q+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KA8wIl3d4PpihVTcxO9LdRpzgKErRHFOLbemTUTs8vM/cqd4n4ZB5WqESx7xWubTA77Uk5pO8bsih276/as+AAQiEsC01Iw4NUh46+CeLo0hEUaQ88KsnqAdu8IVDh49uHQ0TrUzFC7OW9Vzcwv0UxCXbmavEFrAK7oExgO9i/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BiFlmJCP; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BiFlmJCP"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9caa3726fso12091395ab.1
        for <virtualization@lists.linux.dev>; Mon, 03 Feb 2025 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738595526; x=1739200326; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRfpPZzgAZa6Zak9GDas5XD80wl2C6NIA/57szE4cSk=;
        b=BiFlmJCP/WsNIjWTb6/ZYOnzu3CxjXBjs0JTeBptxNub7cQge3/tIfMVYtP5lwUxf0
         10+sZMIEuGl130tv1QSOh12Oe6xKdQ/dFpjyktIgxUdapIWqtPmoo9nP6DGA+wENW0pf
         BPdwtJWFBZ93lYyGcM8jPbCizIhhMmlil2yFsPk02PFHg8ybxvD7bHr2iF2Lrna2HQBs
         Fdg9KONXCMV7ebBsVu+ZyXv3A1PgGTu0Xz3St4n++HQ3vtwxy6oIWSgwigYYeGmrXQzc
         zCg03ESmni2qC93/KDMXVZ5OqbsemxWJLKL4tAQ5yYgLgo2XBmBRIwxPC30417Zk9lvl
         +qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595526; x=1739200326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRfpPZzgAZa6Zak9GDas5XD80wl2C6NIA/57szE4cSk=;
        b=OYwZhXzN9r3FXMdKaztCOsIbeekTa4hqGptx/ZtVI/OjJUfaLOwmtkH2nTRWOedV7+
         7mtXw0yjKbsRlA2UPvfGjGGb9BIStzvytjDbNyiUMDURFGCIcz21ej6rtk2AeJ9d2nOO
         c2p9HvE01wRCM0cQr64E/uC4W6PkA6ITQ+EHyHdlgb8Zs58nb0TEGgPfF8MUoqQe1q9I
         bINbwfCBghEI+ET0aBnZScrPD6bnyf7jklZYU7gIzcTYR1V+FuXHlDmpNLd9UgNkhMU9
         JdJMGCMV6Pw9KyZ8nBaeDq5rKYKv+ReWTPrluLwDrrf5/3lYoPmIDb4VmVYwxjVAczqD
         55Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVO+zvaHon4ZI31hcc1xz+QOwbKGyrUHmu6vL6W577rREpXYNU2t7bf2sfUQmtBmRj0OdPezglytEW+4mix/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZUrBLxJFX3qrWcpysfzaGoI9L6VWO7xsy7MyiN3lbUy5FjZEB
	kj4uUh+FYqr4kETXc0LpRWFjX70Lr91GA7+LtcuGVaQGuXbsRo527QJo06B/E3g=
X-Gm-Gg: ASbGnctte00G4EYiuonnZKSz5hwCTKM9MVn1sSoUs1S1LJ18PWCH2c63fXXvuaShqn6
	Ujup5/D7j6G0GbHgX82MdbdT6xTn93km62XG87hnNLy/28MyXCh0ZzbUysU4n0o6zPfltr+qiwK
	qUbOtRY+jCiH5KLXO5Ka3E1/eweQfazSj9XYOr90ri7TivhzXDnpbicAzZah1CxWsvJVAAbscDg
	WhMwtfflHkaW+XNs859+i4fHXxToAzUKrgKsw3Nt5mdMned+3bmWVgaD2+DBxBambqfEnN18BBh
	vkQ2ytr5zpU=
X-Google-Smtp-Source: AGHT+IExPksUoM3E6ty6LrIuS+bUTXtJbAwi3WKcho/2VPhbuSKK1HIuLb1aeN5jPmbZBIOOLKzxHw==
X-Received: by 2002:a05:6e02:2688:b0:3cf:b2ca:39b7 with SMTP id e9e14a558f8ab-3d008e71836mr145248235ab.3.1738595526174;
        Mon, 03 Feb 2025 07:12:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d01c433734sm16125455ab.14.2025.02.03.07.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 07:12:05 -0800 (PST)
Message-ID: <262032e2-a248-40aa-b5bd-deccc6c405ca@kernel.dk>
Date: Mon, 3 Feb 2025 08:12:04 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: force noio scope in blk_mq_freeze_queue
To: Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20250131120352.1315351-1-hch@lst.de>
 <20250131120352.1315351-2-hch@lst.de>
 <2273ad20-ed56-429c-a6ef-ffdb3196782b@roeck-us.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2273ad20-ed56-429c-a6ef-ffdb3196782b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 8:09 AM, Guenter Roeck wrote:
> On Fri, Jan 31, 2025 at 01:03:47PM +0100, Christoph Hellwig wrote:
>> When block drivers or the core block code perform allocations with a
>> frozen queue, this could try to recurse into the block device to
>> reclaim memory and deadlock.  Thus all allocations done by a process
>> that froze a queue need to be done without __GFP_IO and __GFP_FS.
>> Instead of tying to track all of them down, force a noio scope as
>> part of freezing the queue.
>>
>> Note that nvme is a bit of a mess here due to the non-owner freezes,
>> and they will be addressed separately.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> All sparc64 builds fail with this patch in the tree.

Yep, Stephen reported the same yesterday. The patch is queued up,
will most likely just send it out separately.

-- 
Jens Axboe

