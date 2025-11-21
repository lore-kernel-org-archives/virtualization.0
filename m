Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548D2F5462
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716879; cv=none; b=AU0ccsRKfVTWmPTadkaPq08euO0V614vfNQyF1/PaghYwzLAnTadotk0XczyR0kAqBEFVM2aAuAkQey5dxsF8nvpXLLv3FQKV+XXpEBcR1hVB5/ZXxC1VMqpIQEyMrq7GRnhQDKfQXQVm9kIfhzn4nWF+ZPI/JTof50WwHb02VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716879; c=relaxed/simple;
	bh=88bzWzZsrFl3P0XuSIsfcAZAJYQYQd2cXTWkuomn7dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UpmUvPHJXFx/EdVuGYTR+Q1xgU+NqoHb9ruG7ZIuYvoMZlzHUhRXcjaAUM315E4KCyXxrQXbHNZO213Rn0LE/At+Jy9CX/dFzxHb6KX/hcGyKQeVS1nCwQJKkPRe+MGy2Jdj78Ua5MXNSWQXYseWqVqrG7L885lJGbNSijDkX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXuioNGD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXuioNGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763716874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FTcna51xyD4gkYI2wkOSx2yGaNSja9/HdHczSqaL88Y=;
	b=cXuioNGDJ6FI/81d4hLZMAV0XRx8iLTE0pMEhFpbMY5ePyPoYp/DYAytDhyBlFia7xtHUB
	KkXvZSsA/vkUjvO1ri1EDN6kH3UhMTtueH269n3S+Iy4mjJwkBoSymTiAWSFRnuwC4Erb1
	rKcs0J0PF+++Zf+4NkeyLBLc/Y2hCjQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-NHrwzuR2P_6Jr2w30vg9nA-1; Fri, 21 Nov 2025 04:21:11 -0500
X-MC-Unique: NHrwzuR2P_6Jr2w30vg9nA-1
X-Mimecast-MFC-AGG-ID: NHrwzuR2P_6Jr2w30vg9nA_1763716870
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b76778e621cso22555866b.1
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 01:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763716870; x=1764321670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTcna51xyD4gkYI2wkOSx2yGaNSja9/HdHczSqaL88Y=;
        b=dTlR116HVXpHek+QEHwH+L8pAZRAlGKTHlgg5yXdryjrvFtlbxAklg5VuX4Y0L8z3w
         UQDkyGRhT7CGBPXb5sP6xp6wfoFifwO0vl1Uzxc+1cvXOJS7jN0Du43CCIu2kiBY+fxV
         95FFjKkmuu7lsUM1gvx7AYcJ7/0EiTlWTuNcIMJqYCvEXHWRpC7iWGa7Rj0kZW5KBfSL
         C5GWHAauoAyN+iAQ6Q8PCPhrriVPt5vWnN0bKf6mE9f0c/npEMB/hZ9w/d+naChWP+4u
         gEP07UDD6Ycnt0gupxmJwbOVDg6S4lh2GbThmd6XstRxvz5ewZhTU5eribPJ99zouNCi
         xZBg==
X-Forwarded-Encrypted: i=1; AJvYcCVoK7ULEqZCKCYxD3xdrD41iXAZr6NgiFD+PXUisQnVjFLbzgo62J+hPaFZYzEPGfXoQ44VHCyzHgXT+fCdTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZNc++LGr121n19sUGF84smV7mfi2Yv0spWzW/CLk79LUG+xc0
	R9sf/3qYrH+dXbEpJT164ojYEBDJEL843onppk6bi/MonYdypnlMGIgdi11P+9nMpN5+Ws5SZd7
	Y6d7OIMEkIGiGtLqmOuHdoQx3eh/+RKdvkdyKeveTM1xNr1xdE8KlKI8rvDBxtM7LSA58
X-Gm-Gg: ASbGncsgkZajljf996T81rbtyEzHz4io8yZFd7mbpwKnbmXQd4PtYU5UNq8d8piE3sS
	bGxECoaJLeF4/1r4JYq5fP7RDKsStEsx7YDTgSNOjMAP/5+SeHUEXC3yaeLZES8FjEwFX687vOr
	DnsH9mZa52vddFZghZwNHgUTgZa3/6avr77k2cVZPydesGn4+OQ0CPkVjMTdCTtAkVGHLcyAFkd
	YmXxQMnHn8+q63SgTaVns13A9BQJqv0qOMTco0w6nGIeLxxcbExpazgeK1W42FAmsOkQ2cir526
	h/3ojdJezD8Acp/oW3tmbTNHfsOBlHJ9BHizKOGyiMMtQPS0pHIEEjEGThcR9G200SCf/SPVCuz
	ZgUjRhObm4bhAa99YFNpgxtM7hM6mDlz3HWe8Ab6cIgHRnB11z6ojzAbgSJ+YVA==
X-Received: by 2002:a17:906:d553:b0:b04:48b5:6ea5 with SMTP id a640c23a62f3a-b766ef1d27emr179098866b.17.1763716869720;
        Fri, 21 Nov 2025 01:21:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGy2fwvK+Qkff9FcCdDI2UgofRL9rFpwVTJ/zBHtBRxPZJ5JeGTjRIY7myDBG6TkqWfVfUsUQ==
X-Received: by 2002:a17:906:d553:b0:b04:48b5:6ea5 with SMTP id a640c23a62f3a-b766ef1d27emr179095566b.17.1763716869171;
        Fri, 21 Nov 2025 01:21:09 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765504828esm406198066b.64.2025.11.21.01.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:21:08 -0800 (PST)
Date: Fri, 21 Nov 2025 10:21:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Message-ID: <fy3ep725gwaislzz6lyu27ckswp2iyy5gj6afw6jji6c3get3l@lqa6wpptq5ii>
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
 <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
 <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
 <663yvkk2sh5lesfvdeerlca567xb64qbwih52bxjftob3umsah@eamuykmarrfr>
 <1b2255c7-0e97-4b37-b7ab-e13e90b7b0b9@rbox.co>
 <06936b55-b359-4e3d-bec0-b157ca32d237@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <06936b55-b359-4e3d-bec0-b157ca32d237@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9gEd3iCK2F4QJqfiqobMD3u0F6P6CquW0QsxHsbx2kE_1763716870
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 20, 2025 at 10:12:20PM +0100, Michal Luczaj wrote:
>On 11/19/25 20:52, Michal Luczaj wrote:
>> ...
>> To follow up, should I add a version of syzkaller's lockdep warning repro
>> to vsock test suite? In theory it could test this fix here as well, but in
>> practice the race window is small and hitting it (the brute way) takes
>> prohibitively long.
>
>Replying to self to add more data.
>
>After reverting
>
>f7c877e75352 ("vsock: fix lock inversion in vsock_assign_transport()")
>002541ef650b ("vsock: Ignore signal/timeout on connect() if already
>established")
>
>adding
>
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2014,6 +2014,7 @@ static void test_stream_transport_change_client(const
>struct test_opts *opts)
>                        perror("socket");
>                        exit(EXIT_FAILURE);
>                }
>+               enable_so_linger(s, 1);
>
>                ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>                /* The connect can fail due to signals coming from the
>
>is enough for vsock_test to trigger the lockdep warning syzkaller found.
>

cool, so if it's only that, maybe is worth adding.

Thanks,
Stefano

