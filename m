Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302691DA61B
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731287; cv=none; b=HcCisrRaa5cmgLNSL5Bw395hXe+2htcgyVJH1IramGjyRUA/HZ7DgC0/A72+DSH//XtR58XN6oWggk+/+SCtVsMNr/u78wYLlWcb9rEX+w0PF8DoUxj3oHTK13bgv2nj8t3Cw7E+I0EgBAcA9bxM4WcdoldLTNgt2IOMV2MNlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731287; c=relaxed/simple;
	bh=EW8+ltB5RD/cj4k61+Elnw7V9Vm0GX9HYQV8/qmM9fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cfVWYejP5MVMgWMlsTDTv7mbWssI3IzH0uq9X7aJpKsImkoQY5DVxCaOG5xNVdxcois33SOID6j3TNYsydyR23qQL4md1kg14lfAYAw6OAz4zsFnPv9SylfyZNovz66bDi/1p7zOCAPfYhkRgoaEGB4XapAo88510MmFfratLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwhDP1ky; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwhDP1ky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747731284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K84RlwjKxdVMrP8H1/lSZbVNtNLQI+5UHNrYUWsQ7to=;
	b=FwhDP1kyDN8QYZm+/kn/dmPMRRl0vk+4FvXEL5u3SbzNqeRcwdmG/0oe8S21u+ACNHc4hp
	d5gDCiqKwdJxSl4fnnZZbeoVRiPSd/QwAbn67klON5+f01QQtMYWIuQGqIZbzaJ+uAWj3C
	soUqTm/8X1cRT7+wKGPUVjx8QcuLrJY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-3w4ejb9KPcyD4E_IWPvzMg-1; Tue, 20 May 2025 04:54:43 -0400
X-MC-Unique: 3w4ejb9KPcyD4E_IWPvzMg-1
X-Mimecast-MFC-AGG-ID: 3w4ejb9KPcyD4E_IWPvzMg_1747731282
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad55e9a80acso166566066b.3
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 01:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747731282; x=1748336082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K84RlwjKxdVMrP8H1/lSZbVNtNLQI+5UHNrYUWsQ7to=;
        b=Ppl9V4J3yaINDgIHX7+5m8cgeQMXOz0C8L+O9hxxTaQOPgMAKFOT4umQJKys93Tsjq
         AYAHR9EV6oX6BqLr9g+cuqPFHQEOJ08jXW49KeIZBgBYevP1XC9OK9k9qHMMhEoSaGuU
         6zItuKsVXSGIhJ9BQy6fJKvkA6eqWg8LbO7JIsUI7VqNl11+J9ESaVIDpAFaHVIefCvI
         55DvO0fEqxGTBnp6zJzxg5EVVjEvLc53l5+hYlo851/SfjsHjvFwBRWCXlxClf1Tp9Y0
         Mo5MIP8tiufQfhyLkLj/z1aejjx7kpgUSQheyRl+DU66dwrsQZVPZWLTLQXSnBZVIHLW
         wBSw==
X-Forwarded-Encrypted: i=1; AJvYcCXx10SGp7leY1o2mm3kZ0YAHWY7RD8OUuxB6N2tYIOeICO3xAO2Jk3y1URBAiI2bAEMVQNTAa7yfbmEAKGzrg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6ytVp2bablZsYqkTb0mKp/RinOc1c0YxxguwTcmLsFkvWgQwD
	P3+jfbTp0HLbAn/udyJGYE+l5zOIzwjofY9jKiCRD00YtchYU9SgG0QpMx2Nr/2eMKFrum+1nOZ
	CiDLAO39cxcXYYk8tD3qifX2kwOuomnoxJtBbYAWgtAxRk30t3xhHJiqAiUnL6OU7OzfK
X-Gm-Gg: ASbGncvDrr3oM7u1b4VkCTV7hFyEmRhV+X3IdCwsYOr1LxVxFyVyp8HsMw8zw3lFsVA
	hGQI2QPei7PlFi5C44MwLmd+VaQVBR/uoi7qAjci9/cd50nEu6A8u0RXBrOA46OGeWuiCiyZC6j
	fAsydjsFT2tDKVa0xDx0IoHu3yFbuKsoUGpVLnDwsnFZoWEPDGaCCe5EmIiIB3CNJ1B5vi2x2aW
	DNjuE/fCg+jrvEpiMVcdACsVJ18xDNH/E12yN278HyrI9Ofw10iiRPIqW47u2APFvTPqnCbh9YS
	9Q57DdCiOrognGfiIfmuwMd/9yZX/6qcStjC+Tw9Gw1IdbL57h7LQxrk6eEd
X-Received: by 2002:a17:907:7e87:b0:acb:5c83:25b with SMTP id a640c23a62f3a-ad52d42bf0cmr1554049266b.7.1747731282082;
        Tue, 20 May 2025 01:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1u3cs6wd8rFHSzcQTyYA8XLXVHbvNEiRktGHBow2x1xCtVqQdufsC3hsDqcyuuMCDDTKafQ==
