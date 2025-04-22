Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A61F8756
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358728; cv=none; b=TXoU60n8pV1dlMGQbZkj5fmYhZPWreonRUpHJI0SrTWEruG0ME6FSSMRJYSm62JejZlrUKH9Sr26aA//vrrysk76X27QZkBB6J8DffNRV2J8kW9kuqL1K9gtPrq04WEINB6R/L68TyyjExiHQt+wp9Xy1Niyi/SDSlzHdwVl2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358728; c=relaxed/simple;
	bh=3LybbdQW1iMI36n6qF6wDQCtqVvVWx7aMPmreP0uZNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lNS/F78K0LK5gX8/l7rKVCLipgUICz9MMvM2GxSytdjVr4NH4T85u00LQHizj9hEPwUosVe2yTulkoqm9MMK2WSGu3vEkWBf8Mmbc9wOeEBr7wgVlMTT+1RjauKknVe2WIefCVL3dYE2wwVa8USuHatEPlac+6ehU3/sS/iTqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+W40PZu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+W40PZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745358725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=joxllWRMo1gVbEqeWtbqHWjwqROo+sski2Q8YGooCfY=;
	b=K+W40PZuILXux7cxYSbDBAV0XkWUo47lJQmOYzVYlebmi4ffFL6N9p9/KySuw2BVUcfiQI
	BxAsy42yy42BOnba+hKjCUeEL+tMLVmD9/hRx+4eh2k1qaWltqWajxrXdaUZ1oHZUtRy5t
	Pup7G08Lu/Ufg7ntPRcgk3KZqU4ZJZY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-I5KCoFyxOqCYSM30Mm7wfQ-1; Tue, 22 Apr 2025 17:52:02 -0400
X-MC-Unique: I5KCoFyxOqCYSM30Mm7wfQ-1
X-Mimecast-MFC-AGG-ID: I5KCoFyxOqCYSM30Mm7wfQ_1745358721
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so26859815e9.2
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 14:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745358721; x=1745963521;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joxllWRMo1gVbEqeWtbqHWjwqROo+sski2Q8YGooCfY=;
        b=AbVwHF4oOiLBzml2Y0nWahP4kr3oxMDf0M1L0AX5ejwdlY5aSREnQjCYvJpPfVzRhv
         vfUBABTKV5x3HfDJgxh7MaynEs8ptu4vkF2T6QBmTLW0nejTa6CXQSdoC2kJCjuC4q/x
         Qv0FWAdQrd4VucNUp0YXRC8X3XkZUrHLIV02gGlpnYnKJ5JjuZb4xfBSdfkP5Kq7WFIQ
         JBzWtYDgS2636CGOsgm5ic45x8V7z9IrBWtooWQXhbNzuIFIWlCKxMQSwTKgI2oN4pQb
         ScXx2jV4Hp+Pwc5iz4oMyk2hsteiQLfaZm6onaAvwPCczI0EdMvpyM/hCA3xqIQKDQTD
         +M5w==
X-Gm-Message-State: AOJu0Yx9CHXcSkFGV95ij7Qi1USFNaePI3t7BGejomOmbyG9hNivIaQf
	sKycDqYBbdPSSVfSRZMBPkzrhMlnyTKUDKp3UCPJa4/Ba2S6JTZbr4XOXxT57Rio0zxDeq9jvBr
	0MJwQJaM+4JsvIMxRo06+HN3DKqWM04s6/Pk2+lgEzMAGBLOFa0xpyccQSa/XGkCk
X-Gm-Gg: ASbGncuK7+DIGRf9sizBYFqzDtpDReF6GCbtBNMGOPi/88kQaiuKu6ZvP2I+bXmuhsj
	G1vK6fPySe6Pt/etKYfoE72L1MijhawGeaQ3IHj0AWulSMfqBMnil/IRBYPPNI7X9/ln0kasQ0i
	KA6bD3btHeaVm6YQjefu5RFkp2/IM7RghLbIpabHQig3OOpKkQxLiq8UaLqwoZCiR9vOh+RcWND
	UuSA1dmRwe9sQYTLM3Pxi3DOsCK91hWwQJF+/EEIfAfWJbihxX0BKjwgt1yBnNIcPzYp5nepesM
	msY6V4QlxZxd4mS8tHCJZa+8E/AibQNehcCLVlccNQaMstGaakhKESKr9D7oAe+QoKIudg==
X-Received: by 2002:a05:600c:154d:b0:43c:f4b3:b094 with SMTP id 5b1f17b1804b1-4406ab7a726mr134798705e9.6.1745358720934;
        Tue, 22 Apr 2025 14:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTLxTsyxpVT4t0zbtQAWUyHdf9Zx7V24YbCZxhwIqhnPj4RWkalHudFTrHtJPVsV+GXVwc/g==
X-Received: by 2002:a05:600c:154d:b0:43c:f4b3:b094 with SMTP id 5b1f17b1804b1-4406ab7a726mr134798515e9.6.1745358720531;
        Tue, 22 Apr 2025 14:52:00 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d37332sm2604005e9.30.2025.04.22.14.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:52:00 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Philipp Stanner <phasta@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Arnd Bergmann <arnd@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Philipp Stanner <phasta@kernel.org>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/cirrus: Use non-hybrid PCI devres API
In-Reply-To: <20250417094009.29297-2-phasta@kernel.org>
References: <20250417094009.29297-2-phasta@kernel.org>
Date: Tue, 22 Apr 2025 23:51:58 +0200
Message-ID: <87frhzc1a9.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zCrvHH46bt2zvt1m1LtvfogPSrTaPlWE-CQXWEFw90c_1745358721
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Philipp Stanner <phasta@kernel.org> writes:

Hello Philipp,

> cirrus enables its PCI device with pcim_enable_device(). This,
> implicitly, switches the function pci_request_regions() into managed
> mode, where it becomes a devres function.
>
> The PCI subsystem wants to remove this hybrid nature from its
> interfaces. To do so, users of the aforementioned combination of
> functions must be ported to non-hybrid functions.
>
> Replace the call to sometimes-managed pci_request_regions() with one to
> the always-managed pcim_request_all_regions().
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

