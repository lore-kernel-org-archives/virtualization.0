Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DF204C36;
	Mon, 29 Dec 2025 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767037252; cv=none; b=Tsg+ggG5ea9addHZ9v4qjhEcmolVLkJxxCmTGZnqkeufDPh2RoIjUpe5dqgtWg8RaUPGXxkeAv9wnSJnjJjgWSw7IXbNxc+Zar8XYZVp72hd+nv82PJCehHJ3C8CcMnxm9Kq4tuu9FcbQA3sH1rjV4IulbcghV33AC8eHdu4b8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767037252; c=relaxed/simple;
	bh=3FxapXkLxdf/PMsz9yaDHCSgAZk60YfnbYIDvlaT1Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsC/XaiefMni0hqwHkjADaUxS+s9wqOXdHX4dBX/ZVkB8oAliRZryPf0WfxohRpe8K+4z+QZfQCkOqrNRvSBQaVmwNbQNOoMq4WOGE79FKaavEUeRBVaAIYxXrrbmqw0601fn4mLGnFkA8uA6GPCvSz2aLjwaSEZnjMiLr31idw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=esazk0vj; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="esazk0vj"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vaJ6U-00DYJ6-Vu; Mon, 29 Dec 2025 20:40:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=UExefshQVQAOSU2HaTtm9BnCYxE55bmxAcyfp3Uz3pk=; b=esazk0vjx7gz60zsNrttL1U/hf
	9qLF8+Vm/WSpxnlXFAGVtb+LJINgHFHqwNjiZOuPBx6KFTCgrgTtMZ5bxlF4ySW380B6sRl10mKBJ
	eziSuh9e1JifUhCo+bzb/Gon3tPZlTwUTl5Abcv1damOAlOQXkw+2d6vg6JAtkKuUGbYqckEtycY0
	LfBCB7JVnETXgKkUv7qA6zdfh966JijUlt+b2j+QUgPcR0d+AsQBRAYNF4DUgFS4SQ7drFZhjmmnG
	RdPzDI9M5qnLLW3Omez7Zrk24Re4eSTHc/dGyCNSSI9z4CW0UWVdYOTPHaoQxXoQ4ifNU0ZZZHN78
	LsLLSkMQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vaJ6T-00009U-Ps; Mon, 29 Dec 2025 20:40:30 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vaJ6O-005APE-Lf; Mon, 29 Dec 2025 20:40:24 +0100
Message-ID: <645da2e4-28fb-450d-8f9f-7f025df463df@rbox.co>
Date: Mon, 29 Dec 2025 20:40:22 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
 <aUpualKwJbT9W1ia@sgarzare-redhat>
 <1c877a67-778e-424c-8c23-9e4d799fac2f@rbox.co>
 <aUqWtwr0n2RO7IB-@sgarzare-redhat> <aUrIDT-Tg5SpXhlO@sgarzare-redhat>
 <8b76f6f8-3f5c-4bea-8084-577712ec028b@rbox.co>
 <aUut_Avq3t_xk0Uh@sgarzare-redhat>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <aUut_Avq3t_xk0Uh@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/25 10:15, Stefano Garzarella wrote:
> On Tue, Dec 23, 2025 at 09:38:07PM +0100, Michal Luczaj wrote:
>> On 12/23/25 17:50, Stefano Garzarella wrote:
>>> On Tue, Dec 23, 2025 at 02:20:33PM +0100, Stefano Garzarella wrote:
>>>> On Tue, Dec 23, 2025 at 12:10:25PM +0100, Michal Luczaj wrote:
>>>>> On 12/23/25 11:27, Stefano Garzarella wrote:
>>>>>> On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>>>>>>> Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>>>>>>> handled by vsock's implementation.
>>>>>>>
>>>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>>>> ---
>>>>>>> tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
>>>>>>> 1 file changed, 33 insertions(+)
>>>>>>>
>>>>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>>>>> index 9e1250790f33..8ec8f0844e22 100644
>>>>>>> --- a/tools/testing/vsock/vsock_test.c
>>>>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>>>>> @@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
>>>>>>> 	close(fd);
>>>>>>> }
>>>>>>>
>>>>>>> +static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>>>>>>> +{
>>>>>>> +	int fd;
>>>>>>> +
>>>>>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>>>>>> +	if (fd < 0) {
>>>>>>> +		perror("connect");
>>>>>>> +		exit(EXIT_FAILURE);
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	vsock_wait_remote_close(fd);
>>>
>>> On a second look, why we need to wait the remote close?
>>> can we just have a control message?
>>
>> I think we can. I've used vsock_wait_remote_close() simply as a sync
>> primitive. It's one line of code less.
>>
>>> I'm not sure even on that, I mean why this peer can't close the
>>> connection while the other is checking if it's able to set zerocopy?
>>
>> I was worried that without any sync, client-side close() may race
>> server-side accept(), but I've just checked and it doesn't seem to cause
>> any issues, at least for the virtio transports.
> 
> Okay, I see. Feel free to leave it, but if it's not really needed, I'd 
> prefer to keep the tests as simple as possible.

OK, dropping the sync here. It will be interesting to see if it ever blows up.

...
>>>> In my suite, I'm checking the client, and if the last test fails only
>>>> on the server, I'm missing it. I'd fix my suite, and maybe also
>>>> vsock_test adding another sync point.
>>>
>>> Added a full barrier here:
>>> https://lore.kernel.org/netdev/20251223162210.43976-1-sgarzare@redhat.com
>>
>> Which reminds me of discussion in
>> https://lore.kernel.org/netdev/151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co/
> 
> Oh, I forgot that we already discussed that.
> 
> My first attempt was exactly that, but then discovered that it didn't 
> add too much except for the last one since for the others we have 2 full 
> barriers back to back, so I preferred to move outside the loop. In that 
> way we can also be sure the 2 `vsock_tests` are in sync with the amount 
> of tests to run.

Might it be that we're solving different issues?

I was annoyed by the next test's name/prompt being printed when the
previous test is still running on the other side. Which happens e.g. when
one side takes longer than the other. Or when one of the sides is
unimplemented.

How about something like below; would that cover your case as well?

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index d843643ced6b..5d94ffd2fa82 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -495,7 +495,7 @@ void run_tests(const struct test_case *test_cases,
 			printf("skipped\n");

 			free(line);
-			continue;
+			goto sync;
 		}

 		control_cmpln(line, "NEXT", true);
@@ -510,6 +510,9 @@ void run_tests(const struct test_case *test_cases,
 			run(opts);

 		printf("ok\n");
+sync:
+		control_writeln("RUN_TESTS_SYNC");
+		control_expectln("RUN_TESTS_SYNC");
 	}
 }

