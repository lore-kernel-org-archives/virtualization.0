Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053E38228F
	for <virtualization@lists.linux.dev>; Fri,  3 Apr 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210670; cv=none; b=RZ+egSwjD+/ApsEep4K/FuclCzH2y6HctQh3Hi79ggtF7kBSeI2aLpuzfkwp50SxUkEHHnxHSDQJvlS9tlky5p9KNG3K0f1ut1MGrnWA2naHSmLw/hksprwqUna60Igd68wgRht8sJBKipDAFy9pWCMSsHQKTkwFeAuVn3Y59SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210670; c=relaxed/simple;
	bh=u074NOceth/+r9Ei9g2pssvboQrOKX4SPpJBbPS2SPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OqVizHbQxMjA4BrkiKgBbhR4GXe3+cZciJscoSk/PnOyAO9H8kF65rCIjNrxxQEWKKgDWa0Hz6MIM4OpeM2ayUNTGWoljYfwEaR01xFgyvPEklfB028t24l1/KNxaSDoGOe+36Wi7E2EJ+cAxLV5v0mZyeJTef1DFc9+d2HFVkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0aFu8t9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0aFu8t9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775210662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u074NOceth/+r9Ei9g2pssvboQrOKX4SPpJBbPS2SPA=;
	b=F0aFu8t92lwz9Y+5rNZKFnhw4JCHKbwRVziKjtOlvXW+Esx5AotEPkcPMvkzmuyQYFRgBm
	udnu5rS90f8YxpS0VMPC4QOYyY3iGFUvF5SVgXWMJ1y4+5OJDABzxqAdwrcDPat7aqgcYG
	H0UBM+CKv6JZG17Zew4Zs9JoIrAa+7E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-BG3M592nMaOUh08H2jJ25g-1; Fri, 03 Apr 2026 06:04:21 -0400
X-MC-Unique: BG3M592nMaOUh08H2jJ25g-1
X-Mimecast-MFC-AGG-ID: BG3M592nMaOUh08H2jJ25g_1775210660
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836abfc742so16777175e9.0
        for <virtualization@lists.linux.dev>; Fri, 03 Apr 2026 03:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210660; x=1775815460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u074NOceth/+r9Ei9g2pssvboQrOKX4SPpJBbPS2SPA=;
        b=sMcXlt1KgVpqI5iWixhqJN2OUZgtroUCbEvUFUOQ/d8ZHQinXp+d9sDZKwX4ZcK4Ri
         g50VFpVCjrHYEouqq4b3MZ9Ta3vPdp/gaZDWVxXg5vLLxoGGOBjEGixkFZXI8iKvtNiL
         GrB9nnqXbOVrE99z5jcJlSbQY/V3RIl25vZdlxJM/bRHxMd1MpGI3Z82eetcb5SI0w/0
         3n/UWRnmTu8XyvsAGPDDzCgoyPBa3S7euU95BUWHPiEfNlComZbjMJO8m48lSN76aX1N
         mmUTjl4G9CcMRGhqVpYbk4v3T0Av8SHnkB51zDcFkBvsVOqnt5VFCHNjYR+tz3/EHmjd
         Us6A==
X-Gm-Message-State: AOJu0Yw6+VGw4omNDi3L4V+/o4Ietvd6HX/qVTwarHmjBKwSz79AOr8c
	yiLdcieao3q4cGW+nie9DSbcjgZvx8SzV3ToBG6kBKuLCmXWA45aTU/8x8I+kuO5C/26qA42WuR
	rMaUQEuqEoFJdl3HWwUKuvJYxxc0v84R2PqCRechxPx2QeUqPyARHsKo8nuQKJAWBg00jzeCTWe
	l6
X-Gm-Gg: ATEYQzzWave61w5GNZ5Kk2xL3BEX9zUk6JL60RmslpVmoCdGx8MQd4P+ees+o1/41sX
	PwwbGaDKy5A3tfDRXH2Md9ZR0+CW+WN1gEs9Gx15jV4UfpexULTe1qdj3yFPgL64DDfTg7nfUmn
	xsrGnifZK278VKvYSkQUdlUeWDnJB22+wypxb2eVflzHwSiAlD9ofKs2iHuJwvlPI2rSIf0xfAe
	2xu96Z9/tU+Ip84utXzClPiygkFrSNAJINyY1PIoBpUk/7aeV7w7LEr/L5u82xy1drYxOkZKX88
	nG9SdwDPe1akVL+nd1WQEDIAgUGC0Pbai2jV24HiOnL7SojKV1wphIuVgHQLg3AbTJLthPLwOeE
	0EPSb4OlCR7PdqB0W/qSsj8vp3fJo9umu25eFBr0c9/k6dSf1WLvBDeMNTB0H0SYe4DQRHYFdZ1
	Ye
X-Received: by 2002:a05:600c:3e0c:b0:488:92a3:dd4d with SMTP id 5b1f17b1804b1-488997d32fbmr37461485e9.29.1775210659620;
        Fri, 03 Apr 2026 03:04:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0c:b0:488:92a3:dd4d with SMTP id 5b1f17b1804b1-488997d32fbmr37460995e9.29.1775210659150;
        Fri, 03 Apr 2026 03:04:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm335385945e9.3.2026.04.03.03.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:04:18 -0700 (PDT)
Date: Fri, 3 Apr 2026 12:04:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurence Rowe <laurencerowe@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH] vsock: avoid timeout for non-blocking accept() with
 empty backlog
Message-ID: <ac-QdDNhpuGuAzjr@sgarzare-redhat>
References: <20260402044637.73531-1-laurencerowe@gmail.com>
 <ac47PYPeL0IyRtY6@sgarzare-redhat>
 <CAOycyLTy=ZT0AXiwPrbEfyxX_ZZgwzaetKOqP9cNywTO1_wNZw@mail.gmail.com>
 <CAOycyLR-otKw4jTcNpo3pUBbDx9DVJyPU7b0T6uHib6mSrAvVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAOycyLR-otKw4jTcNpo3pUBbDx9DVJyPU7b0T6uHib6mSrAvVg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vu-D3o6K5QlOhbfmIMsCe14Nod5-z-GGagbsIrrzeQc_1775210660
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 02, 2026 at 04:30:20PM -0700, Laurence Rowe wrote:
>On Thu, Apr 2, 2026 at 12:22 PM Laurence Rowe <laurencerowe@gmail.com> wrote:
>>
>> On Thu, Apr 2, 2026 at 5:03 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> > >Scheduling a timeout for a non-blocking accept with an empty backlog
>> > >meant AF_VSOCK sockets used by epoll network servers incurred hundreds
>> > >of microseconds of additional latency per accept loop compared to
>> > >AF_INET or AF_UNIX sockets.
>> >
>> > Not related to this patch, but should we do something similar (in
>> > another patch) also in vsock_connect() or doesn't matter since usually
>> > it's always blocking?
>>
>> Looking at vsock_connect it's not immediately obvious to me whether it
>> is affected
>> in the same way. I'll capture some ftraces and follow up after
>> updating this patch.
>
>This does not seem to be a problem for vsock_connect since it checks
>for `if (flags & O_NONBLOCK) {` in the while loop before calling
>`schedule_timeout`.
>
>Timings and ftraces:
>
>https://github.com/lrowe/linux-vsock-accept-timeout-investigation?tab=readme-ov-file#a-quick-look-at-connect

Thanks for checking and for the fix!
Stefano

