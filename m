Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84F322DD6
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783232; cv=none; b=gq+XMYzZ9jku8G0oS06TGv+zwv97vxDLWbtM2/usg3tvCBpktOsUpbgRvsf7pZAt+WdI2sfTMJEZqEf0cGn3/vT+hkpgJbgZ+G7jAqEXsMwrK5QFXkTTEpGyJUCw9Xygdk8LwHPMzBZcxkVjSNmCIcb8/R/fAUug0IeNRf2RQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783232; c=relaxed/simple;
	bh=55n1cSL3RzUp+Q5C1c6SkBuw/bFY/z8iN5P6Sb319fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CEqVC/1Mwmlm2MM8UtHAnV/PYZcCa15EWkqxsDeKI6KictdjmKZDmmbpVHILlHzzoKDS8L/WBTuTJFK7i/+552Xv63WDUvrWEa1PVfOEGMCNKL1cdY+v7QEx6w8oE0zo/5VvwRqwUkSh6u069RcAjkEoAdJ4q65VUSTAhQQOzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfO8Hrto; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfO8Hrto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767783229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYUPRF5QDflfWYY7FinPQup3L+Ow2Q/k721sxPIn/mI=;
	b=NfO8HrtoZPHP5saQ9k8zs4DN7eSlPG+Q149JRS0MQ3lh02dUk/CkJXVMOOjySGP2Z6yyLn
	gXP2OW8ZYKxZWplLmY4IsQNin/tXtVrZw9qw2WQARQ0zguRyTolk0SEBnRq7ptEfrbpHkF
	O28h/vX7s+WHM58yLpYYPjKwF3nLo4k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-aCGE7s9-M7Szjzn8RofUOA-1; Wed, 07 Jan 2026 05:53:48 -0500
X-MC-Unique: aCGE7s9-M7Szjzn8RofUOA-1
X-Mimecast-MFC-AGG-ID: aCGE7s9-M7Szjzn8RofUOA_1767783227
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64d5bec0e59so2534860a12.0
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 02:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767783227; x=1768388027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYUPRF5QDflfWYY7FinPQup3L+Ow2Q/k721sxPIn/mI=;
        b=iBYX89wUAPhQGhWQjKnldgq2WVJyPYmm+yrUTXwqi+i5yC0kRxQvx+2oHO2S5ox4I7
         59/qu+eOF7cCUm0SceM1M1pIoWeT5n9yjB0dNFk9njvIn1XP5L/l4tBAxUZvg2LO+0Sz
         ei6oOQbZzvjiqIiB4le/3ecOY6oysw8eUyELDrLtpjOZR2K5HNYoaY2ZPOlqpuzalP1y
         +ja1fvhctqyVjk6yNFIcoRGf5vdjlM0nEgCq/Gh9AUmvQ3KkpMvLZT/XdI43M4hD7EUl
         8+NpcVUG6opiWu9Ghrw2rnq34cfXbiuING4Opbxl6y2ao7z5DhwH//TWstLbRoydS/B/
         1hkg==
X-Forwarded-Encrypted: i=1; AJvYcCXcjb0ztIB/3bfJh20Y3Vze3Ki+qhcLh4leKWn3oZScbZeb+L2tmNUIlXF0rl2+XaW6FXZlpqP1IlM6oqYJhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtX4HhPr14k5WfVckqieOlCK7hnyfE1qzUYscLQCIcckmfilQR
	liX+Gfj1xeA6H6njPynXPCEIvYLiDTL6/C1vXAB8TkfpyXV4yAehQeRmAW1KOD7HOdZ4XscDy5f
	/WvX061P6FOAtHi0c0ehuMF2KJ1TKgi9XaoJ8yteWL1bsBOQ6ijhQu9Q4JnE7DThdTaNk
X-Gm-Gg: AY/fxX57RB32lBuRMMtMBC6R77uL8l5gZhZFophAoo1+YRlw4WpB9NNxV5ygv8WWCu7
	YIt6rVJXfKUOsbQaDgKpOReOUVnNyyvbp9gac/QwBhoAF0sFzjFByWLLzL5WvGTQaRzh+UqyM1i
	CWVmSyw1xoDAQnnyaj7GD4CkqDZJRaA92oZ7vGHha4Yqm4xEtwYYPJvF2Xq7cqG31mHa6HNkEyh
	yKCHE9g/5vDDyETSZ9Sqo1rDZPk+MmGt+ilmQxQ+ahtDZo+bOzwSmkzxnYOCONu/vcH6wf0JL8w
	uU4PvgdQacChyB7SzORfF78SI5j1AEYOZ8sp6MxMEwDArn5bQnRD+FUDxG5XkhlZa8E7PVZUz4u
	ILKPo8gcgJHzeqLkA
X-Received: by 2002:a05:6402:50d0:b0:647:6ec9:8d8b with SMTP id 4fb4d7f45d1cf-65097e9aa86mr1889309a12.34.1767783226751;
        Wed, 07 Jan 2026 02:53:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYm/IAdg4XdEf7zZqf1O/V4KFAkDBQnvZqKSGcLVsWEOr/HfN3lfZry4wILVP7PFF5qBCINw==
X-Received: by 2002:a05:6402:50d0:b0:647:6ec9:8d8b with SMTP id 4fb4d7f45d1cf-65097e9aa86mr1889288a12.34.1767783226279;
        Wed, 07 Jan 2026 02:53:46 -0800 (PST)
