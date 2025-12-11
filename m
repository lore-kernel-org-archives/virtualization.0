Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E043B8D4B
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437035; cv=none; b=okU5wP6Jxk3g/pepWY2IowDN5Tg9gfb/dKCGcUDqShk623p+MoCjX+46GA4TdkLikTI4AdDBAw5xtM4USXBxLMkG9PslhSE57esLMxmGbNz83oigVTFY4Z/od36o+ZL7K+V6iO1bUWpWTMcmN0QobI6qr/Lc6hwLUnUfAvjf82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437035; c=relaxed/simple;
	bh=CiFp2+zFRB9i/4xjpT0D8q8ZwO9oBy0y973OZpeym7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Wnu/qg2jWozd3HejqZBqzR8dRDHdEymCk5EFiCVB1Y/NVjBB2oyDNpCM+nuekqgSPkBI00Enli9P3Szrv7AN2FIcUany/ztLbqURkL19578m5jkE4NlNWH2SQTqThBdDUQRd3K58OsED/6538IJ4uJ+o/CBKNHnTYW4Kdgbf6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4Oo0wvK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4Oo0wvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765437031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7zIAXrb2IdU4JYv9VJI9oSFYqli58AZDxU70CDF1h0U=;
	b=e4Oo0wvKkbdreA5h2mX6CSGRlm1c+2NUsNC7jmnxYRwv6LfbDV+7ILLe9iga8YP47npKhP
	M2VcJLm3wxjJ8oTQqdDL9JvdICedUQ51W+ihr4Odj52XLer6vfQB7JqQvj6e0hHqd3Hil2
	GLpzrNMgKFCwsu5bNx7hQI715NIdZP4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-WnkNAtYLOO-EUa_f3F2U7w-1; Thu, 11 Dec 2025 02:10:30 -0500
X-MC-Unique: WnkNAtYLOO-EUa_f3F2U7w-1
X-Mimecast-MFC-AGG-ID: WnkNAtYLOO-EUa_f3F2U7w_1765437029
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b352355a1so817848f8f.1
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 23:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765437029; x=1766041829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zIAXrb2IdU4JYv9VJI9oSFYqli58AZDxU70CDF1h0U=;
        b=uHbDBxl9lZRZ1HuvzU3fxNOBWG/joruFlqqMVIfd07G45D2/3oWTkWpAhD8Pt1i3A+
         RHC7+E33xQ16krcBKkoHOPcLklDRd47vvD0/IRBq0E852Xo63lUwZKpf1du0tsjmBQvf
         tQZdUlpwDd3Sxh5zn0QgeD4tJdpW/fTs90abJ34VUxld8H/OjIgkbEySkwVAMxDf370I
         dr7BJAQJhwKJFDD3ETcSqmxK7CTsgaPFhzfYt/lJjRYxbhTcKRux0Pya3Zrww/EpMPLj
         iElEscsXITjtnQfUFsuNgLIm5/VSF6QyFzzjuzy61o1rELkrwAG/1w8Zd/00W0H60nDj
         gtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpJDHSDPCSnUO6V49/6FzstFRPm7SMVsDqpLbQqsu24SjSGSjPjWeZdeNE75TFS7VycGcIvzG7rVmH30m8RA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5K0yyIjA58IIovMj9M02KHpZxYUTQL5al17XLXmAec+F4c07B
	19lW1HV52aHOgL08rxmIlUiZ+80WZjKdPGaCrueHX4VaWVjA/ySuKbFxyrXXBmljgRlU1rpDRip
	cL1beGpFQScSQFUeGDQH4cBspL8vAejhULRpKKUtbtzDQC23DTifPaXsbocZa6v76bMlU
X-Gm-Gg: AY/fxX6hRPnxCw4HNm4XSOvnZ51YtOLD37UabTmY/uqORuFcdn/Qr0Oyyo3hN2H59kI
	TYhBM6fs50baSXzxlY52/pitSCjv0rDmzYHw/4IngnUecJNpNP1S2qLXuaT+l+bU9KG89bI7jAr
	bk3kIQ/2L9ZyMfGaQKThPsNNkjXzkeiwAADQJ4gBMor8UMlQEgIniY4FuFD3UzliigdWxcEdoux
	VessNC+dr5CdjBjLRU1t49FSZwI8sDlZ4+hgEcJd0fYkRTNdppCQDvloVXx5q54fNAmCKH2g5ma
	GN6/44PpRcxdKO9hSiC9oRXrM59tNoN3jDCpy+rGYQ4rx/8Foe8qFDA7i2snhS/rD7gvW7ubPrX
	p+9NmMQ+EfhYssJzSHelD3/zOgEPRTwg=
