Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B23F5BD8
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226924; cv=none; b=L4KnQLI2tz0BzAohHN+Tz4a3QiDESXDILs06rFiR/L9zGxYGk1bHl0KDKrF21RJK/MjA4lyvPRYtyzTGvAaWaZ04J6tj7BMo4pOaw9ghcgRALqeAGHPd7ZhSAggN3cnztMD8LnoaVHSWldfFC/vzqO/f6Xvb+oYo5xOJBWyTKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226924; c=relaxed/simple;
	bh=743zbxPSWY9LXSLECHD52e5NJjTvQZ1kd9uEZiehS3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EJuE0U+u8Ds175fVjyRVKkqjxGyZT61JI97Lk0FMW/NVWm3nUUJn5jSAsNotogXXE4GSO9A95tZf/baDoB+mFbG0PLUUbYaJJFmCxUSmjGxzfOmAMaiYTCInml7X+bQ5dCfsgwOMLNjhmj7OBZeB5jxGVmnmP/1bAePHwMLUprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQdpQttU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQdpQttU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785226921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7L3Oa6yWKDj9Irs9koCNMMfNBAhfRI7uo2QmecVaVL8=;
	b=CQdpQttU3iUMQSugN1i80ue1iagmx98L/x9zYG+nVRDxqg6TEJfYaejS0BN3wcD7JI+qUA
	HySB2ib7rIOF5sfGoXn1B2YicJyIJDjYW6nbSmsEcLaw8Q/35ntae3I+OwkYkgqSTvhbxD
	v4K5i1COgTxGl50GRHR0B5YH2ozplDY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-UtcDGitpMtCz6CvcHRnuLg-1; Tue, 28 Jul 2026 04:22:00 -0400
X-MC-Unique: UtcDGitpMtCz6CvcHRnuLg-1
X-Mimecast-MFC-AGG-ID: UtcDGitpMtCz6CvcHRnuLg_1785226919
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4740be00302so2843815f8f.2
        for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 01:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785226919; x=1785831719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7L3Oa6yWKDj9Irs9koCNMMfNBAhfRI7uo2QmecVaVL8=;
        b=I5UV3NyLCcxHv6PohUxAn7vfO5D0x/x/+BOk1CDxrytPdMdNkMnLEkA9UWzNd4Jh5y
         eTh3rUqB0+YmHD/SXLD2rDHrDpVqRNfYyGTzR7ojq74VNj9YY/y6XGSkoq5+U5kQ/gnd
         muvjz1SFKPE2DnuB9NxNN78wNYubBPEsVqelZW7LgTSRw6c1EFPdaj6B3UVu8pDAP4sR
         5rbOctIuLHOZCQauESU7NeUJehpIt3+r+CKmzuSieH0LqgfzbdKGJZJeBakNzkB+ugXB
         GAhjx93CC989f3Yn79nwWJETeuCUZkWJVBjMf/SgfOa8hEOghqeKsEgFxyd2oLtcQK4c
         QyyQ==
X-Forwarded-Encrypted: i=1; AHgh+RowF9CCSadN5YBkgdLzSDYCimOlP00cZ6p6XMQ9BK/gznuoYKCSP6SGurLQqmnjLnhaHpMOydEK2PiTfCN+1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKFILrC5GD6DeynwH3bi0LOM84xIqwAHVwmr5zf3hnrI/vdgYr
	F9MXk9xs5gh070qaAw9qOOXtUhn+5fcri+PFG0U8csZlTDUH4a3xWzX6PkvC3SZJb7SZM5Qo2dH
	IQdhH5bwyWMVyY8GWl//RGuPt3nEfnHL1h6s7lJnjA0E5Ds92jSz1aWgFmk/7+KxFNpOx
X-Gm-Gg: AR+sD10dYLkdQXSw4tkFu4VA4QUhyWxYz2+J3Tg+qS5F166yzVxYVRsoKoqyl26uYPF
	z/YiaDOycUeXHahqRwWhT1iuDYyyUdR8hlQncZJ17orUwJWkBsyTJ1izuN8oWoGxet5x/Yl9lSI
	7T11YUVvEJ+QZH0kWbkloQvQob8TG+yW/4ZU7ggHg48n9IzBn1fsguBS9myvGftl1/+82qyeIXB
	0Pm20M3RBECW3pLvQa67dI4SXs+spECTvZFCpRk7+y7EXAAdob+od4ptpXPIy+UlJt7hT5/fq7a
	urt+tGmuHKLEnKKJU/QXWJwF5oeAAGCkERz5UtCfKefqwXqNHfq32MQARZ0o0N5ZO75IX8YvXi1
	t79hlHSBIMowdyJW1HJ3uUYHnnVLeTbxRWxOAAZGSdlk=
X-Received: by 2002:a05:6000:1889:b0:475:f0d1:eb56 with SMTP id ffacd0b85a97d-47fb1eabd10mr1428741f8f.49.1785226919043;
        Tue, 28 Jul 2026 01:21:59 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:475:f0d1:eb56 with SMTP id ffacd0b85a97d-47fb1eabd10mr1428707f8f.49.1785226918560;
        Tue, 28 Jul 2026 01:21:58 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f939c1465sm41353599f8f.26.2026.07.28.01.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 01:21:57 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:21:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Message-ID: <amhmjLa9DjNFKgmb@sgarzare-redhat>
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b7KhyhB2xH4z_3hlVx6OStd1CCrCDgdIxu2edbxmB1A_1785226919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jul 24, 2026 at 03:34:23PM +0800, Nguyen Dinh Phi [SG] wrote:
>On 24/7/26 05:43, Michal Luczaj wrote:
>>On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>>>...
>>>>>>>Yeah, we need to handle that part better, I think it's a leftover when
>>>>>>>we generalized AF_VSOCK to support more transport than vmci.
>>>>>
>>>>>Speaking of leftovers, I have trouble understanding where does vsock set
>>>>>sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>>>checks for it?
>>>>
>>>>I can't also see where it can be set TBH. Should we remove it ?
>>>
>>>I couldn't find it for listener side too.
>>
>>Removing sk_err handling from vsock_accept() solves the problem, right?
>>
>>thanks,
>>Michal
>
>Yes, confirmed, removing sk_err checks from vsock_accept() does solve 
>the problem.

Okay, so maybe better on going on this direction. WDYT?

Stefano

