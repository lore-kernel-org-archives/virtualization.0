Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F12269D16
	for <virtualization@lists.linux.dev>; Mon, 28 Apr 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848623; cv=none; b=Tnamy+VrBk07ULqwTBDn/IjdIx3ZaQupSAMhIF1XhETAfxwHXi0Vaulf5BrXfsKlmNnEXbUMHyuw+F2wbDFfq9w7umlCrJjlYlEn69O1WsXQ/KKUvjIWsJk6UPXy18IzNbQJOdU70AfqCWbaIphGgN9n70lZGzeOIo31gZvS6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848623; c=relaxed/simple;
	bh=70lfu/B2ib3SJpO5ooGMaAt1QBpRSWIEV/Np9sKATMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rOku5qjhkvji18MLDOmaST3xNzvXOks3jjX4iEX4Ib+7yqaDVMUn1VKyossMqF7aZfu/Asl20Y+UO8IVWg7EDWp5JgBvx5ZnaEBu4DLS+jA3ShyJ30dB77pggJEROJq6NJmn/NoQjVeI52QYerqCzgRaiJXNr1XgGeOPUqlMXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwAih4/j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwAih4/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745848620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UHyYAaJAMEZKibWtlyqh2W6HZtpo9zi498VVY4y0rAg=;
	b=IwAih4/jkU+Ra+U5JMFKoKAAtGzLZSHEUgXmSw8SNKzaBJBjHeB4eibuL4rIIPhD/oML+A
	fgOi1hAEbwNIqtuaKQZwfSz8ZkTfHHq1LzF89GmVuBCmSvn+zcvDKm+H47YSKItqNV1+FF
	ny+ue8TD1+wLyIzY7uIKfPwAjY/4Fi8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-vmwqVLYiM1-Y_J5G-Y44Tg-1; Mon, 28 Apr 2025 09:56:57 -0400
X-MC-Unique: vmwqVLYiM1-Y_J5G-Y44Tg-1
X-Mimecast-MFC-AGG-ID: vmwqVLYiM1-Y_J5G-Y44Tg_1745848617
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c95e424b62so629363085a.1
        for <virtualization@lists.linux.dev>; Mon, 28 Apr 2025 06:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745848617; x=1746453417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHyYAaJAMEZKibWtlyqh2W6HZtpo9zi498VVY4y0rAg=;
        b=AqE6uYlc3MNceCmebKDLPY5PTCxyOUHgguertJXBXBG4/4g98jWhBXPlAEgrCY9haZ
         jkfV4oYus/qnWu5KYlVKF+u2jOdPrj72+074s3N/ai3cuFfSGrkuJSUgyPAdmYJ/VzQG
         jQrudGJxyRz7TiHYdsmvquFBx5hh1GYgQpWhDM7/ln18BwfZRwtk1Hq+ySfLPexm4CIl
         3RPN4fwH5ukmsHdH2TbXsZHsnPZxUV9unGL9czxtHsoFX4Frn2zHGybtyBEvRYDjVS3i
         9Am86wnhR5OsvEdd/Ztyz3lqDlCwFQfZRVYmUPntgjqD8j4Nymp92603EGQfhIXiOMpI
         W8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWWyBsDETimBm+iEz5lHi9e1OdR4zfW+HknRxx8Wbvk63tqnVo9zGYRzfgUqSMmuJnCkInMvor8egm72fdLcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgnduvixihEPchGWpfWO7S+kAvBsVMxFEJ7vte6ii70xV9NvHK
	aiQ+0pVVZvv1sL4dugPWrvq0AE4A4FqX7es80CrM8ZNg+RhUlBhBx7hWEoKxrBND9V+Zt67tU3l
	H/ni91a5L5XywMUrLaVjjwM9mdA6V62PH6GMLldzqtDoQvpe8qy945KR6h0V7rSoJ
