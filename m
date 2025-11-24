Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476502FE598
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763985011; cv=none; b=FVt+Ai/meD6yIQ0CFLFKT6qXOC7zA0fkYT3+x2dvgGfj9zkqRgjGgVexOWMCpiodsTPEdVL7vPjKsWtbIVJHi1/lEYh64zSWdXezMjYAhG0AAR+zw6+l1GiGrYi00IVT7Q0RwOEfbY4xawQcVj7GH0g3VtVsgCsDVMgbxdP0ljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763985011; c=relaxed/simple;
	bh=Bhfx13V/1EPFjWbLYI/1+XVplSCwXJzEc0+7lmCEVe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MCIC/97L+CLeJr/+MMzfIHx0/lkIi/PEN6KTyooNzYS7D8O0P/bZYL78vxPsmnlZWeR2rhukrIU+hKYlavxZ0vTz+rDL4wXXxcOHxZeFiO3AN/zQ5OjpFA/PM/t/oyw9EfZD/HyB1u4+c8CuC8n7FfPzHfwT25jQP72yWwmH5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StCCPArf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StCCPArf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763985008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4Kg/QbITEpZ84Ri1lo2OpOJ/42qXgqIwDaIIHXiNpQ=;
	b=StCCPArfhJmgGWyYwZbOqMaJLf+rl/3jUm+xUqjFewsD0Ne389G0L0c7LEC6KiwC8fYOK/
	gnmW9OZZsu1QX5zrs/+P3JvwpDBXuY65HVazK/u6sKWN+GXAxOo4II3D3+mXXl/hPRy0cI
	hz+5XPIMcxz53t2NzFSaPqaqn5t6b/0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-KuCFTJOrMkeripCB6UcXbw-1; Mon, 24 Nov 2025 06:50:07 -0500
X-MC-Unique: KuCFTJOrMkeripCB6UcXbw-1
X-Mimecast-MFC-AGG-ID: KuCFTJOrMkeripCB6UcXbw_1763985006
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-640b8087663so6589833a12.3
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 03:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763985006; x=1764589806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4Kg/QbITEpZ84Ri1lo2OpOJ/42qXgqIwDaIIHXiNpQ=;
        b=uRJvhk9TDb6fevIz5PQrBBRysXrOx3ppCxFcAupfeCNfCnvtup3P5GDT8YPHlVnIlT
         6KyVEPrng3GwzNFll/Jc+tuckxGcifvg7TTmSS8KPjG5p1FXfR1SV8O8ZEr4PrK51UvJ
         ax7uWiNQf7mdwxBVSMyvHegop3DYPVP4FqDh0WMXUhJXZwRP0ulIZq7Vx1wsPqJ6o8WH
         ZvDZbOgt+cUT3wYk8JvmxakWYvkt4QOVunD7SIUKnXatE5IcN0VReTEn6ZC4RNz2CrXT
         pJpib0GVcd56bLhVXakxjAIJJRQynLI7eu4/zwmjOzt7xLgRXYL1RKKV2aG5lHyUWqsG
         j7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZNd7/hDrLT6KbAzt6wI13nsV1zRAtbnW0Cu1kz6a6vRMVMa9loMKWle8l5vuQV+koGEvs8nJ8vw9lRZE4nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUXyBciiVZiIwA404zwCtpJ8FgPq8vneKSr45dvBKlXRcGN4+q
	6Qy8CXTwGN5RvU1rqZCgFMqxfJE/hebe9RaWQt8XpLpJCZx7rJaPYEgJj88Qv/NtACLLgE12sls
	7Wfy7y0mmwpd9n2u8p4ytO1a4lzthg6NiFlZsButZoP5jg4EXn64BXCsTxG7yLhF9e/dy
X-Gm-Gg: ASbGnctuM4UuwvWvSTtU95kp0TDMtNVQRJIC6BnK49CXwjc/nHPNiP24o4TVtFpcjoe
	PuaLzsVYFlTzhXPR6VNwt5XHlmHZrZeiz3uIx/ZqjCM9lwYZeKU4gkbnXxTcbAHAcXLyVbPqhzt
	bCgVchmFxDi3QolsoyfIzKXR76RxHtMwsftA13e+vBpCmWbNiARV42JCe0hXTGNvDvaFf8rLHjm
	JwNkvNWw5zPWUh+30Q8DSW8Ue5f/zRNyMtqEZ0k1Mlw/mzdxVIwldPtRNijvR4F6IyOW1XYZMEN
	qljvV7AQKz1Q/+JK5WMGod220uCewHhMUffyt56wboOJAPH1KifrkekZ4oSmi+ZjFxagMEOE1ct
	UmR20wJ2rSX5jriOmfjq87k3KEFMq5IE0h71EdOZN6aV1kQBKbg9jNdX9x/HiLg==