X-Received: by 2002:a17:907:7e87:b0:acb:5c83:25b with SMTP id a640c23a62f3a-ad52d42bf0cmr1554045766b.7.1747731281366;
        Tue, 20 May 2025 01:54:41 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278282sm689962766b.80.2025.05.20.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:54:40 -0700 (PDT)
Date: Tue, 20 May 2025 10:54:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] vsock/test: Expand linger test to ensure
 close() does not misbehave
Message-ID: <37c5ymzjhr3pivvx6sygsdqmrr72solzqltwhcsiyvvc3iagiy@3vc3rbxrbcab>
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co>
 <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
 <CAGxU2F59O7QK2Q7TeaP6GU9wHrDMTpcO94TKz72UQndXfgNLVA@mail.gmail.com>
 <ff959c3e-4c47-4f93-8ab8-32446bb0e0d0@rbox.co>
 <CAGxU2F77OT5_Pd6EUF1QcvPDC38e-nuhfwKmPSTau262Eey5vQ@mail.gmail.com>
 <720f6986-8b32-4d00-b309-66a6f0c1ca40@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <720f6986-8b32-4d00-b309-66a6f0c1ca40@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6v4yb7HDUBUPu8LH8avmQJ3Y_jPAHb9RyCyNxqs35xM_1747731282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 12, 2025 at 02:23:12PM +0200, Michal Luczaj wrote:
>On 5/7/25 10:26, Stefano Garzarella wrote:
>> On Wed, 7 May 2025 at 00:47, Michal Luczaj <mhal@rbox.co> wrote:
>>>
>>> On 5/6/25 11:46, Stefano Garzarella wrote:
>>>> On Tue, 6 May 2025 at 11:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>>
>>>>> On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
>>>>>> There was an issue with SO_LINGER: instead of blocking until all queued
>>>>>> messages for the socket have been successfully sent (or the linger timeout
>>>>>> has been reached), close() would block until packets were handled by the
>>>>>> peer.
>>>>>
>>>>> This is a new behaviour that only new kernels will follow, so I think
>>>>> it is better to add a new test instead of extending a pre-existing test
>>>>> that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".
>>>>>
>>>>> The old test should continue to check the null-ptr-deref also for old
>>>>> kernels, while the new test will check the new behaviour, so we can skip
>>>>> the new test while testing an old kernel.
>>>
>>> Right, I'll split it.
>>>
>>>> I also saw that we don't have any test to verify that actually the
>>>> lingering is working, should we add it since we are touching it?
>>>
>>> Yeah, I agree we should. Do you have any suggestion how this could be done
>>> reliably?
>>
>> Can we play with SO_VM_SOCKETS_BUFFER_SIZE like in credit-update tests?
>>
>> One peer can set it (e.g. to 1k), accept the connection, but without
>> read anything. The other peer can set the linger timeout, send more
>> bytes than the buffer size set by the receiver.
>> At this point the extra bytes should stay on the sender socket buffer,
>> so we can do the close() and it should time out, and we can check if
>> it happens.
>>
>> WDYT?
>
>Haven't we discussed this approach in [1]? I've reported that I can't make

Sorry, I forgot. What was the conclusion? Why this can't work?

>it work. But maybe I'm misunderstanding something, please see the code 
>below.

What I should check in the code below?

Thanks,
Stefano

>
>[1]:
>https://lore.kernel.org/netdev/df2d51fd-03e7-477f-8aea-938446f47864@rbox.co/
>
>import termios, time
>from socket import *
>
>SIOCOUTQ = termios.TIOCOUTQ
>VMADDR_CID_LOCAL = 1
>SZ = 1024
>
>def set_linger(s, timeout):
>	optval = (timeout << 32) | 1
>	s.setsockopt(SOL_SOCKET, SO_LINGER, optval)
>	assert s.getsockopt(SOL_SOCKET, SO_LINGER) == optval
>
>def set_bufsz(s, size):
>	s.setsockopt(AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE, size)
>	assert s.getsockopt(AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE) == size
>
>def check_lingering(addr):
>	lis = socket(AF_VSOCK, SOCK_STREAM)
>	lis.bind(addr)
>	lis.listen()
>	set_bufsz(lis, SZ)
>
>	s = socket(AF_VSOCK, SOCK_STREAM)
>	set_linger(s, 5)
>	s.connect(lis.getsockname())
>
>	p, _ = lis.accept()
>
>	s.send(b'x')
>	p.recv(1)
>
>	print("sending...")
>	s.send(b'x' * (SZ+1)) # blocks
>	print("sent")
>
>	print("closing...")
>	ts = time.time()
>	s.close()
>	print("done in %ds" % (time.time() - ts))
>
>check_lingering((VMADDR_CID_LOCAL, 1234))
>

