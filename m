Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF2330B20
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766567786; cv=none; b=RCuLULXpNYBIHRkpSXQ09ROV4V6cL9eMNSghOY+BCgGVce78OLJ9UvDp188V7fjtttBjNZpeZrVN3NOkip6G6eCPD2bbnHO118FJ1pmrepC9R7BmeHq9VgGGkUabskG1ibJD8E6GQoC08JIAVMQyq/Cv//1PbEWr9NH9Z3yDVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766567786; c=relaxed/simple;
	bh=W5FPgoGpUmgPhjWL8T1Mrolt+NR9LunlkkjtHM6j/dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u6Z1G9gWgezzwQ+7zbRlbAgP5OpvWyKkGGC7d/NBhPPzjsWN9+cKnOArT9X3X7j+lS2zaobMEHroljUs9zNxUQdfOGZwoxzslyfKxRDR+KXsJnhPp82H4iijhXE7nNKP7lpjcEWzXWuFHJemQgxRp+UNwGhCimV+LBFHm2/rf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bz9fe//q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bz9fe//q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766567781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TG9qFMYYZ4oH8GV5uabpqY3JSsJR+DkIvS2mHVZ4zRo=;
	b=bz9fe//qYTWbpmllI4vQrIzc2P+mKeHgcnDdJdGLvbp3gkJbCKCdmfqeZT9lsNV+dPTUDN
	uwCWHU0VndWzfokrzOJrRgjuL6odF9O8ZNHMzwB74e49Rzn/m2ZB1skimd/JzkaZAHXrgX
	Mt9yibscDzSKzxSVXdUOsPLZ2gBblT0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-akNUmb24NAaYnGPchweTAw-1; Wed, 24 Dec 2025 04:16:19 -0500
X-MC-Unique: akNUmb24NAaYnGPchweTAw-1
X-Mimecast-MFC-AGG-ID: akNUmb24NAaYnGPchweTAw_1766567779
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b7a7049e202so314384466b.1
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 01:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766567778; x=1767172578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG9qFMYYZ4oH8GV5uabpqY3JSsJR+DkIvS2mHVZ4zRo=;
        b=GLMbJvUgwJQM92guo0oI8wH/CgzXXJEGq3mQ+uvyZcVXc5j3qQoinfpmOLxzGqLAyH
         Cbf1NkRilG8IIL3Fy5Tcy6M82kL3hhVWj8s35Sd0F5mD5mYmlP2HIxI4gP0/wkcf4G+g
         55aT7NDcLNzd+12e+2aOyr0V32pH8fMVJMBDmWZx/EFU5YAAZnqutaloHaWkF+weCPnw
         478Ee7JcjXRYu8kPQfKu4RSV7dqWsoCpbf3mL/7pKv9cC2ny9zw0exPyc+K9cVc/hpwa
         V5oshb6eZhmgOSTlRAIBUZWkQCQMVK3BatpkQ+1e4k4riFFAXOPfq3FQrOp9FMWu8oNE
         bqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKtM6xd6KRYTdCvZP6HyzBwqku7YBiiQiUeg8AVdUgAMGP2pDEQsY9m5nUOpD7WvtJqIkvuEID1f/Q59HHmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXh7qF3hYVEtjuBUC+SkCDop3BcGmboK5b2jNog2NHrFPd1vdw
	E1KaNFv5PokOWXRDcO1p/vEWYOeshVPIrmBpg8UjTCGhJPU19X3+BH9jzAeyVr1882THT+pfw3C
	ype6NRRxa9kow8V8DN+ibyMuvny4G8meOaqyKrOnQerPN0M/ytZFDZvHlxgSt/LhF2MBX
X-Gm-Gg: AY/fxX7n4xyPesJ4GZgAcbX2B/eyAsYczObtBgzmIOo2gWy0AVzWfDc4eH1bDJZhngE
	n6Gtc5aXmv7VOVYW9aENaPnHSiMljHP86YWlJSpLf9bYth9c9la0niE+B8slhDM38KBBD/c0Nxo
	BuGEltIjEd9waYs+agT5llKybpivbxdSdixsgIYYJP42ksjOmKxQyG+twCwQvpGr35bKaF/n5Ta
	vroWTv9WKMUaHhscBfpf1FMwveUcHfwnq1+Dopt5tlaSZJDAk7OdevwAR+gVttDpec/8isuYfv7
	m5NHWpkf81P/ZPEk9Qdfs3mL6AZ/nh4fxlsrxl+1whJwRE9FnwLpzx83wZ/FoYGDy5shqid4j5b
	E8iqL7Y/gCU2xiEON
X-Received: by 2002:a17:907:7f1c:b0:b83:976:50f9 with SMTP id a640c23a62f3a-b83097652a7mr168592966b.61.1766567778470;
        Wed, 24 Dec 2025 01:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2zROeUVFL1dzpYZqyjYvkN4o8L5fjhHfHOKDDCOidKMgMKBQP5VHD8MGw0Ju06pc+b5i0KA==
