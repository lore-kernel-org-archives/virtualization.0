Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086028EB
	for <virtualization@lists.linux.dev>; Mon, 26 May 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270408; cv=none; b=XgEhqWiq4G5Mbz2eG9w1lBWTAyReBZGwhVTtmbG/5Yb7/vmbKREU4GcOCY39+XM2Nf4VqWH29BXPQ2ZX++dMPoUChIXbphIZNASQYk19PMJQCtOiTFE5wY7LLTBCqiajOa+PXU70GNMOPwMXvlhiEoFGrVfjc7GBqk6jaksBBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270408; c=relaxed/simple;
	bh=/e+vyLtK0CFZ4t4mAapQB9b2M2hDkw8sV9L58+jnCMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PWicbObwqnAVFQVlR7Gvv0a8EBHn266cqVdMm5UQ7nJO46aZSHbfq9QHeMRAtURVrSp12I5q8YkrewZWph+YuP1ekZ8gHXAA2S9c8ZYYtbfFwY1vtFCEoBbrDw+Yc3SR+xl5OP6qc0UD/dISRUXypgsYqssU+vehTtc8VLN0aLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVRr/v9F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVRr/v9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748270405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RF6pS1ObcOVvDlmvm5nj8NiMFIwIn9dVx82Hog1fdnE=;
	b=SVRr/v9FJT06dcOlhOj83WXFKXwEwe1uyLXphH6RWF1p8K+jEz04YYKrC6AmmKvxgPbFwn
	v35+5juJVxRydN/Mg149rZaADI7P90oicJ4AguVuUxNJ6+Otz3HPYHUEJcId6zR0Ol2cMP
	aJBNckqFIM2NrI70y009uPCeQVl6vj8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-k8S4QaPLOXGykSUIlMWaNw-1; Mon, 26 May 2025 10:40:02 -0400
X-MC-Unique: k8S4QaPLOXGykSUIlMWaNw-1
X-Mimecast-MFC-AGG-ID: k8S4QaPLOXGykSUIlMWaNw_1748270401
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-44b1f5b8e9dso8629345e9.2
        for <virtualization@lists.linux.dev>; Mon, 26 May 2025 07:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748270401; x=1748875201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF6pS1ObcOVvDlmvm5nj8NiMFIwIn9dVx82Hog1fdnE=;
        b=IZQlWwRg6OHAjFClNpfRy7HjBKlY8qebgsoHZmjT9m8iimcs+QLMhQ7g4VPQE1t6UZ
         waupmKOzfH5NBAcE+OLnjPn6JGw8ss7PgYhDD9JGkLlLY8vw9gn4+sAI/dlTyfRpd2wV
         cLAyFourq6NVWtlj6lC6D67mJq705+XnrcHlQ7SL5Db6myl2VeABp5zgshYfYa8WsiKg
         NHhLBIbuKdgLRUCAoVe6Db4vZvWk3V1pyV5LmaE0xFxVMZuyQi749wY6AniWu+mItRs8
         Ujsg8FqBAf79tTu10tGh/LR/nwr+/jgT79ISxosnX2/eOh5l8mfa0CubhiZ9UOP6i62m
         R1sw==
X-Gm-Message-State: AOJu0YwWnNWgpK7YRMXNdU5UCWKgY03jsSna3u0eCfSkjWC8dWTpBxoL
	PzG+fl4K/fWWfpWOuuXShBIaCY+GIsj7qkMOrK5falB85hDPrnCrxNIETeZbaVXDA5miOXZX8u1
	5LSs6zMuXY8DnhdBVQSD9j8XTjIQpvlUkO4wJvho6HBmZo3ERT28bPRVw4jWF0JjVcTWD
X-Gm-Gg: ASbGncv7SCZGTMwW6H8rv9knlNaqTOIUBXyzt0JsCubDGXDYGSN20xUlVyQn9rwAnvo
	oYycOK6RTsLkD4QgRasIRikhFUxLWZJ/oaDnw7ROXyz7R14joajSzaePLd7vLCjRno4xDMnps2w
	h4JgFLKacHcCMcbjNVt0lKkgSA8xqJHzFNLYzWtClfFXZyXb+pggaJIePbMRwRFVcEpmCLvXXNY
	0/D27rEh6XKMmjkHPMAD1copoXpAPZirykCSdl9du+0ubGQgtftt48b7YdgLRADo7s8ZPhVIsGv
	mOTBXKKudtdUXjt8RM0eYs/La/2aOvaBraXrf57OB5RJj0GTAGNHTni21UrA
