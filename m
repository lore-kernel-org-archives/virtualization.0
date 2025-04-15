Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948076410
	for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725660; cv=none; b=TngzJlK3UXh54GuAyjYtSG+7uCp9wc4Bdk7hu0DDU5bgMdHCeiSD72MLRxxW4C46DsdvyivkW+5j7ijabpSEUMYBuf0L4tm5TB8LDoQWLw52zOz1xx6tou4mv8mkOMeHoBYcFUyW7ZqLvUXuXLCPA8ZfhaLsGZhXFJvvzTcJsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725660; c=relaxed/simple;
	bh=709X1rled5cZvOSoP5Fmp+UUPKulHgYpV7XIeh4A7YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CBYAggrNHdpdNKligTlmJBdZYviPtFVc7PJRbgoMQFKfQs1lFuzgBjYavtZ9XkcLbBv2247JW34yZ45uJ9Vr82TSUCGcLI7dvDLdZFrvJv7oErusvJHO5HtmtqDAm4AXstgNguezsx87qcZb5FScHDi5iJVg9fRAtlUfWJtOC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWejkYLq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWejkYLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744725657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igmdI0kSDqZsvsPzw7Io9AH+cSfi52O12B3FfuJtqjg=;
	b=hWejkYLqLLn2zvtn6c+C6MuObCu8mngQL5uEbTaDwE05lui3bZEcsdEqc0fUZiQj0vTN5X
	qht6iq2uKzU9m4Il06RKgqe2oKTG7vsxZ3UX3FhO7XNCOSRVtHgD56yCoxNo58e7z6dgHk
	dciVaPYkBQZpcnQtie0vQY1qztn7kC8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-KV8qkwMpMsWcuBtpoGvZVA-1; Tue, 15 Apr 2025 10:00:56 -0400
X-MC-Unique: KV8qkwMpMsWcuBtpoGvZVA-1
X-Mimecast-MFC-AGG-ID: KV8qkwMpMsWcuBtpoGvZVA_1744725655
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso43672245e9.0
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 07:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744725655; x=1745330455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igmdI0kSDqZsvsPzw7Io9AH+cSfi52O12B3FfuJtqjg=;
        b=P3xzwn4ky5+k9YfR0h99NHyiezaIaPiqBsj19ZYFZH8jn6IKyA62rcOhtek+mHBBJ7
         av/82S+n2egL6X2TlC2ImSo0/U8b62Y7aHVwgUJksuoG9pk71GBWHfbxBwoUhTySYwCO
         OUROYdNnayT14TaUbKHcr7C63wGKjcbmWiPlgc+Uak3dYPTzw/XFddr8dwYpCyKIHXjc
         3H1KB98J7Acsk/VT5rlkLRFyLcyCDR2lFq/guZDjd2hmYetZPx38O0iGL4vFjWBC0NOE
         ujOLVofmWTKgxrGIKngTHWTezryWyDc8UpuxElqXwLNauE9lQjDiE+IP4U0Io7eD2xzq
         8n1A==
X-Forwarded-Encrypted: i=1; AJvYcCVaXNuP/e+UrNnZrplCulEfFAL5982qGIE1e/Cty9bFa9GVuHnHAmQunTAHT6T5F+knUDx8vkWpM6JfBP3zDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLE3DJrPI7e1H65WB/wEFhmfBMXtaTxwTDIKb9XX24nWooL1u4
	4Uhh8DnuKsAdfK3q/YO4SwlnHCxfb7y5NnKzCNIgGMZxaj7rgTusv5boQ875vY2462zxIZFSzlT
	kf+XqUF0orvPoyW7Y/SpMWQ95/yUn9wXPIJdK1zNoxSiI9Sd37YDGWnAzGuryJTq4
X-Gm-Gg: ASbGncufbuO+Bo9li32GeTxCw6maEzIhkgUVgK34dO8UmC+TfMK2RgJ/Tl5IJJL6qmq
	4/pMbKbs3t+RS5eULSe5o0EBbhhMoc7F27Q4UYiLHNsS1a2Y/e/rxrK8oCn7NXGv1W+ZmK68G5T
	jQBvgqTBQLWh/7nu3reznU5nsSynEluRI69aC+GFUaBFMY0vADshavA2Y8SIqakk3/kt2CLWSH6
	L6w/Z8LZttRvzFqLaTtcMii/GwIjHr8bmhaHiKEoo7kQHhR2FOBJRl3ztU+YmN1x+MRQIMgbl/o
	jk3KIQ==
X-Received: by 2002:a05:6000:2911:b0:391:1652:f0bf with SMTP id ffacd0b85a97d-39eaaea8c84mr12562741f8f.33.1744725654618;
        Tue, 15 Apr 2025 07:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv6jlDturxPui6Vb2bbzQw+TvvK2bK5gTukcWi0U1ZLkB+XYbqUougrxO8tQDqdyASZrd5Fw==
X-Received: by 2002:a05:6000:2911:b0:391:1652:f0bf with SMTP id ffacd0b85a97d-39eaaea8c84mr12562649f8f.33.1744725653855;
        Tue, 15 Apr 2025 07:00:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c8219sm207637185e9.21.2025.04.15.07.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 07:00:52 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:00:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
	Eric Auger <eauger@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2] virtgpu: don't reset on shutdown
Message-ID: <20250415095922-mutt-send-email-mst@kernel.org>
References: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
 <ge6675q3ahypfncrwbiodtcjnoftuza6ele5fhre3jmdeifsez@yy53fbwoulgo>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ge6675q3ahypfncrwbiodtcjnoftuza6ele5fhre3jmdeifsez@yy53fbwoulgo>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0m5KJp0kpBfmOAkYnsqVEetil3AJfQ01f6HD_1rR3K4_1744725655
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2025 at 01:16:32PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > +static void virtio_gpu_shutdown(struct virtio_device *vdev)
> > +{
> > +	/*
> > +	 * drm does its own synchronization on shutdown.
> > +	 * Do nothing here, opt out of device reset.
> > +	 */
> 
> I think a call to 'drm_dev_unplug()' is what you need here.
> 
> take care,
>   Gerd

My patch reverts the behaviour back to what it was, so pls go
ahead and send a patch on top? I won't be able to explain
what it does and why it's needed.


-- 
MST

