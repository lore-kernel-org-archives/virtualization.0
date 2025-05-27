Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924EC24A069
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335280; cv=none; b=kTmHvgnxBng4Raxvdz34NHVgHQ/w05bznXLMVyxj8O3L4makZefyIQ7+n2/HGfqi4RXQxAW9LhOwSj74rK5RG9XojQ7C8mhVEKBWQQevvbfZ1bjxHEd2fNZfbGem69K0YNhwZHVrzlaLCqrbbsPI7l9Pq0cx5QYe9LvANmCZS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335280; c=relaxed/simple;
	bh=9/4frAyuK+mH4dCPcWolggSSGYIz8T6fceKUO2hSxFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HoEK8bPnrXpfBvr9UlZNE3LLF7lLOBkyTLcQ24qkfIxGntsl7B0/GWEb+IDRahJqIgv4c6lJHukXq7mnlk+uVu7GpqE/fyIV3k1DbHksVNKGFDRQ8KDegKzId4V/itbHtEX1VFdttHE4ON70w2tdCKmSYvxAZQSLGwfr9DAKsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdqJYn1U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdqJYn1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748335276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otnLpqmsUXmp5NS65WlS5qhIeAcyrstq9DF1BYfQqbs=;
	b=cdqJYn1U8r9+v2TNDCPu6sQYy/3vstSMp/FOKrvZo+B4C5xpsCCwTny6v51g6cpj1xooEX
	eMsu+fMk7Q6Ucd4ZqGOsvkMVzcuMWS0yjC7tzcOwrVS3JObOA1Q4rK+r1VPzsU1whDtDwR
	x079XjpOVGzg0ky7Wcwl8i6EUnQyLbI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-QPLSYZvSMKqLJM0RwkXE4g-1; Tue, 27 May 2025 04:41:13 -0400
X-MC-Unique: QPLSYZvSMKqLJM0RwkXE4g-1
X-Mimecast-MFC-AGG-ID: QPLSYZvSMKqLJM0RwkXE4g_1748335271
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad51ceda1d9so359245066b.1
        for <virtualization@lists.linux.dev>; Tue, 27 May 2025 01:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748335271; x=1748940071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otnLpqmsUXmp5NS65WlS5qhIeAcyrstq9DF1BYfQqbs=;
        b=W/Ni03ndnmiMrbMYVGMJhpNDnDNic/16g1PTdCZVI4B+av6jJI/RtlL0lJFJu1DYbq
         /tYe9B6GXpL14ySFQoecIyzsMXPm0p6r9y74I90SHRFQ37s4aRQGsipk/g5RZfFOh8yu
         xxbXZd/eR4Jga43jnTHU/9Zk1ZxORurSCHnqb+bsprbn4G3RD5OR7Ts3GdOowJ7guQc+
         xzREgIdxj6U4cMy7eKmdFzcQBhDWivS+6XNJyrt5hCo/tRErw3C9RkjfsAWpUTmExu3r
         U7wwsbschwQsmzdlDeJDouppWH8solrghe2/RO+iNxKfGuV7ePwtzhdqUZWiFYbpkS38
         XjFg==
X-Gm-Message-State: AOJu0YwuK9yJsdv5MOn5aEq7vVXDqdIsP0UbkYaplBRr50e5cSP5dhSC
	u88SJ/EWr7K8GjYAq4dhPxMCDqQ0V7WqjVrRVcIaMsrfZ+O+BrjMpH289X0xZeTumYkQ+JhIBsS
	WN8/HfNrSGviAjN9J3emZ8aI5F+AyIOf2pA78SoENd01z7J1CAgvmWqk4ZsT/qw9e9IWB
X-Gm-Gg: ASbGncuyLcpV+KmQupY0I03pGCzzPAzrOxaONFNCQThySx7xiQEwSN/kccKdhxKeKaV
	pV4JYwIKL6w3RuemisPKhDYvxRciF5wmV4V0+9qu6nu9zCh49NqNk28Zth6JQFBDjA+Ru1Xvl2H
	38QfbW3uOLqpzIb9HaIcWx0u5a4dlXjaCRJw0p/vXqHZwJIa8+ZDE2Rna1wYK9eaZNs+TFcUXnf
	m6MxPFfqslHETpIBUcTh/gI8AkQSUq2/phQ72ZPaaFSwcJsP3+KTXKPLnTF++gDJ4HDti8ZOcDg
	Z01DQKLLWzhbFJ1X90xs2kVe/4j4z0dOZQo/UIDqA236ufofaK/qPgxt8aVB
