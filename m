Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18766205503
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167792; cv=none; b=uCUGmP6zFsWkO+72Mn/cEK8rLqs54BI33vpmwdcIK1QBaM67nVh3fJfLRJNS+rr6JE1m3RdN//rmnAimD0j/tttCs+Ozfo30CaF0pfGwjlNHPR96fDHkwlD9SSyhkJdahmOhi2fabYOBDsmZ7mvLYvmfafHTMhCFfIM821XElXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167792; c=relaxed/simple;
	bh=imtuAnpaAXGOP6kzkiTdpwhJ9L3ewSs/OCqwVl5NK7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q+EjshCzOvOHnPLQX35TR5T04co1y/tIsGnylVOkvi34Z6Rv4x1PjHQG1MCNkgDvb8mEcRNc3rEfdt1uX22wScdwfXZVwrxrQs/LGLuK2FCt+hjwol5n9CF+Qy/k5JADvflfqHZluzw52877HAf7iSX+czEp6An1z1qvO+Tx+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihSGKRRI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihSGKRRI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A79D940906
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vj4odJcQVVPB for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 09:43:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4F61C40903
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F61C40903
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ihSGKRRI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4F61C40903
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vq2Dveu3Lu0iWioX9TM10BGhlOQ2RzAuJnxk7fM0ty0=;
	b=ihSGKRRIFGYYIBdoV/IaFez7xFG5hCQPZ/IUdxNbrmoySsiLxNHRucHBhqAZ8aHDpKhjOu
	La8vWnoo0vgO1f4fkRRQR/6UOWSFV3x9OdMIexYfUrYIZ8GHTDrJFKlUd4zAHvEaqCQUFo
	Erzh8RVa//KUJFbrhnFkugfHX7T2d+0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-FqN1Xar1OKiPfOxNrk5e-w-1; Wed, 05 Mar 2025 04:43:04 -0500
X-MC-Unique: FqN1Xar1OKiPfOxNrk5e-w-1
X-Mimecast-MFC-AGG-ID: FqN1Xar1OKiPfOxNrk5e-w_1741167783
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abf748e5f18so77647966b.0
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 01:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167783; x=1741772583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq2Dveu3Lu0iWioX9TM10BGhlOQ2RzAuJnxk7fM0ty0=;
        b=lWMpRUH9ciyG780Bfcpb+bVvCnpGEMar4kcDUFNXwyOjpoqXBMqJOaeXzYNrMubQmC
         uvEtNTdayEdnXq8adQQC+96SlHDnkpL857RDfmSDuYuU21tGCcvcLfxdwOg22bjZPnzW
         N2r0AYZ3m8OdmTttoL04k03Bkfv++jiRFAykfRLONgCiILJaLmJ9JJvcPIolXR1+FZ/p
         p2iU8kjTcWhvBZeqKCMahmZGhQ0hNOXEifJRFh8oYL51BtWXMIf08/kJvPJ2h1IqzQHA
         M8MBcnjqHzlhQObFW6lq7jkWAvMNZhcDEIloXbjTaR5+fKnWjqK6bP+laa2IWuW+ZfsH
         idng==
X-Forwarded-Encrypted: i=1; AJvYcCV7QZl131rn85Kovky6NrgodQX8PTwwKv6Rti/dD/DczelFBpAZRcOyC5t9ivLbeVesDWMXnDnF84hRZooAog==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyadrDwdLzMemiDCoi58CSUoHhYZq/kWQsMu4+66TfBLBmi7H4H
	MezGEvbkxJZb4b4gJJJQ/112/zZGsZdjsJHuxrLF7JpoTNpBNlu5HBh1my57rxDn8boJCHgddyy
	it8tpHwsbmELFfJes2wfUzRPovk5rsf0hXzO+Wf0keNM7TA/VGR6DAcvcacmKqwF2HE+pLxiWiJ
	hIfpQ=
X-Gm-Gg: ASbGnctEciD1yTd8o3jDB0XegKKJ1FZ1vROashbvaHJ4gIHACKmnc4PbtQlTKLhbvSg
	TPXtensSzDExoNh1mbG42iJsETGTI3lZ0Glfc2xSmCRrdNFeWKKIOL2UQc6qpsxyjSlCA7fITOI
	iGcCkALM0Q9P0jtJ6Kr9+SVCsidY0z1YVAyTUuIJ4RmUdRazu4lIW9tXvW21etewbS0VKISA4yp
	ORr7Uf7zV0hc8mreH6/BSH/s8SaSQTr3DFo+0bVQzbALNsz28jUy+z11uuSM2Z/mTWCrf6TD1NL
	SVgK0M+D+7FXBAfFaCHi4WuMbTJkRDuHEXwJ6K3gEr4GTZQ3GHFLLbgyyO6YcHkX
