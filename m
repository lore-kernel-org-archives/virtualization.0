Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53D352951
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236561; cv=none; b=Qm5er3094GwX1GDr6eccwvVZXI+G5c8GWdOpMx8KOD80ZbYzT1lDywYK3b2rg0BQNw9wtQLgiOxb+9nUx28UwdN+5OkVItC2e3zT2h7Gw4cgosl3G7bF+B+XBMhpNAuXvoqqDqrPfL3jVjrLTM5nbwwV2SjG1GB+YbYlxpRdVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236561; c=relaxed/simple;
	bh=rSpDYYDAlrC2qkyCkQQP9wvtpup8H0/216lHMC+q/jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QA1I+1d3OdWLbN9B9lWHamINDtXpHaUf2ue4Exfr7aH8Eofn7ttM+DlCkV0JVMxGxV4EAJmInJXXVtkpSQKDNQ9Y4YLclbbiHQd51KnH4h6PiQgv0oyu5Fa5ht1ZK20m48GWt2mZNrk8KExfEE0EUhyFBdJasAW3qsp6vKBUZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJ48rsk3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJ48rsk3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768236556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/pAFr0/aoSxJfBcAQjHBP8K9Jsu2l/1rwtc+O6U0sw=;
	b=NJ48rsk37dinjAX9SPmy9XpXWJ5EfXk6r4v5+LW9FMOzT7LAjQcdcCW6OmHE2lfdw2OkkL
	CJRBWolCnGK6STVD0jXAm2oziG/ItRvFclY2X8MtRxZFL0IQZ6f/fe/1ZaXu/2yAlVp6WR
	SI6QR3a0lw4oxhIEnM12rv8Bg+qEkJY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-hqcQuDOSPsOKcMjW1wGl_A-1; Mon, 12 Jan 2026 11:49:15 -0500
X-MC-Unique: hqcQuDOSPsOKcMjW1wGl_A-1
X-Mimecast-MFC-AGG-ID: hqcQuDOSPsOKcMjW1wGl_A_1768236554
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477bf8c1413so44705805e9.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 08:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236551; x=1768841351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/pAFr0/aoSxJfBcAQjHBP8K9Jsu2l/1rwtc+O6U0sw=;
        b=EpiLffW8i4E6zAp1vp2BOMO+lzoilN5Ys5I1/cGLfBvTuwFBGbRKS46zidS1gbciZr
         2lDU0jVZXoA4wjHCS2YrlRQVQZgETFVNdWjwgo3U2mAsFJg125MtgUUBFbBZ9S8aWnoF
         FttBnwZZCAJ/BwO81kOsO7dudmYx+p2TiNANxWcD8jEam31jXIZpuQIXWdvdbT/Q5hh+
         ZiGL/yFfNlbQ3nA1/9zwT2VsaCqewgoQCLTARnDCwG/1D7AnwwuJs9Z3eNT2fDa8aXFx
         LzrRY4oJT8OwYZG6sHiXICVwpsqMdNCqCvtHqYgUAFxzq+tNJTAXi2Eq9dLXpZFfq082
         Gahw==
X-Forwarded-Encrypted: i=1; AJvYcCVxhZuWRK/67sFv6wULhg1csIDXf2Pwu9I2NuZstSweICfRRKFs+bFY90oxMy77gSoCaO0kvztWNQfVyKOByQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBR1n49CoJ9bND6P97vQIDwZ4+qnSSkjsvAbnP6eYxEcIrGNAk
	BkVk8UhsdEO7+cB70xYQtneakvjNwjG9TfACKrgGUrnLCnfER5QzR0HZ/Xw5DxCuDQqUdur3knC
	7bw315lTqgJd00RZEBNnmAYoUEyy+TW2vsxX+StPkari74GUkcjxJzURFzcIUBP6yUKIv