X-Received: by 2002:a17:907:3f9c:b0:ad5:d6b3:5cd5 with SMTP id a640c23a62f3a-ad8596d9843mr1170685866b.5.1748335271011;
        Tue, 27 May 2025 01:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMIKp0vFl+Prf74hN6X8U5dcoTMgJ4VBfKwNEdm/vm6CaEpdolph/x3lK/ErbdGrfTaaYqSg==
X-Received: by 2002:a17:907:3f9c:b0:ad5:d6b3:5cd5 with SMTP id a640c23a62f3a-ad8596d9843mr1170682866b.5.1748335270353;
        Tue, 27 May 2025 01:41:10 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad892d47536sm43991366b.12.2025.05.27.01.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 01:41:09 -0700 (PDT)
Date: Tue, 27 May 2025 10:41:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf
 test
Message-ID: <skvayogoenhntikkdnqrkkjvqesmpnukjlil6reubrouo45sat@j7zw6lfthfrd>
References: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
 <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
 <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
 <gfmoupl72tjyymhwxcstwpgaabbfaz6f4v6vj4lwwzwssg577c@urkmgn7rapnj>
 <151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OyEy2c5_Ya186rxE1yyzb9rK5tl9nh5T593MsHMDOKI_1748335271
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 26, 2025 at 10:44:05PM +0200, Michal Luczaj wrote:
>On 5/26/25 16:39, Stefano Garzarella wrote:
>> On Mon, May 26, 2025 at 02:51:18PM +0200, Michal Luczaj wrote:
>>> On 5/26/25 10:25, Stefano Garzarella wrote:
>>>> On Fri, May 23, 2025 at 12:31:16AM +0200, Michal Luczaj wrote:
>>>>> Increase the coverage of test for UAF due to socket unbinding, and losing
>>>>> transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
>>>>> Add test for UAF due to socket unbinding") and discussion in [1].
>>>>>
>>>>> The idea remains the same: take an unconnected stream socket with a
>>>>> transport assigned and then attempt to switch the transport by trying (and
>>>>> failing) to connect to some other CID. Now do this iterating over all the
>>>>> well known CIDs (plus one).
>>>>>
>>>>> Note that having only a virtio transport loaded (without vhost_vsock) is
>>>>> unsupported; test will always pass. Depending on transports available, a
>>>>
>>>> Do you think it might make sense to print a warning if we are in this
>>>> case, perhaps by parsing /proc/modules and looking at vsock
>>>> dependencies?
>>>
>>> That'd nice, but would parsing /proc/modules work if a transport is
>>> compiled-in (not a module)?
>>
>> Good point, I think not, maybe we can see something under /sys/module,
>> though, I would say let's do best effort without going crazy ;-)
>
>Grepping through /proc/kallsyms would do the trick. Is this still a sane
>ground?

It also depends on a config right?
I see CONFIG_KALLSYMS, CONFIG_KALLSYMS_ALL, etc. but yeah, if it's 
enabled, it should work for both modules and built-in transports.

>
>>> And I've just realized feeding VMADDR_CID_HYPERVISOR to bind() doesn't make
>>> sense at all. Will fix.
>>
>> Yeah, we don't support it for now and maybe it makes sense only in the
>> VMM code (e.g. QEMU), but it's a test, so if you want to leave to stress
>> it more, I don't think it's a big issue.
>
>All right, I'll keep it then. Fails quickly and politely anyway.
>
>>>>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>>>> +{
>>>>> +	bool tested = false;
>>>>> +	int cid;
>>>>> +
>>>>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>>>>
>>>>> +		tested |= test_stream_transport_uaf(cid);
>>>>> +
>>>>> +	if (!tested)
>>>>> +		fprintf(stderr, "No transport tested\n");
>>>>> +
>>>>> 	control_writeln("DONE");
>>>>
>>>> While we're at it, I think we can remove this message, looking at
>>>> run_tests() in util.c, we already have a barrier.
>>>
>>> Ok, sure. Note that console output gets slightly de-synchronised: server
>>> will immediately print next test's prompt and wait there.
>>
>> I see, however I don't have a strong opinion, you can leave it that way
>> if you prefer.
>
>How about adding a sync point to run_tests()? E.g.

Yep, why not, of course in another series :-)

And if you like, you can remove that specific sync point in that series 
and check also other tests, but I think we have only that one.

Thanks,
Stefano

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index de25892f865f..79a02b52dc19 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -451,6 +451,9 @@ void run_tests(const struct test_case *test_cases,
> 			run(opts);
>
> 		printf("ok\n");
>+
>+		control_writeln("RUN_TESTS_SYNC");
>+		control_expectln("RUN_TESTS_SYNC");
> 	}
> }
>

