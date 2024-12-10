Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6292046B3
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853158; cv=none; b=uAtT+j6nzun+KSIAYbJT4ZVRqzKfhFjF7HJacZwDJxn75L9ZY6nUNPTN40MCw7020eQS83txHPMLXO7q7+I2h2bacD/mbjZGpUnjal9Ov0421yxRgUkasN838+r1OMRII8NzFA7MFZ9e06odqRJ/H8lCBpbpqD2X4+B6zU0wT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853158; c=relaxed/simple;
	bh=jxM8Oak5FsSIuUdETeAfc41H8506k5MRoOUV/v8nVjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=s+rrqUj96ezCvsuXJudgzHUJthnpZV0QED69LdcguDZAqM9gWUlzyRZAFFN4CuR9WssSz4T+B7StymbY/QzeQV5RZPBPeBxw/GO81WvBpgmjTqs6s4vIUcZZjO9jJV6wVvGY+eH9lCpxhp3ZtoaPJ3e1uRW/zgSdjrg1eXnHRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0tsuu78; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0tsuu78"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9A0F608BB
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yBx7ZBsGxlFE for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 17:52:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EFBE5607BA
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFBE5607BA
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a0tsuu78
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EFBE5607BA
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7wTWXny8CFCbc3FlHKUZFA0j/GNvYUzPKRP1yK4uOU=;
	b=a0tsuu78D3jUtcmMzQH6U7qRj1h91uZQUfly3LDyZKdM1QeZpiX9B8+dggcQ9wGfhEk9rg
	h7xIYtRLhtqBFy0y4TJyWbBt+YjDApn1MlE+sM9lx0J/bLMpYtUzVo2rxrE5J+QDKyCMgy
	Wx8qz7fYaTGPuv1fAI7t6o7sw6cys1A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-qDN3J6NcMsKEzDwhzRs1zQ-1; Tue, 10 Dec 2024 12:52:32 -0500
X-MC-Unique: qDN3J6NcMsKEzDwhzRs1zQ-1
X-Mimecast-MFC-AGG-ID: qDN3J6NcMsKEzDwhzRs1zQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434edbbc3a7so24515625e9.3
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 09:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853151; x=1734457951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7wTWXny8CFCbc3FlHKUZFA0j/GNvYUzPKRP1yK4uOU=;
        b=SCHa2K8BFr7rpMdf6WmRu7DGaTnpF+DEPFqGut8fznJq8nsYgOwTF6orZ/N2luc1GF
         QW8mrOTGnB41tbNU8NXCg7aEog3QVxAhz2FvxqJqH+QcLa4AklTu7+HXCqL6UvJ/QIqV
         W9OI+NUTXrokbCxPZrgNjzf0VBcYS8z3DvrrbCnnkb6ezPOayeja7TF7OEpLsKc/PxPh
         RA3k41NhbAVR5BgD4GxRgwv0YwK2DkaIWTAobnZGeTuLIkEMKAh9/8sYhFMGDYcU9M0M
         0kaqV6ajsrjHmvQDdOH/EbJidn7YdWE5BUoVfAhU/BMASjIkgMC4kW/y/gws2lRJbjrZ
         q8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVrNmo5HQ8RjGPITToK/vI6Qk5VFaYs8WCtkYgkJbgg8Wj9cUeKXQbjRbr5EpAcbnkbbpJ7F8+y6w/PiKPSLg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwO+z5N5qKqjaHNMalYmqKAWl/0D1U+LM7aPLnjkysl2+Otq7sK
	b0tjFXGon7KDL7haxVj3hWUjuprkTOSyc7bjod2U9Ypl4sijCFVpaAJNaidfeEVhMBiokGU0XSK
	HX8iIVzZCxYTuQB370JqJu9XkERVrVGMZiAKuU9HK1poC5D+EkKlWL+SyBxYoV1vQ/CrHWsBZau
	zVUjc=
X-Gm-Gg: ASbGnctjdhf2Tg8p8+H1/djgD7t9MR90a8UYI8mkKn80ZbhKyuKHE5h5Y6k8s5SuiXG
	PCz0JdBJIVwrRYs6J9XAKylq43PRDMahWRoNNo/6a7Sgra4wu6PLOAl6F6WIlr+q+Gm5CG8kx+e
	szt96fLXnMBV9zdt0eycSJpafgVSY3Af66s2VwQ5bcpLm/VQl6SJcTwmQEFFwFsNWiybrlEafU2
	mgz0Fzb8Eq7310Ssnxq/eDHRKoYcCEE81cKwKjySBysWeSHqUzVLB6+jCFq5HSRUZHgWU6LHj8N
	c7omkIO3vInhCJgqGtvN2g3+fPQReQ==
X-Received: by 2002:a05:600c:1e0c:b0:434:f3a1:b210 with SMTP id 5b1f17b1804b1-434f3a1b4f1mr73407115e9.32.1733853151446;
        Tue, 10 Dec 2024 09:52:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT6Om4hYhYhyD9qJSgoZ3Z6qXK38YTr//I5hZ9Q1woRRwaJmZu4m0F7M5ZzfAHvZP1EyN1sw==
X-Received: by 2002:a05:600c:1e0c:b0:434:f3a1:b210 with SMTP id 5b1f17b1804b1-434f3a1b4f1mr73406865e9.32.1733853150834;
        Tue, 10 Dec 2024 09:52:30 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f3c96ca2sm99608845e9.24.2024.12.10.09.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:52:30 -0800 (PST)
Date: Tue, 10 Dec 2024 18:52:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/8] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
Message-ID: <urth32zhvjesd7pjgy4rzbkbddtvxbmevfjid5vebfak2bd2ae@izvzeo5mk2s6>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241210164456.925060-2-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 66bwokeJAfV2eDYLrPpuDC1L-cpupUAKctnOnDmy3u4_1733853151
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 11, 2024 at 12:41:40AM +0800, Cindy Lu wrote:
>The vhost now uses vhost_task and workers as a child of the owner thread.
>While this aligns with containerization principles,it confuses some legacy

nit: missing space in "principles,it"

>userspace app, Therefore, we are reintroducing kthread API support.

nit: "app, therefore" or "app. Therefore"

>
>Introduce a new parameter to enable users to choose between
>kthread and task mode.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 1 +
> drivers/vhost/vhost.h | 1 +
> 2 files changed, 2 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 9ac25d08f473..eaddbd39c29b 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 	dev->byte_weight = byte_weight;
> 	dev->use_worker = use_worker;
> 	dev->msg_handler = msg_handler;
>+	dev->inherit_owner = true;
> 	init_waitqueue_head(&dev->wait);
> 	INIT_LIST_HEAD(&dev->read_list);
> 	INIT_LIST_HEAD(&dev->pending_list);
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index bb75a292d50c..c650c4506c70 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -176,6 +176,7 @@ struct vhost_dev {
> 	int byte_weight;
> 	struct xarray worker_xa;
> 	bool use_worker;
>+	bool inherit_owner;
> 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> 			   struct vhost_iotlb_msg *msg);
> };
>-- 
>2.45.0
>