X-Received: by 2002:a17:906:9fcb:b0:b76:3397:cfb5 with SMTP id a640c23a62f3a-b7671a17153mr1396872366b.58.1763985006384;
        Mon, 24 Nov 2025 03:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrAsnNU59J4LdNJ/Blq3Kbo6ZrloTHMBy4gsInF2R9s60UpJ8zgkaM/qwmrjZvMM9522v2ow==
X-Received: by 2002:a17:906:9fcb:b0:b76:3397:cfb5 with SMTP id a640c23a62f3a-b7671a17153mr1396862566b.58.1763985005019;
        Mon, 24 Nov 2025 03:50:05 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7cb3bsm1286766966b.27.2025.11.24.03.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:50:04 -0800 (PST)
Date: Mon, 24 Nov 2025 12:49:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Message-ID: <pstj7youxwwrpj3bl2a76kh2t62by2vdakv5elqvueobw3o4pj@tnknzlqdt344>
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
 <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
 <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
 <663yvkk2sh5lesfvdeerlca567xb64qbwih52bxjftob3umsah@eamuykmarrfr>
 <1b2255c7-0e97-4b37-b7ab-e13e90b7b0b9@rbox.co>
 <06936b55-b359-4e3d-bec0-b157ca32d237@rbox.co>
 <fy3ep725gwaislzz6lyu27ckswp2iyy5gj6afw6jji6c3get3l@lqa6wpptq5ii>
 <69a3d223-dd95-43df-af3a-522968d6b850@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <69a3d223-dd95-43df-af3a-522968d6b850@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QnCjvhe4OxrIOS3HPHGznZOMyMrpk8zTugIfhb7Xgeg_1763985006
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Nov 23, 2025 at 10:46:22PM +0100, Michal Luczaj wrote:
>On 11/21/25 10:21, Stefano Garzarella wrote:
>> On Thu, Nov 20, 2025 at 10:12:20PM +0100, Michal Luczaj wrote:
>>> On 11/19/25 20:52, Michal Luczaj wrote:
>>>> ...
>>>> To follow up, should I add a version of syzkaller's lockdep warning repro
>>>> to vsock test suite? In theory it could test this fix here as well, but in
>>>> practice the race window is small and hitting it (the brute way) takes
>>>> prohibitively long.
>>>
>>> Replying to self to add more data.
>>>
>>> After reverting
>>>
>>> f7c877e75352 ("vsock: fix lock inversion in vsock_assign_transport()")
>>> 002541ef650b ("vsock: Ignore signal/timeout on connect() if already
>>> established")
>>>
>>> adding
>>>
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -2014,6 +2014,7 @@ static void test_stream_transport_change_client(const
>>> struct test_opts *opts)
>>>                        perror("socket");
>>>                        exit(EXIT_FAILURE);
>>>                }
>>> +               enable_so_linger(s, 1);
>>>
>>>                ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>>                /* The connect can fail due to signals coming from the
>>>
>>> is enough for vsock_test to trigger the lockdep warning syzkaller found.
>>>
>>
>> cool, so if it's only that, maybe is worth adding.
>
>Ok, there it is:
>https://lore.kernel.org/netdev/20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co/

Great!

>
>And circling back to [1], let me know if you think it's worth adding to the
>suit. I guess it would test the case #2 from [2], but it'd take another 2s

If you think it is better to put them in vsock tests, instead of bpf,
it's fine by me. 2s more is okay IMO.

>and would require both h2g and non-h2g transports enabled.

This should be fine, IIRC we recently added something to check
transports and print warninng or skip tests in that cases.

Thanks,
Stefano

>
>[1]:
>https://lore.kernel.org/netdev/fjy4jaww6xualdudevfuyoavnrbu45cg4d7erv4rttde363xfc@nahglijbl2eg/
>[2]:
>https://lore.kernel.org/netdev/20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co/
>

