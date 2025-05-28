Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6C2CA8
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423335; cv=none; b=qINPZB7qU/a5Hmbmd9eOkpPkCtdDmwDDfA/NvBqeJM9xXLaaVERrZ1KizbsWMbUSfrkIvTFxab4PEZIYl00vz2QrQnAugadgtDyNx8g8Cp3PDVake6u7XOM7kgMviGFiaAJ0fkdzzQhXK8u2GxaKc84M9K0wtIuz9llGOj3ZqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423335; c=relaxed/simple;
	bh=HeRntkvpjTLIxIK7T/7PBTHCgMLMpgZe/nO0/0LPjDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WQPHSOdRr1fJQRIcEoZnJMSLcahok5GPROT++QDd/NeqvpXR+uP4QCXDOmHI4/CnCjSL+ukht6lvrO28GN1u4tYCzuQKr8m5ijTfgANJT1sWvPdt8dthjxdteh65v8EGePr4PyUkYSo3lhsej2z4sn7oDytnUscTHJwpt8BsW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7bz+mpb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7bz+mpb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748423332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K6fOjoths9BP+7g43cHI3UErFOLHs1REkE1Ir6J/HUc=;
	b=J7bz+mpbE7IQQhaIpGwDuP0MWCiAg86qqcGKbW3RTlMS3WHu6ThOlj9AoM/ltdPId3vTTn
	P0apfR3H1Ml5FMb2sDhMuZurXxqjMsOkXUo7FMlTVRPVn6Gu1jr5BdVLT5t3TavMBg+kR5
	cy6m275FBy/SDXIvyiqlA5knttw6woQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-WHOdfN0wP9q8TOivYLd5MA-1; Wed, 28 May 2025 05:08:51 -0400
X-MC-Unique: WHOdfN0wP9q8TOivYLd5MA-1
X-Mimecast-MFC-AGG-ID: WHOdfN0wP9q8TOivYLd5MA_1748423330
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso35286645e9.3
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 02:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423330; x=1749028130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6fOjoths9BP+7g43cHI3UErFOLHs1REkE1Ir6J/HUc=;
        b=MsNg5HwtNFg47Z08vQQ+Q1YRuEMei/rO5hUfkaGnAPNA+HFuBu6A6bWz6zG73DAQmU
         7huykk2vtmKg2HdE9uXxzZhdzVGGTYlZMwSq6c/RJoT+D61o3C5zH2zMUlFg4fmkFKli
         MoYQ9o80sMMLqovF66Yd2B2RhIZBKjnpzkDjfipeCDO3owM6QnFAEm07sR5V/To4KyL5
         9BKwTseEE98wXu4qRAyw09hWhVPH/ReFy3tE+JblIaFpVudMbCWBJXizpzeoDcLyQhQg
         QbNrMtGN32k6Z+XsDQKpfwH65KPGlpZrau9xYtlqUfm1FUkrSXdX04p0xGuw9sCd1UUA
         5Z1g==
X-Gm-Message-State: AOJu0Yxk5jVSFUp/l2tIRaabnrTIB7aArgtNwEGxS5ZGG3W1khZIXEmW
	tVsW1CzmiuF8SXRnt1X45SwSBMoFjGGrU6ALMcIsm6cft+ntZJ3zIKiJfLE8tA6B4YS6nc/lIrM
	D2BnUMus9zpOxl0OE9zeFVJZXflyB4l76C76Gz47wTC5qpZPedLxR3tl3FPr1tvpNnAM3
X-Gm-Gg: ASbGncthZiSH+wcPrsGquh8pRoq0xuEG3yGWPuW+POJa1WdXuOj4xw3H7EgPNTZmjmT
	wB+m6l8b7zRjUiZeeU7cluO4NacgWmw6Ho0WNu8atL34B5Jaont3Q0Edn9vkxGq+r2AiuioY7cA
	ldxprsTJfh1enWJeFJqecMOGmm7CPnBWSoc0poIBLZ8rY2Ew1RpX0zRpexI+FnmQv5GgY3FGg5E
	Mp/1c9sRRLMBvQZCi3Mz6EQeRkmrkrNYMWErQ1PDRkWlvrmBBOdPCL01QigbDlEAOyVJlBTp49E
	8IQF4uyJZWf5O+ZFR4O5xBGrmI8SAUlzC+UVppvvfTHSbzl3rBISVdy8EOu5
X-Received: by 2002:a05:600c:64c6:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-44c937d125amr158521945e9.31.1748423329750;
        Wed, 28 May 2025 02:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSUDpB7MCB0r+KZHQbLDKkjrX6HPTl91hhU9m2/A027cB52iPz1nlOjL0WRytjQ2mFsWDovg==
