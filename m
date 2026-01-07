Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6C329C7C
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779285; cv=none; b=ZiWojUssFLDcx9zSJHmBpTZkUq5zg7vNvZaUq12fz9SeonkAe88NwPR9Xrid8Dw2rkV/eq2S+an1TvTz16FXgeOa8GRm7F4h0f9ZW7ZrSm8xb6EXqqv2YZFYClUi76C5NorEGHjeKBjTRBOXGNqLd+VMTpUoPvYlT6kzqxdlJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779285; c=relaxed/simple;
	bh=wnY5o/MC+2tKe4BqCdLjMx+OdS/yCXDDRqj+BryQq2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJLV+4ZQD2WMiq6SPTG8Q0seUEFZZp/P0hy1W8SD1wUx4E3doiY3Pm/wCsrUpo+XRf/0Va2Qt+7RrjQS/IKpbE5fvBBXuanHixW/APSG4gMPcQsxcpS4oeqC+llzZQhU25lXdeAuLqTsr5kmrT9KzU2+PvU11S/Bfs4TQpX+BI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvOQnoPf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvOQnoPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767779282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScDN5rAHIF+neP5c5OtPOLevrSkBcpaaU/NLEzKk+zA=;
	b=DvOQnoPfrABYvoAb11LDQPpoMPDQtYeh/suMnfVgJmkREk7vsIQ2EVq7X+ilvffpUxXI6f
	lL3Sfwx2Zy46x6s7xIlKND4GNc/12y3yFyviou9/BTYdsCXxkWwFqsVKAdT1nlUJeBC5d9
	VENPAIFSCp7SgHjM9MR57PWC2fBuxtU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-RckKUnpOPqScHi5KrDZzAQ-1; Wed, 07 Jan 2026 04:48:01 -0500
X-MC-Unique: RckKUnpOPqScHi5KrDZzAQ-1
X-Mimecast-MFC-AGG-ID: RckKUnpOPqScHi5KrDZzAQ_1767779280
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47a83800743so3010565e9.0
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 01:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767779280; x=1768384080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScDN5rAHIF+neP5c5OtPOLevrSkBcpaaU/NLEzKk+zA=;
        b=uvAh6WaBXwYaaGbOkjyJTt9iT591irI5FOE/SWU6QUIA6/5fVg5V9WswofjCBgEozz
         4MP2w/S+UaJoskZh8ADAulqfpIbAUd4QET7xSlxb54Un8eQa9rci7p9XuP38WBjdGwOO
         3dZ2Q3OMTeGtnCbwup4Z+s8J3bq+sDufQW1yrK9I+eObmHX9XYI99h7t3CoZWF3/9dPC
         /3M2Xdp3YoZbVSoVmYORCassKb7u/ro9PWfRjmUiNo3TSltNW6EdJSrWDZ47QzLmq+yy
         PWkD6FadEkreV8DZOqZMKYczk0FQ7sBhsxopyfd3OpaqoFsTw82lEvN7r29eAQIVjVem
         agvw==
X-Forwarded-Encrypted: i=1; AJvYcCWqDObCDNqfGVF+hSS3o8z2uutz6NkWwS5drjXALiUVf1EFfL2uaI0g7z9CpXCOGYzqNUGb0rhtMIlzzh0cAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTjRbiVQkIbbBitCyCFaHIOXnni1TY63Kms7mCJJ7GckG/vUVE
	mWkWZn3LBeGGI9lKBKiyg05Rjym7KXCjCcFQMmTysi905fKp+mYY+/GZB2lZiMtKoSz4cWNN80G
	2p6VUR+vOcF5n0KI9j9RTJObVtRhDduu9sJ7fU/SQK1P3YAkiou9CLGfnAER+TLKMA36S
X-Gm-Gg: AY/fxX5NbnKMPOSyAVihS253yYbUFjrnqnyvCiGUMfFYZZ3javetAie9tLXEBw3qfa/
	PQoaZbLJYJDk1FEBdytc/TBYtyFZ1jJ4N9huJHSRQEY0fUUKwmLW8X0595wc2PcZB9lhoILNPJ3
	y+UigpnvKmMDupGRjtbDplB3S9dC+AQG8+0PZTOFo2789kRt/CeFWvq3IMQ6/hB8791LpjcIfON
	gFsu5hWESaA2g8tQN9td9JBK0l4kSfmiorEYZSE8/kAl4wC0FuFL1g2ieoChhs+ieemRjuuHjD8
	jLXZ0gnzpaHKPclNXixHys9qTK9eiQcbnSAHRkhmvkVOOfOVUX2YHJlXVp3UBCdDLhtUlKjPyNX
	YdS6b3incmeq9hg==
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d847d0f30mr23928995e9.0.1767779279700;
        Wed, 07 Jan 2026 01:47:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR14oCSs320qahGMCj2fpcjCaeoaq3gXPszOqvA9YkYZCVCcyOQTMHSiIeVJj9qvkiojdvAQ==
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d847d0f30mr23928485e9.0.1767779279246;
        Wed, 07 Jan 2026 01:47:59 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e13bsm86823385e9.7.2026.01.07.01.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 01:47:58 -0800 (PST)
Message-ID: <99b6f3f7-4130-436a-bfef-3ef35832e02c@redhat.com>
Date: Wed, 7 Jan 2026 10:47:56 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kselftest@vger.kernel.org, berrange@redhat.com,
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NGeh1vVBIiRnmW9zJBgYx8MqOAj8DfuEw681tAo_1XA_1767779280
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/2/25 11:01 PM, Bobby Eshleman wrote:
> On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
>> I still have some concern WRT the dynamic mode change after netns
>> creation. I fear some 'unsolvable' (or very hard to solve) race I can't
>> see now. A tcp_child_ehash_entries-like model will avoid completely the
>> issue, but I understand it would be a significant change over the
>> current status.
>>
>> "Luckily" the merge window is on us and we have some time to discuss. Do
>> you have a specific use-case for the ability to change the netns mode
>> after creation?
>>
>> /P
> 
> I don't think there is a hard requirement that the mode be change-able
> after creation. Though I'd love to avoid such a big change... or at
> least leave unchanged as much of what we've already reviewed as
> possible.
> 
> In the scheme of defining the mode at creation and following the
> tcp_child_ehash_entries-ish model, what I'm imagining is:
> - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
> - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
>   number of times
> 
> - when a netns is created, the new netns mode is inherited from
>   child_ns_mode, being assigned using something like:
> 
> 	  net->vsock.ns_mode =
> 		get_net_ns_by_pid(current->pid)->child_ns_mode
> 
> - /proc/sys/net/vsock/ns_mode queries the current mode, returning
>   "local" or "global", returning value of net->vsock.ns_mode
> - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
>   reject writes
> 
> Does that align with what you have in mind?
Sorry for the latency. This fell of my radar while I still processed PW
before EoY and afterwards I had some break.

Yes, the above aligns with what I suggested, and I think it should solve
possible race-related concerns (but I haven't looked at the RFC).

/P


