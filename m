Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E391DDC1E
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003157; cv=none; b=Ha9rKziJlTjCKKJp2ILaUVBEF6J1t5XS4AH/Xq2s9tjD0NQBhtYM1PmxnrBZdY0qnQ5Li1fp/2cHyI5B/xC52BIpSVDBU5FNB0QEz2cpnhjzq7B/QlKMcTscMmEoP/NaBTrOBSiKl/2O2oroN9pBbCf1E7laDHB7pKSYv6J/whU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003157; c=relaxed/simple;
	bh=3FJc+P6b3zzJcpkV8eK+FP3TgtJw7jYvpWP0TF2ajgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e+zY8w92xVRQCRlAPaDpTJ3o6ehCIeVZ4i1bZuAUnEio/niksl6BOTV9MdWKoZtvjG2UauZJ1rLdis5u9TLgKB9lRQQtFGoAM6lG6SqGbk2SRfTnl8S8tsZHPMfbFvOl+vRsXWWPMjAN0Xn6qW6Vb2hTKCetLfAshdZ2HXCWHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYwCYMlN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYwCYMlN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743003155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cy6PJe0sMeoJhLcbhlkwSjbydSqh6/me/pxc/YeYWRY=;
	b=PYwCYMlNa2gUVWUpZBBnOdejJKr6eUC1GhpL/9hnl8LmwY19s8uT+ZuANKUw3qX4gbtngS
	r4EqFwmsTE6BpYQtEyMwfHsHKJq0Pkc9czJc/XcTCcvwedP0huMh5GqpokLS3ITpRda4PG
	cHTyc2FcqWCONss+zdDpahF+oozWyTI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-xWBiJ8DPOr6a6e9Zowm8_g-1; Wed, 26 Mar 2025 11:32:33 -0400
X-MC-Unique: xWBiJ8DPOr6a6e9Zowm8_g-1
X-Mimecast-MFC-AGG-ID: xWBiJ8DPOr6a6e9Zowm8_g_1743003152
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so47145355e9.2
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 08:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743003152; x=1743607952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy6PJe0sMeoJhLcbhlkwSjbydSqh6/me/pxc/YeYWRY=;
        b=dKbWDcnFo2C5Nng4XfE6WUUgYZ07WZZnGVTfyKV8ksBtIudkKr1kjBfyf96gGJpsXP
         X0OoO1oEjT5cgMCMPyKX81Qa8f2eX+oCA2zIdsuLtA7VuLxN3f8eqgD5iJf26prVu0W+
         ilUXKDrP74/W96FeLYbLnjMgb0e6pKgQzlDAGmmDUWfzSBZmtIx+qi799ppZy7Ex8cGD
         BBOs+tx3O38nKP5G5u3b2UumcfxPhJLg+eUyn9ZaKrzg5UDcA24F1jWENle+USMJC8XQ
         2lXvImJI5JKQU/GUAEoSlamXbQ+AiLN75y/3ZeuNkJxm4+FSbhAHsXYjthVRj2SdDTkP
         SDtA==
X-Forwarded-Encrypted: i=1; AJvYcCUaWZL9CbJ/J7BuW237DuLLB2Rq/vy2Hr6MPzCNX2CRxHCg95K62jrfElb5wiMTL3SDhakXwAGPGR+tyB0CXg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3U3zntEByJ0tdr4fHgwWnUxeiPcr+v3mPXSKn83C7yArPD9hE
	7CWdhtHX1NeV0pmdBtrOKae6OHYX0mIAXAcsOpM/UBIwrmFPW6T2SBHAEwHm7sHVt821W3vXirR
	x/oPmeFN5AhadllWh1WzHiVqe/bOUXVhuFC0l60HWfHIhRhCEvDkTEAFQAUoMSbHM
