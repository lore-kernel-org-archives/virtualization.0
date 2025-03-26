Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD1F1F3BB9
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002068; cv=none; b=CkVoOMgoRF9W8hq6Wq7nRrckCgUe3qm8dVKwUnUv+7t9+MmkIpzlIGn+pIkuw4V/1EgSD7qJnjkTgQGjv1hDg3wm6fEGW3r2XFMhKqCu8RhuNAgmFvZjn0VxBgV7Huc4KGvh+wYJx/+hcOedKn22tjI3kTcKe3wcvBsiIDtmpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002068; c=relaxed/simple;
	bh=HQUnbYOHztWJlIEUmRKH75bQVKxvC05Z8Czi7nqAq54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bU/N6mcV4+KLbnEeTtlQ6Lab89djtRJQ30nJy2vzZY31pDj03WJvfFv1I0MJ2HwdnPbcNkyC9BbgmBOsMxevE0YvvXaU/su1S11spQxE5JsVEBH3Vtet4ePfrdffgKrmSqgAn13AqKxq4NwMBTDwRPKPAiXAvOTzShgnRx4uLK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdzMKDui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdzMKDui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743002066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPLJoTpj9mwt9aNlegdCeCagVemKudQjbGtSj2yURtA=;
	b=UdzMKDuiKuxZiAnAE2/3+j7ISnyxR07MvPkGqEsSjPC2C3rG8rK2bYZxkuvtmyXK4CCfNi
	lUpyI7qf2covl9bsIC1gXff5lkSgrafZGiXUN8z03ACfawvOgM/3F/QnPXhnNW+GQ2uA66
	F0NoLct/TZmsS1wTPozvhbJHG3iY8Kg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-NT8qoD4UPBeNg5jxRfJ8Mw-1; Wed, 26 Mar 2025 11:14:24 -0400
X-MC-Unique: NT8qoD4UPBeNg5jxRfJ8Mw-1
X-Mimecast-MFC-AGG-ID: NT8qoD4UPBeNg5jxRfJ8Mw_1743002063
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913f546dfdso3739317f8f.1
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 08:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743002063; x=1743606863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPLJoTpj9mwt9aNlegdCeCagVemKudQjbGtSj2yURtA=;
        b=Lo6f9d0a1p7IrYPbQ9GaZFATy+5fC/wQqqew+ahLhV4FahUQ5/9MPWAN+H0A/D3PDD
         dOgALRLKONR0841f8ZOoOlEYd1dSJKCD2v1b4IHPkaJ6a+H52UqZVvaIkLObvk5wOJoq
         4+iPWVEQFpHjdzchySqQUdbQgiWej7UTSpwIvDn3BXZxwIN5PtVVPYExNS3JM1S4Xe2R
         AAI3gAKZZGgAShQmat7PfAnrejkWl+Y6mKFvCgIAYvGHUf6SQM6Ol7s4hUCi2eIRyreh
         AoXRRZy3W5J/LHsZB4RXiPRv6TlXLEUkJqkVxfnzBjFlayPPGvXXhCfcBENur3BnIu2Z
         0Pyw==
X-Forwarded-Encrypted: i=1; AJvYcCURW4qsBf4IId5ecyzu7DtUg536GC+0CYDeXVZwjb+A2G76FtIRijkeOArEwzgm2O0HFFqq1H2V/SNx40CibA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5BkMNTp6+hGyPJ1M99gJk6mxCzQPy+g5ZTFf4TTC5TZdyXmHb
	CDLaK1txrmTSbi4KV+5zXPIAifJe68AVPcAXjQERuB/hG1MhiTu7UXyql1tnjZ9ZYZPjuFvyudt
	vhcHKT8vTIYQ13fnSnwsoZfHBBiA1nN08kC8UvUh4QG1bGIJQBtTHpXNsJRDXVZs0
X-Gm-Gg: ASbGncu3rvpzUZ9W7gXSk+ZMLK2oaX+KKlD1VYHZzi7+7kqrTdIONRF0qKsanAZheia
	0i5MfbHw1lq/S0fmWqgTRewgFq9woWqOjPpXiZ/MPC/42L0L7BqMZUVookaC7J1i1ddnicFbmCq
	e5NXypGlhY+BPankYVdIDIsvDAEeeR5Kxj+YBHy4sMMHth/wI965EHowzts4+JPxSHva3Dn6rFb
	2B0p7TtBDF26jWS5+l//bFMY4cCVwyD5AoS4pY3ggj6+FbQBACxHTurh8mDjWUCOAgXfjcvUZzp
	oZPKy9kKWBjUpeDdlA==