X-Received: by 2002:a05:600c:511b:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-44c9493e671mr77932115e9.25.1748270401505;
        Mon, 26 May 2025 07:40:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWo+GvCwfq/rkNxHnvWQwirh+1VtVO+LjjW3fAOxqDotyizM//UqyOYsGby8MQArjXhlSeww==
X-Received: by 2002:a05:600c:511b:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-44c9493e671mr77931885e9.25.1748270400947;
        Mon, 26 May 2025 07:40:00 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aef8asm247808255e9.29.2025.05.26.07.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 07:40:00 -0700 (PDT)
Date: Mon, 26 May 2025 16:39:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf
 test
Message-ID: <gfmoupl72tjyymhwxcstwpgaabbfaz6f4v6vj4lwwzwssg577c@urkmgn7rapnj>
References: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
 <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
 <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8taBIjCdiJRhtdzCK8l5kGSIlOcHTd64cUwdtlixJQI_1748270401
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 26, 2025 at 02:51:18PM +0200, Michal Luczaj wrote:
>On 5/26/25 10:25, Stefano Garzarella wrote:
>> On Fri, May 23, 2025 at 12:31:16AM +0200, Michal Luczaj wrote:
>>> Increase the coverage of test for UAF due to socket unbinding, and losing
>>> transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
>>> Add test for UAF due to socket unbinding") and discussion in [1].
>>>
>>> The idea remains the same: take an unconnected stream socket with a
>>> transport assigned and then attempt to switch the transport by trying (and
>>> failing) to connect to some other CID. Now do this iterating over all the
>>> well known CIDs (plus one).
>>>
>>> Note that having only a virtio transport loaded (without vhost_vsock) is
>>> unsupported; test will always pass. Depending on transports available, a
>>
>> Do you think it might make sense to print a warning if we are in this
>> case, perhaps by parsing /proc/modules and looking at vsock
>> dependencies?
>
>That'd nice, but would parsing /proc/modules work if a transport is
>compiled-in (not a module)?

Good point, I think not, maybe we can see something under /sys/module,
though, I would say let's do best effort without going crazy ;-)

>
>>> +static bool test_stream_transport_uaf(int cid)
>>> {
>>> +	struct sockaddr_vm addr = {
>>> +		.svm_family = AF_VSOCK,
>>> +		.svm_cid = cid,
>>> +		.svm_port = VMADDR_PORT_ANY
>>> +	};
>>> 	int sockets[MAX_PORT_RETRIES];
>>> -	struct sockaddr_vm addr;
>>> -	int fd, i, alen;
>>> +	socklen_t alen;
>>> +	int fd, i, c;
>>>
>>> -	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
>>> +	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>>> +	if (fd < 0) {
>>> +		perror("socket");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>> +
>>> +	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
>>> +		if (errno != EADDRNOTAVAIL) {
>>> +			perror("Unexpected bind() errno");
>>> +			exit(EXIT_FAILURE);
>>> +		}
>>> +
>>> +		close(fd);
>>> +		return false;
>>
>> Perhaps we should mention in the commit or in a comment above this
>> function, what we return and why we can expect EADDRNOTAVAIL.
>
>Something like
>
>/* Probe for a transport by attempting a local CID bind. Unavailable
> * transport (or more specifically: an unsupported transport/CID
> * combination) results in EADDRNOTAVAIL, other errnos are fatal.
> */
>
>?

LGTM!

>
>And I've just realized feeding VMADDR_CID_HYPERVISOR to bind() doesn't make
>sense at all. Will fix.

Yeah, we don't support it for now and maybe it makes sense only in the 
VMM code (e.g. QEMU), but it's a test, so if you want to leave to stress 
it more, I don't think it's a big issue.

>
>> What about adding a vsock_bind_try() in util.c that can fail returning
>> errno, so we can share most of the code with vsock_bind()?
>
>Ah, yes, good idea.
>
>>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>> +{
>>> +	bool tested = false;
>>> +	int cid;
>>> +
>>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>>
>>> +		tested |= test_stream_transport_uaf(cid);
>>> +
>>> +	if (!tested)
>>> +		fprintf(stderr, "No transport tested\n");
>>> +
>>> 	control_writeln("DONE");
>>
>> While we're at it, I think we can remove this message, looking at
>> run_tests() in util.c, we already have a barrier.
>
>Ok, sure. Note that console output gets slightly de-synchronised: server
>will immediately print next test's prompt and wait there.

I see, however I don't have a strong opinion, you can leave it that way 
if you prefer.

Thanks,
Stefano

