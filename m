Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EDC477E51
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467419; cv=none; b=RKo4yWKRGaLk/pX+92kg3G8W6csIigHVkfiGJhCOOBCpmg8Bv7+eRS27Xzrj405Edt+eW22aVd+k0c/yqP+qJSLQI1/RnlB+XvXFar/KO7chQoBHancjY0Kb39rbfPMglltRA3UdfPVdVDHkC2eXTBUhpdFWu01r++ImFpLa4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467419; c=relaxed/simple;
	bh=N4fsCDWKXj8cFUOuROoEasUX7c1f/yp1SRGQJLzc1Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Acm1jHyYg8ZMh5f31SPHw9M5KgYmVRP1v1PQNZaEwx7A0KQNtB609zVe996qah63OwAsY+VtSOgDbxv716hCGcWdHwhQ3e07pThL03kk9DL8YTkIoX5DQSgulisA2jyKxSRTx1psLm+54GvgqqPNRM1BHs3Lbdofk/6uzEV1AOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpIm+PFw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpIm+PFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789467415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nl7n8UtlhHNNnQK/R4cfZiAkVCgsHC/OU98HtE4D5Wg=;
	b=cpIm+PFwCQwe6DdkUPdE5TAd7DghtihlWWYPw5djzD3pxCq9R+KMTq4eEL3QP8ZKYOZyKC
	VsjGHfinbp5odzwlyNeAXcAc+UmWH+gMdVnK0V55jmKcoJrazeNR62d44mg0pz0Mn1IAFn
	76TPZmgDMupwBWXzlLkPeL8C1gSgORU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-GXrW1lu5NmCXHcDrqjzgmQ-1; Tue, 15 Sep 2026 06:16:54 -0400
X-MC-Unique: GXrW1lu5NmCXHcDrqjzgmQ-1
X-Mimecast-MFC-AGG-ID: GXrW1lu5NmCXHcDrqjzgmQ_1789467413
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e735659b7so15882735e9.3
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 03:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467413; x=1790072213;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nl7n8UtlhHNNnQK/R4cfZiAkVCgsHC/OU98HtE4D5Wg=;
        b=HNU7y6qoqHfao8rA2hlw/YYbPWuaeUdw8o8+Q8D47QIhbmUYJNlK4pEZHpQZGiy6Qw
         u3kazHN7mrlr4zWY4cka0w6udm6x/SjwFZ6a5GXj7mpz2hmCCb/+xx63nmJ+T/4vAtKC
         Takr4U0saWmRYwDaGekwvZbqC00DYW4yBSxzDQdq7LAJp70vcvgKrsCiWqfnH+jscMUe
         A6bn+Cnw8AqFmB/DZc0QSZEMCD61q2JHGYdZIlORFKCtN/9jwzs5BiOlKBZcQhq+svNy
         TlKjTwiW6TXCRRMRHQU8ArEemOCGAQwqCAs4P3/LcxS804uDILZZiyEHQsHwG3OAAq8d
         nLFw==
X-Forwarded-Encrypted: i=1; AKwUvByU0oy3jHZj3zZMvOZkrbap9fBm+/QH1TYnwDqwC0uonxpc1PIt/4ejD236d/ceb/ebW9d3F35DKCZJIEtbeQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mokkULvKKGui8u0Fq4r1lod3wdG/UoLRVIVvd/u0XHT2gpNCqJ
	/ghnFp4RycXGWaDD7MgFtZfCMZM5qFQ3vMmqf5ijXIEY/zLizug1ScA+4ZjOOUUSVbsBPMvfyDB
	HkaxVZvRrtY//qxFzyrUzYRvMunNTJIasX8nMOrMy4r+ByP4vtcdmflx97mQkwenM0T9Q
X-Gm-Gg: AYBFou25QfM/hm0RBdHZIgY+rWpg91vjEj2ePc1hyaTYAcc7c/LfXVDM6VmlmZKp48K
	+t+QjeWIUXFSFv4xdsl7C/knJvxwMHU9Cyg1P2d1IAeU7U8G8zMRoj0avoO6eNrVDXJl+HF8ym4
	dLH+Do2wjKdSJlR7XJ6F0OGfh/kpnBn70NLEpOm4a206I0Z8vFr0xdtYOOAQLcyWOHhu6vc1pvB
	j5RALxZQbx5d33T39iH3WkWLpUGcE0/7VMGqkbOczbd62XDVbVnGW1bNfPct3ppCMUGecqFC4LG
	UyShEFVSbLynKk/uR9fyj4mST6/uCFIGc4EKrvnDU4KG5Yg7BDXHtxiYdqdx6xs/5BqKwUUgVbN
	DeFXLhz9ZVq/Kvk4QdirPzAEEscBxKdZI0fRdM/17eoBqFQ==