X-Received: by 2002:a17:906:c148:b0:ac1:f247:69f5 with SMTP id a640c23a62f3a-ac20f0139aemr209684766b.28.1741167783275;
        Wed, 05 Mar 2025 01:43:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5B6S50i1HDHEaJU/jj+bI1k8KZTn2nF4k4C13v/0HHoQCH0wJ+1c900aMe64d5Ks6YGak+w==
X-Received: by 2002:a17:906:c148:b0:ac1:f247:69f5 with SMTP id a640c23a62f3a-ac20f0139aemr209681866b.28.1741167782581;
        Wed, 05 Mar 2025 01:43:02 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac21dd2c297sm28756566b.110.2025.03.05.01.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:43:02 -0800 (PST)
Date: Wed, 5 Mar 2025 10:42:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Dexuan Cui <decui@microsoft.com>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <cmkkkyzyo34pspkewbuthotojte4fcjrzqivjxxgi4agpw7bck@ddofpz3g77z7>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <Z8eVanBR7r90FK7m@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z8eVanBR7r90FK7m@devvm6277.cco0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 80PSqsnN4gcaYHvwpTVUduY9gaIHz27tbuudU0FPRDI_1741167783
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Mar 04, 2025 at 04:06:02PM -0800, Bobby Eshleman wrote:
>On Thu, Jan 16, 2020 at 06:24:25PM +0100, Stefano Garzarella wrote:
>> RFC -> v1:
>>  * added 'netns' module param to vsock.ko to enable the
>>    network namespace support (disabled by default)
>>  * added 'vsock_net_eq()' to check the "net" assigned to a socket
>>    only when 'netns' support is enabled
>>
>> RFC: https://patchwork.ozlabs.org/cover/1202235/
>>
>> Now that we have multi-transport upstream, I started to take a look to
>> support network namespace in vsock.
>>
>> As we partially discussed in the multi-transport proposal [1], it could
>> be nice to support network namespace in vsock to reach the following
>> goals:
>> - isolate host applications from guest applications using the same ports
>>   with CID_ANY
>> - assign the same CID of VMs running in different network namespaces
>> - partition VMs between VMMs or at finer granularity
>>
>> This new feature is disabled by default, because it changes vsock's
>> behavior with network namespaces and could break existing applications.
>> It can be enabled with the new 'netns' module parameter of vsock.ko.
>>
>> This implementation provides the following behavior:
>> - packets received from the host (received by G2H transports) are
>>   assigned to the default netns (init_net)
>> - packets received from the guest (received by H2G - vhost-vsock) are
>>   assigned to the netns of the process that opens /dev/vhost-vsock
>>   (usually the VMM, qemu in my tests, opens the /dev/vhost-vsock)
>>     - for vmci I need some suggestions, because I don't know how to do
>>       and test the same in the vmci driver, for now vmci uses the
>>       init_net
>> - loopback packets are exchanged only in the same netns
>
>
>Hey Stefano,
>
>I recently picked up this series and am hoping to help update it / get
>it merged to address a known use case. I have some questions and
>thoughts (in other parts of this thread) and would love some
>suggestions!

Great!

>
>I already have a local branch with this updated with skbs and using
>/dev/vhost-vsock-netns to opt-in the VM as per the discussion in this
>thread.
>
>One question: what is the behavior we expect from guest namespaces?  In
>v2, you mentioned prototyping a /dev/vsock ioctl() to define the
>namespace for the virtio-vsock device. This would mean only one
>namespace could use vsock in the guest? Do we want to make sure that our
>design makes it possible to support multiple namespaces in the future if
>the use case arrives?

Yes, I guess it makes sense that multiple namespaces can communicate 
with the host and then use the virtio-vsock device!

IIRC, the main use case here was also nested VMs. So a netns could be 
used to isolate a nested VM in L1 and it may not need to talk to L0, so 
the software in the L1 netns can use vsock, but only to talk to L2.

>
>More questions/comments in other parts of this thread.

Sure, I'm happy to help with this effort with discussions/reviews!

Stefano