X-Received: by 2002:a05:600c:64c6:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-44c937d125amr158521515e9.31.1748423329064;
        Wed, 28 May 2025 02:08:49 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45006498c72sm14805555e9.2.2025.05.28.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 02:08:48 -0700 (PDT)
Date: Wed, 28 May 2025 11:08:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf
 test
Message-ID: <7zqv5toj2qjucy7fvaebbpwj6pth53uunsbapwhgrhwbr5pq5t@gp7h6klhr5sj>
References: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
 <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
 <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
 <gfmoupl72tjyymhwxcstwpgaabbfaz6f4v6vj4lwwzwssg577c@urkmgn7rapnj>
 <151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co>
 <skvayogoenhntikkdnqrkkjvqesmpnukjlil6reubrouo45sat@j7zw6lfthfrd>
 <54959090-440e-49e8-80b3-8eee0ef4582c@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <54959090-440e-49e8-80b3-8eee0ef4582c@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VErlnLkwVmqZ-OCzb3IARnN0USd7GwD7A0Yfngg5z0k_1748423330
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 28, 2025 at 10:58:28AM +0200, Michal Luczaj wrote:
>On 5/27/25 10:41, Stefano Garzarella wrote:
>> On Mon, May 26, 2025 at 10:44:05PM +0200, Michal Luczaj wrote:
>>> On 5/26/25 16:39, Stefano Garzarella wrote:
>>>> On Mon, May 26, 2025 at 02:51:18PM +0200, Michal Luczaj wrote:
>>>>> On 5/26/25 10:25, Stefano Garzarella wrote:
>>>>>> On Fri, May 23, 2025 at 12:31:16AM +0200, Michal Luczaj wrote:
>>>>>>> Note that having only a virtio transport loaded (without vhost_vsock) is
>>>>>>> unsupported; test will always pass. Depending on transports available, a
>>>>>>
>>>>>> Do you think it might make sense to print a warning if we are in this
>>>>>> case, perhaps by parsing /proc/modules and looking at vsock
>>>>>> dependencies?
>>>>>
>>>>> That'd nice, but would parsing /proc/modules work if a transport is
>>>>> compiled-in (not a module)?
>>>>
>>>> Good point, I think not, maybe we can see something under /sys/module,
>>>> though, I would say let's do best effort without going crazy ;-)
>>>
>>> Grepping through /proc/kallsyms would do the trick. Is this still a sane
>>> ground?
>>
>> It also depends on a config right?
>> I see CONFIG_KALLSYMS, CONFIG_KALLSYMS_ALL, etc. but yeah, if it's
>> enabled, it should work for both modules and built-in transports.
>
>FWIW, tools/testing/selftests/net/config has CONFIG_KALLSYMS=y, which
>is enough for being able to check symbols like virtio_transport and
>vhost_transport.

Ok, I see, so let's go in that direction.

>
>Administrative query: while net-next is closed, am I supposed to mark this
>series as "RFC" and post v2 for a review as usual, or is it better to just
>hold off until net-next opens?

Whichever you prefer, if you are uncertain about the next version and 
want to speed things up with a review while waiting, then go with RFC, 
but if you think all comments are resolved and the next version is ready 
to be merged, wait for the reopening.
Thanks for asking!

>
>>>>>>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>>>>>> +{
>>>>>>> +	bool tested = false;
>>>>>>> +	int cid;
>>>>>>> +
>>>>>>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>>>>>>
>>>>>>> +		tested |= test_stream_transport_uaf(cid);
>>>>>>> +
>>>>>>> +	if (!tested)
>>>>>>> +		fprintf(stderr, "No transport tested\n");
>>>>>>> +
>>>>>>> 	control_writeln("DONE");
>>>>>>
>>>>>> While we're at it, I think we can remove this message, looking at
>>>>>> run_tests() in util.c, we already have a barrier.
>>>>>
>>>>> Ok, sure. Note that console output gets slightly de-synchronised: server
>>>>> will immediately print next test's prompt and wait there.
>>>>
>>>> I see, however I don't have a strong opinion, you can leave it that way
>>>> if you prefer.
>>>
>>> How about adding a sync point to run_tests()? E.g.
>>
>> Yep, why not, of course in another series :-)
>>
>> And if you like, you can remove that specific sync point in that series
>> and check also other tests, but I think we have only that one.
>
>OK, I'll leave that for later.

Yep, feel free to discard my suggestion, we can fix it later.

Thanks,
Stefano