X-Received: by 2002:a5d:6c63:0:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-3997f90aa79mr21794406f8f.25.1743002063258;
        Wed, 26 Mar 2025 08:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLDszGJVF0UQWbzTWPDs66IMD9GSVlTSXE4mrjhgf35Uxdu3u5FMnMzdvDiVttQywI4kT7Hw==
X-Received: by 2002:a5d:6c63:0:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-3997f90aa79mr21794380f8f.25.1743002062777;
        Wed, 26 Mar 2025 08:14:22 -0700 (PDT)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdff2sm4960435e9.17.2025.03.26.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:14:22 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:14:20 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <ghik6xpa5oxhb5lc4ztmqlwm3tkv5qbkj63h5mfqs33vursd5y@6jttd2lwwo7h>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
 <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gshnGjWJlMaRfTlQWXEHtCgORS4iRlLf2drHb1kMmuU_1743002063
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Michal,

On Wed, Mar 19, 2025 at 01:27:35AM +0100, Michal Luczaj wrote:
>On 3/14/25 10:27, Luigi Leonardi wrote:
>> Add a new test to ensure that when the transport changes a null pointer
>> dereference does not occur[1].
>>
>> Note that this test does not fail, but it may hang on the client side if
>> it triggers a kernel oops.
>>
>> This works by creating a socket, trying to connect to a server, and then
>> executing a second connect operation on the same socket but to a
>> different CID (0). This triggers a transport change. If the connect
>> operation is interrupted by a signal, this could cause a null-ptr-deref.
>
>Just to be clear: that's the splat, right?
>
>Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>Workqueue: vsock-loopback vsock_loopback_work
>RIP: 0010:vsock_stream_has_data+0x44/0x70
>Call Trace:
> virtio_transport_do_close+0x68/0x1a0
> virtio_transport_recv_pkt+0x1045/0x2ae4
> vsock_loopback_work+0x27d/0x3f0
> process_one_work+0x846/0x1420
> worker_thread+0x5b3/0xf80
> kthread+0x35a/0x700
> ret_from_fork+0x2d/0x70
> ret_from_fork_asm+0x1a/0x30
>

Yep! I'll add it to the commit message in v3.
>> ...
>> +static void test_stream_transport_change_client(const struct test_opts *opts)
>> +{
>> +	__sighandler_t old_handler;
>> +	pid_t pid = getpid();
>> +	pthread_t thread_id;
>> +	time_t tout;
>> +
>> +	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>> +	if (old_handler == SIG_ERR) {
>> +		perror("signal");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
>> +		perror("pthread_create");
>
>Does pthread_create() set errno on failure?
It does not, very good catch!
>
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>
>Isn't 10 seconds a bit excessive? I see the oops pretty much immediately.
Yeah it's probably excessive. I used because it's the default timeout 
value.
>
>> +	do {
>> +		struct sockaddr_vm sa = {
>> +			.svm_family = AF_VSOCK,
>> +			.svm_cid = opts->peer_cid,
>> +			.svm_port = opts->peer_port,
>> +		};
>> +		int s;
>> +
>> +		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>> +		if (s < 0) {
>> +			perror("socket");
>> +			exit(EXIT_FAILURE);
>> +		}
>> +
>> +		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>> +
>> +		/* Set CID to 0 cause a transport change. */
>> +		sa.svm_cid = 0;
>> +		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>> +
>> +		close(s);
>> +	} while (current_nsec() < tout);
>> +
>> +	if (pthread_cancel(thread_id)) {
>> +		perror("pthread_cancel");
>
>And errno here.
>
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	/* Wait for the thread to terminate */
>> +	if (pthread_join(thread_id, NULL)) {
>> +		perror("pthread_join");
>
>And here.
>Aaand I've realized I've made exactly the same mistake elsewhere :)
>
>> ...
>> +static void test_stream_transport_change_server(const struct test_opts *opts)
>> +{
>> +	time_t tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>> +
>> +	do {
>> +		int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>> +
>> +		close(s);
>> +	} while (current_nsec() < tout);
>> +}
>
>I'm not certain you need to re-create the listener or measure the time
>here. What about something like
>
>	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>	control_expectln("DONE");
>	close(s);
>
Just tried and it triggers the oops :)

>Thanks,
>Michal
>

Thanks for the review!

Luigi

