Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD341E9B37
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189182; cv=none; b=ir3HLILH01ibMaxh6k4wKTn9ijxTP+9DwuvWs3FzKHipqDB2Zx3D2/adDpyfQ5TATKIBtFGipwwKCvvIpcREuJEowzRgTOE0qm/LCN0qNCaBil4Pxl+FBZWQeoTsvEqkXRmxFoRXoEdqkWrcbFFD1VapKI2brF+eFkdUeSJCdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189182; c=relaxed/simple;
	bh=HLRZVI/nWRZlQ0fNkl1o80BEAq+WpNTkgdhT/Vbv+Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gvI0/j1VhQOkkuXmriFNtwvflhNg5YVaMY3caCxa0ceAqonSKx/IjCRy/8XgU8rVZeuQ//jgX0gv7toR0J580wcvlO5I/TLXXFpGxUjah6bdXGFtYCajcRz7StL2ST43/fCDhQb9brc22fmCOog/y+N93JMjSpHMYqFduGzO9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lh9pgUGD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lh9pgUGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781189180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZCBJLZgel9njZ+2Qcv8LZumt8TieX4eENcyuZdZiuU=;
	b=Lh9pgUGDfnW1yuCudDS+cu58tejH1OssQGxILtk4sTqQLeBYXzS7WdhtqU3OMMVxV3Gtpr
	7za7c1QhFZw0Tu55ZMdXkG/MLHfn6PxC1lZdv8Qo1Y5jgOwUGrMTT8UvJSMWODHFYa+lcs
	TAMPEKDk+qRsEoWcDyC9ibcPIAfkmk4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-aq_2v6tKMsOwDloq_MJo_Q-1; Thu, 11 Jun 2026 10:46:19 -0400
X-MC-Unique: aq_2v6tKMsOwDloq_MJo_Q-1
X-Mimecast-MFC-AGG-ID: aq_2v6tKMsOwDloq_MJo_Q_1781189178
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so67427985e9.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189178; x=1781793978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZCBJLZgel9njZ+2Qcv8LZumt8TieX4eENcyuZdZiuU=;
        b=hrAS1ezWh7A7vyHhfYmoDLvgnD9270fUW8Y6Fowr04arW+yGWoGB7820cCbkz6IkMO
         sHXqXf+Xl7dGyVDNhCmQVzcCeF/gmynOcmWVdJEhsCyEJHtLEroRqTeeAulRe7MF3cmh
         ACfR6ANzZzpC2xX4iAgKnHwNXZBH15SmfArDzL9MU8Brq/JYVPk7oz7NhQJ8e0lXUPHl
         np3X9qJSOD16DP0K/D6VXiirKJiSb1uuJLahbxAMKx7Jh8G7rO9EFpeRCmNXHTo+Bvte
         RgeuC5WgVzw/xVLMeXhvVtJY0/fvl/mAmvsV6Cg2Op9j/42FSCvw8WPIq31b/cjj2BRa
         0oFw==
X-Forwarded-Encrypted: i=1; AFNElJ9jcJloBFINKbigB6GCDuEnndg/WUrh37rN17bs5hbGYGM0AokhZmnJkDXrS6MrHfrHGLu8JQhXAnACSi1Hiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDun0pW9iAzl09E2/eKAefkD0ujmmujrnsUxP2U3BFbp3vr0Pp
	0NIolh75xZtOGE3NoIVfEOv7CaKjLclpdnmMP9t+3ttrsPMPG1ES9w5rBGLUf6oNVHe5KnDT5dt
	K5gtySNU/p27pX2iGShZnNpw/F0O2+vszKVzX/zPjpUK32DPFzj+MHoE/w4aCkTdLStnY
X-Gm-Gg: Acq92OG1fhKKhuJWfKBNAh8XLnhZS/bVWpNwcStVcs93yCderHSJeg5yutgVzp8R70s
	FVyN2OHXT9ze4a+8KiOKkO1n7fGJxf/DSsxqk0F2/Z3ew5s5y0CWb7ET9nc176NzDrJ7z2SJbvC
	OOAOgz4KuAMop4iQp6ts7nDmPxJBw0rNa4GK7KQD2to2qWzUvzJTTwrKHRIXv2vsXoYyvQ6d98b
	9S+FwRCgAgYRcQi1NdPJH/CstpN2dkw221JHBBXxfJ5HrPWJd49TVB4A0Vh9VYMoIQcx/ELNMRq
	GsgApc1DwarhLLX+e5Wyg4DGM2wsT4U9OrJFwT/xGegl4eIjGf/cequDHw+EcAmFgGAwqBdS+hq
	r/r2q7XnJ37LHl9G8VMJ+7/IuHrSKRVhZdDGJCG2RnJXZyx3MDUcuBA==
X-Received: by 2002:a05:600d:8443:10b0:490:6237:5200 with SMTP id 5b1f17b1804b1-490e55df76fmr32011565e9.10.1781189177931;
        Thu, 11 Jun 2026 07:46:17 -0700 (PDT)
X-Received: by 2002:a05:600d:8443:10b0:490:6237:5200 with SMTP id 5b1f17b1804b1-490e55df76fmr32011085e9.10.1781189177421;
        Thu, 11 Jun 2026 07:46:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d0475asm112317975e9.12.2026.06.11.07.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:46:16 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:46:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH 0/2] Fix lock errors in VDUSE suspend feature
Message-ID: <20260611104605-mutt-send-email-mst@kernel.org>
References: <20260611133806.198402-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611133806.198402-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WyV7UgAQCdRID7k4tYzCYeeFWfE_EwFjuTGA4wN33CI_1781189178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 03:38:04PM +0200, Eugenio Pérez wrote:
> Fix wrong ordering at taking semaphore after spinlock and convert the spinlock
> take and release into guards, so they are not lost after a return.
> 
> This series goes on top of https://lore.kernel.org/lkml/20260610083452.477759-1-eperezma@redhat.com/

does not apply there.

> ---
> It would be great if these can be squashed.
> 
> Eugenio Pérez (2):
>   vduse: fix not releasing taken semaphore in vduse_dev_queue_irq_work
>   vduse: not take the device semaphore while holding vq spinlock
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> --
> 2.54.0