X-Gm-Gg: AY/fxX6ZVB8XM/HbXdKVItDjjCOSFALW2EMX22RVQC4Qe+KR//vP9zGHTaakTWtxKXI
	/YjsUIcDoQjCTWDow0tgI5J5m0pGbmCSJ/Se82AZf4kScMz/xaVHd1jEUHaPgIsNiFa8oBywoKF
	VDotSP81SqdrRhNlPHQfWRMrH5BeS5MXwQmqdLPs0/qMJvedLYOc7B/QPl5ZAnQZf/b8aK/TVX2
	rJtJvLVV9FihcB9auF6++7XgS8ZYAbIKymcRmwofrgbmLbzwSuAf8Huhy068d0OTJI6KvDAp5BO
	8HRrom9jPUzIteaq0lLpYwy7HOMmuJ+ONsDSXOtatjpLugC0ODNYmkUOtmQNc+/9IV7mpYSzw65
	/EZtdL6VDe23PkzEKj3WdvqUV/A2OOCcUVWoY4swBkSE0yKTKuFLxMLjXPKWdeQ==
X-Received: by 2002:a05:600c:1991:b0:477:55c9:c3ea with SMTP id 5b1f17b1804b1-47d84b40aa4mr239691895e9.35.1768236550744;
        Mon, 12 Jan 2026 08:49:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbfHpDO7Px43Be+w7n1YsI5iuj6cCFBAlIOAFZDgERsn4SYfumZjikc9aia43Emr8rvTaF4g==
X-Received: by 2002:a05:600c:1991:b0:477:55c9:c3ea with SMTP id 5b1f17b1804b1-47d84b40aa4mr239691475e9.35.1768236550199;
        Mon, 12 Jan 2026 08:49:10 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8718b1a6sm133003075e9.13.2026.01.12.08.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:49:09 -0800 (PST)
Date: Mon, 12 Jan 2026 17:48:56 +0100
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
Message-ID: <aWUk0axv-GZu7VD2@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-2-26f97bb9a99b@rbox.co>
 <aWEqjjE1vb_t35lQ@sgarzare-redhat>
 <76ca0c9f-dcda-4a53-ac1f-c5c28d1ecf44@rbox.co>
 <aWT6EH8oWpw-ADtm@sgarzare-redhat>
 <080d7ae8-e184-4af8-bd72-765bb30b63a5@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <080d7ae8-e184-4af8-bd72-765bb30b63a5@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q0LgfC5FYoRmL4D0HD3ewJVABRgNgaXnIChcEQR9tiE_1768236554
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 12, 2026 at 04:52:02PM +0100, Michal Luczaj wrote:
>On 1/12/26 14:44, Stefano Garzarella wrote:
>> On Sun, Jan 11, 2026 at 11:59:54AM +0100, Michal Luczaj wrote:
>>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>>> index bbe3723babdc..21c8616100f1 100644
>>>>> --- a/tools/testing/vsock/vsock_test.c
>>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>>> @@ -2403,6 +2403,11 @@ static struct test_case test_cases[] = {
>>>>> 		.run_client = test_stream_accepted_setsockopt_client,
>>>>> 		.run_server = test_stream_accepted_setsockopt_server,
>>>>> 	},
>>>>> +	{
>>>>> +		.name = "SOCK_STREAM MSG_ZEROCOPY coalescence corruption",
>>>>
>>>> This is essentially a regression test for virtio transport, so I'd add
>>>> virtio in the test name.
>>>
>>> Isn't virtio transport unaffected? It's about loopback transport (that
>>> shares common code with virtio transport).
>>
>> Why virtio transport is not affected?
>
>With the usual caveat that I may be completely missing something, aren't
>all virtio-transport's rx skbs linear? See virtio_vsock_alloc_linear_skb()
>in virtio_vsock_rx_fill().
>

True, but what about drivers/vhost/vsock.c ?

IIUC in vhost_vsock_handle_tx_kick() we call vhost_vsock_alloc_skb(), 
that calls virtio_vsock_alloc_skb() and pass that skb to 
virtio_transport_recv_pkt(). So, it's also affected right?

BTW in general we consider loopback as one of virtio devices since it 
really shares with them most of the code.

That said, now I'm thinking more about Fixes tag.
Before commit 6693731487a8 ("vsock/virtio: Allocate nonlinear SKBs for 
handling large transmit buffers") was that a real issue?

Thanks,
Stefano

