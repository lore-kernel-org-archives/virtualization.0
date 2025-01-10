Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F1207A34
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497970; cv=none; b=e7Am3Qh6/AIB9FsGysWpTPFNW0HIMKpRvXQgXhfUuimTC1Owv5z6BvCnd5uKeLzrnIB3+rmSUsjFE3crsBM/Ex9XnnDtmvqzYFpQ256K1Km2D3VrfU+A+Ute0CRYjyEHye3vE7gMupWNDP8P3iW2kChedx6XYbpFJoP2qskJyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497970; c=relaxed/simple;
	bh=VGWc2r5DWkp5BEOS12CjavUaRnmM+7UV40Z0p/V+M4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i2WghnNdEHez0U1bp5CBgiUmk2kmYcIi3mm+kkA7B7cqxAtp1C8bSilxJkABFQP6lvI4jax/O7SVp6Zzrvp5zgvh6cgETRwaGjZl9eKFZ9oBBnmm1jv7GdunGbPpP8T3XzR0nsMUN7tqqRicBWJ7RmTJhvemAGPK+r9TIrPtOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlMa9pTQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlMa9pTQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736497968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNsiOXjqRdk4XnuvcNsSYTQ64OcsqQNsmoIU3zwwWOg=;
	b=BlMa9pTQUCgMe2s98jhayflYVQxyO2r0vmEDwbsQqEIVeZsLWikkBVMxXGKcGIdln6rrhV
	nMK2ZOXJHtHwunkHXbCG7FUrg5R1Y00QrfPJSBzO5HHnOtok8cVNMKI/lM8uAdoHfBmmLh
	08Tg38TQk/09sqLZNdi8fRTmyfnTLIY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-m21M93EdNwCiuNNqq1w3bQ-1; Fri, 10 Jan 2025 03:32:46 -0500
X-MC-Unique: m21M93EdNwCiuNNqq1w3bQ-1
X-Mimecast-MFC-AGG-ID: m21M93EdNwCiuNNqq1w3bQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436723bf7ffso14096405e9.3
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 00:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736497965; x=1737102765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNsiOXjqRdk4XnuvcNsSYTQ64OcsqQNsmoIU3zwwWOg=;
        b=nR3WHRa+R3GVlemiimGhhHmpX6S6yh4Wra6Bj2m6MC6RNk2c2zCN/0X4fARNEI/TiM
         qtB1GQ908nQ55ms4W0VmHhPYFzf7Qal/L7n+num2qxzG9fByx55JoDTfVdHvjxM4J6jx
         q/FcWDAxXmtVkdVNSiU/pgsI8P/NGASbUkgF3grD2lYn6Do8bUsUb3SO4ocOuVIfeJKE
         pmzCWpIG1GZyf8OA6tNc+O0kGkx9CzyC45Q9ccniRRwwsnYvQhEMKClM8hyzTgapwjH6
         v/gdBWLS3+BL3i7xhApDlmtq3KaVLm0uxPLYQggXjKpG1Cd7XshZ0mwLgguVrieKEQyW
         0jaA==
X-Forwarded-Encrypted: i=1; AJvYcCU12bU2G+eEiYHTWvZF9sISQKZP1Y+k9FlrKVWf909Tz18zj40+QzTYJSkMV83p0Fe1KgQK5g5mSHb5q6fkCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwctbvVkfjB1aLp8yFcnMFmS2cmmXpuK4JgP/jwUh8GDlEGamZa
	H7hw5PB2nOKBUxkQBTqwft7ltzhRfib9rzAfM+/N7da9/BfPfkPbSFegWV+QW8+irAdfjdgfWaw
	dC4NZBU+Z1XKeovN+8bZ8ZMPW4d+Oz7XjJnzDXbywTCw2Enwg6/aPPeBKWM3NsOk0jjlY4baA
X-Gm-Gg: ASbGnctdhZR948KXHeXvDV+YsqkyF1pN2ngNhkj4AKLvY8XTYwzCXXEtxOm5lM9ayh3
	UxYfXjc4+vl9iWBlCES5cT+soGpxeG+1ho82a3Gp5duGYbgxvixJ/rtTTyTmb4+aCgZ6/IxPLNF
	F4EM/dloX81V4yMA0DXUCMXbiQkkWmZC6BGc1yCOMT4Xc6zqruxQwdJFbg2cxbmLXY9wr55KgqW
	GFgjbmBgpdmMabS/bjFE9NSSs/wkLGuWWfbdQcxGdRzn5hDMyWE
X-Received: by 2002:a05:6000:4714:b0:386:33e3:853c with SMTP id ffacd0b85a97d-38a872fc034mr8254360f8f.12.1736497965395;
        Fri, 10 Jan 2025 00:32:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMC1XlIEOUefypcmHiBcEmLm9qBWhP+6Dt9pGprUw7p20L3Z1sA+aOZ6xBs7f0SCT1XF6q1Q==
X-Received: by 2002:a05:6000:4714:b0:386:33e3:853c with SMTP id ffacd0b85a97d-38a872fc034mr8254341f8f.12.1736497965057;
        Fri, 10 Jan 2025 00:32:45 -0800 (PST)
Received: from redhat.com ([2a06:c701:740d:3500:7f3a:4e66:9c0d:1416])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d17dsm3849954f8f.21.2025.01.10.00.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:32:44 -0800 (PST)
Date: Fri, 10 Jan 2025 03:32:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
Message-ID: <20250110033113-mutt-send-email-mst@kernel.org>
References: <20241111025538.2837-1-jasowang@redhat.com>
 <20250108063310-mutt-send-email-mst@kernel.org>
 <CACGkMEv_sMF5rmeaWchAbgyFd0a7-q+D_Gfejs7NpwcG-YD-YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv_sMF5rmeaWchAbgyFd0a7-q+D_Gfejs7NpwcG-YD-YA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jdNJXIUzgcvroTVc_vD_jZjFR72YXx0L7S85KDq0i_Q_1736497966
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 10, 2025 at 11:32:46AM +0800, Jason Wang wrote:
> On Wed, Jan 8, 2025 at 7:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> > > There's no need to sync DMA for CPU on mapping errors. So this patch
> > > skips the CPU sync in the error handling path of DMA mapping.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> >
> > So as I said, I do not get why we are optimizing error paths.
> > The commit log at least needs to be improved to document
> > the motivation.
> 
> As replied before. Does the following make more sense?
> 
> 1) dma_map_sg() did this
> 2) When the driver tries to submit more buffers than SWIOTLB allows,
> dma_map might fail, in these cases, bouncing is useless.
> 
> Thanks

About 2 - it's an error path. Is there a reason to think it's common?
About 1 - ok reasonable. You can say "while we have no data on how
common this is, it is consistent with what dma_map_sg does".

-- 
MST

