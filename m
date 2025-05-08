Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EAC221F01
	for <virtualization@lists.linux.dev>; Thu,  8 May 2025 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746701098; cv=none; b=n+VnC5XbHOcJHaz6AKuGKR+XFvW/8V1gUA6Y37wMwysWjEzeYs2umaDzZ4wiovPrvKag4yG/haEv9ExvNN4JrXuzrAeX/z1ozFbdmLSFq91FlUFUm2Cek2tdSFfgl1pYlRZhFMhwiEvO3CDZY55TYcorz1uOdsv+pd/FBZrrcus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746701098; c=relaxed/simple;
	bh=Fn/Bg797RXtejcknSS+9IWDalUH7spovGht6Hnt9Dzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfRALBXi2bW4MwmLMF/ckyNZ0JIMIv+mvYHDUP97Ax2h2jnsdvVmZ1JehMbbxOyvpSV9ledUnegAcj+eVERJ8Kl0j+YBOV5hJjXiS0eho0qUu/p6RoQVjSnWdwuOQ5Fb9Ismfx19mMdOg58MEQRlU7v0ZhusVw49bqQsfxDh8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xvjc6BH0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xvjc6BH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746701093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg0VQN380cNy38+THmalJtzeh1gOYnZWm93pCjMLjOk=;
	b=Xvjc6BH0Ysranwamgiu5GoLNm219axZo9KsY/Hxm/gkqmFutB/hbJ5fxlIpfT6nzExKJW0
	m+M2TgjXhXOMEruI3gjtTAIwyEhhE75vuOI9iQCINzKTzFcvxs6QfZTB53R8PXLDxRCAkz
	N3/WsoWyiR/w+ZzJEyQtA0oAK+SP1DE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-abAnxD3iMECaMYx5s9cJWg-1; Thu, 08 May 2025 06:44:50 -0400
X-MC-Unique: abAnxD3iMECaMYx5s9cJWg-1
X-Mimecast-MFC-AGG-ID: abAnxD3iMECaMYx5s9cJWg_1746701089
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso870955e9.3
        for <virtualization@lists.linux.dev>; Thu, 08 May 2025 03:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746701089; x=1747305889;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kg0VQN380cNy38+THmalJtzeh1gOYnZWm93pCjMLjOk=;
        b=CrQWNrSqEw38D2DLXML6K4Atn94yYIQTy9suMTG81iUDyZwqO7DOxYc+sSXx9HlAk9
         7pixVR8ki112uTBlgTbpAQ6ou22PdfuTrYRFnAWgZxJMEHGw8AN2TZSkvSdeVBKMTMTm
         hA0q9WVaGX4hja6+cn4uwGq29bo3TjltVOEgKBdW3XHJq3t1Zyo89MK/j6/e4mZAWUyF
         4M9zuqL582hJW7xH50lxP8R4CCJ1mpdgukbVfjxkl8ERjK7bLBaXgyho18/haV5Grcvm
         JrHB6rRv3IBtV0cf8IdxnQzBK8fauLLiYgqCCzVy6DHEPGLIiR/FLi0Y90m3LkCOSyT8
         nZuA==
X-Gm-Message-State: AOJu0YyVCx2xfeydaDJcUvLQDXk81CQlLwgfZuzXS9hn7Xuxy3p3UvLc
	x0aMhHUE85+6zStBKZxUgEQdctClPd3x0ZdP1fNfUDEymDxKf0NH1Yu+Ex2vC/3sJS1rEduxzLb
	/SXmnyisNOTkFGwXeaYWwoyTs5xikjLzzvhHRs4HY/j4KajM4cAbHvJiOiHgb3V65
X-Gm-Gg: ASbGnctroVee6jKTz2+yBxTxckpOxK+p6zbpuPTYU2ke4SIF/V2CEIdyGBGAG4RC4Gt
	QM5lj9M408i/IvebNRVhaLZJLv6yGpCB4yVqtdsYwXjGGls2cHWWr/kl6cSbhZcuUlQZ3mZ+kcP
	iSS+5/iLr6RjSgq1iJzkdvIvqLcihCcHUHdWvRtSsQeWLFcgDKc2kV2Mkbpoy+wsO5GjlvMc0dW
	4kBpF8Dt7TmCm5eMJFeWEodE6OJu0nsdwTIHdiIsiO08/Qv5D/BkoYG/NYHmzGjRDIopMjwopBE
	GHe+Zo4zaP1zDM1Kal/2UGxRlE3minqNCz0dpebz3C7P/8X2gfOgvj933/v7auoCAdQYvA==
X-Received: by 2002:a05:600c:5027:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-441d44c41a5mr60707275e9.8.1746701089370;
        Thu, 08 May 2025 03:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKWHQImK0mQVYX3JJhEVaBoNakORu3NGB6ausgRqlBfk0NSvqhDkPdCLTMr4AX1Nn44y4TLQ==
X-Received: by 2002:a05:600c:5027:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-441d44c41a5mr60706975e9.8.1746701089048;
        Thu, 08 May 2025 03:44:49 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d14e6d74sm23818755e9.21.2025.05.08.03.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 03:44:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Philipp Stanner <phasta@mailbox.org>, Philipp Stanner
 <phasta@kernel.org>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Arnd Bergmann <arnd@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/cirrus: Use non-hybrid PCI devres API
In-Reply-To: <6d46103afab9fc8e843e5681226f7db34a4ca57d.camel@mailbox.org>
References: <20250417094009.29297-2-phasta@kernel.org>
 <87frhzc1a9.fsf@minerva.mail-host-address-is-not-set>
 <6d46103afab9fc8e843e5681226f7db34a4ca57d.camel@mailbox.org>
Date: Thu, 08 May 2025 12:44:46 +0200
Message-ID: <87a57ns7oh.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3p7JOMtWSm3tzjRw57rSmPb4lsasSZ-eXwT34jqHpP4_1746701089
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Philipp Stanner <phasta@mailbox.org> writes:

Hello Philipp,

> On Tue, 2025-04-22 at 23:51 +0200, Javier Martinez Canillas wrote:
>> Philipp Stanner <phasta@kernel.org> writes:
>> 
>> Hello Philipp,
>> 
>> > cirrus enables its PCI device with pcim_enable_device(). This,
>> > implicitly, switches the function pci_request_regions() into
>> > managed
>> > mode, where it becomes a devres function.
>> > 
>> > The PCI subsystem wants to remove this hybrid nature from its
>> > interfaces. To do so, users of the aforementioned combination of
>> > functions must be ported to non-hybrid functions.
>> > 
>> > Replace the call to sometimes-managed pci_request_regions() with
>> > one to
>> > the always-managed pcim_request_all_regions().
>> > 
>> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>> > ---
>> 
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> 
>
> Who's in charge of applying this? Any objections with me just putting
> it into drm-misc-next?
>

Sure, go ahead.

> P.
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