X-Received: by 2002:a05:600c:3145:b0:49e:74c6:d973 with SMTP id 5b1f17b1804b1-49e822c5633mr7078975e9.31.1789467412888;
        Tue, 15 Sep 2026 03:16:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3145:b0:49e:74c6:d973 with SMTP id 5b1f17b1804b1-49e822c5633mr7078495e9.31.1789467412452;
        Tue, 15 Sep 2026 03:16:52 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d69f3c0sm57509095e9.6.2026.09.15.03.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:16:51 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:16:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 0/6] vsock: assign the guest vsock device to a
 network namespace
Message-ID: <aqkaTXHDf5nfPL9w@sgarzare-redhat>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <apqGcFDFm9_Wtw4q@sgarzare-redhat>
 <apsANK7ySuRzzK0V@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <apsANK7ySuRzzK0V@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wmpJ2TaDvf0Z3iYRN0ZeFfT1Cu7elzYt615-SY9p5nQ_1789467413
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Sep 04, 2026 at 10:30:28AM -0700, Bobby Eshleman wrote:
>On Fri, Sep 04, 2026 at 10:55:17AM +0200, Stefano Garzarella wrote:
>> On Wed, Sep 02, 2026 at 04:00:46PM -0700, Bobby Eshleman wrote:
>> > vsock network namespaces let a host put each VM in a namespace of its
>> > own. A guest has no equivalent yet. It has a single G2H device that
>> > cannot be assigned to a network namespace.
>>
>> Thanks for this, I'll do a proper review next week, in the mean time some
>> comments below:
>>
>> >
>> > This series lets a guest move that device into a network namespace. A
>> > new ioctl on /dev/vsock, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, assigns the
>> > device to the namespace of the calling process. The namespace's existing
>>
>> Why an ioctl?
>>
>> I'm asking because I'd like to know if you've already considered any
>> alternatives (sysfs, netlink, etc.)
>>
>> How do you think the ioctl should be used? Should we provide an userspace
>> tool, or extending some existing tools?
>>
>> Thanks,
>> Stefano
>
>Really only because /dev/vsock exists and the prior series used it.

Yeah, I vaguely remember that we may have discussed switching to netlink 
in that thread, but I can't find it.

>
>Considering netlink, it might be the better option because there is a
>lot of prior art solving problems we might have in the future. For
>example, I was thinking about when users suddenly lose access to vsock,
>with just the current assign ioctl there is no way for apps or users to
>figure out why this happened. We can have an ioctl() setter for user,
>but in netdev world users can actually get a notification via netlink as
>to which namespace the device went to and what its ifindex is there (see
>__dev_change_net_namespace() for the RTM_DELLINK and RTM_NEWLINK
>messages). There is probably more, but that's the case that comes to
>mind.

netlink seems like the right way to go, do you think it'll be a real 
pain to implement?

>
>>
>> > ns_mode then decides who may use it: a "global" namespace shares the
>> > device with every other global namespace, and a "local" namespace keeps
>> > the host connection to itself. The device starts out in the initial
>> > namespace, so until the ioctl is issued nothing has moved and no mode
>> > has changed. There is no explicit unassign as assigning the device back
>> > to the initial namespace is equivalent.
>> >
>> > The ioctl requires CAP_NET_ADMIN in the initial user namespace.
>> >
>> > Connections that can no longer reach the device after a move are reset,
>> > so that a namespace which has lost access cannot keep using a socket it
>> > opened while it still had access. Following netdevs, the device returns
>> > to the initial namespace when the namespace it was moved to is deleted.
>> >
>> > Transports opt in through a new netns_assign_allow callback. Only
>> > virtio-vsock implements it here.
>>
>> Why? (Not asking to support all the others, asking to explain the reason or
>> ask helps from others to extend it)
>>
>> Thanks,
>> Stefano
>
>Sure, can add a note here about extending it. I just didn't want to
>implement code without having an environment allowing me to test it.

It's fine, I'm not asking you to do it ;-)

Sorry again for the delay, I hope to review this series today/tomorrow.

Thanks,
Stefano