X-Gm-Gg: ASbGncuqAyLO2BdEwBYUhsyatGRrVHXlLkOqjmRpetkSJEQEh3A9kO0mTJTllX1IlXR
	QU/n2U246z93lsVYWLYn779C0rpSMfTsbGlLeR1L6MzRrmL83QAtHqzkNNuzyNBIml3kIv8GXMj
	dHWmjxhc07ppFFBX6yXntqQFSFU87c5HGVEDaJVVlhRBqA3fGLCwN3cbLHMqU+N0IgKN92NvKFe
	KDv7zhxyY5/mh/XOR1+fMeKYeDO+ox42oynwKR1eiFFFAvs6Pe+YQnuVvSOgrGI5l5HJzfT69uC
	ySA1szCvSiTDqZJ0
X-Received: by 2002:a05:620a:2887:b0:7c0:a1c8:1db3 with SMTP id af79cd13be357-7c9585c5877mr2487229285a.11.1745848616957;
        Mon, 28 Apr 2025 06:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF77QtEVSxz59mKWcWmWXJCMGCmi0uBQwkt5f3Bu+dckdVzt5kbvV5X2qwCObb0VZdyOuwAw==
X-Received: by 2002:a05:620a:2887:b0:7c0:a1c8:1db3 with SMTP id af79cd13be357-7c9585c5877mr2487224585a.11.1745848616412;
        Mon, 28 Apr 2025 06:56:56 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.205.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cbd048sm623795385a.43.2025.04.28.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:56:55 -0700 (PDT)
Date: Mon, 28 Apr 2025 15:56:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Luigi Leonardi <leonardi@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] vsock: Linger on unsent data
Message-ID: <wff4t4owsukm2jynm2dhju4rrtegyjjlrhu7o5xppsxfqrcus4@wmsvcwkdtdat>
References: <20250421-vsock-linger-v2-0-fe9febd64668@rbox.co>
 <20250421-vsock-linger-v2-1-fe9febd64668@rbox.co>
 <km2nad6hkdi3ngtho2xexyhhosh4aq37scir2hgxkcfiwes2wd@5dyliiq7cpuh>
 <k47d2h7dwn26eti2p6nv2fupuybabvbexwinvxv7jnfbn6o3ep@cqtbaqlqyfrq>
 <ee09df9b-9804-49de-b43b-99ccd4cbe742@rbox.co>
 <wnonuiluxgy6ixoioi57lwlixfgcu27kcewv4ajb3k3hihi773@nv3om2t3tsgo>
 <5a4f8925-0e4d-4e4c-9230-6c69af179d3e@rbox.co>
 <CAGxU2F6YSwrpV4wXH=mWSgK698sjxfQ=zzXS8tVmo3D84-bBqw@mail.gmail.com>
 <81940d67-1a9b-42e1-8594-33af86397df6@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <81940d67-1a9b-42e1-8594-33af86397df6@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HKEiQiNj3xWmNWdaiyj9q8fhQU8AS6trlX972rmzlDM_1745848617
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Apr 24, 2025 at 01:24:59PM +0200, Michal Luczaj wrote:
>On 4/24/25 10:36, Stefano Garzarella wrote:
>> On Thu, 24 Apr 2025 at 09:53, Michal Luczaj <mhal@rbox.co> wrote:
>>> On 4/24/25 09:28, Stefano Garzarella wrote:

[...]

>>> You're right, it was me who was confused. VMCI and Hyper-V have their own
>>> vsock_transport::release callbacks that do not call
>>> virtio_transport_wait_close().
>>>
>>> So VMCI and Hyper-V never lingered anyway?
>>
>> I think so.
>>
>> Indeed I was happy with v1, since I think this should be supported by
>> the vsock core and should not depend on the transport.
>> But we can do also later.
>
>OK, for now let me fix this nonsense in comment and commit message.

Thanks!

>
>But I'll wait for your opinion on [1] (drop, squash, change order of
>patches?) before posting v3.

I'm fine with a second patch to fix the indentation and the order looks 
fine.

BTW I'm thinking if it makes sense to go back on moving the lingering in 
the core. I mean, if `unsent_bytes` is implemented, support linger, if 
not, don't support it, like now.

That said, this should be implemented in another patch (or eventually 
another series if you prefer), so my idea is the following split:
- use unsent_bytes() just in virtio
- move linger support in af_vsock.c (depending on transports 
   implementing unsent_bytes())
- implement unsent_bytes() in other transports (in the future)

WDYT?

Thanks,
Stefano

