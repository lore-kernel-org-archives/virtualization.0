Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676F43D4EC
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837622; cv=none; b=fE+g4K1djIFj2HKaoy2xSj+veFmBs+K2o1Q6T5yADY/2g8AqH1IN7yrZbPOlf/z4UWYbwXJmentTjyVYppsiAOxTKyOlfxpot8KNsfiEqkiDg/AVk8TCo/6ix+8mO5QYTOlMyRKOS1L/mdg8PmIoXx1nCM6riW21mzJXHxgoCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837622; c=relaxed/simple;
	bh=HzcXf6Wv0llfWEbLwfcl50s7dD+w0VdR0+2YgR8e0cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ho8oI/AQe720FmdTm/RCOyjjftXldFgJM2aFfZPNKQpV9TGqiym/9/4wLCF4lH7otQmORxKoKRs5LmgEpJp0/ClGWuylFvKDpmHR6yKeNVpHZJS9aKfg2RzVs5mFLjbA2kpTrg0Nn1q/pmCpuAw5A3HdrDRVIBhEMQ2bs2wei+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JprKPrdI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JprKPrdI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778837619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ42ILoPPEodEg6ZEuswA8B5A9RnneHFtROSVsVKJFY=;
	b=JprKPrdI/EqzNS0ZT+/pc7IqUlYuReltXPj23IGXzOWf9xCI+CHJ8zFVVkUZp4U0pKzBj8
	N9Siu/FyW1FZCbwiBnKVLpobx4FhSryhjboKZLiRRbn2M4IBbAdN872XEnx7kXibHmef1C
	diXU0jgFwiSM78n+OUd/4K0RcbadL+0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-RLrekLsCP9uDncHO5Mkb8Q-1; Fri, 15 May 2026 05:33:38 -0400
X-MC-Unique: RLrekLsCP9uDncHO5Mkb8Q-1
X-Mimecast-MFC-AGG-ID: RLrekLsCP9uDncHO5Mkb8Q_1778837617
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ae994d9aaso4607780f8f.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 02:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837617; x=1779442417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ42ILoPPEodEg6ZEuswA8B5A9RnneHFtROSVsVKJFY=;
        b=leQQ/YsHL5+bTZ1sEGj1QxK+J+Oy6gBINSe8Tjw29K15lWAOOjL7P5e0vnfvfi9dMn
         KSAsUXqfKCZ6hduKaTznDFEFARhwApvg/4KNwyHPUDXCYoC5L8INauMoNUGVWixbMxJv
         CSHDFhKs2mFTpKJ7eNF0CNmCsxwJfJj1UW/CBQfkmkWTEo69Dnm5G0+pR4k4+GilyMqg
         rma+tmm1Kk6hSnHI3fdCgTobM3Z+f4Y/47lI7dirzAKFmrA5lMGVIOdYA8RqsQIzyudm
         l6cnWHTsWz2jHyfyx0X2xWuT083qA1aivDsLwwJKI/7Tys/PaTvJKcnY9Va3Pepxbna3
         WTEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qybTG7VlRRfl4rPIEwMfOcZGEDzcX7i0RQMeLAOlKALs+EF//QcHwFQs3U/YhhkGiibeK6+toh03FppmR/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxvz8eeW2a/ZmiPVDY8mN6m30duIUd8EdlbyZYOz8JZXPqmpURh
	oWdqYktg/MatPHb7sm8xbIhKA1514/rgd8KJet+a4PrARYMiCXExYhiENOxzLS12h4V5Qdu9zaO
	ncVm6kSU31+uryERL+Mvu5c7mEQjHH23ROy59ZwhJKk1HTpYLUTj15vVZFdU/4RaBhPow
X-Gm-Gg: Acq92OFyA9MKiEoVclZjA7tejG4qtnLK7H5gPtYMiSe0QaHVeAhC425OUHTQqVRKKCs
	R1CtFJ7X8/AQhz+9KjkKNrK/asdB5jz1qpFwU8/iq1GHEKoJ0Lyjba0K5H/3mn5dz8jqoxSwkrE
	L94+RyobopeZjRRkfqcjTrL00c8NznB2qjCTNcCf1twLv6rUqAFWxhw0PMoRxYLaX35mZV+85sz
	t7E262aDLB3bma5t/qa9hsULcmihJe7NSg7vielw4DIGJA8q+4/uDQnHKinlFBBFO/V9fKfWMSd
	JS/Iaht8z48fXmMp3O0ufC8ixJW37H1Xv5/D+lawyq91Z4TpN8fkcQq6rYnWaUjfl/HRVx98+G2
	A95GgSNXX7u3iMJiD2PyfuXHlrDeRW+HN4Jh+jQTP6XGxcdicB4D3iLWH4peOTxMKlzYcr65dMA
	==
X-Received: by 2002:a05:6000:2288:b0:45d:4532:5d98 with SMTP id ffacd0b85a97d-45e5c57d2f2mr3913455f8f.8.1778837616858;
        Fri, 15 May 2026 02:33:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2288:b0:45d:4532:5d98 with SMTP id ffacd0b85a97d-45e5c57d2f2mr3913404f8f.8.1778837616358;
        Fri, 15 May 2026 02:33:36 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768bcesm14392867f8f.4.2026.05.15.02.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:33:35 -0700 (PDT)
Date: Fri, 15 May 2026 11:33:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>, mst@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH v2] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <agbn_R2XtH8K7aH1@sgarzare-redhat>
References: <20260513145842.809404-1-polina.vishneva@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260513145842.809404-1-polina.vishneva@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eziQoiigDnGY5JyPOn6IS1Pge8717h2QSzAs8EK4IWo_1778837617
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 13, 2026 at 04:50:04PM +0200, Polina Vishneva wrote:
>From: "Denis V. Lunev" <den@openvz.org>
>
>When the host initiates an AF_VSOCK connect() to a guest that has not
>yet loaded the virtio-vsock transport (i.e. still booting), the caller
>blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT.
>
>A caller that wants to know if the guest is up yet instead of waiting
>could theoretically tune SO_VM_SOCKETS_CONNECT_TIMEOUT, but it's tricky
>to find the right timeout, if not impossible: there's no way to
>distinguish "guest won't reply because it's not up yet" vs "guest is up
>and tried to reply, but was too slow".
>
>Furthermore, this delay is pointless:
>- If the guest doesn't initialize within this timeout, connect()
>  returns ETIMEDOUT.
>- If the guest **does** initialize, it'll reply with RST immediately,
>  because there won't be a listener on the port yet; connect() returns
>  ECONNRESET.
>
>That's also inconsistent with the behavior at other initialization
>stages: if a connection is attempted when the guest driver is already
>loaded, but nothing is listening yet, we return ECONNRESET immediately
>without waiting.
>
>Fix this by checking the RX virtqueue backend in
>vhost_transport_send_pkt() before queuing. If it's NULL, return
>-EHOSTUNREACH immediately.
>
>Callers that used to get ETIMEDOUT will now usually get EHOSTUNREACH.
>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>---
>v2:
>- ECONNREFUSED -> EHOSTUNREACH.
>- Use vhost_transport_do_send_pkt() instead of raw .private_data access.
>- Removed READ_ONCE().
>- Wrapped the condition with unlikely().
>- Updated the comment and the commit message.
>
>v1: https://lore.kernel.org/netdev/20260511145610.413210-1-polina.vishneva@virtuozzo.com
>
> drivers/vhost/vsock.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

@Michael I think this can go with your tree, right?

(I don't see it in https://patchwork.kernel.org/project/netdevbpf/list/)

Thanks,
Stefano

