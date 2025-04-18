Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C32571B2
	for <virtualization@lists.linux.dev>; Fri, 18 Apr 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970835; cv=none; b=NGaJbhKQ/J2Hqss0RwPusrfFLwW7Q8arcqQZj/Xv9uHv2JexXOK4mJCk6d7SC8xjGIW1fHzsl2Ey9NXHm65hEkLkq6RWcln0AFiNN6WxZM7xZvkF9Dtmg2kW15l2aO3DGiC0EJbRDBvK3RTAURw0J3jHuOGnG/x3zyEPnzFA05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970835; c=relaxed/simple;
	bh=9ztD5QEKbZyDUWbK+PqKwSOd4E+kH7gk1b2fzZmLKYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J+Gh9XwD0xh/k60i62II5B3LV/ZdU4VLSWtpOC1MZliIB/vNnMpTFnpPHGf/TT2dlVK92KFq2JQXpIhKRmDMDMKhsJsVD8gwLfiFU10VR11Zcmdexm8ITALpNhzicKTUmq0odgCw5WFdRxZUQo4OmNurpIa6BcF5m7j8Vn7vgxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DM4nsaEL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DM4nsaEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744970832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9G5521K43w3dmM/mpU0zbZYMYOFcRmDMx1FAdvTmU0E=;
	b=DM4nsaELvbUsiW5LDf1CVtVmU8JhhYBhEGuY7l8j1eVP0tIgODsFd/E0vKBV15sDKfUKYp
	KzxNhxovRPJDzOxpB+bqf9m+73v143w4WI9OH/RnqEHS1Uwh0zkeriUt272vDtnCKE8LQ8
	G90pAT7E8ybD0OcBSuxfCPzp+q5BvGA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-EZFvdoM2P3CQ3dS67Hg9XA-1; Fri, 18 Apr 2025 06:07:11 -0400
X-MC-Unique: EZFvdoM2P3CQ3dS67Hg9XA-1
X-Mimecast-MFC-AGG-ID: EZFvdoM2P3CQ3dS67Hg9XA_1744970830
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5f05d36993aso1730035a12.0
        for <virtualization@lists.linux.dev>; Fri, 18 Apr 2025 03:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744970830; x=1745575630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G5521K43w3dmM/mpU0zbZYMYOFcRmDMx1FAdvTmU0E=;
        b=d4BkLq5VXDC8e8Tk1kdvTfHemrmUgAQP5aEw1jjWbCcTsMAnI2MeUAhTKW/Bkpg3tf
         CJVYuPXqB+RpPsQv/+2UvT0QyhuhXoH7tri6eWELpszJbqiP5B/NwAhbkJxMpYtT5wNa
         rD1rx4t1WNS3uA+tfvj8XRA7MDYvJdIgLyDEt59ZcQMztghZVbliuCLcIhcPJYxJMhq7
         uvzsjvi7dkBXsIg46l0CLpCKRMQKqnUzWBTMXMCxsrnmtcAXMojDMIL8KrjyTw8FM1sB
         lq06g+c0TPhlLIun04+DLcbDaSbeX/F+FlyhaZ8eZ9IrL8sPbVIRDAYa2I14gVnimVcr
         ZAdw==
X-Forwarded-Encrypted: i=1; AJvYcCWz7wXbDcI2+3jZYrC/NgHsgaq8C9aMzeHzkXtYwCwlr9ga/qxDkO/gGvgy6P5bQuB3XZ1qNiulOXgyZqq/sw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzc32bA1LKZwpvs8Xc4jcM3tfvmhdjGx3AD/R/SEzWY6/D6U/aw
	ST/BUosT3Tvkq5BSOnC0xZVRstHmDl14RyRikGpLR6ZKI6bswjdI+x1XAoqcdgyjOflzcXaYDNQ
	PR0izKSGIhOkluOvt+0fg/g5qJGuenFhldEJHUhvEebB6qxZ56kJkMXZiNWcVqCIJ