X-Received: by 2002:a17:907:7f1c:b0:b83:976:50f9 with SMTP id a640c23a62f3a-b83097652a7mr168590266b.61.1766567777909;
        Wed, 24 Dec 2025 01:16:17 -0800 (PST)
Received: from sgarzare-redhat ([193.207.144.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0cc52sm1685076666b.52.2025.12.24.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:16:17 -0800 (PST)
Date: Wed, 24 Dec 2025 10:15:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
Message-ID: <aUut_Avq3t_xk0Uh@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
 <aUpualKwJbT9W1ia@sgarzare-redhat>
 <1c877a67-778e-424c-8c23-9e4d799fac2f@rbox.co>
 <aUqWtwr0n2RO7IB-@sgarzare-redhat>
 <aUrIDT-Tg5SpXhlO@sgarzare-redhat>
 <8b76f6f8-3f5c-4bea-8084-577712ec028b@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8b76f6f8-3f5c-4bea-8084-577712ec028b@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BFL11aFvDm-Z5qOvgTwsHLhIknXMNGWY2rb7vzA_Pzg_1766567779
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 23, 2025 at 09:38:07PM +0100, Michal Luczaj wrote:
>On 12/23/25 17:50, Stefano Garzarella wrote:
>> On Tue, Dec 23, 2025 at 02:20:33PM +0100, Stefano Garzarella wrote:
>>> On Tue, Dec 23, 2025 at 12:10:25PM +0100, Michal Luczaj wrote:
>>>> On 12/23/25 11:27, Stefano Garzarella wrote:
>>>>> On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>>>>>> Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>>>>>> handled by vsock's implementation.
>>>>>>
>>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>>> ---
>>>>>> tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
>>>>>> 1 file changed, 33 insertions(+)
>>>>>>
>>>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>>>> index 9e1250790f33..8ec8f0844e22 100644
>>>>>> --- a/tools/testing/vsock/vsock_test.c
>>>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>>>> @@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
>>>>>> 	close(fd);
>>>>>> }
>>>>>>
>>>>>> +static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>>>>>> +{
>>>>>> +	int fd;
>>>>>> +
>>>>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>>>>> +	if (fd < 0) {
>>>>>> +		perror("connect");
>>>>>> +		exit(EXIT_FAILURE);
>>>>>> +	}
>>>>>> +
>>>>>> +	vsock_wait_remote_close(fd);
>>
>> On a second look, why we need to wait the remote close?
>> can we just have a control message?
>
>I think we can. I've used vsock_wait_remote_close() simply as a sync
>primitive. It's one line of code less.
>
>> I'm not sure even on that, I mean why this peer can't close the
>> connection while the other is checking if it's able to set zerocopy?
>
>I was worried that without any sync, client-side close() may race
>server-side accept(), but I've just checked and it doesn't seem to cause
>any issues, at least for the virtio transports.

Okay, I see. Feel free to leave it, but if it's not really needed, I'd 
prefer to keep the tests as simple as possible.

>
>>>>>> +	close(fd);
>>>>>> +}
>>>>>> +
>>>>>> +static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
>>>>>> +{
>>>>>> +	int fd;
>>>>>> +
>>>>>> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>>>>>> +	if (fd < 0) {
>>>>>> +		perror("accept");
>>>>>> +		exit(EXIT_FAILURE);
>>>>>> +	}
>>>>>> +
>>>>>> +	enable_so_zerocopy_check(fd);
>>>>>
>>>>> This test is passing on my env also without the patch applied.
>>>>>
>>>>> Is that expected?
>>>>
>>>> Oh, no, definitely not. It fails for me:
>>>> 36 - SOCK_STREAM accept()ed socket custom setsockopt()...36 - SOCK_STREAM
>>>> accept()ed socket custom setsockopt()...setsockopt err: Operation not
>>>> supported (95)
>>>> setsockopt SO_ZEROCOPY val 1
>>>
>>> aaa, right, the server is failing, sorry ;-)
>>>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>
>>>> I have no idea what's going on :)
>>>>
>>>
>>> In my suite, I'm checking the client, and if the last test fails only
>>> on the server, I'm missing it. I'd fix my suite, and maybe also
>>> vsock_test adding another sync point.
>>
>> Added a full barrier here:
>> https://lore.kernel.org/netdev/20251223162210.43976-1-sgarzare@redhat.com
>
>Which reminds me of discussion in
>https://lore.kernel.org/netdev/151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co/

Oh, I forgot that we already discussed that.

My first attempt was exactly that, but then discovered that it didn't 
add too much except for the last one since for the others we have 2 full 
barriers back to back, so I preferred to move outside the loop. In that 
way we can also be sure the 2 `vsock_tests` are in sync with the amount 
of tests to run.

But yeah, also that one fix the issue.

>. Sorry for postponing, I've put it on my vsock-cleanups branch and kept
>adding more little fixes, and it was never the right time to post the series.
>

Nah, don't apologize, you're doing an amazing job!

Thanks,
Stefano

