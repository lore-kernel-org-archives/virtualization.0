Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2864964F
	for <virtualization@lists.linux.dev>; Tue, 10 Dec 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817744; cv=none; b=WScNid4OkFXOL7Qpl2tJGbE6zvZQfzkKHdfHi3ZgY3nDHjYeDD4kxrjrod6Hye4h0W/hfSTc7Z72UlSJqDYtYx8eDuPZDszrUa36/rAsi3XOALX2JtCbajinE4qMXCBer1peGirK3q8YCgWW+d2EH6Vvr9hrVdm0aMjqIyacsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817744; c=relaxed/simple;
	bh=SMAjA3L/4WYwyx0pAW/Iv4MwRYBgg0ahnkvULcykFrc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OkboYh3W+E+x+YQ5m23xpciYXj/Ej8e7ipU5y2KnN7Vi5gFVExMfmY/VgQDiwrYle509ksh5epenbWJCYhV3GmyWkpZhn5fSnRWeNEUu2SRwRNAVLjBY4qZqwAu4jHhNEPETEoFfvlG8DxjW1HRKyy1+ZLKplU7KBTZ5BoE1E84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fnCFZFmM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnCFZFmM"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso57092745e9.2
        for <virtualization@lists.linux.dev>; Tue, 10 Dec 2024 00:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733817740; x=1734422540; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMNvaQhF85IRdaxsabk7cfCz+/okcwJXbBF4MVtbU6c=;
        b=fnCFZFmMemFGuoVAZywrhC0HjwGkriOZ/kuEbQKbNwcvf97jMYfcyJohy3WGnXNvo0
         oQmwqLCEG8PYKQfTLKfFySr6lbXhoEmIua+nBEASK1swMWdPyJyhSytz3COrY5/BE9HD
         ZFtiIx0ew+0rudku6KXKEhtS7QACvsoDZV7iqSynAiWhXAbeu2cRMq7+qNWs2q/0Ww9t
         AFo5ofY9S8pMPPp8eQysVLRD/4Q2tCrq9PE0311Ps51rLlzJWsmMBxXM7c3H33esmb64
         9yWhWUSXVVJhlkn5sshgvK80BXibR1jpupiruvFIM/XxT0sfkA5eDgbj3M2fXH/VS9zk
         UDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733817740; x=1734422540;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMNvaQhF85IRdaxsabk7cfCz+/okcwJXbBF4MVtbU6c=;
        b=AnjzhSIHrfTeiR4TGcc9zhF9fs+UPpnXdwLYazixkYnEdr4gq4NLWGPBagIRIjHJcl
         wK4i1jW2SBlsBPhJYa6WDnYotn4TdQKstEyvV99oeOEHlSJtfV8qMIp/YQ6gpp/vcC+x
         vxDENszcOhXAuxQnLJIS9JFrzsgjUW+f3Y4xdt2b44muDs5XXMQc1YwwPYRgxNBpsuLx
         sQtxGrQNjeIznmyoYszOjPjZrjqW1kWs0CARsRHTQYcI1n8bOgzwM84Gsd9eArf6Xp7H
         JGToh7dmbW/prh7KeZje14rXkRhlQNcTlS2NeW0rHEqKjcMWo+z95vp5uB62CK2BxIQm
         H5PA==
X-Gm-Message-State: AOJu0YynXxkSH8p4EdIJbqdNP7W/92jMD3o6SBOk5rSiKQeV69c+YW78
	EKLFsZQvWP9Mi+pTjbQ58ETDhEBWdFYkI/G7u8hpPFE0gwidNaM8p1xQS82hheo=
X-Gm-Gg: ASbGncsoqsq3ICZ3wUUR92Zd7Z5PZvReZ7ric64nY9qoGZ3SmxpUKjBvlRHaEuYEkz8
	TKBSWEPUw6yK//Rh3qOqcLXm30li6jH/yxEIqI1dypGJLKiyGSaPF4p70oeJVf4iUSw7Gz6eU2b
	p7FuuXjUfcMNv6FxTHRZHTyVByVngDDrt4DeSCgJvCZ7YyLBS+fjmWskHKtlBUR5l33FV1QNqqQ
	WOzZGuIyiMeRy5hxrTbgaNTb1juZT+V48r7QhZSoymT359f5qOutqnEOMU=
X-Google-Smtp-Source: AGHT+IHoJCGnZcpH364kY34DuQ9eVyRcQssFYqY5hZKtaQcLF9VHClBx0fV9kETu+7nQMARDsCinBw==
X-Received: by 2002:a05:6000:400c:b0:386:3560:477f with SMTP id ffacd0b85a97d-386356049e3mr8059990f8f.23.1733817740474;
        Tue, 10 Dec 2024 00:02:20 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190975fsm15065581f8f.68.2024.12.10.00.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:02:20 -0800 (PST)
Date: Tue, 10 Dec 2024 11:02:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: virtualization@lists.linux.dev
Subject: [bug report] drm/virtio: Import prime buffers from other devices as
 guest blobs
Message-ID: <886902b7-d573-4c0a-8b3d-43f37b8f385f@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Vivek Kasireddy,

This is a semi-automatic email about new static checker warnings.

Commit ca77f27a2665 ("drm/virtio: Import prime buffers from other
devices as guest blobs") from Nov 25, 2024, leads to the following
Smatch complaint:

    drivers/gpu/drm/virtio/virtgpu_prime.c:194 virtgpu_dma_buf_free_obj()
    warn: variable dereferenced before check 'attach' (see line 192)

drivers/gpu/drm/virtio/virtgpu_prime.c
   191		struct dma_buf_attachment *attach = obj->import_attach;
   192		struct dma_resv *resv = attach->dmabuf->resv;
                                        ^^^^^^^^^^^^^^^
The patch adds an unchecked dereference

   193	
   194		if (attach) {
                    ^^^^^^
The older code assumes attach can be NULL

   195			dma_resv_lock(resv, NULL);
   196	

regards,
dan carpenter
