Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB234F24C
	for <virtualization@lists.linux.dev>; Sun,  6 Sep 2026 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720991; cv=none; b=QXj43kAGgMEj6T5HiZdhGNr540hQPcN/4X7z15M+0T89okW+CGmKfd3xVxVg6XjU79fzL9eYwGkdNtgTi8J3WkWQ7eC43cL3NqGyx922uHyok1zQcPKth5zedEDpyXecDPZ6Zx4iEr9UXPooUgN7aInSZMf2p23xMSxxChRAGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720991; c=relaxed/simple;
	bh=6a+HZ1EYXYHu9PlV9ZIMitFPuM02tFoBs0QnqvSqpU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tiUQZomR0p+4WPHo9dxpzhjk1MF1Pzgdm26kN+bv+2UIQKAgfm3n+r0Myrj8PnkmEWM7MpDz3cTFXFfqMb+x4OWnccSzi3Dw70kgKvPyddYhagCwGrN9awuZfF2EzPoUhdH+0LNYarsxQiS74Gv4ulBagkvCRIISXGOJJvHqsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTs0Dq6I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTs0Dq6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788720988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UoPs+GJMD19+2K8VaVNyBFab1idZZJbQk2Q9rWXgiCY=;
	b=NTs0Dq6ID7Utpl8vuq/dAPjs+dNnBvQiCCVqu4/+kh6I37jUoOBjwPz+gARVGZT7DEbGMY
	SeNCqj1pqObM7Q1xUl1k9ljmeR2btIP7aYpQL8y6KywPZyAPTubAiu68zYQ1JztrFXM6IV
	QJm4fZkYeTTB0rh3JWFtUOt617gmMBY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-xAF3YjJdPpKMq20QDFdoiw-1; Sun, 06 Sep 2026 14:56:27 -0400
X-MC-Unique: xAF3YjJdPpKMq20QDFdoiw-1
X-Mimecast-MFC-AGG-ID: xAF3YjJdPpKMq20QDFdoiw_1788720986
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49d0ae342b9so4215375e9.1
        for <virtualization@lists.linux.dev>; Sun, 06 Sep 2026 11:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788720986; x=1789325786;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoPs+GJMD19+2K8VaVNyBFab1idZZJbQk2Q9rWXgiCY=;
        b=ifgI42uMV8kfGARn9DWYgLK7E7v6vPler+yJRWVfZ7p51gdSobm25Y11MD4dl5c3CI
         DWVDjgV6VvaoHNZApBPpMg1RNnFzI/uBuStuC29deAgs1pQJll+7A1E3wyslhvAyIqxu
         BWiGQ2Tro2FlKM2uvwZPYNl9WMrfkNfOqB41V5AfIcFLI1kl28DowR4LV3mV6vktY2S8
         SH9It28ySMepalATvytBaH+wnjgk1fRp/JyckK7rG4/pmBPwKL3YCarUS4Y+zJPDvyA6
         lxCaw9ioMEwvf7xghskcyLZkGQpUEjFe2hBAByMyBzgzcY6/7x0ZopO1tI2nMSeJQwx1
         mZwA==
X-Forwarded-Encrypted: i=1; AKwUvBxjxuDaQlwWL8lXzHe1Oy4Vdlin2ZRDYMKHNPNfWGoH8mVHEg7Rr0cRmFSiNWwyFVZovzNkpaajahGUiG0CnA==@lists.linux.dev
X-Gm-Message-State: AFuF++n0amhTCUTnJ1tghmS51PDUfPyiJEliJirI2ffQJ52hLqAhkEBA
	U1z7TzbB1QRUtFjwdFn70P+vc2bgSL0d4fOIBSxDzNUfR4BwiaHonvA0MCsix5z89CGMHXwrmJ/
	L9FJ7utRQo7NYTc4xx7DFS0L1nNVb6jqdmde8nF1TaPqkqehliL1P/AlX8L4SZTf+Lcwi
X-Gm-Gg: AYBFou3T8kAj6Ho4hTbG6eeUNi4Ux+K14dm3LvdCmZGaev6j8USmMvInXhDQhWl8mww
	GlOybK/JPy7iQR/vprKSrX1nORBpBaa9S+AguIkv1uaqNDxRqW1o/adwaHlkGrR0KZWFRhGWu+Q
	XWyy2h4F1fFMeSWVeOIUv87UmaHmfvAk1aIAHxzcQ+hdrv3fBaPy/bl2Io77ZXWSTKYw0PGUitk
	LDEOjficvziHHsf/HxKXQB8Yy3N2VTWfUr5h8eg0g39mkT3JWSRWA2mcDbib3Wz/zPvJc70zwVS
	QYoGBp5AQIit1ybd0uy2R6nqQft722CHpxKAx+ndhgkv9O3RgQJdlC+xTGrol5QPpQ7ZFPErjFR
	6RVfzIPJMcYPUBVHdl3u/V0E=
X-Received: by 2002:a05:600c:8b29:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cf824743cmr196985185e9.9.1788720985755;
        Sun, 06 Sep 2026 11:56:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8b29:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cf824743cmr196984675e9.9.1788720985146;
        Sun, 06 Sep 2026 11:56:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d084d62b0sm80311485e9.2.2026.09.06.11.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:56:24 -0700 (PDT)
Date: Sun, 6 Sep 2026 14:56:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260906145605-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260906025249-mutt-send-email-mst@kernel.org>
 <ap2VJkoIsBbsqcNm@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ap2VJkoIsBbsqcNm@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Adp4z5sGiGx_YRYi4Y9YbActNvLCFnnyyW1Asp-AaP4_1788720986
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 06, 2026 at 06:32:40PM +0200, Karl Mehltretter wrote:
> On Sun, Sep 06, 2026 at 02:53:05AM +0100, Michael S. Tsirkin wrote:
> > You didn't send patch 3.
> > 
> 
> I resent it to just you now. Mail must have gotton lost somewhere.

got it now, thanks!

> If all else fails, it's on lore:
> https://lore.kernel.org/r/20260905152059.89560-4-kmehltretter@gmail.com/
> 
> Thanks,
> Karl

