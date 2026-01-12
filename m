Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54937359F80
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225476; cv=none; b=iTasuKCEwspnucFZxhdBOBwXJZei1iK5nCz+BfXpOZgUpu5uIzAQcTNGTwTQnRnQEro8YGXqHfTqwiaBe3yA6dpNPhtjhGF21QxbOZDJL9AYRt+p3/i/v5fiZ/BZfEcNJzSJAbqs52rK7lUARQ55K2JnHafjOe9Vc6ej5q4BhyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225476; c=relaxed/simple;
	bh=DCCkMKE37W8wsRrMCbvNOdPo7w9XG07KVqWsm2N1Xpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hkWNnzwPNAgTDuFBJ62DfVpdQiqT/kHv09cN/e210ci5SvgUzzNnkXM3EvbbV9AH53mPJvGCxCyNZvVkDM726rxmQughZUugxFn01h8HMHxPGzjpS+uc980cWP/g76vUg+oMS48Ayyy91aUy5O6dXoHacMYCOjlXyk+2lmvh0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWUr2+59; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWUr2+59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768225474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GGW9mZKBtph9QlALl3Ep6OTQikES/GMT3cQq+RonefE=;
	b=AWUr2+59kaumIcEiBOCLbIFfzVrQtfWpY3tRIkWQDRUI8kjxlgvnw7zpvFhQjrKmsXAJ5J
	BCo0cFHhM9TNoTelVeUVsFoOaKumEJKsTm8RpxWMwZ/bpp3CcCenV4NnZVb0i4+a6NWpOW
	3Nr31bcTafrFcgwyO+hWk6O4i+Dr28k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-l5ctjI9oM5uQ6gkzwBR8gQ-1; Mon, 12 Jan 2026 08:44:33 -0500
X-MC-Unique: l5ctjI9oM5uQ6gkzwBR8gQ-1
X-Mimecast-MFC-AGG-ID: l5ctjI9oM5uQ6gkzwBR8gQ_1768225472
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so74667615e9.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 05:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768225472; x=1768830272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGW9mZKBtph9QlALl3Ep6OTQikES/GMT3cQq+RonefE=;
        b=cl6WQ5oqJxmXfA5oETaFchx6yvszvvUGgUCd0wRiNt+hjlaZTBfv2PHhBPGFaOhsZ4
         3avj8rep4Ny84GQd3SRTH1fTg9Y3aVMkMjMvaVbxijwcmTSTgrBlMhGX2eibP/AhBecZ
         c461xcWNNWhzv+gz//fH0vIcdmYIM+EmbipwPxwcJ2eEPU3YrBZZzES6DMetzDihr0MR
         BJ+Lx1HEm7C/8i2HTxGpozlvYAvPIlos4qazpQXVnC1I9bmzedar5DZjWjmHP+wx1fpA
         pDmf5FvzJHxEGXwsFcODiUYJobLvz5TgO8QnDRbYpkaffBGivCnZXZ8DOGx+GBySqll0
         bs5A==
X-Forwarded-Encrypted: i=1; AJvYcCXbaODgYAo+Vz6gYDdP4J73B7zxTwtZ15bsVCYfZj5F1oMqekGgDy7lLKG3c4JOs/mUHW9avVcW6LQA/fTRoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNa1CNT48tAa9rV2MRMNMruCd1kACWG76nW0hzfk662G3/tUac
	PNcqtRAlruyhFybUP9FZiwNFD00CGSqK+NsfmTwsPKEesMNqSAZAOZF86ajt47/hdnJfF8k/8kU
	9iJjIOQw6894eb+ZHU0L8GJ4C9LzJOH59R9xUm+YxC5QNYIX6tpG5VWHo/2DNNckei9UE
X-Gm-Gg: AY/fxX58RmKfKUclXw1cqQayi/Mq+ZdHMxGINHQIgyVHZSTIIRGt6aJFm4EdcD4TSGA
	mXq3ZgOZ/+q46V7Zm7xAEH0Wl/xoKjyAzVsOOPk/iMQXZL2Sgkxm/mIYqdOpnBHObWkqILypTKB
	Eo6uN/R0HCojt2JpvXuJLJ1eHdJVUx32Oqi86uHh110pNrvbD1igOOg/ElSaoN4gEOHOVNj1w3r
	FCdT+lPtqDDlPNoheZiVmZ4DVtd0dzqd5SRKBub8SBpEGmCtoIeHYoERj3dgOMB05GtZaRXTg7y
	tGjcXc2ZkHZcfguG1B8mQxS0ZV7l8hFi0hVjf7DK5wzr34D3+W4HU6QNMVXPslxlMsOuCz1sRC2
	xmOzbBPmPVvB+DlSnhCxsbfGWWY1CXEfz9pai3Iv07/AeH7LSKu2DW9iZDgXIyA==
X-Received: by 2002:a05:600c:8506:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-47d849bd201mr172455705e9.0.1768225471668;
        Mon, 12 Jan 2026 05:44:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm2s3Ka0LVsovFun71Z5V7/5VR95//yL24AIdoBztX46nKJnlOhC/MqZHEuukOdh9k4vo5Pw==
X-Received: by 2002:a05:600c:8506:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-47d849bd201mr172455485e9.0.1768225471211;
        Mon, 12 Jan 2026 05:44:31 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d286cdecsm25026149f8f.7.2026.01.12.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:44:30 -0800 (PST)
Date: Mon, 12 Jan 2026 14:44:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vsock/test: Add test for a linear and non-linear skb
 getting coalesced
