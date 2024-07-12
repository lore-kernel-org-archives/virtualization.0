Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3D1494BC
	for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774430; cv=none; b=G2KcWLa78Abi2pX3ZA2NJ3EenaC6JjRe5nls/MX+2SsYvghLP2EFvJjhd9qY0JlorJY6P82DkF4ODqGXO+txw12yoEhLteEDyjqw2kTdZ2kyWbxz9dugHeftmQHZ9lsEB0gOYBZZn7Q9On9v1vuqjHmBScoNBsOjSYOVyh9jlT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774430; c=relaxed/simple;
	bh=7ii2cMWIXSW9Zvft7iHYSxGbuGdBlukrB4DhkMPVLDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I0STM0urgVxrFEHygytA77hkN7hzXENSPTi9oeiJyS1GMYVeR5tZdME1+EMjphDUt3JcgjRoLS19Rz8Qt87JvRd3AIK3voPcmOjzmCfBIjBvyFt7hBRAJXd9jnv95PrHLCjaFbOiatiiOnrDdy5q43qhK+dLni/ReZzCy/7u46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IENHo2gb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IENHo2gb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720774427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6eZohFqmRNYBDXGIYv2tB15qLRHJ4lN578ZEp/GlC8=;
	b=IENHo2gb7PRqfogW90yrZaZYLRvNzBYFVZVMzO06/s6R3A0JP5mRWtMIq/yBGRfwQMmFmc
	OD7S2RabvPhDGk8cOzJXVxXInZRU+8baAtmBb1quL3cUnhRX6zlRBsbfPk0LmJMXBBiAJI
	XXEm4SQ6cUHDRggc3M/kwYiEXSmtvsg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-i-j1OvLFMM6eVxi9VdQoIg-1; Fri, 12 Jul 2024 04:53:45 -0400
X-MC-Unique: i-j1OvLFMM6eVxi9VdQoIg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77eb9abdfaso165367266b.0
        for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 01:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720774424; x=1721379224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6eZohFqmRNYBDXGIYv2tB15qLRHJ4lN578ZEp/GlC8=;
        b=H05dQlyvdgFFb2KPUOpC13F14wX6mI3iD7cRdfl+M4MBVsWnxz2HFrFrvxotzmOO2z
         lrr8PdnjemiO/vc8jOvclq6AdovngnP/wU84nVUxLaWW23NA8eMutwmWCcfAYzY2eClF
         7WTgmnc+d/kWVbHcrtwglRj2keSv3aYXF0Ef5KahSgrewTawwMMWqck+KcziXefkFnRt
         cVuWqCbXn0xf2EtZGZMCnP+H6RdXMCWkuoGC+fOeAqONcfLJ7eEPG238fjSfidndKXTv
         ylCvRtDdSGWumpiB08/90A4vPOQTj4WJwkiQikSzEw5qmHPAg++Nw66yQYyeLFC7j8Xr
         tCfA==
X-Forwarded-Encrypted: i=1; AJvYcCUqYMYcjwDJsDd+JT53+P5Y/KXJPYvL/wF/WWjp6Fq5DaZ8aS3WEs2ODR5vNSt3KTksxiCCbIPMbjTwDGD4p8HjTi/rNi3Fw/pIpzqaxj8=
X-Gm-Message-State: AOJu0Yx5zWQGY5RGXwxtPiIbLb/ZzC4JbXB4AGE+FGUClCeuKl6i/y/O
	YKbayKg7rdz6S5vdmUhviPHvBi3FdDACCWr1pQWTKGw4+uu3wg5cw7km67/K5szkqI/a8SbipUY
	LfrAVPaucp9yZTFkgrzg/ofm9bmtnL0k/Tzh12HZ+GiWitHnO+twpf9yCGKtltf4w
X-Received: by 2002:a17:907:3f1c:b0:a79:8149:967a with SMTP id a640c23a62f3a-a7981499859mr589657666b.16.1720774424714;
        Fri, 12 Jul 2024 01:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpV63wxZL+4AWmv5IQrzSy5U9zbXvyslQuXagjzNSHgkYzRL5RG5InQqljmrd5V56lJG4Yxg==
X-Received: by 2002:a17:907:3f1c:b0:a79:8149:967a with SMTP id a640c23a62f3a-a7981499859mr589655066b.16.1720774424085;
        Fri, 12 Jul 2024 01:53:44 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc721sm322652666b.53.2024.07.12.01.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:53:43 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:53:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peng Fan <peng.fan@nxp.com>, 
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <3cx46c62lttslofdaneqqmsrcffeeblgy3d7eumuwx6x72xqtm@uux54tnn5fe7>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
 <PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <whgbeixcinqi2dmcfxxy4h7xfzjjx3kpsqsmjiffkkaijlxh6i@ozhumbrjse3c>
 <20240710190059.06f01a4c@kernel.org>
 <hxsdbdaywybncq5tdusx2zosfnhzxmu3zvlus7s722whwf4wei@amci3g47la7x>
 <20240711133801.GA18681@fedora.redhat.com>
 <20240711071455.5abfaae9@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240711071455.5abfaae9@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 11, 2024 at 07:14:55AM GMT, Jakub Kicinski wrote:
>On Thu, 11 Jul 2024 15:38:01 +0200 Stefan Hajnoczi wrote:
>> > Usually vsock tests test both the driver (virtio-vsock) in the guest and the
>> > device in the host kernel (vhost-vsock). So I usually run the tests in 2
>> > nested VMs to test the latest changes for both the guest and the host.
>> >
>> > I don't know enough selftests, but do you think it is possible to integrate
>> > them?
>> >
>> > CCing Stefan who is the original author and may remember more reasons about
>> > this choice.
>>
>> It's probably because of the manual steps in tools/testing/vsock/README:
>>
>>   The following prerequisite steps are not automated and must be performed prior
>>   to running tests:
>>
>>   1. Build the kernel, make headers_install, and build these tests.
>>   2. Install the kernel and tests on the host.
>>   3. Install the kernel and tests inside the guest.
>>   4. Boot the guest and ensure that the AF_VSOCK transport is enabled.
>>
>> If you want to automate this for QEMU, VMware, and Hyper-V that would be
>> great. It relies on having a guest running under these hypervisors and
>> that's not trivial to automate (plus it involves proprietary software
>> for VMware and Hyper-V that may not be available without additional
>> license agreements and/or payment).
>
>Not sure if there's a requirement that full process is automated.
>Or at least if there is we are already breaking it in networking
>because for some tests we need user to export some env variables
>to point the test to the right interfaces and even a remote machine
>to generate traffic. If the env isn't set up tests return 4 (SKIP).
>I don't feel strongly that ksft + env approach is better but at
>least it gives us easy access to the basic build and packaging
>features from ksft. Up to you but thought I'd ask.
>

Yeah, I'll try to allocate some cycles to look into that. Tracking it 
here: https://gitlab.com/vsock/vsock/-/issues/13

What about this patch, can we queue it for now?

Thanks,
Stefano