X-Received: by 2002:a05:6000:4283:b0:429:cfa3:5fde with SMTP id ffacd0b85a97d-42fab2429b7mr1359341f8f.11.1765437029185;
        Wed, 10 Dec 2025 23:10:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4L1uwJSTXZV+b6GzkW3par9sGsQLwBnfHifQ7AFiF6juLBHiByFqXI4LUIgioFLg/mAG/fw==
X-Received: by 2002:a05:6000:4283:b0:429:cfa3:5fde with SMTP id ffacd0b85a97d-42fab2429b7mr1359299f8f.11.1765437028718;
        Wed, 10 Dec 2025 23:10:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-32-59.inter.net.il. [80.230.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a70379sm3956283f8f.11.2025.12.10.23.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:10:27 -0800 (PST)
Date: Thu, 11 Dec 2025 02:10:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lange Tang <lange_tang@163.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Tang Longjun <tanglongjun@kylinos.cn>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: Re: [PATCH v1 0/7] introduce virtnet_mon for monitor virtio_net
Message-ID: <20251211021008-mutt-send-email-mst@kernel.org>
References: <20251127032407.33475-1-lange_tang@163.com>
 <20251210040328-mutt-send-email-mst@kernel.org>
 <4820b08f.2d13.19b0b523dcb.Coremail.lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4820b08f.2d13.19b0b523dcb.Coremail.lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: af2bY3hy6b0t9YSL6KlGZcDWA5D2XARAOCE6pH9rtyQ_1765437029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 11, 2025 at 10:51:37AM +0800, Lange Tang wrote:
> At 2025-12-10 17:04:04, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >On Thu, Nov 27, 2025 at 11:24:00AM +0800, Longjun Tang wrote:
> >> From: Tang Longjun <tanglongjun@kylinos.cn>
> >> 
> >> hi,
> >> virtnet_mon is used to monitor the data packets of the virtio_net driver 
> >> and the related parameters of virtqueue, useful for tracking its status 
> >> and troubleshooting faults.
> >> 
> >> pls review. tks
> >> 
> >> Best regard.
> >
> >what does this achieve that direct use of tracing would not?
> 
> I apologize that my explanation of virtnet_mon was not detailed enough. 
> virtnet_mon uses kprobe and buffers to monitor virtio_net. 
> To monitor virtio_net, it is necessary to track the member parameters of the virtqueue corresponding to each data packet and output them. 
> When PPS very high, other tracing techniques, such as ebpf, may not be able to handle it, resulting in data loss because they do not have sufficiently large buffers to batch export log data.
> 
> As for the duplicate code, it is only to obtain the layout of the relevant structure, and I have not yet thought of a way to avoid duplication. I would love to hear your suggestions.

add traces as necessary in code and avoid this module completely.

> >
> >> Tang Longjun (7):
> >>   tools/virtio/virtnet_mon: create misc driver for virtnet_mon
> >>   tools/virtio/virtnet_mon: add kfifo to virtnet_mon
> >>   tools/virtio/virtnet_mon: add kprobe start_xmit
> >>   tools/virtio/virtnet_mon: add kprobe gro_receive_skb
> >>   tools/virtio/virtnet_mon: add kprobe ip_local_deliver
> >>   tools/virtio/virtnet_mon: add kprobe skb_xmit_done and skb_recv_done
> >>   tools/virtio/virtnet_mon: add README file for virtnet_moin
> >> 
> >>  tools/virtio/virtnet_mon/Makefile      |   10 +
> >>  tools/virtio/virtnet_mon/README        |   35 +
> >>  tools/virtio/virtnet_mon/virtnet_mon.c | 1048 ++++++++++++++++++++++++
> >>  3 files changed, 1093 insertions(+)
> >>  create mode 100644 tools/virtio/virtnet_mon/Makefile
> >>  create mode 100644 tools/virtio/virtnet_mon/README
> >>  create mode 100644 tools/virtio/virtnet_mon/virtnet_mon.c
> >> 
> >> -- 
> >> 2.43.0