Received: from sgarzare-redhat ([193.207.201.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d683sm4319286a12.34.2026.01.07.02.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 02:53:45 -0800 (PST)
Date: Wed, 7 Jan 2026 11:53:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
Message-ID: <aV45ihZSUPK7hk4I@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
 <aUpualKwJbT9W1ia@sgarzare-redhat>
 <1c877a67-778e-424c-8c23-9e4d799fac2f@rbox.co>
 <aUqWtwr0n2RO7IB-@sgarzare-redhat>
 <aUrIDT-Tg5SpXhlO@sgarzare-redhat>
 <8b76f6f8-3f5c-4bea-8084-577712ec028b@rbox.co>
 <aUut_Avq3t_xk0Uh@sgarzare-redhat>
 <645da2e4-28fb-450d-8f9f-7f025df463df@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <645da2e4-28fb-450d-8f9f-7f025df463df@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u50koC5rVYDEr--6xpDMNZ9DBfIWjcLdEdBcRTuzwRw_1767783227
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Dec 29, 2025 at 08:40:22PM +0100, Michal Luczaj wrote:
>On 12/24/25 10:15, Stefano Garzarella wrote:
>> On Tue, Dec 23, 2025 at 09:38:07PM +0100, Michal Luczaj wrote:
>>> On 12/23/25 17:50, Stefano Garzarella wrote:
>>>> On Tue, Dec 23, 2025 at 02:20:33PM +0100, Stefano Garzarella wrote:
>>>>> On Tue, Dec 23, 2025 at 12:10:25PM +0100, Michal Luczaj wrote:
>>>>>> On 12/23/25 11:27, Stefano Garzarella wrote:
>>>>>>> On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>>>>>>>> Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>>>>>>>> handled by vsock's implementation.
>>>>>>>>
>>>>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>>>>> ---
>>>>>>>> tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
>>>>>>>> 1 file changed, 33 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>>>>>> index 9e1250790f33..8ec8f0844e22 100644
>>>>>>>> --- a/tools/testing/vsock/vsock_test.c
>>>>>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>>>>>> @@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
>>>>>>>> 	close(fd);
>>>>>>>> }
>>>>>>>>
>>>>>>>> +static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>>>>>>>> +{
>>>>>>>> +	int fd;
>>>>>>>> +
>>>>>>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>>>>>>> +	if (fd < 0) {
>>>>>>>> +		perror("connect");
>>>>>>>> +		exit(EXIT_FAILURE);
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	vsock_wait_remote_close(fd);
>>>>
>>>> On a second look, why we need to wait the remote close?
>>>> can we just have a control message?
>>>
>>> I think we can. I've used vsock_wait_remote_close() simply as a sync
>>> primitive. It's one line of code less.
>>>
>>>> I'm not sure even on that, I mean why this peer can't close the
>>>> connection while the other is checking if it's able to set zerocopy?
>>>
>>> I was worried that without any sync, client-side close() may race
>>> server-side accept(), but I've just checked and it doesn't seem to cause
>>> any issues, at least for the virtio transports.
>>
>> Okay, I see. Feel free to leave it, but if it's not really needed, I'd
>> prefer to keep the tests as simple as possible.
>
>OK, dropping the sync here. It will be interesting to see if it ever blows up.
>
>...
>>>>> In my suite, I'm checking the client, and if the last test fails only
>>>>> on the server, I'm missing it. I'd fix my suite, and maybe also
>>>>> vsock_test adding another sync point.
>>>>
>>>> Added a full barrier here:
>>>> https://lore.kernel.org/netdev/20251223162210.43976-1-sgarzare@redhat.com
>>>
>>> Which reminds me of discussion in
>>> https://lore.kernel.org/netdev/151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co/
>>
>> Oh, I forgot that we already discussed that.
>>
>> My first attempt was exactly that, but then discovered that it didn't
>> add too much except for the last one since for the others we have 2 full
>> barriers back to back, so I preferred to move outside the loop. In that
>> way we can also be sure the 2 `vsock_tests` are in sync with the amount
>> of tests to run.
>
>Might it be that we're solving different issues?
>
>I was annoyed by the next test's name/prompt being printed when the
>previous test is still running on the other side. Which happens e.g. when
>one side takes longer than the other. Or when one of the sides is
>unimplemented.

I don't see this that bad, because this will show us exactly what is 
going on. One peer did everything well in its test function and it's 
ready to start the next test, while the other is having some kind of 
trouble at the end of the test.

If a test really want to be sure that one peer should wait the other 
(for some reason), should explicitly set a sync point like we already do 
in some cases.

>
>How about something like below; would that cover your case as well?
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index d843643ced6b..5d94ffd2fa82 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -495,7 +495,7 @@ void run_tests(const struct test_case *test_cases,
> 			printf("skipped\n");
>
> 			free(line);
>-			continue;
>+			goto sync;
> 		}
>
> 		control_cmpln(line, "NEXT", true);
>@@ -510,6 +510,9 @@ void run_tests(const struct test_case *test_cases,
> 			run(opts);
>
> 		printf("ok\n");
>+sync:
>+		control_writeln("RUN_TESTS_SYNC");
>+		control_expectln("RUN_TESTS_SYNC");
> 	}
> }
>

This was my first attempt, but except for the first test, we have 
essentially 2 full barrier back to back, that IMO is not really great.

BTW I think it's better to continue that discussion on 
https://lore.kernel.org/netdev/20251223162210.43976-1-sgarzare@redhat.com/

Thanks,
Stefano

