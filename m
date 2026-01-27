Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1446C2FF169
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528699; cv=none; b=GwA/R+m19HeSpBdd/tZlpfDMMcREW7FmTguUKHLSzh1GfrJb/4tgX4oHjF7N5RZUTnrZULl6lBo1Z7wXFtDhpsdYYTcNG9U0uX+AgB5/3Hp5KaOXNmuGsC7QVS2C+jfoicpIf+6dWj/7sMZEVi1ULhXpF9QVgTRvFXDd2zfSpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528699; c=relaxed/simple;
	bh=sLmzmH4e/VfXRHODrx8No2fcI0r5Vx/h67NeYOL4N9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lCBuKaltim40aaePfv2Fw26wM1PtycZAP3maoxafKFZBNGdjYQGtcG/MAsoQOMrWnCiVFqzYuiyF9Bg+5dHa5t3/2hQTYNxoR3fqxslI9XxPfzCJPDbpldTPPfoo9ZZkpNjt4+/DO1O3K/40MDV+6PoFiSivhEg4bFGs3WBOVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnDgQ0sS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnDgQ0sS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769528696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uSgfBKSWshfFn7p2hhbUKCj8+h/hZZzyQsPoCFT+MfQ=;
	b=gnDgQ0sS5/6x1LqpHrAxvWUSfLKBmeayzwFpQOn/rN3TbrzLNEisLe66Ut+xY/IUZIe1iM
	XeXLl/PbqgzO974tpq3hLmezmFqnbiRuH+A+SMMh1ezL6OOWvXU5TqctC8Rl2XDpC7SWW2
	yZv+cSYqNWTgcZKWqqDRa4wH6O94yEI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Xk0DswYcMViLMC2f3cbvlw-1; Tue, 27 Jan 2026 10:44:55 -0500
X-MC-Unique: Xk0DswYcMViLMC2f3cbvlw-1
X-Mimecast-MFC-AGG-ID: Xk0DswYcMViLMC2f3cbvlw_1769528695
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4359d70faa2so3803117f8f.1
        for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 07:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769528694; x=1770133494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSgfBKSWshfFn7p2hhbUKCj8+h/hZZzyQsPoCFT+MfQ=;
        b=MfY/JCbSJrNbMy593ksZarem7Yt787/BIyhjQ1pJxklMWQXuXT9aclGngrP+uVLBqx
         +s4j6EjcKdYnJtShP1RyVUw1wxpa8dm0v1w+ArE4ECROuW/ccabMCHhJ/ZDUNp4JjwC/
         RCWR8chuWYj1LoIl2i7KGlzkQv1A/KaBUQdYfpErIu5RJH4IP/ts7xmiWWJnk82iMC0H
         H6wCsMinPb0fKaie/XF9BjQ7Pby/+67XDkQh0SYk0pboFHSGxKuNPxGMQ8+L2jS9I97O
         9w18vwV5JW5Fht51TIFg1fYZcP0iltPkdtcuSQzhwT6T3T9gp1GteTmaHxtvN7IEPBIr
         R3nw==
X-Gm-Message-State: AOJu0Yzmm+C8hy0OVS1AW0jKqGb0aBALo/3TSnBU8d6sjXAOV5ALbil2
	wzlxr9P49vd2o/P5Tmj8n96duccORSAT3qhjYpRYKiztr9B9r0Kf0/glrM+/aDqnyVdKOGspu3W
	/e6g7ZQwGJOOmrZDkFNjJBLBUYRhqIeFCJpXLm+cHf6IDBOVt3NqA99dVJvR3jAs5tSY2
X-Gm-Gg: AZuq6aKCcm/VJ65fDChe1n1NwXM7/PAxvF8mPgFFci5CTUTVeImzj/M6nRmzmoA+JIb
	mHwmPm0W9PfURB3BAe/NojICjw4jM+CLRuNsqHA6cbwY62QIITZgqaEWLecsMIs7ixl2tSMKFM+
	yu9vzY0W8L+T6W3QEMplrhzeG6yCK4ojXEKSXiuwBqTUpJBBBundMdsn8NPWA+e2VVZgIWEBC1q
	XentUzPBFhNZXZYsrz8PwWDHVGOCV62uZKhVG3wYt7FpKvcbgEBcPhjJixHzlfmeymDciyn5pvp
	dJy5dfSvWPL5HJxP4lEH44W2G/9Xpzv+V66ab+GWjLjfTt/UHa/qib9aTdAXZp+FUErvt2O3lot
	G5Onc4B0bHJ7+wXXmjoO/0J9VyZ8bpOD3uQ==
X-Received: by 2002:a05:6000:1ac6:b0:435:99d5:9d8f with SMTP id ffacd0b85a97d-435dd06f1aemr2964835f8f.19.1769528694451;
        Tue, 27 Jan 2026 07:44:54 -0800 (PST)
X-Received: by 2002:a05:6000:1ac6:b0:435:99d5:9d8f with SMTP id ffacd0b85a97d-435dd06f1aemr2964801f8f.19.1769528694023;
        Tue, 27 Jan 2026 07:44:54 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7474csm39912950f8f.37.2026.01.27.07.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:44:53 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] virtio: silence KCSAN warnings
Message-ID: <20260127103716-mutt-send-email-mst@kernel.org>
References: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YZvQupJxGPiYjxHwfr2fYgViiI_JT5GacMVQuNey5Bc_1769528695
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 27, 2026 at 04:25:21PM +0100, Johannes Thumshirn wrote:
> When booting a Qemu VM whith KCSAN to debug filesystem races I
> encountered a bunch of KCSAN splats in virtio.
> 
> All of them are false positives, as the racy unknown origin is the
> hypervisor.
> 
> Alex suggested to annotate the vring structure as racy for KCSAN, but
> the __data_racy annotation turns into "volatile" and as such it cannot
> be used to annotate the whole structure. Annotating every structure
> embedding a pointer to the vring turned out to be way more invasive than
> annotating only the few sites consumers.

Oh wow and I learned Linux has

# define auto __auto_type

which then allows auto in G11:

#define data_race(expr)                                                 \
({                                                                      \
        __kcsan_disable_current();                                      \
        auto __v = (expr);                                              \
        __kcsan_enable_current();                                       \
        __v;                                                            \
})




> Changes to v1:
> - Annotate the return of more_used_split() as racy so both call sites
>   are covered
> - Annotate vring_avail_event() as racy so we can condense two patches
>   into one.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I will pick this up.

> Link to v1:
> https://lore.kernel.org/virtualization/20260127083926.865555-1-johannes.thumshirn@wdc.com/
> 
> Johannes Thumshirn (2):
>   virtio: silence KCSAN warning in virtqueue_get_buf_ctx_split
>   virtio: silence KCSAN warning in virtqueue_kick_prepare
> 
>  drivers/virtio/virtio_ring.c     | 4 ++--
>  include/uapi/linux/virtio_ring.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.52.0