Message-ID: <aWT6EH8oWpw-ADtm@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-2-26f97bb9a99b@rbox.co>
 <aWEqjjE1vb_t35lQ@sgarzare-redhat>
 <76ca0c9f-dcda-4a53-ac1f-c5c28d1ecf44@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <76ca0c9f-dcda-4a53-ac1f-c5c28d1ecf44@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZGbzt4heihoYW5ijF8t8tsl3u5oJSSWhmYsgrrGNHG8_1768225472
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Jan 11, 2026 at 11:59:54AM +0100, Michal Luczaj wrote:
>On 1/9/26 17:32, Stefano Garzarella wrote:
>> On Thu, Jan 08, 2026 at 10:54:55AM +0100, Michal Luczaj wrote:
>>> Loopback transport can mangle data in rx queue when a linear skb is
>>> followed by a small MSG_ZEROCOPY packet.
>>
>> Can we describe a bit more what the test is doing?
>
>I've expanded the commit message:
>
>To exercise the logic, send out two packets: a weirdly sized one (to ensure
>some spare tail room in the skb) and a zerocopy one that's small enough to
>fit in the spare room of its predecessor. Then, wait for both to land in
>the rx queue, and check the data received. Faulty packets merger manifests
>itself by corrupting payload of the later packet.

Thanks! LGTM!

>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> tools/testing/vsock/vsock_test.c          |  5 +++
>>> tools/testing/vsock/vsock_test_zerocopy.c | 67 +++++++++++++++++++++++++++++++
>>> tools/testing/vsock/vsock_test_zerocopy.h |  3 ++
>>> 3 files changed, 75 insertions(+)
>>>
>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>> index bbe3723babdc..21c8616100f1 100644
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -2403,6 +2403,11 @@ static struct test_case test_cases[] = {
>>> 		.run_client = test_stream_accepted_setsockopt_client,
>>> 		.run_server = test_stream_accepted_setsockopt_server,
>>> 	},
>>> +	{
>>> +		.name = "SOCK_STREAM MSG_ZEROCOPY coalescence corruption",
>>
>> This is essentially a regression test for virtio transport, so I'd add
>> virtio in the test name.
>
>Isn't virtio transport unaffected? It's about loopback transport (that
>shares common code with virtio transport).

Why virtio transport is not affected?

>
>>> +		.run_client = test_stream_msgzcopy_mangle_client,
>>> +		.run_server = test_stream_msgzcopy_mangle_server,
>>> +	},
>>> 	{},
>>> };
>>>
>>> diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
>>> index 9d9a6cb9614a..6735a9d7525d 100644
>>> --- a/tools/testing/vsock/vsock_test_zerocopy.c
>>> +++ b/tools/testing/vsock/vsock_test_zerocopy.c
>>> @@ -9,11 +9,13 @@
>>> #include <stdio.h>
>>> #include <stdlib.h>
>>> #include <string.h>
>>> +#include <sys/ioctl.h>
>>> #include <sys/mman.h>
>>> #include <unistd.h>
>>> #include <poll.h>
>>> #include <linux/errqueue.h>
>>> #include <linux/kernel.h>
>>> +#include <linux/sockios.h>
>>> #include <errno.h>
>>>
>>> #include "control.h"
>>> @@ -356,3 +358,68 @@ void test_stream_msgzcopy_empty_errq_server(const struct test_opts *opts)
>>> 	control_expectln("DONE");
>>> 	close(fd);
>>> }
>>> +
>>> +#define GOOD_COPY_LEN	128	/* net/vmw_vsock/virtio_transport_common.c */
>>
>> I think we don't need this, I mean we can eventually just send a single
>> byte, no?
>
>For a single byte sent, you get a single byte of uninitialized kernel
>memory. Uninitialized memory can by anything, in particular it can be
>(coincidentally) what you happen to expect. Which would result in a false
>positive. So instead of estimating what length sufficiently reduces
>probability of such false positive, I just took the upper bound.

I see, makes sense to me.

>
>BTW, I've realized recv_verify() is reinventing the wheel. How about
>dropping it in favour of what test_seqpacket_msg_bounds_client() does, i.e.
>calc the hash of payload and send it over the control channel for verification?

Yeah, strongly agree on that.

>
>>> +
>>> +void test_stream_msgzcopy_mangle_client(const struct test_opts *opts)
>>> +{
>>> +	char sbuf1[PAGE_SIZE + 1], sbuf2[GOOD_COPY_LEN];
>>> +	struct pollfd fds;
>>> +	int fd;
>>> +
>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>> +	if (fd < 0) {
>>> +		perror("connect");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>> +
>>> +	enable_so_zerocopy_check(fd);
>>> +
>>> +	memset(sbuf1, '1', sizeof(sbuf1));
>>> +	memset(sbuf2, '2', sizeof(sbuf2));
>>> +
>>> +	send_buf(fd, sbuf1, sizeof(sbuf1), 0, sizeof(sbuf1));
>>> +	send_buf(fd, sbuf2, sizeof(sbuf2), MSG_ZEROCOPY, sizeof(sbuf2));
>>> +
>>> +	fds.fd = fd;
>>> +	fds.events = 0;
>>> +
>>> +	if (poll(&fds, 1, -1) != 1 || !(fds.revents & POLLERR)) {
>>> +		perror("poll");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>
>> Should we also call vsock_recv_completion() or we don't care about the
>> result?
>>
>> If we need it, maybe we can factor our the poll +
>> vsock_recv_completion().
>
>Nope, we don't care about the result.
>

Okay, I see.

Thanks,
Stefano