X-Gm-Gg: ASbGncvpqK54ubXAdtKiDz7u26ZNgQrF4N8LhlrZBIfqEkADx9xJX0ELWLQ/RxeRAkX
	DayNT7gQY4IJ5pFbQur1rF+oWpThWkwl2YojPhF/9rKKVxZr0tvwepuONI2mID/CC1a/sWItugV
	t1bN9TYwov2zoGTvEo02C4lnP/rymS8vBEmWHxS9HKUZKx5/vufrx4Yxc56hc2N20UhmtWGJfU7
	0jSAYz9lpY5dkG4uWn79MTr6Gu8A8bctfOvpQxkjHi8ik3vNffzjnFuxWqy62o64mRlgqkRt+Qc
	VMEZCZumP/1dqDEBwRVg0XSFDtFIDlu8IurYxsoRXUaJDNRTLFbCbPLFYTWOP8sY
X-Received: by 2002:a05:600c:3d93:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-43d58db553amr142517335e9.12.1743003152358;
        Wed, 26 Mar 2025 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRLuNTDcftGdYLrF6TRN76YPNKGjROf60zN8Q6h9HxP9LzdIxTJHT5qWOkTTFeksKVqeo81g==
X-Received: by 2002:a05:600c:3d93:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-43d58db553amr142517035e9.12.1743003151832;
        Wed, 26 Mar 2025 08:32:31 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e834a5sm5891945e9.13.2025.03.26.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:32:30 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:32:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <7ursz6zrffsljkvo25qvgaa5vroflpibtrgnz446ga36kzqtfc@l7v62brwdvod>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
 <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>
 <ghik6xpa5oxhb5lc4ztmqlwm3tkv5qbkj63h5mfqs33vursd5y@6jttd2lwwo7h>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ghik6xpa5oxhb5lc4ztmqlwm3tkv5qbkj63h5mfqs33vursd5y@6jttd2lwwo7h>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5GQn2MFQswMpxGMY9bf7RRT72NoN2KE62zqyvgAkbFs_1743003152
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Mar 26, 2025 at 04:14:20PM +0100, Luigi Leonardi wrote:
>Hi Michal,
>
>On Wed, Mar 19, 2025 at 01:27:35AM +0100, Michal Luczaj wrote:
>>On 3/14/25 10:27, Luigi Leonardi wrote:
>>>Add a new test to ensure that when the transport changes a null pointer
>>>dereference does not occur[1].
>>>
>>>Note that this test does not fail, but it may hang on the client side if
>>>it triggers a kernel oops.
>>>
>>>This works by creating a socket, trying to connect to a server, and then
>>>executing a second connect operation on the same socket but to a
>>>different CID (0). This triggers a transport change. If the connect
>>>operation is interrupted by a signal, this could cause a null-ptr-deref.
>>
>>Just to be clear: that's the splat, right?
>>
>>Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
>>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>>Workqueue: vsock-loopback vsock_loopback_work
>>RIP: 0010:vsock_stream_has_data+0x44/0x70
>>Call Trace:
>>virtio_transport_do_close+0x68/0x1a0
>>virtio_transport_recv_pkt+0x1045/0x2ae4
>>vsock_loopback_work+0x27d/0x3f0
>>process_one_work+0x846/0x1420
>>worker_thread+0x5b3/0xf80
>>kthread+0x35a/0x700
>>ret_from_fork+0x2d/0x70
>>ret_from_fork_asm+0x1a/0x30
>>
>
>Yep! I'll add it to the commit message in v3.
>>>...
>>>+static void test_stream_transport_change_client(const struct test_opts *opts)
>>>+{
>>>+	__sighandler_t old_handler;
>>>+	pid_t pid = getpid();
>>>+	pthread_t thread_id;
>>>+	time_t tout;
>>>+
>>>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>>>+	if (old_handler == SIG_ERR) {
>>>+		perror("signal");
>>>+		exit(EXIT_FAILURE);
>>>+	}
>>>+
>>>+	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
>>>+		perror("pthread_create");
>>
>>Does pthread_create() set errno on failure?
>It does not, very good catch!
>>
>>>+		exit(EXIT_FAILURE);
>>>+	}
>>>+
>>>+	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>>
>>Isn't 10 seconds a bit excessive? I see the oops pretty much immediately.
>Yeah it's probably excessive. I used because it's the default timeout 
>value.

Please define a new macro with less time, something like we did with
ACCEPTQ_LEAK_RACE_TIMEOUT.

Thanks,
Stefano