X-Gm-Gg: ASbGncuzp1SuEM21KecdL+CWym4dKrkazDIncGQMEZwFuCWc6LpdyOrX/2rbSpVkfxf
	R63IK/opOKfC5NIa8m7TTA3zXN1kVG4sz8wp6FK4iJlcaSO311nyHhfBNn5CTlWNF+KOGbB9xOY
	PgVBkmvC1NGs7B1UHZzN+rcDJ+yV1M8d3FtNwOKPmbacWLXmqREfpwPEeBmIO8vzHo6AaS4UFIq
	3kkkyumaF6JIgYE6bFmVmu1sXwJEfowaqcMvzAEyUmwmv3Xs6A1nEDrTOhvjk7m+eHRCrq24dgZ
	J6c7mOqPm2VYRKIFDg==
X-Received: by 2002:a05:6402:4407:b0:5e5:49af:411d with SMTP id 4fb4d7f45d1cf-5f6285460f7mr1805160a12.17.1744970830038;
        Fri, 18 Apr 2025 03:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTKd6NM4kSkW3Otx/O/66Pab50SH+6TRF4InR2WHUY4N/RGC6Eyk+ZoPTNIfSCaBgzl77j2Q==
X-Received: by 2002:a05:6402:4407:b0:5e5:49af:411d with SMTP id 4fb4d7f45d1cf-5f6285460f7mr1805127a12.17.1744970829477;
        Fri, 18 Apr 2025 03:07:09 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.130.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625592cf4sm820284a12.36.2025.04.18.03.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:07:08 -0700 (PDT)
Date: Fri, 18 Apr 2025 12:07:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] vsock: Linger on unsent data
Message-ID: <baamf74wjdpk7ji3hmsyzjr6ngu52qq6au6gcnc5vahlacpenx@rccaffrt6vub>
References: <20250407-vsock-linger-v1-0-1458038e3492@rbox.co>
 <20250407-vsock-linger-v1-1-1458038e3492@rbox.co>
 <22ad09e7-f2b3-48c3-9a6b-8a7b9fd935fe@redhat.com>
 <hu4kfdobwdhrvlm5egbbfzxjiyi6q32666hpdinywi2fd5kl5j@36dvktqp753a>
 <a3ed036f-5153-4d4c-bf71-70b060dd5b2f@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a3ed036f-5153-4d4c-bf71-70b060dd5b2f@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1zICEEvho2aFLcrxr-kBtceDzKjuqqI4enoQatdWbbg_1744970830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 16, 2025 at 02:36:52PM +0200, Michal Luczaj wrote:
>On 4/11/25 12:32, Stefano Garzarella wrote:
>> On Thu, Apr 10, 2025 at 12:51:48PM +0200, Paolo Abeni wrote:
>>> On 4/7/25 8:41 PM, Michal Luczaj wrote:
>>>> Change the behaviour of a lingering close(): instead of waiting for all
>>>> data to be consumed, block until data is considered sent, i.e. until worker
>>>> picks the packets and decrements virtio_vsock_sock::bytes_unsent down to 0.
>>>
>>> I think it should be better to expand the commit message explaining the
>>> rationale.
>
>Sure, will do.
>
>>>> Do linger on shutdown() just as well.
>>>
>>> Why? Generally speaking shutdown() is not supposed to block. I think you
>>> should omit this part.
>>
>> I thought the same, but discussing with Michal we discovered this on
>> socket(7) man page:
>>
>>    SO_LINGER
>>           Sets or gets the SO_LINGER option.  The argument is a
>>           linger structure.
>>
>>               struct linger {
>>                   int l_onoff;    /* linger active */
>>                   int l_linger;   /* how many seconds to linger for */
>>               };
>>
>>           When enabled, a close(2) or shutdown(2) will not return
>>           until all queued messages for the socket have been
>>           successfully sent or the linger timeout has been reached.
>>           Otherwise, the call returns immediately and the closing is
>>           done in the background.  When the socket is closed as part
>>           of exit(2), it always lingers in the background.
>>
>> In AF_VSOCK we supported SO_LINGER only on close(), but it seems that
>> shutdown must also do it from the manpage.
>
>Even though shutdown() lingering isn't universally implemented :/
>
>If I'm reading the code correctly, TCP lingers only on close(). So,
>following the man page on the one hand, mimicking TCP on the other?
>

If this is the case, I would say mimic TCP for now.

Thanks,
Stefano

